.686P
.MODEL FLAT, C
.DATA

public calcDiv

.CODE
calcDiv PROC C a_arg:DWORD, b_arg:DWORD, res_arg:PTR DWORD

mov eax, [a_arg]
mov ecx, [b_arg]

mov edi, [res_arg] ;get pointer to memory for return value

cmp eax, ecx
je a_equal_b
jg a_greater_b
jl a_less_b

; core calculations
a_greater_b:
cmp ecx, 4 ; should be b < 4
je func_ret_undefined
jg func_ret_undefined

; [edi] = b^2 + 5
imul ecx, ecx
jo mul_overflow
add ecx, 5
jo add_overflow

; return
mov eax, 0 ; OK status code
mov [edi], ecx ; move result to the memory address
jmp func_ret

; [edi] = (ab - 20)/b
a_less_b:
; eax = ab - 20
imul eax, ecx
jo mul_overflow
sub eax, 20
jo sub_overflow

; eax = eax/b

test ecx, ecx
jz div_by_zero

cdq
idiv ecx
jo div_overflow

; return
mov [edi], eax ; move result to the memory address
mov eax, 0 ; OK status code
jmp func_ret

; [edi] = -15 * b
a_equal_b:
imul ecx, -15
jo mul_overflow

; return
mov eax, 0 ; OK status code
mov [edi], ecx ;move result to the memory address
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
ret

calcDiv ENDP

END
