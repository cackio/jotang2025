	.text
	.file	"test_compiler.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function now_ms
.LCPI0_0:
	.quad	0x412e848000000000              # double 1.0E+6
.LCPI0_1:
	.quad	0x408f400000000000              # double 1000
	.text
	.globl	now_ms
	.p2align	4, 0x90
	.type	now_ms,@function
now_ms:                                 # @now_ms
	.cfi_startproc
# %bb.0:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	callq	clock_gettime@PLT
	cvtsi2sdq	8(%rsp), %xmm0
	cvtsi2sdq	16(%rsp), %xmm1
	divsd	.LCPI0_0(%rip), %xmm1
	mulsd	.LCPI0_1(%rip), %xmm0
	addsd	%xmm1, %xmm0
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	now_ms, .Lfunc_end0-now_ms
	.cfi_endproc
                                        # -- End function
	.globl	matmul                          # -- Begin function matmul
	.p2align	4, 0x90
	.type	matmul,@function
matmul:                                 # @matmul
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, (%rsp)                    # 8-byte Spill
	testq	%rcx, %rcx
	je	.LBB1_13
# %bb.1:
	testq	%r8, %r8
	je	.LBB1_13
# %bb.2:
	testq	%r9, %r9
	je	.LBB1_14
# %bb.3:
	movq	%rsi, %r14
	movq	%r9, %r10
	andq	$-2, %r10
	leaq	4(%rdi), %rax
	leaq	(,%r9,4), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	leaq	(,%r8,8), %rbx
	xorl	%r12d, %r12d
	jmp	.LBB1_4
	.p2align	4, 0x90
.LBB1_12:                               #   in Loop: Header=BB1_4 Depth=1
	movq	16(%rsp), %r12                  # 8-byte Reload
	addq	$1, %r12
	addq	8(%rsp), %rax                   # 8-byte Folded Reload
	cmpq	(%rsp), %r12                    # 8-byte Folded Reload
	je	.LBB1_13
.LBB1_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_5 Depth 2
                                        #       Child Loop BB1_8 Depth 3
	movq	%r12, %r15
	imulq	%r9, %r15
	movq	%r12, 16(%rsp)                  # 8-byte Spill
	imulq	%r8, %r12
	movq	%r14, %rsi
	xorl	%ebp, %ebp
	jmp	.LBB1_5
	.p2align	4, 0x90
.LBB1_11:                               #   in Loop: Header=BB1_5 Depth=2
	leaq	(%r12,%rbp), %rcx
	movss	%xmm0, (%rdx,%rcx,4)
	addq	$1, %rbp
	addq	$4, %rsi
	cmpq	%r8, %rbp
	je	.LBB1_12
.LBB1_5:                                #   Parent Loop BB1_4 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_8 Depth 3
	cmpq	$1, %r9
	jne	.LBB1_7
# %bb.6:                                #   in Loop: Header=BB1_5 Depth=2
	xorps	%xmm0, %xmm0
	xorl	%r11d, %r11d
	jmp	.LBB1_9
	.p2align	4, 0x90
.LBB1_7:                                #   in Loop: Header=BB1_5 Depth=2
	xorps	%xmm1, %xmm1
	movq	%rsi, %r13
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB1_8:                                #   Parent Loop BB1_4 Depth=1
                                        #     Parent Loop BB1_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movss	-4(%rax,%r11,4), %xmm2          # xmm2 = mem[0],zero,zero,zero
	mulss	(%r13), %xmm2
	movss	(%rax,%r11,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	addss	%xmm1, %xmm2
	mulss	(%r13,%r8,4), %xmm0
	addss	%xmm2, %xmm0
	addq	$2, %r11
	addq	%rbx, %r13
	movaps	%xmm0, %xmm1
	cmpq	%r11, %r10
	jne	.LBB1_8
.LBB1_9:                                #   in Loop: Header=BB1_5 Depth=2
	testb	$1, %r9b
	je	.LBB1_11
# %bb.10:                               #   in Loop: Header=BB1_5 Depth=2
	leaq	(%r11,%r15), %rcx
	movss	(%rdi,%rcx,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
	imulq	%r8, %r11
	addq	%rbp, %r11
	mulss	(%r14,%r11,4), %xmm1
	addss	%xmm1, %xmm0
	jmp	.LBB1_11
.LBB1_14:
	imulq	(%rsp), %r8                     # 8-byte Folded Reload
	shlq	$2, %r8
	movq	%rdx, %rdi
	xorl	%esi, %esi
	movq	%r8, %rdx
	callq	memset@PLT
.LBB1_13:
	addq	$24, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	matmul, .Lfunc_end1-matmul
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4                               # -- Begin function main
.LCPI2_0:
	.quad	2                               # 0x2
	.quad	3                               # 0x3
.LCPI2_1:
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
.LCPI2_2:
	.quad	4                               # 0x4
	.quad	4                               # 0x4
.LCPI2_3:
	.quad	8                               # 0x8
	.quad	8                               # 0x8
.LCPI2_4:
	.quad	12                              # 0xc
	.quad	12                              # 0xc
.LCPI2_5:
	.quad	16                              # 0x10
	.quad	16                              # 0x10
.LCPI2_6:
	.quad	24                              # 0x18
	.quad	24                              # 0x18
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI2_7:
	.quad	0x412e848000000000              # double 1.0E+6
.LCPI2_8:
	.quad	0x408f400000000000              # double 1000
.LCPI2_9:
	.quad	0x409f400000000000              # double 2000
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	$262144, %edi                   # imm = 0x40000
	callq	malloc@PLT
	movq	%rax, %r14
	movq	%rax, %rbx
	movl	$262144, %edi                   # imm = 0x40000
	callq	malloc@PLT
	movq	%rax, %r13
	movq	%rax, %r15
	movl	$262144, %edi                   # imm = 0x40000
	callq	malloc@PLT
	movq	%rax, %r12
	movdqa	.LCPI2_0(%rip), %xmm2           # xmm2 = [2,3]
	movdqa	.LCPI2_1(%rip), %xmm3           # xmm3 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
	movl	$12, %eax
	movdqa	.LCPI2_2(%rip), %xmm8           # xmm8 = [4,4]
	movdqa	.LCPI2_3(%rip), %xmm9           # xmm9 = [8,8]
	movdqa	.LCPI2_4(%rip), %xmm5           # xmm5 = [12,12]
	movdqa	.LCPI2_5(%rip), %xmm10          # xmm10 = [16,16]
	jmp	.LBB2_1
	.p2align	4, 0x90
.LBB2_48:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
.LBB2_49:                               #   in Loop: Header=BB2_1 Depth=1
	unpcklps	%xmm0, %xmm4                    # xmm4 = xmm4[0],xmm0[0],xmm4[1],xmm0[1]
	unpcklps	%xmm7, %xmm6                    # xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1]
	movlhps	%xmm4, %xmm6                    # xmm6 = xmm6[0],xmm4[0]
	movups	%xmm6, (%r14,%rax,4)
	paddq	%xmm10, %xmm3
	paddq	%xmm10, %xmm2
	addq	$16, %rax
	cmpq	$65548, %rax                    # imm = 0x1000C
	je	.LBB2_50
.LBB2_1:                                # =>This Inner Loop Header: Depth=1
	movq	%xmm3, %rcx
	testq	%rcx, %rcx
	js	.LBB2_2
# %bb.3:                                #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rcx, %xmm6
	pshufd	$238, %xmm3, %xmm0              # xmm0 = xmm3[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_6
.LBB2_5:                                #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	addss	%xmm7, %xmm7
	movq	%xmm2, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_9
.LBB2_8:                                #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	addss	%xmm4, %xmm4
	pshufd	$238, %xmm2, %xmm0              # xmm0 = xmm2[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_12
.LBB2_11:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	addss	%xmm0, %xmm0
	jmp	.LBB2_13
	.p2align	4, 0x90
.LBB2_2:                                #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rcx, %xmm6
	addss	%xmm6, %xmm6
	pshufd	$238, %xmm3, %xmm0              # xmm0 = xmm3[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_5
.LBB2_6:                                #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	movq	%xmm2, %rcx
	testq	%rcx, %rcx
	js	.LBB2_8
.LBB2_9:                                #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	pshufd	$238, %xmm2, %xmm0              # xmm0 = xmm2[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_11
.LBB2_12:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
.LBB2_13:                               #   in Loop: Header=BB2_1 Depth=1
	unpcklps	%xmm0, %xmm4                    # xmm4 = xmm4[0],xmm0[0],xmm4[1],xmm0[1]
	unpcklps	%xmm7, %xmm6                    # xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1]
	movlhps	%xmm4, %xmm6                    # xmm6 = xmm6[0],xmm4[0]
	movups	%xmm6, -48(%r14,%rax,4)
	movdqa	%xmm3, %xmm0
	paddq	%xmm8, %xmm0
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_14
# %bb.15:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rcx, %xmm6
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_18
.LBB2_17:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	addss	%xmm7, %xmm7
	jmp	.LBB2_19
	.p2align	4, 0x90
.LBB2_14:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rcx, %xmm6
	addss	%xmm6, %xmm6
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_17
.LBB2_18:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
.LBB2_19:                               #   in Loop: Header=BB2_1 Depth=1
	movdqa	%xmm2, %xmm0
	paddq	%xmm8, %xmm0
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_20
# %bb.21:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_24
.LBB2_23:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	addss	%xmm0, %xmm0
	jmp	.LBB2_25
	.p2align	4, 0x90
.LBB2_20:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	addss	%xmm4, %xmm4
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_23
.LBB2_24:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
.LBB2_25:                               #   in Loop: Header=BB2_1 Depth=1
	unpcklps	%xmm0, %xmm4                    # xmm4 = xmm4[0],xmm0[0],xmm4[1],xmm0[1]
	unpcklps	%xmm7, %xmm6                    # xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1]
	movlhps	%xmm4, %xmm6                    # xmm6 = xmm6[0],xmm4[0]
	movups	%xmm6, -32(%r14,%rax,4)
	movdqa	%xmm3, %xmm0
	paddq	%xmm9, %xmm0
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_26
# %bb.27:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rcx, %xmm6
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_30
.LBB2_29:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	addss	%xmm7, %xmm7
	jmp	.LBB2_31
	.p2align	4, 0x90
.LBB2_26:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rcx, %xmm6
	addss	%xmm6, %xmm6
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_29
.LBB2_30:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
.LBB2_31:                               #   in Loop: Header=BB2_1 Depth=1
	movdqa	%xmm2, %xmm0
	paddq	%xmm9, %xmm0
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_32
# %bb.33:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_36
.LBB2_35:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	addss	%xmm0, %xmm0
	jmp	.LBB2_37
	.p2align	4, 0x90
.LBB2_32:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	addss	%xmm4, %xmm4
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_35
.LBB2_36:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
.LBB2_37:                               #   in Loop: Header=BB2_1 Depth=1
	unpcklps	%xmm0, %xmm4                    # xmm4 = xmm4[0],xmm0[0],xmm4[1],xmm0[1]
	unpcklps	%xmm7, %xmm6                    # xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1]
	movlhps	%xmm4, %xmm6                    # xmm6 = xmm6[0],xmm4[0]
	movups	%xmm6, -16(%r14,%rax,4)
	movdqa	%xmm3, %xmm0
	paddq	%xmm5, %xmm0
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_38
# %bb.39:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rcx, %xmm6
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_42
.LBB2_41:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	addss	%xmm7, %xmm7
	jmp	.LBB2_43
	.p2align	4, 0x90
.LBB2_38:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rcx, %xmm6
	addss	%xmm6, %xmm6
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_41
.LBB2_42:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
.LBB2_43:                               #   in Loop: Header=BB2_1 Depth=1
	movdqa	%xmm2, %xmm0
	paddq	%xmm5, %xmm0
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_44
# %bb.45:                               #   in Loop: Header=BB2_1 Depth=1
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_48
	jmp	.LBB2_47
	.p2align	4, 0x90
.LBB2_44:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	addss	%xmm4, %xmm4
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_48
.LBB2_47:                               #   in Loop: Header=BB2_1 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	addss	%xmm0, %xmm0
	jmp	.LBB2_49
.LBB2_50:
	movdqa	.LCPI2_0(%rip), %xmm1           # xmm1 = [2,3]
	movdqa	.LCPI2_1(%rip), %xmm3           # xmm3 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
	movl	$12, %eax
	movdqa	.LCPI2_6(%rip), %xmm8           # xmm8 = [24,24]
	jmp	.LBB2_51
	.p2align	4, 0x90
.LBB2_98:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm2, %xmm2
	cvtsi2ss	%rcx, %xmm2
.LBB2_99:                               #   in Loop: Header=BB2_51 Depth=1
	unpcklps	%xmm2, %xmm0                    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
	unpcklps	%xmm4, %xmm7                    # xmm7 = xmm7[0],xmm4[0],xmm7[1],xmm4[1]
	movlhps	%xmm0, %xmm7                    # xmm7 = xmm7[0],xmm0[0]
	movups	%xmm7, (%r15,%rax,4)
	paddq	%xmm10, %xmm3
	paddq	%xmm10, %xmm1
	addq	$16, %rax
	cmpq	$65548, %rax                    # imm = 0x1000C
	je	.LBB2_100
.LBB2_51:                               # =>This Inner Loop Header: Depth=1
	movdqa	%xmm3, %xmm6
	paddq	%xmm3, %xmm6
	movq	%xmm6, %rcx
	testq	%rcx, %rcx
	js	.LBB2_52
# %bb.53:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	pshufd	$238, %xmm6, %xmm0              # xmm0 = xmm6[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_56
.LBB2_55:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	addss	%xmm4, %xmm4
	jmp	.LBB2_57
	.p2align	4, 0x90
.LBB2_52:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	addss	%xmm7, %xmm7
	pshufd	$238, %xmm6, %xmm0              # xmm0 = xmm6[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_55
.LBB2_56:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
.LBB2_57:                               #   in Loop: Header=BB2_51 Depth=1
	movdqa	%xmm1, %xmm2
	paddq	%xmm1, %xmm2
	movq	%xmm2, %rcx
	testq	%rcx, %rcx
	js	.LBB2_58
# %bb.59:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	pshufd	$238, %xmm2, %xmm5              # xmm5 = xmm2[2,3,2,3]
	movq	%xmm5, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_62
.LBB2_61:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm5, %xmm5
	cvtsi2ss	%rcx, %xmm5
	addss	%xmm5, %xmm5
	jmp	.LBB2_63
	.p2align	4, 0x90
.LBB2_58:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	addss	%xmm0, %xmm0
	pshufd	$238, %xmm2, %xmm5              # xmm5 = xmm2[2,3,2,3]
	movq	%xmm5, %rcx
	testq	%rcx, %rcx
	js	.LBB2_61
.LBB2_62:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm5, %xmm5
	cvtsi2ss	%rcx, %xmm5
.LBB2_63:                               #   in Loop: Header=BB2_51 Depth=1
	unpcklps	%xmm5, %xmm0                    # xmm0 = xmm0[0],xmm5[0],xmm0[1],xmm5[1]
	unpcklps	%xmm4, %xmm7                    # xmm7 = xmm7[0],xmm4[0],xmm7[1],xmm4[1]
	movlhps	%xmm0, %xmm7                    # xmm7 = xmm7[0],xmm0[0]
	movups	%xmm7, -48(%r15,%rax,4)
	movdqa	%xmm6, %xmm0
	paddq	%xmm9, %xmm0
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_64
# %bb.65:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_68
.LBB2_67:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	addss	%xmm4, %xmm4
	jmp	.LBB2_69
	.p2align	4, 0x90
.LBB2_64:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	addss	%xmm7, %xmm7
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_67
.LBB2_68:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
.LBB2_69:                               #   in Loop: Header=BB2_51 Depth=1
	movdqa	%xmm2, %xmm5
	paddq	%xmm9, %xmm5
	movq	%xmm5, %rcx
	testq	%rcx, %rcx
	js	.LBB2_70
# %bb.71:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	pshufd	$238, %xmm5, %xmm5              # xmm5 = xmm5[2,3,2,3]
	movq	%xmm5, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_74
.LBB2_73:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm5, %xmm5
	cvtsi2ss	%rcx, %xmm5
	addss	%xmm5, %xmm5
	jmp	.LBB2_75
	.p2align	4, 0x90
.LBB2_70:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	addss	%xmm0, %xmm0
	pshufd	$238, %xmm5, %xmm5              # xmm5 = xmm5[2,3,2,3]
	movq	%xmm5, %rcx
	testq	%rcx, %rcx
	js	.LBB2_73
.LBB2_74:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm5, %xmm5
	cvtsi2ss	%rcx, %xmm5
.LBB2_75:                               #   in Loop: Header=BB2_51 Depth=1
	unpcklps	%xmm5, %xmm0                    # xmm0 = xmm0[0],xmm5[0],xmm0[1],xmm5[1]
	unpcklps	%xmm4, %xmm7                    # xmm7 = xmm7[0],xmm4[0],xmm7[1],xmm4[1]
	movlhps	%xmm0, %xmm7                    # xmm7 = xmm7[0],xmm0[0]
	movups	%xmm7, -32(%r15,%rax,4)
	movdqa	%xmm6, %xmm0
	paddq	%xmm10, %xmm0
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_76
# %bb.77:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_80
.LBB2_79:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	addss	%xmm4, %xmm4
	jmp	.LBB2_81
	.p2align	4, 0x90
.LBB2_76:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	addss	%xmm7, %xmm7
	pshufd	$238, %xmm0, %xmm0              # xmm0 = xmm0[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_79
.LBB2_80:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
.LBB2_81:                               #   in Loop: Header=BB2_51 Depth=1
	movdqa	%xmm2, %xmm5
	paddq	%xmm10, %xmm5
	movq	%xmm5, %rcx
	testq	%rcx, %rcx
	js	.LBB2_82
# %bb.83:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	pshufd	$238, %xmm5, %xmm5              # xmm5 = xmm5[2,3,2,3]
	movq	%xmm5, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_86
.LBB2_85:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm5, %xmm5
	cvtsi2ss	%rcx, %xmm5
	addss	%xmm5, %xmm5
	jmp	.LBB2_87
	.p2align	4, 0x90
.LBB2_82:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	addss	%xmm0, %xmm0
	pshufd	$238, %xmm5, %xmm5              # xmm5 = xmm5[2,3,2,3]
	movq	%xmm5, %rcx
	testq	%rcx, %rcx
	js	.LBB2_85
.LBB2_86:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm5, %xmm5
	cvtsi2ss	%rcx, %xmm5
.LBB2_87:                               #   in Loop: Header=BB2_51 Depth=1
	unpcklps	%xmm5, %xmm0                    # xmm0 = xmm0[0],xmm5[0],xmm0[1],xmm5[1]
	unpcklps	%xmm4, %xmm7                    # xmm7 = xmm7[0],xmm4[0],xmm7[1],xmm4[1]
	movlhps	%xmm0, %xmm7                    # xmm7 = xmm7[0],xmm0[0]
	movups	%xmm7, -16(%r15,%rax,4)
	paddq	%xmm8, %xmm6
	movq	%xmm6, %rcx
	testq	%rcx, %rcx
	js	.LBB2_88
# %bb.89:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	pshufd	$238, %xmm6, %xmm0              # xmm0 = xmm6[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_92
.LBB2_91:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	addss	%xmm4, %xmm4
	paddq	%xmm8, %xmm2
	movq	%xmm2, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_95
.LBB2_94:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	addss	%xmm0, %xmm0
	pshufd	$238, %xmm2, %xmm2              # xmm2 = xmm2[2,3,2,3]
	movq	%xmm2, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_98
	jmp	.LBB2_97
	.p2align	4, 0x90
.LBB2_88:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rcx, %xmm7
	addss	%xmm7, %xmm7
	pshufd	$238, %xmm6, %xmm0              # xmm0 = xmm6[2,3,2,3]
	movq	%xmm0, %rcx
	testq	%rcx, %rcx
	js	.LBB2_91
.LBB2_92:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm4, %xmm4
	cvtsi2ss	%rcx, %xmm4
	paddq	%xmm8, %xmm2
	movq	%xmm2, %rcx
	testq	%rcx, %rcx
	js	.LBB2_94
.LBB2_95:                               #   in Loop: Header=BB2_51 Depth=1
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rcx, %xmm0
	pshufd	$238, %xmm2, %xmm2              # xmm2 = xmm2[2,3,2,3]
	movq	%xmm2, %rcx
	testq	%rcx, %rcx
	jns	.LBB2_98
.LBB2_97:                               #   in Loop: Header=BB2_51 Depth=1
	movq	%rcx, %rdx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rdx, %rcx
	xorps	%xmm2, %xmm2
	cvtsi2ss	%rcx, %xmm2
	addss	%xmm2, %xmm2
	jmp	.LBB2_99
.LBB2_100:
	movq	%rsp, %rsi
	movl	$1, %edi
	callq	clock_gettime@PLT
	movq	(%rsp), %r8
	movq	8(%rsp), %r9
	movq	%rbx, %r11
	addq	$4, %r11
	addq	$1024, %r13                     # imm = 0x400
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB2_101:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_102 Depth 2
                                        #       Child Loop BB2_103 Depth 3
                                        #         Child Loop BB2_104 Depth 4
	movq	%r11, %rsi
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB2_102:                              #   Parent Loop BB2_101 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_103 Depth 3
                                        #         Child Loop BB2_104 Depth 4
	movq	%rax, %rdi
	shlq	$8, %rdi
	movq	%r13, %rbx
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_103:                              #   Parent Loop BB2_101 Depth=1
                                        #     Parent Loop BB2_102 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_104 Depth 4
	xorps	%xmm0, %xmm0
	movq	%rbx, %rcx
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB2_104:                              #   Parent Loop BB2_101 Depth=1
                                        #     Parent Loop BB2_102 Depth=2
                                        #       Parent Loop BB2_103 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movss	-4(%rsi,%rbp,4), %xmm1          # xmm1 = mem[0],zero,zero,zero
	mulss	-1024(%rcx), %xmm1
	addss	%xmm0, %xmm1
	movss	(%rsi,%rbp,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	mulss	(%rcx), %xmm0
	addss	%xmm1, %xmm0
	addq	$2, %rbp
	addq	$2048, %rcx                     # imm = 0x800
	cmpq	$256, %rbp                      # imm = 0x100
	jne	.LBB2_104
# %bb.105:                              #   in Loop: Header=BB2_103 Depth=3
	leaq	(%rdx,%rdi), %rcx
	movss	%xmm0, (%r12,%rcx,4)
	addq	$1, %rdx
	addq	$4, %rbx
	cmpq	$256, %rdx                      # imm = 0x100
	jne	.LBB2_103
# %bb.106:                              #   in Loop: Header=BB2_102 Depth=2
	addq	$1, %rax
	addq	$1024, %rsi                     # imm = 0x400
	cmpq	$256, %rax                      # imm = 0x100
	jne	.LBB2_102
# %bb.107:                              #   in Loop: Header=BB2_101 Depth=1
	addl	$1, %r10d
	cmpl	$2000, %r10d                    # imm = 0x7D0
	jne	.LBB2_101
# %bb.108:
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r8, %xmm1
	xorps	%xmm0, %xmm0
	cvtsi2sd	%r9, %xmm0
	divsd	.LCPI2_7(%rip), %xmm0
	mulsd	.LCPI2_8(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, 16(%rsp)                 # 8-byte Spill
	movq	%rsp, %rsi
	movl	$1, %edi
	callq	clock_gettime@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sdq	(%rsp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdq	8(%rsp), %xmm1
	divsd	.LCPI2_7(%rip), %xmm1
	mulsd	.LCPI2_8(%rip), %xmm0
	addsd	%xmm1, %xmm0
	subsd	16(%rsp), %xmm0                 # 8-byte Folded Reload
	divsd	.LCPI2_9(%rip), %xmm0
	movss	(%r12), %xmm1                   # xmm1 = mem[0],zero,zero,zero
	cvtss2sd	%xmm1, %xmm1
	leaq	.L.str(%rip), %rdi
	movb	$2, %al
	callq	printf@PLT
	movq	%r14, %rdi
	callq	free@PLT
	movq	%r15, %rdi
	callq	free@PLT
	movq	%r12, %rdi
	callq	free@PLT
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"matmul: %.6f ms, C[0]=%.2f\n"
	.size	.L.str, 28

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
