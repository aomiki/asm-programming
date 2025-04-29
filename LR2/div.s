.686P
.MODEL FLAT, C
.DATA

public calcDiv

.CODE
calcDiv PROC C a_arg:DWORD, b_arg:DWORD, c_arg:DWORD, res_arg:PTR DWORD

; ecx = (4*a - b - 1)
mov ecx, [a_arg]
imul ecx, 4
jo mul_overflow

sub ecx, [b_arg]
jo sub_overflow

sub ecx, 1
jo sub_overflow

;eax = (c/b + a)
mov eax, [b_arg]
test eax, eax
jz div_by_zero ; check tath c/b won't divide by zero

mov eax, [c_arg]
cdq

idiv [b_arg]
jo div_overflow

add eax, [a_arg]
jz div_by_zero ; check for final division
jo add_overflow

; final division
mov ebx, eax
mov eax, ecx
cdq
idiv ebx
jo div_overflow

; save the result
mov ecx, [res_arg] ;get pointer to memory for return value
mov [ecx], eax ;move result to the memory address

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
