section .text

global _start

extern parse_input
extern doAsmCalculations
extern output_result

_start:
	mov ebp, esp

	sub esp, 12 ; allocate space for a,b,c
	; esi - pointer to a:
	mov esi, esp ; 
	; edi - pointer to b:
	mov edi, esp
	add edi, 4
	; ebx - pointer to c:
	mov ebx, esp
	add ebx, 8

	push ebx; pointer to c
	push edi ; pointer to b
	push esi ; pointer to a
	; argv
	push DWORD ebp
	add DWORD [esp], 4
	; argc
	push DWORD [ebp]
	call parse_input

	sub esp, 4 ; allocate res
	push esp ; pointer to res
	push DWORD [ebx] ; c
	push DWORD [edi] ; b
	push DWORD [esi] ; a
	call doAsmCalculations

	add esp, 16 ; skip args - a,b,c,res pointer, to get to res_arg
	push eax ; status
	push DWORD [ebx] ; c
	push DWORD [edi] ; b
	push DWORD [esi] ; a
	call output_result

	mov eax, 1	; exit(
	mov ebx, 0	;   0,
	sysenter	; );
	
