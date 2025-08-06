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
	vcvtsi2sdq	16(%rsp), %xmm0, %xmm0
	vdivsd	.LCPI0_0(%rip), %xmm0, %xmm0
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm1
	vfmadd231sd	.LCPI0_1(%rip), %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
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
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	testq	%rcx, %rcx
	je	.LBB1_9
# %bb.1:
	testq	%r8, %r8
	je	.LBB1_9
# %bb.2:
	testq	%r9, %r9
	je	.LBB1_10
# %bb.3:
	leaq	(,%r8,4), %r13
	leaq	(,%r9,4), %r10
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB1_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_5 Depth 2
                                        #       Child Loop BB1_6 Depth 3
	movq	%r11, %r14
	movq	%rsi, %r15
	xorl	%r12d, %r12d
	imulq	%r8, %r14
	.p2align	4, 0x90
.LBB1_5:                                #   Parent Loop BB1_4 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_6 Depth 3
	vxorps	%xmm0, %xmm0, %xmm0
	movq	%rdi, %rbx
	movq	%r15, %rax
	movq	%r9, %rbp
	.p2align	4, 0x90
.LBB1_6:                                #   Parent Loop BB1_4 Depth=1
                                        #     Parent Loop BB1_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovss	(%rbx), %xmm1                   # xmm1 = mem[0],zero,zero,zero
	addq	$4, %rbx
	vfmadd231ss	(%rax), %xmm1, %xmm0    # xmm0 = (xmm1 * mem) + xmm0
	addq	%r13, %rax
	addq	$-1, %rbp
	jne	.LBB1_6
# %bb.7:                                #   in Loop: Header=BB1_5 Depth=2
	leaq	(%r12,%r14), %rax
	addq	$1, %r12
	addq	$4, %r15
	cmpq	%r8, %r12
	vmovss	%xmm0, (%rdx,%rax,4)
	jne	.LBB1_5
# %bb.8:                                #   in Loop: Header=BB1_4 Depth=1
	addq	$1, %r11
	addq	%r10, %rdi
	cmpq	%rcx, %r11
	jne	.LBB1_4
	jmp	.LBB1_9
.LBB1_10:
	imulq	%rcx, %r8
	movq	%rdx, %rdi
	xorl	%esi, %esi
	shlq	$2, %r8
	movq	%r8, %rdx
	callq	memset@PLT
.LBB1_9:
	addq	$8, %rsp
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
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5                               # -- Begin function main
.LCPI2_0:
	.quad	4                               # 0x4
	.quad	5                               # 0x5
	.quad	6                               # 0x6
	.quad	7                               # 0x7
.LCPI2_1:
	.quad	0                               # 0x0
	.quad	1                               # 0x1
	.quad	2                               # 0x2
	.quad	3                               # 0x3
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI2_2:
	.quad	1                               # 0x1
.LCPI2_3:
	.quad	8                               # 0x8
.LCPI2_4:
	.quad	16                              # 0x10
.LCPI2_5:
	.quad	0x412e848000000000              # double 1.0E+6
.LCPI2_6:
	.quad	0x408f400000000000              # double 1000
.LCPI2_7:
	.quad	0x409f400000000000              # double 2000
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$168, %rsp
	.cfi_def_cfa_offset 208
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movl	$262144, %edi                   # imm = 0x40000
	callq	malloc@PLT
	movl	$262144, %edi                   # imm = 0x40000
	movq	%rax, %r14
	callq	malloc@PLT
	movl	$262144, %edi                   # imm = 0x40000
	movq	%rax, %r15
	callq	malloc@PLT
	vpbroadcastq	.LCPI2_2(%rip), %ymm15  # ymm15 = [1,1,1,1]
	vbroadcastsd	.LCPI2_3(%rip), %ymm0   # ymm0 = [8,8,8,8]
	vbroadcastsd	.LCPI2_4(%rip), %ymm1   # ymm1 = [16,16,16,16]
	vmovdqa	.LCPI2_0(%rip), %ymm14          # ymm14 = [4,5,6,7]
	vmovdqa	.LCPI2_1(%rip), %ymm4           # ymm4 = [0,1,2,3]
	movq	%rax, %r12
	movq	$-262144, %rax                  # imm = 0xFFFC0000
	vmovups	%ymm0, 64(%rsp)                 # 32-byte Spill
	vmovups	%ymm1, 96(%rsp)                 # 32-byte Spill
	vmovdqu	%ymm15, 128(%rsp)               # 32-byte Spill
	.p2align	4, 0x90
.LBB2_1:                                # =>This Inner Loop Header: Depth=1
	vpsrlq	$1, %ymm14, %ymm1
	vpand	%ymm15, %ymm14, %ymm2
	vpand	%ymm4, %ymm15, %ymm5
	vpor	%ymm2, %ymm1, %ymm1
	vpsrlq	$1, %ymm4, %ymm2
	vblendvpd	%ymm14, %ymm1, %ymm14, %ymm1
	vpor	%ymm5, %ymm2, %ymm2
	vpextrq	$1, %xmm1, %rcx
	vmovq	%xmm1, %rdx
	vblendvpd	%ymm4, %ymm2, %ymm4, %ymm2
	vextracti128	$1, %ymm1, %xmm1
	vxorps	%xmm9, %xmm9, %xmm9
	vcvtsi2ss	%rcx, %xmm9, %xmm11
	vxorps	%xmm9, %xmm9, %xmm9
	vcvtsi2ss	%rdx, %xmm9, %xmm0
	vpextrq	$1, %xmm2, %rsi
	vmovq	%xmm2, %rdi
	vmovq	%xmm1, %rcx
	vextracti128	$1, %ymm2, %xmm5
	vpextrq	$1, %xmm1, %r8
	vmovaps	%xmm0, 16(%rsp)                 # 16-byte Spill
	vmovdqu	64(%rsp), %ymm0                 # 32-byte Reload
	vpaddq	%ymm0, %ymm14, %ymm8
	vxorps	%xmm9, %xmm9, %xmm9
	vcvtsi2ss	%rsi, %xmm9, %xmm1
	vxorps	%xmm9, %xmm9, %xmm9
	vcvtsi2ss	%rdi, %xmm9, %xmm2
	vpaddq	%ymm0, %ymm4, %ymm7
	vxorps	%xmm9, %xmm9, %xmm9
	vcvtsi2ss	%rcx, %xmm9, %xmm0
	vmovq	%xmm5, %rsi
	vpextrq	$1, %xmm5, %rdi
	vpand	%ymm15, %ymm8, %ymm12
	vpsrlq	$1, %ymm8, %ymm13
	vpor	%ymm12, %ymm13, %ymm12
	vpsrlq	$1, %ymm7, %ymm13
	vblendvpd	%ymm8, %ymm12, %ymm8, %ymm12
	vpextrq	$1, %xmm12, %rbx
	vmovq	%xmm12, %rdx
	vextracti128	$1, %ymm12, %xmm5
	vpand	%ymm7, %ymm15, %ymm12
	vmovaps	%xmm0, 48(%rsp)                 # 16-byte Spill
	vxorps	%xmm9, %xmm9, %xmm9
	vcvtsi2ss	%r8, %xmm9, %xmm0
	vpor	%ymm12, %ymm13, %ymm12
	vinsertps	$16, %xmm1, %xmm2, %xmm2 # xmm2 = xmm2[0],xmm1[0],xmm2[2,3]
	vblendvpd	%ymm7, %ymm12, %ymm7, %ymm12
	vpextrq	$1, %xmm12, %rcx
	vextracti128	$1, %ymm12, %xmm3
	vxorps	%xmm9, %xmm9, %xmm9
	vcvtsi2ss	%rsi, %xmm9, %xmm9
	vxorps	%xmm6, %xmm6, %xmm6
	vcvtsi2ss	%rdi, %xmm6, %xmm13
	vpextrq	$1, %xmm5, %rdi
	vmovq	%xmm5, %rsi
	vxorps	%xmm6, %xmm6, %xmm6
	vcvtsi2ss	%rbx, %xmm6, %xmm10
	vxorps	%xmm6, %xmm6, %xmm6
	vcvtsi2ss	%rdx, %xmm6, %xmm15
	vmovq	%xmm12, %rdx
	vmovaps	%xmm0, 32(%rsp)                 # 16-byte Spill
	vxorps	%xmm6, %xmm6, %xmm6
	vcvtsi2ss	%rcx, %xmm6, %xmm5
	vmovq	%xmm3, %rbx
	vxorps	%xmm6, %xmm6, %xmm6
	vcvtsi2ss	%rsi, %xmm6, %xmm12
	vxorps	%xmm6, %xmm6, %xmm6
	vcvtsi2ss	%rdi, %xmm6, %xmm6
	vmovaps	16(%rsp), %xmm0                 # 16-byte Reload
	vpextrq	$1, %xmm3, %rsi
	vinsertps	$16, %xmm11, %xmm0, %xmm11 # xmm11 = xmm0[0],xmm11[0],xmm0[2,3]
	vcvtsi2ss	%rdx, %xmm4, %xmm3
	vcvtsi2ss	%rbx, %xmm4, %xmm1
	vinsertps	$32, 48(%rsp), %xmm11, %xmm11 # 16-byte Folded Reload
                                        # xmm11 = xmm11[0,1],mem[0],xmm11[3]
	vextracti128	$1, %ymm14, %xmm0
	vinsertps	$32, %xmm9, %xmm2, %xmm2 # xmm2 = xmm2[0,1],xmm9[0],xmm2[3]
	vpackssdw	%xmm0, %xmm14, %xmm9
	vinsertps	$48, 32(%rsp), %xmm11, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm11[0,1,2],mem[0]
	vinsertps	$16, %xmm10, %xmm15, %xmm10 # xmm10 = xmm15[0],xmm10[0],xmm15[2,3]
	vextracti128	$1, %ymm4, %xmm15
	vinsertps	$32, %xmm12, %xmm10, %xmm10 # xmm10 = xmm10[0,1],xmm12[0],xmm10[3]
	vinsertps	$48, %xmm13, %xmm2, %xmm2 # xmm2 = xmm2[0,1,2],xmm13[0]
	vpackssdw	%xmm15, %xmm4, %xmm13
	vextracti128	$1, %ymm8, %xmm12
	vinsertps	$48, %xmm6, %xmm10, %xmm6 # xmm6 = xmm10[0,1,2],xmm6[0]
	vaddps	%xmm2, %xmm2, %xmm15
	vpackssdw	%xmm12, %xmm8, %xmm8
	vcvtsi2ss	%rsi, %xmm4, %xmm11
	vinsertps	$16, %xmm5, %xmm3, %xmm3 # xmm3 = xmm3[0],xmm5[0],xmm3[2,3]
	vaddps	%xmm0, %xmm0, %xmm10
	vextracti128	$1, %ymm7, %xmm5
	vinsertps	$32, %xmm1, %xmm3, %xmm1 # xmm1 = xmm3[0,1],xmm1[0],xmm3[3]
	vaddps	%xmm6, %xmm6, %xmm3
	vpackssdw	%xmm5, %xmm7, %xmm5
	vblendvps	%xmm13, %xmm15, %xmm2, %xmm2
	vmovdqu	128(%rsp), %ymm15               # 32-byte Reload
	vblendvps	%xmm9, %xmm10, %xmm0, %xmm0
	vblendvps	%xmm8, %xmm3, %xmm6, %xmm3
	vinsertps	$48, %xmm11, %xmm1, %xmm1 # xmm1 = xmm1[0,1,2],xmm11[0]
	vmovups	%xmm2, 262144(%r14,%rax)
	vaddps	%xmm1, %xmm1, %xmm7
	vmovups	%xmm0, 262160(%r14,%rax)
	vmovdqu	96(%rsp), %ymm0                 # 32-byte Reload
	vmovups	%xmm3, 262192(%r14,%rax)
	vblendvps	%xmm5, %xmm7, %xmm1, %xmm1
	vpaddq	%ymm0, %ymm4, %ymm4
	vpaddq	%ymm0, %ymm14, %ymm14
	vmovups	%xmm1, 262176(%r14,%rax)
	addq	$64, %rax
	jne	.LBB2_1
# %bb.2:
	vmovdqa	.LCPI2_0(%rip), %ymm2           # ymm2 = [4,5,6,7]
	vmovdqa	.LCPI2_1(%rip), %ymm3           # ymm3 = [0,1,2,3]
	vmovdqu	64(%rsp), %ymm14                # 32-byte Reload
	movq	$-262144, %rax                  # imm = 0xFFFC0000
	.p2align	4, 0x90
.LBB2_3:                                # =>This Inner Loop Header: Depth=1
	vpaddq	%ymm2, %ymm2, %ymm5
	vpaddq	%ymm3, %ymm3, %ymm4
	vpaddq	%ymm3, %ymm14, %ymm3
	vpaddq	%ymm2, %ymm14, %ymm2
	vpsrlq	$1, %ymm5, %ymm0
	vpand	%ymm5, %ymm15, %ymm1
	vpsrlq	$1, %ymm4, %ymm6
	vpor	%ymm1, %ymm0, %ymm0
	vpand	%ymm4, %ymm15, %ymm1
	vpor	%ymm1, %ymm6, %ymm1
	vblendvpd	%ymm5, %ymm0, %ymm5, %ymm0
	vblendvpd	%ymm4, %ymm1, %ymm4, %ymm1
	vpextrq	$1, %xmm0, %rcx
	vmovq	%xmm0, %rdx
	vextractf128	$1, %ymm0, %xmm0
	vpextrq	$1, %xmm1, %rsi
	vxorps	%xmm9, %xmm9, %xmm9
	vcvtsi2ss	%rcx, %xmm9, %xmm8
	vxorps	%xmm9, %xmm9, %xmm9
	vcvtsi2ss	%rdx, %xmm9, %xmm9
	vmovq	%xmm0, %rdx
	vmovq	%xmm1, %rcx
	vxorps	%xmm10, %xmm10, %xmm10
	vcvtsi2ss	%rsi, %xmm10, %xmm10
	vpextrq	$1, %xmm0, %rsi
	vextracti128	$1, %ymm1, %xmm0
	vmovq	%xmm0, %rdi
	vxorps	%xmm11, %xmm11, %xmm11
	vcvtsi2ss	%rcx, %xmm11, %xmm11
	vxorps	%xmm12, %xmm12, %xmm12
	vcvtsi2ss	%rdx, %xmm12, %xmm12
	vpextrq	$1, %xmm0, %rdx
	vcvtsi2ss	%rdi, %xmm15, %xmm0
	vinsertps	$16, %xmm8, %xmm9, %xmm7 # xmm7 = xmm9[0],xmm8[0],xmm9[2,3]
	vinsertps	$16, %xmm10, %xmm11, %xmm1 # xmm1 = xmm11[0],xmm10[0],xmm11[2,3]
	vinsertps	$32, %xmm12, %xmm7, %xmm7 # xmm7 = xmm7[0,1],xmm12[0],xmm7[3]
	vcvtsi2ss	%rsi, %xmm15, %xmm6
	vcvtsi2ss	%rdx, %xmm15, %xmm13
	vinsertps	$32, %xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0,1],xmm0[0],xmm1[3]
	vinsertps	$48, %xmm6, %xmm7, %xmm1 # xmm1 = xmm7[0,1,2],xmm6[0]
	vinsertps	$48, %xmm13, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2],xmm13[0]
	vextracti128	$1, %ymm5, %xmm6
	vpackssdw	%xmm6, %xmm5, %xmm8
	vaddps	%xmm1, %xmm1, %xmm6
	vaddps	%xmm0, %xmm0, %xmm7
	vextracti128	$1, %ymm4, %xmm5
	vpackssdw	%xmm5, %xmm4, %xmm4
	vblendvps	%xmm4, %xmm7, %xmm0, %xmm0
	vblendvps	%xmm8, %xmm6, %xmm1, %xmm1
	vmovups	%xmm0, 262144(%r15,%rax)
	vmovups	%xmm1, 262160(%r15,%rax)
	addq	$32, %rax
	jne	.LBB2_3
# %bb.4:
	movq	%rsp, %rsi
	movl	$1, %edi
	vzeroupper
	callq	clock_gettime@PLT
	movq	(%rsp), %r8
	movq	8(%rsp), %r9
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB2_5:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_6 Depth 2
                                        #       Child Loop BB2_7 Depth 3
                                        #         Child Loop BB2_8 Depth 4
	movq	%r14, %rsi
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB2_6:                                #   Parent Loop BB2_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_7 Depth 3
                                        #         Child Loop BB2_8 Depth 4
	movq	%r11, %rdi
	movq	%r15, %rax
	xorl	%edx, %edx
	shlq	$8, %rdi
	.p2align	4, 0x90
.LBB2_7:                                #   Parent Loop BB2_5 Depth=1
                                        #     Parent Loop BB2_6 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_8 Depth 4
	vxorps	%xmm0, %xmm0, %xmm0
	movq	$-1024, %rbx                    # imm = 0xFC00
	movq	%rax, %rcx
	.p2align	4, 0x90
.LBB2_8:                                #   Parent Loop BB2_5 Depth=1
                                        #     Parent Loop BB2_6 Depth=2
                                        #       Parent Loop BB2_7 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	vmovss	1024(%rsi,%rbx), %xmm1          # xmm1 = mem[0],zero,zero,zero
	vfmadd231ss	(%rcx), %xmm1, %xmm0    # xmm0 = (xmm1 * mem) + xmm0
	addq	$1024, %rcx                     # imm = 0x400
	addq	$4, %rbx
	jne	.LBB2_8
# %bb.9:                                #   in Loop: Header=BB2_7 Depth=3
	leaq	(%rdx,%rdi), %rcx
	addq	$1, %rdx
	addq	$4, %rax
	cmpq	$256, %rdx                      # imm = 0x100
	vmovss	%xmm0, (%r12,%rcx,4)
	jne	.LBB2_7
# %bb.10:                               #   in Loop: Header=BB2_6 Depth=2
	addq	$1, %r11
	addq	$1024, %rsi                     # imm = 0x400
	cmpq	$256, %r11                      # imm = 0x100
	jne	.LBB2_6
# %bb.11:                               #   in Loop: Header=BB2_5 Depth=1
	addl	$1, %r10d
	cmpl	$2000, %r10d                    # imm = 0x7D0
	jne	.LBB2_5
# %bb.12:
	vxorps	%xmm15, %xmm15, %xmm15
	vcvtsi2sd	%r9, %xmm15, %xmm0
	movq	%rsp, %rsi
	movl	$1, %edi
	vdivsd	.LCPI2_5(%rip), %xmm0, %xmm1
	vxorps	%xmm15, %xmm15, %xmm15
	vcvtsi2sd	%r8, %xmm15, %xmm0
	vfmadd231sd	.LCPI2_6(%rip), %xmm0, %xmm1 # xmm1 = (xmm0 * mem) + xmm1
	vmovsd	%xmm1, 16(%rsp)                 # 8-byte Spill
	callq	clock_gettime@PLT
	vxorps	%xmm15, %xmm15, %xmm15
	vcvtsi2sdq	8(%rsp), %xmm15, %xmm0
	leaq	.L.str(%rip), %rdi
	movb	$2, %al
	vdivsd	.LCPI2_5(%rip), %xmm0, %xmm0
	vxorps	%xmm15, %xmm15, %xmm15
	vcvtsi2sdq	(%rsp), %xmm15, %xmm1
	vfmadd231sd	.LCPI2_6(%rip), %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
	vmovss	(%r12), %xmm1                   # xmm1 = mem[0],zero,zero,zero
	vsubsd	16(%rsp), %xmm0, %xmm0          # 8-byte Folded Reload
	vdivsd	.LCPI2_7(%rip), %xmm0, %xmm0
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	callq	printf@PLT
	movq	%r14, %rdi
	callq	free@PLT
	movq	%r15, %rdi
	callq	free@PLT
	movq	%r12, %rdi
	callq	free@PLT
	xorl	%eax, %eax
	addq	$168, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
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
