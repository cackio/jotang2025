	.file	"test_compiler.c"
	.text
	.p2align 4
	.globl	now_ms
	.type	now_ms, @function
now_ms:
.LFB39:
	.cfi_startproc
	endbr64
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movl	$1, %edi
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rsi
	call	clock_gettime@PLT
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdq	(%rsp), %xmm0
	mulsd	.LC0(%rip), %xmm0
	cvtsi2sdq	8(%rsp), %xmm1
	divsd	.LC1(%rip), %xmm1
	addsd	%xmm1, %xmm0
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L5
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE39:
	.size	now_ms, .-now_ms
	.p2align 4
	.globl	matmul
	.type	matmul, @function
matmul:
.LFB40:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, -24(%rsp)
	movq	%rdx, -16(%rsp)
	movq	%rcx, -8(%rsp)
	testq	%rcx, %rcx
	je	.L6
	movq	%r8, %r10
	testq	%r8, %r8
	je	.L6
	movq	%rdi, %rbx
	xorl	%r14d, %r14d
	xorl	%r13d, %r13d
	xorl	%r12d, %r12d
	leaq	0(,%r9,4), %r15
	leaq	0(,%r8,4), %rsi
	pxor	%xmm2, %xmm2
	leaq	(%rdi,%r15), %rcx
	.p2align 4,,10
	.p2align 3
.L8:
	movq	-16(%rsp), %rax
	movq	-24(%rsp), %r8
	leaq	(%rbx,%r14,4), %rbp
	xorl	%edi, %edi
	leaq	(%rax,%r13,4), %r11
	.p2align 4,,10
	.p2align 3
.L12:
	movq	%r8, %rdx
	movq	%rbp, %rax
	movaps	%xmm2, %xmm1
	testq	%r9, %r9
	je	.L11
	.p2align 4,,10
	.p2align 3
.L9:
	movss	(%rax), %xmm0
	mulss	(%rdx), %xmm0
	addq	$4, %rax
	addq	%rsi, %rdx
	addss	%xmm0, %xmm1
	cmpq	%rcx, %rax
	jne	.L9
.L11:
	movss	%xmm1, (%r11,%rdi,4)
	addq	$1, %rdi
	addq	$4, %r8
	cmpq	%rdi, %r10
	jne	.L12
	addq	$1, %r12
	addq	%r10, %r13
	addq	%r9, %r14
	addq	%r15, %rcx
	cmpq	%r12, -8(%rsp)
	jne	.L8
.L6:
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE40:
	.size	matmul, .-matmul
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
	.string	"matmul: %.6f ms, C[0]=%.2f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB41:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	$262144, %edi
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	call	malloc@PLT
	movl	$262144, %edi
	movq	%rax, %r12
	call	malloc@PLT
	movl	$262144, %edi
	movq	%rax, %r13
	call	malloc@PLT
	movq	%rax, %rbp
	xorl	%eax, %eax
.L25:
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movss	%xmm0, (%r12,%rax,4)
	addq	$1, %rax
	cmpq	$65536, %rax
	jne	.L25
	xorl	%eax, %eax
.L26:
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movss	%xmm0, 0(%r13,%rax,2)
	addq	$2, %rax
	cmpq	$131072, %rax
	jne	.L26
	xorl	%eax, %eax
	movl	$2000, %ebx
	leaq	1024(%rbp), %r14
	call	now_ms
	leaq	262144(%r12), %r11
	movsd	%xmm0, 8(%rsp)
.L27:
	movq	%rbp, %r10
	movq	%r14, %r8
	movq	%r12, %rcx
	.p2align 4,,10
	.p2align 3
.L33:
	movq	%r13, %rdx
	movq	%r10, %rax
	.p2align 4,,10
	.p2align 3
.L31:
	movq	%rcx, %rdi
	movq	%rdx, %rsi
	pxor	%xmm0, %xmm0
	leaq	262144(%rdx), %r9
.L28:
	movss	(%rdi), %xmm1
	movups	(%rsi), %xmm2
	addq	$1024, %rsi
	addq	$4, %rdi
	shufps	$0, %xmm1, %xmm1
	mulps	%xmm2, %xmm1
	addps	%xmm1, %xmm0
	cmpq	%rsi, %r9
	jne	.L28
	movups	%xmm0, (%rax)
	addq	$16, %rax
	addq	$16, %rdx
	cmpq	%r8, %rax
	jne	.L31
	addq	$1024, %rcx
	leaq	1024(%rax), %r8
	addq	$1024, %r10
	cmpq	%rcx, %r11
	jne	.L33
	subl	$1, %ebx
	jne	.L27
	xorl	%eax, %eax
	call	now_ms
	leaq	.LC4(%rip), %rsi
	movl	$1, %edi
	pxor	%xmm1, %xmm1
	movl	$2, %eax
	cvtss2sd	0(%rbp), %xmm1
	subsd	8(%rsp), %xmm0
	divsd	.LC3(%rip), %xmm0
	call	__printf_chk@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	%rbp, %rdi
	call	free@PLT
	addq	$16, %rsp
	.cfi_def_cfa_offset 48
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1083129856
	.align 8
.LC1:
	.long	0
	.long	1093567616
	.align 8
.LC3:
	.long	0
	.long	1084178432
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
