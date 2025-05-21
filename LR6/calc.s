%define a_arg ebp + 8 ; skip old ebp,function address
%define b_arg ebp + 16
%define res_arg ebp + 24

section .data

const_four dq 4.0
const_five dq 5.0
const_neg_fifteen dq -15.0
const_twenty dq 20.0

section .text

global doAsmCalculations

; int doAsmCalculations(double a, double b, double* res_arg)
doAsmCalculations:
	push ebp
	mov ebp, esp

	push esi
	push edi
	push ebx

	mov edi, [res_arg] ; pointer to res

	; load function arguments to FPU
	fld QWORD [a_arg]
	fld QWORD [b_arg]

	; system of equations - conditions
	fcomi st0, st1 ; b ? a
	je syseq_case_equal ; a = b
	ja syseq_case_less ; a < b
	; a > b:
	fld QWORD [const_four]
	fcomip st0, st1 ; 4 ? b
	ja syseq_case_greater ; b < 4
	jmp func_ret_undefined

	; -15b
	syseq_case_equal:
		fld QWORD [const_neg_fifteen]
		fmulp

		fst QWORD [edi] ; store to res
		mov eax, 0
		jmp func_ret

	; (ab-20)/b
	syseq_case_less:
		fmul st1, st0 ; ab
		fld QWORD [const_twenty]
		fsubp st2, st0 ; ab-20

		fldz
		fcomip st1 ; b == 0
		je div_by_zero

		fdivp ; (ab-20)/b

		fst QWORD [edi] ; store to res
		mov eax, 0
		jmp func_ret

	;b^2 + 5
	syseq_case_greater:
		fmul st0, st0
		fld QWORD [const_five]
		faddp

		fst QWORD [edi] ; store to res
		mov eax, 0
		jmp func_ret

	add_overflow:
		mov eax, 1 ; ADD OVERFLOW status code
		jmp func_ret

	sub_overflow:
		mov eax, 2 ; SUB OVERFLOW status code
		jmp func_ret

	div_overflow:
		mov eax, 3 ; DIV OVERFLOW status code
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
