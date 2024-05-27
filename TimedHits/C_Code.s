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
@ GNU C17 (devkitARM release 63) version 13.2.0 (arm-none-eabi)
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
	.syntax unified
	.code	16
	.thumb_func
	.type	GetButtonsToPress.part.0, %function
GetButtonsToPress.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r10	@,
	mov	r6, r8	@,
	mov	r7, r9	@,
	push	{r6, r7, lr}	@
@ C_Code.c:299: 		u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
	ldr	r3, .L21	@ tmp133,
	ldr	r2, [r3]	@ tmp136,
@ C_Code.c:295: int GetButtonsToPress(TimedHitsProc* proc) { 
	sub	sp, sp, #8	@,,
@ C_Code.c:299: 		u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
	str	r2, [sp]	@ tmp136,
	mov	r2, sp	@ tmp166,
	ldrh	r3, [r3, #4]	@ tmp138,
	strh	r3, [r2, #4]	@ tmp138,
@ C_Code.c:304: 		int numberOfRandomButtons = NumberOfRandomButtons; 
	ldr	r3, .L21+4	@ tmp140,
	ldr	r3, [r3]	@ numberOfRandomButtons, NumberOfRandomButtons
@ C_Code.c:295: int GetButtonsToPress(TimedHitsProc* proc) { 
	mov	r10, r0	@ proc, tmp163
@ C_Code.c:304: 		int numberOfRandomButtons = NumberOfRandomButtons; 
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:305: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	cmp	r3, #0	@ numberOfRandomButtons,
	bne	.L2		@,
@ C_Code.c:305: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	ldr	r3, .L21+8	@ tmp142,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.8_2, *TimedHitsDifficultyRam.8_2
	lsls	r3, r3, #29	@ tmp147, *TimedHitsDifficultyRam.8_2,
@ C_Code.c:305: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	lsrs	r2, r3, #29	@ numberOfRandomButtons, tmp147,
	mov	r8, r2	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:306: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	cmp	r3, #0	@ tmp147,
	beq	.L18		@,
.L3:
	ldr	r3, .L21+12	@ tmp161,
@ C_Code.c:302: 		int oppDir = 0; 
	movs	r6, #0	@ oppDir,
@ C_Code.c:307: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	movs	r5, #0	@ i,
@ C_Code.c:297: 	int keys = proc->buttonsToPress;
	movs	r7, #0	@ <retval>,
@ C_Code.c:303: 		int size = 5; // -1 since we count from 0  
	movs	r4, #5	@ size,
	mov	r9, r3	@ tmp161, tmp161
	b	.L9		@
.L5:
@ C_Code.c:307: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r5, r5, #1	@ i,
@ C_Code.c:327: 			keys |= button; 
	orrs	r7, r0	@ <retval>, button
@ C_Code.c:307: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r5, r8	@ i, numberOfRandomButtons
	bge	.L19		@,
.L9:
@ C_Code.c:308: 			num = NextRN_N(size); 
	movs	r0, r4	@, size
	bl	.L23		@
@ C_Code.c:309: 			button = KeysList[num];
	mov	r3, sp	@ tmp173,
	ldrb	r0, [r3, r0]	@ button, KeysList
@ C_Code.c:312: 			if (button & 0xF0) { // some dpad 
	cmp	r0, #15	@ button,
	bls	.L5		@,
@ C_Code.c:313: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	cmp	r0, #16	@ button,
	beq	.L11		@,
@ C_Code.c:314: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	cmp	r0, #32	@ button,
	beq	.L12		@,
@ C_Code.c:315: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	cmp	r0, #64	@ button,
	bne	.L20		@,
@ C_Code.c:315: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	movs	r6, #128	@ oppDir,
.L6:
@ C_Code.c:317: 				for (int c = 0; c <= size; ++c) { 
	cmp	r4, #0	@ size,
	blt	.L5		@,
	mov	r2, sp	@ ivtmp.60,
@ C_Code.c:317: 				for (int c = 0; c <= size; ++c) { 
	movs	r3, #0	@ c,
	b	.L8		@
.L7:
@ C_Code.c:317: 				for (int c = 0; c <= size; ++c) { 
	adds	r3, r3, #1	@ c,
@ C_Code.c:317: 				for (int c = 0; c <= size; ++c) { 
	adds	r2, r2, #1	@ ivtmp.60,
	cmp	r3, r4	@ c, size
	bgt	.L5		@,
.L8:
@ C_Code.c:318: 					if (KeysList[c] == oppDir) { 
	ldrb	r1, [r2]	@ MEM[(unsigned char *)_22], MEM[(unsigned char *)_22]
@ C_Code.c:318: 					if (KeysList[c] == oppDir) { 
	cmp	r1, r6	@ MEM[(unsigned char *)_22], oppDir
	bne	.L7		@,
@ C_Code.c:319: 						KeysList[c] = KeysList[size]; 
	mov	r2, sp	@ tmp174,
@ C_Code.c:319: 						KeysList[c] = KeysList[size]; 
	mov	r1, sp	@ tmp175,
@ C_Code.c:319: 						KeysList[c] = KeysList[size]; 
	ldrb	r2, [r2, r4]	@ _13, KeysList
@ C_Code.c:307: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r5, r5, #1	@ i,
@ C_Code.c:319: 						KeysList[c] = KeysList[size]; 
	strb	r2, [r1, r3]	@ _13, KeysList[c_42]
@ C_Code.c:320: 						size--; 
	subs	r4, r4, #1	@ size,
@ C_Code.c:327: 			keys |= button; 
	orrs	r7, r0	@ <retval>, button
@ C_Code.c:307: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r5, r8	@ i, numberOfRandomButtons
	blt	.L9		@,
.L19:
@ C_Code.c:329: 		proc->buttonsToPress = keys; 
	lsls	r3, r7, #16	@ tmp157, <retval>,
	lsrs	r3, r3, #16	@ _5, tmp157,
.L4:
	movs	r2, #84	@ tmp158,
	mov	r1, r10	@ proc, proc
@ C_Code.c:332: } 
	movs	r0, r7	@, <retval>
@ C_Code.c:329: 		proc->buttonsToPress = keys; 
	strh	r3, [r1, r2]	@ _5, proc_24(D)->buttonsToPress
@ C_Code.c:332: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L11:
@ C_Code.c:313: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	movs	r6, #32	@ oppDir,
	b	.L6		@
.L2:
@ C_Code.c:307: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r3, #0	@ numberOfRandomButtons,
	bgt	.L3		@,
	movs	r3, #0	@ _5,
@ C_Code.c:297: 	int keys = proc->buttonsToPress;
	movs	r7, #0	@ <retval>,
	b	.L4		@
.L18:
@ C_Code.c:306: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	adds	r3, r3, #1	@ numberOfRandomButtons,
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
	b	.L3		@
.L12:
@ C_Code.c:314: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	movs	r6, #16	@ oppDir,
	b	.L6		@
.L20:
@ C_Code.c:316: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	cmp	r0, #128	@ button,
	bne	.L6		@,
@ C_Code.c:316: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	movs	r6, #64	@ oppDir,
	b	.L6		@
.L22:
	.align	2
.L21:
	.word	.LC0
	.word	NumberOfRandomButtons
	.word	TimedHitsDifficultyRam
	.word	NextRN_N
	.size	GetButtonsToPress.part.0, .-GetButtonsToPress.part.0
	.align	1
	.p2align 2,,3
	.global	AreTimedHitsEnabled
	.syntax unified
	.code	16
	.thumb_func
	.type	AreTimedHitsEnabled, %function
AreTimedHitsEnabled:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:92: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L25	@ tmp118,
@ C_Code.c:91: int AreTimedHitsEnabled(void) { 
	push	{r4, lr}	@
@ C_Code.c:92: 	return !CheckFlag(DisabledFlag); 
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
@ C_Code.c:93: }
	@ sp needed	@
@ C_Code.c:92: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L25+4	@ tmp120,
	bl	.L27		@
@ C_Code.c:92: 	return !CheckFlag(DisabledFlag); 
	rsbs	r3, r0, #0	@ tmp126, tmp127
	adcs	r0, r0, r3	@ tmp125, tmp127, tmp126
@ C_Code.c:93: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L26:
	.align	2
.L25:
	.word	DisabledFlag
	.word	CheckFlag
	.size	AreTimedHitsEnabled, .-AreTimedHitsEnabled
	.align	1
	.p2align 2,,3
	.global	InitVariables
	.syntax unified
	.code	16
	.thumb_func
	.type	InitVariables, %function
InitVariables:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:96: 	proc->anim = NULL; 
	movs	r3, #0	@ tmp115,
@ C_Code.c:115: } 
	@ sp needed	@
@ C_Code.c:101: 	proc->timer2 = 0xFF; 
	movs	r2, #255	@ tmp118,
@ C_Code.c:111: 	proc->buttonsToPress = 0; 
	movs	r1, #84	@ tmp122,
@ C_Code.c:96: 	proc->anim = NULL; 
	str	r3, [r0, #44]	@ tmp115, proc_2(D)->anim
@ C_Code.c:97: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp115, proc_2(D)->anim2
@ C_Code.c:100: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp115, proc_2(D)->timer
@ C_Code.c:106: 	proc->currentRound = NULL; 
	str	r3, [r0, #60]	@ tmp115, proc_2(D)->currentRound
@ C_Code.c:107: 	proc->active_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp115, proc_2(D)->active_bunit
@ C_Code.c:108: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #68]	@ tmp115, proc_2(D)->opp_bunit
@ C_Code.c:101: 	proc->timer2 = 0xFF; 
	str	r2, [r0, #56]	@ tmp118, proc_2(D)->timer2
@ C_Code.c:111: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r1]	@ tmp115, proc_2(D)->buttonsToPress
@ C_Code.c:102: 	proc->hitOnTime = false; 
	str	r3, [r0, #72]	@ tmp115, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 72B]
	ldr	r3, .L29	@ tmp126,
	str	r3, [r0, #76]	@ tmp126, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 76B]
@ C_Code.c:113: 	proc->codefframe = 0xff;
	movs	r3, #80	@ tmp127,
	ldr	r1, .L29+4	@ tmp128,
	strh	r1, [r0, r3]	@ tmp128, MEM <vector(2) unsigned char> [(unsigned char *)proc_2(D) + 80B]
@ C_Code.c:114: 	proc->EkrEfxIsUnitHittedNowFrames = 0xff; 
	adds	r3, r3, #2	@ tmp130,
	strb	r2, [r0, r3]	@ tmp118, proc_2(D)->EkrEfxIsUnitHittedNowFrames
@ C_Code.c:115: } 
	bx	lr
.L30:
	.align	2
.L29:
	.word	-16711936
	.word	511
	.size	InitVariables, .-InitVariables
	.align	1
	.p2align 2,,3
	.global	StartTimedHitsProc
	.syntax unified
	.code	16
	.thumb_func
	.type	StartTimedHitsProc, %function
StartTimedHitsProc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ C_Code.c:119: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r4, .L34	@ tmp115,
	ldr	r3, .L34+4	@ tmp116,
	movs	r0, r4	@, tmp115
	bl	.L27		@
@ C_Code.c:120: 	if (!proc) { 
	cmp	r0, #0	@ tmp119,
	beq	.L33		@,
.L31:
@ C_Code.c:124: } 
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L33:
@ C_Code.c:121: 		proc = Proc_Start(TimedHitsProcCmd, (void*)3); 
	movs	r1, #3	@,
	movs	r0, r4	@, tmp115
	ldr	r3, .L34+8	@ tmp118,
	bl	.L27		@
@ C_Code.c:124: } 
	b	.L31		@
.L35:
	.align	2
.L34:
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
	.type	SetCurrentAnimInProc, %function
SetCurrentAnimInProc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:129: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r3, .L42	@ tmp132,
@ C_Code.c:127: void SetCurrentAnimInProc(struct Anim* anim) { 
	movs	r5, r0	@ anim, tmp198
@ C_Code.c:129: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r0, .L42+4	@ tmp131,
	bl	.L27		@
@ C_Code.c:97: 	proc->anim2 = NULL; 
	movs	r3, #0	@ tmp133,
@ C_Code.c:111: 	proc->buttonsToPress = 0; 
	movs	r2, #84	@ tmp138,
@ C_Code.c:97: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp133, proc_20->anim2
@ C_Code.c:100: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp133, proc_20->timer
@ C_Code.c:106: 	proc->currentRound = NULL; 
	str	r3, [r0, #60]	@ tmp133, proc_20->currentRound
@ C_Code.c:107: 	proc->active_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp133, proc_20->active_bunit
@ C_Code.c:108: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #68]	@ tmp133, proc_20->opp_bunit
@ C_Code.c:111: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r2]	@ tmp133, proc_20->buttonsToPress
@ C_Code.c:102: 	proc->hitOnTime = false; 
	str	r3, [r0, #72]	@ tmp133, MEM <vector(4) unsigned char> [(unsigned char *)proc_20 + 72B]
	ldr	r3, .L42+8	@ tmp142,
	str	r3, [r0, #76]	@ tmp142, MEM <vector(4) unsigned char> [(unsigned char *)proc_20 + 76B]
@ C_Code.c:114: 	proc->EkrEfxIsUnitHittedNowFrames = 0xff; 
	movs	r3, #255	@ tmp144,
	subs	r2, r2, #2	@ tmp143,
	strb	r3, [r0, r2]	@ tmp144, proc_20->EkrEfxIsUnitHittedNowFrames
@ C_Code.c:113: 	proc->codefframe = 0xff;
	subs	r2, r2, #2	@ tmp146,
	strh	r3, [r0, r2]	@ tmp144, MEM <vector(2) unsigned char> [(unsigned char *)proc_20 + 80B]
@ C_Code.c:129: 	proc = Proc_Find(TimedHitsProcCmd); 
	movs	r4, r0	@ proc, tmp199
@ C_Code.c:134: 	proc->anim = anim; 
	str	r5, [r0, #44]	@ anim, proc_20->anim
@ C_Code.c:135: 	proc->anim2 = GetAnimAnotherSide(anim); 
	ldr	r3, .L42+12	@ tmp149,
	movs	r0, r5	@, anim
	bl	.L27		@
@ C_Code.c:135: 	proc->anim2 = GetAnimAnotherSide(anim); 
	str	r0, [r4, #48]	@ _1, proc_20->anim2
@ C_Code.c:137: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	ldrh	r2, [r5, #14]	@ _2,
@ C_Code.c:137: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	ldrh	r3, [r0, #14]	@ _3,
@ C_Code.c:137: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	cmp	r2, r3	@ _2, _3
	bls	.L37		@,
@ C_Code.c:137: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	subs	r2, r2, #1	@ tmp151,
	lsls	r2, r2, #24	@ tmp152, tmp151,
	lsrs	r0, r2, #24	@ iftmp.1_15, tmp152,
.L38:
@ C_Code.c:137: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	movs	r3, #73	@ tmp156,
	strb	r0, [r4, r3]	@ iftmp.1_15, proc_20->roundId
@ C_Code.c:138: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	ldr	r3, .L42+16	@ tmp158,
	bl	.L27		@
@ C_Code.c:139: 	proc->side = GetAnimPosition(anim) ^ 1; 
	ldr	r3, .L42+20	@ tmp159,
@ C_Code.c:138: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	str	r0, [r4, #60]	@ tmp201, proc_20->currentRound
@ C_Code.c:139: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r0, r5	@, anim
	bl	.L27		@
@ C_Code.c:139: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r3, #1	@ tmp161,
@ C_Code.c:139: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r2, #77	@ tmp164,
@ C_Code.c:139: 	proc->side = GetAnimPosition(anim) ^ 1; 
	lsls	r0, r0, #24	@ tmp160, tmp202,
	asrs	r0, r0, #24	@ _9, tmp160,
	eors	r3, r0	@ tmp163, _9
@ C_Code.c:139: 	proc->side = GetAnimPosition(anim) ^ 1; 
	strb	r3, [r4, r2]	@ tmp163, proc_20->side
@ C_Code.c:140: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, .L42+24	@ tmp166,
@ C_Code.c:141: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, .L42+28	@ tmp167,
@ C_Code.c:140: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, [r3]	@ gpEkrBattleUnitLeft.2_12, gpEkrBattleUnitLeft
@ C_Code.c:141: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, [r2]	@ gpEkrBattleUnitRight.3_13, gpEkrBattleUnitRight
@ C_Code.c:140: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	str	r3, [r4, #64]	@ gpEkrBattleUnitLeft.2_12, proc_20->active_bunit
@ C_Code.c:141: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #68]	@ gpEkrBattleUnitRight.3_13, proc_20->opp_bunit
@ C_Code.c:142: 	if (!proc->side) { 
	cmp	r0, #1	@ _9,
	bne	.L39		@,
@ C_Code.c:143: 		proc->active_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #64]	@ gpEkrBattleUnitRight.3_13, proc_20->active_bunit
@ C_Code.c:144: 		proc->opp_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #68]	@ gpEkrBattleUnitLeft.2_12, proc_20->opp_bunit
.L39:
@ C_Code.c:146: 	if (!proc->loadedImg) {
	movs	r6, #76	@ tmp168,
@ C_Code.c:146: 	if (!proc->loadedImg) {
	ldrb	r3, [r4, r6]	@ tmp169,
	cmp	r3, #0	@ tmp169,
	beq	.L41		@,
.L36:
@ C_Code.c:158: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L37:
@ C_Code.c:137: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	subs	r3, r3, #1	@ tmp154,
	lsls	r3, r3, #24	@ tmp155, tmp154,
	lsrs	r0, r3, #24	@ iftmp.1_15, tmp155,
	b	.L38		@
.L41:
@ C_Code.c:147: 		proc->timer2 = 0xFF; 
	adds	r3, r3, #255	@ tmp170,
@ C_Code.c:148: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r5, .L42+32	@ tmp173,
	movs	r2, #6	@,
@ C_Code.c:147: 		proc->timer2 = 0xFF; 
	str	r3, [r4, #56]	@ tmp170, proc_20->timer2
@ C_Code.c:148: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r0, .L42+36	@ tmp172,
	ldr	r1, .L42+40	@,
	subs	r3, r3, #253	@,
	bl	.L44		@
@ C_Code.c:149: 		Copy2dChr(&BattleStar, (void*)0x06012a40, 2, 2); // 0x108 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+44	@ tmp175,
	ldr	r1, .L42+48	@,
	bl	.L44		@
@ C_Code.c:150: 		Copy2dChr(&A_Button, (void*)0x06012800, 2, 2); // 0x140
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+52	@ tmp178,
	ldr	r1, .L42+56	@,
	bl	.L44		@
@ C_Code.c:151: 		Copy2dChr(&B_Button, (void*)0x06012840, 2, 2); // 0x142 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+60	@ tmp181,
	ldr	r1, .L42+64	@,
	bl	.L44		@
@ C_Code.c:152: 		Copy2dChr(&Left_Button, (void*)0x06012880, 2, 2); // 0x144
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+68	@ tmp184,
	ldr	r1, .L42+72	@,
	bl	.L44		@
@ C_Code.c:153: 		Copy2dChr(&Right_Button, (void*)0x060128C0, 2, 2); // 0x146
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+76	@ tmp187,
	ldr	r1, .L42+80	@,
	bl	.L44		@
@ C_Code.c:154: 		Copy2dChr(&Up_Button, (void*)0x06012900, 2, 2); // 0x148
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+84	@ tmp190,
	ldr	r1, .L42+88	@,
	bl	.L44		@
@ C_Code.c:155: 		Copy2dChr(&Down_Button, (void*)0x06012940, 2, 2); // 0x14a
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L42+92	@ tmp193,
	ldr	r1, .L42+96	@,
	bl	.L44		@
@ C_Code.c:156: 		proc->loadedImg = true;
	movs	r3, #1	@ tmp196,
	strb	r3, [r4, r6]	@ tmp196, proc_20->loadedImg
@ C_Code.c:158: }
	b	.L36		@
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
	.type	BreakOnce, %function
BreakOnce:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:240: 	if (proc->broke) { return; } 
	movs	r3, #75	@ tmp116,
@ C_Code.c:240: 	if (proc->broke) { return; } 
	ldrb	r2, [r0, r3]	@ tmp117,
	cmp	r2, #0	@ tmp117,
	bne	.L45		@,
@ C_Code.c:241: 	proc->broke = true; 
	adds	r2, r2, #1	@ tmp119,
	strb	r2, [r0, r3]	@ tmp119, proc_4(D)->broke
@ C_Code.c:242: 	asm("mov r11, r11");
	.syntax divided
@ 242 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L45:
@ C_Code.c:243: } 
	@ sp needed	@
	bx	lr
	.size	BreakOnce, .-BreakOnce
	.align	1
	.p2align 2,,3
	.global	HitNow
	.syntax unified
	.code	16
	.thumb_func
	.type	HitNow, %function
HitNow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:247: 	if (!HpProc) { return false; } // 
	cmp	r1, #0	@ tmp126,
	beq	.L49		@,
@ C_Code.c:249: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #82	@ tmp119,
@ C_Code.c:249: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r0, [r0, r3]	@ tmp121,
	rsbs	r3, r0, #0	@ tmp123, tmp121
	adcs	r0, r0, r3	@ <retval>, tmp121, tmp123
.L47:
@ C_Code.c:251: } 
	@ sp needed	@
	bx	lr
.L49:
@ C_Code.c:247: 	if (!HpProc) { return false; } // 
	movs	r0, #0	@ <retval>,
	b	.L47		@
	.size	HitNow, .-HitNow
	.align	1
	.p2align 2,,3
	.global	GetButtonsToPress
	.syntax unified
	.code	16
	.thumb_func
	.type	GetButtonsToPress, %function
GetButtonsToPress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r2, .L53	@ tmp118,
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r2, [r2]	@ AlwaysA, AlwaysA
@ C_Code.c:295: int GetButtonsToPress(TimedHitsProc* proc) { 
	movs	r3, r0	@ proc, tmp122
	push	{r4, lr}	@
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
	cmp	r2, #0	@ AlwaysA,
	bne	.L52		@,
@ C_Code.c:297: 	int keys = proc->buttonsToPress;
	adds	r2, r2, #84	@ tmp120,
@ C_Code.c:297: 	int keys = proc->buttonsToPress;
	ldrh	r0, [r0, r2]	@ <retval>,
@ C_Code.c:298: 	if (!keys) { 
	cmp	r0, #0	@ <retval>,
	bne	.L50		@,
	movs	r0, r3	@, proc
	bl	GetButtonsToPress.part.0		@
.L50:
@ C_Code.c:332: } 
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L52:
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
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
	.type	CountKeysPressed, %function
CountKeysPressed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:335: int CountKeysPressed(u32 keys) { 
	movs	r1, r0	@ keys, tmp130
	movs	r2, #5	@ ivtmp_1,
	movs	r3, #1	@ pretmp_5,
@ C_Code.c:336: 	int c = 0; 
	movs	r0, #0	@ <retval>,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r4, #32	@ tmp129,
	ldr	r5, .L62	@ tmp128,
	b	.L58		@
.L61:
	adds	r3, r5, r0	@ tmp123, tmp128, <retval>
	ldrb	r3, [r3, r4]	@ pretmp_5, RomKeysList
.L58:
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r1	@ tmp120, keys
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp127, tmp120
	sbcs	r3, r3, r6	@ tmp126, tmp120, tmp127
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	subs	r2, r2, #1	@ ivtmp_1,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r0, r0, r3	@ <retval>, <retval>, tmp126
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	cmp	r2, #0	@ ivtmp_1,
	bne	.L61		@,
@ C_Code.c:342: } 
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
	.type	PressedSpecificKeys, %function
PressedSpecificKeys:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r8	@,
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, .L98	@ tmp145,
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:344: int PressedSpecificKeys(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r1	@ keys, tmp188
	push	{lr}	@
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
	cmp	r3, #0	@ AlwaysA,
	bne	.L80		@,
@ C_Code.c:297: 	int keys = proc->buttonsToPress;
	adds	r3, r3, #84	@ tmp147,
	ldrh	r3, [r0, r3]	@ keys,
	mov	r8, r3	@ keys, keys
@ C_Code.c:298: 	if (!keys) { 
	cmp	r3, #0	@ keys,
	beq	.L66		@,
.L93:
@ C_Code.c:346: 	int count = CountKeysPressed(reqKeys); 
	mov	r0, r8	@ prephitmp_13, keys
.L65:
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
	movs	r1, #5	@ ivtmp_26,
	movs	r3, #1	@ pretmp_59,
@ C_Code.c:336: 	int c = 0; 
	movs	r2, #0	@ c,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r6, #32	@ tmp186,
	ldr	r7, .L98+4	@ tmp185,
	b	.L69		@
.L94:
	adds	r3, r7, r2	@ tmp151, tmp185, c
	ldrb	r3, [r3, r6]	@ pretmp_59, RomKeysList
.L69:
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r0	@ tmp148, prephitmp_13
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r5, r3, #1	@ tmp169, tmp148
	sbcs	r3, r3, r5	@ tmp168, tmp148, tmp169
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	subs	r1, r1, #1	@ ivtmp_26,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r2, r2, r3	@ c, c, tmp168
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	cmp	r1, #0	@ ivtmp_26,
	bne	.L94		@,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r5, .L98+4	@ tmp183,
	movs	r0, #5	@ ivtmp_35,
	movs	r3, #1	@ pretmp_74,
@ C_Code.c:336: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	mov	ip, r5	@ tmp183, tmp183
	movs	r7, #32	@ tmp184,
	b	.L68		@
.L95:
	mov	r3, ip	@ tmp183, tmp183
	adds	r3, r3, r1	@ tmp155, tmp183, c
	ldrb	r3, [r3, r7]	@ pretmp_74, RomKeysList
.L68:
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp152, keys
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp172, tmp152
	sbcs	r3, r3, r6	@ tmp171, tmp152, tmp172
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	subs	r0, r0, #1	@ ivtmp_35,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp171
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	cmp	r0, #0	@ ivtmp_35,
	bne	.L95		@,
	movs	r0, #5	@ ivtmp_62,
	movs	r3, #1	@ pretmp_78,
@ C_Code.c:347: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r2, r1	@ c, c
	blt	.L82		@,
@ C_Code.c:336: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r6, #32	@ tmp180,
	ldr	r7, .L98+4	@ tmp179,
	b	.L75		@
.L96:
	adds	r3, r7, r1	@ tmp159, tmp179, c
	ldrb	r3, [r3, r6]	@ pretmp_78, RomKeysList
.L75:
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp156, keys
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r5, r3, #1	@ tmp175, tmp156
	sbcs	r3, r3, r5	@ tmp174, tmp156, tmp175
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	subs	r0, r0, #1	@ ivtmp_62,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp174
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	cmp	r0, #0	@ ivtmp_62,
	bne	.L96		@,
@ C_Code.c:347: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r2, r1	@ tmp160, c, c
@ C_Code.c:347: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp160,
	bgt	.L84		@,
.L77:
@ C_Code.c:348: 	return (keys & reqKeys); 
	mov	r0, r8	@ keys, keys
	ands	r0, r4	@ keys, keys
.L64:
@ C_Code.c:349: } 
	@ sp needed	@
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L66:
	bl	GetButtonsToPress.part.0		@
	mov	r8, r0	@ keys, tmp189
	b	.L93		@
.L82:
@ C_Code.c:336: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r6, #32	@ tmp182,
	ldr	r7, .L98+4	@ tmp181,
	b	.L72		@
.L97:
	adds	r3, r7, r1	@ tmp164, tmp181, c
	ldrb	r3, [r3, r6]	@ pretmp_76, RomKeysList
.L72:
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp161, keys
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r5, r3, #1	@ tmp178, tmp161
	sbcs	r3, r3, r5	@ tmp177, tmp161, tmp178
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	subs	r0, r0, #1	@ ivtmp_43,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp177
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	cmp	r0, #0	@ ivtmp_43,
	bne	.L97		@,
@ C_Code.c:347: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r1, r2	@ tmp165, c, c
@ C_Code.c:347: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp165,
	ble	.L77		@,
.L84:
@ C_Code.c:347: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	movs	r0, #0	@ <retval>,
	b	.L64		@
.L80:
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
	movs	r3, #1	@ keys,
	movs	r0, #1	@ prephitmp_13,
	mov	r8, r3	@ keys, keys
	b	.L65		@
.L99:
	.align	2
.L98:
	.word	AlwaysA
	.word	.LANCHOR0
	.size	PressedSpecificKeys, .-PressedSpecificKeys
	.align	1
	.p2align 2,,3
	.global	SaveInputFrame
	.syntax unified
	.code	16
	.thumb_func
	.type	SaveInputFrame, %function
SaveInputFrame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:351: 	struct Anim* anim = proc->anim; 
	ldr	r5, [r0, #44]	@ anim, proc_17(D)->anim
@ C_Code.c:352: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:352: 	u32 instruction = *anim->pScrCurrent++; 
	adds	r3, r6, #4	@ tmp130, _1,
	str	r3, [r5, #32]	@ tmp130, anim_18->pScrCurrent
@ C_Code.c:353: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	movs	r3, #252	@ tmp132,
@ C_Code.c:350: void SaveInputFrame(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r0	@ proc, tmp151
@ C_Code.c:353: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	movs	r0, #160	@ tmp133,
@ C_Code.c:352: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r2, [r6]	@ instruction, *_1
@ C_Code.c:353: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	lsls	r3, r3, #22	@ tmp132, tmp132,
	ands	r3, r2	@ tmp131, instruction
	lsls	r0, r0, #19	@ tmp133, tmp133,
	cmp	r3, r0	@ tmp131, tmp133
	beq	.L107		@,
.L101:
@ C_Code.c:362: 	if (PressedSpecificKeys(proc, keys)) { 
	movs	r0, r4	@, proc
@ C_Code.c:361: 	instruction = *anim->pScrCurrent--; 
	str	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:362: 	if (PressedSpecificKeys(proc, keys)) { 
	bl	PressedSpecificKeys		@
@ C_Code.c:362: 	if (PressedSpecificKeys(proc, keys)) { 
	cmp	r0, #0	@ tmp153,
	beq	.L100		@,
@ C_Code.c:363: 		if (!proc->frame) { 
	movs	r3, #78	@ tmp143,
@ C_Code.c:363: 		if (!proc->frame) { 
	ldrb	r2, [r4, r3]	@ tmp144,
	cmp	r2, #0	@ tmp144,
	beq	.L108		@,
.L100:
@ C_Code.c:368: }  
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L107:
@ C_Code.c:354: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	movs	r3, #255	@ tmp134,
	ands	r3, r2	@ _4, instruction
@ C_Code.c:354: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	cmp	r3, #4	@ _4,
	beq	.L109		@,
@ C_Code.c:357: 		if (ANINS_COMMAND_GET_ID(instruction) == 0xF) {
	cmp	r3, #15	@ _4,
	bne	.L101		@,
@ C_Code.c:358: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #65	@ tmp141,
	strb	r2, [r4, r3]	@ proc_17(D)->timer,
@ C_Code.c:358: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	movs	r3, #0	@ tmp142,
	str	r3, [r4, #56]	@ tmp142, proc_17(D)->timer2
	b	.L101		@
.L108:
@ C_Code.c:365: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	movs	r1, #128	@,
	movs	r0, #159	@,
@ C_Code.c:364: 			proc->frame = proc->timer; // locate is side for stereo? 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
@ C_Code.c:365: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r1, r1, #1	@,,
@ C_Code.c:364: 			proc->frame = proc->timer; // locate is side for stereo? 
	strb	r2, [r4, r3]	@ proc_17(D)->timer, proc_17(D)->frame
@ C_Code.c:365: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r0, r0, #1	@,,
	movs	r2, #120	@,
	ldr	r4, .L110	@ tmp150,
	subs	r3, r3, #77	@,
	bl	.L112		@
@ C_Code.c:368: }  
	b	.L100		@
.L109:
@ C_Code.c:355: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #75	@ tmp137,
	strb	r2, [r4, r3]	@ proc_17(D)->timer,
@ C_Code.c:355: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	movs	r3, #0	@ tmp138,
	str	r3, [r4, #56]	@ tmp138, proc_17(D)->timer2
	b	.L101		@
.L111:
	.align	2
.L110:
	.word	PlaySFX
	.size	SaveInputFrame, .-SaveInputFrame
	.align	1
	.p2align 2,,3
	.global	SaveIfWeHitOnTime
	.syntax unified
	.code	16
	.thumb_func
	.type	SaveIfWeHitOnTime, %function
SaveIfWeHitOnTime:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:370: 	if (proc->frame) { 
	movs	r3, #78	@ tmp128,
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:369: void SaveIfWeHitOnTime(TimedHitsProc* proc) {
	push	{r4, lr}	@
@ C_Code.c:370: 	if (proc->frame) { 
	cmp	r3, #0	@ _1,
	beq	.L113		@,
@ C_Code.c:371: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #80	@ tmp129,
@ C_Code.c:371: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, .L124	@ tmp130,
@ C_Code.c:371: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldrb	r2, [r0, r2]	@ _2,
@ C_Code.c:371: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, [r1]	@ pretmp_33, LenienceFrames
@ C_Code.c:371: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, #255	@ _2,
	beq	.L116		@,
.L123:
@ C_Code.c:371: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	subs	r2, r2, r3	@ tmp131, _2, _1
	asrs	r4, r2, #31	@ tmp147, tmp131,
	adds	r2, r2, r4	@ tmp132, tmp131, tmp147
	eors	r2, r4	@ tmp132, tmp147
@ C_Code.c:371: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, r1	@ tmp132, pretmp_33
	bge	.L117		@,
@ C_Code.c:371: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #72	@ tmp133,
	movs	r4, #1	@ tmp134,
	strb	r4, [r0, r2]	@ tmp134, proc_21(D)->hitOnTime
.L117:
@ C_Code.c:373: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	ldr	r2, [r0, #52]	@ proc_21(D)->timer, proc_21(D)->timer
	subs	r3, r2, r3	@ tmp139, proc_21(D)->timer, _1
@ C_Code.c:373: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	cmp	r3, r1	@ tmp139, pretmp_33
	bge	.L113		@,
@ C_Code.c:373: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	movs	r3, #72	@ tmp141,
	movs	r2, #1	@ tmp142,
	strb	r2, [r0, r3]	@ tmp142, proc_21(D)->hitOnTime
.L113:
@ C_Code.c:376: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L116:
@ C_Code.c:372: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	movs	r2, #79	@ tmp136,
	ldrb	r2, [r0, r2]	@ _8,
@ C_Code.c:372: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	cmp	r2, #255	@ _8,
	bne	.L123		@,
	b	.L117		@
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
	.type	CheatCodeOn, %function
CheatCodeOn:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:379: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L127	@ tmp118,
@ C_Code.c:380: } 
	@ sp needed	@
@ C_Code.c:379: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldrb	r0, [r3, #31]	@ tmp120,
	movs	r3, #127	@ tmp122,
	bics	r0, r3	@ tmp117, tmp122
@ C_Code.c:380: } 
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
	.type	DidWeHitOnTime, %function
DidWeHitOnTime:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:379: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L133	@ tmp120,
@ C_Code.c:383: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp123,
	cmp	r3, #127	@ tmp123,
	bhi	.L132		@,
@ C_Code.c:384: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L133+4	@ tmp124,
@ C_Code.c:384: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L132		@,
@ C_Code.c:385: 	return proc->hitOnTime;
	adds	r3, r3, #72	@ tmp126,
	ldrb	r0, [r0, r3]	@ <retval>,
	b	.L129		@
.L132:
@ C_Code.c:383: 	if (CheatCodeOn()) { return true; } 
	movs	r0, #1	@ <retval>,
.L129:
@ C_Code.c:386: }
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
	.type	DrawButtonsToPress, %function
DrawButtonsToPress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r5, r8	@,
	mov	r6, r9	@,
	mov	lr, fp	@,
	mov	r7, r10	@,
	push	{r5, r6, r7, lr}	@
	movs	r5, r3	@ palID, tmp274
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, .L189	@ tmp162,
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:388: void DrawButtonsToPress(TimedHitsProc* proc, int x, int y, int palID) { 
	sub	sp, sp, #36	@,,
@ C_Code.c:388: void DrawButtonsToPress(TimedHitsProc* proc, int x, int y, int palID) { 
	movs	r6, r0	@ proc, tmp271
	mov	r8, r1	@ x, tmp272
	str	r2, [sp, #8]	@ tmp273, %sfp
@ C_Code.c:296: 	if (AlwaysA) { return A_BUTTON; } 
	cmp	r3, #0	@ AlwaysA,
	beq	.LCB898	@
	b	.L154	@long jump	@
.LCB898:
@ C_Code.c:297: 	int keys = proc->buttonsToPress;
	adds	r3, r3, #84	@ tmp164,
	ldrh	r4, [r0, r3]	@ _78,
@ C_Code.c:298: 	if (!keys) { 
	cmp	r4, #0	@ _78,
	beq	.L137		@,
.L179:
@ C_Code.c:404: 	if (keys & A_BUTTON) { 
	movs	r3, #1	@ tmp195,
	ands	r3, r4	@ tmp195, _27
	mov	fp, r3	@ _87, tmp195
@ C_Code.c:407: 	if (keys & B_BUTTON) { 
	movs	r3, #2	@ tmp196,
	ands	r3, r4	@ tmp196, _27
	str	r3, [sp, #12]	@ tmp196, %sfp
@ C_Code.c:410: 	if (keys & DPAD_LEFT) { 
	movs	r3, #32	@ tmp197,
	ands	r3, r4	@ tmp197, _27
	str	r3, [sp, #16]	@ tmp197, %sfp
@ C_Code.c:413: 	if (keys & DPAD_RIGHT) { 
	movs	r3, #16	@ tmp198,
	ands	r3, r4	@ tmp198, _27
	str	r3, [sp, #20]	@ tmp198, %sfp
@ C_Code.c:416: 	if (keys & DPAD_UP) { 
	movs	r3, #64	@ tmp199,
	ands	r3, r4	@ tmp199, _27
	str	r3, [sp, #24]	@ tmp199, %sfp
@ C_Code.c:419: 	if (keys & DPAD_DOWN) { 
	movs	r3, #128	@ tmp200,
	ands	r3, r4	@ tmp200, _27
	str	r3, [sp, #28]	@ tmp200, %sfp
.L136:
@ C_Code.c:391: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r3, .L189+4	@ tmp201,
@ C_Code.c:391: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r3, [r3]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
	cmp	r3, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L140		@,
@ C_Code.c:391: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	movs	r3, #78	@ tmp205,
@ C_Code.c:391: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldrb	r3, [r6, r3]	@ tmp206,
	cmp	r3, #0	@ tmp206,
	bne	.L180		@,
.L140:
@ C_Code.c:393: 	int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); //OAM2_CHR(0);
	lsls	r5, r5, #28	@ tmp204, palID,
	lsrs	r5, r5, #16	@ _110, tmp204,
.L139:
@ C_Code.c:394: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	movs	r3, #255	@ tmp207,
	ldr	r7, [sp, #8]	@ y, %sfp
	ldr	r6, .L189+8	@ tmp265,
	ands	r3, r7	@ tmp207, y
	mov	r2, r8	@ x, x
	mov	r9, r3	@ _5, tmp207
	movs	r3, r6	@ tmp209, tmp265
	lsls	r1, r2, #23	@ tmp211, x,
	ldr	r7, .L189+12	@ tmp266,
	mov	r2, r9	@, _5
	movs	r0, #2	@,
	adds	r3, r3, #40	@ tmp209,
	lsrs	r1, r1, #23	@ tmp210, tmp211,
	str	r5, [sp]	@ _110,
	bl	.L191		@
@ C_Code.c:395: 	x += 32; 
	mov	r1, r8	@ x, x
@ C_Code.c:396: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	movs	r3, r6	@ tmp214, tmp265
@ C_Code.c:395: 	x += 32; 
	adds	r1, r1, #32	@ x,
@ C_Code.c:396: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	lsls	r1, r1, #23	@ tmp217, x,
	mov	r2, r9	@, _5
	movs	r0, #2	@,
	adds	r3, r3, #48	@ tmp214,
	lsrs	r1, r1, #23	@ tmp216, tmp217,
	str	r5, [sp]	@ _110,
	bl	.L191		@
@ C_Code.c:394: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	r10, r7	@ tmp266, tmp266
@ C_Code.c:397: 	y += 16; x -= 36; 
	ldr	r7, [sp, #8]	@ y, %sfp
	movs	r1, #5	@ ivtmp_35,
	movs	r3, #1	@ pretmp_112,
@ C_Code.c:336: 	int c = 0; 
	movs	r2, #0	@ c,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r0, #32	@ tmp270,
	mov	ip, r5	@ _110, _110
@ C_Code.c:397: 	y += 16; x -= 36; 
	adds	r7, r7, #16	@ y,
	b	.L143		@
.L181:
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r3, r6, r2	@ tmp222, tmp265, c
	ldrb	r3, [r3, r0]	@ pretmp_112, RomKeysList
.L143:
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp219, _27
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r5, r3, #1	@ tmp269, tmp219
	sbcs	r3, r3, r5	@ tmp268, tmp219, tmp269
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	subs	r1, r1, #1	@ ivtmp_35,
@ C_Code.c:338: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r2, r2, r3	@ c, c, tmp268
@ C_Code.c:337: 	for (int i = 0; i < 5; ++i) { 
	cmp	r1, #0	@ ivtmp_35,
	bne	.L181		@,
@ C_Code.c:400: 	if (count == 1) { x += 24; } // centering 
	mov	r5, ip	@ _110, _110
	cmp	r2, #1	@ c,
	beq	.L182		@,
@ C_Code.c:401: 	if (count == 2) { x += 16; } 
	cmp	r2, #2	@ c,
	bne	.L146		@,
@ C_Code.c:401: 	if (count == 2) { x += 16; } 
	mov	r4, r8	@ x, x
	adds	r4, r4, #12	@ x,
.L145:
@ C_Code.c:404: 	if (keys & A_BUTTON) { 
	mov	r3, fp	@ _87, _87
	cmp	r3, #0	@ _87,
	bne	.L183		@,
.L148:
@ C_Code.c:407: 	if (keys & B_BUTTON) { 
	ldr	r3, [sp, #12]	@ _90, %sfp
	cmp	r3, #0	@ _90,
	bne	.L184		@,
.L149:
@ C_Code.c:410: 	if (keys & DPAD_LEFT) { 
	ldr	r3, [sp, #16]	@ _93, %sfp
	cmp	r3, #0	@ _93,
	bne	.L185		@,
.L150:
@ C_Code.c:413: 	if (keys & DPAD_RIGHT) { 
	ldr	r3, [sp, #20]	@ _96, %sfp
	cmp	r3, #0	@ _96,
	bne	.L186		@,
.L151:
@ C_Code.c:416: 	if (keys & DPAD_UP) { 
	ldr	r3, [sp, #24]	@ _99, %sfp
	cmp	r3, #0	@ _99,
	bne	.L187		@,
.L152:
@ C_Code.c:419: 	if (keys & DPAD_DOWN) { 
	ldr	r3, [sp, #28]	@ _102, %sfp
	cmp	r3, #0	@ _102,
	bne	.L188		@,
.L135:
@ C_Code.c:426: } 
	add	sp, sp, #36	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L137:
	bl	GetButtonsToPress.part.0		@
	movs	r4, r0	@ _27, tmp275
	b	.L179		@
.L180:
	movs	r5, #224	@ _110,
	lsls	r5, r5, #8	@ _110, _110,
	b	.L139		@
.L146:
@ C_Code.c:402: 	if (count == 3) { x += 8; } 
	mov	r3, r8	@ x, x
	adds	r4, r3, #4	@ x, x,
@ C_Code.c:402: 	if (count == 3) { x += 8; } 
	cmp	r2, #3	@ c,
	beq	.L145		@,
@ C_Code.c:397: 	y += 16; x -= 36; 
	subs	r4, r4, #8	@ x,
	b	.L145		@
.L182:
@ C_Code.c:400: 	if (count == 1) { x += 24; } // centering 
	mov	r4, r8	@ x, x
@ C_Code.c:404: 	if (keys & A_BUTTON) { 
	mov	r3, fp	@ _87, _87
@ C_Code.c:400: 	if (count == 1) { x += 24; } // centering 
	adds	r4, r4, #20	@ x,
@ C_Code.c:404: 	if (keys & A_BUTTON) { 
	cmp	r3, #0	@ _87,
	beq	.L148		@,
.L183:
@ C_Code.c:405: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp224, tmp265
	movs	r2, #255	@ tmp225,
	lsls	r1, r4, #23	@ tmp228, x,
	adds	r3, r3, #56	@ tmp224,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	ands	r2, r7	@ tmp226, y
	lsrs	r1, r1, #23	@ tmp227, tmp228,
	bl	.L192		@
@ C_Code.c:407: 	if (keys & B_BUTTON) { 
	ldr	r3, [sp, #12]	@ _90, %sfp
@ C_Code.c:405: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:407: 	if (keys & B_BUTTON) { 
	cmp	r3, #0	@ _90,
	beq	.L149		@,
.L184:
@ C_Code.c:408: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp231, tmp265
	movs	r2, #255	@ tmp232,
	lsls	r1, r4, #23	@ tmp235, x,
	adds	r3, r3, #64	@ tmp231,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	ands	r2, r7	@ tmp233, y
	lsrs	r1, r1, #23	@ tmp234, tmp235,
	bl	.L192		@
@ C_Code.c:410: 	if (keys & DPAD_LEFT) { 
	ldr	r3, [sp, #16]	@ _93, %sfp
@ C_Code.c:408: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:410: 	if (keys & DPAD_LEFT) { 
	cmp	r3, #0	@ _93,
	beq	.L150		@,
.L185:
@ C_Code.c:411: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp238, tmp265
	movs	r2, #255	@ tmp239,
	lsls	r1, r4, #23	@ tmp242, x,
	adds	r3, r3, #72	@ tmp238,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	ands	r2, r7	@ tmp240, y
	lsrs	r1, r1, #23	@ tmp241, tmp242,
	bl	.L192		@
@ C_Code.c:413: 	if (keys & DPAD_RIGHT) { 
	ldr	r3, [sp, #20]	@ _96, %sfp
@ C_Code.c:411: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:413: 	if (keys & DPAD_RIGHT) { 
	cmp	r3, #0	@ _96,
	beq	.L151		@,
.L186:
@ C_Code.c:414: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp245, tmp265
	movs	r2, #255	@ tmp246,
	lsls	r1, r4, #23	@ tmp249, x,
	adds	r3, r3, #80	@ tmp245,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	ands	r2, r7	@ tmp247, y
	lsrs	r1, r1, #23	@ tmp248, tmp249,
	bl	.L192		@
@ C_Code.c:416: 	if (keys & DPAD_UP) { 
	ldr	r3, [sp, #24]	@ _99, %sfp
@ C_Code.c:414: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:416: 	if (keys & DPAD_UP) { 
	cmp	r3, #0	@ _99,
	beq	.L152		@,
.L187:
@ C_Code.c:417: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp252, tmp265
	movs	r2, #255	@ tmp253,
	lsls	r1, r4, #23	@ tmp256, x,
	adds	r3, r3, #88	@ tmp252,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	ands	r2, r7	@ tmp254, y
	lsrs	r1, r1, #23	@ tmp255, tmp256,
	bl	.L192		@
@ C_Code.c:419: 	if (keys & DPAD_DOWN) { 
	ldr	r3, [sp, #28]	@ _102, %sfp
@ C_Code.c:417: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:419: 	if (keys & DPAD_DOWN) { 
	cmp	r3, #0	@ _102,
	beq	.L135		@,
.L188:
@ C_Code.c:420: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp265, tmp265
	movs	r2, #255	@ tmp260,
	lsls	r1, r4, #23	@ tmp263, x,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	adds	r3, r3, #96	@ tmp265,
	ands	r2, r7	@ tmp261, y
	lsrs	r1, r1, #23	@ tmp262, tmp263,
	bl	.L192		@
@ C_Code.c:426: } 
	b	.L135		@
.L154:
	movs	r3, #0	@ _102,
	str	r3, [sp, #28]	@ _102, %sfp
	str	r3, [sp, #24]	@ _99, %sfp
	str	r3, [sp, #20]	@ _96, %sfp
	str	r3, [sp, #16]	@ _93, %sfp
	str	r3, [sp, #12]	@ _90, %sfp
	adds	r3, r3, #1	@ _87,
	mov	fp, r3	@ _87, _87
	movs	r4, #1	@ _27,
	b	.L136		@
.L190:
	.align	2
.L189:
	.word	AlwaysA
	.word	ChangePaletteWhenButtonIsPressed
	.word	.LANCHOR0
	.word	PutSprite
	.size	DrawButtonsToPress, .-DrawButtonsToPress
	.align	1
	.p2align 2,,3
	.global	GetDefaultDamagePercent
	.syntax unified
	.code	16
	.thumb_func
	.type	GetDefaultDamagePercent, %function
GetDefaultDamagePercent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:506: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp122,
	movs	r3, #192	@ tmp123,
	ldrsb	r1, [r0, r1]	@ tmp122,
	ands	r3, r1	@ _14, tmp122
@ C_Code.c:505: 	if (success) { 
	cmp	r2, #0	@ tmp131,
	beq	.L194		@,
@ C_Code.c:506: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _14,
	bne	.L195		@,
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L199	@ tmp124,
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L198		@,
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L199+4	@ tmp126,
	ldr	r0, [r3]	@ <retval>,
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L193		@
.L194:
@ C_Code.c:512: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _14,
	beq	.L198		@,
@ C_Code.c:515: 	return FailedHitDamagePercent; 
	ldr	r3, .L199+8	@ tmp128,
	ldr	r0, [r3]	@ <retval>,
.L193:
@ C_Code.c:516: } 
	@ sp needed	@
	bx	lr
.L195:
@ C_Code.c:510: 		return BonusDamagePercent; 
	ldr	r3, .L199+12	@ tmp127,
	ldr	r0, [r3]	@ <retval>,
	b	.L193		@
.L198:
@ C_Code.c:508: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
	b	.L193		@
.L200:
	.align	2
.L199:
	.word	BlockingEnabled
	.word	ReducedDamagePercent
	.word	FailedHitDamagePercent
	.word	BonusDamagePercent
	.size	GetDefaultDamagePercent, .-GetDefaultDamagePercent
	.align	1
	.p2align 2,,3
	.global	GetDamagePercent
	.syntax unified
	.code	16
	.thumb_func
	.type	GetDamagePercent, %function
GetDamagePercent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:506: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp122,
	movs	r3, #192	@ tmp123,
	ldrsb	r1, [r0, r1]	@ tmp122,
	ands	r3, r1	@ _9, tmp122
@ C_Code.c:505: 	if (success) { 
	cmp	r2, #0	@ tmp131,
	beq	.L202		@,
@ C_Code.c:506: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _9,
	bne	.L203		@,
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L207	@ tmp124,
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L206		@,
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L207+4	@ tmp126,
	ldr	r0, [r3]	@ <retval>,
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L201		@
.L202:
@ C_Code.c:512: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _9,
	beq	.L206		@,
@ C_Code.c:515: 	return FailedHitDamagePercent; 
	ldr	r3, .L207+8	@ tmp128,
	ldr	r0, [r3]	@ <retval>,
.L201:
@ C_Code.c:520: } 
	@ sp needed	@
	bx	lr
.L203:
@ C_Code.c:510: 		return BonusDamagePercent; 
	ldr	r3, .L207+12	@ tmp127,
	ldr	r0, [r3]	@ <retval>,
	b	.L201		@
.L206:
@ C_Code.c:508: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
@ C_Code.c:519: 	return GetDefaultDamagePercent(active_bunit, opp_bunit, success); 
	b	.L201		@
.L208:
	.align	2
.L207:
	.word	BlockingEnabled
	.word	ReducedDamagePercent
	.word	FailedHitDamagePercent
	.word	BonusDamagePercent
	.size	GetDamagePercent, .-GetDamagePercent
	.align	1
	.p2align 2,,3
	.global	AdjustAllRounds
	.syntax unified
	.code	16
	.thumb_func
	.type	AdjustAllRounds, %function
AdjustAllRounds:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}	@
@ C_Code.c:524: 	for (int i = id; i < 22; i += 2) {
	cmp	r0, #21	@ id,
	bgt	.L209		@,
	ldr	r3, .L219	@ tmp128,
	lsls	r2, r0, #1	@ tmp127, id,
@ C_Code.c:526: 		if (hp == 0xffff) { break; }
	ldr	r5, .L219+4	@ tmp129,
	adds	r2, r2, r3	@ ivtmp.182, tmp127, tmp128
	b	.L213		@
.L211:
	movs	r4, #0	@ _4,
@ C_Code.c:528: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	cmp	r3, r1	@ _1, difference
	blt	.L212		@,
@ C_Code.c:528: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	subs	r3, r3, r1	@ tmp132, _1, difference
.L217:
	lsls	r3, r3, #16	@ tmp133, tmp132,
	lsrs	r4, r3, #16	@ _4, tmp133,
.L212:
@ C_Code.c:524: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:527: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:524: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.182,
	cmp	r0, #21	@ id,
	bgt	.L209		@,
.L213:
@ C_Code.c:525: 		hp = gEfxHpLut[i]; 
	ldrh	r3, [r2]	@ _1, MEM[(short unsigned int *)_18]
@ C_Code.c:526: 		if (hp == 0xffff) { break; }
	cmp	r3, r5	@ _1, tmp129
	beq	.L209		@,
@ C_Code.c:527: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r1, #0	@ difference,
	bge	.L211		@,
@ C_Code.c:527: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	adds	r3, r3, r1	@ hp, _1, difference
	movs	r4, #0	@ _4,
@ C_Code.c:527: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r3, #0	@ hp,
	bgt	.L217		@,
@ C_Code.c:524: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:527: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:524: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.182,
	cmp	r0, #21	@ id,
	ble	.L213		@,
.L209:
@ C_Code.c:542: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L220:
	.align	2
.L219:
	.word	gEfxHpLut
	.word	65535
	.size	AdjustAllRounds, .-AdjustAllRounds
	.align	1
	.p2align 2,,3
	.global	CheckForDeath
	.syntax unified
	.code	16
	.thumb_func
	.type	CheckForDeath, %function
CheckForDeath:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r8	@,
	movs	r4, r0	@ proc, tmp200
	movs	r6, r2	@ active_bunit, tmp202
@ C_Code.c:554: 	int side = proc->side; 
	movs	r2, #77	@ tmp143,
@ C_Code.c:553: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	push	{lr}	@
@ C_Code.c:553: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	movs	r7, r3	@ opp_bunit, tmp203
	ldr	r0, [sp, #28]	@ hp, hp
@ C_Code.c:554: 	int side = proc->side; 
	ldrb	r3, [r4, r2]	@ _1,
@ C_Code.c:553: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	movs	r5, r1	@ HpProc, tmp201
@ C_Code.c:554: 	int side = proc->side; 
	mov	r8, r3	@ _1, _1
@ C_Code.c:558: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	cmp	r0, #0	@ hp,
	blt	.L225		@,
.L222:
@ C_Code.c:559: 	if (hp <= 0) { // they are dead 
	cmp	r0, #0	@ hp,
	ble	.L226		@,
.L221:
@ C_Code.c:600: }
	@ sp needed	@
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L226:
@ C_Code.c:565: 		opp_bunit->unit.curHP = 0; 
	movs	r3, #0	@ tmp153,
	strb	r3, [r7, #19]	@ tmp153, opp_bunit_32(D)->unit.curHP
@ C_Code.c:566: 		if (UsingSkillSys) { HpProc->post = 0; } 
	ldr	r3, .L227	@ tmp155,
@ C_Code.c:566: 		if (UsingSkillSys) { HpProc->post = 0; } 
	ldr	r3, [r3]	@ UsingSkillSys, UsingSkillSys
	cmp	r3, #0	@ UsingSkillSys,
	bne	.L224		@,
@ C_Code.c:567: 		else { HpProc->post = 0; HpProc->postHpAtkrSS = 0; } 
	movs	r2, #82	@ tmp157,
	strh	r3, [r5, r2]	@ UsingSkillSys, HpProc_34(D)->postHpAtkrSS
.L224:
	movs	r3, #80	@ tmp160,
	movs	r2, #0	@ tmp161,
	strh	r2, [r5, r3]	@ tmp161, HpProc_34(D)->post
@ C_Code.c:569: 		proc->code4frame = 0xff;
	subs	r3, r3, #1	@ tmp163,
	adds	r2, r2, #255	@ tmp164,
	strb	r2, [r4, r3]	@ tmp164, proc_24(D)->code4frame
@ C_Code.c:573: 		HpProc->death = true; 
	subs	r3, r3, #78	@ tmp167,
	subs	r2, r2, #214	@ tmp166,
	strb	r3, [r5, r2]	@ tmp167, HpProc_34(D)->death
@ C_Code.c:578: 		proc->anim->nextRoundId = 8; // seems to mostly work for now? see GetAnimNextRoundType
	ldr	r1, [r4, #44]	@ proc_24(D)->anim, proc_24(D)->anim
	subs	r2, r2, #33	@ tmp170,
	strh	r2, [r1, #14]	@ tmp170, _10->nextRoundId
@ C_Code.c:579: 		proc->anim2->nextRoundId = 8; 
	ldr	r1, [r4, #48]	@ proc_24(D)->anim2, proc_24(D)->anim2
	strh	r2, [r1, #14]	@ tmp170, _11->nextRoundId
@ C_Code.c:581: 		gBanimDoneFlag[0] = true; // stop counterattacks ?
	ldr	r2, .L227+4	@ tmp175,
	str	r3, [r2]	@ tmp167, gBanimDoneFlag[0]
@ C_Code.c:582: 		gBanimDoneFlag[1] = true; // [201fb04..201fb07]!! - nothing else is writing to it. good. 
	str	r3, [r2, #4]	@ tmp167, gBanimDoneFlag[1]
@ C_Code.c:584: 		round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END; 
	movs	r2, #176	@ tmp179,
	ldr	r3, [sp, #24]	@ tmp215, round
	ldrb	r3, [r3, #2]	@ tmp182,
	orrs	r3, r2	@ tmp184, tmp179
	ldr	r2, [sp, #24]	@ tmp216, round
	strb	r3, [r2, #2]	@ tmp184,
@ C_Code.c:589: 		side = 1 ^ side; 
	movs	r3, #1	@ tmp189,
	mov	r2, r8	@ _1, _1
	eors	r2, r3	@ _1, tmp189
	movs	r3, r2	@ side, _1
@ C_Code.c:590: 		id = (gEfxHpLutOff[side] * 2) + (side);
	ldr	r2, .L227+8	@ tmp190,
	lsls	r1, r3, #1	@ tmp191, side,
	ldrsh	r0, [r1, r2]	@ tmp192, gEfxHpLutOff
@ C_Code.c:590: 		id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r0, r0, #1	@ tmp193, tmp192,
@ C_Code.c:590: 		id = (gEfxHpLutOff[side] * 2) + (side);
	adds	r0, r0, r3	@ id, tmp193, side
@ C_Code.c:591: 		hp = GetEfxHp(id); 
	ldr	r3, .L227+12	@ tmp195,
	bl	.L27		@
@ C_Code.c:593: 		active_bunit->unit.curHP = hp; 
	strb	r0, [r6, #19]	@ tmp205, active_bunit_48(D)->unit.curHP
@ C_Code.c:600: }
	b	.L221		@
.L225:
@ C_Code.c:557: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	mov	r2, r8	@ _1, _1
	ldr	r3, .L227+8	@ tmp144,
	lsls	r2, r2, #1	@ tmp145, _1,
	ldrsh	r0, [r2, r3]	@ tmp146, gEfxHpLutOff
@ C_Code.c:557: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r0, r0, #1	@ tmp147, tmp146,
@ C_Code.c:558: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	ldr	r3, .L227+12	@ tmp149,
@ C_Code.c:557: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	add	r0, r0, r8	@ id, _1
@ C_Code.c:558: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	bl	.L27		@
@ C_Code.c:558: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	ldr	r3, [sp, #24]	@ tmp214, round
	ldrb	r3, [r3, #3]	@ tmp152,
	lsls	r3, r3, #24	@ tmp152, tmp152,
	asrs	r3, r3, #24	@ tmp152, tmp152,
@ C_Code.c:558: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	subs	r0, r0, r3	@ hp, tmp204, tmp152
	b	.L222		@
.L228:
	.align	2
.L227:
	.word	UsingSkillSys
	.word	gBanimDoneFlag
	.word	gEfxHpLutOff
	.word	GetEfxHp
	.size	CheckForDeath, .-CheckForDeath
	.global	__aeabi_idiv
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	AdjustDamageByPercent.part.0, %function
AdjustDamageByPercent.part.0:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, fp	@,
	mov	r6, r9	@,
	mov	r5, r8	@,
	mov	r7, r10	@,
	mov	r8, r3	@ opp_bunit, tmp349
@ C_Code.c:605: 	int side = proc->side; 
	movs	r3, #77	@ tmp216,
@ C_Code.c:602: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	push	{r5, r6, r7, lr}	@
	mov	fp, r2	@ active_bunit, tmp348
@ C_Code.c:605: 	int side = proc->side; 
	ldrb	r2, [r0, r3]	@ side,
@ C_Code.c:606: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	ldr	r3, .L263	@ tmp217,
@ C_Code.c:602: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	movs	r7, r1	@ HpProc, tmp347
@ C_Code.c:606: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r1, r2, #1	@ tmp218, side,
	ldrsh	r5, [r1, r3]	@ tmp219, gEfxHpLutOff
@ C_Code.c:606: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r5, r5, #1	@ tmp220, tmp219,
@ C_Code.c:606: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	adds	r3, r5, r2	@ id, tmp220, side
@ C_Code.c:602: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	sub	sp, sp, #20	@,,
@ C_Code.c:606: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	str	r3, [sp, #8]	@ id, %sfp
@ C_Code.c:602: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	mov	r9, r0	@ proc, tmp346
@ C_Code.c:607: 	int hp = GetEfxHp(id); // + round->hpChange; 
	movs	r0, r3	@, id
	ldr	r3, .L263+4	@ tmp221,
	bl	.L27		@
	subs	r6, r0, #0	@ tmp222, tmp350,
@ C_Code.c:608: 	if (!hp) { return; } 
	beq	.L229		@,
@ C_Code.c:610: 	int damage = (round->hpChange * percent) / 100; 
	ldr	r3, [sp, #56]	@ tmp362, round
	ldrb	r3, [r3, #3]	@ _11,
	lsls	r3, r3, #24	@ _11, _11,
	asrs	r3, r3, #24	@ _11, _11,
	mov	r10, r3	@ _11, _11
	movs	r4, r3	@ _197, _11
@ C_Code.c:610: 	int damage = (round->hpChange * percent) / 100; 
	ldr	r3, [sp, #60]	@ tmp364, percent
@ C_Code.c:610: 	int damage = (round->hpChange * percent) / 100; 
	movs	r1, #100	@,
@ C_Code.c:610: 	int damage = (round->hpChange * percent) / 100; 
	mov	r0, r10	@ tmp224, _11
	muls	r0, r3	@ tmp224, tmp364
@ C_Code.c:610: 	int damage = (round->hpChange * percent) / 100; 
	ldr	r3, .L263+8	@ tmp227,
	bl	.L27		@
	subs	r1, r0, #0	@ damage, tmp351,
@ C_Code.c:611: 	if (!damage) { damage = 1; } 
	bne	.L231		@,
@ C_Code.c:611: 	if (!damage) { damage = 1; } 
	adds	r1, r1, #1	@ damage,
.L231:
@ C_Code.c:613: 	if (damage > round->hpChange) { 
	cmp	r10, r1	@ _11, damage
	blt	.L258		@,
@ C_Code.c:634: 	else if (round->hpChange != hp) { 
	cmp	r6, r10	@ tmp222, _11
	bne	.LCB1502	@
	b	.L240	@long jump	@
.LCB1502:
@ C_Code.c:635: 		damage = round->hpChange - damage; 
	mov	r3, r10	@ _11, _11
	subs	r0, r3, r1	@ damage, _11, damage
@ C_Code.c:637: 		if (UsingSkillSys) { // uggggh 
	ldr	r3, .L263+12	@ tmp259,
	ldr	r2, [r3]	@ UsingSkillSys.23_50, UsingSkillSys
@ C_Code.c:646: 		opp_bunit->unit.curHP += damage; 
	mov	r3, r8	@ opp_bunit, opp_bunit
@ C_Code.c:647: 		round->hpChange -= damage; 
	mov	r5, r10	@ _11, _11
@ C_Code.c:646: 		opp_bunit->unit.curHP += damage; 
	ldrb	r3, [r3, #19]	@ tmp262,
	lsls	r4, r0, #24	@ tmp260, damage,
	lsrs	r4, r4, #24	@ _222, tmp260,
	adds	r3, r4, r3	@ tmp263, _222, tmp262
	lsls	r3, r3, #24	@ tmp264, tmp263,
@ C_Code.c:647: 		round->hpChange -= damage; 
	subs	r4, r5, r4	@ tmp266, _11, _222
@ C_Code.c:646: 		opp_bunit->unit.curHP += damage; 
	asrs	r3, r3, #24	@ _226, tmp264,
@ C_Code.c:647: 		round->hpChange -= damage; 
	lsls	r4, r4, #24	@ tmp267, tmp266,
@ C_Code.c:646: 		opp_bunit->unit.curHP += damage; 
	str	r3, [sp, #12]	@ _226, %sfp
@ C_Code.c:636: 		hp += damage; 
	adds	r6, r6, r0	@ hp, tmp222, damage
@ C_Code.c:647: 		round->hpChange -= damage; 
	asrs	r4, r4, #24	@ _229, tmp267,
@ C_Code.c:637: 		if (UsingSkillSys) { // uggggh 
	cmp	r2, #0	@ UsingSkillSys.23_50,
	beq	.L241		@,
@ C_Code.c:638: 			HpProc->post += damage;
	lsls	r0, r0, #16	@ tmp268, damage,
	lsrs	r5, r0, #16	@ _53, tmp268,
@ C_Code.c:638: 			HpProc->post += damage;
	movs	r0, #80	@ tmp269,
@ C_Code.c:638: 			HpProc->post += damage;
	mov	ip, r5	@ _53, _53
@ C_Code.c:638: 			HpProc->post += damage;
	movs	r3, r0	@ tmp269, tmp269
@ C_Code.c:638: 			HpProc->post += damage;
	ldrh	r0, [r7, r0]	@ tmp271,
	add	r0, r0, ip	@ tmp272, _53
	strh	r0, [r7, r3]	@ tmp272, HpProc_21(D)->post
@ C_Code.c:646: 		opp_bunit->unit.curHP += damage; 
	mov	r0, r8	@ opp_bunit, opp_bunit
	ldr	r3, [sp, #12]	@ _226, %sfp
	strb	r3, [r0, #19]	@ _226, opp_bunit_34(D)->unit.curHP
@ C_Code.c:647: 		round->hpChange -= damage; 
	ldr	r3, [sp, #56]	@ tmp391, round
	strb	r4, [r3, #3]	@ _229, round_10(D)->hpChange
@ C_Code.c:648: 		if (UsingSkillSys == 2) { round->overDmg += damage; } // used by Huichelaar's banim numbers 
	cmp	r2, #2	@ UsingSkillSys.23_50,
	bne	.L243		@,
@ C_Code.c:648: 		if (UsingSkillSys == 2) { round->overDmg += damage; } // used by Huichelaar's banim numbers 
	ldr	r3, [sp, #56]	@ tmp395, round
	ldrh	r3, [r3, #6]	@ tmp286,
	ldr	r2, [sp, #56]	@ tmp398, round
	add	r3, r3, ip	@ tmp287, _53
	strh	r3, [r2, #6]	@ tmp287, round_10(D)->overDmg
	b	.L243		@
.L258:
@ C_Code.c:617: 		if (hp < 0) { damage -= ABS(hp); } 
	mov	r3, r10	@ _11, _11
@ C_Code.c:614: 		hp -= damage;
	subs	r0, r6, r1	@ hp, tmp222, damage
@ C_Code.c:615: 		damage -= round->hpChange; 
	subs	r1, r1, r3	@ damage, damage, _11
@ C_Code.c:617: 		if (hp < 0) { damage -= ABS(hp); } 
	cmp	r0, #0	@ hp,
	blt	.L259		@,
.L234:
@ C_Code.c:621: 		if (UsingSkillSys) { // uggggh 
	ldr	r3, .L263+12	@ tmp229,
	ldr	r2, [r3]	@ UsingSkillSys.21_20, UsingSkillSys
@ C_Code.c:630: 		opp_bunit->unit.curHP -= damage; 
	mov	r3, r8	@ opp_bunit, opp_bunit
@ C_Code.c:691: 	if (hp < 0) { hp = 0; } 
	mvns	r6, r0	@ tmp341, hp
@ C_Code.c:630: 		opp_bunit->unit.curHP -= damage; 
	ldrb	r3, [r3, #19]	@ tmp232,
	lsls	r4, r1, #24	@ tmp230, damage,
	lsrs	r4, r4, #24	@ _213, tmp230,
	subs	r3, r3, r4	@ tmp233, tmp232, _213
@ C_Code.c:631: 		round->hpChange += damage; 
	add	r4, r4, r10	@ tmp236, _11
@ C_Code.c:630: 		opp_bunit->unit.curHP -= damage; 
	lsls	r3, r3, #24	@ tmp234, tmp233,
@ C_Code.c:631: 		round->hpChange += damage; 
	lsls	r4, r4, #24	@ tmp237, tmp236,
@ C_Code.c:691: 	if (hp < 0) { hp = 0; } 
	asrs	r6, r6, #31	@ tmp340, tmp341,
@ C_Code.c:630: 		opp_bunit->unit.curHP -= damage; 
	asrs	r3, r3, #24	@ _217, tmp234,
@ C_Code.c:631: 		round->hpChange += damage; 
	asrs	r4, r4, #24	@ _220, tmp237,
@ C_Code.c:691: 	if (hp < 0) { hp = 0; } 
	ands	r6, r0	@ prephitmp_210, hp
@ C_Code.c:621: 		if (UsingSkillSys) { // uggggh 
	cmp	r2, #0	@ UsingSkillSys.21_20,
	bne	.L260		@,
@ C_Code.c:625: 			post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	movs	r0, #82	@ tmp247,
@ C_Code.c:625: 			post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	ldrsh	r2, [r7, r0]	@ post,
@ C_Code.c:626: 			post -= damage; 
	subs	r2, r2, r1	@ post, post, damage
@ C_Code.c:627: 			HpProc->postHpAtkrSS = post; 
	strh	r2, [r7, r0]	@ post, HpProc_21(D)->postHpAtkrSS
@ C_Code.c:628: 			HpProc->post = post>>16; 
	asrs	r2, r2, #16	@ tmp250, post,
@ C_Code.c:628: 			HpProc->post = post>>16; 
	subs	r0, r0, #2	@ tmp251,
	strh	r2, [r7, r0]	@ tmp250, HpProc_21(D)->post
@ C_Code.c:630: 		opp_bunit->unit.curHP -= damage; 
	mov	r2, r8	@ opp_bunit, opp_bunit
	strb	r3, [r2, #19]	@ _217, opp_bunit_34(D)->unit.curHP
@ C_Code.c:631: 		round->hpChange += damage; 
	ldr	r3, [sp, #56]	@ tmp378, round
	strb	r4, [r3, #3]	@ _220, round_10(D)->hpChange
.L239:
@ C_Code.c:690: 	AdjustAllRounds(id, damage, round->hpChange);
	movs	r2, r4	@, _197
	ldr	r0, [sp, #8]	@, %sfp
	bl	AdjustAllRounds		@
@ C_Code.c:692: 	CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp); 
	ldr	r3, [sp, #56]	@ tmp415, round
	mov	r2, fp	@, active_bunit
	str	r3, [sp]	@ tmp415,
	movs	r1, r7	@, HpProc
	mov	r3, r8	@, opp_bunit
	mov	r0, r9	@, proc
	str	r6, [sp, #4]	@ prephitmp_210,
	bl	CheckForDeath		@
.L229:
@ C_Code.c:707: } 
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
.L260:
@ C_Code.c:622: 			HpProc->post -= damage;
	movs	r5, #80	@ tmp239,
@ C_Code.c:622: 			HpProc->post -= damage;
	lsls	r0, r1, #16	@ tmp238, damage,
	lsrs	r0, r0, #16	@ _25, tmp238,
	str	r0, [sp, #12]	@ _25, %sfp
@ C_Code.c:622: 			HpProc->post -= damage;
	mov	r10, r5	@ tmp239, tmp239
@ C_Code.c:622: 			HpProc->post -= damage;
	ldrh	r5, [r7, r5]	@ tmp241,
	subs	r5, r5, r0	@ tmp242, tmp241, _25
	mov	ip, r5	@ tmp242, tmp242
	mov	r5, r10	@ tmp239, tmp239
	mov	r0, ip	@ tmp242, tmp242
	strh	r0, [r7, r5]	@ tmp242, HpProc_21(D)->post
@ C_Code.c:630: 		opp_bunit->unit.curHP -= damage; 
	mov	r0, r8	@ opp_bunit, opp_bunit
	strb	r3, [r0, #19]	@ _217, opp_bunit_34(D)->unit.curHP
@ C_Code.c:631: 		round->hpChange += damage; 
	ldr	r3, [sp, #56]	@ tmp376, round
	strb	r4, [r3, #3]	@ _220, round_10(D)->hpChange
@ C_Code.c:632: 		if (UsingSkillSys == 2) { round->overDmg -= damage; } // used by Huichelaar's banim numbers 
	cmp	r2, #2	@ UsingSkillSys.21_20,
	bne	.L239		@,
@ C_Code.c:632: 		if (UsingSkillSys == 2) { round->overDmg -= damage; } // used by Huichelaar's banim numbers 
	ldr	r3, [sp, #56]	@ tmp379, round
	ldr	r2, [sp, #12]	@ _25, %sfp
	ldrh	r3, [r3, #6]	@ tmp256,
	subs	r3, r3, r2	@ tmp257, tmp256, _25
	ldr	r2, [sp, #56]	@ tmp380, round
	strh	r3, [r2, #6]	@ tmp257, round_10(D)->overDmg
	b	.L239		@
.L259:
@ C_Code.c:617: 		if (hp < 0) { damage -= ABS(hp); } 
	subs	r1, r6, r3	@ damage, tmp222, _11
	b	.L234		@
.L241:
@ C_Code.c:641: 			post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	movs	r2, #82	@ tmp277,
@ C_Code.c:641: 			post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	ldrsh	r5, [r7, r2]	@ post,
	mov	ip, r5	@ post, post
@ C_Code.c:642: 			post += damage; 
	add	r0, r0, ip	@ post, post
@ C_Code.c:643: 			HpProc->postHpAtkrSS = post; 
	strh	r0, [r7, r2]	@ post, HpProc_21(D)->postHpAtkrSS
@ C_Code.c:644: 			HpProc->post = post>>16; 
	subs	r2, r2, #2	@ tmp281,
@ C_Code.c:644: 			HpProc->post = post>>16; 
	asrs	r0, r0, #16	@ tmp280, post,
@ C_Code.c:644: 			HpProc->post = post>>16; 
	strh	r0, [r7, r2]	@ tmp280, HpProc_21(D)->post
@ C_Code.c:646: 		opp_bunit->unit.curHP += damage; 
	mov	r2, r8	@ opp_bunit, opp_bunit
	ldr	r3, [sp, #12]	@ _226, %sfp
	strb	r3, [r2, #19]	@ _226, opp_bunit_34(D)->unit.curHP
@ C_Code.c:647: 		round->hpChange -= damage; 
	ldr	r3, [sp, #56]	@ tmp394, round
	strb	r4, [r3, #3]	@ _229, round_10(D)->hpChange
.L243:
@ C_Code.c:649: 		damage = 0 - damage;
	mov	r3, r10	@ _11, _11
	subs	r1, r1, r3	@ damage, damage, _11
@ C_Code.c:691: 	if (hp < 0) { hp = 0; } 
	mvns	r3, r6	@ tmp343, hp
	asrs	r3, r3, #31	@ tmp342, tmp343,
	ands	r6, r3	@ prephitmp_210, tmp342
	b	.L239		@
.L240:
@ C_Code.c:653: 		if ((hp == 1)) { // deal lethal anyway 
	cmp	r6, #1	@ tmp222,
	beq	.L261		@,
@ C_Code.c:671: 		else if (BlockingCanPreventLethal) { // leave alive with 1 hp 
	ldr	r3, .L263+16	@ tmp307,
@ C_Code.c:671: 		else if (BlockingCanPreventLethal) { // leave alive with 1 hp 
	ldr	r3, [r3]	@ BlockingCanPreventLethal, BlockingCanPreventLethal
	cmp	r3, #0	@ BlockingCanPreventLethal,
	beq	.L262		@,
@ C_Code.c:674: 			if (UsingSkillSys) { // uggggh 
	ldr	r3, .L263+12	@ tmp309,
	ldr	r2, [r3]	@ UsingSkillSys.28_85, UsingSkillSys
@ C_Code.c:684: 			opp_bunit->unit.curHP += 1; 
	mov	r3, r8	@ opp_bunit, opp_bunit
@ C_Code.c:685: 			round->hpChange -= 1; 
	mov	r1, r10	@ _11, _11
@ C_Code.c:684: 			opp_bunit->unit.curHP += 1; 
	ldrb	r3, [r3, #19]	@ tmp311,
@ C_Code.c:685: 			round->hpChange -= 1; 
	subs	r4, r1, #1	@ tmp315, _11,
@ C_Code.c:684: 			opp_bunit->unit.curHP += 1; 
	adds	r3, r3, #1	@ tmp312,
	lsls	r3, r3, #24	@ tmp313, tmp312,
@ C_Code.c:685: 			round->hpChange -= 1; 
	lsls	r4, r4, #24	@ tmp316, tmp315,
@ C_Code.c:684: 			opp_bunit->unit.curHP += 1; 
	asrs	r3, r3, #24	@ _237, tmp313,
@ C_Code.c:685: 			round->hpChange -= 1; 
	asrs	r4, r4, #24	@ _240, tmp316,
@ C_Code.c:674: 			if (UsingSkillSys) { // uggggh 
	cmp	r2, #0	@ UsingSkillSys.28_85,
	beq	.L251		@,
@ C_Code.c:675: 				HpProc->post += 1;
	movs	r0, #80	@ tmp317,
@ C_Code.c:683: 			HpProc->post += 1;
	ldrh	r1, [r7, r0]	@ tmp319,
	adds	r1, r1, #2	@ tmp320,
	strh	r1, [r7, r0]	@ tmp320, HpProc_21(D)->post
@ C_Code.c:684: 			opp_bunit->unit.curHP += 1; 
	mov	r1, r8	@ opp_bunit, opp_bunit
	strb	r3, [r1, #19]	@ _237, opp_bunit_34(D)->unit.curHP
@ C_Code.c:685: 			round->hpChange -= 1; 
	ldr	r3, [sp, #56]	@ tmp409, round
	strb	r4, [r3, #3]	@ _240, round_10(D)->hpChange
@ C_Code.c:686: 			if (UsingSkillSys == 2) { round->overDmg += 1; } 
	cmp	r2, #2	@ UsingSkillSys.28_85,
	bne	.L253		@,
@ C_Code.c:686: 			if (UsingSkillSys == 2) { round->overDmg += 1; } 
	ldr	r3, [sp, #56]	@ tmp412, round
	ldrh	r3, [r3, #6]	@ tmp336,
	ldr	r2, [sp, #56]	@ tmp413, round
	adds	r3, r3, #1	@ tmp337,
	strh	r3, [r2, #6]	@ tmp337, round_10(D)->overDmg
.L253:
@ C_Code.c:687: 			damage = 0 - damage;
	movs	r1, #1	@ tmp339,
	mov	r3, r10	@ _11, _11
@ C_Code.c:690: 	AdjustAllRounds(id, damage, round->hpChange);
	movs	r6, #1	@ prephitmp_210,
@ C_Code.c:687: 			damage = 0 - damage;
	subs	r1, r1, r3	@ damage, tmp339, _11
	b	.L239		@
.L262:
@ C_Code.c:691: 	if (hp < 0) { hp = 0; } 
	mvns	r3, r6	@ tmp345, tmp222
	asrs	r3, r3, #31	@ tmp344, tmp345,
	ands	r6, r3	@ prephitmp_210, tmp344
	b	.L239		@
.L261:
@ C_Code.c:656: 			if (UsingSkillSys) { // uggggh 
	ldr	r3, .L263+12	@ tmp289,
	ldr	r6, [r3]	@ prephitmp_210, UsingSkillSys
@ C_Code.c:666: 			round->hpChange += damage; 
	movs	r3, #2	@ _233,
@ C_Code.c:656: 			if (UsingSkillSys) { // uggggh 
	cmp	r6, #0	@ prephitmp_210,
	beq	.L246		@,
@ C_Code.c:657: 				HpProc->post = 0;
	movs	r2, #80	@ tmp293,
	movs	r1, #0	@ tmp294,
	strh	r1, [r7, r2]	@ tmp294, HpProc_21(D)->post
@ C_Code.c:665: 			opp_bunit->unit.curHP = 0; 
	movs	r2, #0	@ tmp295,
	mov	r1, r8	@ opp_bunit, opp_bunit
	strb	r2, [r1, #19]	@ tmp295, opp_bunit_34(D)->unit.curHP
@ C_Code.c:666: 			round->hpChange += damage; 
	ldr	r2, [sp, #56]	@ tmp401, round
@ C_Code.c:690: 	AdjustAllRounds(id, damage, round->hpChange);
	movs	r4, #2	@ _197,
@ C_Code.c:666: 			round->hpChange += damage; 
	strb	r3, [r2, #3]	@ _233, round_10(D)->hpChange
@ C_Code.c:667: 			if (UsingSkillSys == 2) { round->overDmg -= damage; } 
	cmp	r6, #2	@ prephitmp_210,
	bne	.L248		@,
@ C_Code.c:667: 			if (UsingSkillSys == 2) { round->overDmg -= damage; } 
	ldr	r3, [sp, #56]	@ tmp404, round
	ldrh	r3, [r3, #6]	@ tmp304,
	ldr	r2, [sp, #56]	@ tmp405, round
	subs	r3, r3, #1	@ tmp305,
	strh	r3, [r2, #6]	@ tmp305, round_10(D)->overDmg
.L248:
@ C_Code.c:668: 			damage = 0 - damage;
	movs	r1, #1	@ damage,
@ C_Code.c:611: 	if (!damage) { damage = 1; } 
	movs	r6, #0	@ prephitmp_210,
@ C_Code.c:668: 			damage = 0 - damage;
	rsbs	r1, r1, #0	@ damage, damage
	b	.L239		@
.L246:
@ C_Code.c:665: 			opp_bunit->unit.curHP = 0; 
	mov	r2, r8	@ opp_bunit, opp_bunit
@ C_Code.c:668: 			damage = 0 - damage;
	movs	r1, #1	@ damage,
@ C_Code.c:663: 				HpProc->post = post>>16; 
	str	r6, [r7, #80]	@ prephitmp_210, MEM <vector(2) short int> [(short int *)HpProc_21(D) + 80B]
@ C_Code.c:665: 			opp_bunit->unit.curHP = 0; 
	strb	r6, [r2, #19]	@ prephitmp_210, opp_bunit_34(D)->unit.curHP
@ C_Code.c:666: 			round->hpChange += damage; 
	ldr	r2, [sp, #56]	@ tmp403, round
@ C_Code.c:690: 	AdjustAllRounds(id, damage, round->hpChange);
	movs	r4, #2	@ _197,
@ C_Code.c:666: 			round->hpChange += damage; 
	strb	r3, [r2, #3]	@ _233, round_10(D)->hpChange
@ C_Code.c:668: 			damage = 0 - damage;
	rsbs	r1, r1, #0	@ damage, damage
	b	.L239		@
.L251:
@ C_Code.c:678: 				post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	movs	r1, #82	@ tmp325,
@ C_Code.c:678: 				post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	ldrsh	r2, [r7, r1]	@ post,
@ C_Code.c:679: 				post += 1; 
	adds	r2, r2, #1	@ post,
@ C_Code.c:680: 				HpProc->postHpAtkrSS = post; 
	strh	r2, [r7, r1]	@ post, HpProc_21(D)->postHpAtkrSS
@ C_Code.c:681: 				HpProc->post = post>>16; 
	asrs	r2, r2, #16	@ tmp328, post,
@ C_Code.c:683: 			HpProc->post += 1;
	adds	r2, r2, #1	@ tmp330,
	subs	r1, r1, #2	@ tmp331,
	strh	r2, [r7, r1]	@ tmp330, HpProc_21(D)->post
@ C_Code.c:684: 			opp_bunit->unit.curHP += 1; 
	mov	r2, r8	@ opp_bunit, opp_bunit
	strb	r3, [r2, #19]	@ _237, opp_bunit_34(D)->unit.curHP
@ C_Code.c:685: 			round->hpChange -= 1; 
	ldr	r3, [sp, #56]	@ tmp411, round
	strb	r4, [r3, #3]	@ _240, round_10(D)->hpChange
	b	.L253		@
.L264:
	.align	2
.L263:
	.word	gEfxHpLutOff
	.word	GetEfxHp
	.word	__aeabi_idiv
	.word	UsingSkillSys
	.word	BlockingCanPreventLethal
	.size	AdjustDamageByPercent.part.0, .-AdjustDamageByPercent.part.0
	.align	1
	.p2align 2,,3
	.global	AdjustDamageWithGetter
	.syntax unified
	.code	16
	.thumb_func
	.type	AdjustDamageWithGetter, %function
AdjustDamageWithGetter:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:506: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r5, #11	@ tmp129,
	movs	r4, #192	@ tmp130,
	ldrsb	r5, [r2, r5]	@ tmp129,
@ C_Code.c:546: void AdjustDamageWithGetter(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int success) { 
	sub	sp, sp, #8	@,,
@ C_Code.c:506: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	ands	r4, r5	@ _29, tmp129
@ C_Code.c:505: 	if (success) { 
	ldr	r5, [sp, #28]	@ tmp149, success
	cmp	r5, #0	@ tmp149,
	beq	.L266		@,
@ C_Code.c:506: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _29,
	beq	.L283		@,
@ C_Code.c:510: 		return BonusDamagePercent; 
	ldr	r4, .L285	@ tmp134,
	ldr	r4, [r4]	@ _19,
.L269:
@ C_Code.c:548: 	if (percent != 100) { 
	cmp	r4, #100	@ _19,
	beq	.L265		@,
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r6, [r0, #60]	@ _24, proc_7(D)->currentRound
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r5, [r6]	@ *_24, *_24
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsls	r5, r5, #30	@ tmp147, *_24,
	bmi	.L265		@,
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	movs	r5, #3	@ tmp142,
	ldrsb	r5, [r6, r5]	@ tmp142,
	cmp	r5, #0	@ tmp142,
	bne	.L284		@,
.L265:
@ C_Code.c:551: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L283:
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L285+4	@ tmp131,
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, [r4]	@ BlockingEnabled, BlockingEnabled
	cmp	r4, #0	@ BlockingEnabled,
	beq	.L265		@,
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L285+8	@ tmp133,
	ldr	r4, [r4]	@ _19,
@ C_Code.c:507: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L269		@
.L266:
@ C_Code.c:512: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _29,
	beq	.L265		@,
@ C_Code.c:515: 	return FailedHitDamagePercent; 
	ldr	r4, .L285+12	@ tmp135,
	ldr	r4, [r4]	@ _19,
	b	.L269		@
.L284:
	str	r4, [sp, #4]	@ _19,
	ldr	r4, [sp, #24]	@ tmp150, round
	str	r4, [sp]	@ tmp150,
	bl	AdjustDamageByPercent.part.0		@
@ C_Code.c:551: } 
	b	.L265		@
.L286:
	.align	2
.L285:
	.word	BonusDamagePercent
	.word	BlockingEnabled
	.word	ReducedDamagePercent
	.word	FailedHitDamagePercent
	.size	AdjustDamageWithGetter, .-AdjustDamageWithGetter
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	DoStuffIfHit.part.0, %function
DoStuffIfHit.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r7, r9	@,
	mov	r6, r8	@,
	mov	lr, r10	@,
	push	{r6, r7, lr}	@
@ C_Code.c:431: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldr	r3, .L317	@ tmp162,
@ C_Code.c:431: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldrh	r5, [r3, #8]	@ tmp165,
	ldrh	r3, [r3, #4]	@ tmp167,
@ C_Code.c:431: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	orrs	r5, r3	@ keys, tmp167
@ C_Code.c:435: 	int x = proc->anim2->xPosition; 
	ldr	r3, [r0, #48]	@ proc_5(D)->anim2, proc_5(D)->anim2
@ C_Code.c:429: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r7, r2	@ round, tmp253
@ C_Code.c:435: 	int x = proc->anim2->xPosition; 
	movs	r2, #2	@ tmp262,
	ldrsh	r3, [r3, r2]	@ x, proc_5(D)->anim2, tmp262
	mov	r8, r3	@ x, x
@ C_Code.c:436: 	struct BattleUnit* active_bunit = proc->active_bunit; 
	ldr	r3, [r0, #64]	@ active_bunit, proc_5(D)->active_bunit
	mov	r9, r3	@ active_bunit, active_bunit
@ C_Code.c:437: 	struct BattleUnit* opp_bunit = proc->opp_bunit; 
	ldr	r3, [r0, #68]	@ opp_bunit, proc_5(D)->opp_bunit
	mov	r10, r3	@ opp_bunit, opp_bunit
@ C_Code.c:438: 	int hitTime = !proc->EkrEfxIsUnitHittedNowFrames; 
	movs	r3, #82	@ tmp171,
@ C_Code.c:439: 	if (hitTime) { // 1 frame 
	ldrb	r3, [r0, r3]	@ tmp172,
@ C_Code.c:429: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r4, r0	@ proc, tmp251
	movs	r6, r1	@ HpProc, tmp252
	sub	sp, sp, #8	@,,
@ C_Code.c:439: 	if (hitTime) { // 1 frame 
	cmp	r3, #0	@ tmp172,
	bne	.L289		@,
@ C_Code.c:441: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	ldr	r2, [r0, #56]	@ proc_5(D)->timer2, proc_5(D)->timer2
	cmp	r2, #255	@ proc_5(D)->timer2,
	bne	.LCB1899	@
	b	.L314	@long jump	@
.LCB1899:
.L290:
@ C_Code.c:442: 		SaveInputFrame(proc, keys); 
	movs	r1, r5	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
@ C_Code.c:443: 		SaveIfWeHitOnTime(proc);
	movs	r0, r4	@, proc
	bl	SaveIfWeHitOnTime		@
@ C_Code.c:444: 		if (!proc->adjustedDmg) { 
	movs	r3, #74	@ tmp175,
@ C_Code.c:444: 		if (!proc->adjustedDmg) { 
	ldrb	r2, [r4, r3]	@ tmp176,
	cmp	r2, #0	@ tmp176,
	bne	.L289		@,
@ C_Code.c:379: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r2, .L317+4	@ tmp177,
@ C_Code.c:383: 	if (CheatCodeOn()) { return true; } 
	ldrb	r2, [r2, #31]	@ tmp180,
	cmp	r2, #127	@ tmp180,
	bhi	.L292		@,
@ C_Code.c:384: 	if (AlwaysWork) { return true; } 
	ldr	r2, .L317+8	@ tmp181,
@ C_Code.c:384: 	if (AlwaysWork) { return true; } 
	ldr	r2, [r2]	@ AlwaysWork, AlwaysWork
	cmp	r2, #0	@ AlwaysWork,
	bne	.L292		@,
@ C_Code.c:385: 	return proc->hitOnTime;
	adds	r2, r2, #72	@ tmp183,
@ C_Code.c:445: 			if (DidWeHitOnTime(proc)) { 
	ldrb	r2, [r4, r2]	@ tmp184,
	cmp	r2, #0	@ tmp184,
	bne	.L292		@,
@ C_Code.c:451: 				proc->adjustedDmg = true; 
	movs	r2, #1	@ tmp195,
	strb	r2, [r4, r3]	@ tmp195, proc_5(D)->adjustedDmg
@ C_Code.c:512: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	mov	r3, r9	@ active_bunit, active_bunit
	movs	r2, #11	@ tmp197,
	ldrsb	r2, [r3, r2]	@ tmp197,
	movs	r3, #192	@ tmp198,
	ands	r3, r2	@ tmp199, tmp197
@ C_Code.c:512: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ tmp199,
	beq	.L295		@,
@ C_Code.c:515: 	return FailedHitDamagePercent; 
	ldr	r3, .L317+12	@ tmp200,
	ldr	r3, [r3]	@ _78, FailedHitDamagePercent
@ C_Code.c:548: 	if (percent != 100) { 
	cmp	r3, #100	@ _78,
	beq	.L295		@,
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r1, [r4, #60]	@ _83, proc_5(D)->currentRound
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r2, [r1]	@ *_83, *_83
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsls	r2, r2, #30	@ tmp259, *_83,
	bmi	.L295		@,
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	movs	r2, #3	@ tmp207,
	ldrsb	r2, [r1, r2]	@ tmp207,
	cmp	r2, #0	@ tmp207,
	beq	.L295		@,
	str	r3, [sp, #4]	@ _78,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	movs	r1, r6	@, HpProc
	movs	r0, r4	@, proc
	str	r7, [sp]	@ round,
	bl	AdjustDamageByPercent.part.0		@
	b	.L295		@
.L292:
@ C_Code.c:240: 	if (proc->broke) { return; } 
	movs	r3, #75	@ tmp185,
@ C_Code.c:240: 	if (proc->broke) { return; } 
	ldrb	r2, [r4, r3]	@ tmp186,
	cmp	r2, #0	@ tmp186,
	bne	.L294		@,
@ C_Code.c:241: 	proc->broke = true; 
	adds	r2, r2, #1	@ tmp188,
	strb	r2, [r4, r3]	@ tmp188, proc_5(D)->broke
@ C_Code.c:242: 	asm("mov r11, r11");
	.syntax divided
@ 242 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L294:
@ C_Code.c:447: 				proc->adjustedDmg = true; 
	movs	r3, #1	@ tmp191,
	movs	r2, #74	@ tmp190,
@ C_Code.c:448: 				AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true); 
	movs	r1, r6	@, HpProc
@ C_Code.c:447: 				proc->adjustedDmg = true; 
	strb	r3, [r4, r2]	@ tmp191, proc_5(D)->adjustedDmg
@ C_Code.c:448: 				AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true); 
	movs	r0, r4	@, proc
	str	r3, [sp, #4]	@ tmp191,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	str	r7, [sp]	@ round,
	bl	AdjustDamageWithGetter		@
.L295:
@ C_Code.c:457: 			CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, (-1)); 
	movs	r3, #1	@ tmp208,
	rsbs	r3, r3, #0	@ tmp208, tmp208
	str	r3, [sp, #4]	@ tmp208,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	movs	r1, r6	@, HpProc
	movs	r0, r4	@, proc
	str	r7, [sp]	@ round,
	bl	CheckForDeath		@
.L289:
@ C_Code.c:462: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	movs	r3, #77	@ tmp209,
@ C_Code.c:462: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r0, [r4, r3]	@ tmp210,
	ldr	r3, .L317+16	@ tmp211,
	bl	.L27		@
@ C_Code.c:462: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	cmp	r0, #0	@ tmp212,
	bne	.L296		@,
@ C_Code.c:462: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	movs	r3, #79	@ tmp214,
@ C_Code.c:462: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r3, [r4, r3]	@ tmp215,
	cmp	r3, #255	@ tmp215,
	beq	.L315		@,
.L296:
@ C_Code.c:379: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L317+4	@ tmp218,
@ C_Code.c:383: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp221,
@ C_Code.c:482: 		else if (proc->timer2 < 20) { 
	ldr	r5, [r4, #56]	@ pretmp_97, proc_5(D)->timer2
@ C_Code.c:383: 	if (CheatCodeOn()) { return true; } 
	cmp	r3, #127	@ tmp221,
	bhi	.L298		@,
@ C_Code.c:384: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L317+8	@ tmp222,
@ C_Code.c:384: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L298		@,
@ C_Code.c:385: 	return proc->hitOnTime;
	adds	r3, r3, #72	@ tmp224,
@ C_Code.c:465: 		if (DidWeHitOnTime(proc)) { 
	ldrb	r3, [r4, r3]	@ tmp225,
	cmp	r3, #0	@ tmp225,
	bne	.L298		@,
@ C_Code.c:482: 		else if (proc->timer2 < 20) { 
	cmp	r5, #19	@ pretmp_97,
	ble	.L316		@,
.L300:
@ C_Code.c:485: 		proc->roundEnd = true; 
	movs	r3, #81	@ tmp241,
	movs	r2, #1	@ tmp242,
	strb	r2, [r4, r3]	@ tmp242, proc_5(D)->roundEnd
.L287:
@ C_Code.c:501: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L298:
@ C_Code.c:477: 			if (((y > (-16)) && (y < (161)))) { 
	movs	r3, #63	@ tmp226,
	subs	r3, r3, r5	@ tmp227, tmp226, pretmp_97
@ C_Code.c:477: 			if (((y > (-16)) && (y < (161)))) { 
	cmp	r3, #175	@ tmp227,
	bhi	.L300		@,
@ C_Code.c:472: 			x += Mod(clock, 8) >> 1; 
	movs	r1, #8	@,
	movs	r0, r5	@, pretmp_97
	ldr	r3, .L317+20	@ tmp228,
	bl	.L27		@
@ C_Code.c:474: 			y -= clock; 
	movs	r1, #48	@ tmp231,
@ C_Code.c:478: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	movs	r2, #255	@ tmp233,
@ C_Code.c:474: 			y -= clock; 
	subs	r1, r1, r5	@ y, tmp231, pretmp_97
@ C_Code.c:478: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	ands	r2, r1	@ tmp234, y
@ C_Code.c:472: 			x += Mod(clock, 8) >> 1; 
	asrs	r1, r0, #1	@ tmp235, tmp255,
@ C_Code.c:478: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	movs	r0, #224	@ tmp239,
@ C_Code.c:472: 			x += Mod(clock, 8) >> 1; 
	add	r1, r1, r8	@ x, x
@ C_Code.c:478: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	lsls	r0, r0, #8	@ tmp239, tmp239,
	lsls	r1, r1, #23	@ tmp238, x,
	str	r0, [sp]	@ tmp239,
	ldr	r3, .L317+24	@ tmp230,
	movs	r0, #0	@,
	ldr	r5, .L317+28	@ tmp240,
	lsrs	r1, r1, #23	@ tmp237, tmp238,
	bl	.L44		@
	b	.L300		@
.L314:
@ C_Code.c:441: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	str	r3, [r0, #56]	@ tmp172, proc_5(D)->timer2
	b	.L290		@
.L315:
@ C_Code.c:462: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	subs	r3, r3, #175	@ tmp216,
@ C_Code.c:462: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r3, [r4, r3]	@ tmp217,
	cmp	r3, #255	@ tmp217,
	bne	.L296		@,
@ C_Code.c:489: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	ldr	r3, [r4, #52]	@ proc_5(D)->timer, proc_5(D)->timer
	cmp	r3, #0	@ proc_5(D)->timer,
	bgt	.L302		@,
@ C_Code.c:489: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	movs	r3, #78	@ tmp245,
	strb	r0, [r4, r3]	@ tmp212, proc_5(D)->frame
.L303:
@ C_Code.c:494: 		if (!proc->roundEnd) { 
	movs	r3, #81	@ tmp248,
@ C_Code.c:494: 		if (!proc->roundEnd) { 
	ldrb	r3, [r4, r3]	@ tmp249,
	cmp	r3, #0	@ tmp249,
	bne	.L287		@,
@ C_Code.c:495: 			DrawButtonsToPress(proc, x, y, 15); 
	movs	r2, #24	@,
	mov	r1, r8	@, x
	movs	r0, r4	@, proc
	adds	r3, r3, #15	@,
	bl	DrawButtonsToPress		@
	b	.L287		@
.L316:
@ C_Code.c:483: 			DrawButtonsToPress(proc, x, y, 14); 
	movs	r3, #14	@,
	movs	r2, #24	@,
	mov	r1, r8	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress		@
	b	.L300		@
.L302:
@ C_Code.c:492: 			SaveInputFrame(proc, keys); 
	movs	r1, r5	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
	b	.L303		@
.L318:
	.align	2
.L317:
	.word	sKeyStatusBuffer
	.word	gPlaySt
	.word	AlwaysWork
	.word	FailedHitDamagePercent
	.word	EkrEfxIsUnitHittedNow
	.word	Mod
	.word	.LANCHOR0+104
	.word	PutSprite
	.size	DoStuffIfHit.part.0, .-DoStuffIfHit.part.0
	.align	1
	.p2align 2,,3
	.global	DoStuffIfHit
	.syntax unified
	.code	16
	.thumb_func
	.type	DoStuffIfHit, %function
DoStuffIfHit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:429: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r6, r3	@ round, tmp127
@ C_Code.c:92: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L321	@ tmp120,
@ C_Code.c:429: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r4, r0	@ proc, tmp125
@ C_Code.c:92: 	return !CheckFlag(DisabledFlag); 
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L321+4	@ tmp122,
@ C_Code.c:429: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r5, r2	@ HpProc, tmp126
@ C_Code.c:92: 	return !CheckFlag(DisabledFlag); 
	bl	.L27		@
@ C_Code.c:430: 	if (!AreTimedHitsEnabled()) { return; } 
	cmp	r0, #0	@ tmp128,
	bne	.L319		@,
	movs	r2, r6	@, round
	movs	r1, r5	@, HpProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit.part.0		@
.L319:
@ C_Code.c:501: } 
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L322:
	.align	2
.L321:
	.word	DisabledFlag
	.word	CheckFlag
	.size	DoStuffIfHit, .-DoStuffIfHit
	.align	1
	.p2align 2,,3
	.global	LoopTimedHitsProc
	.syntax unified
	.code	16
	.thumb_func
	.type	LoopTimedHitsProc, %function
LoopTimedHitsProc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:254: 	if (!proc->anim) { return; } 
	ldr	r3, [r0, #44]	@ proc_25(D)->anim, proc_25(D)->anim
@ C_Code.c:253: void LoopTimedHitsProc(TimedHitsProc* proc) { 
	movs	r4, r0	@ proc, tmp181
	sub	sp, sp, #8	@,,
@ C_Code.c:254: 	if (!proc->anim) { return; } 
	cmp	r3, #0	@ proc_25(D)->anim,
	beq	.L323		@,
@ C_Code.c:256: 	struct ProcEkrBattle* battleProc = gpProcEkrBattle; 
	ldr	r3, .L346	@ tmp143,
@ C_Code.c:258: 	if (!battleProc) { return; } 
	ldr	r3, [r3]	@ gpProcEkrBattle, gpProcEkrBattle
	cmp	r3, #0	@ gpProcEkrBattle,
	beq	.L323		@,
@ C_Code.c:259: 	if (!proc->anim2) { return; } 
	ldr	r3, [r0, #48]	@ proc_25(D)->anim2, proc_25(D)->anim2
	cmp	r3, #0	@ proc_25(D)->anim2,
	beq	.L323		@,
@ C_Code.c:261: 	proc->timer++;
	ldr	r3, [r0, #52]	@ proc_25(D)->timer, proc_25(D)->timer
	adds	r3, r3, #1	@ tmp146,
	str	r3, [r0, #52]	@ tmp146, proc_25(D)->timer
@ C_Code.c:262: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	ldr	r3, [r0, #56]	@ _5, proc_25(D)->timer2
@ C_Code.c:262: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	cmp	r3, #255	@ _5,
	beq	.L327		@,
@ C_Code.c:262: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	adds	r3, r3, #1	@ tmp148,
	str	r3, [r0, #56]	@ tmp148, proc_25(D)->timer2
.L327:
@ C_Code.c:266: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	movs	r5, #82	@ tmp149,
	ldrb	r3, [r4, r5]	@ _7,
@ C_Code.c:264: 	struct SkillSysBattleHit* currentRound = proc->currentRound; 
	ldr	r6, [r4, #60]	@ currentRound, proc_25(D)->currentRound
@ C_Code.c:266: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	cmp	r3, #255	@ _7,
	beq	.L328		@,
@ C_Code.c:267: 		proc->EkrEfxIsUnitHittedNowFrames++; 
	adds	r3, r3, #1	@ tmp150,
	strb	r3, [r4, r5]	@ tmp150, proc_25(D)->EkrEfxIsUnitHittedNowFrames
.L329:
@ C_Code.c:272: 	struct NewProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	ldr	r3, .L346+4	@ tmp161,
	ldr	r0, [r3]	@ gProcScr_efxHPBar, gProcScr_efxHPBar
	ldr	r3, .L346+8	@ tmp163,
	bl	.L27		@
@ C_Code.c:92: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L346+12	@ tmp164,
@ C_Code.c:272: 	struct NewProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	movs	r5, r0	@ HpProc, tmp183
@ C_Code.c:92: 	return !CheckFlag(DisabledFlag); 
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L346+16	@ tmp166,
	bl	.L27		@
@ C_Code.c:430: 	if (!AreTimedHitsEnabled()) { return; } 
	cmp	r0, #0	@ tmp184,
	bne	.L330		@,
	movs	r2, r6	@, currentRound
	movs	r1, r5	@, HpProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit.part.0		@
.L330:
@ C_Code.c:247: 	if (!HpProc) { return false; } // 
	cmp	r5, #0	@ HpProc,
	beq	.L323		@,
@ C_Code.c:249: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #82	@ tmp169,
@ C_Code.c:249: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r3, [r4, r3]	@ tmp170,
	cmp	r3, #0	@ tmp170,
	bne	.L323		@,
@ C_Code.c:275: 		int x = BAN_DisplayDamage(proc->anim2, 0, 0, 0, proc->roundId); 
	movs	r6, #73	@ tmp172,
@ C_Code.c:275: 		int x = BAN_DisplayDamage(proc->anim2, 0, 0, 0, proc->roundId); 
	ldrb	r3, [r4, r6]	@ tmp173,
	movs	r1, #0	@,
	movs	r2, #0	@,
	ldr	r0, [r4, #48]	@ proc_25(D)->anim2, proc_25(D)->anim2
	ldr	r5, .L346+20	@ tmp174,
	str	r3, [sp]	@ tmp173,
	movs	r3, #0	@,
	bl	.L44		@
	movs	r3, r0	@ x, tmp185
@ C_Code.c:276: 		x = BAN_DisplayDamage(proc->anim, 1, proc->anim->xPosition, x, proc->roundId);  
	ldr	r0, [r4, #44]	@ _16, proc_25(D)->anim
	movs	r1, #2	@ tmp189,
	ldrsh	r2, [r0, r1]	@ tmp175, _16, tmp189
	ldrb	r1, [r4, r6]	@ tmp177,
	str	r1, [sp]	@ tmp177,
	movs	r1, #1	@,
	bl	.L44		@
.L323:
@ C_Code.c:279: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L328:
@ C_Code.c:269: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #77	@ tmp153,
@ C_Code.c:269: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	ldrb	r0, [r4, r3]	@ tmp154,
	ldr	r3, .L346+24	@ tmp155,
	bl	.L27		@
@ C_Code.c:269: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	cmp	r0, #0	@ tmp182,
	beq	.L329		@,
@ C_Code.c:269: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #0	@ tmp159,
	strb	r3, [r4, r5]	@ tmp159, proc_25(D)->EkrEfxIsUnitHittedNowFrames
	b	.L329		@
.L347:
	.align	2
.L346:
	.word	gpProcEkrBattle
	.word	gProcScr_efxHPBar
	.word	Proc_Find
	.word	DisabledFlag
	.word	CheckFlag
	.word	BAN_DisplayDamage
	.word	EkrEfxIsUnitHittedNow
	.size	LoopTimedHitsProc, .-LoopTimedHitsProc
	.align	1
	.p2align 2,,3
	.global	AdjustDamageByPercent
	.syntax unified
	.code	16
	.thumb_func
	.type	AdjustDamageByPercent, %function
AdjustDamageByPercent:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}	@
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r5, [r0, #60]	@ _1, proc_7(D)->currentRound
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r4, [r5]	@ *_1, *_1
@ C_Code.c:602: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	sub	sp, sp, #12	@,,
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsls	r4, r4, #30	@ tmp135, *_1,
	bmi	.L348		@,
@ C_Code.c:604: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	movs	r4, #3	@ tmp130,
	ldrsb	r4, [r5, r4]	@ tmp130,
	cmp	r4, #0	@ tmp130,
	bne	.L354		@,
.L348:
@ C_Code.c:707: } 
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L354:
	ldr	r4, [sp, #28]	@ tmp137, percent
	str	r4, [sp, #4]	@ tmp137,
	ldr	r4, [sp, #24]	@ tmp138, round
	str	r4, [sp]	@ tmp138,
	bl	AdjustDamageByPercent.part.0		@
	b	.L348		@
	.size	AdjustDamageByPercent, .-AdjustDamageByPercent
	.align	1
	.p2align 2,,3
	.global	GetBattleAnimPreconfType
	.syntax unified
	.code	16
	.thumb_func
	.type	GetBattleAnimPreconfType, %function
GetBattleAnimPreconfType:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:718: 	int result = gPlaySt.config.animationType; 
	movs	r2, #66	@ tmp130,
@ C_Code.c:717: int GetBattleAnimPreconfType(void) {
	push	{r4, lr}	@
@ C_Code.c:718: 	int result = gPlaySt.config.animationType; 
	ldr	r3, .L367	@ tmp164,
	ldrb	r0, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:719: 	if (!CheatCodeOn()) { 
	ldrb	r2, [r3, #31]	@ tmp139,
@ C_Code.c:718: 	int result = gPlaySt.config.animationType; 
	lsls	r0, r0, #29	@ tmp134, gPlaySt,
@ C_Code.c:718: 	int result = gPlaySt.config.animationType; 
	lsrs	r0, r0, #30	@ <retval>, tmp134,
@ C_Code.c:719: 	if (!CheatCodeOn()) { 
	cmp	r2, #127	@ tmp139,
	bhi	.L356		@,
@ C_Code.c:720: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, .L367+4	@ tmp140,
@ C_Code.c:720: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, [r2]	@ ForceAnimsOn, ForceAnimsOn
	cmp	r2, #0	@ ForceAnimsOn,
	beq	.L356		@,
@ C_Code.c:720: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	cmp	r0, #2	@ <retval>,
	beq	.L355		@,
.L359:
@ C_Code.c:720: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	movs	r0, #1	@ <retval>,
.L355:
@ C_Code.c:741: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L356:
@ C_Code.c:723:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r2, #66	@ tmp143,
	ldrb	r2, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:723:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r3, #6	@ tmp149,
	ands	r3, r2	@ tmp150, gPlaySt
	cmp	r3, #4	@ tmp150,
	bne	.L355		@,
@ C_Code.c:727:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	movs	r1, #11	@ tmp154,
@ C_Code.c:728:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	movs	r4, #11	@ pretmp_25,
@ C_Code.c:727:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldr	r0, .L367+8	@ tmp153,
@ C_Code.c:728:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldr	r2, .L367+12	@ tmp152,
@ C_Code.c:727:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldrsb	r1, [r0, r1]	@ tmp154,
	adds	r3, r3, #188	@ tmp155,
@ C_Code.c:728:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldrsb	r4, [r2, r4]	@ pretmp_25,* pretmp_25
@ C_Code.c:727:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	tst	r3, r1	@ tmp155, tmp154
	beq	.L366		@,
@ C_Code.c:733:         if (UNIT_FACTION(&gBattleTarget.unit) != FACTION_BLUE)
	tst	r3, r4	@ tmp155, pretmp_25
	bne	.L359		@,
@ C_Code.c:740:         return GetSoloAnimPreconfType(&gBattleTarget.unit);
	movs	r0, r2	@, tmp152
.L366:
	ldr	r3, .L367+16	@ tmp162,
	bl	.L27		@
	b	.L355		@
.L368:
	.align	2
.L367:
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
.LC94:
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
	.word	.LC94
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
	.ident	"GCC: (devkitARM release 63) 13.2.0"
	.text
	.code 16
	.align	1
.L27:
	bx	r3
.L112:
	bx	r4
.L44:
	bx	r5
.L191:
	bx	r7
.L23:
	bx	r9
.L192:
	bx	r10
