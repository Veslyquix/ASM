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
	.align	1
	.p2align 2,,3
	.global	AreTimedHitsEnabled
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	AreTimedHitsEnabled, %function
AreTimedHitsEnabled:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:100: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldr	r3, .L8	@ tmp122,
@ C_Code.c:100: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldrh	r2, [r3]	@ gBattleStats, gBattleStats
	movs	r3, #252	@ tmp126,
	lsls	r3, r3, #2	@ tmp126, tmp126,
@ C_Code.c:99: int AreTimedHitsEnabled(void) { 
	push	{r4, lr}	@
@ C_Code.c:100: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	tst	r2, r3	@ gBattleStats, tmp126
	bne	.L3		@,
@ C_Code.c:103: 	if (TimedHitsDifficultyRam->off) { return false; } 
	ldr	r3, .L8+4	@ tmp131,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_4, *TimedHitsDifficultyRam.0_4
@ C_Code.c:101: 		return false; 
	movs	r0, #0	@ <retval>,
@ C_Code.c:103: 	if (TimedHitsDifficultyRam->off) { return false; } 
	lsls	r3, r3, #25	@ tmp152, *TimedHitsDifficultyRam.0_4,
	bpl	.L7		@,
.L1:
@ C_Code.c:105: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L7:
@ C_Code.c:104: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L8+8	@ tmp141,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L8+12	@ tmp143,
	bl	.L10		@
@ C_Code.c:104: 	return !CheckFlag(DisabledFlag); 
	rsbs	r3, r0, #0	@ tmp148, tmp150
	adcs	r0, r0, r3	@ <retval>, tmp150, tmp148
	b	.L1		@
.L3:
@ C_Code.c:101: 		return false; 
	movs	r0, #0	@ <retval>,
	b	.L1		@
.L9:
	.align	2
.L8:
	.word	gBattleStats
	.word	TimedHitsDifficultyRam
	.word	DisabledFlag
	.word	CheckFlag
	.size	AreTimedHitsEnabled, .-AreTimedHitsEnabled
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
@ C_Code.c:113: 	proc->timer2 = 0xFF; 
	ldr	r2, .L12	@ tmp120,
@ C_Code.c:127: } 
	@ sp needed	@
@ C_Code.c:113: 	proc->timer2 = 0xFF; 
	str	r2, [r0, #68]	@ tmp120, MEM <unsigned int> [(unsigned char *)proc_2(D) + 68B]
@ C_Code.c:110: 	proc->broke = false; 
	subs	r2, r2, #255	@ tmp121,
	str	r2, [r0, #72]	@ tmp121, MEM <unsigned int> [(unsigned char *)proc_2(D) + 72B]
@ C_Code.c:124: 	proc->code4frame = 0xff;
	ldr	r2, .L12+4	@ tmp122,
@ C_Code.c:108: 	proc->anim = NULL; 
	movs	r3, #0	@ tmp114,
@ C_Code.c:124: 	proc->code4frame = 0xff;
	str	r2, [r0, #76]	@ tmp122, MEM <unsigned int> [(unsigned char *)proc_2(D) + 76B]
@ C_Code.c:123: 	proc->buttonsToPress = 0; 
	movs	r2, #80	@ tmp123,
@ C_Code.c:108: 	proc->anim = NULL; 
	str	r3, [r0, #44]	@ tmp114, proc_2(D)->anim
@ C_Code.c:109: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp114, proc_2(D)->anim2
@ C_Code.c:112: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp114, proc_2(D)->timer
@ C_Code.c:118: 	proc->currentRound = NULL; 
	str	r3, [r0, #56]	@ tmp114, proc_2(D)->currentRound
@ C_Code.c:119: 	proc->active_bunit = NULL; 
	str	r3, [r0, #60]	@ tmp114, proc_2(D)->active_bunit
@ C_Code.c:120: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp114, proc_2(D)->opp_bunit
@ C_Code.c:123: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r2]	@ tmp114, proc_2(D)->buttonsToPress
@ C_Code.c:127: } 
	bx	lr
.L13:
	.align	2
.L12:
	.word	16711935
	.word	-16646145
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
	push	{r4, r5, r6, lr}	@
@ C_Code.c:131: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r5, .L17	@ tmp115,
	ldr	r3, .L17+4	@ tmp116,
	movs	r0, r5	@, tmp115
	bl	.L10		@
	subs	r4, r0, #0	@ proc, tmp131,
@ C_Code.c:132: 	if (!proc) { 
	beq	.L16		@,
.L14:
@ C_Code.c:137: } 
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L16:
@ C_Code.c:133: 		proc = Proc_Start(TimedHitsProcCmd, (void*)3); 
	ldr	r3, .L17+8	@ tmp118,
	movs	r1, #3	@,
	movs	r0, r5	@, tmp115
	bl	.L10		@
@ C_Code.c:113: 	proc->timer2 = 0xFF; 
	ldr	r3, .L17+12	@ tmp125,
	str	r3, [r0, #68]	@ tmp125, MEM <unsigned int> [(unsigned char *)proc_6 + 68B]
@ C_Code.c:110: 	proc->broke = false; 
	subs	r3, r3, #255	@ tmp126,
	str	r3, [r0, #72]	@ tmp126, MEM <unsigned int> [(unsigned char *)proc_6 + 72B]
@ C_Code.c:124: 	proc->code4frame = 0xff;
	ldr	r3, .L17+16	@ tmp127,
	str	r3, [r0, #76]	@ tmp127, MEM <unsigned int> [(unsigned char *)proc_6 + 76B]
@ C_Code.c:123: 	proc->buttonsToPress = 0; 
	movs	r3, #80	@ tmp128,
@ C_Code.c:108: 	proc->anim = NULL; 
	str	r4, [r0, #44]	@ proc, proc_6->anim
@ C_Code.c:109: 	proc->anim2 = NULL; 
	str	r4, [r0, #48]	@ proc, proc_6->anim2
@ C_Code.c:112: 	proc->timer = 0; 
	str	r4, [r0, #52]	@ proc, proc_6->timer
@ C_Code.c:118: 	proc->currentRound = NULL; 
	str	r4, [r0, #56]	@ proc, proc_6->currentRound
@ C_Code.c:119: 	proc->active_bunit = NULL; 
	str	r4, [r0, #60]	@ proc, proc_6->active_bunit
@ C_Code.c:120: 	proc->opp_bunit = NULL; 
	str	r4, [r0, #64]	@ proc, proc_6->opp_bunit
@ C_Code.c:123: 	proc->buttonsToPress = 0; 
	strh	r4, [r0, r3]	@ proc, proc_6->buttonsToPress
@ C_Code.c:137: } 
	b	.L14		@
.L18:
	.align	2
.L17:
	.word	.LANCHOR0
	.word	Proc_Find
	.word	Proc_Start
	.word	16711935
	.word	-16646145
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
	push	{r3, r4, r5, r6, r7, lr}	@
@ C_Code.c:140: void SetCurrentAnimInProc(struct Anim* anim) { 
	movs	r5, r0	@ anim, tmp191
@ C_Code.c:142: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r3, .L25	@ tmp132,
	ldr	r0, .L25+4	@ tmp131,
	bl	.L10		@
	subs	r4, r0, #0	@ proc, tmp192,
@ C_Code.c:143: 	if (!proc) { return; } 
	beq	.L19		@,
@ C_Code.c:145: 	if (proc->roundId == roundId) { return; } 	
	movs	r7, #70	@ tmp134,
@ C_Code.c:144: 	int roundId = anim->nextRoundId-1; 
	ldrh	r6, [r5, #14]	@ tmp133,
@ C_Code.c:145: 	if (proc->roundId == roundId) { return; } 	
	ldrb	r3, [r0, r7]	@ tmp135,
@ C_Code.c:144: 	int roundId = anim->nextRoundId-1; 
	subs	r6, r6, #1	@ roundId,
@ C_Code.c:145: 	if (proc->roundId == roundId) { return; } 	
	cmp	r3, r6	@ tmp135, roundId
	beq	.L19		@,
@ C_Code.c:113: 	proc->timer2 = 0xFF; 
	ldr	r2, .L25+8	@ tmp141,
	str	r2, [r0, #68]	@ tmp141, MEM <unsigned int> [(unsigned char *)proc_20 + 68B]
@ C_Code.c:110: 	proc->broke = false; 
	subs	r2, r2, #255	@ tmp142,
	str	r2, [r0, #72]	@ tmp142, MEM <unsigned int> [(unsigned char *)proc_20 + 72B]
@ C_Code.c:124: 	proc->code4frame = 0xff;
	ldr	r2, .L25+12	@ tmp143,
@ C_Code.c:109: 	proc->anim2 = NULL; 
	movs	r3, #0	@ tmp136,
@ C_Code.c:124: 	proc->code4frame = 0xff;
	str	r2, [r0, #76]	@ tmp143, MEM <unsigned int> [(unsigned char *)proc_20 + 76B]
@ C_Code.c:123: 	proc->buttonsToPress = 0; 
	movs	r2, #80	@ tmp144,
@ C_Code.c:109: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp136, proc_20->anim2
@ C_Code.c:112: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp136, proc_20->timer
@ C_Code.c:118: 	proc->currentRound = NULL; 
	str	r3, [r0, #56]	@ tmp136, proc_20->currentRound
@ C_Code.c:119: 	proc->active_bunit = NULL; 
	str	r3, [r0, #60]	@ tmp136, proc_20->active_bunit
@ C_Code.c:120: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp136, proc_20->opp_bunit
@ C_Code.c:123: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r2]	@ tmp136, proc_20->buttonsToPress
@ C_Code.c:148: 	proc->anim = anim; 
	str	r5, [r0, #44]	@ anim, proc_20->anim
@ C_Code.c:149: 	proc->anim2 = GetAnimAnotherSide(anim); 
	ldr	r3, .L25+16	@ tmp147,
	movs	r0, r5	@, anim
	bl	.L10		@
@ C_Code.c:149: 	proc->anim2 = GetAnimAnotherSide(anim); 
	str	r0, [r4, #48]	@ tmp193, proc_20->anim2
@ C_Code.c:153: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	movs	r0, #255	@ tmp150,
	ldr	r3, .L25+20	@ tmp152,
@ C_Code.c:150: 	proc->roundId = roundId; 
	strb	r6, [r4, r7]	@ roundId, proc_20->roundId
@ C_Code.c:153: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	ands	r0, r6	@ tmp151, roundId
	bl	.L10		@
@ C_Code.c:154: 	proc->side = GetAnimPosition(anim) ^ 1; 
	ldr	r3, .L25+24	@ tmp153,
@ C_Code.c:153: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	str	r0, [r4, #56]	@ tmp194, proc_20->currentRound
@ C_Code.c:154: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r0, r5	@, anim
	bl	.L10		@
@ C_Code.c:154: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r3, #1	@ tmp155,
@ C_Code.c:154: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r2, #74	@ tmp158,
@ C_Code.c:154: 	proc->side = GetAnimPosition(anim) ^ 1; 
	lsls	r0, r0, #24	@ tmp154, tmp195,
	asrs	r0, r0, #24	@ _10, tmp154,
	eors	r3, r0	@ tmp157, _10
@ C_Code.c:154: 	proc->side = GetAnimPosition(anim) ^ 1; 
	strb	r3, [r4, r2]	@ tmp157, proc_20->side
@ C_Code.c:155: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, .L25+28	@ tmp160,
@ C_Code.c:156: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, .L25+32	@ tmp161,
@ C_Code.c:155: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, [r3]	@ gpEkrBattleUnitLeft.2_13, gpEkrBattleUnitLeft
@ C_Code.c:156: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, [r2]	@ gpEkrBattleUnitRight.3_14, gpEkrBattleUnitRight
@ C_Code.c:155: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	str	r3, [r4, #60]	@ gpEkrBattleUnitLeft.2_13, proc_20->active_bunit
@ C_Code.c:156: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #64]	@ gpEkrBattleUnitRight.3_14, proc_20->opp_bunit
@ C_Code.c:157: 	if (!proc->side) { 
	cmp	r0, #1	@ _10,
	bne	.L23		@,
@ C_Code.c:158: 		proc->active_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #60]	@ gpEkrBattleUnitRight.3_14, proc_20->active_bunit
@ C_Code.c:159: 		proc->opp_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #64]	@ gpEkrBattleUnitLeft.2_13, proc_20->opp_bunit
.L23:
@ C_Code.c:161: 	if (!proc->loadedImg) {
	movs	r6, #73	@ tmp162,
@ C_Code.c:161: 	if (!proc->loadedImg) {
	ldrb	r3, [r4, r6]	@ tmp163,
	cmp	r3, #0	@ tmp163,
	beq	.L24		@,
.L19:
@ C_Code.c:172: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L24:
@ C_Code.c:162: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r5, .L25+36	@ tmp166,
	movs	r2, #6	@,
	ldr	r0, .L25+40	@ tmp165,
	ldr	r1, .L25+44	@,
	adds	r3, r3, #2	@,
	bl	.L27		@
@ C_Code.c:163: 		Copy2dChr(&BattleStar, (void*)0x06012a40, 2, 2); // 0x108 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L25+48	@ tmp168,
	ldr	r1, .L25+52	@,
	bl	.L27		@
@ C_Code.c:164: 		Copy2dChr(&A_Button, (void*)0x06012800, 2, 2); // 0x140
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L25+56	@ tmp171,
	ldr	r1, .L25+60	@,
	bl	.L27		@
@ C_Code.c:165: 		Copy2dChr(&B_Button, (void*)0x06012840, 2, 2); // 0x142 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L25+64	@ tmp174,
	ldr	r1, .L25+68	@,
	bl	.L27		@
@ C_Code.c:166: 		Copy2dChr(&Left_Button, (void*)0x06012880, 2, 2); // 0x144
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L25+72	@ tmp177,
	ldr	r1, .L25+76	@,
	bl	.L27		@
@ C_Code.c:167: 		Copy2dChr(&Right_Button, (void*)0x060128C0, 2, 2); // 0x146
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L25+80	@ tmp180,
	ldr	r1, .L25+84	@,
	bl	.L27		@
@ C_Code.c:168: 		Copy2dChr(&Up_Button, (void*)0x06012900, 2, 2); // 0x148
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L25+88	@ tmp183,
	ldr	r1, .L25+92	@,
	bl	.L27		@
@ C_Code.c:169: 		Copy2dChr(&Down_Button, (void*)0x06012940, 2, 2); // 0x14a
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L25+96	@ tmp186,
	ldr	r1, .L25+100	@,
	bl	.L27		@
@ C_Code.c:170: 		proc->loadedImg = true;
	movs	r3, #1	@ tmp189,
	strb	r3, [r4, r6]	@ tmp189, proc_20->loadedImg
	b	.L19		@
.L26:
	.align	2
.L25:
	.word	Proc_Find
	.word	.LANCHOR0
	.word	16711935
	.word	-16711681
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
@ C_Code.c:254: 	if (proc->broke) { return; } 
	movs	r3, #72	@ tmp115,
@ C_Code.c:254: 	if (proc->broke) { return; } 
	ldrb	r2, [r0, r3]	@ tmp116,
	cmp	r2, #0	@ tmp116,
	bne	.L28		@,
@ C_Code.c:255: 	proc->broke = true; 
	adds	r2, r2, #1	@ tmp118,
	strb	r2, [r0, r3]	@ tmp118, proc_4(D)->broke
@ C_Code.c:256: 	asm("mov r11, r11");
	.syntax divided
@ 256 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L28:
@ C_Code.c:257: } 
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
@ C_Code.c:261: 	if (!HpProc) { return false; } // 
	cmp	r1, #0	@ tmp125,
	beq	.L32		@,
@ C_Code.c:263: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #79	@ tmp118,
@ C_Code.c:263: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r0, [r0, r3]	@ tmp120,
@ C_Code.c:261: 	if (!HpProc) { return false; } // 
	rsbs	r3, r0, #0	@ tmp122, tmp120
	adcs	r0, r0, r3	@ <retval>, tmp120, tmp122
.L30:
@ C_Code.c:265: } 
	@ sp needed	@
	bx	lr
.L32:
@ C_Code.c:261: 	if (!HpProc) { return false; } // 
	movs	r0, #0	@ <retval>,
	b	.L30		@
	.size	HitNow, .-HitNow
	.align	1
	.p2align 2,,3
	.global	IsNotMagicAnimation
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IsNotMagicAnimation, %function
IsNotMagicAnimation:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:311: 	int wepType = GetItemType(proc->active_bunit->weaponBefore); 
	movs	r3, #74	@ tmp123,
@ C_Code.c:310: int IsNotMagicAnimation(TimedHitsProc* proc) { 
	push	{r4, lr}	@
@ C_Code.c:311: 	int wepType = GetItemType(proc->active_bunit->weaponBefore); 
	ldr	r2, [r0, #60]	@ proc_6(D)->active_bunit, proc_6(D)->active_bunit
@ C_Code.c:316: } 
	@ sp needed	@
@ C_Code.c:311: 	int wepType = GetItemType(proc->active_bunit->weaponBefore); 
	ldrh	r0, [r2, r3]	@ tmp124,
	ldr	r3, .L34	@ tmp125,
	bl	.L10		@
@ C_Code.c:314: 	if (wepType == 7) { return false; } 
	movs	r3, #2	@ tmp130,
@ C_Code.c:313: 	if (wepType == 6) { return false; } 
	subs	r0, r0, #5	@ tmp127,
@ C_Code.c:314: 	if (wepType == 7) { return false; } 
	cmp	r3, r0	@ tmp130, tmp127
	sbcs	r0, r0, r0	@ tmp134
	rsbs	r0, r0, #0	@ tmp129, tmp134
@ C_Code.c:316: } 
	pop	{r4}
	pop	{r1}
	bx	r1
.L35:
	.align	2
.L34:
	.word	GetItemType
	.size	IsNotMagicAnimation, .-IsNotMagicAnimation
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC26:
	.ascii	"\001\002\020 @\200\000"
	.text
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r5, r8	@,
	mov	lr, fp	@,
	mov	r7, r10	@,
	mov	r6, r9	@,
	push	{r5, r6, r7, lr}	@
@ C_Code.c:320: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, .L64	@ tmp146,
@ C_Code.c:320: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:319: int GetButtonsToPress(TimedHitsProc* proc) { 
	mov	r8, r0	@ proc, tmp203
	sub	sp, sp, #12	@,,
@ C_Code.c:320: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	cmp	r3, #0	@ AlwaysA,
	bne	.L50		@,
@ C_Code.c:320: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, .L64+4	@ tmp148,
	ldr	r2, [r3]	@ TimedHitsDifficultyRam.10_2, TimedHitsDifficultyRam
@ C_Code.c:320: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.10_2, *TimedHitsDifficultyRam.10_2
	lsls	r3, r3, #26	@ tmp207, *TimedHitsDifficultyRam.10_2,
	bmi	.L50		@,
@ C_Code.c:321: 	int keys = proc->buttonsToPress;
	movs	r3, #80	@ tmp158,
@ C_Code.c:321: 	int keys = proc->buttonsToPress;
	ldrh	r5, [r0, r3]	@ <retval>,
@ C_Code.c:322: 	if (!keys) { 
	cmp	r5, #0	@ <retval>,
	bne	.L36		@,
@ C_Code.c:323: 		u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
	ldr	r3, .L64+8	@ tmp160,
	ldr	r1, [r3]	@ tmp163,
	str	r1, [sp]	@ tmp163,
	mov	r1, sp	@ tmp210,
	ldrh	r3, [r3, #4]	@ tmp165,
	strh	r3, [r1, #4]	@ tmp165,
@ C_Code.c:328: 		int numberOfRandomButtons = NumberOfRandomButtons; 
	ldr	r3, .L64+12	@ tmp167,
	ldr	r3, [r3]	@ numberOfRandomButtons, NumberOfRandomButtons
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:311: 	int wepType = GetItemType(proc->active_bunit->weaponBefore); 
	movs	r3, #74	@ tmp169,
	ldr	r1, [r0, #60]	@ proc_33(D)->active_bunit, proc_33(D)->active_bunit
@ C_Code.c:311: 	int wepType = GetItemType(proc->active_bunit->weaponBefore); 
	ldrh	r0, [r1, r3]	@ _95,
@ C_Code.c:329: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	mov	r3, r9	@ numberOfRandomButtons, numberOfRandomButtons
	cmp	r3, #0	@ numberOfRandomButtons,
	beq	.L61		@,
@ C_Code.c:311: 	int wepType = GetItemType(proc->active_bunit->weaponBefore); 
	ldr	r3, .L64+16	@ tmp197,
	bl	.L10		@
@ C_Code.c:312: 	if (wepType == 5) { return false; } 
	subs	r0, r0, #5	@ tmp198,
	cmp	r0, #2	@ tmp198,
	bls	.L47		@,
.L48:
@ C_Code.c:330: 		if (IsNotMagicAnimation(proc)) { numberOfRandomButtons = numberOfRandomButtons / 2; } 
	mov	r3, r9	@ numberOfRandomButtons, numberOfRandomButtons
	lsrs	r3, r3, #31	@ tmp179, numberOfRandomButtons,
	add	r3, r3, r9	@ tmp180, numberOfRandomButtons
	asrs	r3, r3, #1	@ numberOfRandomButtons, tmp180,
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
.L39:
@ C_Code.c:331: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	mov	r3, r9	@ numberOfRandomButtons, numberOfRandomButtons
	cmp	r3, #0	@ numberOfRandomButtons,
	bne	.L47		@,
@ C_Code.c:331: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	movs	r3, #1	@ numberOfRandomButtons,
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
.L40:
	ldr	r3, .L64+20	@ tmp199,
	mov	fp, r3	@ tmp199, tmp199
@ C_Code.c:338: 			if (button & 0xF0) { // some dpad 
	movs	r3, #15	@ tmp185,
@ C_Code.c:333: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	movs	r6, #0	@ i,
@ C_Code.c:326: 		int oppDir = 0; 
	movs	r7, #0	@ oppDir,
@ C_Code.c:321: 	int keys = proc->buttonsToPress;
	movs	r5, #0	@ keys,
@ C_Code.c:327: 		int size = 5; // -1 since we count from 0  
	movs	r4, #5	@ size,
@ C_Code.c:338: 			if (button & 0xF0) { // some dpad 
	mov	r10, r3	@ tmp185, tmp185
	b	.L46		@
.L42:
@ C_Code.c:333: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r6, r6, #1	@ i,
@ C_Code.c:353: 			keys |= button; 
	orrs	r5, r0	@ keys, button
@ C_Code.c:333: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r9, r6	@ numberOfRandomButtons, i
	ble	.L62		@,
.L46:
@ C_Code.c:334: 			num = NextRN_N(size); 
	movs	r0, r4	@, size
	bl	.L66		@
@ C_Code.c:335: 			button = KeysList[num];
	mov	r3, sp	@ tmp222,
	ldrb	r0, [r3, r0]	@ button, KeysList
@ C_Code.c:338: 			if (button & 0xF0) { // some dpad 
	mov	r2, r10	@ tmp185, tmp185
	movs	r3, r0	@ tmp187, button
	bics	r3, r2	@ tmp187, tmp185
	beq	.L42		@,
@ C_Code.c:339: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	cmp	r0, #16	@ button,
	beq	.L53		@,
@ C_Code.c:340: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	cmp	r0, #32	@ button,
	beq	.L54		@,
@ C_Code.c:341: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	cmp	r0, #64	@ button,
	bne	.L63		@,
@ C_Code.c:341: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	movs	r7, #128	@ oppDir,
.L43:
@ C_Code.c:343: 				for (int c = 0; c <= size; ++c) { 
	cmp	r4, #0	@ size,
	blt	.L42		@,
	mov	r2, sp	@ ivtmp.99,
@ C_Code.c:343: 				for (int c = 0; c <= size; ++c) { 
	movs	r3, #0	@ c,
	b	.L45		@
.L44:
@ C_Code.c:343: 				for (int c = 0; c <= size; ++c) { 
	adds	r3, r3, #1	@ c,
@ C_Code.c:343: 				for (int c = 0; c <= size; ++c) { 
	adds	r2, r2, #1	@ ivtmp.99,
	cmp	r4, r3	@ size, c
	blt	.L42		@,
.L45:
@ C_Code.c:344: 					if (KeysList[c] == oppDir) { 
	ldrb	r1, [r2]	@ MEM[(unsigned char *)_52], MEM[(unsigned char *)_52]
@ C_Code.c:344: 					if (KeysList[c] == oppDir) { 
	cmp	r1, r7	@ MEM[(unsigned char *)_52], oppDir
	bne	.L44		@,
@ C_Code.c:345: 						KeysList[c] = KeysList[size]; 
	mov	r2, sp	@ tmp225,
@ C_Code.c:345: 						KeysList[c] = KeysList[size]; 
	mov	r1, sp	@ tmp226,
@ C_Code.c:345: 						KeysList[c] = KeysList[size]; 
	ldrb	r2, [r2, r4]	@ _12, KeysList
@ C_Code.c:333: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r6, r6, #1	@ i,
@ C_Code.c:345: 						KeysList[c] = KeysList[size]; 
	strb	r2, [r1, r3]	@ _12, KeysList[c_23]
@ C_Code.c:346: 						size--; 
	subs	r4, r4, #1	@ size,
@ C_Code.c:353: 			keys |= button; 
	orrs	r5, r0	@ keys, button
@ C_Code.c:333: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r9, r6	@ numberOfRandomButtons, i
	bgt	.L46		@,
.L62:
@ C_Code.c:355: 		proc->buttonsToPress = keys; 
	lsls	r3, r5, #16	@ tmp193, keys,
	lsrs	r3, r3, #16	@ _83, tmp193,
.L41:
	movs	r2, #80	@ tmp194,
	mov	r1, r8	@ proc, proc
	strh	r3, [r1, r2]	@ _83, proc_33(D)->buttonsToPress
	b	.L36		@
.L50:
@ C_Code.c:320: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	movs	r5, #1	@ <retval>,
.L36:
@ C_Code.c:358: } 
	movs	r0, r5	@, <retval>
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
.L61:
@ C_Code.c:329: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.10_2, *TimedHitsDifficultyRam.10_2
	lsls	r3, r3, #27	@ tmp174, *TimedHitsDifficultyRam.10_2,
@ C_Code.c:329: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	lsrs	r3, r3, #27	@ numberOfRandomButtons, tmp174,
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:311: 	int wepType = GetItemType(proc->active_bunit->weaponBefore); 
	ldr	r3, .L64+16	@ tmp176,
	bl	.L10		@
@ C_Code.c:312: 	if (wepType == 5) { return false; } 
	subs	r0, r0, #5	@ tmp177,
	cmp	r0, #2	@ tmp177,
	bhi	.L48		@,
	b	.L39		@
.L63:
@ C_Code.c:342: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	cmp	r0, #128	@ button,
	bne	.L43		@,
@ C_Code.c:342: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	movs	r7, #64	@ oppDir,
	b	.L43		@
.L54:
@ C_Code.c:340: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	movs	r7, #16	@ oppDir,
	b	.L43		@
.L53:
@ C_Code.c:339: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	movs	r7, #32	@ oppDir,
	b	.L43		@
.L47:
@ C_Code.c:333: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	mov	r3, r9	@ numberOfRandomButtons, numberOfRandomButtons
	cmp	r3, #0	@ numberOfRandomButtons,
	bgt	.L40		@,
	movs	r3, #0	@ _83,
	b	.L41		@
.L65:
	.align	2
.L64:
	.word	AlwaysA
	.word	TimedHitsDifficultyRam
	.word	.LC26
	.word	NumberOfRandomButtons
	.word	GetItemType
	.word	NextRN_N
	.size	GetButtonsToPress, .-GetButtonsToPress
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DrawButtonsToPress.part.0, %function
DrawButtonsToPress.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, fp	@,
	mov	r5, r8	@,
	mov	r7, r10	@,
	mov	r6, r9	@,
	push	{r5, r6, r7, lr}	@
	sub	sp, sp, #12	@,,
@ C_Code.c:415: void DrawButtonsToPress(TimedHitsProc* proc, int x, int y, int palID) { 
	mov	fp, r2	@ y, tmp239
	movs	r7, r0	@ proc, tmp237
	mov	r8, r1	@ x, tmp238
	movs	r5, r3	@ palID, tmp240
@ C_Code.c:417: 	int keys = GetButtonsToPress(proc); 
	bl	GetButtonsToPress		@
@ C_Code.c:419: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r2, .L123	@ tmp155,
@ C_Code.c:419: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r2, [r2]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
@ C_Code.c:417: 	int keys = GetButtonsToPress(proc); 
	movs	r4, r0	@ keys, tmp241
@ C_Code.c:419: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	cmp	r2, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L70		@,
@ C_Code.c:419: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	movs	r3, #75	@ tmp159,
@ C_Code.c:419: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldrb	r3, [r7, r3]	@ tmp160,
	cmp	r3, #0	@ tmp160,
	beq	.LCB608	@
	b	.L113	@long jump	@
.LCB608:
.L70:
@ C_Code.c:421: 	int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); //OAM2_CHR(0);
	lsls	r5, r5, #28	@ tmp158, palID,
	lsrs	r5, r5, #16	@ prephitmp_87, tmp158,
.L69:
@ C_Code.c:422: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	r2, fp	@ y, y
	movs	r3, #255	@ tmp161,
	ldr	r7, .L123+4	@ tmp232,
	ands	r3, r2	@ tmp161, y
	mov	r2, r8	@ x, x
	mov	r10, r3	@ _11, tmp161
	movs	r3, r7	@ tmp163, tmp232
	lsls	r1, r2, #23	@ tmp165, x,
	ldr	r6, .L123+8	@ tmp233,
	mov	r2, r10	@, _11
	movs	r0, #2	@,
	adds	r3, r3, #32	@ tmp163,
	lsrs	r1, r1, #23	@ tmp164, tmp165,
	str	r5, [sp]	@ prephitmp_87,
	bl	.L125		@
@ C_Code.c:423: 	x += 32; 
	mov	r1, r8	@ x, x
@ C_Code.c:424: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	movs	r3, r7	@ tmp168, tmp232
@ C_Code.c:423: 	x += 32; 
	adds	r1, r1, #32	@ x,
@ C_Code.c:424: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	lsls	r1, r1, #23	@ tmp171, x,
	mov	r2, r10	@, _11
	movs	r0, #2	@,
	adds	r3, r3, #40	@ tmp168,
	lsrs	r1, r1, #23	@ tmp170, tmp171,
	str	r5, [sp]	@ prephitmp_87,
	bl	.L125		@
@ C_Code.c:425: 	y += 16; x -= 36; 
	movs	r3, #16	@ y,
	movs	r2, r7	@ ivtmp.117, tmp232
	mov	r10, r3	@ y, y
	movs	r0, r7	@ _18, tmp232
@ C_Code.c:422: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	r9, r6	@ tmp233, tmp233
@ C_Code.c:362: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:425: 	y += 16; x -= 36; 
	add	r10, r10, fp	@ y, y
	adds	r2, r2, #49	@ ivtmp.117,
	adds	r0, r0, #54	@ _18,
@ C_Code.c:426: 	int count = CountKeysPressed(keys); 
	subs	r3, r3, #15	@ prephitmp_85,
	b	.L73		@
.L114:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r3, [r2]	@ prephitmp_85, MEM[(unsigned char *)_6]
	adds	r2, r2, #1	@ ivtmp.117,
.L73:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	ands	r3, r4	@ tmp177, keys
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r6, r3, #1	@ tmp236, tmp177
	sbcs	r3, r3, r6	@ tmp235, tmp177, tmp236
	adds	r1, r1, r3	@ c, c, tmp235
@ C_Code.c:363: 	for (int i = 0; i < 6; ++i) { 
	cmp	r0, r2	@ _18, ivtmp.117
	bne	.L114		@,
@ C_Code.c:428: 	if (count == 1) { x += 16; } // centering 
	cmp	r1, #1	@ c,
	beq	.L115		@,
@ C_Code.c:429: 	if (count == 2) { x += 8; } 
	mov	r3, r8	@ x, x
	adds	r6, r3, #4	@ x, x,
@ C_Code.c:429: 	if (count == 2) { x += 8; } 
	cmp	r1, #2	@ c,
	bne	.L116		@,
.L75:
@ C_Code.c:432: 	if (keys & A_BUTTON) { 
	lsls	r3, r4, #31	@ tmp243, keys,
	bmi	.L117		@,
.L77:
@ C_Code.c:435: 	if (keys & B_BUTTON) { 
	lsls	r3, r4, #30	@ tmp244, keys,
	bmi	.L118		@,
.L78:
@ C_Code.c:438: 	if (keys & DPAD_LEFT) { 
	lsls	r3, r4, #26	@ tmp245, keys,
	bmi	.L119		@,
.L79:
@ C_Code.c:441: 	if (keys & DPAD_RIGHT) { 
	lsls	r3, r4, #27	@ tmp246, keys,
	bmi	.L120		@,
.L80:
@ C_Code.c:444: 	if (keys & DPAD_UP) { 
	lsls	r3, r4, #25	@ tmp247, keys,
	bmi	.L121		@,
.L81:
@ C_Code.c:447: 	if (keys & DPAD_DOWN) { 
	lsls	r4, r4, #24	@ tmp248, keys,
	bmi	.L122		@,
.L67:
@ C_Code.c:454: } 
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L116:
@ C_Code.c:425: 	y += 16; x -= 36; 
	subs	r6, r6, #8	@ x,
@ C_Code.c:432: 	if (keys & A_BUTTON) { 
	lsls	r3, r4, #31	@ tmp243, keys,
	bpl	.L77		@,
.L117:
@ C_Code.c:433: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	mov	r1, r10	@ y, y
	movs	r2, #255	@ tmp182,
	movs	r3, r7	@ tmp181, tmp232
	ands	r2, r1	@ tmp183, y
	lsls	r1, r6, #23	@ tmp185, x,
	movs	r0, #2	@,
	str	r5, [sp]	@ prephitmp_87,
	adds	r3, r3, #56	@ tmp181,
	lsrs	r1, r1, #23	@ tmp184, tmp185,
	bl	.L126		@
@ C_Code.c:433: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	adds	r6, r6, #18	@ x,
@ C_Code.c:435: 	if (keys & B_BUTTON) { 
	lsls	r3, r4, #30	@ tmp244, keys,
	bpl	.L78		@,
.L118:
@ C_Code.c:436: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	mov	r1, r10	@ y, y
	movs	r2, #255	@ tmp191,
	movs	r3, r7	@ tmp190, tmp232
	ands	r2, r1	@ tmp192, y
	lsls	r1, r6, #23	@ tmp194, x,
	movs	r0, #2	@,
	str	r5, [sp]	@ prephitmp_87,
	adds	r3, r3, #64	@ tmp190,
	lsrs	r1, r1, #23	@ tmp193, tmp194,
	bl	.L126		@
@ C_Code.c:436: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	adds	r6, r6, #18	@ x,
@ C_Code.c:438: 	if (keys & DPAD_LEFT) { 
	lsls	r3, r4, #26	@ tmp245, keys,
	bpl	.L79		@,
.L119:
@ C_Code.c:439: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	mov	r1, r10	@ y, y
	movs	r2, #255	@ tmp200,
	movs	r3, r7	@ tmp199, tmp232
	ands	r2, r1	@ tmp201, y
	lsls	r1, r6, #23	@ tmp203, x,
	movs	r0, #2	@,
	str	r5, [sp]	@ prephitmp_87,
	adds	r3, r3, #72	@ tmp199,
	lsrs	r1, r1, #23	@ tmp202, tmp203,
	bl	.L126		@
@ C_Code.c:439: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	adds	r6, r6, #18	@ x,
@ C_Code.c:441: 	if (keys & DPAD_RIGHT) { 
	lsls	r3, r4, #27	@ tmp246, keys,
	bpl	.L80		@,
.L120:
@ C_Code.c:442: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	mov	r1, r10	@ y, y
	movs	r2, #255	@ tmp209,
	movs	r3, r7	@ tmp208, tmp232
	ands	r2, r1	@ tmp210, y
	lsls	r1, r6, #23	@ tmp212, x,
	movs	r0, #2	@,
	str	r5, [sp]	@ prephitmp_87,
	adds	r3, r3, #80	@ tmp208,
	lsrs	r1, r1, #23	@ tmp211, tmp212,
	bl	.L126		@
@ C_Code.c:442: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	adds	r6, r6, #18	@ x,
@ C_Code.c:444: 	if (keys & DPAD_UP) { 
	lsls	r3, r4, #25	@ tmp247, keys,
	bpl	.L81		@,
.L121:
@ C_Code.c:445: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	mov	r1, r10	@ y, y
	movs	r2, #255	@ tmp218,
	movs	r3, r7	@ tmp217, tmp232
	ands	r2, r1	@ tmp219, y
	lsls	r1, r6, #23	@ tmp221, x,
	movs	r0, #2	@,
	str	r5, [sp]	@ prephitmp_87,
	adds	r3, r3, #88	@ tmp217,
	lsrs	r1, r1, #23	@ tmp220, tmp221,
	bl	.L126		@
@ C_Code.c:445: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	adds	r6, r6, #18	@ x,
@ C_Code.c:447: 	if (keys & DPAD_DOWN) { 
	lsls	r4, r4, #24	@ tmp248, keys,
	bpl	.L67		@,
.L122:
@ C_Code.c:448: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2); x += 18; 
	mov	r1, r10	@ y, y
	movs	r2, #255	@ tmp227,
	movs	r3, r7	@ tmp232, tmp232
	ands	r2, r1	@ tmp228, y
	lsls	r1, r6, #23	@ tmp230, x,
	movs	r0, #2	@,
	str	r5, [sp]	@ prephitmp_87,
	adds	r3, r3, #96	@ tmp232,
	lsrs	r1, r1, #23	@ tmp229, tmp230,
	bl	.L126		@
	b	.L67		@
.L113:
	movs	r5, #224	@ prephitmp_87,
	lsls	r5, r5, #8	@ prephitmp_87, prephitmp_87,
	b	.L69		@
.L115:
@ C_Code.c:428: 	if (count == 1) { x += 16; } // centering 
	mov	r6, r8	@ x, x
	adds	r6, r6, #12	@ x,
	b	.L75		@
.L124:
	.align	2
.L123:
	.word	ChangePaletteWhenButtonIsPressed
	.word	.LANCHOR0
	.word	PutSprite
	.size	DrawButtonsToPress.part.0, .-DrawButtonsToPress.part.0
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
	ldr	r1, .L134	@ tmp122,
	movs	r2, r1	@ ivtmp.134, tmp122
	push	{r4, r5, lr}	@
@ C_Code.c:361: int CountKeysPressed(u32 keys) { 
	movs	r3, #1	@ pretmp_5,
	movs	r4, r0	@ keys, tmp131
	adds	r2, r2, #49	@ ivtmp.134,
@ C_Code.c:362: 	int c = 0; 
	movs	r0, #0	@ <retval>,
	adds	r1, r1, #54	@ _21,
	b	.L130		@
.L133:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r3, [r2]	@ pretmp_5, MEM[(unsigned char *)_19]
	adds	r2, r2, #1	@ ivtmp.134,
.L130:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	ands	r3, r4	@ tmp126, keys
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r5, r3, #1	@ tmp130, tmp126
	sbcs	r3, r3, r5	@ tmp129, tmp126, tmp130
	adds	r0, r0, r3	@ <retval>, <retval>, tmp129
@ C_Code.c:363: 	for (int i = 0; i < 6; ++i) { 
	cmp	r2, r1	@ ivtmp.134, _21
	bne	.L133		@,
@ C_Code.c:368: } 
	@ sp needed	@
	pop	{r4, r5}
	pop	{r1}
	bx	r1
.L135:
	.align	2
.L134:
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
	push	{r3, r4, r5, r6, r7, lr}	@
@ C_Code.c:370: int PressedSpecificKeys(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r1	@ keys, tmp179
@ C_Code.c:371: 	int reqKeys = GetButtonsToPress(proc); 
	bl	GetButtonsToPress		@
	ldr	r5, .L166	@ tmp150,
	movs	r2, r5	@ ivtmp.165, tmp150
	adds	r2, r2, #49	@ ivtmp.165,
	mov	ip, r0	@ reqKeys, tmp180
@ C_Code.c:372: 	int count = CountKeysPressed(reqKeys); 
	movs	r1, r2	@ ivtmp.193, ivtmp.165
	movs	r3, #1	@ pretmp_38,
@ C_Code.c:362: 	int c = 0; 
	movs	r6, #0	@ c,
	adds	r5, r5, #54	@ _94,
	b	.L139		@
.L162:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r3, [r1]	@ pretmp_38, MEM[(unsigned char *)_92]
	adds	r1, r1, #1	@ ivtmp.193,
.L139:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	mov	r0, ip	@ reqKeys, reqKeys
	ands	r3, r0	@ tmp154, reqKeys
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r7, r3, #1	@ tmp168, tmp154
	sbcs	r3, r3, r7	@ tmp167, tmp154, tmp168
	adds	r6, r6, r3	@ c, c, tmp167
@ C_Code.c:363: 	for (int i = 0; i < 6; ++i) { 
	cmp	r1, r5	@ ivtmp.193, _94
	bne	.L162		@,
	movs	r1, r2	@ ivtmp.179, ivtmp.165
	movs	r3, #1	@ pretmp_18,
@ C_Code.c:362: 	int c = 0; 
	movs	r7, #0	@ c,
	b	.L138		@
.L163:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r3, [r1]	@ pretmp_18, MEM[(unsigned char *)_85]
	adds	r1, r1, #1	@ ivtmp.179,
.L138:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	ands	r3, r4	@ tmp155, keys
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r0, r3, #1	@ tmp171, tmp155
	sbcs	r3, r3, r0	@ tmp170, tmp155, tmp171
	adds	r7, r7, r3	@ c, c, tmp170
@ C_Code.c:363: 	for (int i = 0; i < 6; ++i) { 
	cmp	r1, r5	@ ivtmp.179, _94
	bne	.L163		@,
	movs	r3, #1	@ prephitmp_66,
@ C_Code.c:362: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:373: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r6, r7	@ c, c
	bge	.L145		@,
	b	.L142		@
.L164:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r3, [r2]	@ prephitmp_66, MEM[(unsigned char *)_8]
	adds	r2, r2, #1	@ ivtmp.165,
.L145:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	ands	r3, r4	@ tmp156, keys
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r7, r3, #1	@ tmp174, tmp156
	sbcs	r3, r3, r7	@ tmp173, tmp156, tmp174
	adds	r1, r1, r3	@ c, c, tmp173
@ C_Code.c:363: 	for (int i = 0; i < 6; ++i) { 
	cmp	r2, r5	@ ivtmp.165, _94
	bne	.L164		@,
@ C_Code.c:373: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r6, r1	@ tmp157, c, c
@ C_Code.c:373: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp157,
	bgt	.L153		@,
.L147:
@ C_Code.c:374: 	reqKeys &= ~keys; // only 0 if we hit all the correct keys (and possibly 1 extra) 
	mov	r0, ip	@ reqKeys, reqKeys
	bics	r0, r4	@ reqKeys, keys
@ C_Code.c:375: 	return (!reqKeys); 
	rsbs	r3, r0, #0	@ tmp164, reqKeys
	adcs	r0, r0, r3	@ <retval>, reqKeys, tmp164
.L136:
@ C_Code.c:376: } 
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L165:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r3, [r2]	@ pretmp_29, MEM[(unsigned char *)_78]
	adds	r2, r2, #1	@ ivtmp.165,
.L142:
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	ands	r3, r4	@ tmp158, keys
@ C_Code.c:364: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r7, r3, #1	@ tmp177, tmp158
	sbcs	r3, r3, r7	@ tmp176, tmp158, tmp177
	adds	r1, r1, r3	@ c, c, tmp176
@ C_Code.c:363: 	for (int i = 0; i < 6; ++i) { 
	cmp	r2, r5	@ ivtmp.165, _94
	bne	.L165		@,
@ C_Code.c:373: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r1, r6	@ tmp159, c, c
@ C_Code.c:373: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp159,
	ble	.L147		@,
.L153:
@ C_Code.c:373: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	movs	r0, #0	@ <retval>,
	b	.L136		@
.L167:
	.align	2
.L166:
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
@ C_Code.c:377: void SaveInputFrame(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r0	@ proc, tmp155
@ C_Code.c:378: 	struct Anim* anim = proc->anim; 
	ldr	r0, [r0, #44]	@ anim, proc_18(D)->anim
@ C_Code.c:379: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r5, [r0, #32]	@ _1, anim_19->pScrCurrent
@ C_Code.c:379: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r2, [r5]	@ instruction, *_1
@ C_Code.c:379: 	u32 instruction = *anim->pScrCurrent++; 
	adds	r3, r5, #4	@ tmp130, _1,
	str	r3, [r0, #32]	@ tmp130, anim_19->pScrCurrent
@ C_Code.c:380: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	lsls	r3, r2, #2	@ tmp132, instruction,
	lsrs	r3, r3, #26	@ tmp133, tmp132,
@ C_Code.c:380: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	cmp	r3, #5	@ tmp133,
	beq	.L175		@,
.L169:
@ C_Code.c:388: 	instruction = *anim->pScrCurrent--; 
	str	r5, [r0, #32]	@ _1, anim_19->pScrCurrent
@ C_Code.c:389: 	if (PressedSpecificKeys(proc, keys)) { 
	movs	r0, r4	@, proc
	bl	PressedSpecificKeys		@
@ C_Code.c:389: 	if (PressedSpecificKeys(proc, keys)) { 
	cmp	r0, #0	@ tmp157,
	beq	.L168		@,
@ C_Code.c:390: 		if (!proc->frame) { 
	movs	r3, #75	@ tmp147,
@ C_Code.c:390: 		if (!proc->frame) { 
	ldrb	r2, [r4, r3]	@ tmp148,
	cmp	r2, #0	@ tmp148,
	beq	.L176		@,
.L168:
@ C_Code.c:395: }  
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L175:
@ C_Code.c:381: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	adds	r3, r3, #250	@ tmp134,
	ands	r3, r2	@ _5, instruction
@ C_Code.c:381: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	cmp	r3, #4	@ _5,
	beq	.L177		@,
@ C_Code.c:384: 		if (ANINS_COMMAND_GET_ID(instruction) == 0xF) {
	cmp	r3, #15	@ _5,
	bne	.L169		@,
@ C_Code.c:385: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_18(D)->timer, proc_18(D)->timer
	adds	r3, r3, #62	@ tmp143,
	strb	r2, [r4, r3]	@ proc_18(D)->timer, proc_18(D)->codefframe
@ C_Code.c:385: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	movs	r2, #0	@ tmp145,
	subs	r3, r3, #9	@ tmp144,
	strb	r2, [r4, r3]	@ tmp145, proc_18(D)->timer2
	b	.L169		@
.L176:
@ C_Code.c:392: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	movs	r1, #128	@,
	movs	r0, #159	@,
@ C_Code.c:391: 			proc->frame = proc->timer; // locate is side for stereo? 
	ldr	r2, [r4, #52]	@ proc_18(D)->timer, proc_18(D)->timer
@ C_Code.c:392: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r1, r1, #1	@,,
@ C_Code.c:391: 			proc->frame = proc->timer; // locate is side for stereo? 
	strb	r2, [r4, r3]	@ proc_18(D)->timer, proc_18(D)->frame
@ C_Code.c:392: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r0, r0, #1	@,,
	movs	r2, #120	@,
	ldr	r4, .L178	@ tmp154,
	subs	r3, r3, #74	@,
	bl	.L180		@
@ C_Code.c:395: }  
	b	.L168		@
.L177:
@ C_Code.c:382: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_18(D)->timer, proc_18(D)->timer
	adds	r3, r3, #72	@ tmp137,
	strb	r2, [r4, r3]	@ proc_18(D)->timer, proc_18(D)->code4frame
@ C_Code.c:382: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	movs	r2, #0	@ tmp139,
	subs	r3, r3, #8	@ tmp138,
	strb	r2, [r4, r3]	@ tmp139, proc_18(D)->timer2
	b	.L169		@
.L179:
	.align	2
.L178:
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
@ C_Code.c:397: 	if (proc->frame) { 
	movs	r3, #75	@ tmp127,
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:396: void SaveIfWeHitOnTime(TimedHitsProc* proc) {
	push	{r4, lr}	@
@ C_Code.c:397: 	if (proc->frame) { 
	cmp	r3, #0	@ _1,
	beq	.L181		@,
@ C_Code.c:398: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #77	@ tmp128,
@ C_Code.c:398: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, .L192	@ tmp129,
@ C_Code.c:398: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldrb	r2, [r0, r2]	@ _2,
@ C_Code.c:398: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, [r1]	@ pretmp_32, LenienceFrames
@ C_Code.c:398: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, #255	@ _2,
	beq	.L184		@,
.L191:
@ C_Code.c:398: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	subs	r2, r2, r3	@ tmp130, _2, _1
	asrs	r4, r2, #31	@ tmp146, tmp130,
	adds	r2, r2, r4	@ tmp131, tmp130, tmp146
	eors	r2, r4	@ tmp131, tmp146
@ C_Code.c:398: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, r1	@ tmp131, pretmp_32
	bge	.L185		@,
@ C_Code.c:398: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #69	@ tmp132,
	movs	r4, #1	@ tmp133,
	strb	r4, [r0, r2]	@ tmp133, proc_21(D)->hitOnTime
.L185:
@ C_Code.c:400: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	ldr	r2, [r0, #52]	@ proc_21(D)->timer, proc_21(D)->timer
	subs	r3, r2, r3	@ tmp138, proc_21(D)->timer, _1
@ C_Code.c:400: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	cmp	r3, r1	@ tmp138, pretmp_32
	bge	.L181		@,
@ C_Code.c:400: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	movs	r3, #69	@ tmp140,
	movs	r2, #1	@ tmp141,
	strb	r2, [r0, r3]	@ tmp141, proc_21(D)->hitOnTime
.L181:
@ C_Code.c:403: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L184:
@ C_Code.c:399: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	movs	r2, #76	@ tmp135,
	ldrb	r2, [r0, r2]	@ _8,
@ C_Code.c:399: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	cmp	r2, #255	@ _8,
	bne	.L191		@,
	b	.L185		@
.L193:
	.align	2
.L192:
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
@ C_Code.c:406: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L195	@ tmp117,
@ C_Code.c:407: } 
	@ sp needed	@
@ C_Code.c:406: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldrb	r0, [r3, #31]	@ tmp119,
	movs	r3, #127	@ tmp121,
	bics	r0, r3	@ tmp116, tmp121
@ C_Code.c:407: } 
	bx	lr
.L196:
	.align	2
.L195:
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
@ C_Code.c:406: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L201	@ tmp119,
@ C_Code.c:410: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp122,
	cmp	r3, #127	@ tmp122,
	bhi	.L200		@,
@ C_Code.c:411: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L201+4	@ tmp123,
@ C_Code.c:411: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L200		@,
@ C_Code.c:412: 	return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp125,
	ldrb	r0, [r0, r3]	@ <retval>,
	b	.L197		@
.L200:
@ C_Code.c:410: 	if (CheatCodeOn()) { return true; } 
	movs	r0, #1	@ <retval>,
.L197:
@ C_Code.c:413: }
	@ sp needed	@
	bx	lr
.L202:
	.align	2
.L201:
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ C_Code.c:416: 	if (!DisplayPress) { return; } 
	ldr	r4, .L208	@ tmp118,
@ C_Code.c:416: 	if (!DisplayPress) { return; } 
	ldr	r4, [r4]	@ DisplayPress, DisplayPress
	cmp	r4, #0	@ DisplayPress,
	beq	.L203		@,
	bl	DrawButtonsToPress.part.0		@
.L203:
@ C_Code.c:454: } 
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L209:
	.align	2
.L208:
	.word	DisplayPress
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
@ C_Code.c:540: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp130,
	movs	r3, #192	@ tmp131,
	ldrsb	r1, [r0, r1]	@ tmp130,
	ands	r3, r1	@ _6, tmp130
@ C_Code.c:539: 	if (success) { 
	cmp	r2, #0	@ tmp163,
	beq	.L211		@,
@ C_Code.c:540: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _6,
	beq	.L219		@,
@ C_Code.c:544: 		if (!TimedHitsDifficultyRam->alwaysA) { 
	ldr	r3, .L220	@ tmp135,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam.25_16, TimedHitsDifficultyRam
@ C_Code.c:544: 		if (!TimedHitsDifficultyRam->alwaysA) { 
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.25_16, *TimedHitsDifficultyRam.25_16
@ C_Code.c:544: 		if (!TimedHitsDifficultyRam->alwaysA) { 
	lsls	r2, r3, #26	@ tmp164, *TimedHitsDifficultyRam.25_16,
	bmi	.L214		@,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r2, .L220+4	@ tmp145,
	ldr	r2, [r2]	@ DifficultyThreshold.27_21, DifficultyThreshold
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	lsls	r3, r3, #27	@ tmp150, *TimedHitsDifficultyRam.25_16,
	lsrs	r3, r3, #27	@ tmp151, tmp150,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	cmp	r3, r2	@ tmp151, DifficultyThreshold.27_21
	bge	.L215		@,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r3, .L220+8	@ tmp153,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r2, r3	@ DifficultyThreshold.27_21, NumberOfRandomButtons
	bgt	.L214		@,
.L215:
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r2, .L220+12	@ tmp155,
	ldr	r3, .L220+16	@ tmp156,
	ldr	r0, [r2]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r3, [r3]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r0, r0, r3	@ <retval>, BonusDamagePercent, DifficultyBonusPercent
	b	.L210		@
.L211:
@ C_Code.c:549: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _6,
	beq	.L217		@,
@ C_Code.c:552: 	return FailedHitDamagePercent; 
	ldr	r3, .L220+20	@ tmp160,
	ldr	r0, [r3]	@ <retval>,
.L210:
@ C_Code.c:553: } 
	@ sp needed	@
	bx	lr
.L219:
@ C_Code.c:541: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L220+24	@ tmp132,
@ C_Code.c:541: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L217		@,
@ C_Code.c:541: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L220+28	@ tmp134,
	ldr	r0, [r3]	@ <retval>,
	b	.L210		@
.L214:
@ C_Code.c:547: 		return BonusDamagePercent; 
	ldr	r3, .L220+12	@ tmp159,
	ldr	r0, [r3]	@ <retval>,
	b	.L210		@
.L217:
@ C_Code.c:542: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
	b	.L210		@
.L221:
	.align	2
.L220:
	.word	TimedHitsDifficultyRam
	.word	DifficultyThreshold
	.word	NumberOfRandomButtons
	.word	BonusDamagePercent
	.word	DifficultyBonusPercent
	.word	FailedHitDamagePercent
	.word	BlockingEnabled
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
@ C_Code.c:540: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp130,
	movs	r3, #192	@ tmp131,
	ldrsb	r1, [r0, r1]	@ tmp130,
	ands	r3, r1	@ _11, tmp130
@ C_Code.c:539: 	if (success) { 
	cmp	r2, #0	@ tmp163,
	beq	.L223		@,
@ C_Code.c:540: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _11,
	beq	.L231		@,
@ C_Code.c:544: 		if (!TimedHitsDifficultyRam->alwaysA) { 
	ldr	r3, .L232	@ tmp135,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam.25_17, TimedHitsDifficultyRam
@ C_Code.c:544: 		if (!TimedHitsDifficultyRam->alwaysA) { 
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.25_17, *TimedHitsDifficultyRam.25_17
@ C_Code.c:544: 		if (!TimedHitsDifficultyRam->alwaysA) { 
	lsls	r2, r3, #26	@ tmp164, *TimedHitsDifficultyRam.25_17,
	bmi	.L226		@,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r2, .L232+4	@ tmp145,
	ldr	r2, [r2]	@ DifficultyThreshold.27_22, DifficultyThreshold
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	lsls	r3, r3, #27	@ tmp150, *TimedHitsDifficultyRam.25_17,
	lsrs	r3, r3, #27	@ tmp151, tmp150,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	cmp	r3, r2	@ tmp151, DifficultyThreshold.27_22
	bge	.L227		@,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r3, .L232+8	@ tmp153,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r2, r3	@ DifficultyThreshold.27_22, NumberOfRandomButtons
	bgt	.L226		@,
.L227:
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r2, .L232+12	@ tmp155,
	ldr	r3, .L232+16	@ tmp156,
	ldr	r0, [r2]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r3, [r3]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r0, r0, r3	@ <retval>, BonusDamagePercent, DifficultyBonusPercent
	b	.L222		@
.L223:
@ C_Code.c:549: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _11,
	beq	.L229		@,
@ C_Code.c:552: 	return FailedHitDamagePercent; 
	ldr	r3, .L232+20	@ tmp160,
	ldr	r0, [r3]	@ <retval>,
.L222:
@ C_Code.c:557: } 
	@ sp needed	@
	bx	lr
.L231:
@ C_Code.c:541: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L232+24	@ tmp132,
@ C_Code.c:541: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L229		@,
@ C_Code.c:541: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L232+28	@ tmp134,
	ldr	r0, [r3]	@ <retval>,
	b	.L222		@
.L226:
@ C_Code.c:547: 		return BonusDamagePercent; 
	ldr	r3, .L232+12	@ tmp159,
	ldr	r0, [r3]	@ <retval>,
	b	.L222		@
.L229:
@ C_Code.c:542: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
@ C_Code.c:556: 	return GetDefaultDamagePercent(active_bunit, opp_bunit, success); 
	b	.L222		@
.L233:
	.align	2
.L232:
	.word	TimedHitsDifficultyRam
	.word	DifficultyThreshold
	.word	NumberOfRandomButtons
	.word	BonusDamagePercent
	.word	DifficultyBonusPercent
	.word	FailedHitDamagePercent
	.word	BlockingEnabled
	.word	ReducedDamagePercent
	.size	GetDamagePercent, .-GetDamagePercent
	.align	1
	.p2align 2,,3
	.global	AdjustCurrentRound
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	AdjustCurrentRound, %function
AdjustCurrentRound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}	@
@ C_Code.c:570: 	for (int i = id; i < 22; i += 2) {
	cmp	r0, #21	@ id,
	bgt	.L234		@,
	ldr	r3, .L244	@ tmp127,
	lsls	r2, r0, #1	@ tmp126, id,
@ C_Code.c:572: 		if (hp == 0xffff) { break; }
	ldr	r5, .L244+4	@ tmp128,
	adds	r2, r2, r3	@ ivtmp.225, tmp126, tmp127
	b	.L238		@
.L236:
	movs	r4, #0	@ _4,
@ C_Code.c:574: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	cmp	r3, r1	@ _1, difference
	blt	.L237		@,
@ C_Code.c:574: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	subs	r3, r3, r1	@ tmp131, _1, difference
.L242:
	lsls	r3, r3, #16	@ tmp132, tmp131,
	lsrs	r4, r3, #16	@ _4, tmp132,
.L237:
@ C_Code.c:570: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:573: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_23]
@ C_Code.c:570: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.225,
	cmp	r0, #21	@ id,
	bgt	.L234		@,
.L238:
@ C_Code.c:571: 		hp = gEfxHpLut[i]; 
	ldrh	r3, [r2]	@ _1, MEM[(short unsigned int *)_23]
@ C_Code.c:572: 		if (hp == 0xffff) { break; }
	cmp	r3, r5	@ _1, tmp128
	beq	.L234		@,
@ C_Code.c:573: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r1, #0	@ difference,
	bge	.L236		@,
@ C_Code.c:573: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	adds	r3, r3, r1	@ hp, _1, difference
	movs	r4, #0	@ _4,
@ C_Code.c:573: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r3, #0	@ hp,
	bgt	.L242		@,
@ C_Code.c:570: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:573: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_23]
@ C_Code.c:570: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.225,
	cmp	r0, #21	@ id,
	ble	.L238		@,
.L234:
@ C_Code.c:578: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L245:
	.align	2
.L244:
	.word	gEfxHpLut
	.word	65535
	.size	AdjustCurrentRound, .-AdjustCurrentRound
	.align	1
	.p2align 2,,3
	.global	UpdateHP
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	UpdateHP, %function
UpdateHP:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
	cmp	r3, #127	@ newHp,
	ble	.L247		@,
	movs	r3, #127	@ _8,
.L248:
@ C_Code.c:584: 	int hp = gEkrGaugeHp[side];
	ldr	r5, [sp, #16]	@ tmp165, side
	ldr	r4, .L258	@ tmp133,
	lsls	r5, r5, #1	@ tmp134, tmp165,
	ldrsh	r4, [r5, r4]	@ _1, gEkrGaugeHp
@ C_Code.c:585: 	some_bunit->unit.curHP = newHp; 
	strb	r3, [r2, #19]	@ _8, some_bunit_21(D)->unit.curHP
@ C_Code.c:586: 	if (hp == newHp) { return; } 
	cmp	r3, r4	@ _8, _1
	beq	.L246		@,
@ C_Code.c:588: 	if (newDamage) { diff = 0 - newDamage; }
	ldr	r2, [sp, #20]	@ tmp166, newDamage
	rsbs	r5, r2, #0	@ diff, tmp166
@ C_Code.c:588: 	if (newDamage) { diff = 0 - newDamage; }
	cmp	r2, #0	@ tmp167,
	beq	.L256		@,
@ C_Code.c:590: 	if (proc->side == side) { 
	movs	r2, #74	@ tmp136,
@ C_Code.c:590: 	if (proc->side == side) { 
	ldr	r6, [sp, #16]	@ tmp168, side
@ C_Code.c:590: 	if (proc->side == side) { 
	ldrb	r2, [r0, r2]	@ tmp137,
@ C_Code.c:590: 	if (proc->side == side) { 
	cmp	r2, r6	@ tmp137, tmp168
	beq	.L257		@,
.L246:
@ C_Code.c:604: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L247:
	mvns	r4, r3	@ tmp153, newHp
	asrs	r4, r4, #31	@ tmp152, tmp153,
	ands	r3, r4	@ _8, tmp152
	b	.L248		@
.L256:
@ C_Code.c:590: 	if (proc->side == side) { 
	movs	r2, #74	@ tmp136,
@ C_Code.c:590: 	if (proc->side == side) { 
	ldr	r6, [sp, #16]	@ tmp168, side
@ C_Code.c:590: 	if (proc->side == side) { 
	ldrb	r2, [r0, r2]	@ tmp137,
@ C_Code.c:587: 	int diff = newHp - hp; 
	subs	r5, r3, r4	@ diff, _8, _1
@ C_Code.c:590: 	if (proc->side == side) { 
	cmp	r2, r6	@ tmp137, tmp168
	bne	.L246		@,
.L257:
@ C_Code.c:592: 		if (UsingSkillSys) { // uggggh 
	ldr	r2, .L258+4	@ tmp139,
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	asrs	r6, r5, #31	@ tmp161, diff,
@ C_Code.c:591: 		HpProc->cur = hp; 
	strh	r4, [r1, #46]	@ _1, HpProc_27(D)->cur
@ C_Code.c:592: 		if (UsingSkillSys) { // uggggh 
	ldr	r4, [r2]	@ UsingSkillSys.32_5, UsingSkillSys
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	adds	r2, r5, r6	@ tmp140, diff, tmp161
	eors	r2, r6	@ tmp140, tmp161
@ C_Code.c:593: 			HpProc->post = newHp;
	lsls	r3, r3, #16	@ _42, _8,
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	lsls	r2, r2, #24	@ tmp141, tmp140,
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	ldr	r0, [r0, #56]	@ pretmp_37, proc_26(D)->currentRound
@ C_Code.c:593: 			HpProc->post = newHp;
	asrs	r3, r3, #16	@ _42, _42,
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	asrs	r2, r2, #24	@ _35, tmp141,
@ C_Code.c:592: 		if (UsingSkillSys) { // uggggh 
	cmp	r4, #0	@ UsingSkillSys.32_5,
	beq	.L254		@,
@ C_Code.c:593: 			HpProc->post = newHp;
	movs	r6, #80	@ tmp142,
	strh	r3, [r1, r6]	@ _42, HpProc_27(D)->post
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	strb	r2, [r0, #3]	@ _35, pretmp_37->hpChange
@ C_Code.c:602: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	cmp	r4, #2	@ UsingSkillSys.32_5,
	bne	.L246		@,
@ C_Code.c:602: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	strh	r5, [r0, #6]	@ diff, pretmp_37->overDmg
	b	.L246		@
.L254:
@ C_Code.c:597: 			HpProc->postHpAtkrSS = newHp>>16; 
	movs	r5, #82	@ tmp145,
	strh	r4, [r1, r5]	@ UsingSkillSys.32_5, HpProc_27(D)->postHpAtkrSS
@ C_Code.c:598: 			HpProc->post = newHp; 
	movs	r4, #80	@ tmp148,
	strh	r3, [r1, r4]	@ _42, HpProc_27(D)->post
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	strb	r2, [r0, #3]	@ _35, pretmp_37->hpChange
	b	.L246		@
.L259:
	.align	2
.L258:
	.word	gEkrGaugeHp
	.word	UsingSkillSys
	.size	UpdateHP, .-UpdateHP
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
	@ args = 12, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r8	@,
	movs	r7, r2	@ active_bunit, tmp281
	movs	r2, r3	@ opp_bunit, tmp282
@ C_Code.c:609: 	int side = proc->side; 
	movs	r3, #74	@ tmp175,
@ C_Code.c:608: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp, int newDamage) { 
	push	{lr}	@
	sub	sp, sp, #8	@,,
@ C_Code.c:608: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp, int newDamage) { 
	movs	r6, r1	@ HpProc, tmp280
@ C_Code.c:609: 	int side = proc->side; 
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:608: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp, int newDamage) { 
	ldr	r1, [sp, #36]	@ hp, hp
	movs	r5, r0	@ proc, tmp279
@ C_Code.c:609: 	int side = proc->side; 
	mov	r8, r3	@ _1, _1
@ C_Code.c:611: 	if (hp < 0) { hp = gEkrGaugeHp[side]; } 
	cmp	r1, #0	@ hp,
	bge	.L261		@,
@ C_Code.c:611: 	if (hp < 0) { hp = gEkrGaugeHp[side]; } 
	mov	r1, r8	@ _1, _1
	ldr	r3, .L295	@ tmp176,
	lsls	r1, r1, #1	@ tmp177, _1,
@ C_Code.c:611: 	if (hp < 0) { hp = gEkrGaugeHp[side]; } 
	ldrsh	r1, [r1, r3]	@ hp, gEkrGaugeHp
.L261:
@ C_Code.c:612: 	if (hp <= 0) { // they are dead 
	cmp	r1, #0	@ hp,
	ble	.L291		@,
@ C_Code.c:657: 		HpProc->death = false; 
	movs	r3, #41	@ tmp241,
	movs	r2, #0	@ tmp242,
	strb	r2, [r6, r3]	@ tmp242, HpProc_43(D)->death
.L270:
@ C_Code.c:663: 	struct Unit* unit = GetUnit(gBattleActor.unit.index);
	movs	r0, #11	@ tmp245,
@ C_Code.c:663: 	struct Unit* unit = GetUnit(gBattleActor.unit.index);
	ldr	r5, .L295+4	@ tmp244,
@ C_Code.c:663: 	struct Unit* unit = GetUnit(gBattleActor.unit.index);
	ldr	r4, .L295+8	@ tmp273,
	ldrsb	r0, [r5, r0]	@ tmp245,
	bl	.L180		@
@ C_Code.c:664: 	if (UNIT_IS_VALID(unit)) { 
	cmp	r0, #0	@ unit,
	beq	.L274		@,
@ C_Code.c:664: 	if (UNIT_IS_VALID(unit)) { 
	ldr	r3, [r0]	@ unit_68->pCharacterData, unit_68->pCharacterData
	cmp	r3, #0	@ unit_68->pCharacterData,
	beq	.L274		@,
@ C_Code.c:665: 		gBattleActor.unit.exp = unit->exp; 
	ldrb	r3, [r0, #9]	@ _18,
@ C_Code.c:665: 		gBattleActor.unit.exp = unit->exp; 
	strb	r3, [r5, #9]	@ _18, gBattleActor.unit.exp
@ C_Code.c:666: 		gBattleActor.unit.level = unit->level; 
	movs	r3, #8	@ _19,
	ldrsb	r3, [r0, r3]	@ _19,* _19
@ C_Code.c:666: 		gBattleActor.unit.level = unit->level; 
	strb	r3, [r5, #8]	@ _19, gBattleActor.unit.level
.L274:
@ C_Code.c:669: 	unit = GetUnit(gBattleTarget.unit.index); 
	movs	r0, #11	@ tmp253,
@ C_Code.c:669: 	unit = GetUnit(gBattleTarget.unit.index); 
	ldr	r5, .L295+12	@ tmp252,
@ C_Code.c:669: 	unit = GetUnit(gBattleTarget.unit.index); 
	ldrsb	r0, [r5, r0]	@ tmp253,
	bl	.L180		@
@ C_Code.c:670: 	if (UNIT_IS_VALID(unit)) { 
	cmp	r0, #0	@ unit,
	beq	.L275		@,
@ C_Code.c:670: 	if (UNIT_IS_VALID(unit)) { 
	ldr	r3, [r0]	@ unit_72->pCharacterData, unit_72->pCharacterData
	cmp	r3, #0	@ unit_72->pCharacterData,
	beq	.L275		@,
@ C_Code.c:671: 		gBattleTarget.unit.exp = unit->exp; 
	ldrb	r3, [r0, #9]	@ _23,
@ C_Code.c:671: 		gBattleTarget.unit.exp = unit->exp; 
	strb	r3, [r5, #9]	@ _23, gBattleTarget.unit.exp
@ C_Code.c:672: 		gBattleTarget.unit.level = unit->level; 
	movs	r3, #8	@ _24,
	ldrsb	r3, [r0, r3]	@ _24,* _24
@ C_Code.c:672: 		gBattleTarget.unit.level = unit->level; 
	strb	r3, [r5, #8]	@ _24, gBattleTarget.unit.level
.L275:
@ C_Code.c:676: 	BattleApplyExpGains();  // update exp 
	ldr	r3, .L295+16	@ tmp260,
	bl	.L10		@
@ C_Code.c:677: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	ldr	r2, .L295+20	@ tmp263,
	ldr	r1, [r2]	@ gpEkrBattleUnitLeft, gpEkrBattleUnitLeft
	movs	r2, #110	@ tmp264,
@ C_Code.c:677: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	ldr	r3, .L295+24	@ tmp261,
@ C_Code.c:677: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	ldrsb	r1, [r1, r2]	@ tmp266,
@ C_Code.c:677: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	strh	r1, [r3]	@ tmp266, gBanimExpGain[0]
@ C_Code.c:678: 	gBanimExpGain[1] = gpEkrBattleUnitRight->expGain; 
	ldr	r1, .L295+28	@ tmp269,
	ldr	r1, [r1]	@ gpEkrBattleUnitRight, gpEkrBattleUnitRight
	ldrsb	r2, [r1, r2]	@ tmp272,
@ C_Code.c:678: 	gBanimExpGain[1] = gpEkrBattleUnitRight->expGain; 
	strh	r2, [r3, #2]	@ tmp272, gBanimExpGain[1]
@ C_Code.c:680: }
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L291:
@ C_Code.c:614: 		UpdateHP(proc, HpProc, opp_bunit, hp, side, newDamage); 
	ldr	r3, [sp, #40]	@ tmp299, newDamage
	str	r3, [sp, #4]	@ tmp299,
	mov	r3, r8	@ _1, _1
	movs	r1, r6	@, HpProc
	movs	r0, r5	@, proc
	str	r3, [sp]	@ _1,
	movs	r3, #0	@,
	bl	UpdateHP		@
@ C_Code.c:616: 		proc->code4frame = 0xff;
	movs	r3, #76	@ tmp178,
	movs	r2, #255	@ tmp179,
@ C_Code.c:634: 		struct SkillSysBattleHit* nextRound = GetCurrentRound(proc->roundId + 1); 
	movs	r4, #70	@ tmp191,
@ C_Code.c:616: 		proc->code4frame = 0xff;
	strb	r2, [r5, r3]	@ tmp179, proc_39(D)->code4frame
@ C_Code.c:621: 		HpProc->death = true; 
	subs	r3, r3, #35	@ tmp181,
	subs	r2, r2, #254	@ tmp182,
	strb	r2, [r6, r3]	@ tmp182, HpProc_43(D)->death
@ C_Code.c:632: 		round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END; 
	ldr	r3, [sp, #32]	@ tmp301, round
	ldrb	r3, [r3, #2]	@ tmp187,
	adds	r2, r2, #175	@ tmp184,
	orrs	r3, r2	@ tmp189, tmp184
	ldr	r2, [sp, #32]	@ tmp302, round
	strb	r3, [r2, #2]	@ tmp189,
@ C_Code.c:634: 		struct SkillSysBattleHit* nextRound = GetCurrentRound(proc->roundId + 1); 
	ldrb	r0, [r5, r4]	@ tmp192,
@ C_Code.c:634: 		struct SkillSysBattleHit* nextRound = GetCurrentRound(proc->roundId + 1); 
	ldr	r3, .L295+32	@ tmp194,
	adds	r0, r0, #1	@ tmp193,
	bl	.L10		@
@ C_Code.c:635: 		nextRound->info = BATTLE_HIT_INFO_END; 
	movs	r3, #7	@ tmp200,
	ldrh	r2, [r0, #2]	@ MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B], MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B]
	ands	r3, r2	@ tmp199, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B]
	movs	r2, #128	@ tmp201,
	orrs	r3, r2	@ tmp204, tmp201
	strh	r3, [r0, #2]	@ tmp204, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B]
@ C_Code.c:639: 		u16* animRound = &GetAnimRoundData()[0]; 
	ldr	r3, .L295+36	@ tmp206,
	bl	.L10		@
@ C_Code.c:640: 		for (int i = proc->roundId; i < 32; ++i) { 
	ldrb	r3, [r5, r4]	@ i,
@ C_Code.c:640: 		for (int i = proc->roundId; i < 32; ++i) { 
	cmp	r3, #31	@ i,
	bgt	.L266		@,
@ C_Code.c:642: 			animRound[i] = 0xFFFF; 
	movs	r2, #1	@ tmp278,
	rsbs	r2, r2, #0	@ tmp278, tmp278
	mov	ip, r2	@ tmp278, tmp278
@ C_Code.c:641: 			if (animRound[i] == 0xFFFF) { break; } 
	ldr	r1, .L295+40	@ tmp221,
	b	.L263		@
.L292:
@ C_Code.c:642: 			animRound[i] = 0xFFFF; 
	mov	r2, ip	@ tmp278, tmp278
@ C_Code.c:640: 		for (int i = proc->roundId; i < 32; ++i) { 
	adds	r3, r3, #1	@ i,
@ C_Code.c:642: 			animRound[i] = 0xFFFF; 
	strh	r2, [r0, r4]	@ tmp278, MEM[(u16 *)animRound_58 + _122 * 1]
@ C_Code.c:640: 		for (int i = proc->roundId; i < 32; ++i) { 
	cmp	r3, #32	@ i,
	beq	.L266		@,
.L263:
	lsls	r4, r3, #1	@ _122, i,
@ C_Code.c:641: 			if (animRound[i] == 0xFFFF) { break; } 
	ldrh	r2, [r0, r4]	@ MEM[(u16 *)animRound_58 + _122 * 1], MEM[(u16 *)animRound_58 + _122 * 1]
	cmp	r2, r1	@ MEM[(u16 *)animRound_58 + _122 * 1], tmp221
	bne	.L292		@,
.L266:
@ C_Code.c:649: 		side = 1 ^ side; 
	movs	r2, #1	@ tmp211,
	mov	r3, r8	@ _1, _1
	eors	r3, r2	@ _1, tmp211
	movs	r2, r3	@ side, _1
@ C_Code.c:650: 		hp = gEkrGaugeHp[side];
	ldr	r3, .L295	@ tmp212,
	lsls	r1, r2, #1	@ tmp213, side,
	ldrsh	r1, [r1, r3]	@ _13, gEkrGaugeHp
@ C_Code.c:651: 		if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL) { hp += newDamage; } 
	ldr	r3, [sp, #32]	@ tmp305, round
	ldr	r0, [r3]	@ *round_51(D), *round_51(D)
@ C_Code.c:651: 		if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL) { hp += newDamage; } 
	ldr	r3, [sp, #40]	@ tmp306, newDamage
	adds	r3, r3, r1	@ hp, tmp306, _13
@ C_Code.c:651: 		if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL) { hp += newDamage; } 
	lsls	r0, r0, #23	@ tmp289, *round_51(D),
	bpl	.L293		@,
	cmp	r3, #127	@ hp,
	bgt	.L294		@,
.L267:
	mvns	r0, r3	@ tmp275, hp
	asrs	r0, r0, #31	@ tmp274, tmp275,
	ands	r3, r0	@ _80, tmp274
.L268:
@ C_Code.c:585: 	some_bunit->unit.curHP = newHp; 
	strb	r3, [r7, #19]	@ _80, active_bunit_65(D)->unit.curHP
@ C_Code.c:586: 	if (hp == newHp) { return; } 
	cmp	r1, r3	@ _13, _80
	bne	.LCB1700	@
	b	.L270	@long jump	@
.LCB1700:
@ C_Code.c:590: 	if (proc->side == side) { 
	movs	r0, #74	@ tmp225,
	ldrb	r0, [r5, r0]	@ tmp226,
@ C_Code.c:590: 	if (proc->side == side) { 
	cmp	r2, r0	@ side, tmp226
	beq	.LCB1704	@
	b	.L270	@long jump	@
.LCB1704:
@ C_Code.c:587: 	int diff = newHp - hp; 
	subs	r4, r3, r1	@ diff, _80, _13
@ C_Code.c:592: 		if (UsingSkillSys) { // uggggh 
	ldr	r2, .L295+44	@ tmp228,
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	ldr	r0, [r5, #56]	@ pretmp_125, proc_39(D)->currentRound
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	asrs	r5, r4, #31	@ tmp290, diff,
@ C_Code.c:591: 		HpProc->cur = hp; 
	strh	r1, [r6, #46]	@ _13, HpProc_43(D)->cur
@ C_Code.c:592: 		if (UsingSkillSys) { // uggggh 
	ldr	r1, [r2]	@ UsingSkillSys.32_88, UsingSkillSys
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	adds	r2, r4, r5	@ tmp229, diff, tmp290
	eors	r2, r5	@ tmp229, tmp290
@ C_Code.c:593: 			HpProc->post = newHp;
	lsls	r3, r3, #16	@ _123, _80,
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	lsls	r2, r2, #24	@ tmp230, tmp229,
@ C_Code.c:593: 			HpProc->post = newHp;
	asrs	r3, r3, #16	@ _123, _123,
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	asrs	r2, r2, #24	@ _126, tmp230,
@ C_Code.c:592: 		if (UsingSkillSys) { // uggggh 
	cmp	r1, #0	@ UsingSkillSys.32_88,
	beq	.L272		@,
@ C_Code.c:593: 			HpProc->post = newHp;
	movs	r5, #80	@ tmp231,
	strh	r3, [r6, r5]	@ _123, HpProc_43(D)->post
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	strb	r2, [r0, #3]	@ _126, pretmp_125->hpChange
@ C_Code.c:602: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	cmp	r1, #2	@ UsingSkillSys.32_88,
	beq	.LCB1723	@
	b	.L270	@long jump	@
.LCB1723:
@ C_Code.c:602: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	strh	r4, [r0, #6]	@ diff, pretmp_125->overDmg
	b	.L270		@
.L294:
	movs	r3, #127	@ _80,
	b	.L268		@
.L293:
@ C_Code.c:650: 		hp = gEkrGaugeHp[side];
	movs	r3, r1	@ hp, _13
	cmp	r3, #127	@ hp,
	ble	.L267		@,
	b	.L294		@
.L272:
@ C_Code.c:597: 			HpProc->postHpAtkrSS = newHp>>16; 
	movs	r4, #82	@ tmp234,
	strh	r1, [r6, r4]	@ UsingSkillSys.32_88, HpProc_43(D)->postHpAtkrSS
@ C_Code.c:598: 			HpProc->post = newHp; 
	movs	r1, #80	@ tmp237,
	strh	r3, [r6, r1]	@ _123, HpProc_43(D)->post
@ C_Code.c:601: 		proc->currentRound->hpChange = ABS(diff); 
	strb	r2, [r0, #3]	@ _126, pretmp_125->hpChange
	b	.L270		@
.L296:
	.align	2
.L295:
	.word	gEkrGaugeHp
	.word	gBattleActor
	.word	GetUnit
	.word	gBattleTarget
	.word	BattleApplyExpGains
	.word	gpEkrBattleUnitLeft
	.word	gBanimExpGain
	.word	gpEkrBattleUnitRight
	.word	GetCurrentRound
	.word	GetAnimRoundData
	.word	65535
	.word	UsingSkillSys
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
	@ args = 8, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r6, r9	@,
	mov	r7, r10	@,
	mov	r5, r8	@,
	mov	lr, fp	@,
	push	{r5, r6, r7, lr}	@
	movs	r7, r3	@ opp_bunit, tmp228
@ C_Code.c:684: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r3, [r0, #56]	@ _1, proc_49(D)->currentRound
	mov	r9, r3	@ _1, _1
@ C_Code.c:684: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r3, [r3]	@ *_1, *_1
	lsls	r3, r3, #13	@ tmp162, *_1,
@ C_Code.c:682: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	movs	r6, r2	@ active_bunit, tmp227
	movs	r4, r0	@ proc, tmp225
	movs	r5, r1	@ HpProc, tmp226
	sub	sp, sp, #36	@,,
@ C_Code.c:684: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsrs	r2, r3, #13	@ _2, tmp162,
@ C_Code.c:684: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsls	r3, r3, #17	@ tmp232, tmp162,
	bmi	.L297		@,
@ C_Code.c:684: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	mov	r3, r9	@ _1, _1
	ldrb	r3, [r3, #3]	@ tmp165,
	lsls	r3, r3, #24	@ tmp165, tmp165,
	asrs	r3, r3, #24	@ tmp165, tmp165,
	beq	.L297		@,
@ C_Code.c:685: 	if (round->hpChange <= 0) { return; } // healing 
	movs	r1, #3	@ _6,
	ldr	r3, [sp, #72]	@ tmp244, round
	ldrsb	r1, [r3, r1]	@ _6,* _6
@ C_Code.c:685: 	if (round->hpChange <= 0) { return; } // healing 
	cmp	r1, #0	@ _6,
	ble	.L297		@,
@ C_Code.c:686: 	int side = proc->side; 
	movs	r3, #74	@ tmp168,
	ldrb	r3, [r0, r3]	@ side,
	movs	r0, r3	@ side, side
	str	r3, [sp, #20]	@ side, %sfp
@ C_Code.c:687: 	int hp = gEkrGaugeHp[proc->side];
	ldr	r3, .L333	@ tmp169,
	lsls	r0, r0, #1	@ tmp170, side,
@ C_Code.c:687: 	int hp = gEkrGaugeHp[proc->side];
	ldrsh	r3, [r0, r3]	@ hp, gEkrGaugeHp
	str	r3, [sp, #24]	@ hp, %sfp
@ C_Code.c:688: 	if (!hp) { CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp, 0); return; } 
	cmp	r3, #0	@ hp,
	bne	.LCB1811	@
	b	.L330	@long jump	@
.LCB1811:
@ C_Code.c:692: 		if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage) { 
	movs	r3, #1	@ tmp178,
	ldr	r0, [sp, #20]	@ side, %sfp
@ C_Code.c:690: 	int oldDamage = round->hpChange;  
	mov	r8, r1	@ oldDamage, _6
@ C_Code.c:692: 		if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage) { 
	eors	r3, r0	@ tmp177, side
@ C_Code.c:692: 		if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage) { 
	ldr	r1, .L333+4	@ tmp173,
	lsls	r3, r3, #1	@ tmp179, tmp177,
	ldrsh	r3, [r3, r1]	@ pretmp_82, gEkrGaugeDmg
@ C_Code.c:691: 	if (proc->currentRound->attributes & BATTLE_HIT_ATTR_CRIT) { 
	lsls	r2, r2, #31	@ tmp233, _2,
	bpl	.L300		@,
@ C_Code.c:692: 		if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage) { 
	lsls	r2, r3, #1	@ tmp183, pretmp_82,
	adds	r3, r2, r3	@ tmp184, tmp183, pretmp_82
	cmp	r8, r3	@ oldDamage, tmp184
	blt	.L328		@,
.L302:
@ C_Code.c:699: 	if (UsingSkillSys == 2) { oldDamage = ABS(round->overDmg); } 
	ldr	r3, .L333+8	@ tmp186,
	ldr	r3, [r3]	@ UsingSkillSys.38_17, UsingSkillSys
	str	r3, [sp, #28]	@ UsingSkillSys.38_17, %sfp
@ C_Code.c:699: 	if (UsingSkillSys == 2) { oldDamage = ABS(round->overDmg); } 
	cmp	r3, #2	@ UsingSkillSys.38_17,
	bne	.L303		@,
@ C_Code.c:699: 	if (UsingSkillSys == 2) { oldDamage = ABS(round->overDmg); } 
	ldr	r3, [sp, #72]	@ tmp256, round
	movs	r2, #6	@ tmp240,
	ldrsh	r3, [r3, r2]	@ tmp187, tmp256, tmp240
	asrs	r2, r3, #31	@ tmp234, tmp187,
	adds	r3, r3, r2	@ tmp188, tmp187, tmp234
	eors	r3, r2	@ tmp188, tmp234
@ C_Code.c:699: 	if (UsingSkillSys == 2) { oldDamage = ABS(round->overDmg); } 
	lsls	r3, r3, #16	@ tmp189, tmp188,
	lsrs	r3, r3, #16	@ oldDamage, tmp189,
	mov	r8, r3	@ oldDamage, oldDamage
.L303:
@ C_Code.c:703: 	int newDamage = ((oldDamage * percent)) / 100; 
	ldr	r2, [sp, #76]	@ tmp259, percent
	mov	r3, r8	@ _20, oldDamage
	muls	r3, r2	@ _20, tmp259
	mov	r10, r3	@ _20, _20
@ C_Code.c:703: 	int newDamage = ((oldDamage * percent)) / 100; 
	ldr	r3, .L333+12	@ tmp193,
	movs	r1, #100	@,
	mov	r0, r10	@, _20
	mov	fp, r3	@ tmp193, tmp193
	bl	.L10		@
@ C_Code.c:704: 	if (newDamage >= oldDamage) { newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100; } 
	cmp	r8, r0	@ oldDamage, tmp229
	bgt	.L304		@,
@ C_Code.c:704: 	if (newDamage >= oldDamage) { newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100; } 
	ldr	r3, .L333+16	@ tmp195,
	ldr	r0, [r3]	@ BonusDamageRounding, BonusDamageRounding
@ C_Code.c:704: 	if (newDamage >= oldDamage) { newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100; } 
	movs	r1, #100	@,
@ C_Code.c:704: 	if (newDamage >= oldDamage) { newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100; } 
	add	r0, r0, r10	@ tmp196, _20
@ C_Code.c:704: 	if (newDamage >= oldDamage) { newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100; } 
	bl	.L66		@
.L305:
	mov	r10, r0	@ newDamage, newDamage
	cmp	r0, #0	@ newDamage,
	bgt	.L306		@,
	movs	r3, #1	@ newDamage,
	mov	r10, r3	@ newDamage, newDamage
.L306:
@ C_Code.c:707: 	int newHp = hp - newDamage; 
	mov	r2, r10	@ newDamage, newDamage
	ldr	r3, [sp, #24]	@ hp, %sfp
@ C_Code.c:708: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp212,
@ C_Code.c:707: 	int newHp = hp - newDamage; 
	subs	r2, r3, r2	@ newHp, hp, newDamage
@ C_Code.c:708: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r3, #192	@ tmp213,
	ldrsb	r1, [r6, r1]	@ tmp212,
	ands	r3, r1	@ tmp214, tmp212
@ C_Code.c:708: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ tmp214,
	beq	.L331		@,
.L307:
	mvns	r3, r2	@ tmp224, newHp
	asrs	r3, r3, #31	@ tmp223, tmp224,
	ands	r2, r3	@ newHp, tmp223
@ C_Code.c:718: 	if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) && (proc->currentRound->skillID)) { 
	ldr	r3, [sp, #28]	@ UsingSkillSys.38_17, %sfp
	mov	fp, r2	@ _3, newHp
	cmp	r3, #0	@ UsingSkillSys.38_17,
	beq	.L310		@,
@ C_Code.c:718: 	if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) && (proc->currentRound->skillID)) { 
	mov	r3, r9	@ _1, _1
@ C_Code.c:718: 	if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) && (proc->currentRound->skillID)) { 
	ldr	r2, .L333+20	@ tmp219,
@ C_Code.c:718: 	if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) && (proc->currentRound->skillID)) { 
	ldr	r2, [r2]	@ ProcSkillsStackWithTimedHits, ProcSkillsStackWithTimedHits
@ C_Code.c:718: 	if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) && (proc->currentRound->skillID)) { 
	ldrb	r3, [r3, #4]	@ pretmp_76,
@ C_Code.c:718: 	if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) && (proc->currentRound->skillID)) { 
	cmp	r2, #0	@ ProcSkillsStackWithTimedHits,
	beq	.L311		@,
@ C_Code.c:718: 	if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) && (proc->currentRound->skillID)) { 
	ldr	r2, .L333+24	@ tmp221,
@ C_Code.c:718: 	if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) && (proc->currentRound->skillID)) { 
	ldrb	r2, [r2, r3]	@ tmp222, SkillExceptionsTable
	cmp	r2, #0	@ tmp222,
	bne	.L311		@,
.L310:
@ C_Code.c:725: 	UpdateHP(proc, HpProc, opp_bunit, newHp, side, newDamage); 
	mov	r3, r10	@ newDamage, newDamage
	str	r3, [sp, #4]	@ newDamage,
	ldr	r3, [sp, #20]	@ side, %sfp
	movs	r2, r7	@, opp_bunit
	str	r3, [sp]	@ side,
	movs	r1, r5	@, HpProc
	mov	r3, fp	@, _3
	movs	r0, r4	@, proc
	bl	UpdateHP		@
@ C_Code.c:729: 	CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, newHp, newDamage); 
	mov	r3, r10	@ newDamage, newDamage
	str	r3, [sp, #8]	@ newDamage,
	mov	r3, fp	@ _3, _3
.L329:
	str	r3, [sp, #4]	@ _3,
	ldr	r3, [sp, #72]	@ tmp277, round
	movs	r2, r6	@, active_bunit
	str	r3, [sp]	@ tmp277,
	movs	r1, r5	@, HpProc
	movs	r3, r7	@, opp_bunit
	movs	r0, r4	@, proc
	bl	CheckForDeath		@
.L297:
@ C_Code.c:732: } 
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
.L300:
@ C_Code.c:697: 	else if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	mov	r2, r8	@ oldDamage, oldDamage
	lsls	r2, r2, #16	@ _6, oldDamage,
	asrs	r2, r2, #16	@ _6, _6,
	cmp	r2, r3	@ _6, pretmp_82
	bge	.L302		@,
.L328:
@ C_Code.c:697: 	else if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	mov	r8, r3	@ oldDamage, pretmp_82
	b	.L302		@
.L311:
@ C_Code.c:718: 	if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) && (proc->currentRound->skillID)) { 
	cmp	r3, #0	@ pretmp_76,
	beq	.L310		@,
@ C_Code.c:721: 		newHp = hp - oldDamage; 
	mov	r2, r8	@ oldDamage, oldDamage
	ldr	r3, [sp, #24]	@ hp, %sfp
	subs	r3, r3, r2	@ _3, hp, oldDamage
	mov	fp, r3	@ _3, _3
	mov	r10, r8	@ newDamage, oldDamage
	b	.L310		@
.L304:
@ C_Code.c:705: 	else { newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100; } 
	ldr	r3, .L333+28	@ tmp202,
	ldr	r0, [r3]	@ ReducedDamageRounding, ReducedDamageRounding
@ C_Code.c:705: 	else { newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100; } 
	ldr	r3, .L333+32	@ tmp205,
	ldr	r3, [r3]	@ ReducedDamageSubtract, ReducedDamageSubtract
@ C_Code.c:705: 	else { newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100; } 
	add	r0, r0, r10	@ tmp203, _20
@ C_Code.c:705: 	else { newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100; } 
	movs	r1, #100	@,
@ C_Code.c:705: 	else { newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100; } 
	subs	r0, r0, r3	@ tmp206, tmp203, ReducedDamageSubtract
@ C_Code.c:705: 	else { newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100; } 
	bl	.L66		@
	b	.L305		@
.L331:
@ C_Code.c:711: 			if ((hp - oldDamage) <= 0) { if (!BlockingCanPreventLethal) { newHp = hp - oldDamage; newDamage = oldDamage; } }
	mov	r1, r8	@ oldDamage, oldDamage
	ldr	r3, [sp, #24]	@ hp, %sfp
	subs	r3, r3, r1	@ _30, hp, oldDamage
@ C_Code.c:711: 			if ((hp - oldDamage) <= 0) { if (!BlockingCanPreventLethal) { newHp = hp - oldDamage; newDamage = oldDamage; } }
	cmp	r3, #0	@ _30,
	ble	.L332		@,
.L308:
@ C_Code.c:712: 			if (!BlockingEnabled) { newHp = hp - oldDamage; newDamage = oldDamage; } 
	ldr	r1, .L333+36	@ tmp217,
@ C_Code.c:712: 			if (!BlockingEnabled) { newHp = hp - oldDamage; newDamage = oldDamage; } 
	ldr	r1, [r1]	@ BlockingEnabled, BlockingEnabled
	cmp	r1, #0	@ BlockingEnabled,
	bne	.L307		@,
@ C_Code.c:711: 			if ((hp - oldDamage) <= 0) { if (!BlockingCanPreventLethal) { newHp = hp - oldDamage; newDamage = oldDamage; } }
	movs	r2, r3	@ newHp, _30
@ C_Code.c:712: 			if (!BlockingEnabled) { newHp = hp - oldDamage; newDamage = oldDamage; } 
	mov	r10, r8	@ newDamage, oldDamage
	b	.L307		@
.L330:
@ C_Code.c:688: 	if (!hp) { CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp, 0); return; } 
	str	r3, [sp, #8]	@ hp,
	b	.L329		@
.L332:
@ C_Code.c:711: 			if ((hp - oldDamage) <= 0) { if (!BlockingCanPreventLethal) { newHp = hp - oldDamage; newDamage = oldDamage; } }
	ldr	r1, .L333+40	@ tmp215,
@ C_Code.c:711: 			if ((hp - oldDamage) <= 0) { if (!BlockingCanPreventLethal) { newHp = hp - oldDamage; newDamage = oldDamage; } }
	ldr	r1, [r1]	@ BlockingCanPreventLethal, BlockingCanPreventLethal
	cmp	r1, #0	@ BlockingCanPreventLethal,
	bne	.L308		@,
@ C_Code.c:711: 			if ((hp - oldDamage) <= 0) { if (!BlockingCanPreventLethal) { newHp = hp - oldDamage; newDamage = oldDamage; } }
	movs	r2, r3	@ newHp, _30
	mov	r10, r8	@ newDamage, oldDamage
	b	.L308		@
.L334:
	.align	2
.L333:
	.word	gEkrGaugeHp
	.word	gEkrGaugeDmg
	.word	UsingSkillSys
	.word	__aeabi_idiv
	.word	BonusDamageRounding
	.word	ProcSkillsStackWithTimedHits
	.word	SkillExceptionsTable
	.word	ReducedDamageRounding
	.word	ReducedDamageSubtract
	.word	BlockingEnabled
	.word	BlockingCanPreventLethal
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
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}	@
@ C_Code.c:540: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r5, #11	@ tmp133,
	movs	r4, #192	@ tmp134,
	ldrsb	r5, [r2, r5]	@ tmp133,
@ C_Code.c:561: void AdjustDamageWithGetter(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int success) { 
	sub	sp, sp, #12	@,,
@ C_Code.c:540: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	ands	r4, r5	@ _15, tmp133
@ C_Code.c:539: 	if (success) { 
	ldr	r5, [sp, #28]	@ tmp172, success
	cmp	r5, #0	@ tmp172,
	beq	.L336		@,
@ C_Code.c:540: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _15,
	beq	.L344		@,
@ C_Code.c:544: 		if (!TimedHitsDifficultyRam->alwaysA) { 
	ldr	r4, .L345	@ tmp138,
	ldr	r4, [r4]	@ TimedHitsDifficultyRam.25_21, TimedHitsDifficultyRam
@ C_Code.c:544: 		if (!TimedHitsDifficultyRam->alwaysA) { 
	ldrb	r4, [r4]	@ *TimedHitsDifficultyRam.25_21, *TimedHitsDifficultyRam.25_21
@ C_Code.c:544: 		if (!TimedHitsDifficultyRam->alwaysA) { 
	lsls	r5, r4, #26	@ tmp168, *TimedHitsDifficultyRam.25_21,
	bmi	.L339		@,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r5, .L345+4	@ tmp148,
	ldr	r5, [r5]	@ DifficultyThreshold.27_26, DifficultyThreshold
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	lsls	r4, r4, #27	@ tmp153, *TimedHitsDifficultyRam.25_21,
	lsrs	r4, r4, #27	@ tmp154, tmp153,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	cmp	r4, r5	@ tmp154, DifficultyThreshold.27_26
	bge	.L340		@,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r4, .L345+8	@ tmp156,
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r4, [r4]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r5, r4	@ DifficultyThreshold.27_26, NumberOfRandomButtons
	bgt	.L339		@,
.L340:
@ C_Code.c:545: 			if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) || (NumberOfRandomButtons >= DifficultyThreshold)) { return BonusDamagePercent + DifficultyBonusPercent; } 
	ldr	r4, .L345+12	@ tmp158,
	ldr	r5, .L345+16	@ tmp159,
	ldr	r4, [r4]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r5, [r5]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r4, r4, r5	@ _19, BonusDamagePercent, DifficultyBonusPercent
	b	.L338		@
.L336:
@ C_Code.c:549: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _15,
	beq	.L342		@,
@ C_Code.c:552: 	return FailedHitDamagePercent; 
	ldr	r4, .L345+20	@ tmp163,
	ldr	r4, [r4]	@ _19,
.L338:
@ C_Code.c:563: 	AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);	
	str	r4, [sp, #4]	@ _19,
	ldr	r4, [sp, #24]	@ tmp173, round
	str	r4, [sp]	@ tmp173,
	bl	AdjustDamageByPercent		@
@ C_Code.c:564: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L344:
@ C_Code.c:541: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L345+24	@ tmp135,
@ C_Code.c:541: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, [r4]	@ BlockingEnabled, BlockingEnabled
	cmp	r4, #0	@ BlockingEnabled,
	beq	.L342		@,
@ C_Code.c:541: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L345+28	@ tmp137,
	ldr	r4, [r4]	@ _19,
	b	.L338		@
.L339:
@ C_Code.c:547: 		return BonusDamagePercent; 
	ldr	r4, .L345+12	@ tmp162,
	ldr	r4, [r4]	@ _19,
	b	.L338		@
.L342:
@ C_Code.c:542: 			else { return 100; } 
	movs	r4, #100	@ _19,
	b	.L338		@
.L346:
	.align	2
.L345:
	.word	TimedHitsDifficultyRam
	.word	DifficultyThreshold
	.word	NumberOfRandomButtons
	.word	BonusDamagePercent
	.word	DifficultyBonusPercent
	.word	FailedHitDamagePercent
	.word	BlockingEnabled
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r7, r9	@,
	mov	r6, r8	@,
	mov	lr, r10	@,
	movs	r4, r0	@ proc, tmp295
@ C_Code.c:100: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldr	r0, .L384	@ tmp173,
@ C_Code.c:100: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldrh	r5, [r0]	@ gBattleStats, gBattleStats
	movs	r0, #252	@ tmp177,
@ C_Code.c:457: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	push	{r6, r7, lr}	@
@ C_Code.c:100: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	lsls	r0, r0, #2	@ tmp177, tmp177,
@ C_Code.c:457: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r7, r2	@ HpProc, tmp296
	movs	r6, r3	@ round, tmp297
	sub	sp, sp, #8	@,,
@ C_Code.c:100: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	tst	r5, r0	@ gBattleStats, tmp177
	bne	.L347		@,
@ C_Code.c:103: 	if (TimedHitsDifficultyRam->off) { return false; } 
	ldr	r3, .L384+4	@ tmp182,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_13, *TimedHitsDifficultyRam.0_13
@ C_Code.c:103: 	if (TimedHitsDifficultyRam->off) { return false; } 
	lsls	r3, r3, #25	@ tmp304, *TimedHitsDifficultyRam.0_13,
	bpl	.L380		@,
.L347:
@ C_Code.c:533: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L380:
@ C_Code.c:104: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L384+8	@ tmp192,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L384+12	@ tmp194,
	bl	.L10		@
@ C_Code.c:458: 	if (!AreTimedHitsEnabled()) { return; } 
	cmp	r0, #0	@ tmp298,
	bne	.L347		@,
@ C_Code.c:459: 	if (round->hpChange < 0) { return; } // healing 
	ldrb	r3, [r6, #3]	@ tmp199,
	cmp	r3, #127	@ tmp199,
	bhi	.L347		@,
@ C_Code.c:460: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldr	r3, .L384+16	@ tmp200,
@ C_Code.c:460: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldrh	r2, [r3, #8]	@ tmp203,
	ldrh	r3, [r3, #4]	@ tmp205,
@ C_Code.c:460: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	orrs	r2, r3	@ tmp203, tmp205
@ C_Code.c:464: 	int x = proc->anim2->xPosition; 
	ldr	r3, [r4, #48]	@ proc_8(D)->anim2, proc_8(D)->anim2
@ C_Code.c:464: 	int x = proc->anim2->xPosition; 
	movs	r5, #2	@ x,
	ldrsh	r5, [r3, r5]	@ x, proc_8(D)->anim2, x
@ C_Code.c:460: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	mov	r8, r2	@ keys, tmp203
@ C_Code.c:465: 	if (x > 119) { x -= 40; } 
	cmp	r5, #119	@ x,
	bgt	.LCB2187	@
	b	.L351	@long jump	@
.LCB2187:
@ C_Code.c:465: 	if (x > 119) { x -= 40; } 
	subs	r5, r5, #40	@ x,
.L352:
@ C_Code.c:467: 	struct BattleUnit* active_bunit = proc->active_bunit; 
	ldr	r3, [r4, #60]	@ active_bunit, proc_8(D)->active_bunit
	mov	r9, r3	@ active_bunit, active_bunit
@ C_Code.c:468: 	struct BattleUnit* opp_bunit = proc->opp_bunit; 
	ldr	r3, [r4, #64]	@ opp_bunit, proc_8(D)->opp_bunit
	mov	r10, r3	@ opp_bunit, opp_bunit
@ C_Code.c:469: 	int hitTime = !proc->EkrEfxIsUnitHittedNowFrames; 
	movs	r3, #79	@ tmp209,
@ C_Code.c:470: 	if (hitTime) { // 1 frame 
	ldrb	r3, [r4, r3]	@ tmp210,
	cmp	r3, #0	@ tmp210,
	bne	.L354		@,
@ C_Code.c:472: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	movs	r2, #68	@ tmp211,
@ C_Code.c:472: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	ldrb	r1, [r4, r2]	@ tmp212,
	cmp	r1, #255	@ tmp212,
	bne	.LCB2202	@
	b	.L381	@long jump	@
.LCB2202:
.L355:
@ C_Code.c:473: 		SaveInputFrame(proc, keys); 
	mov	r1, r8	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
@ C_Code.c:474: 		SaveIfWeHitOnTime(proc);
	movs	r0, r4	@, proc
	bl	SaveIfWeHitOnTime		@
@ C_Code.c:475: 		if (!proc->adjustedDmg) { 
	movs	r3, #71	@ tmp216,
@ C_Code.c:475: 		if (!proc->adjustedDmg) { 
	ldrb	r2, [r4, r3]	@ tmp217,
	cmp	r2, #0	@ tmp217,
	bne	.L354		@,
@ C_Code.c:406: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r2, .L384+20	@ tmp218,
@ C_Code.c:410: 	if (CheatCodeOn()) { return true; } 
	ldrb	r2, [r2, #31]	@ tmp221,
	cmp	r2, #127	@ tmp221,
	bls	.LCB2216	@
	b	.L357	@long jump	@
.LCB2216:
@ C_Code.c:411: 	if (AlwaysWork) { return true; } 
	ldr	r2, .L384+24	@ tmp222,
@ C_Code.c:411: 	if (AlwaysWork) { return true; } 
	ldr	r2, [r2]	@ AlwaysWork, AlwaysWork
	cmp	r2, #0	@ AlwaysWork,
	beq	.LCB2220	@
	b	.L357	@long jump	@
.LCB2220:
@ C_Code.c:412: 	return proc->hitOnTime;
	adds	r2, r2, #69	@ tmp224,
@ C_Code.c:476: 			if (DidWeHitOnTime(proc)) { 
	ldrb	r2, [r4, r2]	@ tmp225,
	cmp	r2, #0	@ tmp225,
	beq	.LCB2224	@
	b	.L357	@long jump	@
.LCB2224:
@ C_Code.c:481: 				proc->adjustedDmg = true; 
	movs	r2, #1	@ tmp231,
	strb	r2, [r4, r3]	@ tmp231, proc_8(D)->adjustedDmg
@ C_Code.c:549: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	mov	r3, r9	@ active_bunit, active_bunit
	movs	r2, #11	@ tmp233,
	ldrsb	r2, [r3, r2]	@ tmp233,
	movs	r3, #192	@ tmp234,
	ands	r3, r2	@ tmp235, tmp233
@ C_Code.c:549: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ tmp235,
	bne	.LCB2233	@
	b	.L369	@long jump	@
.LCB2233:
@ C_Code.c:552: 	return FailedHitDamagePercent; 
	ldr	r3, .L384+28	@ tmp236,
	ldr	r3, [r3]	@ _86, FailedHitDamagePercent
.L359:
@ C_Code.c:563: 	AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);	
	str	r3, [sp, #4]	@ _86,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	movs	r1, r7	@, HpProc
	movs	r0, r4	@, proc
	str	r6, [sp]	@ round,
	bl	AdjustDamageByPercent		@
.L354:
@ C_Code.c:491: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	movs	r3, #74	@ tmp237,
@ C_Code.c:491: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	ldrb	r0, [r4, r3]	@ tmp238,
	ldr	r3, .L384+32	@ tmp239,
	bl	.L10		@
@ C_Code.c:491: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	movs	r3, #68	@ tmp242,
	ldrb	r6, [r4, r3]	@ prephitmp_68,
@ C_Code.c:491: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	cmp	r0, #0	@ tmp240,
	bne	.L361		@,
@ C_Code.c:491: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	adds	r3, r3, #8	@ tmp244,
	ldrh	r2, [r4, r3]	@ MEM <struct TimedHitsProc> [(void *)proc_8(D)], MEM <struct TimedHitsProc> [(void *)proc_8(D)]
	ldr	r3, .L384+36	@ tmp246,
	cmp	r2, r3	@ MEM <struct TimedHitsProc> [(void *)proc_8(D)], tmp246
	beq	.L382		@,
.L361:
@ C_Code.c:406: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L384+20	@ tmp247,
@ C_Code.c:410: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp250,
	cmp	r3, #127	@ tmp250,
	bhi	.L363		@,
@ C_Code.c:411: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L384+24	@ tmp251,
@ C_Code.c:411: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L363		@,
@ C_Code.c:412: 	return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp253,
@ C_Code.c:492: 		if (DidWeHitOnTime(proc)) { 
	ldrb	r3, [r4, r3]	@ tmp254,
	cmp	r3, #0	@ tmp254,
	bne	.L363		@,
@ C_Code.c:509: 		else if (proc->timer2 < 20) { 
	cmp	r6, #19	@ prephitmp_68,
	bhi	.L365		@,
@ C_Code.c:510: 			if (ChangePaletteWhenButtonIsPressed) { 
	ldr	r2, .L384+40	@ tmp281,
@ C_Code.c:416: 	if (!DisplayPress) { return; } 
	ldr	r3, .L384+44	@ tmp280,
@ C_Code.c:510: 			if (ChangePaletteWhenButtonIsPressed) { 
	ldr	r2, [r2]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
@ C_Code.c:416: 	if (!DisplayPress) { return; } 
	ldr	r3, [r3]	@ pretmp_69, DisplayPress
@ C_Code.c:510: 			if (ChangePaletteWhenButtonIsPressed) { 
	cmp	r2, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L366		@,
@ C_Code.c:416: 	if (!DisplayPress) { return; } 
	cmp	r3, #0	@ pretmp_69,
	bne	.L383		@,
.L365:
@ C_Code.c:517: 		proc->roundEnd = true; 
	movs	r3, #78	@ tmp283,
	movs	r2, #1	@ tmp284,
	strb	r2, [r4, r3]	@ tmp284, proc_8(D)->roundEnd
	b	.L347		@
.L363:
@ C_Code.c:502: 			if (((y > (-16)) && (y < (161)))) { 
	movs	r3, #63	@ tmp255,
	subs	r3, r3, r6	@ tmp256, tmp255, prephitmp_68
@ C_Code.c:502: 			if (((y > (-16)) && (y < (161)))) { 
	cmp	r3, #175	@ tmp256,
	bhi	.L365		@,
@ C_Code.c:503: 				if (!gBanimDoneFlag[proc->side]) { // doesn't seem to matter ? 
	movs	r2, #74	@ tmp258,
	ldrb	r2, [r4, r2]	@ tmp259,
@ C_Code.c:503: 				if (!gBanimDoneFlag[proc->side]) { // doesn't seem to matter ? 
	ldr	r3, .L384+48	@ tmp257,
	lsls	r2, r2, #2	@ tmp260, tmp259,
@ C_Code.c:503: 				if (!gBanimDoneFlag[proc->side]) { // doesn't seem to matter ? 
	ldr	r3, [r2, r3]	@ gBanimDoneFlag[_56], gBanimDoneFlag[_56]
	cmp	r3, #0	@ gBanimDoneFlag[_56],
	bne	.L365		@,
@ C_Code.c:498: 			x += xPos[Mod(clock, sizeof(xPos)+1)]; 
	movs	r1, #31	@,
	movs	r0, r6	@, prephitmp_68
	ldr	r3, .L384+52	@ tmp262,
	bl	.L10		@
@ C_Code.c:498: 			x += xPos[Mod(clock, sizeof(xPos)+1)]; 
	ldr	r3, .L384+56	@ tmp263,
	movs	r2, #104	@ tmp264,
	adds	r3, r3, r0	@ tmp265, tmp263, tmp300
@ C_Code.c:501: 			y -= clock; 
	movs	r0, #48	@ tmp269,
@ C_Code.c:498: 			x += xPos[Mod(clock, sizeof(xPos)+1)]; 
	ldrb	r1, [r3, r2]	@ tmp266, xPos
@ C_Code.c:501: 			y -= clock; 
	subs	r0, r0, r6	@ y, tmp269, prephitmp_68
@ C_Code.c:504: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	adds	r2, r2, #151	@ tmp271,
	ands	r2, r0	@ tmp272, y
	movs	r0, #224	@ tmp276,
@ C_Code.c:498: 			x += xPos[Mod(clock, sizeof(xPos)+1)]; 
	adds	r1, r1, r5	@ x, tmp266, x
@ C_Code.c:504: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	ldr	r3, .L384+60	@ tmp267,
@ C_Code.c:499: 			x += 16; 
	adds	r1, r1, #16	@ x,
@ C_Code.c:504: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	lsls	r0, r0, #8	@ tmp276, tmp276,
	lsls	r1, r1, #23	@ tmp275, x,
	str	r0, [sp]	@ tmp276,
	ldr	r5, .L384+64	@ tmp277,
	movs	r0, #0	@,
	adds	r3, r3, #8	@ tmp268,
	lsrs	r1, r1, #23	@ tmp274, tmp275,
	bl	.L27		@
	b	.L365		@
.L351:
@ C_Code.c:466: 	else if (x > 40) { x -= 20; } 
	cmp	r5, #40	@ x,
	bgt	.LCB2332	@
	b	.L352	@long jump	@
.LCB2332:
@ C_Code.c:466: 	else if (x > 40) { x -= 20; } 
	subs	r5, r5, #20	@ x,
	b	.L352		@
.L382:
@ C_Code.c:491: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	cmp	r6, #255	@ prephitmp_68,
	bne	.L361		@,
@ C_Code.c:521: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	ldr	r3, [r4, #52]	@ proc_8(D)->timer, proc_8(D)->timer
	cmp	r3, #0	@ proc_8(D)->timer,
	bgt	.L367		@,
@ C_Code.c:521: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	movs	r3, #75	@ tmp287,
	strb	r0, [r4, r3]	@ tmp240, proc_8(D)->frame
.L368:
@ C_Code.c:526: 		if (!proc->roundEnd) { 
	movs	r3, #78	@ tmp290,
@ C_Code.c:526: 		if (!proc->roundEnd) { 
	ldrb	r3, [r4, r3]	@ tmp291,
	cmp	r3, #0	@ tmp291,
	beq	.LCB2350	@
	b	.L347	@long jump	@
.LCB2350:
@ C_Code.c:416: 	if (!DisplayPress) { return; } 
	ldr	r3, .L384+44	@ tmp292,
@ C_Code.c:416: 	if (!DisplayPress) { return; } 
	ldr	r3, [r3]	@ DisplayPress, DisplayPress
	cmp	r3, #0	@ DisplayPress,
	bne	.LCB2354	@
	b	.L347	@long jump	@
.LCB2354:
	movs	r3, #15	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L347		@
.L381:
@ C_Code.c:472: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	strb	r3, [r4, r2]	@ tmp210, proc_8(D)->timer2
	b	.L355		@
.L357:
@ C_Code.c:477: 				proc->adjustedDmg = true; 
	movs	r3, #1	@ tmp227,
	movs	r2, #71	@ tmp226,
@ C_Code.c:478: 				AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true); 
	str	r3, [sp, #4]	@ tmp227,
@ C_Code.c:477: 				proc->adjustedDmg = true; 
	strb	r3, [r4, r2]	@ tmp227, proc_8(D)->adjustedDmg
@ C_Code.c:478: 				AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true); 
	movs	r1, r7	@, HpProc
	mov	r3, r10	@, opp_bunit
	mov	r2, r9	@, active_bunit
	movs	r0, r4	@, proc
	str	r6, [sp]	@ round,
	bl	AdjustDamageWithGetter		@
	b	.L354		@
.L366:
@ C_Code.c:416: 	if (!DisplayPress) { return; } 
	cmp	r3, #0	@ pretmp_69,
	beq	.L365		@,
	movs	r3, #14	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L365		@
.L383:
	movs	r3, #15	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L365		@
.L367:
@ C_Code.c:524: 			SaveInputFrame(proc, keys); 
	mov	r1, r8	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
	b	.L368		@
.L369:
@ C_Code.c:550: 		return 100; 
	movs	r3, #100	@ _86,
	b	.L359		@
.L385:
	.align	2
.L384:
	.word	gBattleStats
	.word	TimedHitsDifficultyRam
	.word	DisabledFlag
	.word	CheckFlag
	.word	sKeyStatusBuffer
	.word	gPlaySt
	.word	AlwaysWork
	.word	FailedHitDamagePercent
	.word	EkrEfxIsUnitHittedNow
	.word	65535
	.word	ChangePaletteWhenButtonIsPressed
	.word	DisplayPress
	.word	gBanimDoneFlag
	.word	Mod
	.word	.LANCHOR0
	.word	.LANCHOR1
	.word	PutSprite
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
@ C_Code.c:268: 	if (!proc->anim) { return; } 
	ldr	r3, [r0, #44]	@ proc_29(D)->anim, proc_29(D)->anim
@ C_Code.c:267: void LoopTimedHitsProc(TimedHitsProc* proc) { 
	movs	r4, r0	@ proc, tmp184
	sub	sp, sp, #12	@,,
@ C_Code.c:268: 	if (!proc->anim) { return; } 
	cmp	r3, #0	@ proc_29(D)->anim,
	beq	.L386		@,
@ C_Code.c:270: 	struct ProcEkrBattle* battleProc = gpProcEkrBattle; 
	ldr	r3, .L413	@ tmp143,
	ldr	r5, [r3]	@ battleProc, gpProcEkrBattle
@ C_Code.c:272: 	if (!battleProc) { return; } // 0 after suspend until battle start 
	cmp	r5, #0	@ battleProc,
	beq	.L386		@,
@ C_Code.c:273: 	if (!proc->anim2) { return; }
	ldr	r3, [r0, #48]	@ proc_29(D)->anim2, proc_29(D)->anim2
	cmp	r3, #0	@ proc_29(D)->anim2,
	beq	.L386		@,
@ C_Code.c:274: 	if (gEkrBattleEndFlag) { Proc_End(proc); return; } // 0 after suspend until battle done
	ldr	r3, .L413+4	@ tmp145,
@ C_Code.c:274: 	if (gEkrBattleEndFlag) { Proc_End(proc); return; } // 0 after suspend until battle done
	ldr	r3, [r3]	@ gEkrBattleEndFlag, gEkrBattleEndFlag
	cmp	r3, #0	@ gEkrBattleEndFlag,
	bne	.L411		@,
@ C_Code.c:277: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	movs	r2, #68	@ tmp150,
@ C_Code.c:276: 	proc->timer++;
	ldr	r3, [r0, #52]	@ proc_29(D)->timer, proc_29(D)->timer
	adds	r3, r3, #1	@ tmp148,
	str	r3, [r0, #52]	@ tmp148, proc_29(D)->timer
@ C_Code.c:277: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	ldrb	r3, [r0, r2]	@ _6,
@ C_Code.c:277: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	cmp	r3, #255	@ _6,
	beq	.L391		@,
@ C_Code.c:277: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	adds	r3, r3, #1	@ tmp151,
	strb	r3, [r0, r2]	@ tmp151, proc_29(D)->timer2
.L391:
@ C_Code.c:281: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	movs	r6, #79	@ tmp154,
	ldrb	r3, [r4, r6]	@ _8,
@ C_Code.c:279: 	struct SkillSysBattleHit* currentRound = proc->currentRound; 
	ldr	r7, [r4, #56]	@ currentRound, proc_29(D)->currentRound
@ C_Code.c:281: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	cmp	r3, #255	@ _8,
	beq	.L392		@,
@ C_Code.c:282: 		proc->EkrEfxIsUnitHittedNowFrames++; 
	adds	r3, r3, #1	@ tmp155,
	strb	r3, [r4, r6]	@ tmp155, proc_29(D)->EkrEfxIsUnitHittedNowFrames
.L393:
@ C_Code.c:287: 	struct NewProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBarResire); 
	ldr	r3, .L413+8	@ tmp166,
	ldr	r6, .L413+12	@ tmp168,
	ldr	r0, [r3]	@ gProcScr_efxHPBarResire, gProcScr_efxHPBarResire
	bl	.L125		@
	subs	r2, r0, #0	@ HpProc, tmp186,
@ C_Code.c:288: 	if (!HpProc) { HpProc = Proc_Find(gProcScr_efxHPBar); } 
	beq	.L412		@,
@ C_Code.c:289: 	DoStuffIfHit(proc, battleProc, HpProc, currentRound); 
	movs	r3, r7	@, currentRound
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
.L395:
@ C_Code.c:263: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #79	@ tmp172,
@ C_Code.c:263: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r3, [r4, r3]	@ tmp173,
	cmp	r3, #0	@ tmp173,
	bne	.L386		@,
@ C_Code.c:292: 		int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId); 
	movs	r6, #70	@ tmp175,
@ C_Code.c:292: 		int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId); 
	ldrb	r3, [r4, r6]	@ tmp176,
	movs	r1, #0	@,
	movs	r2, #0	@,
	str	r3, [sp]	@ tmp176,
	ldr	r0, [r4, #48]	@ proc_29(D)->anim2, proc_29(D)->anim2
	movs	r3, #0	@,
	ldr	r5, .L413+16	@ tmp177,
	bl	.L27		@
	movs	r3, r0	@ x, tmp188
@ C_Code.c:293: 		x = DisplayDamage2(proc->anim, 1, proc->anim->xPosition, x, proc->roundId);  
	ldr	r0, [r4, #44]	@ _18, proc_29(D)->anim
	movs	r1, #2	@ tmp192,
	ldrsh	r2, [r0, r1]	@ tmp178, _18, tmp192
	ldrb	r1, [r4, r6]	@ tmp180,
	str	r1, [sp]	@ tmp180,
	movs	r1, #1	@,
	bl	.L27		@
.L386:
@ C_Code.c:296: } 
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L411:
@ C_Code.c:274: 	if (gEkrBattleEndFlag) { Proc_End(proc); return; } // 0 after suspend until battle done
	ldr	r3, .L413+20	@ tmp147,
	bl	.L10		@
@ C_Code.c:274: 	if (gEkrBattleEndFlag) { Proc_End(proc); return; } // 0 after suspend until battle done
	b	.L386		@
.L392:
@ C_Code.c:284: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #74	@ tmp158,
@ C_Code.c:284: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	ldrb	r0, [r4, r3]	@ tmp159,
	ldr	r3, .L413+24	@ tmp160,
	bl	.L10		@
@ C_Code.c:284: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	cmp	r0, #0	@ tmp185,
	beq	.L393		@,
@ C_Code.c:284: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #0	@ tmp164,
	strb	r3, [r4, r6]	@ tmp164, proc_29(D)->EkrEfxIsUnitHittedNowFrames
	b	.L393		@
.L412:
@ C_Code.c:288: 	if (!HpProc) { HpProc = Proc_Find(gProcScr_efxHPBar); } 
	ldr	r3, .L413+28	@ tmp169,
	ldr	r0, [r3]	@ gProcScr_efxHPBar, gProcScr_efxHPBar
	bl	.L125		@
@ C_Code.c:289: 	DoStuffIfHit(proc, battleProc, HpProc, currentRound); 
	movs	r3, r7	@, currentRound
@ C_Code.c:288: 	if (!HpProc) { HpProc = Proc_Find(gProcScr_efxHPBar); } 
	movs	r6, r0	@ HpProc, tmp187
@ C_Code.c:289: 	DoStuffIfHit(proc, battleProc, HpProc, currentRound); 
	movs	r2, r0	@, HpProc
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
@ C_Code.c:261: 	if (!HpProc) { return false; } // 
	cmp	r6, #0	@ HpProc,
	beq	.L386		@,
	b	.L395		@
.L414:
	.align	2
.L413:
	.word	gpProcEkrBattle
	.word	gEkrBattleEndFlag
	.word	gProcScr_efxHPBarResire
	.word	Proc_Find
	.word	DisplayDamage2
	.word	Proc_End
	.word	EkrEfxIsUnitHittedNow
	.word	gProcScr_efxHPBar
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
@ C_Code.c:744: 	int result = gPlaySt.config.animationType; 
	movs	r2, #66	@ tmp129,
@ C_Code.c:743: int GetBattleAnimPreconfType(void) {
	push	{r4, lr}	@
@ C_Code.c:744: 	int result = gPlaySt.config.animationType; 
	ldr	r3, .L427	@ tmp163,
	ldrb	r0, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:745: 	if (!CheatCodeOn()) { 
	ldrb	r2, [r3, #31]	@ tmp138,
@ C_Code.c:744: 	int result = gPlaySt.config.animationType; 
	lsls	r0, r0, #29	@ tmp133, gPlaySt,
@ C_Code.c:744: 	int result = gPlaySt.config.animationType; 
	lsrs	r0, r0, #30	@ <retval>, tmp133,
@ C_Code.c:745: 	if (!CheatCodeOn()) { 
	cmp	r2, #127	@ tmp138,
	bhi	.L416		@,
@ C_Code.c:746: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, .L427+4	@ tmp139,
@ C_Code.c:746: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, [r2]	@ ForceAnimsOn, ForceAnimsOn
	cmp	r2, #0	@ ForceAnimsOn,
	beq	.L416		@,
@ C_Code.c:746: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	cmp	r0, #2	@ <retval>,
	beq	.L415		@,
.L419:
@ C_Code.c:746: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	movs	r0, #1	@ <retval>,
.L415:
@ C_Code.c:767: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L416:
@ C_Code.c:749:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r2, #66	@ tmp142,
	ldrb	r2, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:749:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r3, #6	@ tmp148,
	ands	r3, r2	@ tmp149, gPlaySt
	cmp	r3, #4	@ tmp149,
	bne	.L415		@,
@ C_Code.c:753:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	movs	r1, #11	@ tmp153,
@ C_Code.c:754:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	movs	r4, #11	@ pretmp_25,
@ C_Code.c:753:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldr	r0, .L427+8	@ tmp152,
@ C_Code.c:754:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldr	r2, .L427+12	@ tmp151,
@ C_Code.c:753:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldrsb	r1, [r0, r1]	@ tmp153,
	adds	r3, r3, #188	@ tmp154,
@ C_Code.c:754:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldrsb	r4, [r2, r4]	@ pretmp_25,* pretmp_25
@ C_Code.c:753:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	tst	r3, r1	@ tmp154, tmp153
	beq	.L426		@,
@ C_Code.c:759:         if (UNIT_FACTION(&gBattleTarget.unit) != FACTION_BLUE)
	tst	r3, r4	@ tmp154, pretmp_25
	bne	.L419		@,
@ C_Code.c:766:         return GetSoloAnimPreconfType(&gBattleTarget.unit);
	movs	r0, r2	@, tmp151
.L426:
	ldr	r3, .L427+16	@ tmp161,
	bl	.L10		@
	b	.L415		@
.L428:
	.align	2
.L427:
	.word	gPlaySt
	.word	ForceAnimsOn
	.word	gBattleActor
	.word	gBattleTarget
	.word	GetSoloAnimPreconfType
	.size	GetBattleAnimPreconfType, .-GetBattleAnimPreconfType
	.global	xPos
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
.LC132:
	.ascii	"TimedHitsProcName\000"
	.global	gEkrBg2QuakeVec
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.set	.LANCHOR1,. + 128
	.type	TimedHitsProcCmd, %object
	.size	TimedHitsProcCmd, 32
TimedHitsProcCmd:
@ opcode:
	.short	1
@ dataImm:
	.short	0
@ dataPtr:
	.word	.LC132
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
	.type	RomKeysList, %object
	.size	RomKeysList, 6
RomKeysList:
	.ascii	"\001\002\020 @\200"
	.space	2
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
	.type	xPos, %object
	.size	xPos, 30
xPos:
	.ascii	"\000\000\000\001\001\001\002\002\002\003\003\003\004"
	.ascii	"\004\004\005\005\005\004\004\004\003\003\003\002\002"
	.ascii	"\002\001\001\001"
	.space	2
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
.L10:
	bx	r3
.L180:
	bx	r4
.L27:
	bx	r5
.L125:
	bx	r6
.L126:
	bx	r9
.L66:
	bx	fp
