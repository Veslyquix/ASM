	.cpu arm7tdmi
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
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -O2
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\001\002\020 @\200\000"
	.text
	.align	1
	.p2align 2,,3
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetButtonsToPress.part.0, %function
GetButtonsToPress.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, fp	@,
	mov	r5, r8	@,
	mov	r7, r10	@,
	mov	r6, r9	@,
	push	{r5, r6, r7, lr}	@
@ C_Code.c:253: 		u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
	ldr	r3, .L20	@ tmp132,
	ldr	r2, [r3]	@ tmp135,
@ C_Code.c:249: int GetButtonsToPress(TimedHitsProc* proc) { 
	sub	sp, sp, #12	@,,
@ C_Code.c:253: 		u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
	str	r2, [sp]	@ tmp135,
	mov	r2, sp	@ tmp166,
	ldrh	r3, [r3, #4]	@ tmp137,
	strh	r3, [r2, #4]	@ tmp137,
@ C_Code.c:258: 		for (int i = 0; i < NumberOfRandomButtons; ++i) { 
	ldr	r3, .L20+4	@ tmp159,
	mov	r8, r3	@ tmp159, tmp159
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
@ C_Code.c:249: int GetButtonsToPress(TimedHitsProc* proc) { 
	mov	fp, r0	@ proc, tmp163
@ C_Code.c:258: 		for (int i = 0; i < NumberOfRandomButtons; ++i) { 
	cmp	r3, #0	@ NumberOfRandomButtons,
	ble	.L8		@,
	ldr	r3, .L20+8	@ tmp160,
	mov	r10, r3	@ tmp160, tmp160
@ C_Code.c:263: 			if (button & 0xF0) { // some dpad 
	movs	r3, #15	@ tmp144,
@ C_Code.c:256: 		int oppDir = 0; 
	movs	r6, #0	@ oppDir,
@ C_Code.c:258: 		for (int i = 0; i < NumberOfRandomButtons; ++i) { 
	movs	r5, #0	@ i,
@ C_Code.c:251: 	int keys = proc->buttonsToPress;
	movs	r7, #0	@ <retval>,
@ C_Code.c:257: 		int size = 5; // -1 since we count from 0  
	movs	r4, #5	@ size,
@ C_Code.c:263: 			if (button & 0xF0) { // some dpad 
	mov	r9, r3	@ tmp144, tmp144
	b	.L7		@
.L3:
@ C_Code.c:258: 		for (int i = 0; i < NumberOfRandomButtons; ++i) { 
	mov	r3, r8	@ tmp159, tmp159
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
@ C_Code.c:258: 		for (int i = 0; i < NumberOfRandomButtons; ++i) { 
	adds	r5, r5, #1	@ i,
@ C_Code.c:278: 			keys |= button; 
	orrs	r7, r0	@ <retval>, button
@ C_Code.c:258: 		for (int i = 0; i < NumberOfRandomButtons; ++i) { 
	cmp	r5, r3	@ i, NumberOfRandomButtons
	bge	.L18		@,
.L7:
@ C_Code.c:259: 			num = NextRN_N(size); 
	movs	r0, r4	@, size
	bl	.L22		@
@ C_Code.c:260: 			button = KeysList[num];
	mov	r3, sp	@ tmp171,
	ldrb	r0, [r3, r0]	@ button, KeysList
@ C_Code.c:263: 			if (button & 0xF0) { // some dpad 
	mov	r2, r9	@ tmp144, tmp144
	movs	r3, r0	@ tmp146, button
	bics	r3, r2	@ tmp146, tmp144
	beq	.L3		@,
@ C_Code.c:264: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	cmp	r0, #16	@ button,
	beq	.L9		@,
@ C_Code.c:265: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	cmp	r0, #32	@ button,
	beq	.L10		@,
@ C_Code.c:266: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	cmp	r0, #64	@ button,
	bne	.L19		@,
@ C_Code.c:266: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	movs	r6, #128	@ oppDir,
.L4:
@ C_Code.c:268: 				for (int c = 0; c <= size; ++c) { 
	cmp	r4, #0	@ size,
	blt	.L3		@,
	mov	r2, sp	@ ivtmp.49,
@ C_Code.c:268: 				for (int c = 0; c <= size; ++c) { 
	movs	r3, #0	@ c,
	b	.L6		@
.L5:
@ C_Code.c:268: 				for (int c = 0; c <= size; ++c) { 
	adds	r3, r3, #1	@ c,
@ C_Code.c:268: 				for (int c = 0; c <= size; ++c) { 
	adds	r2, r2, #1	@ ivtmp.49,
	cmp	r3, r4	@ c, size
	bgt	.L3		@,
.L6:
@ C_Code.c:269: 					if (KeysList[c] == oppDir) { 
	ldrb	r1, [r2]	@ MEM[(unsigned char *)_6], MEM[(unsigned char *)_6]
@ C_Code.c:269: 					if (KeysList[c] == oppDir) { 
	cmp	r1, r6	@ MEM[(unsigned char *)_6], oppDir
	bne	.L5		@,
@ C_Code.c:270: 						KeysList[c] = KeysList[size]; 
	mov	r2, sp	@ tmp174,
@ C_Code.c:270: 						KeysList[c] = KeysList[size]; 
	mov	r1, sp	@ tmp175,
@ C_Code.c:270: 						KeysList[c] = KeysList[size]; 
	ldrb	r2, [r2, r4]	@ _10, KeysList
@ C_Code.c:270: 						KeysList[c] = KeysList[size]; 
	strb	r2, [r1, r3]	@ _10, KeysList[c_25]
@ C_Code.c:258: 		for (int i = 0; i < NumberOfRandomButtons; ++i) { 
	mov	r3, r8	@ tmp159, tmp159
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
@ C_Code.c:258: 		for (int i = 0; i < NumberOfRandomButtons; ++i) { 
	adds	r5, r5, #1	@ i,
@ C_Code.c:271: 						size--; 
	subs	r4, r4, #1	@ size,
@ C_Code.c:278: 			keys |= button; 
	orrs	r7, r0	@ <retval>, button
@ C_Code.c:258: 		for (int i = 0; i < NumberOfRandomButtons; ++i) { 
	cmp	r5, r3	@ i, NumberOfRandomButtons
	blt	.L7		@,
.L18:
@ C_Code.c:280: 		proc->buttonsToPress = keys; 
	lsls	r3, r7, #16	@ tmp154, <retval>,
	lsrs	r3, r3, #16	@ prephitmp_1, tmp154,
.L2:
	movs	r2, #84	@ tmp155,
	mov	r1, fp	@ proc, proc
@ C_Code.c:283: } 
	movs	r0, r7	@, <retval>
@ C_Code.c:280: 		proc->buttonsToPress = keys; 
	strh	r3, [r1, r2]	@ prephitmp_1, proc_21(D)->buttonsToPress
@ C_Code.c:283: } 
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L9:
@ C_Code.c:264: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	movs	r6, #32	@ oppDir,
	b	.L4		@
.L19:
@ C_Code.c:267: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	cmp	r0, #128	@ button,
	bne	.L4		@,
@ C_Code.c:267: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	movs	r6, #64	@ oppDir,
	b	.L4		@
.L10:
@ C_Code.c:265: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	movs	r6, #16	@ oppDir,
	b	.L4		@
.L8:
@ C_Code.c:258: 		for (int i = 0; i < NumberOfRandomButtons; ++i) { 
	movs	r3, #0	@ prephitmp_1,
@ C_Code.c:251: 	int keys = proc->buttonsToPress;
	movs	r7, #0	@ <retval>,
	b	.L2		@
.L21:
	.align	2
.L20:
	.word	.LC0
	.word	NumberOfRandomButtons
	.word	NextRN_N
	.size	GetButtonsToPress.part.0, .-GetButtonsToPress.part.0
	.align	1
	.p2align 2,,3
	.global	InitVariables
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	InitVariables, %function
InitVariables:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:93: 	proc->buttonsToPress = 0; 
	movs	r3, #0	@ tmp115,
@ C_Code.c:97: } 
	@ sp needed	@
@ C_Code.c:93: 	proc->buttonsToPress = 0; 
	movs	r2, #84	@ tmp114,
	strh	r3, [r0, r2]	@ tmp115, proc_2(D)->buttonsToPress
@ C_Code.c:78: 	proc->anim = NULL; 
	str	r3, [r0, #44]	@ tmp115, proc_2(D)->anim
@ C_Code.c:79: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp115, proc_2(D)->anim2
@ C_Code.c:82: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp115, proc_2(D)->timer
@ C_Code.c:88: 	proc->currentRound = NULL; 
	str	r3, [r0, #60]	@ tmp115, proc_2(D)->currentRound
@ C_Code.c:89: 	proc->active_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp115, proc_2(D)->active_bunit
@ C_Code.c:90: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #68]	@ tmp115, proc_2(D)->opp_bunit
@ C_Code.c:84: 	proc->hitOnTime = false; 
	str	r3, [r0, #72]	@ tmp115, MEM <unsigned int> [(unsigned char *)proc_2(D) + 72B]
@ C_Code.c:86: 	proc->loadedImg = false; // reload after each round 
	ldr	r3, .L24	@ tmp125,
	str	r3, [r0, #76]	@ tmp125, MEM <unsigned int> [(unsigned char *)proc_2(D) + 76B]
@ C_Code.c:95: 	proc->codefframe = 0xff;
	movs	r3, #80	@ tmp126,
@ C_Code.c:83: 	proc->timer2 = 99; 
	adds	r2, r2, #15	@ tmp120,
	str	r2, [r0, #56]	@ tmp120, proc_2(D)->timer2
@ C_Code.c:95: 	proc->codefframe = 0xff;
	ldr	r2, .L24+4	@ tmp127,
	strh	r2, [r0, r3]	@ tmp127, MEM <unsigned short> [(unsigned char *)proc_2(D) + 80B]
@ C_Code.c:96: 	proc->EkrEfxIsUnitHittedNowFrames = 0xff; 
	subs	r2, r2, #1	@ tmp130,
	adds	r3, r3, #2	@ tmp129,
	subs	r2, r2, #255	@ tmp130,
	strb	r2, [r0, r3]	@ tmp130, proc_2(D)->EkrEfxIsUnitHittedNowFrames
@ C_Code.c:97: } 
	bx	lr
.L25:
	.align	2
.L24:
	.word	-16711936
	.word	511
	.size	InitVariables, .-InitVariables
	.align	1
	.p2align 2,,3
	.global	StartTimedHitsProc
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	StartTimedHitsProc, %function
StartTimedHitsProc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ C_Code.c:101: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r4, .L29	@ tmp114,
	ldr	r3, .L29+4	@ tmp115,
	movs	r0, r4	@, tmp114
	bl	.L31		@
@ C_Code.c:102: 	if (!proc) { 
	cmp	r0, #0	@ tmp118,
	beq	.L28		@,
.L26:
@ C_Code.c:106: } 
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L28:
@ C_Code.c:103: 		proc = Proc_Start(TimedHitsProcCmd, (void*)3); 
	movs	r1, #3	@,
	movs	r0, r4	@, tmp114
	ldr	r3, .L29+8	@ tmp117,
	bl	.L31		@
@ C_Code.c:106: } 
	b	.L26		@
.L30:
	.align	2
.L29:
	.word	.LANCHOR0
	.word	Proc_Find
	.word	Proc_Start
	.size	StartTimedHitsProc, .-StartTimedHitsProc
	.align	1
	.p2align 2,,3
	.global	SetCurrentAnimInProc
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SetCurrentAnimInProc, %function
SetCurrentAnimInProc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:111: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r3, .L42	@ tmp135,
@ C_Code.c:109: void SetCurrentAnimInProc(struct Anim* anim) { 
	movs	r5, r0	@ anim, tmp208
@ C_Code.c:111: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r0, .L42+4	@ tmp134,
	bl	.L31		@
@ C_Code.c:79: 	proc->anim2 = NULL; 
	movs	r3, #0	@ tmp136,
@ C_Code.c:93: 	proc->buttonsToPress = 0; 
	movs	r2, #84	@ tmp138,
@ C_Code.c:79: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp136, proc_23->anim2
@ C_Code.c:82: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp136, proc_23->timer
@ C_Code.c:93: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r2]	@ tmp136, proc_23->buttonsToPress
@ C_Code.c:88: 	proc->currentRound = NULL; 
	str	r3, [r0, #60]	@ tmp136, proc_23->currentRound
@ C_Code.c:89: 	proc->active_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp136, proc_23->active_bunit
@ C_Code.c:90: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #68]	@ tmp136, proc_23->opp_bunit
@ C_Code.c:84: 	proc->hitOnTime = false; 
	str	r3, [r0, #72]	@ tmp136, MEM <unsigned int> [(unsigned char *)proc_23 + 72B]
@ C_Code.c:86: 	proc->loadedImg = false; // reload after each round 
	ldr	r3, .L42+8	@ tmp145,
	str	r3, [r0, #76]	@ tmp145, MEM <unsigned int> [(unsigned char *)proc_23 + 76B]
@ C_Code.c:95: 	proc->codefframe = 0xff;
	movs	r3, #255	@ tmp147,
	subs	r2, r2, #4	@ tmp146,
	strh	r3, [r0, r2]	@ tmp147, MEM <unsigned short> [(unsigned char *)proc_23 + 80B]
@ C_Code.c:96: 	proc->EkrEfxIsUnitHittedNowFrames = 0xff; 
	adds	r2, r2, #2	@ tmp149,
	strb	r3, [r0, r2]	@ tmp147, proc_23->EkrEfxIsUnitHittedNowFrames
@ C_Code.c:111: 	proc = Proc_Find(TimedHitsProcCmd); 
	movs	r4, r0	@ proc, tmp209
@ C_Code.c:116: 	proc->anim = anim; 
	str	r5, [r0, #44]	@ anim, proc_23->anim
@ C_Code.c:117: 	proc->anim2 = GetAnimAnotherSide(anim); 
	ldr	r3, .L42+12	@ tmp152,
	movs	r0, r5	@, anim
	bl	.L31		@
@ C_Code.c:117: 	proc->anim2 = GetAnimAnotherSide(anim); 
	str	r0, [r4, #48]	@ _1, proc_23->anim2
@ C_Code.c:119: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	ldrh	r2, [r5, #14]	@ _2,
@ C_Code.c:119: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	ldrh	r3, [r0, #14]	@ _3,
@ C_Code.c:119: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	cmp	r2, r3	@ _2, _3
	bls	.L33		@,
@ C_Code.c:119: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	subs	r2, r2, #1	@ tmp154,
	lsls	r2, r2, #24	@ tmp155, tmp154,
	lsrs	r0, r2, #24	@ iftmp.0_18, tmp155,
.L34:
@ C_Code.c:119: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	movs	r3, #73	@ tmp159,
	strb	r0, [r4, r3]	@ iftmp.0_18, proc_23->roundId
@ C_Code.c:120: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	ldr	r3, .L42+16	@ tmp161,
	bl	.L31		@
@ C_Code.c:121: 	proc->side = GetAnimPosition(anim) ^ 1; 
	ldr	r3, .L42+20	@ tmp162,
@ C_Code.c:120: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	str	r0, [r4, #60]	@ tmp211, proc_23->currentRound
@ C_Code.c:121: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r0, r5	@, anim
	bl	.L31		@
@ C_Code.c:121: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r3, #1	@ tmp164,
@ C_Code.c:121: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r2, #77	@ tmp167,
@ C_Code.c:121: 	proc->side = GetAnimPosition(anim) ^ 1; 
	lsls	r0, r0, #24	@ tmp163, tmp212,
	asrs	r0, r0, #24	@ _9, tmp163,
	eors	r3, r0	@ tmp166, _9
@ C_Code.c:121: 	proc->side = GetAnimPosition(anim) ^ 1; 
	strb	r3, [r4, r2]	@ tmp166, proc_23->side
@ C_Code.c:122: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, .L42+24	@ tmp169,
@ C_Code.c:123: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, .L42+28	@ tmp170,
@ C_Code.c:122: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, [r3]	@ gpEkrBattleUnitLeft.1_12, gpEkrBattleUnitLeft
@ C_Code.c:123: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, [r2]	@ gpEkrBattleUnitRight.2_13, gpEkrBattleUnitRight
@ C_Code.c:122: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	str	r3, [r4, #64]	@ gpEkrBattleUnitLeft.1_12, proc_23->active_bunit
@ C_Code.c:123: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #68]	@ gpEkrBattleUnitRight.2_13, proc_23->opp_bunit
@ C_Code.c:124: 	if (!proc->side) { 
	cmp	r0, #1	@ _9,
	bne	.L35		@,
@ C_Code.c:125: 		proc->active_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #64]	@ gpEkrBattleUnitRight.2_13, proc_23->active_bunit
@ C_Code.c:126: 		proc->opp_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #68]	@ gpEkrBattleUnitLeft.1_12, proc_23->opp_bunit
.L35:
@ C_Code.c:128: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r2, [r4, #60]	@ _14, proc_23->currentRound
@ C_Code.c:128: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r3, [r2]	@ *_14, *_14
@ C_Code.c:128: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsls	r3, r3, #30	@ tmp213, *_14,
	bmi	.L32		@,
@ C_Code.c:128: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	movs	r3, #3	@ tmp177,
	ldrsb	r3, [r2, r3]	@ tmp177,
	cmp	r3, #0	@ tmp177,
	beq	.L32		@,
@ C_Code.c:129: 	if (!proc->loadedImg) {
	movs	r6, #76	@ tmp178,
@ C_Code.c:129: 	if (!proc->loadedImg) {
	ldrb	r3, [r4, r6]	@ tmp179,
	cmp	r3, #0	@ tmp179,
	beq	.L41		@,
.L32:
@ C_Code.c:141: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L33:
@ C_Code.c:119: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	subs	r3, r3, #1	@ tmp157,
	lsls	r3, r3, #24	@ tmp158, tmp157,
	lsrs	r0, r3, #24	@ iftmp.0_18, tmp158,
	b	.L34		@
.L41:
@ C_Code.c:131: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r5, .L42+32	@ tmp183,
	movs	r2, #6	@,
@ C_Code.c:130: 		proc->timer2 = 0; 
	str	r3, [r4, #56]	@ tmp179, proc_23->timer2
@ C_Code.c:131: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r0, .L42+36	@ tmp182,
	ldr	r1, .L42+40	@,
	adds	r3, r3, #2	@,
	bl	.L44		@
@ C_Code.c:132: 		Copy2dChr(&BattleStar, (void*)0x06012a40, 2, 2); // 0x108 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+44	@ tmp185,
	ldr	r1, .L42+48	@,
	bl	.L44		@
@ C_Code.c:133: 		Copy2dChr(&A_Button, (void*)0x06012800, 2, 2); // 0x140
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+52	@ tmp188,
	ldr	r1, .L42+56	@,
	bl	.L44		@
@ C_Code.c:134: 		Copy2dChr(&B_Button, (void*)0x06012840, 2, 2); // 0x142 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+60	@ tmp191,
	ldr	r1, .L42+64	@,
	bl	.L44		@
@ C_Code.c:135: 		Copy2dChr(&Left_Button, (void*)0x06012880, 2, 2); // 0x144
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+68	@ tmp194,
	ldr	r1, .L42+72	@,
	bl	.L44		@
@ C_Code.c:136: 		Copy2dChr(&Right_Button, (void*)0x060128C0, 2, 2); // 0x146
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+76	@ tmp197,
	ldr	r1, .L42+80	@,
	bl	.L44		@
@ C_Code.c:137: 		Copy2dChr(&Up_Button, (void*)0x06012900, 2, 2); // 0x148
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+84	@ tmp200,
	ldr	r1, .L42+88	@,
	bl	.L44		@
@ C_Code.c:138: 		Copy2dChr(&Down_Button, (void*)0x06012940, 2, 2); // 0x14a
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+92	@ tmp203,
	ldr	r1, .L42+96	@,
	bl	.L44		@
@ C_Code.c:139: 		proc->loadedImg = true;
	movs	r3, #1	@ tmp206,
	strb	r3, [r4, r6]	@ tmp206, proc_23->loadedImg
	b	.L32		@
.L43:
	.align	2
.L42:
	.word	Proc_Find
	.word	.LANCHOR0
	.word	-16711936
	.word	GetAnimAnotherSide
	.word	GetCurrentRound
	.word	GetAnimPosition
	.word	gpEkrBattleUnitLeft
	.word	gpEkrBattleUnitRight
	.word	Copy2dChr
	.word	Press_Image
	.word	100739456
	.word	BattleStar
	.word	100739648
	.word	A_Button
	.word	100739072
	.word	B_Button
	.word	100739136
	.word	Left_Button
	.word	100739200
	.word	Right_Button
	.word	100739264
	.word	Up_Button
	.word	100739328
	.word	Down_Button
	.word	100739392
	.size	SetCurrentAnimInProc, .-SetCurrentAnimInProc
	.align	1
	.p2align 2,,3
	.global	BreakOnce
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	BreakOnce, %function
BreakOnce:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:202: 	if (proc->broke) { return; } 
	movs	r3, #75	@ tmp115,
@ C_Code.c:202: 	if (proc->broke) { return; } 
	ldrb	r2, [r0, r3]	@ tmp116,
	cmp	r2, #0	@ tmp116,
	bne	.L45		@,
@ C_Code.c:203: 	proc->broke = true; 
	adds	r2, r2, #1	@ tmp118,
	strb	r2, [r0, r3]	@ tmp118, proc_4(D)->broke
@ C_Code.c:204: 	asm("mov r11, r11");
	.syntax divided
@ 204 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L45:
@ C_Code.c:205: } 
	@ sp needed	@
	bx	lr
	.size	BreakOnce, .-BreakOnce
	.align	1
	.p2align 2,,3
	.global	HitNow
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	HitNow, %function
HitNow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:230: 	if (!HpProc) { return false; } // 
	cmp	r1, #0	@ tmp125,
	beq	.L49		@,
@ C_Code.c:232: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #82	@ tmp118,
@ C_Code.c:232: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r0, [r0, r3]	@ tmp120,
@ C_Code.c:230: 	if (!HpProc) { return false; } // 
	rsbs	r3, r0, #0	@ tmp122, tmp120
	adcs	r0, r0, r3	@ <retval>, tmp120, tmp122
.L47:
@ C_Code.c:234: } 
	@ sp needed	@
	bx	lr
.L49:
@ C_Code.c:230: 	if (!HpProc) { return false; } // 
	movs	r0, #0	@ <retval>,
	b	.L47		@
	.size	HitNow, .-HitNow
	.align	1
	.p2align 2,,3
	.global	GetButtonsToPress
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetButtonsToPress, %function
GetButtonsToPress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r2, .L53	@ tmp117,
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r2, [r2]	@ AlwaysA, AlwaysA
@ C_Code.c:249: int GetButtonsToPress(TimedHitsProc* proc) { 
	movs	r3, r0	@ proc, tmp121
	push	{r4, lr}	@
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	cmp	r2, #0	@ AlwaysA,
	bne	.L52		@,
@ C_Code.c:251: 	int keys = proc->buttonsToPress;
	adds	r2, r2, #84	@ tmp119,
@ C_Code.c:251: 	int keys = proc->buttonsToPress;
	ldrh	r0, [r0, r2]	@ <retval>,
@ C_Code.c:252: 	if (!keys) { 
	cmp	r0, #0	@ <retval>,
	bne	.L50		@,
	movs	r0, r3	@, proc
	bl	GetButtonsToPress.part.0		@
.L50:
@ C_Code.c:283: } 
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L52:
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	movs	r0, #1	@ <retval>,
	b	.L50		@
.L54:
	.align	2
.L53:
	.word	AlwaysA
	.size	GetButtonsToPress, .-GetButtonsToPress
	.align	1
	.p2align 2,,3
	.global	CountKeysPressed
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CountKeysPressed, %function
CountKeysPressed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r1, r0	@ keys, tmp129
	movs	r3, #1	@ pretmp_5,
	movs	r2, #5	@ ivtmp_1,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r1	@ tmp119, keys
@ C_Code.c:286: int CountKeysPressed(u32 keys) { 
	push	{r4, r5, r6, lr}	@
@ C_Code.c:287: 	int c = 0; 
	movs	r0, #0	@ <retval>,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r4, r3, #1	@ tmp126, tmp119
	sbcs	r3, r3, r4	@ tmp125, tmp119, tmp126
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	subs	r2, r2, #1	@ ivtmp_1,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r5, #32	@ tmp128,
	ldr	r6, .L62	@ tmp127,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r0, r0, r3	@ <retval>, <retval>, tmp125
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	cmp	r2, #0	@ ivtmp_1,
	beq	.L55		@,
.L61:
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r3, r6, r0	@ tmp122, tmp127, <retval>
	ldrb	r3, [r3, r5]	@ pretmp_5, RomKeysList
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r1	@ tmp119, keys
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r4, r3, #1	@ tmp126, tmp119
	sbcs	r3, r3, r4	@ tmp125, tmp119, tmp126
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	subs	r2, r2, #1	@ ivtmp_1,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r0, r0, r3	@ <retval>, <retval>, tmp125
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	cmp	r2, #0	@ ivtmp_1,
	bne	.L61		@,
.L55:
@ C_Code.c:293: } 
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L63:
	.align	2
.L62:
	.word	.LANCHOR0
	.size	CountKeysPressed, .-CountKeysPressed
	.align	1
	.p2align 2,,3
	.global	PressedSpecificKeys
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	PressedSpecificKeys, %function
PressedSpecificKeys:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r8	@,
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, .L103	@ tmp145,
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:295: int PressedSpecificKeys(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r1	@ keys, tmp218
	push	{lr}	@
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	cmp	r3, #0	@ AlwaysA,
	beq	.LCB531	@
	b	.L83	@long jump	@
.LCB531:
@ C_Code.c:251: 	int keys = proc->buttonsToPress;
	adds	r3, r3, #84	@ tmp147,
	ldrh	r3, [r0, r3]	@ keys,
	mov	r8, r3	@ keys, keys
@ C_Code.c:252: 	if (!keys) { 
	cmp	r3, #0	@ keys,
	beq	.L66		@,
.L96:
@ C_Code.c:297: 	int count = CountKeysPressed(reqKeys); 
	mov	r0, r8	@ _23, keys
.L65:
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	movs	r3, #1	@ pretmp_6,
	movs	r1, #5	@ ivtmp_35,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r0	@ tmp148, _23
@ C_Code.c:287: 	int c = 0; 
	movs	r2, #0	@ c,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp179, tmp148
	sbcs	r3, r3, r6	@ tmp178, tmp148, tmp179
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r5, .L103+4	@ tmp215,
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	subs	r1, r1, #1	@ ivtmp_35,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	mov	ip, r5	@ tmp215, tmp215
	movs	r7, #32	@ tmp216,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r2, r2, r3	@ c, c, tmp178
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	cmp	r1, #0	@ ivtmp_35,
	beq	.L84		@,
.L98:
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	mov	r3, ip	@ tmp215, tmp215
	adds	r3, r3, r2	@ tmp151, tmp215, c
	ldrb	r3, [r3, r7]	@ pretmp_6, RomKeysList
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r0	@ tmp148, _23
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp179, tmp148
	sbcs	r3, r3, r6	@ tmp178, tmp148, tmp179
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	subs	r1, r1, #1	@ ivtmp_35,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r2, r2, r3	@ c, c, tmp178
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	cmp	r1, #0	@ ivtmp_35,
	bne	.L98		@,
.L84:
	movs	r3, #1	@ prephitmp_11,
	movs	r1, #5	@ ivtmp_43,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp152, keys
@ C_Code.c:287: 	int c = 0; 
	movs	r0, #0	@ c,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp182, tmp152
	sbcs	r3, r3, r6	@ tmp181, tmp152, tmp182
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r5, .L103+4	@ tmp213,
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	subs	r1, r1, #1	@ ivtmp_43,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	mov	ip, r5	@ tmp213, tmp213
	movs	r7, #32	@ tmp214,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r0, r0, r3	@ c, c, tmp181
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	cmp	r1, #0	@ ivtmp_43,
	beq	.L71		@,
.L99:
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	mov	r3, ip	@ tmp213, tmp213
	adds	r3, r3, r0	@ tmp155, tmp213, c
	ldrb	r3, [r3, r7]	@ prephitmp_11, RomKeysList
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp152, keys
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp182, tmp152
	sbcs	r3, r3, r6	@ tmp181, tmp152, tmp182
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	subs	r1, r1, #1	@ ivtmp_43,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r0, r0, r3	@ c, c, tmp181
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	cmp	r1, #0	@ ivtmp_43,
	bne	.L99		@,
.L71:
@ C_Code.c:298: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r2, r0	@ c, c
	blt	.L85		@,
	movs	r3, #1	@ prephitmp_59,
	movs	r0, #5	@ ivtmp_65,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp156, keys
@ C_Code.c:287: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r5, r3, #1	@ tmp185, tmp156
	sbcs	r3, r3, r5	@ tmp184, tmp156, tmp185
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	subs	r0, r0, #1	@ ivtmp_65,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r6, #32	@ tmp210,
	ldr	r7, .L103+4	@ tmp209,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp184
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	cmp	r0, #0	@ ivtmp_65,
	beq	.L74		@,
.L100:
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r3, r7, r1	@ tmp159, tmp209, c
	ldrb	r3, [r3, r6]	@ prephitmp_59, RomKeysList
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp156, keys
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r5, r3, #1	@ tmp185, tmp156
	sbcs	r3, r3, r5	@ tmp184, tmp156, tmp185
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	subs	r0, r0, #1	@ ivtmp_65,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp184
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	cmp	r0, #0	@ ivtmp_65,
	bne	.L100		@,
.L74:
@ C_Code.c:298: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	movs	r3, #1	@ tmp161,
@ C_Code.c:298: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r2, r1	@ tmp160, c, c
@ C_Code.c:298: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp160,
	ble	.L97		@,
.L80:
	lsls	r3, r3, #24	@ tmp175, tmp171,
	lsrs	r3, r3, #24	@ iftmp.9_19, tmp175,
@ C_Code.c:298: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	bne	.L101		@,
@ C_Code.c:299: 	return (keys & reqKeys); 
	mov	r0, r8	@ keys, keys
	ands	r0, r4	@ keys, keys
.L64:
@ C_Code.c:300: } 
	@ sp needed	@
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L101:
@ C_Code.c:298: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	movs	r0, #0	@ <retval>,
	b	.L64		@
.L66:
	bl	GetButtonsToPress.part.0		@
	mov	r8, r0	@ keys, tmp219
	b	.L96		@
.L85:
	movs	r3, #1	@ pretmp_10,
	movs	r0, #5	@ ivtmp_51,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp166, keys
@ C_Code.c:287: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r5, r3, #1	@ tmp193, tmp166
	sbcs	r3, r3, r5	@ tmp192, tmp166, tmp193
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	subs	r0, r0, #1	@ ivtmp_51,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r6, #32	@ tmp212,
	ldr	r7, .L103+4	@ tmp211,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp192
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	cmp	r0, #0	@ ivtmp_51,
	beq	.L79		@,
.L102:
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r3, r7, r1	@ tmp169, tmp211, c
	ldrb	r3, [r3, r6]	@ pretmp_10, RomKeysList
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp166, keys
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r5, r3, #1	@ tmp193, tmp166
	sbcs	r3, r3, r5	@ tmp192, tmp166, tmp193
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	subs	r0, r0, #1	@ ivtmp_51,
@ C_Code.c:289: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp192
@ C_Code.c:288: 	for (int i = 0; i < 5; ++i) { 
	cmp	r0, #0	@ ivtmp_51,
	bne	.L102		@,
.L79:
@ C_Code.c:298: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	movs	r3, #1	@ tmp171,
@ C_Code.c:298: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r1, r2	@ tmp170, c, c
@ C_Code.c:298: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp170,
	bgt	.L80		@,
.L97:
	movs	r3, #0	@ tmp171,
	b	.L80		@
.L83:
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	movs	r3, #1	@ keys,
	movs	r0, #1	@ _23,
	mov	r8, r3	@ keys, keys
	b	.L65		@
.L104:
	.align	2
.L103:
	.word	AlwaysA
	.word	.LANCHOR0
	.size	PressedSpecificKeys, .-PressedSpecificKeys
	.align	1
	.p2align 2,,3
	.global	SaveInputFrame
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SaveInputFrame, %function
SaveInputFrame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:301: void SaveInputFrame(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r0	@ proc, tmp151
@ C_Code.c:302: 	struct Anim* anim = proc->anim; 
	ldr	r0, [r0, #44]	@ anim, proc_18(D)->anim
@ C_Code.c:303: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r5, [r0, #32]	@ _1, anim_19->pScrCurrent
@ C_Code.c:303: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r2, [r5]	@ instruction, *_1
@ C_Code.c:303: 	u32 instruction = *anim->pScrCurrent++; 
	adds	r3, r5, #4	@ tmp130, _1,
	str	r3, [r0, #32]	@ tmp130, anim_19->pScrCurrent
@ C_Code.c:304: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	lsls	r3, r2, #2	@ tmp132, instruction,
	lsrs	r3, r3, #26	@ tmp133, tmp132,
@ C_Code.c:304: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	cmp	r3, #5	@ tmp133,
	beq	.L112		@,
.L106:
@ C_Code.c:312: 	instruction = *anim->pScrCurrent--; 
	str	r5, [r0, #32]	@ _1, anim_19->pScrCurrent
@ C_Code.c:313: 	if (PressedSpecificKeys(proc, keys)) { 
	movs	r0, r4	@, proc
	bl	PressedSpecificKeys		@
@ C_Code.c:313: 	if (PressedSpecificKeys(proc, keys)) { 
	cmp	r0, #0	@ tmp153,
	beq	.L105		@,
@ C_Code.c:314: 		if (!proc->frame) { 
	movs	r3, #78	@ tmp143,
@ C_Code.c:314: 		if (!proc->frame) { 
	ldrb	r2, [r4, r3]	@ tmp144,
	cmp	r2, #0	@ tmp144,
	beq	.L113		@,
.L105:
@ C_Code.c:319: }  
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L112:
@ C_Code.c:305: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	adds	r3, r3, #250	@ tmp134,
	ands	r3, r2	@ _5, instruction
@ C_Code.c:305: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	cmp	r3, #4	@ _5,
	beq	.L114		@,
@ C_Code.c:308: 		if (ANINS_COMMAND_GET_ID(instruction) == 0xF) {
	cmp	r3, #15	@ _5,
	bne	.L106		@,
@ C_Code.c:309: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_18(D)->timer, proc_18(D)->timer
	adds	r3, r3, #65	@ tmp141,
	strb	r2, [r4, r3]	@ proc_18(D)->timer,
@ C_Code.c:309: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	movs	r3, #0	@ tmp142,
	str	r3, [r4, #56]	@ tmp142, proc_18(D)->timer2
	b	.L106		@
.L113:
@ C_Code.c:316: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	movs	r1, #128	@,
	movs	r0, #159	@,
@ C_Code.c:315: 			proc->frame = proc->timer; // locate is side for stereo? 
	ldr	r2, [r4, #52]	@ proc_18(D)->timer, proc_18(D)->timer
@ C_Code.c:316: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r1, r1, #1	@,,
@ C_Code.c:315: 			proc->frame = proc->timer; // locate is side for stereo? 
	strb	r2, [r4, r3]	@ proc_18(D)->timer, proc_18(D)->frame
@ C_Code.c:316: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r0, r0, #1	@,,
	movs	r2, #120	@,
	ldr	r4, .L115	@ tmp150,
	subs	r3, r3, #77	@,
	bl	.L117		@
@ C_Code.c:319: }  
	b	.L105		@
.L114:
@ C_Code.c:306: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_18(D)->timer, proc_18(D)->timer
	adds	r3, r3, #75	@ tmp137,
	strb	r2, [r4, r3]	@ proc_18(D)->timer,
@ C_Code.c:306: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	movs	r3, #0	@ tmp138,
	str	r3, [r4, #56]	@ tmp138, proc_18(D)->timer2
	b	.L106		@
.L116:
	.align	2
.L115:
	.word	PlaySFX
	.size	SaveInputFrame, .-SaveInputFrame
	.align	1
	.p2align 2,,3
	.global	SaveIfWeHitOnTime
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SaveIfWeHitOnTime, %function
SaveIfWeHitOnTime:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:323: 		if (ABS(num - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; }
	movs	r2, #78	@ tmp128,
@ C_Code.c:321: 	int num = proc->codefframe; 
	movs	r3, #80	@ tmp127,
@ C_Code.c:323: 		if (ABS(num - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; }
	ldrb	r1, [r0, r2]	@ _20,
@ C_Code.c:321: 	int num = proc->codefframe; 
	ldrb	r3, [r0, r3]	@ num,
@ C_Code.c:323: 		if (ABS(num - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; }
	ldr	r2, .L124	@ tmp129,
	ldr	r2, [r2]	@ pretmp_31, LenienceFrames
@ C_Code.c:322: 	if (num != 0xFF) { 
	cmp	r3, #255	@ num,
	beq	.L119		@,
.L123:
@ C_Code.c:323: 		if (ABS(num - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; }
	subs	r3, r3, r1	@ tmp130, num, _20
	asrs	r1, r3, #31	@ tmp141, tmp130,
	adds	r3, r3, r1	@ tmp131, tmp130, tmp141
	eors	r3, r1	@ tmp131, tmp141
@ C_Code.c:323: 		if (ABS(num - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; }
	cmp	r3, r2	@ tmp131, pretmp_31
	bge	.L118		@,
.L122:
@ C_Code.c:323: 		if (ABS(num - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; }
	movs	r3, #72	@ tmp132,
	movs	r2, #1	@ tmp133,
	strb	r2, [r0, r3]	@ tmp133, proc_16(D)->hitOnTime
.L118:
@ C_Code.c:328: }
	@ sp needed	@
	bx	lr
.L119:
@ C_Code.c:325: 	else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	movs	r3, #79	@ tmp135,
	ldrb	r3, [r0, r3]	@ _7,
@ C_Code.c:325: 	else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	cmp	r3, #255	@ _7,
	bne	.L123		@,
@ C_Code.c:326: 	else if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; }
	ldr	r3, [r0, #52]	@ proc_16(D)->timer, proc_16(D)->timer
	subs	r3, r3, r1	@ tmp138, proc_16(D)->timer, _20
@ C_Code.c:326: 	else if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; }
	cmp	r3, r2	@ tmp138, pretmp_31
	blt	.L122		@,
	b	.L118		@
.L125:
	.align	2
.L124:
	.word	LenienceFrames
	.size	SaveIfWeHitOnTime, .-SaveIfWeHitOnTime
	.align	1
	.p2align 2,,3
	.global	CheatCodeOn
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CheatCodeOn, %function
CheatCodeOn:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:331: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L127	@ tmp117,
@ C_Code.c:332: } 
	@ sp needed	@
@ C_Code.c:331: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldrb	r0, [r3, #31]	@ tmp119,
	movs	r3, #127	@ tmp121,
	bics	r0, r3	@ tmp116, tmp121
@ C_Code.c:332: } 
	bx	lr
.L128:
	.align	2
.L127:
	.word	gPlaySt
	.size	CheatCodeOn, .-CheatCodeOn
	.align	1
	.p2align 2,,3
	.global	DidWeHitOnTime
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DidWeHitOnTime, %function
DidWeHitOnTime:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:331: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L133	@ tmp119,
@ C_Code.c:335: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp122,
	cmp	r3, #127	@ tmp122,
	bhi	.L132		@,
@ C_Code.c:336: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L133+4	@ tmp123,
@ C_Code.c:336: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L132		@,
@ C_Code.c:337: 	return proc->hitOnTime;
	adds	r3, r3, #72	@ tmp125,
	ldrb	r0, [r0, r3]	@ <retval>,
	b	.L129		@
.L132:
@ C_Code.c:335: 	if (CheatCodeOn()) { return true; } 
	movs	r0, #1	@ <retval>,
.L129:
@ C_Code.c:338: }
	@ sp needed	@
	bx	lr
.L134:
	.align	2
.L133:
	.word	gPlaySt
	.word	AlwaysWork
	.size	DidWeHitOnTime, .-DidWeHitOnTime
	.align	1
	.p2align 2,,3
	.global	DrawButtonsToPress
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DrawButtonsToPress, %function
DrawButtonsToPress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r5, r8	@,
	mov	lr, fp	@,
	mov	r7, r10	@,
	mov	r6, r9	@,
	push	{r5, r6, r7, lr}	@
	sub	sp, sp, #28	@,,
@ C_Code.c:340: void DrawButtonsToPress(TimedHitsProc* proc, int x, int y, int palID) { 
	movs	r5, r1	@ x, tmp219
	str	r1, [sp, #20]	@ x, %sfp
@ C_Code.c:346: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	lsls	r1, r1, #23	@ tmp146, x,
	lsrs	r1, r1, #23	@ _107, tmp146,
	mov	fp, r1	@ _107, _107
	movs	r1, #255	@ tmp147,
	ands	r1, r2	@ tmp147, y
	mov	r10, r1	@ _108, tmp147
@ C_Code.c:347: 	x += 32; 
	movs	r1, r5	@ tmp148, x
@ C_Code.c:345: 	int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); //OAM2_CHR(0);
	lsls	r4, r3, #28	@ tmp151, tmp221,
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, .L170	@ tmp152,
@ C_Code.c:347: 	x += 32; 
	adds	r1, r1, #32	@ tmp148,
@ C_Code.c:348: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	lsls	r1, r1, #23	@ tmp149, tmp148,
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:348: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	lsrs	r1, r1, #23	@ _110, tmp149,
@ C_Code.c:349: 	y += 16; x -= 36; 
	adds	r2, r2, #16	@ y,
@ C_Code.c:348: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	mov	r8, r1	@ _110, _110
@ C_Code.c:349: 	y += 16; x -= 36; 
	str	r2, [sp, #8]	@ y, %sfp
@ C_Code.c:345: 	int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); //OAM2_CHR(0);
	lsrs	r4, r4, #16	@ _111, tmp151,
@ C_Code.c:349: 	y += 16; x -= 36; 
	subs	r5, r5, #4	@ x,
@ C_Code.c:250: 	if (AlwaysA) { return A_BUTTON; } 
	cmp	r3, #0	@ AlwaysA,
	bne	.L136		@,
@ C_Code.c:251: 	int keys = proc->buttonsToPress;
	adds	r3, r3, #84	@ tmp154,
@ C_Code.c:251: 	int keys = proc->buttonsToPress;
	ldrh	r6, [r0, r3]	@ keys,
@ C_Code.c:252: 	if (!keys) { 
	cmp	r6, #0	@ keys,
	beq	.L164		@,
.L137:
@ C_Code.c:346: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	ldr	r3, .L170+4	@ tmp216,
	mov	r9, r3	@ tmp216, tmp216
	ldr	r7, .L170+8	@ tmp217,
	mov	r2, r10	@, _108
	mov	r1, fp	@, _107
	movs	r0, #2	@,
	adds	r3, r3, #40	@ tmp156,
	str	r4, [sp]	@ _111,
	bl	.L172		@
@ C_Code.c:348: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	mov	r3, r9	@ tmp159, tmp216
	mov	r2, r10	@, _108
	mov	r1, r8	@, _110
	adds	r3, r3, #48	@ tmp159,
	movs	r0, #2	@,
	str	r4, [sp]	@ _111,
	bl	.L172		@
@ C_Code.c:353: 	if (keys & B_BUTTON) { 
	movs	r3, #2	@ tmp161,
	ands	r3, r6	@ tmp161, keys
	mov	r8, r3	@ _65, tmp161
@ C_Code.c:356: 	if (keys & DPAD_LEFT) { 
	movs	r3, #32	@ tmp162,
	ands	r3, r6	@ tmp162, keys
	str	r3, [sp, #16]	@ tmp162, %sfp
@ C_Code.c:359: 	if (keys & DPAD_RIGHT) { 
	movs	r3, #16	@ tmp163,
	ands	r3, r6	@ tmp163, keys
@ C_Code.c:346: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	fp, r7	@ tmp217, tmp217
@ C_Code.c:359: 	if (keys & DPAD_RIGHT) { 
	movs	r7, r3	@ prephitmp_67, tmp163
@ C_Code.c:362: 	if (keys & DPAD_UP) { 
	movs	r3, #64	@ tmp164,
	ands	r3, r6	@ tmp164, keys
	str	r3, [sp, #12]	@ tmp164, %sfp
@ C_Code.c:365: 	if (keys & DPAD_DOWN) { 
	movs	r3, #128	@ tmp165,
	ands	r3, r6	@ tmp165, keys
	mov	r10, r3	@ prephitmp_36, tmp165
@ C_Code.c:350: 	if (keys & A_BUTTON) { 
	lsls	r6, r6, #31	@ tmp223, keys,
	bmi	.L144		@,
@ C_Code.c:353: 	if (keys & B_BUTTON) { 
	mov	r3, r8	@ _65, _65
	cmp	r3, #0	@ _65,
	bne	.L165		@,
.L139:
@ C_Code.c:356: 	if (keys & DPAD_LEFT) { 
	ldr	r3, [sp, #16]	@ prephitmp_69, %sfp
	cmp	r3, #0	@ prephitmp_69,
	bne	.L166		@,
.L140:
@ C_Code.c:359: 	if (keys & DPAD_RIGHT) { 
	cmp	r7, #0	@ prephitmp_67,
	bne	.L167		@,
.L141:
@ C_Code.c:362: 	if (keys & DPAD_UP) { 
	ldr	r3, [sp, #12]	@ prephitmp_68, %sfp
	cmp	r3, #0	@ prephitmp_68,
	bne	.L168		@,
.L142:
@ C_Code.c:365: 	if (keys & DPAD_DOWN) { 
	mov	r3, r10	@ prephitmp_36, prephitmp_36
	cmp	r3, #0	@ prephitmp_36,
	bne	.L169		@,
.L135:
@ C_Code.c:372: } 
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L164:
	bl	GetButtonsToPress.part.0		@
	movs	r6, r0	@ keys, tmp222
	b	.L137		@
.L136:
@ C_Code.c:346: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	ldr	r3, .L170+4	@ tmp216,
	mov	r9, r3	@ tmp216, tmp216
	mov	r2, r10	@, _108
	mov	r1, fp	@, _107
	ldr	r6, .L170+8	@ tmp217,
	movs	r0, #2	@,
	adds	r3, r3, #40	@ tmp211,
	str	r4, [sp]	@ _111,
	bl	.L173		@
@ C_Code.c:348: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	mov	r3, r9	@ tmp214, tmp216
	mov	r2, r10	@, _108
	mov	r1, r8	@, _110
	adds	r3, r3, #48	@ tmp214,
	movs	r0, #2	@,
	str	r4, [sp]	@ _111,
	bl	.L173		@
	movs	r3, #0	@ prephitmp_36,
@ C_Code.c:346: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	fp, r6	@ tmp217, tmp217
@ C_Code.c:348: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	mov	r10, r3	@ prephitmp_36, prephitmp_36
	movs	r7, r3	@ prephitmp_67, prephitmp_67
	mov	r8, r3	@ _65, _65
	str	r3, [sp, #12]	@ prephitmp_68, %sfp
	str	r3, [sp, #16]	@ prephitmp_69, %sfp
.L144:
@ C_Code.c:351: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	movs	r2, #255	@ tmp170,
	mov	r3, r9	@ tmp169, tmp216
	ldr	r1, [sp, #8]	@ _112, %sfp
	ands	r2, r1	@ tmp171, _112
	lsls	r1, r5, #23	@ tmp173, x,
	adds	r3, r3, #56	@ tmp169,
	movs	r0, #2	@,
	str	r4, [sp]	@ _111,
	lsrs	r1, r1, #23	@ tmp172, tmp173,
	bl	.L174		@
@ C_Code.c:353: 	if (keys & B_BUTTON) { 
	mov	r3, r8	@ _65, _65
@ C_Code.c:351: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	ldr	r5, [sp, #20]	@ x, %sfp
	adds	r5, r5, #14	@ x,
@ C_Code.c:353: 	if (keys & B_BUTTON) { 
	cmp	r3, #0	@ _65,
	beq	.L139		@,
.L165:
@ C_Code.c:354: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	movs	r2, #255	@ tmp177,
	mov	r3, r9	@ tmp176, tmp216
	ldr	r1, [sp, #8]	@ _112, %sfp
	ands	r2, r1	@ tmp178, _112
	lsls	r1, r5, #23	@ tmp180, x,
	adds	r3, r3, #64	@ tmp176,
	movs	r0, #2	@,
	str	r4, [sp]	@ _111,
	lsrs	r1, r1, #23	@ tmp179, tmp180,
	bl	.L174		@
@ C_Code.c:356: 	if (keys & DPAD_LEFT) { 
	ldr	r3, [sp, #16]	@ prephitmp_69, %sfp
@ C_Code.c:354: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	adds	r5, r5, #18	@ x,
@ C_Code.c:356: 	if (keys & DPAD_LEFT) { 
	cmp	r3, #0	@ prephitmp_69,
	beq	.L140		@,
.L166:
@ C_Code.c:357: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	movs	r2, #255	@ tmp184,
	mov	r3, r9	@ tmp183, tmp216
	ldr	r1, [sp, #8]	@ _112, %sfp
	ands	r2, r1	@ tmp185, _112
	lsls	r1, r5, #23	@ tmp187, x,
	movs	r0, #2	@,
	str	r4, [sp]	@ _111,
	adds	r3, r3, #72	@ tmp183,
	lsrs	r1, r1, #23	@ tmp186, tmp187,
	bl	.L174		@
@ C_Code.c:357: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	adds	r5, r5, #18	@ x,
@ C_Code.c:359: 	if (keys & DPAD_RIGHT) { 
	cmp	r7, #0	@ prephitmp_67,
	beq	.L141		@,
.L167:
@ C_Code.c:360: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	movs	r2, #255	@ tmp191,
	mov	r3, r9	@ tmp190, tmp216
	ldr	r1, [sp, #8]	@ _112, %sfp
	ands	r2, r1	@ tmp192, _112
	lsls	r1, r5, #23	@ tmp194, x,
	adds	r3, r3, #80	@ tmp190,
	movs	r0, #2	@,
	str	r4, [sp]	@ _111,
	lsrs	r1, r1, #23	@ tmp193, tmp194,
	bl	.L174		@
@ C_Code.c:362: 	if (keys & DPAD_UP) { 
	ldr	r3, [sp, #12]	@ prephitmp_68, %sfp
@ C_Code.c:360: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	adds	r5, r5, #18	@ x,
@ C_Code.c:362: 	if (keys & DPAD_UP) { 
	cmp	r3, #0	@ prephitmp_68,
	beq	.L142		@,
.L168:
@ C_Code.c:363: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	movs	r2, #255	@ tmp198,
	mov	r3, r9	@ tmp197, tmp216
	ldr	r1, [sp, #8]	@ _112, %sfp
	ands	r2, r1	@ tmp199, _112
	lsls	r1, r5, #23	@ tmp201, x,
	adds	r3, r3, #88	@ tmp197,
	movs	r0, #2	@,
	str	r4, [sp]	@ _111,
	lsrs	r1, r1, #23	@ tmp200, tmp201,
	bl	.L174		@
@ C_Code.c:365: 	if (keys & DPAD_DOWN) { 
	mov	r3, r10	@ prephitmp_36, prephitmp_36
@ C_Code.c:363: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	adds	r5, r5, #18	@ x,
@ C_Code.c:365: 	if (keys & DPAD_DOWN) { 
	cmp	r3, #0	@ prephitmp_36,
	beq	.L135		@,
.L169:
@ C_Code.c:366: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2); x += 18; 
	movs	r2, #255	@ tmp205,
	mov	r3, r9	@ tmp216, tmp216
	ldr	r1, [sp, #8]	@ _112, %sfp
	ands	r2, r1	@ tmp206, _112
	lsls	r1, r5, #23	@ tmp208, x,
	movs	r0, #2	@,
	str	r4, [sp]	@ _111,
	adds	r3, r3, #96	@ tmp216,
	lsrs	r1, r1, #23	@ tmp207, tmp208,
	bl	.L174		@
@ C_Code.c:372: } 
	b	.L135		@
.L171:
	.align	2
.L170:
	.word	AlwaysA
	.word	.LANCHOR0
	.word	PutSprite
	.size	DrawButtonsToPress, .-DrawButtonsToPress
	.align	1
	.p2align 2,,3
	.global	GetDefaultDamagePercent
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetDefaultDamagePercent, %function
GetDefaultDamagePercent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:435: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { return ReducedDamagePercent; } 
	movs	r2, #11	@ tmp119,
	movs	r3, #192	@ tmp120,
	ldrsb	r2, [r0, r2]	@ tmp119,
	ands	r3, r2	@ tmp121, tmp119
@ C_Code.c:435: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { return ReducedDamagePercent; } 
	cmp	r3, #128	@ tmp121,
	beq	.L178		@,
@ C_Code.c:436: 	return BonusDamagePercent; 
	ldr	r3, .L179	@ tmp123,
	ldr	r0, [r3]	@ <retval>,
.L175:
@ C_Code.c:437: } 
	@ sp needed	@
	bx	lr
.L178:
@ C_Code.c:435: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { return ReducedDamagePercent; } 
	ldr	r3, .L179+4	@ tmp122,
	ldr	r0, [r3]	@ <retval>,
	b	.L175		@
.L180:
	.align	2
.L179:
	.word	BonusDamagePercent
	.word	ReducedDamagePercent
	.size	GetDefaultDamagePercent, .-GetDefaultDamagePercent
	.align	1
	.p2align 2,,3
	.global	GetDamagePercent
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetDamagePercent, %function
GetDamagePercent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r2, #11	@ tmp119,
	movs	r3, #192	@ tmp120,
	ldrsb	r2, [r0, r2]	@ tmp119,
	ands	r3, r2	@ tmp121, tmp119
	cmp	r3, #128	@ tmp121,
	beq	.L184		@,
	ldr	r3, .L185	@ tmp123,
	ldr	r0, [r3]	@ <retval>,
.L181:
	@ sp needed	@
	bx	lr
.L184:
	ldr	r3, .L185+4	@ tmp122,
	ldr	r0, [r3]	@ <retval>,
	b	.L181		@
.L186:
	.align	2
.L185:
	.word	BonusDamagePercent
	.word	ReducedDamagePercent
	.size	GetDamagePercent, .-GetDamagePercent
	.align	1
	.p2align 2,,3
	.global	AdjustAllRounds
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	AdjustAllRounds, %function
AdjustAllRounds:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}	@
@ C_Code.c:445: 	for (int i = id; i < 22; i += 2) {
	cmp	r0, #21	@ id,
	bgt	.L187		@,
	ldr	r3, .L197	@ tmp127,
	lsls	r2, r0, #1	@ tmp126, id,
@ C_Code.c:447: 		if (hp == 0xffff) { break; }
	ldr	r5, .L197+4	@ tmp128,
	adds	r2, r2, r3	@ ivtmp.156, tmp126, tmp127
	b	.L191		@
.L189:
	movs	r4, #0	@ _4,
@ C_Code.c:449: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	cmp	r3, r1	@ _1, difference
	blt	.L190		@,
@ C_Code.c:449: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	subs	r3, r3, r1	@ tmp131, _1, difference
.L195:
	lsls	r3, r3, #16	@ tmp132, tmp131,
	lsrs	r4, r3, #16	@ _4, tmp132,
.L190:
@ C_Code.c:445: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:448: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_23]
@ C_Code.c:445: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.156,
	cmp	r0, #21	@ id,
	bgt	.L187		@,
.L191:
@ C_Code.c:446: 		hp = gEfxHpLut[i]; 
	ldrh	r3, [r2]	@ _1, MEM[(short unsigned int *)_23]
@ C_Code.c:447: 		if (hp == 0xffff) { break; }
	cmp	r3, r5	@ _1, tmp128
	beq	.L187		@,
@ C_Code.c:448: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r1, #0	@ difference,
	bge	.L189		@,
@ C_Code.c:448: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	adds	r3, r3, r1	@ hp, _1, difference
	movs	r4, #0	@ _4,
@ C_Code.c:448: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r3, #0	@ hp,
	bgt	.L195		@,
@ C_Code.c:445: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:448: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_23]
@ C_Code.c:445: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.156,
	cmp	r0, #21	@ id,
	ble	.L191		@,
.L187:
@ C_Code.c:463: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L198:
	.align	2
.L197:
	.word	gEfxHpLut
	.word	65535
	.size	AdjustAllRounds, .-AdjustAllRounds
	.align	1
	.p2align 2,,3
	.global	CheckForDeath
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CheckForDeath, %function
CheckForDeath:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r9	@,
	movs	r7, r2	@ active_bunit, tmp192
@ C_Code.c:472: 	int side = proc->side; 
	movs	r2, #77	@ tmp141,
@ C_Code.c:471: void CheckForDeath(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	push	{lr}	@
@ C_Code.c:471: void CheckForDeath(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	mov	r9, r3	@ opp_bunit, tmp193
	ldr	r3, [sp, #28]	@ hp, hp
	movs	r4, r0	@ proc, tmp190
	movs	r6, r1	@ HpProc, tmp191
@ C_Code.c:472: 	int side = proc->side; 
	ldrb	r5, [r0, r2]	@ _1,
@ C_Code.c:476: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	cmp	r3, #0	@ hp,
	blt	.L202		@,
@ C_Code.c:477: 	if (hp <= 0) { // they are dead 
	ble	.L203		@,
.L199:
@ C_Code.c:516: }
	@ sp needed	@
	pop	{r7}
	mov	r9, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L202:
@ C_Code.c:475: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	ldr	r3, .L204	@ tmp142,
	lsls	r2, r5, #1	@ tmp143, _1,
	ldrsh	r0, [r2, r3]	@ tmp144, gEfxHpLutOff
@ C_Code.c:475: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r0, r0, #1	@ tmp145, tmp144,
@ C_Code.c:476: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	ldr	r3, .L204+4	@ tmp147,
@ C_Code.c:475: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	adds	r0, r0, r5	@ id, tmp145, _1
@ C_Code.c:476: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	bl	.L31		@
@ C_Code.c:476: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	ldr	r3, [sp, #24]	@ tmp201, round
	ldrb	r3, [r3, #3]	@ tmp150,
	lsls	r3, r3, #24	@ tmp150, tmp150,
	asrs	r3, r3, #24	@ tmp150, tmp150,
@ C_Code.c:476: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	subs	r3, r0, r3	@ hp, tmp194, tmp150
@ C_Code.c:477: 	if (hp <= 0) { // they are dead 
	cmp	r3, #0	@ hp,
	bgt	.L199		@,
.L203:
@ C_Code.c:483: 		opp_bunit->unit.curHP = 0; 
	movs	r3, #0	@ tmp151,
	mov	r2, r9	@ opp_bunit, opp_bunit
	strb	r3, [r2, #19]	@ tmp151, opp_bunit_30(D)->unit.curHP
@ C_Code.c:485: 		proc->code4frame = 0xff;
	movs	r2, #255	@ tmp155,
@ C_Code.c:484: 		HpProc->post = 0; 
	str	r3, [r6, #80]	@ tmp151, HpProc_32(D)->post
@ C_Code.c:485: 		proc->code4frame = 0xff;
	adds	r3, r3, #79	@ tmp154,
	strb	r2, [r4, r3]	@ tmp155, proc_22(D)->code4frame
@ C_Code.c:489: 		HpProc->death = true; 
	subs	r3, r3, #78	@ tmp158,
	subs	r2, r2, #214	@ tmp157,
	strb	r3, [r6, r2]	@ tmp158, HpProc_32(D)->death
@ C_Code.c:494: 		proc->anim->nextRoundId = 8; // seems to mostly work for now? see GetAnimNextRoundType
	ldr	r1, [r4, #44]	@ proc_22(D)->anim, proc_22(D)->anim
	subs	r2, r2, #33	@ tmp161,
	strh	r2, [r1, #14]	@ tmp161, _9->nextRoundId
@ C_Code.c:495: 		proc->anim2->nextRoundId = 8; 
	ldr	r1, [r4, #48]	@ proc_22(D)->anim2, proc_22(D)->anim2
	strh	r2, [r1, #14]	@ tmp161, _10->nextRoundId
@ C_Code.c:497: 		gBanimDoneFlag[0] = true; // stop counterattacks ?
	ldr	r2, .L204+8	@ tmp166,
	str	r3, [r2]	@ tmp158, gBanimDoneFlag[0]
@ C_Code.c:498: 		gBanimDoneFlag[1] = true; // [201fb04..201fb07]!! - nothing else is writing to it. good. 
	str	r3, [r2, #4]	@ tmp158, gBanimDoneFlag[1]
@ C_Code.c:500: 		round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END; 
	movs	r2, #176	@ tmp170,
	ldr	r3, [sp, #24]	@ tmp203, round
	ldrb	r3, [r3, #2]	@ tmp173,
	orrs	r3, r2	@ tmp175, tmp170
	ldr	r2, [sp, #24]	@ tmp204, round
	strb	r3, [r2, #2]	@ tmp175,
@ C_Code.c:505: 		side = 1 ^ side; 
	movs	r3, #1	@ tmp180,
@ C_Code.c:506: 		id = (gEfxHpLutOff[side] * 2) + (side);
	ldr	r2, .L204	@ tmp181,
@ C_Code.c:505: 		side = 1 ^ side; 
	eors	r3, r5	@ side, _1
@ C_Code.c:506: 		id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r1, r3, #1	@ tmp182, side,
	ldrsh	r0, [r1, r2]	@ tmp183, gEfxHpLutOff
@ C_Code.c:506: 		id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r0, r0, #1	@ tmp184, tmp183,
@ C_Code.c:506: 		id = (gEfxHpLutOff[side] * 2) + (side);
	adds	r0, r0, r3	@ id, tmp184, side
@ C_Code.c:507: 		hp = GetEfxHp(id); 
	ldr	r3, .L204+4	@ tmp186,
	bl	.L31		@
@ C_Code.c:509: 		active_bunit->unit.curHP = hp; 
	strb	r0, [r7, #19]	@ tmp195, active_bunit_44(D)->unit.curHP
@ C_Code.c:516: }
	b	.L199		@
.L205:
	.align	2
.L204:
	.word	gEfxHpLutOff
	.word	GetEfxHp
	.word	gBanimDoneFlag
	.size	CheckForDeath, .-CheckForDeath
	.global	__aeabi_idiv
	.align	1
	.p2align 2,,3
	.global	AdjustDamageByPercent
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	AdjustDamageByPercent, %function
AdjustDamageByPercent:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r7, r10	@,
	mov	r5, r8	@,
	mov	lr, fp	@,
	mov	r6, r9	@,
	push	{r5, r6, r7, lr}	@
	movs	r7, r3	@ opp_bunit, tmp258
@ C_Code.c:521: 	int side = proc->side; 
	movs	r3, #77	@ tmp182,
@ C_Code.c:518: void AdjustDamageByPercent(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	mov	r10, r2	@ active_bunit, tmp257
@ C_Code.c:521: 	int side = proc->side; 
	ldrb	r2, [r0, r3]	@ side,
@ C_Code.c:522: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	ldr	r3, .L233	@ tmp183,
@ C_Code.c:518: void AdjustDamageByPercent(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	movs	r6, r1	@ HpProc, tmp256
@ C_Code.c:522: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r1, r2, #1	@ tmp184, side,
	ldrsh	r5, [r1, r3]	@ tmp185, gEfxHpLutOff
@ C_Code.c:522: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r5, r5, #1	@ tmp186, tmp185,
@ C_Code.c:522: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	adds	r5, r5, r2	@ id, tmp186, side
@ C_Code.c:518: void AdjustDamageByPercent(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	mov	r8, r0	@ proc, tmp255
@ C_Code.c:523: 	int hp = GetEfxHp(id); // + round->hpChange; 
	ldr	r3, .L233+4	@ tmp187,
	movs	r0, r5	@, id
@ C_Code.c:518: void AdjustDamageByPercent(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	sub	sp, sp, #20	@,,
@ C_Code.c:523: 	int hp = GetEfxHp(id); // + round->hpChange; 
	bl	.L31		@
	subs	r4, r0, #0	@ tmp188, tmp259,
@ C_Code.c:524: 	if (!hp) { return; } 
	beq	.L206		@,
@ C_Code.c:526: 	int damage = (round->hpChange * percent) / 100; 
	ldr	r3, [sp, #56]	@ tmp268, round
	ldrb	r3, [r3, #3]	@ _7,
	lsls	r3, r3, #24	@ _7, _7,
	asrs	r3, r3, #24	@ _7, _7,
	mov	r9, r3	@ _7, _7
@ C_Code.c:526: 	int damage = (round->hpChange * percent) / 100; 
	ldr	r3, [sp, #60]	@ tmp270, percent
@ C_Code.c:526: 	int damage = (round->hpChange * percent) / 100; 
	movs	r1, #100	@,
@ C_Code.c:526: 	int damage = (round->hpChange * percent) / 100; 
	mov	r0, r9	@ tmp190, _7
	muls	r0, r3	@ tmp190, tmp270
@ C_Code.c:526: 	int damage = (round->hpChange * percent) / 100; 
	ldr	r3, .L233+8	@ tmp193,
	bl	.L31		@
@ C_Code.c:537: 		round->hpChange += damage; 
	mov	r3, r9	@ _7, _7
@ C_Code.c:538: 		if (UsingSkillSys) { round->overDmg -= damage; } // used by Huichelaar's banim numbers 
	ldr	r2, .L233+12	@ tmp196,
	ldr	r2, [r2]	@ pretmp_134, UsingSkillSys
@ C_Code.c:537: 		round->hpChange += damage; 
	lsls	r3, r3, #24	@ tmp195, _7,
@ C_Code.c:538: 		if (UsingSkillSys) { round->overDmg -= damage; } // used by Huichelaar's banim numbers 
	str	r2, [sp, #8]	@ pretmp_134, %sfp
@ C_Code.c:537: 		round->hpChange += damage; 
	lsrs	r3, r3, #24	@ _126, tmp195,
@ C_Code.c:527: 	if (damage > round->hpChange) { 
	cmp	r9, r0	@ _7, damage
	blt	.L231		@,
@ C_Code.c:542: 		damage = round->hpChange - damage; 
	mov	r2, r9	@ _7, _7
@ C_Code.c:540: 	else if (round->hpChange != hp) { 
	cmp	r9, r4	@ _7, tmp188
	beq	.L213		@,
@ C_Code.c:542: 		damage = round->hpChange - damage; 
	subs	r1, r2, r0	@ damage, _7, damage
@ C_Code.c:544: 		HpProc->post += damage;
	ldr	r2, [r6, #80]	@ HpProc_83(D)->post, HpProc_83(D)->post
	adds	r2, r2, r1	@ tmp212, HpProc_83(D)->post, damage
	str	r2, [r6, #80]	@ tmp212, HpProc_83(D)->post
@ C_Code.c:545: 		opp_bunit->unit.curHP += damage; 
	lsls	r2, r1, #24	@ tmp214, damage,
	lsrs	r2, r2, #24	@ _30, tmp214,
	str	r2, [sp, #12]	@ _30, %sfp
	ldrb	r2, [r7, #19]	@ tmp216,
	mov	fp, r2	@ tmp216, tmp216
	ldr	r2, [sp, #12]	@ _30, %sfp
	mov	ip, r2	@ _30, _30
	add	fp, fp, ip	@ tmp217, _30
	mov	r2, fp	@ tmp217, tmp217
	strb	r2, [r7, #19]	@ tmp217, opp_bunit_85(D)->unit.curHP
@ C_Code.c:546: 		round->hpChange -= damage; 
	mov	r2, ip	@ _30, _30
	subs	r2, r3, r2	@ tmp219, _126, _30
	lsls	r2, r2, #24	@ tmp220, tmp219,
	ldr	r3, [sp, #56]	@ tmp286, round
	asrs	r2, r2, #24	@ _19, tmp220,
	strb	r2, [r3, #3]	@ _19, round_79(D)->hpChange
@ C_Code.c:547: 		if (UsingSkillSys) { round->overDmg += damage; } // used by Huichelaar's banim numbers 
	ldr	r3, [sp, #8]	@ pretmp_134, %sfp
@ C_Code.c:543: 		hp += damage; 
	adds	r4, r4, r1	@ hp, tmp188, damage
@ C_Code.c:547: 		if (UsingSkillSys) { round->overDmg += damage; } // used by Huichelaar's banim numbers 
	cmp	r3, #0	@ pretmp_134,
	beq	.L214		@,
@ C_Code.c:547: 		if (UsingSkillSys) { round->overDmg += damage; } // used by Huichelaar's banim numbers 
	ldr	r3, [sp, #56]	@ tmp288, round
	ldrh	r3, [r3, #6]	@ tmp223,
	adds	r3, r3, r1	@ tmp225, tmp223, damage
	ldr	r1, [sp, #56]	@ tmp289, round
	strh	r3, [r1, #6]	@ tmp225, round_79(D)->overDmg
.L214:
@ C_Code.c:548: 		damage = 0 - damage;
	mov	r3, r9	@ _7, _7
	subs	r1, r0, r3	@ damage, damage, _7
	mvns	r3, r4	@ tmp254, hp
	asrs	r3, r3, #31	@ tmp253, tmp254,
	ands	r4, r3	@ _113, tmp253
.L212:
@ C_Code.c:574: 	AdjustAllRounds(id, damage, round->hpChange);
	movs	r0, r5	@, id
	bl	AdjustAllRounds		@
@ C_Code.c:576: 	CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp); 
	ldr	r3, [sp, #56]	@ tmp301, round
	mov	r2, r10	@, active_bunit
	str	r3, [sp]	@ tmp301,
	movs	r1, r6	@, HpProc
	movs	r3, r7	@, opp_bunit
	mov	r0, r8	@, proc
	str	r4, [sp, #4]	@ _113,
	bl	CheckForDeath		@
.L206:
@ C_Code.c:591: } 
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
.L231:
@ C_Code.c:528: 		hp -= damage;
	subs	r2, r4, r0	@ hp, tmp188, damage
	mov	fp, r2	@ hp, hp
@ C_Code.c:531: 		if (hp < 0) { damage -= ABS(hp); } 
	mov	r2, r9	@ _7, _7
	subs	r1, r4, r2	@ damage, tmp188, _7
@ C_Code.c:531: 		if (hp < 0) { damage -= ABS(hp); } 
	mov	r2, fp	@ hp, hp
	cmp	r2, #0	@ hp,
	blt	.L210		@,
@ C_Code.c:529: 		damage -= round->hpChange; 
	mov	r2, r9	@ _7, _7
	subs	r1, r0, r2	@ damage, damage, _7
.L210:
@ C_Code.c:535: 		HpProc->post -= damage;
	ldr	r2, [r6, #80]	@ HpProc_83(D)->post, HpProc_83(D)->post
	subs	r2, r2, r1	@ tmp197, HpProc_83(D)->post, damage
	str	r2, [r6, #80]	@ tmp197, HpProc_83(D)->post
@ C_Code.c:536: 		opp_bunit->unit.curHP -= damage; 
	lsls	r2, r1, #24	@ tmp199, damage,
	ldrb	r0, [r7, #19]	@ tmp201,
	lsrs	r2, r2, #24	@ _14, tmp199,
	subs	r0, r0, r2	@ tmp202, tmp201, _14
@ C_Code.c:537: 		round->hpChange += damage; 
	adds	r2, r2, r3	@ tmp204, _14, _126
	lsls	r2, r2, #24	@ tmp205, tmp204,
	ldr	r3, [sp, #56]	@ tmp277, round
	asrs	r2, r2, #24	@ _19, tmp205,
@ C_Code.c:536: 		opp_bunit->unit.curHP -= damage; 
	strb	r0, [r7, #19]	@ tmp202, opp_bunit_85(D)->unit.curHP
@ C_Code.c:537: 		round->hpChange += damage; 
	strb	r2, [r3, #3]	@ _19, round_79(D)->hpChange
	mov	r3, fp	@ hp, hp
	mvns	r4, r3	@ tmp252, hp
	asrs	r4, r4, #31	@ tmp251, tmp252,
	ands	r4, r3	@ _113, hp
@ C_Code.c:538: 		if (UsingSkillSys) { round->overDmg -= damage; } // used by Huichelaar's banim numbers 
	ldr	r3, [sp, #8]	@ pretmp_134, %sfp
	cmp	r3, #0	@ pretmp_134,
	beq	.L212		@,
@ C_Code.c:538: 		if (UsingSkillSys) { round->overDmg -= damage; } // used by Huichelaar's banim numbers 
	ldr	r3, [sp, #56]	@ tmp281, round
	ldrh	r3, [r3, #6]	@ tmp208,
	ldr	r0, [sp, #56]	@ tmp282, round
	subs	r3, r3, r1	@ tmp210, tmp208, damage
	strh	r3, [r0, #6]	@ tmp210, round_79(D)->overDmg
	b	.L212		@
.L213:
@ C_Code.c:552: 		if (hp == 1) { // deal lethal anyway 
	cmp	r2, #1	@ _7,
	beq	.L232		@,
@ C_Code.c:565: 			HpProc->post += 1;
	ldr	r2, [r6, #80]	@ HpProc_83(D)->post, HpProc_83(D)->post
	adds	r2, r2, #1	@ tmp237,
	str	r2, [r6, #80]	@ tmp237, HpProc_83(D)->post
@ C_Code.c:566: 			opp_bunit->unit.curHP += 1; 
	ldrb	r2, [r7, #19]	@ tmp240,
@ C_Code.c:567: 			round->hpChange -= 1; 
	subs	r3, r3, #1	@ tmp243,
@ C_Code.c:566: 			opp_bunit->unit.curHP += 1; 
	adds	r2, r2, #1	@ tmp241,
@ C_Code.c:567: 			round->hpChange -= 1; 
	lsls	r3, r3, #24	@ tmp244, tmp243,
@ C_Code.c:566: 			opp_bunit->unit.curHP += 1; 
	strb	r2, [r7, #19]	@ tmp241, opp_bunit_85(D)->unit.curHP
@ C_Code.c:567: 			round->hpChange -= 1; 
	asrs	r2, r3, #24	@ _19, tmp244,
	ldr	r3, [sp, #56]	@ tmp296, round
	strb	r2, [r3, #3]	@ _19, round_79(D)->hpChange
@ C_Code.c:568: 			if (UsingSkillSys) { round->overDmg += 1; } 
	ldr	r3, [sp, #8]	@ pretmp_134, %sfp
	cmp	r3, #0	@ pretmp_134,
	beq	.L217		@,
@ C_Code.c:568: 			if (UsingSkillSys) { round->overDmg += 1; } 
	ldr	r3, [sp, #56]	@ tmp298, round
	ldrh	r3, [r3, #6]	@ tmp247,
	ldr	r1, [sp, #56]	@ tmp299, round
	adds	r3, r3, #1	@ tmp248,
	strh	r3, [r1, #6]	@ tmp248, round_79(D)->overDmg
.L217:
@ C_Code.c:569: 			damage = 0 - damage;
	movs	r1, #1	@ tmp250,
	mov	r3, r9	@ _7, _7
	movs	r4, #1	@ _113,
	subs	r1, r1, r3	@ damage, tmp250, _7
	b	.L212		@
.L232:
@ C_Code.c:555: 			HpProc->post = 0;
	movs	r2, #0	@ tmp227,
@ C_Code.c:557: 			round->hpChange += damage; 
	adds	r3, r3, #1	@ tmp230,
@ C_Code.c:555: 			HpProc->post = 0;
	str	r2, [r6, #80]	@ tmp227, HpProc_83(D)->post
@ C_Code.c:556: 			opp_bunit->unit.curHP = 0; 
	strb	r2, [r7, #19]	@ tmp227, opp_bunit_85(D)->unit.curHP
@ C_Code.c:557: 			round->hpChange += damage; 
	lsls	r2, r3, #24	@ tmp231, tmp230,
	ldr	r3, [sp, #56]	@ tmp292, round
	asrs	r2, r2, #24	@ _19, tmp231,
	strb	r2, [r3, #3]	@ _19, round_79(D)->hpChange
@ C_Code.c:558: 			if (UsingSkillSys) { round->overDmg -= damage; } 
	ldr	r3, [sp, #8]	@ pretmp_134, %sfp
	cmp	r3, #0	@ pretmp_134,
	beq	.L218		@,
@ C_Code.c:558: 			if (UsingSkillSys) { round->overDmg -= damage; } 
	ldr	r3, [sp, #56]	@ tmp294, round
	ldrh	r3, [r3, #6]	@ tmp234,
	ldr	r1, [sp, #56]	@ tmp295, round
	subs	r3, r3, #1	@ tmp235,
	strh	r3, [r1, #6]	@ tmp235, round_79(D)->overDmg
@ C_Code.c:559: 			damage = 0 - damage;
	movs	r1, #1	@ damage,
@ C_Code.c:558: 			if (UsingSkillSys) { round->overDmg -= damage; } 
	movs	r4, #0	@ _113,
@ C_Code.c:559: 			damage = 0 - damage;
	rsbs	r1, r1, #0	@ damage, damage
	b	.L212		@
.L218:
@ C_Code.c:559: 			damage = 0 - damage;
	movs	r1, #1	@ damage,
	movs	r4, #0	@ _113,
	rsbs	r1, r1, #0	@ damage, damage
	b	.L212		@
.L234:
	.align	2
.L233:
	.word	gEfxHpLutOff
	.word	GetEfxHp
	.word	__aeabi_idiv
	.word	UsingSkillSys
	.size	AdjustDamageByPercent, .-AdjustDamageByPercent
	.align	1
	.p2align 2,,3
	.global	AdjustDamageWithGetter
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	AdjustDamageWithGetter, %function
AdjustDamageWithGetter:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}	@
@ C_Code.c:435: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { return ReducedDamagePercent; } 
	movs	r5, #11	@ tmp122,
	movs	r4, #192	@ tmp123,
	ldrsb	r5, [r2, r5]	@ tmp122,
@ C_Code.c:467: void AdjustDamageWithGetter(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round) { 
	sub	sp, sp, #12	@,,
@ C_Code.c:435: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { return ReducedDamagePercent; } 
	ands	r4, r5	@ tmp124, tmp122
@ C_Code.c:435: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { return ReducedDamagePercent; } 
	cmp	r4, #128	@ tmp124,
	beq	.L238		@,
@ C_Code.c:436: 	return BonusDamagePercent; 
	ldr	r4, .L239	@ tmp126,
	ldr	r4, [r4]	@ _12,
.L237:
@ C_Code.c:468: 	AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, GetDamagePercent(active_bunit, opp_bunit)); 
	str	r4, [sp, #4]	@ _12,
	ldr	r4, [sp, #24]	@ tmp132, round
	str	r4, [sp]	@ tmp132,
	bl	AdjustDamageByPercent		@
@ C_Code.c:469: } 
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L238:
@ C_Code.c:435: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { return ReducedDamagePercent; } 
	ldr	r4, .L239+4	@ tmp125,
	ldr	r4, [r4]	@ _12,
	b	.L237		@
.L240:
	.align	2
.L239:
	.word	BonusDamagePercent
	.word	ReducedDamagePercent
	.size	AdjustDamageWithGetter, .-AdjustDamageWithGetter
	.align	1
	.p2align 2,,3
	.global	DoStuffIfHit
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DoStuffIfHit, %function
DoStuffIfHit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r5, r8	@,
	mov	r7, r10	@,
	mov	r6, r9	@,
	mov	lr, fp	@,
	push	{r5, r6, r7, lr}	@
	mov	r8, r3	@ round, tmp247
@ C_Code.c:376: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldr	r3, .L266	@ tmp165,
@ C_Code.c:376: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldrh	r6, [r3, #8]	@ tmp168,
	ldrh	r3, [r3, #4]	@ tmp170,
@ C_Code.c:376: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	orrs	r6, r3	@ keys, tmp170
@ C_Code.c:377: 	int side = proc->side; 
	movs	r3, #77	@ tmp173,
@ C_Code.c:375: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct ProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r4, r0	@ proc, tmp245
@ C_Code.c:377: 	int side = proc->side; 
	ldrb	r0, [r0, r3]	@ side,
@ C_Code.c:380: 	x = x+((side)*4*8);
	lsls	r7, r0, #5	@ tmp174, side,
@ C_Code.c:375: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct ProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	sub	sp, sp, #20	@,,
@ C_Code.c:380: 	x = x+((side)*4*8);
	adds	r7, r7, #96	@ tmp174,
@ C_Code.c:375: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct ProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	subs	r5, r2, #0	@ HpProc, tmp246,
@ C_Code.c:380: 	x = x+((side)*4*8);
	str	r7, [sp, #8]	@ tmp174, %sfp
@ C_Code.c:230: 	if (!HpProc) { return false; } // 
	beq	.L242		@,
@ C_Code.c:232: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	adds	r3, r3, #5	@ tmp175,
@ C_Code.c:232: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r3, [r4, r3]	@ tmp176,
	cmp	r3, #0	@ tmp176,
	bne	.L242		@,
@ C_Code.c:381: 	struct BattleUnit* active_bunit = proc->active_bunit; 
	ldr	r3, [r4, #64]	@ active_bunit, proc_37(D)->active_bunit
	mov	fp, r3	@ active_bunit, active_bunit
@ C_Code.c:382: 	struct BattleUnit* opp_bunit = proc->opp_bunit; 
	ldr	r3, [r4, #68]	@ opp_bunit, proc_37(D)->opp_bunit
@ C_Code.c:385: 		SaveInputFrame(proc, keys); 
	movs	r1, r6	@, keys
	movs	r0, r4	@, proc
@ C_Code.c:382: 	struct BattleUnit* opp_bunit = proc->opp_bunit; 
	str	r3, [sp, #12]	@ opp_bunit, %sfp
@ C_Code.c:385: 		SaveInputFrame(proc, keys); 
	bl	SaveInputFrame		@
@ C_Code.c:386: 		SaveIfWeHitOnTime(proc);
	movs	r0, r4	@, proc
	bl	SaveIfWeHitOnTime		@
@ C_Code.c:331: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L266+4	@ tmp177,
@ C_Code.c:335: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp180,
	cmp	r3, #127	@ tmp180,
	bhi	.L243		@,
@ C_Code.c:336: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L266+8	@ tmp181,
@ C_Code.c:336: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L243		@,
@ C_Code.c:337: 	return proc->hitOnTime;
	adds	r3, r3, #72	@ tmp183,
@ C_Code.c:388: 		if (DidWeHitOnTime(proc)) { 
	ldrb	r3, [r4, r3]	@ tmp184,
	cmp	r3, #0	@ tmp184,
	bne	.L243		@,
.L244:
@ C_Code.c:394: 		int x2 = BAN_DisplayDamage(proc->anim2, 0, 0, 0, proc->roundId); 
	movs	r3, #73	@ tmp196,
	mov	r10, r3	@ tmp196, tmp196
@ C_Code.c:394: 		int x2 = BAN_DisplayDamage(proc->anim2, 0, 0, 0, proc->roundId); 
	ldrb	r3, [r4, r3]	@ tmp197,
	movs	r1, #0	@,
	movs	r2, #0	@,
	str	r3, [sp]	@ tmp197,
	ldr	r7, .L266+12	@ tmp198,
	movs	r3, #0	@,
	ldr	r0, [r4, #48]	@ proc_37(D)->anim2, proc_37(D)->anim2
	bl	.L172		@
	movs	r3, r0	@ x2, tmp248
@ C_Code.c:395: 		x2 = BAN_DisplayDamage(proc->anim, 1, proc->anim->xPosition, x2, proc->roundId);  
	ldr	r0, [r4, #44]	@ _11, proc_37(D)->anim
	movs	r1, #2	@ tmp254,
	ldrsh	r2, [r0, r1]	@ tmp199, _11, tmp254
	mov	r1, r10	@ tmp196, tmp196
	ldrb	r1, [r4, r1]	@ tmp201,
	str	r1, [sp]	@ tmp201,
	movs	r1, #1	@,
	bl	.L172		@
@ C_Code.c:397: 		if (!proc->adjustedDmg) {
	movs	r3, #74	@ tmp203,
@ C_Code.c:397: 		if (!proc->adjustedDmg) {
	ldrb	r3, [r4, r3]	@ tmp204,
	cmp	r3, #0	@ tmp204,
	bne	.LCB1684	@
	b	.L247	@long jump	@
.LCB1684:
.L262:
@ C_Code.c:402: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	movs	r3, #77	@ tmp207,
@ C_Code.c:402: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r0, [r4, r3]	@ side,
.L242:
	ldr	r3, .L266+16	@ tmp208,
	bl	.L31		@
@ C_Code.c:402: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	cmp	r0, #0	@ tmp209,
	bne	.L248		@,
@ C_Code.c:402: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	movs	r3, #79	@ tmp211,
@ C_Code.c:402: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r3, [r4, r3]	@ tmp212,
	cmp	r3, #255	@ tmp212,
	beq	.L263		@,
.L248:
@ C_Code.c:331: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L266+4	@ tmp215,
@ C_Code.c:335: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp218,
@ C_Code.c:414: 		else if (proc->timer2 < 20) { 
	ldr	r5, [r4, #56]	@ pretmp_6, proc_37(D)->timer2
@ C_Code.c:335: 	if (CheatCodeOn()) { return true; } 
	cmp	r3, #127	@ tmp218,
	bhi	.L250		@,
@ C_Code.c:336: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L266+8	@ tmp219,
@ C_Code.c:336: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L250		@,
@ C_Code.c:337: 	return proc->hitOnTime;
	adds	r3, r3, #72	@ tmp221,
@ C_Code.c:404: 		if (DidWeHitOnTime(proc)) { 
	ldrb	r3, [r4, r3]	@ tmp222,
	cmp	r3, #0	@ tmp222,
	bne	.L250		@,
@ C_Code.c:414: 		else if (proc->timer2 < 20) { 
	cmp	r5, #19	@ pretmp_6,
	ble	.L264		@,
.L252:
@ C_Code.c:417: 		proc->roundEnd = true; 
	movs	r3, #81	@ tmp236,
	movs	r2, #1	@ tmp237,
	strb	r2, [r4, r3]	@ tmp237, proc_37(D)->roundEnd
.L241:
@ C_Code.c:432: } 
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
.L250:
@ C_Code.c:409: 			x += Mod(clock, 8) >> 1; 
	movs	r1, #8	@,
	movs	r0, r5	@, pretmp_6
	ldr	r3, .L266+20	@ tmp223,
	bl	.L31		@
@ C_Code.c:410: 			y -= clock; 
	movs	r1, #40	@ tmp226,
@ C_Code.c:412: 			PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Star, oam2); 
	movs	r2, #255	@ tmp228,
@ C_Code.c:410: 			y -= clock; 
	subs	r1, r1, r5	@ y, tmp226, pretmp_6
@ C_Code.c:412: 			PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Star, oam2); 
	ands	r2, r1	@ tmp229, y
@ C_Code.c:409: 			x += Mod(clock, 8) >> 1; 
	asrs	r1, r0, #1	@ tmp230, tmp250,
@ C_Code.c:409: 			x += Mod(clock, 8) >> 1; 
	ldr	r0, [sp, #8]	@ x, %sfp
	mov	ip, r0	@ x, x
@ C_Code.c:412: 			PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Star, oam2); 
	movs	r0, #224	@ tmp234,
@ C_Code.c:409: 			x += Mod(clock, 8) >> 1; 
	add	r1, r1, ip	@ x, x
@ C_Code.c:412: 			PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Star, oam2); 
	ldr	r3, .L266+24	@ tmp224,
	lsls	r0, r0, #8	@ tmp234, tmp234,
	lsls	r1, r1, #23	@ tmp233, x,
	str	r0, [sp]	@ tmp234,
	ldr	r5, .L266+28	@ tmp235,
	movs	r0, #2	@,
	adds	r3, r3, #104	@ tmp225,
	lsrs	r1, r1, #23	@ tmp232, tmp233,
	bl	.L44		@
	b	.L252		@
.L243:
@ C_Code.c:389: 			if (!proc->adjustedDmg) { 
	movs	r3, #74	@ tmp185,
@ C_Code.c:389: 			if (!proc->adjustedDmg) { 
	ldrb	r2, [r4, r3]	@ tmp186,
	cmp	r2, #0	@ tmp186,
	bne	.L244		@,
@ C_Code.c:390: 				proc->adjustedDmg = true; 
	adds	r2, r2, #1	@ tmp188,
	strb	r2, [r4, r3]	@ tmp188, proc_37(D)->adjustedDmg
@ C_Code.c:435: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { return ReducedDamagePercent; } 
	mov	r3, fp	@ active_bunit, active_bunit
	movs	r2, #11	@ tmp190,
	ldrsb	r2, [r3, r2]	@ tmp190,
	movs	r3, #192	@ tmp191,
	ands	r3, r2	@ tmp192, tmp190
@ C_Code.c:435: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { return ReducedDamagePercent; } 
	cmp	r3, #128	@ tmp192,
	beq	.L265		@,
@ C_Code.c:436: 	return BonusDamagePercent; 
	ldr	r3, .L266+32	@ tmp194,
	ldr	r3, [r3]	@ _76,
.L246:
@ C_Code.c:468: 	AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, GetDamagePercent(active_bunit, opp_bunit)); 
	str	r3, [sp, #4]	@ _76,
	mov	r3, r8	@ round, round
	mov	r2, fp	@, active_bunit
	str	r3, [sp]	@ round,
	movs	r1, r5	@, HpProc
	movs	r0, r4	@, proc
	ldr	r3, [sp, #12]	@, %sfp
	bl	AdjustDamageByPercent		@
@ C_Code.c:469: } 
	b	.L244		@
.L264:
@ C_Code.c:415: 			DrawButtonsToPress(proc, x, y, 14); 
	movs	r3, #14	@,
	movs	r2, #40	@,
	movs	r0, r4	@, proc
	ldr	r1, [sp, #8]	@, %sfp
	bl	DrawButtonsToPress		@
	b	.L252		@
.L263:
@ C_Code.c:402: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	subs	r3, r3, #175	@ tmp213,
@ C_Code.c:402: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r3, [r4, r3]	@ tmp214,
	cmp	r3, #255	@ tmp214,
	bne	.L248		@,
@ C_Code.c:421: 		if (proc->timer < 10) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	ldr	r3, [r4, #52]	@ proc_37(D)->timer, proc_37(D)->timer
	cmp	r3, #9	@ proc_37(D)->timer,
	bgt	.L254		@,
@ C_Code.c:421: 		if (proc->timer < 10) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	movs	r3, #78	@ tmp240,
	strb	r0, [r4, r3]	@ tmp209, proc_37(D)->frame
.L255:
@ C_Code.c:425: 		if (!proc->roundEnd) { 
	movs	r3, #81	@ tmp243,
@ C_Code.c:425: 		if (!proc->roundEnd) { 
	ldrb	r3, [r4, r3]	@ tmp244,
	cmp	r3, #0	@ tmp244,
	bne	.L241		@,
@ C_Code.c:426: 			DrawButtonsToPress(proc, x, y, 15); 
	movs	r2, #40	@,
	movs	r0, r4	@, proc
	ldr	r1, [sp, #8]	@, %sfp
	adds	r3, r3, #15	@,
	bl	DrawButtonsToPress		@
@ C_Code.c:432: } 
	b	.L241		@
.L247:
@ C_Code.c:398: 			CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, (-1)); 
	movs	r3, #1	@ tmp206,
	rsbs	r3, r3, #0	@ tmp206, tmp206
	str	r3, [sp, #4]	@ tmp206,
	mov	r3, r8	@ round, round
	mov	r2, fp	@, active_bunit
	str	r3, [sp]	@ round,
	movs	r1, r5	@, HpProc
	movs	r0, r4	@, proc
	ldr	r3, [sp, #12]	@, %sfp
	bl	CheckForDeath		@
	b	.L262		@
.L254:
@ C_Code.c:423: 			SaveInputFrame(proc, keys); 
	movs	r1, r6	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
	b	.L255		@
.L265:
@ C_Code.c:435: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { return ReducedDamagePercent; } 
	ldr	r3, .L266+36	@ tmp193,
	ldr	r3, [r3]	@ _76,
	b	.L246		@
.L267:
	.align	2
.L266:
	.word	sKeyStatusBuffer
	.word	gPlaySt
	.word	AlwaysWork
	.word	BAN_DisplayDamage
	.word	EkrEfxIsUnitHittedNow
	.word	Mod
	.word	.LANCHOR0
	.word	PutSprite
	.word	BonusDamagePercent
	.word	ReducedDamagePercent
	.size	DoStuffIfHit, .-DoStuffIfHit
	.align	1
	.p2align 2,,3
	.global	LoopTimedHitsProc
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	LoopTimedHitsProc, %function
LoopTimedHitsProc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r8	@,
@ C_Code.c:208: 	if (!proc->anim) { return; } 
	ldr	r3, [r0, #44]	@ proc_19(D)->anim, proc_19(D)->anim
@ C_Code.c:207: void LoopTimedHitsProc(TimedHitsProc* proc) { 
	movs	r4, r0	@ proc, tmp162
	push	{lr}	@
@ C_Code.c:208: 	if (!proc->anim) { return; } 
	cmp	r3, #0	@ proc_19(D)->anim,
	beq	.L268		@,
@ C_Code.c:210: 	struct ProcEkrBattle* battleProc = gpProcEkrBattle; 
	ldr	r3, .L286	@ tmp133,
	ldr	r5, [r3]	@ battleProc, gpProcEkrBattle
@ C_Code.c:212: 	if (!battleProc) { return; } 
	cmp	r5, #0	@ battleProc,
	beq	.L268		@,
@ C_Code.c:213: 	if (!proc->anim2) { return; } 
	ldr	r3, [r0, #48]	@ proc_19(D)->anim2, proc_19(D)->anim2
	cmp	r3, #0	@ proc_19(D)->anim2,
	beq	.L268		@,
@ C_Code.c:215: 	proc->timer++;
	ldr	r3, [r0, #52]	@ proc_19(D)->timer, proc_19(D)->timer
@ C_Code.c:218: 	struct SkillSysBattleHit* currentRound = proc->currentRound; 
	ldr	r6, [r0, #60]	@ currentRound, proc_19(D)->currentRound
@ C_Code.c:215: 	proc->timer++;
	adds	r3, r3, #1	@ tmp135,
	str	r3, [r0, #52]	@ tmp135, proc_19(D)->timer
@ C_Code.c:216: 	proc->timer2++;
	ldr	r3, [r0, #56]	@ proc_19(D)->timer2, proc_19(D)->timer2
@ C_Code.c:219: 	if ((currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!currentRound->hpChange)) { return; } 
	ldr	r2, [r6]	@ *currentRound_23, *currentRound_23
@ C_Code.c:216: 	proc->timer2++;
	adds	r3, r3, #1	@ tmp137,
@ C_Code.c:219: 	if ((currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!currentRound->hpChange)) { return; } 
	movs	r7, r2	@ tmp144, *currentRound_23
@ C_Code.c:216: 	proc->timer2++;
	str	r3, [r0, #56]	@ tmp137, proc_19(D)->timer2
@ C_Code.c:219: 	if ((currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!currentRound->hpChange)) { return; } 
	movs	r3, #2	@ tmp143,
	ands	r7, r3	@ tmp144, tmp143
	tst	r2, r3	@ *currentRound_23, tmp143
	bne	.L268		@,
@ C_Code.c:219: 	if ((currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!currentRound->hpChange)) { return; } 
	movs	r3, #3	@ tmp145,
	ldrsb	r3, [r6, r3]	@ tmp145,
	cmp	r3, #0	@ tmp145,
	beq	.L268		@,
@ C_Code.c:220: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	movs	r3, #82	@ tmp146,
	mov	r8, r3	@ tmp146, tmp146
	ldrb	r3, [r0, r3]	@ _9,
@ C_Code.c:220: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	cmp	r3, #255	@ _9,
	beq	.L272		@,
@ C_Code.c:221: 		proc->EkrEfxIsUnitHittedNowFrames++; 
	mov	r2, r8	@ tmp146, tmp146
	adds	r3, r3, #1	@ tmp147,
	strb	r3, [r0, r2]	@ tmp147, proc_19(D)->EkrEfxIsUnitHittedNowFrames
.L273:
@ C_Code.c:224: 	struct ProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	ldr	r3, .L286+4	@ tmp158,
	ldr	r0, [r3]	@ gProcScr_efxHPBar, gProcScr_efxHPBar
	ldr	r3, .L286+8	@ tmp160,
	bl	.L31		@
@ C_Code.c:225: 	DoStuffIfHit(proc, battleProc, HpProc, currentRound); 
	movs	r3, r6	@, currentRound
@ C_Code.c:224: 	struct ProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	movs	r2, r0	@ HpProc, tmp164
@ C_Code.c:225: 	DoStuffIfHit(proc, battleProc, HpProc, currentRound); 
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
.L268:
@ C_Code.c:226: } 
	@ sp needed	@
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L272:
@ C_Code.c:223: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #77	@ tmp150,
@ C_Code.c:223: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	ldrb	r0, [r0, r3]	@ tmp151,
	ldr	r3, .L286+12	@ tmp152,
	bl	.L31		@
@ C_Code.c:223: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	cmp	r0, #0	@ tmp163,
	beq	.L273		@,
@ C_Code.c:223: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	mov	r3, r8	@ tmp146, tmp146
	strb	r7, [r4, r3]	@ tmp144, proc_19(D)->EkrEfxIsUnitHittedNowFrames
	b	.L273		@
.L287:
	.align	2
.L286:
	.word	gpProcEkrBattle
	.word	gProcScr_efxHPBar
	.word	Proc_Find
	.word	EkrEfxIsUnitHittedNow
	.size	LoopTimedHitsProc, .-LoopTimedHitsProc
	.align	1
	.p2align 2,,3
	.global	GetBattleAnimPreconfType
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetBattleAnimPreconfType, %function
GetBattleAnimPreconfType:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:602: 	int result = gPlaySt.config.animationType; 
	movs	r2, #66	@ tmp129,
@ C_Code.c:601: int GetBattleAnimPreconfType(void) {
	push	{r4, lr}	@
@ C_Code.c:602: 	int result = gPlaySt.config.animationType; 
	ldr	r3, .L300	@ tmp163,
	ldrb	r0, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:603: 	if (!CheatCodeOn()) { 
	ldrb	r2, [r3, #31]	@ tmp138,
@ C_Code.c:602: 	int result = gPlaySt.config.animationType; 
	lsls	r0, r0, #29	@ tmp133, gPlaySt,
@ C_Code.c:602: 	int result = gPlaySt.config.animationType; 
	lsrs	r0, r0, #30	@ <retval>, tmp133,
@ C_Code.c:603: 	if (!CheatCodeOn()) { 
	cmp	r2, #127	@ tmp138,
	bhi	.L289		@,
@ C_Code.c:604: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, .L300+4	@ tmp139,
@ C_Code.c:604: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, [r2]	@ ForceAnimsOn, ForceAnimsOn
	cmp	r2, #0	@ ForceAnimsOn,
	beq	.L289		@,
@ C_Code.c:604: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	cmp	r0, #2	@ <retval>,
	beq	.L288		@,
.L292:
@ C_Code.c:604: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	movs	r0, #1	@ <retval>,
.L288:
@ C_Code.c:625: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L289:
@ C_Code.c:607:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r2, #66	@ tmp142,
	ldrb	r2, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:607:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r3, #6	@ tmp148,
	ands	r3, r2	@ tmp149, gPlaySt
	cmp	r3, #4	@ tmp149,
	bne	.L288		@,
@ C_Code.c:611:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	movs	r1, #11	@ tmp153,
@ C_Code.c:612:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	movs	r4, #11	@ pretmp_25,
@ C_Code.c:611:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldr	r0, .L300+8	@ tmp152,
@ C_Code.c:612:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldr	r2, .L300+12	@ tmp151,
@ C_Code.c:611:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldrsb	r1, [r0, r1]	@ tmp153,
	adds	r3, r3, #188	@ tmp154,
@ C_Code.c:612:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldrsb	r4, [r2, r4]	@ pretmp_25,* pretmp_25
@ C_Code.c:611:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	tst	r3, r1	@ tmp154, tmp153
	beq	.L299		@,
@ C_Code.c:617:         if (UNIT_FACTION(&gBattleTarget.unit) != FACTION_BLUE)
	tst	r3, r4	@ tmp154, pretmp_25
	bne	.L292		@,
@ C_Code.c:624:         return GetSoloAnimPreconfType(&gBattleTarget.unit);
	movs	r0, r2	@, tmp151
.L299:
	ldr	r3, .L300+16	@ tmp161,
	bl	.L31		@
	b	.L288		@
.L301:
	.align	2
.L300:
	.word	gPlaySt
	.word	ForceAnimsOn
	.word	gBattleActor
	.word	gBattleTarget
	.word	GetSoloAnimPreconfType
	.size	GetBattleAnimPreconfType, .-GetBattleAnimPreconfType
	.global	RomKeysList
	.global	sSprite_Down_Button
	.global	sSprite_Up_Button
	.global	sSprite_Right_Button
	.global	sSprite_Left_Button
	.global	sSprite_B_Button
	.global	sSprite_A_Button
	.global	sSprite_Star
	.global	sSprite_PressInput2
	.global	sSprite_PressInput
	.global	sSprite_MissedInput
	.global	sSprite_HitInput
	.global	TimedHitsProcCmd
	.section	.rodata.str1.4
	.align	2
.LC77:
	.ascii	"TimedHitsProcName\000"
	.global	gEkrBg2QuakeVec
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	TimedHitsProcCmd, %object
	.size	TimedHitsProcCmd, 32
TimedHitsProcCmd:
@ opcode:
	.short	1
@ dataImm:
	.short	0
@ dataPtr:
	.word	.LC77
@ opcode:
	.short	14
@ dataImm:
	.short	0
@ dataPtr:
	.word	0
@ opcode:
	.short	3
@ dataImm:
	.short	0
@ dataPtr:
	.word	LoopTimedHitsProc
@ opcode:
	.short	0
@ dataImm:
	.short	0
@ dataPtr:
	.word	0
	.type	RomKeysList, %object
	.size	RomKeysList, 6
RomKeysList:
	.ascii	"\001\002\020 @\200"
	.space	2
	.type	sSprite_PressInput, %object
	.size	sSprite_PressInput, 8
sSprite_PressInput:
	.short	1
	.short	16384
	.short	-32768
	.short	332
	.type	sSprite_PressInput2, %object
	.size	sSprite_PressInput2, 8
sSprite_PressInput2:
	.short	1
	.short	0
	.short	16384
	.short	336
	.type	sSprite_A_Button, %object
	.size	sSprite_A_Button, 8
sSprite_A_Button:
	.short	1
	.short	0
	.short	16384
	.short	320
	.type	sSprite_B_Button, %object
	.size	sSprite_B_Button, 8
sSprite_B_Button:
	.short	1
	.short	0
	.short	16384
	.short	322
	.type	sSprite_Left_Button, %object
	.size	sSprite_Left_Button, 8
sSprite_Left_Button:
	.short	1
	.short	0
	.short	16384
	.short	324
	.type	sSprite_Right_Button, %object
	.size	sSprite_Right_Button, 8
sSprite_Right_Button:
	.short	1
	.short	0
	.short	16384
	.short	326
	.type	sSprite_Up_Button, %object
	.size	sSprite_Up_Button, 8
sSprite_Up_Button:
	.short	1
	.short	0
	.short	16384
	.short	328
	.type	sSprite_Down_Button, %object
	.size	sSprite_Down_Button, 8
sSprite_Down_Button:
	.short	1
	.short	0
	.short	16384
	.short	330
	.type	sSprite_Star, %object
	.size	sSprite_Star, 8
sSprite_Star:
	.short	1
	.short	0
	.short	16384
	.short	338
	.type	sSprite_MissedInput, %object
	.size	sSprite_MissedInput, 8
sSprite_MissedInput:
	.short	1
	.short	0
	.short	16384
	.short	460
	.type	sSprite_HitInput, %object
	.size	sSprite_HitInput, 8
sSprite_HitInput:
	.short	1
	.short	2
	.short	16384
	.short	458
	.bss
	.align	2
	.type	gEkrBg2QuakeVec, %object
	.size	gEkrBg2QuakeVec, 4
gEkrBg2QuakeVec:
	.space	4
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.text
	.code 16
	.align	1
.L31:
	bx	r3
.L117:
	bx	r4
.L44:
	bx	r5
.L173:
	bx	r6
.L172:
	bx	r7
.L22:
	bx	r10
.L174:
	bx	fp
