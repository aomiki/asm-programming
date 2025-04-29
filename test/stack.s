	.file	"stack.cpp"
	.intel_syntax noprefix
# GNU C++17 (GCC) version 14.2.1 20250207 (x86_64-pc-linux-gnu)
#	compiled by GNU C version 14.2.1 20250207, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.27-GMP

# warning: MPFR header version 4.2.1 differs from library version 4.2.2.
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -masm=intel -m32 -mtune=generic -march=x86-64 -Os
	.text
	.globl	_Z8sum_funcii
	.type	_Z8sum_funcii, @function
_Z8sum_funcii:
.LFB0:
	.cfi_startproc
	push	ebp	#
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp	#,
	.cfi_def_cfa_register 5
# stack.cpp:4:     int result1 = sum_arg1 + sum_arg2;
	mov	eax, DWORD PTR 12[ebp]	# sum_arg2, sum_arg2
	add	eax, DWORD PTR 8[ebp]	# result1_3, sum_arg1
# stack.cpp:7: }
	pop	ebp	#
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	
	.cfi_endproc
.LFE0:
	.size	_Z8sum_funcii, .-_Z8sum_funcii
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
# stack.cpp:13: }
	xor	eax, eax	#
	ret	
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (GNU) 14.2.1 20250207"
	.section	.note.GNU-stack,"",@progbits
