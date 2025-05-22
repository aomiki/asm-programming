section .text

global _start

extern parse_input
extern doAsmCalculations
extern output_result

_start:
	mov ebp, esp

	sub esp, 8 ; allocate space for x
	; esi - pointer to x:
	mov esi, esp ;

	push esi ; pointer to x
	; argv
	push DWORD ebp
	add DWORD [esp], 4
	; argc
	push DWORD [ebp]
	call parse_input

	sub esp, 8 ; allocate res
	push esp ; pointer to res
	push DWORD [esi + 4] ; x - 4 higher bytes
	push DWORD [esi] ; x - 4 lower bytes
	call doAsmCalculations

	add esp, 12 ; skip args - x,res pointer, to get to res
	push eax ; status
	push DWORD [esi + 4] ; X - 4 higher bytes
	push DWORD [esi] ; x - 4 lower bytes
	call output_result

	mov eax, 1	; exit(
	mov ebx, 0	;   0,
	sysenter	; );
