global _start
extern printf

section .text

_start:
  mov al,100
  add al,100
  mov rax, 1        ; write(
  mov rdi, 1        ;   STDOUT_FILENO,
  mov rsi, al      ;   "Hello, world!\n",
  mov rdx, 1   ;   sizeof("Hello, world!\n")
  syscall           ; );

  mov rax, 60       ; exit(
  mov rdi, 0        ;   EXIT_SUCCESS
  syscall           ; );

; https://stackoverflow.com/questions/8194141/how-to-print-a-number-in-assembly-nasm