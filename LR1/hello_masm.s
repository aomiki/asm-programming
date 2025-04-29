.686P
.MODEL FLAT, C

.DATA

msg DB "Hello, world!", 10
msglen EQU $ - msg

public _start

.CODE

_start PROC
  mov eax, 1        ; write(
  mov edi, 1        ;   STDOUT_FILENO,
  mov esi, msg      ;   "Hello, world!\n",
  mov edx, msglen   ;   sizeof("Hello, world!\n")
  sysenter           ; );

  mov eax, 60       ; exit(
  mov edi, 0        ;   EXIT_SUCCESS
  sysenter           ; );

_start ENDP

END