section .text

global doAsmCalculations

; int doAsmCalculations(int count, int* arr, int* res_arg)
doAsmCalculations:
	push ebp
	mov ebp, esp

	push esi
	push edi
	push ebx

	mov ecx, [ebp + 8] ; count
	mov esi, [ebp + 12] ; arr
	mov edi, [ebp + 16] ; res_arg

	; eax = positive sum, ebx = negative sum
	mov eax, 0
	mov ebx, 0
	loop_sum:
		cmp DWORD [esi], 0
		jg positive_sum
		jl negative_sum
		je loop_end

		positive_sum:
			add eax, [esi]
			jo add_overflow
			jmp loop_end

		negative_sum:
			add ebx, [esi]
			jo add_overflow
			jmp loop_end

		loop_end:
			add esi, 4
	loop loop_sum

	sub eax, ebx ; positive sum - negative sum
	jo sub_overflow
	mov [edi], eax ; res
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
