section .text

global _start

extern parse_input
extern doAsmCalculations
extern output_result

_start:
	mov ebp, esp

	sub esp, 16 ; allocate space for a,b
	; esi - pointer to a:
	mov esi, esp ; 
	; edi - pointer to b:
	mov edi, esp
	add edi, 8

	push edi ; pointer to b
	push esi ; pointer to a
	; argv
	push DWORD ebp
	add DWORD [esp], 4
	; argc
	push DWORD [ebp]
	call parse_input

	sub esp, 8 ; allocate res
	push esp ; pointer to res
	push DWORD [edi + 4] ; b - 4 higher bytes
	push DWORD [edi] ; b - 4 lower bytes
	push DWORD [esi + 4] ; a - 4 higher bytes
	push DWORD [esi] ; a - 4 lower bytes
	call doAsmCalculations

	add esp, 20 ; skip args - a,b,res pointer, to get to res
	push eax ; status
	push DWORD [edi + 4] ; b - 4 higher bytes
	push DWORD [edi] ; b - 4 lower bytes
	push DWORD [esi + 4] ; a - 4 higher bytes
	push DWORD [esi] ; a - 4 lower bytes
	call output_result

	mov eax, 1	; exit(
	mov ebx, 0	;   0,
	sysenter	; );
