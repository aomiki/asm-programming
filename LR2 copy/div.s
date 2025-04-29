.686P
.MODEL FLAT, C
.DATA

public calcDiv

.CODE
calcDiv PROC C a_arg:WORD, b_arg:BYTE, c_arg:WORD, res_arg:PTR WORD

; (a+c) /b

movsx BX, [b_arg]

mov AX, [a_arg]
mov CX, [c_arg]

add AX, CX
cwd

idiv BX

; save the result
mov ecx, [res_arg] ;get pointer to memory for return value
mov [ecx], AX ;move result to the memory address

; exit function with status code
mov eax, 0 ; OK status code
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

func_ret:
ret

calcDiv ENDP

END
