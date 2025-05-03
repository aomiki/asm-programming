%define a_arg ebp + 8
%define b_arg ebp + 12
%define c_arg ebp + 16
%define res_arg ebp + 20

section .data

const_two dd 2.0
const_seven dd 7.0
const_twelve dd 12.0

section .text
global doAsmCalculations

; int doAsmCalculations(float a, float b, float c, float* res_arg)
doAsmCalculations:
	push ebp
	mov ebp, esp

	push esi
	push edi
	push ebx

	mov edi, [res_arg] ; res_arg

	; [edi] = (2*b +7c)/(а/2 - 12c);

	; 2b
	fld DWORD [const_two]
	fld DWORD [b_arg]
	fmulp

	; 7c
	fld DWORD [const_seven]
	fld DWORD [c_arg]
	fmulp

	; 2b + 7c
	faddp

	; a/2
	fld DWORD [a_arg]
	fld DWORD [const_two]
	fdivp

	; 12c
	fld DWORD [const_twelve]
	fld DWORD [c_arg]
	fmulp

	; a/2 - 12c
	fsubp

	; [edi] = (2*b +7c)/(а/2 - 12c);
	fdivp

	fst DWORD [edi] ; res
	mov eax, 0 ; status
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
