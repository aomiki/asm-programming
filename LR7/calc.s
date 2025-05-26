%define x_arg ebp + 8 ; skip old ebp,function address
%define res_arg ebp + 16

section .data

const_two dq 2.0

section .text

global doAsmCalculations

; tan^3( ln( cot(2x+pi/2) ) )
; int doAsmCalculations(double x, double* res_arg)
doAsmCalculations:
	push ebp
	mov ebp, esp

	push esi
	push edi
	push ebx

	mov edi, [res_arg] ; pointer to res

	; load values to compute from to FPU
	fldl2e
	fld QWORD [const_two]
	fld QWORD [x_arg]
	; st0 = x
	; st1 = 2.0
	; st2 = log_2(e)

	fmul st0, st1
	; st0 = x * 2.0
	; st1 = 2.0
	; st2 = log_2(e)

	fldpi
	; st0 = pi
	; st1 = x * 2.0
	; st2 = 2.0
	; st3 = log_2(e)

	fdivrp st2, st0
	; st0 = x * 2.0
	; st1 = pi / 2.0
	; st2 = log_2(e)

	faddp
	; st0 = (pi / 2.0) + (x * 2.0)
	; st1 = log_2(e)

	fptan
	; st0 = 1
	; st1 = tan( (pi / 2.0) + (x * 2.0) )
	; st2 = log_2(e)

	; check if outside fptan range +-2^63
	fstsw ax
	sahf
	jp fptan_overflow; C2=PF=1

	fdivr st1, st0
	; st0 = 1
	; st1 = cot( (pi / 2.0) + (x * 2.0) )
	; st2 = log_2(e)

	fdivrp st2, st0
	; st0 = cot( (pi / 2.0) + (x * 2.0) )
	; st1 = log_2(e)^-1

	; check if log argument is negative or zero
	fldz
	; st0 = 0
	; st1 = cot( (pi / 2.0) + (x * 2.0) )
	; st2 = log_2(e)^-1
	fcomip st0, st1 ; 0 ? log_arg
	je log_arg_zero ; 0 = log_arg
	ja log_arg_neg ; 0 > log_arg

	fyl2x
	; st0 = log_2(e)^-1 * log_2( cot( (pi / 2.0) + (x * 2.0) ) ) =
	; = ln( cot( (pi / 2.0) + (x * 2.0) ) )

	fptan
	; st0 = 1
	; st1 = tan( ln( cot( (pi / 2.0) + (x * 2.0) ) ) )

	; check if outside fptan range +-2^63
	fstsw ax
	sahf
	jp fptan_overflow; C2=PF=1

	fstp st0
	fld st0
	; st0 = st1 = tan( ln( cot( (pi / 2.0) + (x * 2.0) ) ) )

	fmul st0, st0
	fmulp
	; st0 = tan^3( ln( cot( (pi / 2.0) + (x * 2.0) ) ) )

	fstp QWORD [edi] ; store to res
	mov eax, 0
	jmp func_ret

	fptan_overflow:
		mov eax, 1 ; FPTAN OVERFLOW status code
		jmp func_ret

	log_arg_zero:
		mov eax, 2 ; LOG ARG ZERO status code
		jmp func_ret

	log_arg_neg:
		mov eax, 3 ; LOG ARG NEG status code
		jmp func_ret

	mul_overflow:
		mov eax, 4 ; DIV OVERFLOW status code
		jmp func_ret

	div_by_zero:
		mov eax, 5 ; DIV BY ZERO status code
		jmp func_ret

	func_ret_undefined:
		mov eax, 6
		jmp func_ret

	func_ret:
		mov esi, [ebp-4]
		mov edi, [ebp-8]
		mov ebx, [ebp-12]

		leave
		ret
