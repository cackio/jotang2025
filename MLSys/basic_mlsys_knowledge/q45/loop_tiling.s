	.text
	.file	"loop_tiling.c"
	.globl	blur_y                          # -- Begin function blur_y
	.p2align	4, 0x90
	.type	blur_y,@function
blur_y:                                 # @blur_y
	.cfi_startproc
# %bb.0:
	xorl	%r8d, %r8d
	jmp	.LBB0_1
	.p2align	4, 0x90
.LBB0_16:                               #   in Loop: Header=BB0_1 Depth=1
	addq	$1, %r8
	addq	$4, %rdi
	addq	$4, %rsi
	cmpq	$10240, %r8                     # imm = 0x2800
	je	.LBB0_17
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_2 Depth 2
	xorl	%r10d, %r10d
	xorl	%r9d, %r9d
	jmp	.LBB0_2
	.p2align	4, 0x90
.LBB0_15:                               #   in Loop: Header=BB0_2 Depth=2
	movslq	%edx, %rax
	imulq	$954437177, %rax, %rax          # imm = 0x38E38E39
	movq	%rax, %rcx
	sarq	$33, %rax
	shrq	$63, %rcx
	addl	%ecx, %eax
	movl	%eax, (%rsi,%r10)
	addq	$40960, %r10                    # imm = 0xA000
	cmpq	$10240, %r9                     # imm = 0x2800
	je	.LBB0_16
.LBB0_2:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r9, %rax
	addl	$-4, %r9d
	xorl	%edx, %edx
	cmpl	$10240, %r9d                    # imm = 0x2800
	jb	.LBB0_3
# %bb.4:                                #   in Loop: Header=BB0_2 Depth=2
	leal	-3(%rax), %ecx
	cmpl	$10239, %ecx                    # imm = 0x27FF
	jbe	.LBB0_5
.LBB0_6:                                #   in Loop: Header=BB0_2 Depth=2
	leal	-2(%rax), %ecx
	cmpl	$10239, %ecx                    # imm = 0x27FF
	jbe	.LBB0_7
.LBB0_8:                                #   in Loop: Header=BB0_2 Depth=2
	leal	-1(%rax), %ecx
	cmpl	$10239, %ecx                    # imm = 0x27FF
	jbe	.LBB0_9
.LBB0_10:                               #   in Loop: Header=BB0_2 Depth=2
	addl	(%rdi,%r10), %edx
	leaq	1(%rax), %r9
	cmpq	$10238, %rax                    # imm = 0x27FE
	ja	.LBB0_15
	jmp	.LBB0_11
	.p2align	4, 0x90
.LBB0_3:                                #   in Loop: Header=BB0_2 Depth=2
	movl	-163840(%rdi,%r10), %edx
	leal	-3(%rax), %ecx
	cmpl	$10239, %ecx                    # imm = 0x27FF
	ja	.LBB0_6
.LBB0_5:                                #   in Loop: Header=BB0_2 Depth=2
	addl	-122880(%rdi,%r10), %edx
	leal	-2(%rax), %ecx
	cmpl	$10239, %ecx                    # imm = 0x27FF
	ja	.LBB0_8
.LBB0_7:                                #   in Loop: Header=BB0_2 Depth=2
	addl	-81920(%rdi,%r10), %edx
	leal	-1(%rax), %ecx
	cmpl	$10239, %ecx                    # imm = 0x27FF
	ja	.LBB0_10
.LBB0_9:                                #   in Loop: Header=BB0_2 Depth=2
	addl	-40960(%rdi,%r10), %edx
	addl	(%rdi,%r10), %edx
	leaq	1(%rax), %r9
	cmpq	$10238, %rax                    # imm = 0x27FE
	ja	.LBB0_15
.LBB0_11:                               #   in Loop: Header=BB0_2 Depth=2
	addl	40960(%rdi,%r10), %edx
	cmpq	$10238, %rax                    # imm = 0x27FE
	je	.LBB0_15
# %bb.12:                               #   in Loop: Header=BB0_2 Depth=2
	addl	81920(%rdi,%r10), %edx
	cmpq	$10236, %rax                    # imm = 0x27FC
	ja	.LBB0_15
# %bb.13:                               #   in Loop: Header=BB0_2 Depth=2
	addl	122880(%rdi,%r10), %edx
	cmpq	$10236, %rax                    # imm = 0x27FC
	je	.LBB0_15
# %bb.14:                               #   in Loop: Header=BB0_2 Depth=2
	addl	163840(%rdi,%r10), %edx
	jmp	.LBB0_15
.LBB0_17:
	retq
.Lfunc_end0:
	.size	blur_y, .Lfunc_end0-blur_y
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2                               # -- Begin function blur_y_tile_SIMD
.LCPI1_0:
	.long	954437177                       # 0x38e38e39
	.text
	.globl	blur_y_tile_SIMD
	.p2align	4, 0x90
	.type	blur_y_tile_SIMD,@function
blur_y_tile_SIMD:                       # @blur_y_tile_SIMD
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
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	vpbroadcastd	.LCPI1_0(%rip), %ymm11  # ymm11 = [954437177,954437177,954437177,954437177,954437177,954437177,954437177,954437177]
	xorl	%r12d, %r12d
	movq	%rdi, %rbx
	movq	%rsi, %r11
	jmp	.LBB1_1
	.p2align	4, 0x90
.LBB1_19:                               #   in Loop: Header=BB1_1 Depth=1
	movq	-56(%rsp), %r11                 # 8-byte Reload
	movq	-48(%rsp), %rbx                 # 8-byte Reload
	addq	$64, %r11
	addq	$64, %rbx
	cmpq	$10224, %r12                    # imm = 0x27F0
	movq	-64(%rsp), %r12                 # 8-byte Reload
	jae	.LBB1_20
.LBB1_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_2 Depth 2
                                        #       Child Loop BB1_5 Depth 3
	leaq	-40960(%r12), %rcx
	leaq	16(%r12), %rax
	leaq	40976(%r12), %r8
	xorl	%edx, %edx
	movq	%rbx, -48(%rsp)                 # 8-byte Spill
	movq	%r11, -56(%rsp)                 # 8-byte Spill
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	movq	%r12, %rcx
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%r8, -16(%rsp)                  # 8-byte Spill
	orq	$8, %rcx
	movq	%rcx, -40(%rsp)                 # 8-byte Spill
	jmp	.LBB1_2
	.p2align	4, 0x90
.LBB1_21:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	$10236, %rdx                    # imm = 0x27FC
	movq	%rbp, -24(%rsp)                 # 8-byte Spill
	leaq	-30720(%r14,%r14,4), %rcx
	setb	%al
	movl	%eax, -68(%rsp)                 # 4-byte Spill
	setbe	%al
	cmpq	$10238, %rdx                    # imm = 0x27FE
	movl	%eax, -72(%rsp)                 # 4-byte Spill
	setb	%dl
	setbe	%al
	cmpl	$10240, %r10d                   # imm = 0x2800
	setb	%r10b
	cmpl	$10240, %r9d                    # imm = 0x2800
	vmovd	%edx, %xmm7
	vmovd	%eax, %xmm6
	vmovd	-72(%rsp), %xmm4                # 4-byte Folded Reload
                                        # xmm4 = mem[0],zero,zero,zero
	leaq	30720(%r14,%r14,4), %rdx
	setb	%r9b
	cmpl	$10240, %r8d                    # imm = 0x2800
	vmovd	%r10d, %xmm3
	leaq	-10240(%r14,%r14,4), %r10
	setb	%r8b
	cmpl	$10240, %r15d                   # imm = 0x2800
	vmovd	%r9d, %xmm2
	leaq	-20480(%r14,%r14,4), %r15
	leaq	20480(%r14,%r14,4), %r9
	setb	%bpl
	vmovd	%r8d, %xmm1
	vpbroadcastb	%xmm4, %xmm4
	leaq	10240(%r14,%r14,4), %r8
	vmovd	%ebp, %xmm0
	vpbroadcastb	%xmm1, %xmm1
	leaq	-40960(%r14,%r14,4), %rbp
	leaq	40960(%r14,%r14,4), %r14
	vpbroadcastb	%xmm0, %xmm0
	leaq	(%r12,%rbp), %rax
	vpmovzxwd	%xmm0, %ymm0            # ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
	vpslld	$31, %ymm0, %ymm5
	vpmovzxwd	%xmm1, %ymm0            # ymm0 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero,xmm1[4],zero,xmm1[5],zero,xmm1[6],zero,xmm1[7],zero
	vpbroadcastb	%xmm3, %xmm1
	vpslld	$31, %ymm0, %ymm13
	vpbroadcastb	%xmm2, %xmm0
	vpbroadcastb	%xmm7, %xmm2
	vpmaskmovd	(%rdi,%rax,4), %ymm5, %ymm7
	leaq	(%r12,%rcx), %rax
	vpmovzxwd	%xmm1, %ymm1            # ymm1 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero,xmm1[4],zero,xmm1[5],zero,xmm1[6],zero,xmm1[7],zero
	vpmovzxwd	%xmm0, %ymm0            # ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
	vpmaskmovd	(%rdi,%rax,4), %ymm13, %ymm8
	leaq	(%r12,%r15), %rax
	vpslld	$31, %ymm1, %ymm12
	vpslld	$31, %ymm0, %ymm14
	vpbroadcastb	%xmm6, %xmm0
	vmovd	-68(%rsp), %xmm6                # 4-byte Folded Reload
                                        # xmm6 = mem[0],zero,zero,zero
	vpmaskmovd	(%rdi,%rax,4), %ymm14, %ymm9
	leaq	(%r12,%r10), %rax
	vpand	%xmm2, %xmm0, %xmm3
	vpmovzxwd	%xmm0, %ymm1            # ymm1 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
	vpandn	%xmm0, %xmm2, %xmm0
	vpmaskmovd	(%rdi,%rax,4), %ymm12, %ymm10
	vpaddd	%ymm7, %ymm8, %ymm8
	vpand	%xmm4, %xmm3, %xmm7
	leaq	(%r12,%rdx), %rax
	vpslld	$31, %ymm1, %ymm1
	vpmovzxwd	%xmm0, %ymm0            # ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
	vpbroadcastb	%xmm6, %xmm6
	vpand	%xmm6, %xmm7, %xmm6
	vpmovzxwd	%xmm7, %ymm7            # ymm7 = xmm7[0],zero,xmm7[1],zero,xmm7[2],zero,xmm7[3],zero,xmm7[4],zero,xmm7[5],zero,xmm7[6],zero,xmm7[7],zero
	vpmovzxwd	%xmm6, %ymm6            # ymm6 = xmm6[0],zero,xmm6[1],zero,xmm6[2],zero,xmm6[3],zero,xmm6[4],zero,xmm6[5],zero,xmm6[6],zero,xmm6[7],zero
	vpaddd	%ymm10, %ymm9, %ymm9
	vpslld	$31, %ymm7, %ymm7
	vpaddd	%ymm9, %ymm8, %ymm9
	vpmaskmovd	(%rdi,%rax,4), %ymm7, %ymm8
	vpslld	$31, %ymm6, %ymm6
	leaq	(%r12,%r14), %rax
	vpmaskmovd	(%rdi,%rax,4), %ymm6, %ymm10
	leaq	(%r12,%r8), %rax
	vpaddd	%ymm10, %ymm8, %ymm10
	vpmovzxwd	%xmm3, %ymm8            # ymm8 = xmm3[0],zero,xmm3[1],zero,xmm3[2],zero,xmm3[3],zero,xmm3[4],zero,xmm3[5],zero,xmm3[6],zero,xmm3[7],zero
	vpandn	%xmm3, %xmm4, %xmm3
	vpmaskmovd	(%rdi,%rax,4), %ymm1, %ymm4
	leaq	(%r12,%r9), %rax
	vpslld	$31, %ymm8, %ymm8
	vpmovzxwd	%xmm3, %ymm3            # ymm3 = xmm3[0],zero,xmm3[1],zero,xmm3[2],zero,xmm3[3],zero,xmm3[4],zero,xmm3[5],zero,xmm3[6],zero,xmm3[7],zero
	vpmaskmovd	(%rdi,%rax,4), %ymm8, %ymm2
	movq	-24(%rsp), %rax                 # 8-byte Reload
	vpaddd	(%rdi,%rax,4), %ymm9, %ymm15
	vpslld	$31, %ymm3, %ymm9
	vpaddd	%ymm4, %ymm15, %ymm4
	vpaddd	%ymm4, %ymm2, %ymm2
	vpaddd	%ymm2, %ymm10, %ymm3
	vpslld	$31, %ymm0, %ymm10
	vblendvps	%ymm9, %ymm2, %ymm3, %ymm2
	vblendvps	%ymm10, %ymm4, %ymm2, %ymm0
	vblendvps	%ymm1, %ymm0, %ymm15, %ymm0
	vpermilps	$245, %ymm0, %ymm2      # ymm2 = ymm0[1,1,3,3,5,5,7,7]
	vpmuldq	%ymm11, %ymm0, %ymm0
	vpmuldq	%ymm11, %ymm2, %ymm2
	vpshufd	$245, %ymm0, %ymm0              # ymm0 = ymm0[1,1,3,3,5,5,7,7]
	vpblendd	$170, %ymm2, %ymm0, %ymm0       # ymm0 = ymm0[0],ymm2[1],ymm0[2],ymm2[3],ymm0[4],ymm2[5],ymm0[6],ymm2[7]
	vpsrld	$31, %ymm0, %ymm2
	vpsrad	$1, %ymm0, %ymm0
	vpaddd	%ymm2, %ymm0, %ymm0
	vmovdqu	%ymm0, (%rsi,%rax,4)
	movq	-40(%rsp), %rax                 # 8-byte Reload
	addq	%rax, %rbp
	addq	%rax, %rcx
	addq	%rax, %r10
	addq	%rax, %r15
	addq	%rax, %rdx
	addq	%rax, %r14
	addq	%rax, %r13
	addq	%rax, %r8
	addq	%rax, %r9
	vpmaskmovd	(%rdi,%rbp,4), %ymm5, %ymm0
	vpmaskmovd	(%rdi,%rcx,4), %ymm13, %ymm2
	vpmaskmovd	(%rdi,%r10,4), %ymm12, %ymm3
	vpmaskmovd	(%rdi,%r9,4), %ymm8, %ymm4
	vpaddd	%ymm2, %ymm0, %ymm0
	vpmaskmovd	(%rdi,%r15,4), %ymm14, %ymm2
	vpaddd	%ymm3, %ymm2, %ymm2
	vpmaskmovd	(%rdi,%r14,4), %ymm6, %ymm3
	vpaddd	%ymm2, %ymm0, %ymm0
	vpmaskmovd	(%rdi,%rdx,4), %ymm7, %ymm2
	vpaddd	(%rdi,%r13,4), %ymm0, %ymm0
	vpaddd	%ymm3, %ymm2, %ymm2
	vpmaskmovd	(%rdi,%r8,4), %ymm1, %ymm3
	vpaddd	%ymm0, %ymm3, %ymm3
	vpaddd	%ymm3, %ymm4, %ymm4
	vpaddd	%ymm2, %ymm4, %ymm2
	vblendvps	%ymm9, %ymm4, %ymm2, %ymm2
	vblendvps	%ymm10, %ymm3, %ymm2, %ymm2
	vblendvps	%ymm1, %ymm2, %ymm0, %ymm0
	vpermilps	$245, %ymm0, %ymm1      # ymm1 = ymm0[1,1,3,3,5,5,7,7]
	vpmuldq	%ymm11, %ymm0, %ymm0
	vpmuldq	%ymm11, %ymm1, %ymm1
	vpshufd	$245, %ymm0, %ymm0              # ymm0 = ymm0[1,1,3,3,5,5,7,7]
	vpblendd	$170, %ymm1, %ymm0, %ymm0       # ymm0 = ymm0[0],ymm1[1],ymm0[2],ymm1[3],ymm0[4],ymm1[5],ymm0[6],ymm1[7]
	vpsrld	$31, %ymm0, %ymm1
	vpsrad	$1, %ymm0, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vmovdqu	%ymm0, (%rsi,%r13,4)
.LBB1_22:                               #   in Loop: Header=BB1_2 Depth=2
	movq	-8(%rsp), %rdx                  # 8-byte Reload
	addq	$40960, %r11                    # imm = 0xA000
	addq	$40960, %rbx                    # imm = 0xA000
	cmpq	$10240, %rdx                    # imm = 0x2800
	je	.LBB1_19
.LBB1_2:                                #   Parent Loop BB1_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_5 Depth 3
	movq	%rdx, %r14
	movq	-16(%rsp), %rcx                 # 8-byte Reload
	leaq	1(%rdx), %rax
	leal	-4(%rdx), %r15d
	leal	-3(%rdx), %r8d
	leal	-2(%rdx), %r9d
	leal	-1(%rdx), %r10d
	shlq	$11, %r14
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	leaq	(%r14,%r14,4), %r13
	leaq	(%rcx,%r13), %rax
	leaq	(%r12,%r13), %rbp
	leaq	(%rdi,%rax,4), %rax
	leaq	(%rsi,%rbp,4), %rcx
	cmpq	%rax, %rcx
	jae	.LBB1_21
# %bb.3:                                #   in Loop: Header=BB1_2 Depth=2
	movq	-32(%rsp), %rax                 # 8-byte Reload
	movq	-64(%rsp), %rcx                 # 8-byte Reload
	addq	%r13, %rax
	addq	%r13, %rcx
	leaq	(%rdi,%rax,4), %rax
	leaq	(%rsi,%rcx,4), %rcx
	cmpq	%rcx, %rax
	jae	.LBB1_21
# %bb.4:                                #   in Loop: Header=BB1_2 Depth=2
	xorl	%eax, %eax
	jmp	.LBB1_5
	.p2align	4, 0x90
.LBB1_18:                               #   in Loop: Header=BB1_5 Depth=3
	movslq	%ecx, %rcx
	imulq	$954437177, %rcx, %rcx          # imm = 0x38E38E39
	movq	%rcx, %rbp
	sarq	$33, %rcx
	shrq	$63, %rbp
	addl	%ebp, %ecx
	movl	%ecx, (%r11,%rax,4)
	addq	$1, %rax
	cmpq	$16, %rax
	je	.LBB1_22
.LBB1_5:                                #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	xorl	%ecx, %ecx
	cmpl	$10240, %r15d                   # imm = 0x2800
	jb	.LBB1_6
# %bb.7:                                #   in Loop: Header=BB1_5 Depth=3
	cmpl	$10239, %r8d                    # imm = 0x27FF
	jbe	.LBB1_8
.LBB1_9:                                #   in Loop: Header=BB1_5 Depth=3
	cmpl	$10239, %r9d                    # imm = 0x27FF
	jbe	.LBB1_10
.LBB1_11:                               #   in Loop: Header=BB1_5 Depth=3
	cmpl	$10239, %r10d                   # imm = 0x27FF
	jbe	.LBB1_12
.LBB1_13:                               #   in Loop: Header=BB1_5 Depth=3
	addl	(%rbx,%rax,4), %ecx
	cmpq	$10238, %rdx                    # imm = 0x27FE
	ja	.LBB1_18
	jmp	.LBB1_14
	.p2align	4, 0x90
.LBB1_6:                                #   in Loop: Header=BB1_5 Depth=3
	movl	-163840(%rbx,%rax,4), %ecx
	cmpl	$10239, %r8d                    # imm = 0x27FF
	ja	.LBB1_9
.LBB1_8:                                #   in Loop: Header=BB1_5 Depth=3
	addl	-122880(%rbx,%rax,4), %ecx
	cmpl	$10239, %r9d                    # imm = 0x27FF
	ja	.LBB1_11
.LBB1_10:                               #   in Loop: Header=BB1_5 Depth=3
	addl	-81920(%rbx,%rax,4), %ecx
	cmpl	$10239, %r10d                   # imm = 0x27FF
	ja	.LBB1_13
.LBB1_12:                               #   in Loop: Header=BB1_5 Depth=3
	addl	-40960(%rbx,%rax,4), %ecx
	addl	(%rbx,%rax,4), %ecx
	cmpq	$10238, %rdx                    # imm = 0x27FE
	ja	.LBB1_18
.LBB1_14:                               #   in Loop: Header=BB1_5 Depth=3
	addl	40960(%rbx,%rax,4), %ecx
	cmpq	$10237, %rdx                    # imm = 0x27FD
	ja	.LBB1_18
# %bb.15:                               #   in Loop: Header=BB1_5 Depth=3
	addl	81920(%rbx,%rax,4), %ecx
	cmpq	$10236, %rdx                    # imm = 0x27FC
	ja	.LBB1_18
# %bb.16:                               #   in Loop: Header=BB1_5 Depth=3
	addl	122880(%rbx,%rax,4), %ecx
	cmpq	$10235, %rdx                    # imm = 0x27FB
	ja	.LBB1_18
# %bb.17:                               #   in Loop: Header=BB1_5 Depth=3
	addl	163840(%rbx,%rax,4), %ecx
	jmp	.LBB1_18
.LBB1_20:
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
	vzeroupper
	retq
.Lfunc_end1:
	.size	blur_y_tile_SIMD, .Lfunc_end1-blur_y_tile_SIMD
	.cfi_endproc
                                        # -- End function
	.globl	blur_y_tile_SIMD_threads        # -- Begin function blur_y_tile_SIMD_threads
	.p2align	4, 0x90
	.type	blur_y_tile_SIMD_threads,@function
blur_y_tile_SIMD_threads:               # @blur_y_tile_SIMD_threads
	.cfi_startproc
# %bb.0:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, 16(%rsp)
	movq	%rsi, 8(%rsp)
	leaq	.L__unnamed_1(%rip), %rdi
	leaq	.omp_outlined.(%rip), %rdx
	leaq	16(%rsp), %rcx
	leaq	8(%rsp), %r8
	movl	$2, %esi
	xorl	%eax, %eax
	callq	__kmpc_fork_call@PLT
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	blur_y_tile_SIMD_threads, .Lfunc_end2-blur_y_tile_SIMD_threads
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function .omp_outlined.
	.type	.omp_outlined.,@function
.omp_outlined.:                         # @.omp_outlined.
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	(%rdi), %ebx
	leaq	.L__unnamed_1(%rip), %rbp
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, %r12
	movl	$1073741859, %edx               # imm = 0x40000023
	xorl	%ecx, %ecx
	movl	$639, %r8d                      # imm = 0x27F
	movl	$1, %r9d
	movl	$0, 20(%rsp)
	movl	$639, 16(%rsp)                  # imm = 0x27F
	movl	$1, 28(%rsp)
	movl	$0, 24(%rsp)
	movl	$1, (%rsp)
	movq	%rbp, %rdi
	movl	%ebx, %esi
	callq	__kmpc_dispatch_init_4@PLT
	leaq	24(%rsp), %rdx
	leaq	20(%rsp), %rcx
	leaq	16(%rsp), %r8
	leaq	28(%rsp), %r9
	movq	%rbp, %rdi
	movl	%ebx, %esi
	movl	%ebx, 32(%rsp)                  # 4-byte Spill
	jmp	.LBB3_1
	.p2align	4, 0x90
.LBB3_24:                               #   in Loop: Header=BB3_1 Depth=1
	movl	32(%rsp), %esi                  # 4-byte Reload
	leaq	.L__unnamed_1(%rip), %rdi
	leaq	24(%rsp), %rdx
	leaq	20(%rsp), %rcx
	leaq	16(%rsp), %r8
	leaq	28(%rsp), %r9
.LBB3_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_4 Depth 2
                                        #       Child Loop BB3_6 Depth 3
                                        #         Child Loop BB3_20 Depth 4
	callq	__kmpc_dispatch_next_4@PLT
	testl	%eax, %eax
	je	.LBB3_25
# %bb.2:                                #   in Loop: Header=BB3_1 Depth=1
	movslq	20(%rsp), %rsi
	movl	16(%rsp), %eax
	cmpl	%eax, %esi
	jg	.LBB3_24
# %bb.3:                                #   in Loop: Header=BB3_1 Depth=1
	movl	%esi, %edx
	shll	$4, %edx
	jmp	.LBB3_4
	.p2align	4, 0x90
.LBB3_22:                               #   in Loop: Header=BB3_4 Depth=2
	movl	16(%rsp), %eax
	movq	48(%rsp), %rsi                  # 8-byte Reload
	movl	36(%rsp), %edx                  # 4-byte Reload
.LBB3_23:                               #   in Loop: Header=BB3_4 Depth=2
	movslq	%eax, %rcx
	addl	$16, %edx
	cmpq	%rcx, %rsi
	leaq	1(%rsi), %rsi
	jge	.LBB3_24
.LBB3_4:                                #   Parent Loop BB3_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_6 Depth 3
                                        #         Child Loop BB3_20 Depth 4
	cmpq	$639, %rsi                      # imm = 0x27F
	jg	.LBB3_23
# %bb.5:                                #   in Loop: Header=BB3_4 Depth=2
	movl	%esi, %ecx
	movq	40(%rsp), %r8                   # 8-byte Reload
	movq	%rsi, 48(%rsp)                  # 8-byte Spill
	movl	$10240, %esi                    # imm = 0x2800
	movl	$16, %edi
	movslq	%edx, %rax
	movl	%edx, 36(%rsp)                  # 4-byte Spill
	shll	$4, %ecx
	leaq	(,%rax,4), %rdx
	subl	%ecx, %esi
	movq	(%r8), %rcx
	cmpl	$16, %esi
	cmovgel	%edi, %esi
	xorl	%ebp, %ebp
	movslq	%esi, %r11
	leaq	(%rcx,%rax,4), %r8
	jmp	.LBB3_6
	.p2align	4, 0x90
.LBB3_21:                               #   in Loop: Header=BB3_6 Depth=3
	addq	$40960, %r8                     # imm = 0xA000
	addq	$40960, %rdx                    # imm = 0xA000
	cmpq	$10240, %r10                    # imm = 0x2800
	movq	%r10, %rbp
	je	.LBB3_22
.LBB3_6:                                #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_4 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB3_20 Depth 4
	leal	-4(%rbp), %r9d
	leal	-3(%rbp), %eax
	leal	-2(%rbp), %ebx
	leal	-1(%rbp), %esi
	leaq	1(%rbp), %r10
	xorl	%r15d, %r15d
	jmp	.LBB3_20
	.p2align	4, 0x90
.LBB3_19:                               #   in Loop: Header=BB3_20 Depth=4
	movslq	%r13d, %rdi
	imulq	$954437177, %rdi, %rdi          # imm = 0x38E38E39
	movq	%rdi, %rcx
	sarq	$33, %rdi
	shrq	$63, %rcx
	addl	%ecx, %edi
	movl	%edi, (%r8,%r15,4)
	addq	$1, %r15
	cmpq	%r11, %r15
	jge	.LBB3_21
.LBB3_20:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_4 Depth=2
                                        #       Parent Loop BB3_6 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	(%r12), %r14
	xorl	%r13d, %r13d
	cmpl	$10240, %r9d                    # imm = 0x2800
	jae	.LBB3_8
# %bb.7:                                #   in Loop: Header=BB3_20 Depth=4
	leaq	(%r14,%rdx), %rdi
	movl	-163840(%rdi,%r15,4), %r13d
.LBB3_8:                                #   in Loop: Header=BB3_20 Depth=4
	cmpl	$10239, %eax                    # imm = 0x27FF
	jbe	.LBB3_9
# %bb.10:                               #   in Loop: Header=BB3_20 Depth=4
	cmpl	$10239, %ebx                    # imm = 0x27FF
	jbe	.LBB3_11
.LBB3_12:                               #   in Loop: Header=BB3_20 Depth=4
	cmpl	$10239, %esi                    # imm = 0x27FF
	jbe	.LBB3_13
.LBB3_14:                               #   in Loop: Header=BB3_20 Depth=4
	addq	%rdx, %r14
	addl	(%r14,%r15,4), %r13d
	cmpq	$10238, %rbp                    # imm = 0x27FE
	ja	.LBB3_19
	jmp	.LBB3_15
	.p2align	4, 0x90
.LBB3_9:                                #   in Loop: Header=BB3_20 Depth=4
	leaq	(%r14,%rdx), %rdi
	addl	-122880(%rdi,%r15,4), %r13d
	cmpl	$10239, %ebx                    # imm = 0x27FF
	ja	.LBB3_12
.LBB3_11:                               #   in Loop: Header=BB3_20 Depth=4
	leaq	(%r14,%rdx), %rdi
	addl	-81920(%rdi,%r15,4), %r13d
	cmpl	$10239, %esi                    # imm = 0x27FF
	ja	.LBB3_14
.LBB3_13:                               #   in Loop: Header=BB3_20 Depth=4
	leaq	(%r14,%rdx), %rdi
	addl	-40960(%rdi,%r15,4), %r13d
	addq	%rdx, %r14
	addl	(%r14,%r15,4), %r13d
	cmpq	$10238, %rbp                    # imm = 0x27FE
	ja	.LBB3_19
.LBB3_15:                               #   in Loop: Header=BB3_20 Depth=4
	addl	40960(%r14,%r15,4), %r13d
	cmpq	$10237, %rbp                    # imm = 0x27FD
	ja	.LBB3_19
# %bb.16:                               #   in Loop: Header=BB3_20 Depth=4
	addl	81920(%r14,%r15,4), %r13d
	cmpq	$10236, %rbp                    # imm = 0x27FC
	ja	.LBB3_19
# %bb.17:                               #   in Loop: Header=BB3_20 Depth=4
	addl	122880(%r14,%r15,4), %r13d
	cmpq	$10235, %rbp                    # imm = 0x27FB
	ja	.LBB3_19
# %bb.18:                               #   in Loop: Header=BB3_20 Depth=4
	addl	163840(%r14,%r15,4), %r13d
	jmp	.LBB3_19
.LBB3_25:
	addq	$56, %rsp
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
.Lfunc_end3:
	.size	.omp_outlined., .Lfunc_end3-.omp_outlined.
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2                               # -- Begin function blur_y_tile_SIMD_lessif
.LCPI4_0:
	.long	954437177                       # 0x38e38e39
	.text
	.globl	blur_y_tile_SIMD_lessif
	.p2align	4, 0x90
	.type	blur_y_tile_SIMD_lessif,@function
blur_y_tile_SIMD_lessif:                # @blur_y_tile_SIMD_lessif
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
	vpbroadcastd	.LCPI4_0(%rip), %ymm0   # ymm0 = [954437177,954437177,954437177,954437177,954437177,954437177,954437177,954437177]
	leaq	163840(%rsi), %rcx
	leaq	327680(%rdi), %rax
	leaq	419266560(%rsi), %rdx
	movq	%rsi, %r11
	xorl	%r15d, %r15d
	movq	%rsi, %r10
	movq	%rsi, -120(%rsp)                # 8-byte Spill
	movq	%rcx, -72(%rsp)                 # 8-byte Spill
	leaq	419389440(%rdi), %rcx
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	movq	%rcx, -88(%rsp)                 # 8-byte Spill
	movq	%rdi, %rcx
	jmp	.LBB4_1
	.p2align	4, 0x90
.LBB4_29:                               #   in Loop: Header=BB4_1 Depth=1
	movq	-48(%rsp), %r10                 # 8-byte Reload
	movq	-40(%rsp), %rcx                 # 8-byte Reload
	addq	$64, -64(%rsp)                  # 8-byte Folded Spill
	addq	$64, -72(%rsp)                  # 8-byte Folded Spill
	addq	$64, -80(%rsp)                  # 8-byte Folded Spill
	addq	$64, -88(%rsp)                  # 8-byte Folded Spill
	addq	$64, %r10
	addq	$64, %rcx
	cmpq	$10224, %r15                    # imm = 0x27F0
	movq	-56(%rsp), %r15                 # 8-byte Reload
	jae	.LBB4_30
.LBB4_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_2 Depth 2
                                        #       Child Loop BB4_5 Depth 3
                                        #     Child Loop BB4_15 Depth 2
                                        #       Child Loop BB4_18 Depth 3
                                        #     Child Loop BB4_21 Depth 2
                                        #       Child Loop BB4_24 Depth 3
	leaq	-30720(%r15), %rdx
	leaq	40976(%r15), %rsi
	leaq	16(%r15), %rax
	xorl	%r14d, %r14d
	movq	%rcx, -40(%rsp)                 # 8-byte Spill
	movq	%r10, -48(%rsp)                 # 8-byte Spill
	movq	%r15, -128(%rsp)                # 8-byte Spill
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	leaq	40960(%r15), %rdx
	movq	%rsi, -112(%rsp)                # 8-byte Spill
	leaq	81936(%r15), %rsi
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	%rdx, (%rsp)                    # 8-byte Spill
	leaq	104816640(%r15), %rdx
	movq	%rsi, -8(%rsp)                  # 8-byte Spill
	leaq	104816656(%r15), %rsi
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	leaq	104775680(%r15), %rdx
	movq	%rsi, -16(%rsp)                 # 8-byte Spill
	leaq	104847376(%r15), %rsi
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	movq	%r15, %rdx
	movq	%rsi, 8(%rsp)                   # 8-byte Spill
	orq	$8, %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	jmp	.LBB4_2
	.p2align	4, 0x90
.LBB4_12:                               #   in Loop: Header=BB4_2 Depth=2
	cmpl	$10240, %r12d                   # imm = 0x2800
	movq	-128(%rsp), %rdx                # 8-byte Reload
	leaq	-30720(%rsi,%rsi,4), %rbx
	leaq	-20480(%rsi,%rsi,4), %r15
	movq	%r14, -104(%rsp)                # 8-byte Spill
	leaq	30720(%rsi,%rsi,4), %r12
	leaq	40960(%rsi,%rsi,4), %r14
	setb	%r8b
	cmpl	$10240, %ebp                    # imm = 0x2800
	setb	%bpl
	cmpl	$10240, %eax                    # imm = 0x2800
	vmovd	%r8d, %xmm3
	leaq	20480(%rsi,%rsi,4), %r8
	setb	%al
	leaq	(%rdx,%rbx), %r11
	movq	-128(%rsp), %rdx                # 8-byte Reload
	vmovd	%ebp, %xmm2
	leaq	10240(%rsi,%rsi,4), %rbp
	vpbroadcastb	%xmm3, %xmm4
	vmovd	%eax, %xmm1
	vpbroadcastb	%xmm2, %xmm2
	leaq	-10240(%rsi,%rsi,4), %rax
	vpbroadcastb	%xmm1, %xmm1
	vpmovzxwd	%xmm2, %ymm2            # ymm2 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero,xmm2[4],zero,xmm2[5],zero,xmm2[6],zero,xmm2[7],zero
	vpmovzxwd	%xmm1, %ymm1            # ymm1 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero,xmm1[4],zero,xmm1[5],zero,xmm1[6],zero,xmm1[7],zero
	leaq	(%rdx,%r15), %rsi
	movq	-128(%rsp), %rdx                # 8-byte Reload
	vpslld	$31, %ymm2, %ymm3
	vpmovzxwd	%xmm4, %ymm2            # ymm2 = xmm4[0],zero,xmm4[1],zero,xmm4[2],zero,xmm4[3],zero,xmm4[4],zero,xmm4[5],zero,xmm4[6],zero,xmm4[7],zero
	vpslld	$31, %ymm1, %ymm1
	vpmaskmovd	(%rdi,%rsi,4), %ymm3, %ymm5
	vpslld	$31, %ymm2, %ymm2
	vpmaskmovd	(%rdi,%r11,4), %ymm1, %ymm4
	movq	-120(%rsp), %r11                # 8-byte Reload
	leaq	(%rdx,%rax), %rsi
	movq	-128(%rsp), %rdx                # 8-byte Reload
	vpaddd	%ymm5, %ymm4, %ymm4
	vpmaskmovd	(%rdi,%rsi,4), %ymm2, %ymm5
	leaq	(%rdx,%rbp), %rsi
	movq	-128(%rsp), %rdx                # 8-byte Reload
	vpaddd	%ymm5, %ymm4, %ymm4
	vpaddd	(%rdi,%r9,4), %ymm4, %ymm4
	vpaddd	(%rdi,%rsi,4), %ymm4, %ymm4
	leaq	(%rdx,%r8), %rsi
	movq	-128(%rsp), %rdx                # 8-byte Reload
	vpaddd	(%rdi,%rsi,4), %ymm4, %ymm4
	leaq	(%rdx,%r12), %rsi
	movq	-96(%rsp), %rdx                 # 8-byte Reload
	vpaddd	(%rdi,%rsi,4), %ymm4, %ymm4
	movq	-128(%rsp), %rsi                # 8-byte Reload
	addq	%rdx, %rbx
	addq	%rdx, %r15
	addq	%rdx, %rax
	addq	%rdx, %r13
	addq	%rdx, %rbp
	addq	%rdx, %r8
	addq	%rdx, %r12
	addq	%r14, %rsi
	addq	%rdx, %r14
	vpaddd	(%rdi,%rsi,4), %ymm4, %ymm4
	vpshufd	$245, %ymm4, %ymm5              # ymm5 = ymm4[1,1,3,3,5,5,7,7]
	vpmuldq	%ymm0, %ymm4, %ymm4
	vpmuldq	%ymm0, %ymm5, %ymm5
	vpshufd	$245, %ymm4, %ymm4              # ymm4 = ymm4[1,1,3,3,5,5,7,7]
	vpblendd	$170, %ymm5, %ymm4, %ymm4       # ymm4 = ymm4[0],ymm5[1],ymm4[2],ymm5[3],ymm4[4],ymm5[5],ymm4[6],ymm5[7]
	vpsrld	$31, %ymm4, %ymm5
	vpsrad	$1, %ymm4, %ymm4
	vpaddd	%ymm5, %ymm4, %ymm4
	vmovdqu	%ymm4, (%r11,%r9,4)
	vpmaskmovd	(%rdi,%r15,4), %ymm3, %ymm3
	vpmaskmovd	(%rdi,%rbx,4), %ymm1, %ymm1
	vpmaskmovd	(%rdi,%rax,4), %ymm2, %ymm2
	movq	-128(%rsp), %r15                # 8-byte Reload
	vpaddd	%ymm3, %ymm1, %ymm1
	vpaddd	%ymm2, %ymm1, %ymm1
	vpaddd	(%rdi,%r13,4), %ymm1, %ymm1
	vpaddd	(%rdi,%rbp,4), %ymm1, %ymm1
	vpaddd	(%rdi,%r8,4), %ymm1, %ymm1
	vpaddd	(%rdi,%r12,4), %ymm1, %ymm1
	vpaddd	(%rdi,%r14,4), %ymm1, %ymm1
	movq	-104(%rsp), %r14                # 8-byte Reload
	vpshufd	$245, %ymm1, %ymm2              # ymm2 = ymm1[1,1,3,3,5,5,7,7]
	vpmuldq	%ymm0, %ymm1, %ymm1
	vpmuldq	%ymm0, %ymm2, %ymm2
	vpshufd	$245, %ymm1, %ymm1              # ymm1 = ymm1[1,1,3,3,5,5,7,7]
	vpblendd	$170, %ymm2, %ymm1, %ymm1       # ymm1 = ymm1[0],ymm2[1],ymm1[2],ymm2[3],ymm1[4],ymm2[5],ymm1[6],ymm2[7]
	vpsrld	$31, %ymm1, %ymm2
	vpsrad	$1, %ymm1, %ymm1
	vpaddd	%ymm2, %ymm1, %ymm1
	vmovdqu	%ymm1, (%r11,%r13,4)
.LBB4_13:                               #   in Loop: Header=BB4_2 Depth=2
	addq	$40960, %r10                    # imm = 0xA000
	addq	$40960, %rcx                    # imm = 0xA000
	cmpq	$4, %r14
	je	.LBB4_14
.LBB4_2:                                #   Parent Loop BB4_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_5 Depth 3
	movq	%r14, %rsi
	movq	-112(%rsp), %rdx                # 8-byte Reload
	leal	-3(%r14), %eax
	leal	-2(%r14), %ebp
	leal	-1(%r14), %r12d
	addq	$1, %r14
	shlq	$11, %rsi
	leaq	(%rsi,%rsi,4), %r13
	leaq	(%rdx,%r13), %rbx
	leaq	(%r15,%r13), %r9
	leaq	(%rdi,%rbx,4), %r8
	leaq	(%r11,%r9,4), %rdx
	cmpq	%r8, %rdx
	jae	.LBB4_12
# %bb.3:                                #   in Loop: Header=BB4_2 Depth=2
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	leaq	(%rdx,%r13), %rbx
	leaq	(%rdi,%rbx,4), %r8
	movq	-56(%rsp), %rbx                 # 8-byte Reload
	addq	%r13, %rbx
	leaq	(%r11,%rbx,4), %rbx
	cmpq	%rbx, %r8
	jae	.LBB4_12
# %bb.4:                                #   in Loop: Header=BB4_2 Depth=2
	xorl	%esi, %esi
	jmp	.LBB4_5
	.p2align	4, 0x90
.LBB4_11:                               #   in Loop: Header=BB4_5 Depth=3
	addl	(%rcx,%rsi,4), %ebx
	addl	40960(%rcx,%rsi,4), %ebx
	addl	81920(%rcx,%rsi,4), %ebx
	addl	122880(%rcx,%rsi,4), %ebx
	addl	163840(%rcx,%rsi,4), %ebx
	movslq	%ebx, %rbx
	imulq	$954437177, %rbx, %rbx          # imm = 0x38E38E39
	movq	%rbx, %rdx
	sarq	$33, %rbx
	shrq	$63, %rdx
	addl	%edx, %ebx
	movl	%ebx, (%r10,%rsi,4)
	addq	$1, %rsi
	cmpq	$16, %rsi
	je	.LBB4_13
.LBB4_5:                                #   Parent Loop BB4_1 Depth=1
                                        #     Parent Loop BB4_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	xorl	%ebx, %ebx
	cmpl	$10240, %eax                    # imm = 0x2800
	jb	.LBB4_6
# %bb.7:                                #   in Loop: Header=BB4_5 Depth=3
	cmpl	$10239, %ebp                    # imm = 0x27FF
	jbe	.LBB4_8
.LBB4_9:                                #   in Loop: Header=BB4_5 Depth=3
	cmpl	$10239, %r12d                   # imm = 0x27FF
	ja	.LBB4_11
	jmp	.LBB4_10
	.p2align	4, 0x90
.LBB4_6:                                #   in Loop: Header=BB4_5 Depth=3
	movl	-122880(%rcx,%rsi,4), %ebx
	cmpl	$10239, %ebp                    # imm = 0x27FF
	ja	.LBB4_9
.LBB4_8:                                #   in Loop: Header=BB4_5 Depth=3
	addl	-81920(%rcx,%rsi,4), %ebx
	cmpl	$10239, %r12d                   # imm = 0x27FF
	ja	.LBB4_11
.LBB4_10:                               #   in Loop: Header=BB4_5 Depth=3
	addl	-40960(%rcx,%rsi,4), %ebx
	jmp	.LBB4_11
	.p2align	4, 0x90
.LBB4_14:                               #   in Loop: Header=BB4_1 Depth=1
	movq	-72(%rsp), %rcx                 # 8-byte Reload
	movq	-64(%rsp), %rdx                 # 8-byte Reload
	movl	$4, %ebp
	xorl	%r14d, %r14d
	jmp	.LBB4_15
	.p2align	4, 0x90
.LBB4_33:                               #   in Loop: Header=BB4_15 Depth=2
	shlq	$11, %rbp
	movq	%r8, -104(%rsp)                 # 8-byte Spill
	movq	-128(%rsp), %rbx                # 8-byte Reload
	leaq	-40960(%rbp,%rbp,4), %r11
	leaq	(%rbp,%rbp,4), %r9
	leaq	-30720(%rbp,%rbp,4), %r15
	leaq	-20480(%rbp,%rbp,4), %r8
	leaq	-10240(%rbp,%rbp,4), %rax
	leaq	10240(%rbp,%rbp,4), %rsi
	leaq	20480(%rbp,%rbp,4), %r10
	leaq	30720(%rbp,%rbp,4), %r13
	leaq	40960(%rbp,%rbp,4), %r12
	movq	-128(%rsp), %rbp                # 8-byte Reload
	leaq	(%rbx,%r11), %rbx
	leaq	(%rbp,%r15), %rbp
	vmovdqu	(%rdi,%rbp,4), %ymm1
	vpaddd	(%rdi,%rbx,4), %ymm1, %ymm1
	movq	-128(%rsp), %rbx                # 8-byte Reload
	movq	-128(%rsp), %rbp                # 8-byte Reload
	leaq	(%rbx,%r8), %rbx
	leaq	(%rbp,%rsi), %rbp
	vpaddd	(%rdi,%rbx,4), %ymm1, %ymm1
	movq	-128(%rsp), %rbx                # 8-byte Reload
	leaq	(%rbx,%rax), %rbx
	vpaddd	(%rdi,%rbx,4), %ymm1, %ymm1
	movq	-128(%rsp), %rbx                # 8-byte Reload
	leaq	(%rbx,%r9), %rbx
	vpaddd	(%rdi,%rbx,4), %ymm1, %ymm1
	vpaddd	(%rdi,%rbp,4), %ymm1, %ymm1
	movq	-128(%rsp), %rbp                # 8-byte Reload
	leaq	(%rbp,%r10), %rbp
	vpaddd	(%rdi,%rbp,4), %ymm1, %ymm1
	movq	-128(%rsp), %rbp                # 8-byte Reload
	leaq	(%rbp,%r13), %rbp
	vpaddd	(%rdi,%rbp,4), %ymm1, %ymm1
	movq	-128(%rsp), %rbp                # 8-byte Reload
	leaq	(%rbp,%r12), %rbp
	vpaddd	(%rdi,%rbp,4), %ymm1, %ymm1
	movq	-120(%rsp), %rbp                # 8-byte Reload
	vpshufd	$245, %ymm1, %ymm2              # ymm2 = ymm1[1,1,3,3,5,5,7,7]
	vpmuldq	%ymm0, %ymm1, %ymm1
	vpmuldq	%ymm0, %ymm2, %ymm2
	vpshufd	$245, %ymm1, %ymm1              # ymm1 = ymm1[1,1,3,3,5,5,7,7]
	vpblendd	$170, %ymm2, %ymm1, %ymm1       # ymm1 = ymm1[0],ymm2[1],ymm1[2],ymm2[3],ymm1[4],ymm2[5],ymm1[6],ymm2[7]
	vpsrld	$31, %ymm1, %ymm2
	vpsrad	$1, %ymm1, %ymm1
	vpaddd	%ymm2, %ymm1, %ymm1
	vmovdqu	%ymm1, (%rbp,%rbx,4)
	movq	-96(%rsp), %rbp                 # 8-byte Reload
	addq	%rbp, %r15
	addq	%rbp, %r11
	addq	%rbp, %r8
	addq	%rbp, %rax
	addq	%rbp, %r9
	addq	%rbp, %rsi
	addq	%rbp, %r10
	addq	%rbp, %r13
	addq	%rbp, %r12
	vmovdqu	(%rdi,%r15,4), %ymm1
	vpaddd	(%rdi,%r11,4), %ymm1, %ymm1
	movq	-120(%rsp), %r11                # 8-byte Reload
	movq	-128(%rsp), %r15                # 8-byte Reload
	vpaddd	(%rdi,%r8,4), %ymm1, %ymm1
	movq	-104(%rsp), %r8                 # 8-byte Reload
	vpaddd	(%rdi,%rax,4), %ymm1, %ymm1
	vpaddd	(%rdi,%r9,4), %ymm1, %ymm1
	vpaddd	(%rdi,%rsi,4), %ymm1, %ymm1
	vpaddd	(%rdi,%r10,4), %ymm1, %ymm1
	vpaddd	(%rdi,%r13,4), %ymm1, %ymm1
	vpaddd	(%rdi,%r12,4), %ymm1, %ymm1
	vpshufd	$245, %ymm1, %ymm2              # ymm2 = ymm1[1,1,3,3,5,5,7,7]
	vpmuldq	%ymm0, %ymm1, %ymm1
	vpmuldq	%ymm0, %ymm2, %ymm2
	vpshufd	$245, %ymm1, %ymm1              # ymm1 = ymm1[1,1,3,3,5,5,7,7]
	vpblendd	$170, %ymm2, %ymm1, %ymm1       # ymm1 = ymm1[0],ymm2[1],ymm1[2],ymm2[3],ymm1[4],ymm2[5],ymm1[6],ymm2[7]
	vpsrld	$31, %ymm1, %ymm2
	vpsrad	$1, %ymm1, %ymm1
	vpaddd	%ymm2, %ymm1, %ymm1
	vmovdqu	%ymm1, (%r11,%r9,4)
.LBB4_19:                               #   in Loop: Header=BB4_15 Depth=2
	addq	$1, %r14
	addq	$40960, %rdx                    # imm = 0xA000
	addq	$40960, %rcx                    # imm = 0xA000
	cmpq	$10236, %r8                     # imm = 0x27FC
	movq	%r8, %rbp
	je	.LBB4_20
.LBB4_15:                               #   Parent Loop BB4_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_18 Depth 3
	movq	%r14, %rax
	movq	-8(%rsp), %rsi                  # 8-byte Reload
	movq	(%rsp), %rbx                    # 8-byte Reload
	leaq	1(%rbp), %r8
	shlq	$11, %rax
	leaq	(%rax,%rax,4), %rax
	addq	%rax, %rsi
	addq	%rax, %rbx
	leaq	(%rdi,%rsi,4), %rsi
	leaq	(%r11,%rbx,4), %rbx
	cmpq	%rsi, %rbx
	jae	.LBB4_33
# %bb.16:                               #   in Loop: Header=BB4_15 Depth=2
	leaq	(%r15,%rax), %rsi
	addq	-112(%rsp), %rax                # 8-byte Folded Reload
	leaq	(%rdi,%rsi,4), %rsi
	leaq	(%r11,%rax,4), %rax
	cmpq	%rax, %rsi
	jae	.LBB4_33
# %bb.17:                               #   in Loop: Header=BB4_15 Depth=2
	movq	$-16, %rax
	.p2align	4, 0x90
.LBB4_18:                               #   Parent Loop BB4_1 Depth=1
                                        #     Parent Loop BB4_15 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-286656(%rdx,%rax,4), %esi
	addl	-327616(%rdx,%rax,4), %esi
	addl	-245696(%rdx,%rax,4), %esi
	addl	-204736(%rdx,%rax,4), %esi
	addl	-163776(%rdx,%rax,4), %esi
	addl	-122816(%rdx,%rax,4), %esi
	addl	-81856(%rdx,%rax,4), %esi
	addl	-40896(%rdx,%rax,4), %esi
	addl	64(%rdx,%rax,4), %esi
	movslq	%esi, %rsi
	imulq	$954437177, %rsi, %rsi          # imm = 0x38E38E39
	movq	%rsi, %rbp
	sarq	$33, %rsi
	shrq	$63, %rbp
	addl	%ebp, %esi
	movl	%esi, 64(%rcx,%rax,4)
	incq	%rax
	jne	.LBB4_18
	jmp	.LBB4_19
	.p2align	4, 0x90
.LBB4_20:                               #   in Loop: Header=BB4_1 Depth=1
	movq	-88(%rsp), %rbx                 # 8-byte Reload
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	movl	$10236, %ebp                    # imm = 0x27FC
	xorl	%r14d, %r14d
	jmp	.LBB4_21
	.p2align	4, 0x90
.LBB4_31:                               #   in Loop: Header=BB4_21 Depth=2
	movq	%rbp, %rdx
	movq	%r8, -112(%rsp)                 # 8-byte Spill
	shlq	$11, %rdx
	cmpq	$10237, %rbp                    # imm = 0x27FD
	setbe	%r15b
	setb	%sil
	cmpq	$10239, %rbp                    # imm = 0x27FF
	leaq	-40960(%rdx,%rdx,4), %rax
	leaq	-30720(%rdx,%rdx,4), %r8
	leaq	(%rdx,%rdx,4), %r9
	leaq	-20480(%rdx,%rdx,4), %r13
	leaq	-10240(%rdx,%rdx,4), %r12
	leaq	10240(%rdx,%rdx,4), %r10
	leaq	30720(%rdx,%rdx,4), %r11
	vmovd	%r15d, %xmm2
	movq	-128(%rsp), %r15                # 8-byte Reload
	setb	%bpl
	vmovd	%ebp, %xmm1
	leaq	20480(%rdx,%rdx,4), %rbp
	vpbroadcastb	%xmm2, %xmm5
	vmovd	%esi, %xmm2
	vpbroadcastb	%xmm2, %xmm3
	vpbroadcastb	%xmm1, %xmm4
	leaq	(%r15,%r8), %rsi
	leaq	(%r15,%rax), %rdx
	vpmovzxwd	%xmm4, %ymm1            # ymm1 = xmm4[0],zero,xmm4[1],zero,xmm4[2],zero,xmm4[3],zero,xmm4[4],zero,xmm4[5],zero,xmm4[6],zero,xmm4[7],zero
	vpand	%xmm5, %xmm4, %xmm7
	vpandn	%xmm4, %xmm5, %xmm4
	vmovdqu	(%rdi,%rsi,4), %ymm2
	vpaddd	(%rdi,%rdx,4), %ymm2, %ymm2
	leaq	(%r15,%r13), %rdx
	vpslld	$31, %ymm1, %ymm1
	leaq	(%r15,%r10), %rsi
	vpand	%xmm3, %xmm7, %xmm3
	vpmovzxwd	%xmm4, %ymm4            # ymm4 = xmm4[0],zero,xmm4[1],zero,xmm4[2],zero,xmm4[3],zero,xmm4[4],zero,xmm4[5],zero,xmm4[6],zero,xmm4[7],zero
	vpaddd	(%rdi,%rdx,4), %ymm2, %ymm2
	leaq	(%r15,%r12), %rdx
	vpmaskmovd	(%rdi,%rsi,4), %ymm1, %ymm8
	vpmovzxwd	%xmm3, %ymm3            # ymm3 = xmm3[0],zero,xmm3[1],zero,xmm3[2],zero,xmm3[3],zero,xmm3[4],zero,xmm3[5],zero,xmm3[6],zero,xmm3[7],zero
	leaq	(%r15,%rbp), %rsi
	vpslld	$31, %ymm4, %ymm4
	vpaddd	(%rdi,%rdx,4), %ymm2, %ymm2
	leaq	(%r15,%r9), %rdx
	vpslld	$31, %ymm3, %ymm3
	vpaddd	(%rdi,%rdx,4), %ymm2, %ymm6
	vpmovzxwd	%xmm7, %ymm2            # ymm2 = xmm7[0],zero,xmm7[1],zero,xmm7[2],zero,xmm7[3],zero,xmm7[4],zero,xmm7[5],zero,xmm7[6],zero,xmm7[7],zero
	vpslld	$31, %ymm2, %ymm2
	vpaddd	%ymm6, %ymm8, %ymm7
	vpmaskmovd	(%rdi,%rsi,4), %ymm2, %ymm8
	leaq	(%r15,%r11), %rsi
	vpmaskmovd	(%rdi,%rsi,4), %ymm3, %ymm5
	movq	-120(%rsp), %rsi                # 8-byte Reload
	vpaddd	%ymm7, %ymm8, %ymm8
	vpaddd	%ymm5, %ymm8, %ymm5
	vblendvps	%ymm4, %ymm7, %ymm5, %ymm5
	vblendvps	%ymm1, %ymm5, %ymm6, %ymm5
	vpermilps	$245, %ymm5, %ymm6      # ymm6 = ymm5[1,1,3,3,5,5,7,7]
	vpmuldq	%ymm0, %ymm5, %ymm5
	vpmuldq	%ymm0, %ymm6, %ymm6
	vpshufd	$245, %ymm5, %ymm5              # ymm5 = ymm5[1,1,3,3,5,5,7,7]
	vpblendd	$170, %ymm6, %ymm5, %ymm5       # ymm5 = ymm5[0],ymm6[1],ymm5[2],ymm6[3],ymm5[4],ymm6[5],ymm5[6],ymm6[7]
	vpsrld	$31, %ymm5, %ymm6
	vpsrad	$1, %ymm5, %ymm5
	vpaddd	%ymm6, %ymm5, %ymm5
	vmovdqu	%ymm5, (%rsi,%rdx,4)
	movq	-96(%rsp), %rsi                 # 8-byte Reload
	addq	%rsi, %r8
	addq	%rsi, %rax
	addq	%rsi, %r13
	addq	%rsi, %r12
	addq	%rsi, %r9
	addq	%rsi, %r10
	addq	%rsi, %rbp
	addq	%rsi, %r11
	vmovdqu	(%rdi,%r8,4), %ymm5
	vpaddd	(%rdi,%rax,4), %ymm5, %ymm5
	vpmaskmovd	(%rdi,%r10,4), %ymm1, %ymm6
	vpmaskmovd	(%rdi,%rbp,4), %ymm2, %ymm2
	vpmaskmovd	(%rdi,%r11,4), %ymm3, %ymm3
	movq	-112(%rsp), %r8                 # 8-byte Reload
	movq	-120(%rsp), %r11                # 8-byte Reload
	vpaddd	(%rdi,%r13,4), %ymm5, %ymm5
	vpaddd	(%rdi,%r12,4), %ymm5, %ymm5
	vpaddd	(%rdi,%r9,4), %ymm5, %ymm5
	vpaddd	%ymm5, %ymm6, %ymm6
	vpaddd	%ymm6, %ymm2, %ymm2
	vpaddd	%ymm3, %ymm2, %ymm2
	vblendvps	%ymm4, %ymm6, %ymm2, %ymm2
	vblendvps	%ymm1, %ymm2, %ymm5, %ymm1
	vpermilps	$245, %ymm1, %ymm2      # ymm2 = ymm1[1,1,3,3,5,5,7,7]
	vpmuldq	%ymm0, %ymm1, %ymm1
	vpmuldq	%ymm0, %ymm2, %ymm2
	vpshufd	$245, %ymm1, %ymm1              # ymm1 = ymm1[1,1,3,3,5,5,7,7]
	vpblendd	$170, %ymm2, %ymm1, %ymm1       # ymm1 = ymm1[0],ymm2[1],ymm1[2],ymm2[3],ymm1[4],ymm2[5],ymm1[6],ymm2[7]
	vpsrld	$31, %ymm1, %ymm2
	vpsrad	$1, %ymm1, %ymm1
	vpaddd	%ymm2, %ymm1, %ymm1
	vmovdqu	%ymm1, (%r11,%r9,4)
.LBB4_32:                               #   in Loop: Header=BB4_21 Depth=2
	addq	$1, %r14
	addq	$40960, %rcx                    # imm = 0xA000
	addq	$40960, %rbx                    # imm = 0xA000
	cmpq	$10240, %r8                     # imm = 0x2800
	movq	%r8, %rbp
	je	.LBB4_29
.LBB4_21:                               #   Parent Loop BB4_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_24 Depth 3
	movq	%r14, %rax
	movq	8(%rsp), %rdx                   # 8-byte Reload
	movq	16(%rsp), %r9                   # 8-byte Reload
	leaq	1(%rbp), %r8
	shlq	$11, %rax
	leaq	(%rax,%rax,4), %rax
	leaq	(%rdx,%rax), %rsi
	leaq	(%r9,%rax), %rdx
	leaq	(%rdi,%rsi,4), %rsi
	leaq	(%r11,%rdx,4), %rdx
	cmpq	%rsi, %rdx
	jae	.LBB4_31
# %bb.22:                               #   in Loop: Header=BB4_21 Depth=2
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	addq	%rax, %rdx
	addq	-16(%rsp), %rax                 # 8-byte Folded Reload
	leaq	(%rdi,%rdx,4), %rdx
	leaq	(%r11,%rax,4), %rax
	cmpq	%rax, %rdx
	jae	.LBB4_31
# %bb.23:                               #   in Loop: Header=BB4_21 Depth=2
	movq	$-16, %rax
	jmp	.LBB4_24
	.p2align	4, 0x90
.LBB4_28:                               #   in Loop: Header=BB4_24 Depth=3
	movslq	%esi, %rdx
	imulq	$954437177, %rdx, %rdx          # imm = 0x38E38E39
	movq	%rdx, %rsi
	sarq	$33, %rdx
	shrq	$63, %rsi
	addl	%esi, %edx
	movl	%edx, 64(%rcx,%rax,4)
	incq	%rax
	je	.LBB4_32
.LBB4_24:                               #   Parent Loop BB4_1 Depth=1
                                        #     Parent Loop BB4_21 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-245696(%rbx,%rax,4), %esi
	addl	-286656(%rbx,%rax,4), %esi
	addl	-204736(%rbx,%rax,4), %esi
	addl	-163776(%rbx,%rax,4), %esi
	addl	-122816(%rbx,%rax,4), %esi
	cmpq	$10238, %rbp                    # imm = 0x27FE
	ja	.LBB4_28
# %bb.25:                               #   in Loop: Header=BB4_24 Depth=3
	addl	-81856(%rbx,%rax,4), %esi
	cmpq	$10237, %rbp                    # imm = 0x27FD
	ja	.LBB4_28
# %bb.26:                               #   in Loop: Header=BB4_24 Depth=3
	addl	-40896(%rbx,%rax,4), %esi
	cmpq	$10236, %rbp                    # imm = 0x27FC
	ja	.LBB4_28
# %bb.27:                               #   in Loop: Header=BB4_24 Depth=3
	addl	64(%rbx,%rax,4), %esi
	jmp	.LBB4_28
.LBB4_30:
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
	vzeroupper
	retq
.Lfunc_end4:
	.size	blur_y_tile_SIMD_lessif, .Lfunc_end4-blur_y_tile_SIMD_lessif
	.cfi_endproc
                                        # -- End function
	.globl	blur_y_tile_SIMD_lessif_threads # -- Begin function blur_y_tile_SIMD_lessif_threads
	.p2align	4, 0x90
	.type	blur_y_tile_SIMD_lessif_threads,@function
blur_y_tile_SIMD_lessif_threads:        # @blur_y_tile_SIMD_lessif_threads
	.cfi_startproc
# %bb.0:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, 16(%rsp)
	movq	%rsi, 8(%rsp)
	leaq	.L__unnamed_1(%rip), %rdi
	leaq	.omp_outlined..1(%rip), %rdx
	leaq	16(%rsp), %rcx
	leaq	8(%rsp), %r8
	leaq	4(%rsp), %r9
	movl	$3, %esi
	xorl	%eax, %eax
	movl	$9, 4(%rsp)
	callq	__kmpc_fork_call@PLT
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	blur_y_tile_SIMD_lessif_threads, .Lfunc_end5-blur_y_tile_SIMD_lessif_threads
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2                               # -- Begin function .omp_outlined..1
.LCPI6_0:
	.long	954437177                       # 0x38e38e39
	.text
	.p2align	4, 0x90
	.type	.omp_outlined..1,@function
.omp_outlined..1:                       # @.omp_outlined..1
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
	subq	$184, %rsp
	.cfi_def_cfa_offset 240
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	(%rdi), %ebx
	leaq	.L__unnamed_1(%rip), %r15
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, %r14
	movl	$1073741859, %edx               # imm = 0x40000023
	xorl	%ecx, %ecx
	movl	$639, %r8d                      # imm = 0x27F
	movl	$1, %r9d
	movl	$0, 24(%rsp)
	movl	$639, 20(%rsp)                  # imm = 0x27F
	movl	$1, 36(%rsp)
	movl	$0, 32(%rsp)
	movl	$1, (%rsp)
	movq	%r15, %rdi
	movl	%ebx, %esi
	callq	__kmpc_dispatch_init_4@PLT
	movq	%r15, %rdi
	leaq	32(%rsp), %rdx
	leaq	24(%rsp), %rcx
	leaq	20(%rsp), %r8
	leaq	36(%rsp), %r9
	movl	%ebx, %esi
	movl	$1, %r15d
	movl	%ebx, 56(%rsp)                  # 4-byte Spill
	callq	__kmpc_dispatch_next_4@PLT
	testl	%eax, %eax
	je	.LBB6_36
# %bb.1:
	vpbroadcastd	.LCPI6_0(%rip), %ymm0   # ymm0 = [954437177,954437177,954437177,954437177,954437177,954437177,954437177,954437177]
	movl	$16, %r11d
	vmovdqu	%ymm0, 144(%rsp)                # 32-byte Spill
	jmp	.LBB6_3
	.p2align	4, 0x90
.LBB6_2:                                #   in Loop: Header=BB6_3 Depth=1
	movl	56(%rsp), %esi                  # 4-byte Reload
	leaq	.L__unnamed_1(%rip), %rdi
	leaq	32(%rsp), %rdx
	leaq	24(%rsp), %rcx
	leaq	20(%rsp), %r8
	leaq	36(%rsp), %r9
	vzeroupper
	callq	__kmpc_dispatch_next_4@PLT
	movl	$16, %r11d
	testl	%eax, %eax
	je	.LBB6_36
.LBB6_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_5 Depth 2
                                        #       Child Loop BB6_7 Depth 3
                                        #       Child Loop BB6_9 Depth 3
                                        #       Child Loop BB6_11 Depth 3
                                        #       Child Loop BB6_13 Depth 3
                                        #       Child Loop BB6_16 Depth 3
                                        #         Child Loop BB6_22 Depth 4
                                        #         Child Loop BB6_24 Depth 4
                                        #       Child Loop BB6_28 Depth 3
                                        #       Child Loop BB6_30 Depth 3
                                        #       Child Loop BB6_32 Depth 3
                                        #       Child Loop BB6_34 Depth 3
	movslq	24(%rsp), %rax
	cmpl	20(%rsp), %eax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	jg	.LBB6_2
# %bb.4:                                #   in Loop: Header=BB6_3 Depth=1
	movq	64(%rsp), %rax                  # 8-byte Reload
	movl	$10240, %ecx                    # imm = 0x2800
	xorl	%r8d, %r8d
	movl	%eax, %ebx
	movq	%rax, %r10
	shll	$4, %ebx
	subl	%ebx, %ecx
	movl	%ecx, %r9d
	movl	%ecx, 60(%rsp)                  # 4-byte Spill
	jmp	.LBB6_5
	.p2align	4, 0x90
.LBB6_35:                               #   in Loop: Header=BB6_5 Depth=2
	movslq	20(%rsp), %rax
	addl	$1, %r8d
	addl	$16, %ebx
	addl	$-16, %r9d
	cmpq	%rax, %r10
	leaq	1(%r10), %r10
	jge	.LBB6_2
.LBB6_5:                                #   Parent Loop BB6_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB6_7 Depth 3
                                        #       Child Loop BB6_9 Depth 3
                                        #       Child Loop BB6_11 Depth 3
                                        #       Child Loop BB6_13 Depth 3
                                        #       Child Loop BB6_16 Depth 3
                                        #         Child Loop BB6_22 Depth 4
                                        #         Child Loop BB6_24 Depth 4
                                        #       Child Loop BB6_28 Depth 3
                                        #       Child Loop BB6_30 Depth 3
                                        #       Child Loop BB6_32 Depth 3
                                        #       Child Loop BB6_34 Depth 3
	cmpl	$16, %r9d
	movl	$16, %eax
	movl	60(%rsp), %edx                  # 4-byte Reload
	movl	%r8d, %ecx
	movslq	%ebx, %rbx
	cmovll	%r9d, %eax
	cmpl	$2, %eax
	movl	%edx, %r12d
	movl	$10240, %edx                    # imm = 0x2800
	cmovll	%r15d, %eax
	shll	$4, %ecx
	subl	%ecx, %r12d
	movl	%r10d, %ecx
	cmpl	$16, %r12d
	cmovgel	%r11d, %r12d
	cmpl	$2, %r12d
	cmovll	%r15d, %r12d
	shll	$4, %ecx
	subl	%ecx, %edx
	cmpl	$16, %edx
	cmovgel	%r11d, %edx
	cmpq	$639, %r10                      # imm = 0x27F
	jg	.LBB6_35
# %bb.6:                                #   in Loop: Header=BB6_5 Depth=2
	leaq	419389440(,%rbx,4), %rcx
	movq	%r8, 80(%rsp)                   # 8-byte Spill
	movq	%r10, 72(%rsp)                  # 8-byte Spill
	movl	%r9d, 28(%rsp)                  # 4-byte Spill
	leaq	(,%rbx,4), %r13
	andl	$24, %eax
	leaq	286720(,%rbx,4), %r9
	leaq	245760(,%rbx,4), %r10
	leaq	204800(,%rbx,4), %rdi
	movslq	%edx, %rdx
	xorl	%ebp, %ebp
	movq	%rbx, 40(%rsp)                  # 8-byte Spill
	movq	%rcx, 88(%rsp)                  # 8-byte Spill
	movq	64(%rsp), %rcx                  # 8-byte Reload
	leal	(%rcx,%r8), %esi
	shll	$4, %esi
	movslq	%esi, %rcx
	leaq	40960(%rcx), %rsi
	leaq	40960(%r12,%rcx), %r8
	movq	%rcx, 120(%rsp)                 # 8-byte Spill
	leaq	81920(%r12,%rcx), %rcx
	movq	%rsi, 136(%rsp)                 # 8-byte Spill
	movq	48(%rsp), %rsi                  # 8-byte Reload
	movq	%r8, 112(%rsp)                  # 8-byte Spill
	movq	%rcx, 128(%rsp)                 # 8-byte Spill
	movq	(%rsi), %r8
	leaq	(%r8,%rbx,4), %rsi
	.p2align	4, 0x90
.LBB6_7:                                #   Parent Loop BB6_3 Depth=1
                                        #     Parent Loop BB6_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	(%r14), %rcx
	addq	%r13, %rcx
	movl	40960(%rcx,%rbp,4), %ebx
	addl	(%rcx,%rbp,4), %ebx
	addl	81920(%rcx,%rbp,4), %ebx
	addl	122880(%rcx,%rbp,4), %ebx
	addl	163840(%rcx,%rbp,4), %ebx
	movslq	%ebx, %rcx
	imulq	$954437177, %rcx, %rcx          # imm = 0x38E38E39
	movq	%rcx, %rbx
	sarq	$33, %rcx
	shrq	$63, %rbx
	addl	%ebx, %ecx
	movl	%ecx, (%rsi,%rbp,4)
	addq	$1, %rbp
	cmpq	%rdx, %rbp
	jl	.LBB6_7
# %bb.8:                                #   in Loop: Header=BB6_5 Depth=2
	movq	40(%rsp), %rcx                  # 8-byte Reload
	xorl	%ebp, %ebp
	movq	%r13, 96(%rsp)                  # 8-byte Spill
	leaq	40960(%r8,%rcx,4), %rsi
	.p2align	4, 0x90
.LBB6_9:                                #   Parent Loop BB6_3 Depth=1
                                        #     Parent Loop BB6_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	(%r14), %rcx
	addq	%rdi, %rcx
	movl	-163840(%rcx,%rbp,4), %ebx
	addl	-204800(%rcx,%rbp,4), %ebx
	addl	-122880(%rcx,%rbp,4), %ebx
	addl	-81920(%rcx,%rbp,4), %ebx
	addl	-40960(%rcx,%rbp,4), %ebx
	addl	(%rcx,%rbp,4), %ebx
	movslq	%ebx, %rcx
	imulq	$954437177, %rcx, %rcx          # imm = 0x38E38E39
	movq	%rcx, %rbx
	sarq	$33, %rcx
	shrq	$63, %rbx
	addl	%ebx, %ecx
	movl	%ecx, (%rsi,%rbp,4)
	addq	$1, %rbp
	cmpq	%rdx, %rbp
	jl	.LBB6_9
# %bb.10:                               #   in Loop: Header=BB6_5 Depth=2
	movq	40(%rsp), %rcx                  # 8-byte Reload
	xorl	%esi, %esi
	leaq	81920(%r8,%rcx,4), %rdi
	.p2align	4, 0x90
.LBB6_11:                               #   Parent Loop BB6_3 Depth=1
                                        #     Parent Loop BB6_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	(%r14), %rcx
	addq	%r10, %rcx
	movl	-204800(%rcx,%rsi,4), %ebp
	addl	-245760(%rcx,%rsi,4), %ebp
	addl	-163840(%rcx,%rsi,4), %ebp
	addl	-122880(%rcx,%rsi,4), %ebp
	addl	-81920(%rcx,%rsi,4), %ebp
	addl	-40960(%rcx,%rsi,4), %ebp
	addl	(%rcx,%rsi,4), %ebp
	movslq	%ebp, %rcx
	imulq	$954437177, %rcx, %rcx          # imm = 0x38E38E39
	movq	%rcx, %rbp
	sarq	$33, %rcx
	shrq	$63, %rbp
	addl	%ebp, %ecx
	movl	%ecx, (%rdi,%rsi,4)
	addq	$1, %rsi
	cmpq	%rdx, %rsi
	jl	.LBB6_11
# %bb.12:                               #   in Loop: Header=BB6_5 Depth=2
	movq	40(%rsp), %rbx                  # 8-byte Reload
	xorl	%esi, %esi
	leaq	122880(%r8,%rbx,4), %rcx
	.p2align	4, 0x90
.LBB6_13:                               #   Parent Loop BB6_3 Depth=1
                                        #     Parent Loop BB6_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	(%r14), %rdi
	addq	%r9, %rdi
	movl	-245760(%rdi,%rsi,4), %ebp
	addl	-286720(%rdi,%rsi,4), %ebp
	addl	-204800(%rdi,%rsi,4), %ebp
	addl	-163840(%rdi,%rsi,4), %ebp
	addl	-122880(%rdi,%rsi,4), %ebp
	addl	-81920(%rdi,%rsi,4), %ebp
	addl	-40960(%rdi,%rsi,4), %ebp
	addl	(%rdi,%rsi,4), %ebp
	movslq	%ebp, %rdi
	imulq	$954437177, %rdi, %rdi          # imm = 0x38E38E39
	movq	%rdi, %rbp
	sarq	$33, %rdi
	shrq	$63, %rbp
	addl	%ebp, %edi
	movl	%edi, (%rcx,%rsi,4)
	addq	$1, %rsi
	cmpq	%rdx, %rsi
	jl	.LBB6_13
# %bb.14:                               #   in Loop: Header=BB6_5 Depth=2
	movq	72(%rsp), %r10                  # 8-byte Reload
	movq	80(%rsp), %r8                   # 8-byte Reload
	movl	28(%rsp), %r9d                  # 4-byte Reload
	cmpq	$639, %r10                      # imm = 0x27F
	jg	.LBB6_35
# %bb.15:                               #   in Loop: Header=BB6_5 Depth=2
	movq	48(%rsp), %rcx                  # 8-byte Reload
	movl	%r12d, %esi
	vmovdqu	144(%rsp), %ymm2                # 32-byte Reload
	movl	$4, %r13d
	xorl	%r8d, %r8d
	andl	$2147483640, %esi               # imm = 0x7FFFFFF8
	movq	%rsi, 104(%rsp)                 # 8-byte Spill
	movq	(%rcx), %r10
	movq	(%r14), %rcx
	leaq	327680(%rcx,%rbx,4), %rsi
	leaq	163840(%r10,%rbx,4), %r15
	leaq	163840(%rcx,%rbx,4), %r11
	jmp	.LBB6_16
	.p2align	4, 0x90
.LBB6_25:                               #   in Loop: Header=BB6_16 Depth=3
	addq	$1, %r8
	addq	$40960, %rsi                    # imm = 0xA000
	addq	$40960, %r15                    # imm = 0xA000
	addq	$40960, %r11                    # imm = 0xA000
	cmpq	$10236, %r13                    # imm = 0x27FC
	je	.LBB6_26
.LBB6_16:                               #   Parent Loop BB6_3 Depth=1
                                        #     Parent Loop BB6_5 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB6_22 Depth 4
                                        #         Child Loop BB6_24 Depth 4
	addq	$1, %r13
	cmpl	$8, %r12d
	jae	.LBB6_18
# %bb.17:                               #   in Loop: Header=BB6_16 Depth=3
	xorl	%r9d, %r9d
	jmp	.LBB6_24
	.p2align	4, 0x90
.LBB6_18:                               #   in Loop: Header=BB6_16 Depth=3
	movq	%r8, %rbp
	movq	128(%rsp), %rdi                 # 8-byte Reload
	movq	136(%rsp), %r9                  # 8-byte Reload
	shlq	$11, %rbp
	leaq	(%rbp,%rbp,4), %rbp
	leaq	(%rdi,%rbp), %rbx
	leaq	(%r9,%rbp), %rdi
	leaq	(%rcx,%rbx,4), %rbx
	leaq	(%r10,%rdi,4), %rdi
	cmpq	%rbx, %rdi
	jae	.LBB6_21
# %bb.19:                               #   in Loop: Header=BB6_16 Depth=3
	movq	120(%rsp), %rdi                 # 8-byte Reload
	addq	%rbp, %rdi
	addq	112(%rsp), %rbp                 # 8-byte Folded Reload
	leaq	(%rcx,%rdi,4), %rdi
	leaq	(%r10,%rbp,4), %rbp
	cmpq	%rbp, %rdi
	jae	.LBB6_21
# %bb.20:                               #   in Loop: Header=BB6_16 Depth=3
	xorl	%r9d, %r9d
	jmp	.LBB6_24
	.p2align	4, 0x90
.LBB6_21:                               #   in Loop: Header=BB6_16 Depth=3
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB6_22:                               #   Parent Loop BB6_3 Depth=1
                                        #     Parent Loop BB6_5 Depth=2
                                        #       Parent Loop BB6_16 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	vmovdqu	-286720(%rsi,%rbp,4), %ymm0
	vpaddd	-327680(%rsi,%rbp,4), %ymm0, %ymm0
	vpaddd	-245760(%rsi,%rbp,4), %ymm0, %ymm0
	vpaddd	-204800(%rsi,%rbp,4), %ymm0, %ymm0
	vpaddd	-163840(%rsi,%rbp,4), %ymm0, %ymm0
	vpaddd	-122880(%rsi,%rbp,4), %ymm0, %ymm0
	vpaddd	-81920(%rsi,%rbp,4), %ymm0, %ymm0
	vpaddd	-40960(%rsi,%rbp,4), %ymm0, %ymm0
	vpaddd	(%rsi,%rbp,4), %ymm0, %ymm0
	vpshufd	$245, %ymm0, %ymm1              # ymm1 = ymm0[1,1,3,3,5,5,7,7]
	vpmuldq	%ymm2, %ymm0, %ymm0
	vpmuldq	%ymm2, %ymm1, %ymm1
	vpshufd	$245, %ymm0, %ymm0              # ymm0 = ymm0[1,1,3,3,5,5,7,7]
	vpblendd	$170, %ymm1, %ymm0, %ymm0       # ymm0 = ymm0[0],ymm1[1],ymm0[2],ymm1[3],ymm0[4],ymm1[5],ymm0[6],ymm1[7]
	vpsrld	$31, %ymm0, %ymm1
	vpsrad	$1, %ymm0, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vmovdqu	%ymm0, (%r15,%rbp,4)
	addq	$8, %rbp
	cmpq	%rbp, %rax
	jne	.LBB6_22
# %bb.23:                               #   in Loop: Header=BB6_16 Depth=3
	movq	104(%rsp), %r9                  # 8-byte Reload
	cmpq	%r12, %r9
	je	.LBB6_25
	.p2align	4, 0x90
.LBB6_24:                               #   Parent Loop BB6_3 Depth=1
                                        #     Parent Loop BB6_5 Depth=2
                                        #       Parent Loop BB6_16 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	-122880(%r11,%r9,4), %edi
	addl	-163840(%r11,%r9,4), %edi
	addl	-81920(%r11,%r9,4), %edi
	addl	-40960(%r11,%r9,4), %edi
	addl	(%r11,%r9,4), %edi
	addl	40960(%r11,%r9,4), %edi
	addl	81920(%r11,%r9,4), %edi
	addl	122880(%r11,%r9,4), %edi
	addl	163840(%r11,%r9,4), %edi
	movslq	%edi, %rdi
	imulq	$954437177, %rdi, %rdi          # imm = 0x38E38E39
	movq	%rdi, %rbx
	sarq	$33, %rdi
	shrq	$63, %rbx
	addl	%ebx, %edi
	movl	%edi, (%r15,%r9,4)
	addq	$1, %r9
	cmpq	%rdx, %r9
	jl	.LBB6_24
	jmp	.LBB6_25
	.p2align	4, 0x90
.LBB6_26:                               #   in Loop: Header=BB6_5 Depth=2
	movq	72(%rsp), %r10                  # 8-byte Reload
	movq	40(%rsp), %rbx                  # 8-byte Reload
	movq	80(%rsp), %r8                   # 8-byte Reload
	movl	28(%rsp), %r9d                  # 4-byte Reload
	movl	$1, %r15d
	movl	$16, %r11d
	cmpq	$639, %r10                      # imm = 0x27F
	jg	.LBB6_35
# %bb.27:                               #   in Loop: Header=BB6_5 Depth=2
	movq	48(%rsp), %rax                  # 8-byte Reload
	xorl	%esi, %esi
	movq	(%rax), %r12
	movq	88(%rsp), %rax                  # 8-byte Reload
	leaq	419266560(%r12,%rbx,4), %rcx
	.p2align	4, 0x90
.LBB6_28:                               #   Parent Loop BB6_3 Depth=1
                                        #     Parent Loop BB6_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	(%r14), %rdi
	addq	%rax, %rdi
	movl	-245760(%rdi,%rsi,4), %ebp
	addl	-286720(%rdi,%rsi,4), %ebp
	addl	-204800(%rdi,%rsi,4), %ebp
	addl	-163840(%rdi,%rsi,4), %ebp
	addl	-122880(%rdi,%rsi,4), %ebp
	addl	-81920(%rdi,%rsi,4), %ebp
	addl	-40960(%rdi,%rsi,4), %ebp
	addl	(%rdi,%rsi,4), %ebp
	movslq	%ebp, %rdi
	imulq	$954437177, %rdi, %rdi          # imm = 0x38E38E39
	movq	%rdi, %rbp
	sarq	$33, %rdi
	shrq	$63, %rbp
	addl	%ebp, %edi
	movl	%edi, (%rcx,%rsi,4)
	addq	$1, %rsi
	cmpq	%rdx, %rsi
	jl	.LBB6_28
# %bb.29:                               #   in Loop: Header=BB6_5 Depth=2
	leaq	419307520(%r12,%rbx,4), %rcx
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB6_30:                               #   Parent Loop BB6_3 Depth=1
                                        #     Parent Loop BB6_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	(%r14), %rdi
	addq	%rax, %rdi
	movl	-204800(%rdi,%rsi,4), %ebp
	addl	-245760(%rdi,%rsi,4), %ebp
	addl	-163840(%rdi,%rsi,4), %ebp
	addl	-122880(%rdi,%rsi,4), %ebp
	addl	-81920(%rdi,%rsi,4), %ebp
	addl	-40960(%rdi,%rsi,4), %ebp
	addl	(%rdi,%rsi,4), %ebp
	movslq	%ebp, %rdi
	imulq	$954437177, %rdi, %rdi          # imm = 0x38E38E39
	movq	%rdi, %rbp
	sarq	$33, %rdi
	shrq	$63, %rbp
	addl	%ebp, %edi
	movl	%edi, (%rcx,%rsi,4)
	addq	$1, %rsi
	cmpq	%rdx, %rsi
	jl	.LBB6_30
# %bb.31:                               #   in Loop: Header=BB6_5 Depth=2
	leaq	419348480(%r12,%rbx,4), %rcx
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB6_32:                               #   Parent Loop BB6_3 Depth=1
                                        #     Parent Loop BB6_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	(%r14), %rdi
	addq	%rax, %rdi
	movl	-163840(%rdi,%rsi,4), %ebp
	addl	-204800(%rdi,%rsi,4), %ebp
	addl	-122880(%rdi,%rsi,4), %ebp
	addl	-81920(%rdi,%rsi,4), %ebp
	addl	-40960(%rdi,%rsi,4), %ebp
	addl	(%rdi,%rsi,4), %ebp
	movslq	%ebp, %rdi
	imulq	$954437177, %rdi, %rdi          # imm = 0x38E38E39
	movq	%rdi, %rbp
	sarq	$33, %rdi
	shrq	$63, %rbp
	addl	%ebp, %edi
	movl	%edi, (%rcx,%rsi,4)
	addq	$1, %rsi
	cmpq	%rdx, %rsi
	jl	.LBB6_32
# %bb.33:                               #   in Loop: Header=BB6_5 Depth=2
	movq	96(%rsp), %rbp                  # 8-byte Reload
	leaq	419389440(%r12,%rbx,4), %rax
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB6_34:                               #   Parent Loop BB6_3 Depth=1
                                        #     Parent Loop BB6_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	(%r14), %rsi
	addq	%rbp, %rsi
	movl	419266560(%rsi,%rcx,4), %edi
	addl	419225600(%rsi,%rcx,4), %edi
	addl	419307520(%rsi,%rcx,4), %edi
	addl	419348480(%rsi,%rcx,4), %edi
	addl	419389440(%rsi,%rcx,4), %edi
	movslq	%edi, %rsi
	imulq	$954437177, %rsi, %rsi          # imm = 0x38E38E39
	movq	%rsi, %rdi
	sarq	$33, %rsi
	shrq	$63, %rdi
	addl	%edi, %esi
	movl	%esi, (%rax,%rcx,4)
	addq	$1, %rcx
	cmpq	%rdx, %rcx
	jl	.LBB6_34
	jmp	.LBB6_35
.LBB6_36:
	addq	$184, %rsp
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
.Lfunc_end6:
	.size	.omp_outlined..1, .Lfunc_end6-.omp_outlined..1
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function now_ms
.LCPI7_0:
	.quad	0x412e848000000000              # double 1.0E+6
.LCPI7_1:
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
	vdivsd	.LCPI7_0(%rip), %xmm0, %xmm0
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm1
	vfmadd231sd	.LCPI7_1(%rip), %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	now_ms, .Lfunc_end7-now_ms
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function main
.LCPI8_0:
	.quad	0x412e848000000000              # double 1.0E+6
.LCPI8_1:
	.quad	0x408f400000000000              # double 1000
.LCPI8_2:
	.quad	0x4024000000000000              # double 10
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
	subq	$184, %rsp
	.cfi_def_cfa_offset 240
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	xorl	%edi, %edi
	xorl	%ebp, %ebp
	callq	srand@PLT
	leaq	image(%rip), %rbx
	.p2align	4, 0x90
.LBB8_1:                                # =>This Inner Loop Header: Depth=1
	callq	rand@PLT
	movzbl	%al, %eax
	movl	%eax, (%rbp,%rbx)
	addq	$4, %rbp
	cmpq	$419430400, %rbp                # imm = 0x19000000
	jne	.LBB8_1
# %bb.2:
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	callq	clock_gettime@PLT
	vcvtsi2sdq	8(%rsp), %xmm0, %xmm0
	leaq	image_blur_origin(%rip), %rbp
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	vmovsd	%xmm0, 72(%rsp)                 # 8-byte Spill
	vcvtsi2sdq	16(%rsp), %xmm1, %xmm0
	vmovsd	%xmm0, 64(%rsp)                 # 8-byte Spill
	callq	blur_y
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	callq	clock_gettime@PLT
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm0
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	vmovsd	%xmm0, 56(%rsp)                 # 8-byte Spill
	vcvtsi2sdq	16(%rsp), %xmm1, %xmm0
	vmovsd	%xmm0, 40(%rsp)                 # 8-byte Spill
	callq	clock_gettime@PLT
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm0
	leaq	image_blur_tile(%rip), %rbp
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	vmovsd	%xmm0, 48(%rsp)                 # 8-byte Spill
	vcvtsi2sdq	16(%rsp), %xmm1, %xmm0
	vmovsd	%xmm0, 176(%rsp)                # 8-byte Spill
	callq	blur_y_tile_SIMD
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	callq	clock_gettime@PLT
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm0
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	vmovsd	%xmm0, 168(%rsp)                # 8-byte Spill
	vcvtsi2sdq	16(%rsp), %xmm1, %xmm0
	vmovsd	%xmm0, 160(%rsp)                # 8-byte Spill
	callq	clock_gettime@PLT
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm0
	leaq	image_blur_tile_lessif(%rip), %rbp
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	vmovsd	%xmm0, 152(%rsp)                # 8-byte Spill
	vcvtsi2sdq	16(%rsp), %xmm1, %xmm0
	vmovsd	%xmm0, 144(%rsp)                # 8-byte Spill
	callq	blur_y_tile_SIMD_lessif
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD_lessif
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD_lessif
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD_lessif
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD_lessif
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD_lessif
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD_lessif
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD_lessif
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD_lessif
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	blur_y_tile_SIMD_lessif
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	callq	clock_gettime@PLT
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm0
	movl	$8, %edi
	vmovsd	%xmm0, 136(%rsp)                # 8-byte Spill
	vcvtsi2sdq	16(%rsp), %xmm1, %xmm0
	vmovsd	%xmm0, 128(%rsp)                # 8-byte Spill
	callq	omp_set_num_threads@PLT
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	callq	clock_gettime@PLT
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm0
	leaq	image_blur_tile_lessif_threads(%rip), %rax
	leaq	.L__unnamed_1(%rip), %r12
	leaq	.omp_outlined..1(%rip), %rbp
	leaq	8(%rsp), %r15
	leaq	24(%rsp), %r13
	leaq	36(%rsp), %r14
	movl	$3, %esi
	movl	$9, 36(%rsp)
	movq	%rax, 24(%rsp)
	movq	%r12, %rdi
	movq	%rbp, %rdx
	movq	%r15, %rcx
	movq	%r13, %r8
	movq	%r14, %r9
	xorl	%eax, %eax
	vmovsd	%xmm0, 120(%rsp)                # 8-byte Spill
	vcvtsi2sdq	16(%rsp), %xmm1, %xmm0
	movq	%rbx, 8(%rsp)
	vmovsd	%xmm0, 112(%rsp)                # 8-byte Spill
	callq	__kmpc_fork_call@PLT
	leaq	image_blur_tile_lessif_threads(%rip), %rax
	movq	%r12, %rdi
	movl	$3, %esi
	movq	%rbp, %rdx
	movq	%r15, %rcx
	movq	%r13, %r8
	movq	%r14, %r9
	movq	%rbx, 8(%rsp)
	movl	$9, 36(%rsp)
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	callq	__kmpc_fork_call@PLT
	leaq	image_blur_tile_lessif_threads(%rip), %rax
	movq	%r12, %rdi
	movl	$3, %esi
	movq	%rbp, %rdx
	movq	%r15, %rcx
	movq	%r13, %r8
	movq	%r14, %r9
	movq	%rbx, 8(%rsp)
	movl	$9, 36(%rsp)
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	callq	__kmpc_fork_call@PLT
	leaq	image_blur_tile_lessif_threads(%rip), %rax
	movq	%r12, %rdi
	movl	$3, %esi
	movq	%rbp, %rdx
	movq	%r15, %rcx
	movq	%r13, %r8
	movq	%r14, %r9
	movq	%rbx, 8(%rsp)
	movl	$9, 36(%rsp)
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	callq	__kmpc_fork_call@PLT
	leaq	image_blur_tile_lessif_threads(%rip), %rax
	movq	%r12, %rdi
	movl	$3, %esi
	movq	%rbp, %rdx
	movq	%r15, %rcx
	movq	%r13, %r8
	movq	%r14, %r9
	movq	%rbx, 8(%rsp)
	movl	$9, 36(%rsp)
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	callq	__kmpc_fork_call@PLT
	leaq	image_blur_tile_lessif_threads(%rip), %rax
	movq	%r12, %rdi
	movl	$3, %esi
	movq	%rbp, %rdx
	movq	%r15, %rcx
	movq	%r13, %r8
	movq	%r14, %r9
	movq	%rbx, 8(%rsp)
	movl	$9, 36(%rsp)
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	callq	__kmpc_fork_call@PLT
	leaq	image_blur_tile_lessif_threads(%rip), %rax
	movq	%r12, %rdi
	movl	$3, %esi
	movq	%rbp, %rdx
	movq	%r15, %rcx
	movq	%r13, %r8
	movq	%r14, %r9
	movq	%rbx, 8(%rsp)
	movl	$9, 36(%rsp)
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	callq	__kmpc_fork_call@PLT
	leaq	image_blur_tile_lessif_threads(%rip), %rax
	movq	%r12, %rdi
	movl	$3, %esi
	movq	%rbp, %rdx
	movq	%r15, %rcx
	movq	%r13, %r8
	movq	%r14, %r9
	movq	%rbx, 8(%rsp)
	movl	$9, 36(%rsp)
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	callq	__kmpc_fork_call@PLT
	leaq	image_blur_tile_lessif_threads(%rip), %rax
	movq	%rbp, %rdx
	movq	%r12, %rdi
	movl	$3, %esi
	movq	%r15, %rcx
	movq	%r13, %r8
	movq	%r14, %r9
	movq	%rbx, 8(%rsp)
	movl	$9, 36(%rsp)
	movq	%r14, %rbp
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	callq	__kmpc_fork_call@PLT
	leaq	image_blur_tile_lessif_threads(%rip), %rax
	movq	%r12, %rdi
	movl	$3, %esi
	leaq	.omp_outlined..1(%rip), %rdx
	movq	%r15, %rcx
	movq	%r13, %r8
	movq	%rbp, %r9
	movq	%rbx, 8(%rsp)
	movl	$9, 36(%rsp)
	movq	%r12, %r14
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	callq	__kmpc_fork_call@PLT
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	callq	clock_gettime@PLT
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm0
	movl	$8, %edi
	vmovsd	%xmm0, 88(%rsp)                 # 8-byte Spill
	vcvtsi2sdq	16(%rsp), %xmm1, %xmm0
	vmovsd	%xmm0, 80(%rsp)                 # 8-byte Spill
	callq	omp_set_num_threads@PLT
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	callq	clock_gettime@PLT
	vcvtsi2sdq	8(%rsp), %xmm1, %xmm0
	leaq	.omp_outlined.(%rip), %r15
	leaq	8(%rsp), %rbp
	leaq	24(%rsp), %r12
	leaq	image_blur_tile_threads(%rip), %r13
	movq	%r14, %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	movq	%r15, %rdx
	movq	%rbp, %rcx
	movq	%r12, %r8
	movq	%r13, 24(%rsp)
	vmovsd	%xmm0, 104(%rsp)                # 8-byte Spill
	vcvtsi2sdq	16(%rsp), %xmm1, %xmm0
	movq	%rbx, 8(%rsp)
	vmovsd	%xmm0, 96(%rsp)                 # 8-byte Spill
	callq	__kmpc_fork_call@PLT
	movq	%r14, %rdi
	movl	$2, %esi
	movq	%r15, %rdx
	movq	%rbp, %rcx
	movq	%r12, %r8
	xorl	%eax, %eax
	movq	%rbx, 8(%rsp)
	movq	%r13, 24(%rsp)
	callq	__kmpc_fork_call@PLT
	movq	%r14, %rdi
	movl	$2, %esi
	movq	%r15, %rdx
	movq	%rbp, %rcx
	movq	%r12, %r8
	xorl	%eax, %eax
	movq	%rbx, 8(%rsp)
	movq	%r13, 24(%rsp)
	callq	__kmpc_fork_call@PLT
	movq	%r14, %rdi
	movl	$2, %esi
	movq	%r15, %rdx
	movq	%rbp, %rcx
	movq	%r12, %r8
	xorl	%eax, %eax
	movq	%rbx, 8(%rsp)
	movq	%r13, 24(%rsp)
	callq	__kmpc_fork_call@PLT
	movq	%r14, %rdi
	movl	$2, %esi
	movq	%r15, %rdx
	movq	%rbp, %rcx
	movq	%r12, %r8
	xorl	%eax, %eax
	movq	%rbx, 8(%rsp)
	movq	%r13, 24(%rsp)
	callq	__kmpc_fork_call@PLT
	movq	%r14, %rdi
	movl	$2, %esi
	movq	%r15, %rdx
	movq	%rbp, %rcx
	movq	%r12, %r8
	xorl	%eax, %eax
	movq	%rbx, 8(%rsp)
	movq	%r13, 24(%rsp)
	callq	__kmpc_fork_call@PLT
	movq	%r14, %rdi
	movl	$2, %esi
	movq	%r15, %rdx
	movq	%rbp, %rcx
	movq	%r12, %r8
	xorl	%eax, %eax
	movq	%rbx, 8(%rsp)
	movq	%r13, 24(%rsp)
	callq	__kmpc_fork_call@PLT
	movq	%r14, %rdi
	movl	$2, %esi
	movq	%r15, %rdx
	movq	%rbp, %rcx
	movq	%r12, %r8
	xorl	%eax, %eax
	movq	%rbx, 8(%rsp)
	movq	%r13, 24(%rsp)
	callq	__kmpc_fork_call@PLT
	movq	%r14, %rdi
	movl	$2, %esi
	movq	%r15, %rdx
	movq	%rbp, %rcx
	movq	%r12, %r8
	xorl	%eax, %eax
	movq	%rbx, 8(%rsp)
	movq	%r13, 24(%rsp)
	callq	__kmpc_fork_call@PLT
	movq	%r14, %rdi
	movl	$2, %esi
	movq	%r15, %rdx
	movq	%rbp, %rcx
	movq	%r12, %r8
	xorl	%eax, %eax
	movq	%rbx, 8(%rsp)
	movq	%r13, 24(%rsp)
	callq	__kmpc_fork_call@PLT
	vmovsd	.LCPI8_0(%rip), %xmm5           # xmm5 = mem[0],zero
	vmovsd	80(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmovsd	112(%rsp), %xmm1                # 8-byte Reload
                                        # xmm1 = mem[0],zero
	vmovsd	.LCPI8_1(%rip), %xmm6           # xmm6 = mem[0],zero
	vmovsd	144(%rsp), %xmm2                # 8-byte Reload
                                        # xmm2 = mem[0],zero
	vmovsd	176(%rsp), %xmm3                # 8-byte Reload
                                        # xmm3 = mem[0],zero
	vmovsd	64(%rsp), %xmm4                 # 8-byte Reload
                                        # xmm4 = mem[0],zero
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	vdivsd	%xmm5, %xmm0, %xmm0
	vdivsd	%xmm5, %xmm1, %xmm1
	vdivsd	%xmm5, %xmm2, %xmm2
	vdivsd	%xmm5, %xmm3, %xmm3
	vdivsd	%xmm5, %xmm4, %xmm4
	vfmadd231sd	88(%rsp), %xmm6, %xmm0  # 8-byte Folded Reload
                                        # xmm0 = (xmm6 * mem) + xmm0
	vfmadd231sd	120(%rsp), %xmm6, %xmm1 # 8-byte Folded Reload
                                        # xmm1 = (xmm6 * mem) + xmm1
	vfmadd231sd	152(%rsp), %xmm6, %xmm2 # 8-byte Folded Reload
                                        # xmm2 = (xmm6 * mem) + xmm2
	vfmadd231sd	48(%rsp), %xmm6, %xmm3  # 8-byte Folded Reload
                                        # xmm3 = (xmm6 * mem) + xmm3
	vfmadd231sd	72(%rsp), %xmm6, %xmm4  # 8-byte Folded Reload
                                        # xmm4 = (xmm6 * mem) + xmm4
	vsubsd	%xmm1, %xmm0, %xmm0
	vmovsd	128(%rsp), %xmm1                # 8-byte Reload
                                        # xmm1 = mem[0],zero
	vdivsd	%xmm5, %xmm1, %xmm1
	vfmadd231sd	136(%rsp), %xmm6, %xmm1 # 8-byte Folded Reload
                                        # xmm1 = (xmm6 * mem) + xmm1
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovsd	160(%rsp), %xmm2                # 8-byte Reload
                                        # xmm2 = mem[0],zero
	vdivsd	%xmm5, %xmm2, %xmm2
	vfmadd231sd	168(%rsp), %xmm6, %xmm2 # 8-byte Folded Reload
                                        # xmm2 = (xmm6 * mem) + xmm2
	vsubsd	%xmm3, %xmm2, %xmm2
	vmovsd	40(%rsp), %xmm3                 # 8-byte Reload
                                        # xmm3 = mem[0],zero
	vdivsd	%xmm5, %xmm3, %xmm3
	vfmadd231sd	56(%rsp), %xmm6, %xmm3  # 8-byte Folded Reload
                                        # xmm3 = (xmm6 * mem) + xmm3
	vsubsd	%xmm4, %xmm3, %xmm3
	vmovsd	96(%rsp), %xmm4                 # 8-byte Reload
                                        # xmm4 = mem[0],zero
	vdivsd	%xmm5, %xmm4, %xmm4
	vfmadd231sd	104(%rsp), %xmm6, %xmm4 # 8-byte Folded Reload
                                        # xmm4 = (xmm6 * mem) + xmm4
	vmovsd	.LCPI8_2(%rip), %xmm6           # xmm6 = mem[0],zero
	vdivsd	%xmm6, %xmm1, %xmm5
	vdivsd	%xmm6, %xmm0, %xmm0
	vdivsd	%xmm6, %xmm2, %xmm2
	vdivsd	%xmm6, %xmm3, %xmm1
	vmovsd	%xmm4, 40(%rsp)                 # 8-byte Spill
	vmovsd	%xmm0, 72(%rsp)                 # 8-byte Spill
	vmovsd	%xmm5, 64(%rsp)                 # 8-byte Spill
	vmovsd	%xmm2, 56(%rsp)                 # 8-byte Spill
	vmovsd	%xmm1, 48(%rsp)                 # 8-byte Spill
	callq	clock_gettime@PLT
	vcvtsi2sdq	16(%rsp), %xmm7, %xmm0
	leaq	.L.str(%rip), %rdi
	movl	$10, %esi
	xorl	%eax, %eax
	vdivsd	.LCPI8_0(%rip), %xmm0, %xmm0
	vcvtsi2sdq	8(%rsp), %xmm7, %xmm1
	vfmadd231sd	.LCPI8_1(%rip), %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
	vsubsd	40(%rsp), %xmm0, %xmm0          # 8-byte Folded Reload
	vdivsd	.LCPI8_2(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, 40(%rsp)                 # 8-byte Spill
	callq	printf@PLT
	vmovsd	48(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	leaq	.L.str.2(%rip), %rdi
	movb	$1, %al
	callq	printf@PLT
	vmovsd	56(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	leaq	.L.str.3(%rip), %rdi
	movb	$1, %al
	callq	printf@PLT
	vmovsd	40(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	leaq	.L.str.4(%rip), %rdi
	movb	$1, %al
	callq	printf@PLT
	vmovsd	64(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	leaq	.L.str.5(%rip), %rdi
	movb	$1, %al
	callq	printf@PLT
	vmovsd	72(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	leaq	.L.str.6(%rip), %rdi
	movb	$1, %al
	callq	printf@PLT
	xorl	%eax, %eax
	addq	$184, %rsp
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
.Lfunc_end8:
	.size	main, .Lfunc_end8-main
	.cfi_endproc
                                        # -- End function
	.type	.L__unnamed_2,@object           # @0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__unnamed_2:
	.asciz	";unknown;unknown;0;0;;"
	.size	.L__unnamed_2, 23

	.type	.L__unnamed_1,@object           # @1
	.section	.data.rel.ro,"aw",@progbits
	.p2align	3
.L__unnamed_1:
	.long	0                               # 0x0
	.long	2                               # 0x2
	.long	0                               # 0x0
	.long	22                              # 0x16
	.quad	.L__unnamed_2
	.size	.L__unnamed_1, 24

	.type	image,@object                   # @image
	.local	image
	.comm	image,419430400,16
	.type	image_blur_origin,@object       # @image_blur_origin
	.local	image_blur_origin
	.comm	image_blur_origin,419430400,16
	.type	image_blur_tile,@object         # @image_blur_tile
	.local	image_blur_tile
	.comm	image_blur_tile,419430400,16
	.type	image_blur_tile_lessif,@object  # @image_blur_tile_lessif
	.local	image_blur_tile_lessif
	.comm	image_blur_tile_lessif,419430400,16
	.type	image_blur_tile_lessif_threads,@object # @image_blur_tile_lessif_threads
	.local	image_blur_tile_lessif_threads
	.comm	image_blur_tile_lessif_threads,419430400,16
	.type	image_blur_tile_threads,@object # @image_blur_tile_threads
	.local	image_blur_tile_threads
	.comm	image_blur_tile_threads,419430400,16
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Average time over %d runs:\n"
	.size	.L.str, 28

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"  blur_y:      %.3f ms\n"
	.size	.L.str.2, 24

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"  blur_y_tile_SIMD: %.3f ms\n"
	.size	.L.str.3, 29

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"  blur_y_tile_SIMD_threads: %.3f ms\n"
	.size	.L.str.4, 37

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"  blur_y_tile_SIMD_lessif: %.3f ms\n"
	.size	.L.str.5, 36

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"  blur_y_tile_SIMD_lessif_threads: %.3f ms\n"
	.size	.L.str.6, 44

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym .omp_outlined.
	.addrsig_sym .omp_outlined..1
	.addrsig_sym image
	.addrsig_sym image_blur_origin
	.addrsig_sym image_blur_tile
	.addrsig_sym image_blur_tile_lessif
	.addrsig_sym image_blur_tile_lessif_threads
	.addrsig_sym image_blur_tile_threads
