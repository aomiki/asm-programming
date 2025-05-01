section .text

global main

extern parse_input
extern doAsmCalculations
extern output_result

main:
	push ebp
	mov ebp, esp
	push edi
	push esi
	push ebx

	sub esp, 8 ; allocate space for a,b
	mov esi, esp ; pointer to a
	mov edi, esp
	add edi, 4 ; pointer to b

	push edi ; pass pointer to arr_out
	push esi ; pass pointer to count_out
	push DWORD [ebp + 12] ; argv
	push DWORD [ebp + 8] ; argc
	call parse_input

	sub esp, 4 ; res
	push esp ; pointer to res
	push DWORD [edi] ; arr
	push DWORD [esi] ; count
	call doAsmCalculations

	add esp, 12 ; skip args - a,b,res pointer, to get to res_arg
	push eax ; status 
	push DWORD [edi] ; arr
	push DWORD [esi] ; count
	call output_result

	mov edi, [ebp-4]
	mov esi, [ebp-8]
	mov ebx, [ebp-12]

	leave
	ret
