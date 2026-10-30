	.cpu arm7tdmi
	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 2	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"C_Code.c"
@ GNU C23 (devkitARM) version 16.1.0 (arm-none-eabi)
@	compiled by GNU C version 13.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -O2
	.text
	.align	1
	.p2align 2,,3
	.global	CallARM_FillMovementMap
	.syntax unified
	.code	16
	.thumb_func
	.type	CallARM_FillMovementMap, %function
CallARM_FillMovementMap:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r6, r9	@,
	mov	lr, fp	@,
	mov	r7, r10	@,
	mov	r5, r8	@,
	push	{r5, r6, r7, lr}	@
@ C_Code.c:16:     if (!gMapFloodCoreRam())
	ldr	r3, .L22	@ tmp149,
@ C_Code.c:11: {
	sub	sp, sp, #20	@,,
@ C_Code.c:16:     if (!gMapFloodCoreRam())
	mov	r9, r3	@ tmp149, tmp149
	ldr	r3, [r3]	@ gMapFloodCoreRam, gMapFloodCoreRam
	bl	.L24		@
@ C_Code.c:16:     if (!gMapFloodCoreRam())
	cmp	r0, #0	@ _2,
	beq	.L1		@,
	ldr	r3, .L22+4	@ tmp150,
	mov	r10, r3	@ tmp150, tmp150
@ C_Code.c:26:             row = gWorkingBmMap[iy];
	ldr	r3, .L22+8	@ tmp158,
	str	r3, [sp, #8]	@ tmp158, %sfp
@ C_Code.c:37:                 if (++seed == gMovMapFillStPool1 + FLOOD_RESEED_COUNT)
	movs	r3, #64	@ tmp159,
	mov	fp, r3	@ tmp159, tmp159
	ldr	r4, .L22+12	@ seed,
	str	r4, [sp, #12]	@ seed, %sfp
	add	fp, fp, r4	@ tmp159, seed
.L8:
@ C_Code.c:24:         for (iy = 0; iy < gBmMapSize.y; ++iy)
	mov	r3, r10	@ tmp150, tmp150
	movs	r2, #2	@ tmp181,
	ldrsh	r3, [r3, r2]	@ tmp124, tmp150, tmp181
	cmp	r3, #0	@ tmp124,
	ble	.L9		@,
@ C_Code.c:21:         dropped = FALSE;
	movs	r3, #0	@ dropped,
@ C_Code.c:24:         for (iy = 0; iy < gBmMapSize.y; ++iy)
	movs	r6, #0	@ iy,
@ C_Code.c:22:         seed = gMovMapFillStPool1;
	mov	r7, r10	@ tmp150, tmp150
@ C_Code.c:21:         dropped = FALSE;
	str	r3, [sp, #4]	@ dropped, %sfp
@ C_Code.c:22:         seed = gMovMapFillStPool1;
	ldr	r5, [sp, #12]	@ seed, %sfp
.L7:
@ C_Code.c:28:             for (ix = 0; ix < gBmMapSize.x; ++ix)
	movs	r2, #0	@ tmp182,
	ldrsh	r3, [r7, r2]	@ gBmMapSize, tmp150, tmp182
	cmp	r3, #0	@ gBmMapSize,
	ble	.L4		@,
@ C_Code.c:26:             row = gWorkingBmMap[iy];
	ldr	r3, [sp, #8]	@ tmp158, %sfp
	ldr	r3, [r3]	@ gWorkingBmMap, gWorkingBmMap
	lsls	r2, r6, #2	@ tmp129, iy,
	ldr	r3, [r2, r3]	@ row, *_6
	mov	r8, r3	@ row, row
@ C_Code.c:35:                 seed->connexion = FLOOD_START;
	movs	r3, #5	@ tmp151,
	mov	r10, r3	@ tmp151, tmp151
@ C_Code.c:39:                     seed->connexion = FLOOD_END;
	movs	r3, r6	@ iy, iy
@ C_Code.c:28:             for (ix = 0; ix < gBmMapSize.x; ++ix)
	movs	r4, #0	@ ix,
@ C_Code.c:39:                     seed->connexion = FLOOD_END;
	mov	r6, r8	@ row, row
	mov	r8, r3	@ iy, iy
	b	.L6		@
.L10:
@ C_Code.c:37:                 if (++seed == gMovMapFillStPool1 + FLOOD_RESEED_COUNT)
	movs	r5, r3	@ seed, seed
.L5:
@ C_Code.c:28:             for (ix = 0; ix < gBmMapSize.x; ++ix)
	movs	r2, #0	@ tmp183,
	ldrsh	r3, [r7, r2]	@ _14, tmp150, tmp183
@ C_Code.c:28:             for (ix = 0; ix < gBmMapSize.x; ++ix)
	adds	r4, r4, #1	@ ix,
@ C_Code.c:28:             for (ix = 0; ix < gBmMapSize.x; ++ix)
	cmp	r3, r4	@ _14, ix
	ble	.L21		@,
.L6:
@ C_Code.c:30:                 if (row[ix] == 0xFF)
	ldrb	r3, [r6, r4]	@ MEM[(u8 *)row_37 + _48 * 1], MEM[(u8 *)row_37 + _48 * 1]
	cmp	r3, #255	@ MEM[(u8 *)row_37 + _48 * 1],
	beq	.L5		@,
@ C_Code.c:47:         dropped |= gMapFloodCoreRam();
	mov	r3, r9	@ tmp149, tmp149
	ldr	r2, [r3]	@ pretmp_51, gMapFloodCoreRam
@ C_Code.c:34:                 seed->yPos = iy;
	mov	r3, r8	@ iy, iy
	strb	r3, [r5, #1]	@ iy, seed_60->yPos
@ C_Code.c:35:                 seed->connexion = FLOOD_START;
	mov	r3, r10	@ tmp151, tmp151
	strb	r3, [r5, #2]	@ tmp151, seed_60->connexion
@ C_Code.c:37:                 if (++seed == gMovMapFillStPool1 + FLOOD_RESEED_COUNT)
	adds	r3, r5, #4	@ seed, seed,
@ C_Code.c:33:                 seed->xPos = ix;
	strb	r4, [r5]	@ ix, seed_60->xPos
@ C_Code.c:37:                 if (++seed == gMovMapFillStPool1 + FLOOD_RESEED_COUNT)
	cmp	r3, fp	@ seed, tmp159
	bne	.L10		@,
@ C_Code.c:39:                     seed->connexion = FLOOD_END;
	movs	r3, #4	@ tmp201,
	strb	r3, [r5, #6]	@ tmp200, MEM[(struct MovMapFillStateExt *)seed_60 + 4B].connexion
@ C_Code.c:40:                     dropped |= gMapFloodCoreRam();
	bl	.L25		@
@ C_Code.c:40:                     dropped |= gMapFloodCoreRam();
	ldr	r3, [sp, #4]	@ dropped, %sfp
	orrs	r3, r0	@ dropped, _45
	str	r3, [sp, #4]	@ dropped, %sfp
@ C_Code.c:28:             for (ix = 0; ix < gBmMapSize.x; ++ix)
	movs	r2, #0	@ tmp183,
	ldrsh	r3, [r7, r2]	@ _14, tmp150, tmp183
@ C_Code.c:28:             for (ix = 0; ix < gBmMapSize.x; ++ix)
	adds	r4, r4, #1	@ ix,
@ C_Code.c:41:                     seed = gMovMapFillStPool1;
	subs	r5, r5, #60	@ seed,
@ C_Code.c:28:             for (ix = 0; ix < gBmMapSize.x; ++ix)
	cmp	r3, r4	@ _14, ix
	bgt	.L6		@,
.L21:
	mov	r6, r8	@ iy, iy
.L4:
@ C_Code.c:24:         for (iy = 0; iy < gBmMapSize.y; ++iy)
	movs	r2, #2	@ tmp184,
	ldrsh	r3, [r7, r2]	@ _16, tmp150, tmp184
@ C_Code.c:24:         for (iy = 0; iy < gBmMapSize.y; ++iy)
	adds	r6, r6, #1	@ iy,
@ C_Code.c:24:         for (iy = 0; iy < gBmMapSize.y; ++iy)
	cmp	r3, r6	@ _16, iy
	bgt	.L7		@,
	mov	r10, r7	@ tmp150, tmp150
.L3:
@ C_Code.c:46:         seed->connexion = FLOOD_END;
	movs	r3, #4	@ tmp143,
	strb	r3, [r5, #2]	@ tmp143, seed_63->connexion
@ C_Code.c:47:         dropped |= gMapFloodCoreRam();
	mov	r3, r9	@ tmp149, tmp149
	ldr	r3, [r3]	@ gMapFloodCoreRam, gMapFloodCoreRam
	bl	.L24		@
@ C_Code.c:47:         dropped |= gMapFloodCoreRam();
	ldr	r3, [sp, #4]	@ dropped, %sfp
	orrs	r0, r3	@ dropped_36, dropped
@ C_Code.c:48:     } while (dropped);
	bne	.L8		@,
.L1:
@ C_Code.c:49: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L9:
@ C_Code.c:21:         dropped = FALSE;
	movs	r3, #0	@ dropped,
@ C_Code.c:22:         seed = gMovMapFillStPool1;
	ldr	r5, [sp, #12]	@ seed, %sfp
@ C_Code.c:21:         dropped = FALSE;
	str	r3, [sp, #4]	@ dropped, %sfp
	b	.L3		@
.L23:
	.align	2
.L22:
	.word	gMapFloodCoreRam
	.word	gBmMapSize
	.word	gWorkingBmMap
	.word	gMovMapFillStPool1
	.size	CallARM_FillMovementMap, .-CallARM_FillMovementMap
	.ident	"GCC: (devkitARM) 16.1.0"
	.code 16
	.align	1
.L25:
	bx	r2
.L24:
	bx	r3
