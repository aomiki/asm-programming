global calcDiv

calcDiv:

; (a+c) /b

movsx BX, [esp + 8]

mov AX, [esp + 4]
mov CX, [esp + 12]

add AX, CX
cwd

idiv BX

; save the result
mov ecx, [esp + 16] ;get pointer to memory for return value
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

