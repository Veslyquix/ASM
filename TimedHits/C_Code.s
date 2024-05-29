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
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldr	r3, .L8	@ tmp123,
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldrh	r2, [r3]	@ gBattleStats, gBattleStats
	movs	r3, #252	@ tmp127,
	lsls	r3, r3, #2	@ tmp127, tmp127,
@ C_Code.c:93: int AreTimedHitsEnabled(void) { 
	push	{r4, lr}	@
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	tst	r2, r3	@ gBattleStats, tmp127
	bne	.L3		@,
@ C_Code.c:97: 	if (TimedHitsDifficultyRam->off) { return false; } 
	ldr	r3, .L8+4	@ tmp132,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_4, *TimedHitsDifficultyRam.0_4
@ C_Code.c:95: 		return false; 
	movs	r0, #0	@ <retval>,
@ C_Code.c:97: 	if (TimedHitsDifficultyRam->off) { return false; } 
	lsls	r3, r3, #25	@ tmp153, *TimedHitsDifficultyRam.0_4,
	bpl	.L7		@,
.L1:
@ C_Code.c:99: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L7:
@ C_Code.c:98: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L8+8	@ tmp142,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L8+12	@ tmp144,
	bl	.L10		@
@ C_Code.c:98: 	return !CheckFlag(DisabledFlag); 
	rsbs	r3, r0, #0	@ tmp149, tmp151
	adcs	r0, r0, r3	@ <retval>, tmp151, tmp149
	b	.L1		@
.L3:
@ C_Code.c:95: 		return false; 
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
	.type	InitVariables, %function
InitVariables:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:102: 	proc->anim = NULL; 
	movs	r3, #0	@ tmp115,
@ C_Code.c:121: } 
	@ sp needed	@
@ C_Code.c:117: 	proc->buttonsToPress = 0; 
	movs	r2, #80	@ tmp121,
@ C_Code.c:102: 	proc->anim = NULL; 
	str	r3, [r0, #44]	@ tmp115, proc_2(D)->anim
@ C_Code.c:103: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp115, proc_2(D)->anim2
@ C_Code.c:106: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp115, proc_2(D)->timer
@ C_Code.c:112: 	proc->currentRound = NULL; 
	str	r3, [r0, #56]	@ tmp115, proc_2(D)->currentRound
@ C_Code.c:113: 	proc->active_bunit = NULL; 
	str	r3, [r0, #60]	@ tmp115, proc_2(D)->active_bunit
@ C_Code.c:114: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp115, proc_2(D)->opp_bunit
@ C_Code.c:117: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r2]	@ tmp115, proc_2(D)->buttonsToPress
@ C_Code.c:107: 	proc->timer2 = 0xFF; 
	adds	r3, r3, #255	@ tmp124,
	str	r3, [r0, #68]	@ tmp124, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 68B]
	movs	r3, #255	@ tmp125,
	lsls	r3, r3, #16	@ tmp125, tmp125,
	str	r3, [r0, #72]	@ tmp125, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 72B]
	ldr	r3, .L12	@ tmp126,
	str	r3, [r0, #76]	@ tmp126, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 76B]
@ C_Code.c:121: } 
	bx	lr
.L13:
	.align	2
.L12:
	.word	-16646145
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
@ C_Code.c:125: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r4, .L17	@ tmp115,
	ldr	r3, .L17+4	@ tmp116,
	movs	r0, r4	@, tmp115
	bl	.L10		@
@ C_Code.c:126: 	if (!proc) { 
	cmp	r0, #0	@ tmp119,
	beq	.L16		@,
.L14:
@ C_Code.c:130: } 
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L16:
@ C_Code.c:127: 		proc = Proc_Start(TimedHitsProcCmd, (void*)3); 
	movs	r1, #3	@,
	movs	r0, r4	@, tmp115
	ldr	r3, .L17+8	@ tmp118,
	bl	.L10		@
@ C_Code.c:130: } 
	b	.L14		@
.L18:
	.align	2
.L17:
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
@ C_Code.c:135: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r3, .L26	@ tmp130,
@ C_Code.c:133: void SetCurrentAnimInProc(struct Anim* anim) { 
	movs	r5, r0	@ anim, tmp189
@ C_Code.c:135: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r0, .L26+4	@ tmp129,
	bl	.L10		@
	subs	r4, r0, #0	@ proc, tmp190,
@ C_Code.c:136: 	if (!proc) { return; } 
	beq	.L19		@,
@ C_Code.c:103: 	proc->anim2 = NULL; 
	movs	r3, #0	@ tmp131,
@ C_Code.c:117: 	proc->buttonsToPress = 0; 
	movs	r2, #80	@ tmp136,
@ C_Code.c:103: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp131, proc_18->anim2
@ C_Code.c:106: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp131, proc_18->timer
@ C_Code.c:112: 	proc->currentRound = NULL; 
	str	r3, [r0, #56]	@ tmp131, proc_18->currentRound
@ C_Code.c:113: 	proc->active_bunit = NULL; 
	str	r3, [r0, #60]	@ tmp131, proc_18->active_bunit
@ C_Code.c:114: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp131, proc_18->opp_bunit
@ C_Code.c:117: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r2]	@ tmp131, proc_18->buttonsToPress
@ C_Code.c:107: 	proc->timer2 = 0xFF; 
	adds	r3, r3, #255	@ tmp139,
	str	r3, [r0, #68]	@ tmp139, MEM <vector(4) unsigned char> [(unsigned char *)proc_18 + 68B]
	movs	r3, #255	@ tmp140,
	lsls	r3, r3, #16	@ tmp140, tmp140,
	str	r3, [r0, #72]	@ tmp140, MEM <vector(4) unsigned char> [(unsigned char *)proc_18 + 72B]
	ldr	r3, .L26+8	@ tmp141,
@ C_Code.c:139: 	proc->anim = anim; 
	str	r5, [r0, #44]	@ anim, proc_18->anim
@ C_Code.c:107: 	proc->timer2 = 0xFF; 
	str	r3, [r0, #76]	@ tmp141, MEM <vector(4) unsigned char> [(unsigned char *)proc_18 + 76B]
@ C_Code.c:140: 	proc->anim2 = GetAnimAnotherSide(anim); 
	ldr	r3, .L26+12	@ tmp142,
	movs	r0, r5	@, anim
	bl	.L10		@
@ C_Code.c:140: 	proc->anim2 = GetAnimAnotherSide(anim); 
	str	r0, [r4, #48]	@ tmp191, proc_18->anim2
@ C_Code.c:141: 	proc->roundId = anim->nextRoundId-1; 
	ldrh	r3, [r5, #14]	@ tmp145,
	subs	r3, r3, #1	@ tmp146,
	lsls	r3, r3, #24	@ tmp147, tmp146,
	lsrs	r0, r3, #24	@ _4, tmp147,
@ C_Code.c:141: 	proc->roundId = anim->nextRoundId-1; 
	movs	r3, #70	@ tmp148,
	strb	r0, [r4, r3]	@ _4, proc_18->roundId
@ C_Code.c:144: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	ldr	r3, .L26+16	@ tmp150,
	bl	.L10		@
@ C_Code.c:145: 	proc->side = GetAnimPosition(anim) ^ 1; 
	ldr	r3, .L26+20	@ tmp151,
@ C_Code.c:144: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	str	r0, [r4, #56]	@ tmp192, proc_18->currentRound
@ C_Code.c:145: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r0, r5	@, anim
	bl	.L10		@
@ C_Code.c:145: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r3, #1	@ tmp153,
@ C_Code.c:145: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r2, #74	@ tmp156,
@ C_Code.c:145: 	proc->side = GetAnimPosition(anim) ^ 1; 
	lsls	r0, r0, #24	@ tmp152, tmp193,
	asrs	r0, r0, #24	@ _8, tmp152,
	eors	r3, r0	@ tmp155, _8
@ C_Code.c:145: 	proc->side = GetAnimPosition(anim) ^ 1; 
	strb	r3, [r4, r2]	@ tmp155, proc_18->side
@ C_Code.c:146: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, .L26+24	@ tmp158,
@ C_Code.c:147: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, .L26+28	@ tmp159,
@ C_Code.c:146: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, [r3]	@ gpEkrBattleUnitLeft.2_11, gpEkrBattleUnitLeft
@ C_Code.c:147: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, [r2]	@ gpEkrBattleUnitRight.3_12, gpEkrBattleUnitRight
@ C_Code.c:146: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	str	r3, [r4, #60]	@ gpEkrBattleUnitLeft.2_11, proc_18->active_bunit
@ C_Code.c:147: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #64]	@ gpEkrBattleUnitRight.3_12, proc_18->opp_bunit
@ C_Code.c:148: 	if (!proc->side) { 
	cmp	r0, #1	@ _8,
	beq	.L24		@,
@ C_Code.c:152: 	if (!proc->loadedImg) {
	movs	r6, #73	@ tmp160,
@ C_Code.c:152: 	if (!proc->loadedImg) {
	ldrb	r3, [r4, r6]	@ tmp161,
	cmp	r3, #0	@ tmp161,
	beq	.L25		@,
.L19:
@ C_Code.c:163: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L24:
@ C_Code.c:152: 	if (!proc->loadedImg) {
	movs	r6, #73	@ tmp160,
@ C_Code.c:149: 		proc->active_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #60]	@ gpEkrBattleUnitRight.3_12, proc_18->active_bunit
@ C_Code.c:150: 		proc->opp_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #64]	@ gpEkrBattleUnitLeft.2_11, proc_18->opp_bunit
@ C_Code.c:152: 	if (!proc->loadedImg) {
	ldrb	r3, [r4, r6]	@ tmp161,
	cmp	r3, #0	@ tmp161,
	bne	.L19		@,
.L25:
@ C_Code.c:153: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r5, .L26+32	@ tmp164,
	movs	r2, #6	@,
	ldr	r0, .L26+36	@ tmp163,
	ldr	r1, .L26+40	@,
	adds	r3, r3, #2	@,
	bl	.L28		@
@ C_Code.c:154: 		Copy2dChr(&BattleStar, (void*)0x06012a40, 2, 2); // 0x108 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+44	@ tmp166,
	ldr	r1, .L26+48	@,
	bl	.L28		@
@ C_Code.c:155: 		Copy2dChr(&A_Button, (void*)0x06012800, 2, 2); // 0x140
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+52	@ tmp169,
	ldr	r1, .L26+56	@,
	bl	.L28		@
@ C_Code.c:156: 		Copy2dChr(&B_Button, (void*)0x06012840, 2, 2); // 0x142 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+60	@ tmp172,
	ldr	r1, .L26+64	@,
	bl	.L28		@
@ C_Code.c:157: 		Copy2dChr(&Left_Button, (void*)0x06012880, 2, 2); // 0x144
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+68	@ tmp175,
	ldr	r1, .L26+72	@,
	bl	.L28		@
@ C_Code.c:158: 		Copy2dChr(&Right_Button, (void*)0x060128C0, 2, 2); // 0x146
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+76	@ tmp178,
	ldr	r1, .L26+80	@,
	bl	.L28		@
@ C_Code.c:159: 		Copy2dChr(&Up_Button, (void*)0x06012900, 2, 2); // 0x148
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+84	@ tmp181,
	ldr	r1, .L26+88	@,
	bl	.L28		@
@ C_Code.c:160: 		Copy2dChr(&Down_Button, (void*)0x06012940, 2, 2); // 0x14a
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+92	@ tmp184,
	ldr	r1, .L26+96	@,
	bl	.L28		@
@ C_Code.c:161: 		proc->loadedImg = true;
	movs	r3, #1	@ tmp187,
	strb	r3, [r4, r6]	@ tmp187, proc_18->loadedImg
	b	.L19		@
.L27:
	.align	2
.L26:
	.word	Proc_Find
	.word	.LANCHOR0
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
	.type	BreakOnce, %function
BreakOnce:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:245: 	if (proc->broke) { return; } 
	movs	r3, #72	@ tmp116,
@ C_Code.c:245: 	if (proc->broke) { return; } 
	ldrb	r2, [r0, r3]	@ tmp117,
	cmp	r2, #0	@ tmp117,
	bne	.L29		@,
@ C_Code.c:246: 	proc->broke = true; 
	adds	r2, r2, #1	@ tmp119,
	strb	r2, [r0, r3]	@ tmp119, proc_4(D)->broke
@ C_Code.c:247: 	asm("mov r11, r11");
	.syntax divided
@ 247 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L29:
@ C_Code.c:248: } 
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
@ C_Code.c:252: 	if (!HpProc) { return false; } // 
	cmp	r1, #0	@ tmp126,
	beq	.L33		@,
@ C_Code.c:254: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #79	@ tmp119,
@ C_Code.c:254: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r0, [r0, r3]	@ tmp121,
	rsbs	r3, r0, #0	@ tmp123, tmp121
	adcs	r0, r0, r3	@ <retval>, tmp121, tmp123
.L31:
@ C_Code.c:256: } 
	@ sp needed	@
	bx	lr
.L33:
@ C_Code.c:252: 	if (!HpProc) { return false; } // 
	movs	r0, #0	@ <retval>,
	b	.L31		@
	.size	HitNow, .-HitNow
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC25:
	.ascii	"\001\002\020 @\200\000"
	.text
	.align	1
	.p2align 2,,3
	.global	GetButtonsToPress
	.syntax unified
	.code	16
	.thumb_func
	.type	GetButtonsToPress, %function
GetButtonsToPress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r6, r8	@,
	mov	lr, r10	@,
	mov	r7, r9	@,
	push	{r6, r7, lr}	@
@ C_Code.c:303: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, .L56	@ tmp137,
@ C_Code.c:303: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:302: int GetButtonsToPress(TimedHitsProc* proc) { 
	mov	r8, r0	@ proc, tmp179
	sub	sp, sp, #8	@,,
@ C_Code.c:303: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	cmp	r3, #0	@ AlwaysA,
	bne	.L45		@,
@ C_Code.c:303: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, .L56+4	@ tmp139,
	ldr	r2, [r3]	@ TimedHitsDifficultyRam.9_2, TimedHitsDifficultyRam
@ C_Code.c:303: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.9_2, *TimedHitsDifficultyRam.9_2
	lsls	r3, r3, #26	@ tmp181, *TimedHitsDifficultyRam.9_2,
	bmi	.L45		@,
@ C_Code.c:304: 	int keys = proc->buttonsToPress;
	movs	r3, #80	@ tmp149,
@ C_Code.c:304: 	int keys = proc->buttonsToPress;
	ldrh	r0, [r0, r3]	@ <retval>,
@ C_Code.c:305: 	if (!keys) { 
	cmp	r0, #0	@ <retval>,
	bne	.L34		@,
@ C_Code.c:306: 		u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
	ldr	r3, .L56+8	@ tmp151,
	ldr	r1, [r3]	@ tmp154,
	str	r1, [sp]	@ tmp154,
	mov	r1, sp	@ tmp184,
	ldrh	r3, [r3, #4]	@ tmp156,
	strh	r3, [r1, #4]	@ tmp156,
@ C_Code.c:311: 		int numberOfRandomButtons = NumberOfRandomButtons; 
	ldr	r3, .L56+12	@ tmp158,
	ldr	r3, [r3]	@ numberOfRandomButtons, NumberOfRandomButtons
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:312: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	cmp	r3, #0	@ numberOfRandomButtons,
	beq	.L53		@,
@ C_Code.c:314: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	ble	.L46		@,
.L37:
	ldr	r3, .L56+16	@ tmp177,
@ C_Code.c:314: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	movs	r6, #0	@ i,
@ C_Code.c:309: 		int oppDir = 0; 
	movs	r7, #0	@ oppDir,
@ C_Code.c:304: 	int keys = proc->buttonsToPress;
	movs	r5, #0	@ keys,
@ C_Code.c:310: 		int size = 5; // -1 since we count from 0  
	movs	r4, #5	@ size,
	mov	r10, r3	@ tmp177, tmp177
	b	.L43		@
.L39:
@ C_Code.c:314: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r6, r6, #1	@ i,
@ C_Code.c:334: 			keys |= button; 
	orrs	r5, r0	@ keys, button
@ C_Code.c:314: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r9, r6	@ numberOfRandomButtons, i
	ble	.L54		@,
.L43:
@ C_Code.c:315: 			num = NextRN_N(size); 
	movs	r0, r4	@, size
	bl	.L58		@
@ C_Code.c:316: 			button = KeysList[num];
	mov	r3, sp	@ tmp191,
	ldrb	r0, [r3, r0]	@ button, KeysList
@ C_Code.c:319: 			if (button & 0xF0) { // some dpad 
	cmp	r0, #15	@ button,
	bls	.L39		@,
@ C_Code.c:320: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	cmp	r0, #16	@ button,
	beq	.L47		@,
@ C_Code.c:321: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	cmp	r0, #32	@ button,
	beq	.L48		@,
@ C_Code.c:322: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	cmp	r0, #64	@ button,
	bne	.L55		@,
@ C_Code.c:322: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	movs	r7, #128	@ oppDir,
.L40:
@ C_Code.c:324: 				for (int c = 0; c <= size; ++c) { 
	cmp	r4, #0	@ size,
	blt	.L39		@,
	mov	r2, sp	@ ivtmp.86,
@ C_Code.c:324: 				for (int c = 0; c <= size; ++c) { 
	movs	r3, #0	@ c,
	b	.L42		@
.L41:
@ C_Code.c:324: 				for (int c = 0; c <= size; ++c) { 
	adds	r3, r3, #1	@ c,
@ C_Code.c:324: 				for (int c = 0; c <= size; ++c) { 
	adds	r2, r2, #1	@ ivtmp.86,
	cmp	r3, r4	@ c, size
	bgt	.L39		@,
.L42:
@ C_Code.c:325: 					if (KeysList[c] == oppDir) { 
	ldrb	r1, [r2]	@ MEM[(unsigned char *)_45], MEM[(unsigned char *)_45]
@ C_Code.c:325: 					if (KeysList[c] == oppDir) { 
	cmp	r1, r7	@ MEM[(unsigned char *)_45], oppDir
	bne	.L41		@,
@ C_Code.c:326: 						KeysList[c] = KeysList[size]; 
	mov	r2, sp	@ tmp192,
@ C_Code.c:326: 						KeysList[c] = KeysList[size]; 
	mov	r1, sp	@ tmp193,
@ C_Code.c:326: 						KeysList[c] = KeysList[size]; 
	ldrb	r2, [r2, r4]	@ _10, KeysList
@ C_Code.c:314: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r6, r6, #1	@ i,
@ C_Code.c:326: 						KeysList[c] = KeysList[size]; 
	strb	r2, [r1, r3]	@ _10, KeysList[c_53]
@ C_Code.c:327: 						size--; 
	subs	r4, r4, #1	@ size,
@ C_Code.c:334: 			keys |= button; 
	orrs	r5, r0	@ keys, button
@ C_Code.c:314: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r9, r6	@ numberOfRandomButtons, i
	bgt	.L43		@,
.L54:
@ C_Code.c:336: 		proc->buttonsToPress = keys; 
	movs	r0, r5	@ <retval>, keys
	lsls	r3, r5, #16	@ tmp173, keys,
	lsrs	r3, r3, #16	@ prephitmp_15, tmp173,
.L38:
	movs	r2, #80	@ tmp174,
	mov	r1, r8	@ proc, proc
	strh	r3, [r1, r2]	@ prephitmp_15, proc_29(D)->buttonsToPress
	b	.L34		@
.L45:
@ C_Code.c:303: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	movs	r0, #1	@ <retval>,
.L34:
@ C_Code.c:339: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L53:
@ C_Code.c:312: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.9_2, *TimedHitsDifficultyRam.9_2
	lsls	r3, r3, #27	@ tmp163, *TimedHitsDifficultyRam.9_2,
@ C_Code.c:312: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	lsrs	r2, r3, #27	@ numberOfRandomButtons, tmp163,
	mov	r9, r2	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:313: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	cmp	r3, #0	@ tmp163,
	bne	.L37		@,
@ C_Code.c:313: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	adds	r3, r3, #1	@ numberOfRandomButtons,
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
	b	.L37		@
.L47:
@ C_Code.c:320: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	movs	r7, #32	@ oppDir,
	b	.L40		@
.L48:
@ C_Code.c:321: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	movs	r7, #16	@ oppDir,
	b	.L40		@
.L55:
@ C_Code.c:323: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	cmp	r0, #128	@ button,
	bne	.L40		@,
@ C_Code.c:323: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	movs	r7, #64	@ oppDir,
	b	.L40		@
.L46:
@ C_Code.c:314: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	movs	r3, #0	@ prephitmp_15,
	b	.L38		@
.L57:
	.align	2
.L56:
	.word	AlwaysA
	.word	TimedHitsDifficultyRam
	.word	.LC25
	.word	NumberOfRandomButtons
	.word	NextRN_N
	.size	GetButtonsToPress, .-GetButtonsToPress
	.align	1
	.p2align 2,,3
	.syntax unified
	.code	16
	.thumb_func
	.type	DrawButtonsToPress.part.0, %function
DrawButtonsToPress.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r6, r9	@,
	mov	lr, fp	@,
	mov	r7, r10	@,
	mov	r5, r8	@,
	push	{r5, r6, r7, lr}	@
	sub	sp, sp, #12	@,,
@ C_Code.c:396: void DrawButtonsToPress(TimedHitsProc* proc, int x, int y, int palID) { 
	movs	r7, r2	@ y, tmp237
	movs	r4, r0	@ proc, tmp235
	mov	r9, r1	@ x, tmp236
	movs	r6, r3	@ palID, tmp238
@ C_Code.c:398: 	int keys = GetButtonsToPress(proc); 
	bl	GetButtonsToPress		@
@ C_Code.c:400: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r2, .L114	@ tmp155,
@ C_Code.c:400: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r2, [r2]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
@ C_Code.c:398: 	int keys = GetButtonsToPress(proc); 
	movs	r5, r0	@ keys, tmp239
@ C_Code.c:400: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	cmp	r2, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L62		@,
@ C_Code.c:400: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	movs	r3, #75	@ tmp159,
@ C_Code.c:400: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldrb	r3, [r4, r3]	@ tmp160,
	cmp	r3, #0	@ tmp160,
	bne	.L105		@,
.L62:
@ C_Code.c:402: 	int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); //OAM2_CHR(0);
	lsls	r6, r6, #28	@ tmp158, palID,
	lsrs	r6, r6, #16	@ _78, tmp158,
.L61:
@ C_Code.c:403: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	r2, r9	@ x, x
	movs	r4, #255	@ tmp161,
	ldr	r3, .L114+4	@ tmp230,
	mov	r8, r3	@ tmp230, tmp230
	ands	r4, r7	@ tmp161, y
	lsls	r1, r2, #23	@ tmp165, x,
	mov	fp, r4	@ _11, tmp161
	movs	r2, r4	@, _11
	movs	r0, #2	@,
	ldr	r4, .L114+8	@ tmp231,
	adds	r3, r3, #32	@ tmp163,
	lsrs	r1, r1, #23	@ tmp164, tmp165,
	str	r6, [sp]	@ _78,
	bl	.L116		@
@ C_Code.c:404: 	x += 32; 
	mov	r1, r9	@ x, x
@ C_Code.c:405: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	mov	r3, r8	@ tmp168, tmp230
@ C_Code.c:404: 	x += 32; 
	adds	r1, r1, #32	@ x,
@ C_Code.c:405: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	lsls	r1, r1, #23	@ tmp171, x,
	mov	r2, fp	@, _11
	adds	r3, r3, #40	@ tmp168,
	lsrs	r1, r1, #23	@ tmp170, tmp171,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	bl	.L116		@
	mov	r3, r8	@ ivtmp.100, tmp230
	mov	r1, r8	@ _76, tmp230
@ C_Code.c:403: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	r10, r4	@ tmp231, tmp231
@ C_Code.c:343: 	int c = 0; 
	movs	r2, #0	@ c,
@ C_Code.c:406: 	y += 16; x -= 36; 
	adds	r7, r7, #16	@ y,
	adds	r3, r3, #48	@ ivtmp.100,
	adds	r1, r1, #54	@ _76,
.L64:
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r4, [r3]	@ MEM[(unsigned char *)_96], MEM[(unsigned char *)_96]
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ands	r4, r5	@ tmp175, keys
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r0, r4, #1	@ tmp234, tmp175
	sbcs	r4, r4, r0	@ tmp233, tmp175, tmp234
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	adds	r3, r3, #1	@ ivtmp.100,
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	adds	r2, r2, r4	@ c, c, tmp233
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	cmp	r1, r3	@ _76, ivtmp.100
	bne	.L64		@,
@ C_Code.c:409: 	if (count == 1) { x += 16; } // centering 
	cmp	r2, #1	@ c,
	beq	.L106		@,
@ C_Code.c:410: 	if (count == 2) { x += 8; } 
	mov	r3, r9	@ x, x
	adds	r4, r3, #4	@ x, x,
@ C_Code.c:410: 	if (count == 2) { x += 8; } 
	cmp	r2, #2	@ c,
	bne	.L107		@,
.L66:
@ C_Code.c:413: 	if (keys & A_BUTTON) { 
	lsls	r3, r5, #31	@ tmp241, keys,
	bmi	.L108		@,
.L68:
@ C_Code.c:416: 	if (keys & B_BUTTON) { 
	lsls	r3, r5, #30	@ tmp242, keys,
	bmi	.L109		@,
.L69:
@ C_Code.c:419: 	if (keys & DPAD_LEFT) { 
	lsls	r3, r5, #26	@ tmp243, keys,
	bmi	.L110		@,
.L70:
@ C_Code.c:422: 	if (keys & DPAD_RIGHT) { 
	lsls	r3, r5, #27	@ tmp244, keys,
	bmi	.L111		@,
.L71:
@ C_Code.c:425: 	if (keys & DPAD_UP) { 
	lsls	r3, r5, #25	@ tmp245, keys,
	bmi	.L112		@,
.L72:
@ C_Code.c:428: 	if (keys & DPAD_DOWN) { 
	lsls	r5, r5, #24	@ tmp246, keys,
	bmi	.L113		@,
.L59:
@ C_Code.c:435: } 
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
.L105:
	movs	r6, #224	@ _78,
	lsls	r6, r6, #8	@ _78, _78,
	b	.L61		@
.L106:
@ C_Code.c:409: 	if (count == 1) { x += 16; } // centering 
	mov	r4, r9	@ x, x
	adds	r4, r4, #12	@ x,
@ C_Code.c:413: 	if (keys & A_BUTTON) { 
	lsls	r3, r5, #31	@ tmp241, keys,
	bpl	.L68		@,
.L108:
@ C_Code.c:414: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	mov	r3, r8	@ tmp179, tmp230
	movs	r2, #255	@ tmp180,
	lsls	r1, r4, #23	@ tmp183, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #56	@ tmp179,
	ands	r2, r7	@ tmp181, y
	lsrs	r1, r1, #23	@ tmp182, tmp183,
	bl	.L58		@
@ C_Code.c:414: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:416: 	if (keys & B_BUTTON) { 
	lsls	r3, r5, #30	@ tmp242, keys,
	bpl	.L69		@,
.L109:
@ C_Code.c:417: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	mov	r3, r8	@ tmp188, tmp230
	movs	r2, #255	@ tmp189,
	lsls	r1, r4, #23	@ tmp192, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #64	@ tmp188,
	ands	r2, r7	@ tmp190, y
	lsrs	r1, r1, #23	@ tmp191, tmp192,
	bl	.L58		@
@ C_Code.c:417: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:419: 	if (keys & DPAD_LEFT) { 
	lsls	r3, r5, #26	@ tmp243, keys,
	bpl	.L70		@,
.L110:
@ C_Code.c:420: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	mov	r3, r8	@ tmp197, tmp230
	movs	r2, #255	@ tmp198,
	lsls	r1, r4, #23	@ tmp201, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #72	@ tmp197,
	ands	r2, r7	@ tmp199, y
	lsrs	r1, r1, #23	@ tmp200, tmp201,
	bl	.L58		@
@ C_Code.c:420: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:422: 	if (keys & DPAD_RIGHT) { 
	lsls	r3, r5, #27	@ tmp244, keys,
	bpl	.L71		@,
.L111:
@ C_Code.c:423: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	mov	r3, r8	@ tmp206, tmp230
	movs	r2, #255	@ tmp207,
	lsls	r1, r4, #23	@ tmp210, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #80	@ tmp206,
	ands	r2, r7	@ tmp208, y
	lsrs	r1, r1, #23	@ tmp209, tmp210,
	bl	.L58		@
@ C_Code.c:423: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:425: 	if (keys & DPAD_UP) { 
	lsls	r3, r5, #25	@ tmp245, keys,
	bpl	.L72		@,
.L112:
@ C_Code.c:426: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	mov	r3, r8	@ tmp215, tmp230
	movs	r2, #255	@ tmp216,
	lsls	r1, r4, #23	@ tmp219, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #88	@ tmp215,
	ands	r2, r7	@ tmp217, y
	lsrs	r1, r1, #23	@ tmp218, tmp219,
	bl	.L58		@
@ C_Code.c:426: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:428: 	if (keys & DPAD_DOWN) { 
	lsls	r5, r5, #24	@ tmp246, keys,
	bpl	.L59		@,
.L113:
@ C_Code.c:429: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2); x += 18; 
	mov	r3, r8	@ tmp230, tmp230
	movs	r2, #255	@ tmp225,
	lsls	r1, r4, #23	@ tmp228, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #96	@ tmp230,
	ands	r2, r7	@ tmp226, y
	lsrs	r1, r1, #23	@ tmp227, tmp228,
	bl	.L58		@
	b	.L59		@
.L107:
@ C_Code.c:406: 	y += 16; x -= 36; 
	subs	r4, r4, #8	@ x,
	b	.L66		@
.L115:
	.align	2
.L114:
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
	.type	CountKeysPressed, %function
CountKeysPressed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r1, .L123	@ tmp122,
	movs	r2, r1	@ ivtmp.111, tmp122
	push	{r4, r5, lr}	@
@ C_Code.c:342: int CountKeysPressed(u32 keys) { 
	movs	r4, r0	@ keys, tmp129
@ C_Code.c:343: 	int c = 0; 
	movs	r0, #0	@ <retval>,
	adds	r2, r2, #48	@ ivtmp.111,
	adds	r1, r1, #54	@ _15,
.L119:
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r3, [r2]	@ MEM[(unsigned char *)_34], MEM[(unsigned char *)_34]
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ands	r3, r4	@ tmp124, keys
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r5, r3, #1	@ tmp128, tmp124
	sbcs	r3, r3, r5	@ tmp127, tmp124, tmp128
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	adds	r2, r2, #1	@ ivtmp.111,
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	adds	r0, r0, r3	@ <retval>, <retval>, tmp127
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	cmp	r2, r1	@ ivtmp.111, _15
	bne	.L119		@,
@ C_Code.c:349: } 
	@ sp needed	@
	pop	{r4, r5}
	pop	{r1}
	bx	r1
.L124:
	.align	2
.L123:
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
	push	{r3, r4, r5, r6, r7, lr}	@
@ C_Code.c:351: int PressedSpecificKeys(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r1	@ keys, tmp180
@ C_Code.c:352: 	int reqKeys = GetButtonsToPress(proc); 
	bl	GetButtonsToPress		@
	ldr	r5, .L151	@ tmp150,
	movs	r2, r5	@ ivtmp.134, tmp150
	adds	r2, r2, #48	@ ivtmp.134,
	mov	ip, r0	@ reqKeys, tmp181
@ C_Code.c:353: 	int count = CountKeysPressed(reqKeys); 
	movs	r1, r2	@ ivtmp.146, ivtmp.134
@ C_Code.c:343: 	int c = 0; 
	movs	r6, #0	@ c,
	adds	r5, r5, #54	@ _58,
.L127:
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	mov	r0, ip	@ reqKeys, reqKeys
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r3, [r1]	@ MEM[(unsigned char *)_148], MEM[(unsigned char *)_148]
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ands	r3, r0	@ tmp152, reqKeys
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r7, r3, #1	@ tmp169, tmp152
	sbcs	r3, r3, r7	@ tmp168, tmp152, tmp169
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	adds	r1, r1, #1	@ ivtmp.146,
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	adds	r6, r6, r3	@ c, c, tmp168
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	cmp	r5, r1	@ _58, ivtmp.146
	bne	.L127		@,
	movs	r1, r2	@ ivtmp.140, ivtmp.134
@ C_Code.c:343: 	int c = 0; 
	movs	r7, #0	@ c,
.L129:
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r3, [r1]	@ MEM[(unsigned char *)_124], MEM[(unsigned char *)_124]
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ands	r3, r4	@ tmp154, keys
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r0, r3, #1	@ tmp172, tmp154
	sbcs	r3, r3, r0	@ tmp171, tmp154, tmp172
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	adds	r1, r1, #1	@ ivtmp.140,
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	adds	r7, r7, r3	@ c, c, tmp171
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	cmp	r5, r1	@ _58, ivtmp.140
	bne	.L129		@,
@ C_Code.c:343: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:354: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r6, r7	@ c, c
	blt	.L130		@,
.L132:
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r3, [r2]	@ MEM[(unsigned char *)_88], MEM[(unsigned char *)_88]
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ands	r3, r4	@ tmp156, keys
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r7, r3, #1	@ tmp175, tmp156
	sbcs	r3, r3, r7	@ tmp174, tmp156, tmp175
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	adds	r2, r2, #1	@ ivtmp.134,
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp174
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	cmp	r2, r5	@ ivtmp.134, _58
	bne	.L132		@,
@ C_Code.c:354: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r6, r1	@ tmp157, c, c
@ C_Code.c:354: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp157,
	bgt	.L138		@,
.L134:
@ C_Code.c:355: 	reqKeys &= ~keys; // only 0 if we hit all the correct keys (and possibly 1 extra) 
	mov	r0, ip	@ reqKeys, reqKeys
	bics	r0, r4	@ reqKeys, keys
@ C_Code.c:356: 	return (!reqKeys); 
	rsbs	r3, r0, #0	@ tmp165, reqKeys
	adcs	r0, r0, r3	@ <retval>, reqKeys, tmp165
.L125:
@ C_Code.c:357: } 
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L130:
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ldrb	r3, [r2]	@ MEM[(unsigned char *)_69], MEM[(unsigned char *)_69]
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	ands	r3, r4	@ tmp159, keys
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	subs	r7, r3, #1	@ tmp178, tmp159
	sbcs	r3, r3, r7	@ tmp177, tmp159, tmp178
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	adds	r2, r2, #1	@ ivtmp.134,
@ C_Code.c:345: 		if (keys & RomKeysList[i]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp177
@ C_Code.c:344: 	for (int i = 0; i < 6; ++i) { 
	cmp	r2, r5	@ ivtmp.134, _58
	bne	.L130		@,
@ C_Code.c:354: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r1, r6	@ tmp160, c, c
@ C_Code.c:354: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp160,
	ble	.L134		@,
.L138:
@ C_Code.c:354: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	movs	r0, #0	@ <retval>,
	b	.L125		@
.L152:
	.align	2
.L151:
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
@ C_Code.c:359: 	struct Anim* anim = proc->anim; 
	ldr	r5, [r0, #44]	@ anim, proc_17(D)->anim
@ C_Code.c:360: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:360: 	u32 instruction = *anim->pScrCurrent++; 
	adds	r3, r6, #4	@ tmp130, _1,
	str	r3, [r5, #32]	@ tmp130, anim_18->pScrCurrent
@ C_Code.c:361: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	movs	r3, #252	@ tmp132,
@ C_Code.c:358: void SaveInputFrame(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r0	@ proc, tmp155
@ C_Code.c:361: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	movs	r0, #160	@ tmp133,
@ C_Code.c:360: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r2, [r6]	@ instruction, *_1
@ C_Code.c:361: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	lsls	r3, r3, #22	@ tmp132, tmp132,
	ands	r3, r2	@ tmp131, instruction
	lsls	r0, r0, #19	@ tmp133, tmp133,
	cmp	r3, r0	@ tmp131, tmp133
	beq	.L160		@,
.L154:
@ C_Code.c:370: 	if (PressedSpecificKeys(proc, keys)) { 
	movs	r0, r4	@, proc
@ C_Code.c:369: 	instruction = *anim->pScrCurrent--; 
	str	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:370: 	if (PressedSpecificKeys(proc, keys)) { 
	bl	PressedSpecificKeys		@
@ C_Code.c:370: 	if (PressedSpecificKeys(proc, keys)) { 
	cmp	r0, #0	@ tmp157,
	beq	.L153		@,
@ C_Code.c:371: 		if (!proc->frame) { 
	movs	r3, #75	@ tmp147,
@ C_Code.c:371: 		if (!proc->frame) { 
	ldrb	r2, [r4, r3]	@ tmp148,
	cmp	r2, #0	@ tmp148,
	beq	.L161		@,
.L153:
@ C_Code.c:376: }  
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L160:
@ C_Code.c:362: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	movs	r3, #255	@ tmp134,
	ands	r3, r2	@ _4, instruction
@ C_Code.c:362: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	cmp	r3, #4	@ _4,
	beq	.L162		@,
@ C_Code.c:365: 		if (ANINS_COMMAND_GET_ID(instruction) == 0xF) {
	cmp	r3, #15	@ _4,
	bne	.L154		@,
@ C_Code.c:366: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #62	@ tmp143,
	strb	r2, [r4, r3]	@ proc_17(D)->timer, proc_17(D)->codefframe
@ C_Code.c:366: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	movs	r2, #0	@ tmp145,
	subs	r3, r3, #9	@ tmp144,
	strb	r2, [r4, r3]	@ tmp145, proc_17(D)->timer2
	b	.L154		@
.L161:
@ C_Code.c:373: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	movs	r1, #128	@,
	movs	r0, #159	@,
@ C_Code.c:372: 			proc->frame = proc->timer; // locate is side for stereo? 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
@ C_Code.c:373: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r1, r1, #1	@,,
@ C_Code.c:372: 			proc->frame = proc->timer; // locate is side for stereo? 
	strb	r2, [r4, r3]	@ proc_17(D)->timer, proc_17(D)->frame
@ C_Code.c:373: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r0, r0, #1	@,,
	movs	r2, #120	@,
	ldr	r4, .L163	@ tmp154,
	subs	r3, r3, #74	@,
	bl	.L116		@
@ C_Code.c:376: }  
	b	.L153		@
.L162:
@ C_Code.c:363: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #72	@ tmp137,
	strb	r2, [r4, r3]	@ proc_17(D)->timer, proc_17(D)->code4frame
@ C_Code.c:363: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	movs	r2, #0	@ tmp139,
	subs	r3, r3, #8	@ tmp138,
	strb	r2, [r4, r3]	@ tmp139, proc_17(D)->timer2
	b	.L154		@
.L164:
	.align	2
.L163:
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
@ C_Code.c:378: 	if (proc->frame) { 
	movs	r3, #75	@ tmp128,
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:377: void SaveIfWeHitOnTime(TimedHitsProc* proc) {
	push	{r4, lr}	@
@ C_Code.c:378: 	if (proc->frame) { 
	cmp	r3, #0	@ _1,
	beq	.L165		@,
@ C_Code.c:379: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #77	@ tmp129,
@ C_Code.c:379: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, .L176	@ tmp130,
@ C_Code.c:379: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldrb	r2, [r0, r2]	@ _2,
@ C_Code.c:379: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, [r1]	@ pretmp_33, LenienceFrames
@ C_Code.c:379: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, #255	@ _2,
	beq	.L168		@,
.L175:
@ C_Code.c:379: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	subs	r2, r2, r3	@ tmp131, _2, _1
	asrs	r4, r2, #31	@ tmp147, tmp131,
	adds	r2, r2, r4	@ tmp132, tmp131, tmp147
	eors	r2, r4	@ tmp132, tmp147
@ C_Code.c:379: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, r1	@ tmp132, pretmp_33
	bge	.L169		@,
@ C_Code.c:379: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #69	@ tmp133,
	movs	r4, #1	@ tmp134,
	strb	r4, [r0, r2]	@ tmp134, proc_21(D)->hitOnTime
.L169:
@ C_Code.c:381: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	ldr	r2, [r0, #52]	@ proc_21(D)->timer, proc_21(D)->timer
	subs	r3, r2, r3	@ tmp139, proc_21(D)->timer, _1
@ C_Code.c:381: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	cmp	r3, r1	@ tmp139, pretmp_33
	bge	.L165		@,
@ C_Code.c:381: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	movs	r3, #69	@ tmp141,
	movs	r2, #1	@ tmp142,
	strb	r2, [r0, r3]	@ tmp142, proc_21(D)->hitOnTime
.L165:
@ C_Code.c:384: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L168:
@ C_Code.c:380: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	movs	r2, #76	@ tmp136,
	ldrb	r2, [r0, r2]	@ _8,
@ C_Code.c:380: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	cmp	r2, #255	@ _8,
	bne	.L175		@,
	b	.L169		@
.L177:
	.align	2
.L176:
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
@ C_Code.c:387: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L179	@ tmp118,
@ C_Code.c:388: } 
	@ sp needed	@
@ C_Code.c:387: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldrb	r0, [r3, #31]	@ tmp120,
	movs	r3, #127	@ tmp122,
	bics	r0, r3	@ tmp117, tmp122
@ C_Code.c:388: } 
	bx	lr
.L180:
	.align	2
.L179:
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
@ C_Code.c:387: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L185	@ tmp120,
@ C_Code.c:391: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp123,
	cmp	r3, #127	@ tmp123,
	bhi	.L184		@,
@ C_Code.c:392: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L185+4	@ tmp124,
@ C_Code.c:392: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L184		@,
@ C_Code.c:393: 	return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp126,
	ldrb	r0, [r0, r3]	@ <retval>,
	b	.L181		@
.L184:
@ C_Code.c:391: 	if (CheatCodeOn()) { return true; } 
	movs	r0, #1	@ <retval>,
.L181:
@ C_Code.c:394: }
	@ sp needed	@
	bx	lr
.L186:
	.align	2
.L185:
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ C_Code.c:397: 	if (!DisplayPress) { return; } 
	ldr	r4, .L192	@ tmp119,
@ C_Code.c:397: 	if (!DisplayPress) { return; } 
	ldr	r4, [r4]	@ DisplayPress, DisplayPress
	cmp	r4, #0	@ DisplayPress,
	beq	.L187		@,
	bl	DrawButtonsToPress.part.0		@
.L187:
@ C_Code.c:435: } 
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L193:
	.align	2
.L192:
	.word	DisplayPress
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
@ C_Code.c:518: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp122,
	movs	r3, #192	@ tmp123,
	ldrsb	r1, [r0, r1]	@ tmp122,
	ands	r3, r1	@ _14, tmp122
@ C_Code.c:517: 	if (success) { 
	cmp	r2, #0	@ tmp131,
	beq	.L195		@,
@ C_Code.c:518: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _14,
	bne	.L196		@,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L200	@ tmp124,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L199		@,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L200+4	@ tmp126,
	ldr	r0, [r3]	@ <retval>,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L194		@
.L195:
@ C_Code.c:524: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _14,
	beq	.L199		@,
@ C_Code.c:527: 	return FailedHitDamagePercent; 
	ldr	r3, .L200+8	@ tmp128,
	ldr	r0, [r3]	@ <retval>,
.L194:
@ C_Code.c:528: } 
	@ sp needed	@
	bx	lr
.L196:
@ C_Code.c:522: 		return BonusDamagePercent; 
	ldr	r3, .L200+12	@ tmp127,
	ldr	r0, [r3]	@ <retval>,
	b	.L194		@
.L199:
@ C_Code.c:520: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
	b	.L194		@
.L201:
	.align	2
.L200:
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
@ C_Code.c:518: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp122,
	movs	r3, #192	@ tmp123,
	ldrsb	r1, [r0, r1]	@ tmp122,
	ands	r3, r1	@ _9, tmp122
@ C_Code.c:517: 	if (success) { 
	cmp	r2, #0	@ tmp131,
	beq	.L203		@,
@ C_Code.c:518: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _9,
	bne	.L204		@,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L208	@ tmp124,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L207		@,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L208+4	@ tmp126,
	ldr	r0, [r3]	@ <retval>,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L202		@
.L203:
@ C_Code.c:524: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _9,
	beq	.L207		@,
@ C_Code.c:527: 	return FailedHitDamagePercent; 
	ldr	r3, .L208+8	@ tmp128,
	ldr	r0, [r3]	@ <retval>,
.L202:
@ C_Code.c:532: } 
	@ sp needed	@
	bx	lr
.L204:
@ C_Code.c:522: 		return BonusDamagePercent; 
	ldr	r3, .L208+12	@ tmp127,
	ldr	r0, [r3]	@ <retval>,
	b	.L202		@
.L207:
@ C_Code.c:520: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
@ C_Code.c:531: 	return GetDefaultDamagePercent(active_bunit, opp_bunit, success); 
	b	.L202		@
.L209:
	.align	2
.L208:
	.word	BlockingEnabled
	.word	ReducedDamagePercent
	.word	FailedHitDamagePercent
	.word	BonusDamagePercent
	.size	GetDamagePercent, .-GetDamagePercent
	.align	1
	.p2align 2,,3
	.global	AdjustCurrentRound
	.syntax unified
	.code	16
	.thumb_func
	.type	AdjustCurrentRound, %function
AdjustCurrentRound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}	@
@ C_Code.c:547: 	for (int i = id; i < 22; i += 2) {
	cmp	r0, #21	@ id,
	bgt	.L210		@,
	ldr	r3, .L220	@ tmp128,
	lsls	r2, r0, #1	@ tmp127, id,
@ C_Code.c:549: 		if (hp == 0xffff) { break; }
	ldr	r5, .L220+4	@ tmp129,
	adds	r2, r2, r3	@ ivtmp.176, tmp127, tmp128
	b	.L214		@
.L212:
	movs	r4, #0	@ _4,
@ C_Code.c:551: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	cmp	r3, r1	@ _1, difference
	blt	.L213		@,
@ C_Code.c:551: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	subs	r3, r3, r1	@ tmp132, _1, difference
.L218:
	lsls	r3, r3, #16	@ tmp133, tmp132,
	lsrs	r4, r3, #16	@ _4, tmp133,
.L213:
@ C_Code.c:547: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:550: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:547: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.176,
	cmp	r0, #21	@ id,
	bgt	.L210		@,
.L214:
@ C_Code.c:548: 		hp = gEfxHpLut[i]; 
	ldrh	r3, [r2]	@ _1, MEM[(short unsigned int *)_18]
@ C_Code.c:549: 		if (hp == 0xffff) { break; }
	cmp	r3, r5	@ _1, tmp129
	beq	.L210		@,
@ C_Code.c:550: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r1, #0	@ difference,
	bge	.L212		@,
@ C_Code.c:550: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	adds	r3, r3, r1	@ hp, _1, difference
	movs	r4, #0	@ _4,
@ C_Code.c:550: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r3, #0	@ hp,
	bgt	.L218		@,
@ C_Code.c:547: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:550: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:547: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.176,
	cmp	r0, #21	@ id,
	ble	.L214		@,
.L210:
@ C_Code.c:555: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L221:
	.align	2
.L220:
	.word	gEfxHpLut
	.word	65535
	.size	AdjustCurrentRound, .-AdjustCurrentRound
	.align	1
	.p2align 2,,3
	.global	UpdateHP
	.syntax unified
	.code	16
	.thumb_func
	.type	UpdateHP, %function
UpdateHP:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
@ C_Code.c:559: 	if (newHp < 0) { newHp = 0; } 
	mvns	r4, r3	@ tmp159, newHp
@ C_Code.c:560: 	int hp = gEkrGaugeHp[side];
	ldr	r5, [sp, #20]	@ tmp171, side
@ C_Code.c:559: 	if (newHp < 0) { newHp = 0; } 
	asrs	r4, r4, #31	@ tmp158, tmp159,
	ands	r3, r4	@ _15, tmp158
@ C_Code.c:560: 	int hp = gEkrGaugeHp[side];
	ldr	r4, .L230	@ tmp136,
	lsls	r5, r5, #1	@ tmp137, tmp171,
	ldrsh	r4, [r5, r4]	@ _1, gEkrGaugeHp
@ C_Code.c:561: 	some_bunit->unit.curHP = newHp; 
	strb	r3, [r2, #19]	@ _15, some_bunit_23(D)->unit.curHP
@ C_Code.c:562: 	if (hp == newHp) { return; } 
	cmp	r3, r4	@ _15, _1
	beq	.L222		@,
@ C_Code.c:565: 	if (proc->side == side) { 
	movs	r2, #74	@ tmp139,
@ C_Code.c:565: 	if (proc->side == side) { 
	ldr	r5, [sp, #20]	@ tmp172, side
@ C_Code.c:565: 	if (proc->side == side) { 
	ldrb	r2, [r0, r2]	@ tmp140,
@ C_Code.c:565: 	if (proc->side == side) { 
	cmp	r2, r5	@ tmp140, tmp172
	beq	.L229		@,
.L222:
@ C_Code.c:580: }
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L229:
@ C_Code.c:566: 		if (UsingSkillSys) { // uggggh 
	ldr	r2, .L230+4	@ tmp141,
@ C_Code.c:563: 	int diff = newHp - hp; 
	subs	r7, r3, r4	@ diff, _15, _1
@ C_Code.c:566: 		if (UsingSkillSys) { // uggggh 
	ldr	r6, [r2]	@ UsingSkillSys.24_5, UsingSkillSys
@ C_Code.c:577: 		proc->currentRound->hpChange = ABS(diff); 
	ldr	r2, [r0, #56]	@ pretmp_41, proc_26(D)->currentRound
@ C_Code.c:577: 		proc->currentRound->hpChange = ABS(diff); 
	asrs	r0, r7, #31	@ tmp167, diff,
@ C_Code.c:577: 		proc->currentRound->hpChange = ABS(diff); 
	mov	ip, r2	@ pretmp_41, pretmp_41
@ C_Code.c:577: 		proc->currentRound->hpChange = ABS(diff); 
	adds	r2, r7, r0	@ tmp142, diff, tmp167
	eors	r2, r0	@ tmp142, tmp167
@ C_Code.c:568: 			HpProc->post = newHp;
	lsls	r5, r3, #16	@ _36, _15,
@ C_Code.c:577: 		proc->currentRound->hpChange = ABS(diff); 
	lsls	r2, r2, #24	@ tmp143, tmp142,
@ C_Code.c:568: 			HpProc->post = newHp;
	asrs	r5, r5, #16	@ _36, _36,
@ C_Code.c:577: 		proc->currentRound->hpChange = ABS(diff); 
	asrs	r2, r2, #24	@ _42, tmp143,
@ C_Code.c:566: 		if (UsingSkillSys) { // uggggh 
	cmp	r6, #0	@ UsingSkillSys.24_5,
	beq	.L227		@,
@ C_Code.c:568: 			HpProc->post = newHp;
	movs	r3, #80	@ tmp145,
@ C_Code.c:567: 			HpProc->cur = hp; 
	strh	r4, [r1, #46]	@ _1, HpProc_27(D)->cur
@ C_Code.c:568: 			HpProc->post = newHp;
	strh	r5, [r1, r3]	@ _36, HpProc_27(D)->post
@ C_Code.c:577: 		proc->currentRound->hpChange = ABS(diff); 
	mov	r3, ip	@ pretmp_41, pretmp_41
	strb	r2, [r3, #3]	@ _42, pretmp_41->hpChange
@ C_Code.c:578: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	cmp	r6, #2	@ UsingSkillSys.24_5,
	bne	.L222		@,
@ C_Code.c:578: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	strh	r7, [r3, #6]	@ diff, pretmp_41->overDmg
	b	.L222		@
.L227:
@ C_Code.c:571: 			HpProc->postHpAtkrSS = newHp; 
	movs	r6, #82	@ tmp148,
	strh	r5, [r1, r6]	@ _36, HpProc_27(D)->postHpAtkrSS
@ C_Code.c:572: 			HpProc->post = newHp>>16; 
	movs	r5, #80	@ tmp151,
@ C_Code.c:572: 			HpProc->post = newHp>>16; 
	asrs	r3, r3, #16	@ tmp150, _15,
@ C_Code.c:572: 			HpProc->post = newHp>>16; 
	strh	r3, [r1, r5]	@ tmp150, HpProc_27(D)->post
@ C_Code.c:573: 			HpProc->cur = hp>>16; 
	asrs	r3, r4, #16	@ tmp153, _1,
@ C_Code.c:573: 			HpProc->cur = hp>>16; 
	strh	r3, [r1, #46]	@ tmp153, HpProc_27(D)->cur
@ C_Code.c:577: 		proc->currentRound->hpChange = ABS(diff); 
	mov	r3, ip	@ pretmp_41, pretmp_41
@ C_Code.c:574: 			HpProc->curHpAtkrSS = hp; 
	strh	r4, [r1, #48]	@ _1, HpProc_27(D)->curHpAtkrSS
@ C_Code.c:577: 		proc->currentRound->hpChange = ABS(diff); 
	strb	r2, [r3, #3]	@ _42, pretmp_41->hpChange
	b	.L222		@
.L231:
	.align	2
.L230:
	.word	gEkrGaugeHp
	.word	UsingSkillSys
	.size	UpdateHP, .-UpdateHP
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
	movs	r7, r2	@ active_bunit, tmp208
	movs	r2, r3	@ opp_bunit, tmp209
@ C_Code.c:585: 	int side = proc->side; 
	movs	r3, #74	@ tmp148,
@ C_Code.c:584: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	push	{lr}	@
	sub	sp, sp, #8	@,,
@ C_Code.c:584: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	movs	r6, r1	@ HpProc, tmp207
@ C_Code.c:585: 	int side = proc->side; 
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:584: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	ldr	r1, [sp, #36]	@ hp, hp
	movs	r5, r0	@ proc, tmp206
@ C_Code.c:585: 	int side = proc->side; 
	mov	r8, r3	@ _1, _1
@ C_Code.c:587: 	if (hp < 0) { hp = gEkrGaugeHp[side]; } 
	cmp	r1, #0	@ hp,
	bge	.L233		@,
@ C_Code.c:587: 	if (hp < 0) { hp = gEkrGaugeHp[side]; } 
	mov	r1, r8	@ _1, _1
	ldr	r3, .L240	@ tmp149,
	lsls	r1, r1, #1	@ tmp150, _1,
@ C_Code.c:587: 	if (hp < 0) { hp = gEkrGaugeHp[side]; } 
	ldrsh	r1, [r1, r3]	@ hp, gEkrGaugeHp
.L233:
@ C_Code.c:588: 	if (hp <= 0) { // they are dead 
	cmp	r1, #0	@ hp,
	ble	.L238		@,
.L234:
@ C_Code.c:635: 	BattleApplyExpGains();  // update exp 
	ldr	r3, .L240+4	@ tmp192,
	bl	.L10		@
@ C_Code.c:636: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	ldr	r2, .L240+8	@ tmp195,
	ldr	r1, [r2]	@ gpEkrBattleUnitLeft, gpEkrBattleUnitLeft
	movs	r2, #110	@ tmp196,
@ C_Code.c:636: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	ldr	r3, .L240+12	@ tmp193,
@ C_Code.c:636: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	ldrsb	r1, [r1, r2]	@ tmp198,
@ C_Code.c:636: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	strh	r1, [r3]	@ tmp198, gBanimExpGain[0]
@ C_Code.c:637: 	gBanimExpGain[1] = gpEkrBattleUnitRight->expGain; 
	ldr	r1, .L240+16	@ tmp201,
	ldr	r1, [r1]	@ gpEkrBattleUnitRight, gpEkrBattleUnitRight
	ldrsb	r2, [r1, r2]	@ tmp204,
@ C_Code.c:637: 	gBanimExpGain[1] = gpEkrBattleUnitRight->expGain; 
	strh	r2, [r3, #2]	@ tmp204, gBanimExpGain[1]
@ C_Code.c:639: }
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L238:
@ C_Code.c:590: 		UpdateHP(proc, HpProc, opp_bunit, hp, side); 
	mov	r3, r8	@ _1, _1
	movs	r1, r6	@, HpProc
	movs	r0, r5	@, proc
	str	r3, [sp]	@ _1,
	movs	r3, #0	@,
	bl	UpdateHP		@
@ C_Code.c:592: 		proc->code4frame = 0xff;
	movs	r3, #76	@ tmp151,
	movs	r2, #255	@ tmp152,
@ C_Code.c:610: 		struct SkillSysBattleHit* nextRound = GetCurrentRound(proc->roundId + 1); 
	movs	r4, #70	@ tmp164,
@ C_Code.c:592: 		proc->code4frame = 0xff;
	strb	r2, [r5, r3]	@ tmp152, proc_25(D)->code4frame
@ C_Code.c:597: 		HpProc->death = true; 
	subs	r3, r3, #35	@ tmp154,
	subs	r2, r2, #254	@ tmp155,
	strb	r2, [r6, r3]	@ tmp155, HpProc_30(D)->death
@ C_Code.c:608: 		round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END; 
	ldr	r3, [sp, #32]	@ tmp222, round
	ldrb	r3, [r3, #2]	@ tmp160,
	adds	r2, r2, #175	@ tmp157,
	orrs	r3, r2	@ tmp162, tmp157
	ldr	r2, [sp, #32]	@ tmp223, round
	strb	r3, [r2, #2]	@ tmp162,
@ C_Code.c:610: 		struct SkillSysBattleHit* nextRound = GetCurrentRound(proc->roundId + 1); 
	ldrb	r0, [r5, r4]	@ tmp165,
@ C_Code.c:610: 		struct SkillSysBattleHit* nextRound = GetCurrentRound(proc->roundId + 1); 
	ldr	r3, .L240+20	@ tmp167,
	adds	r0, r0, #1	@ tmp166,
	bl	.L10		@
@ C_Code.c:611: 		nextRound->info = BATTLE_HIT_INFO_END; 
	movs	r3, #7	@ tmp173,
	ldrh	r2, [r0, #2]	@ MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_38 + 2B], MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_38 + 2B]
	ands	r3, r2	@ tmp172, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_38 + 2B]
	movs	r2, #128	@ tmp174,
	orrs	r3, r2	@ tmp177, tmp174
	strh	r3, [r0, #2]	@ tmp177, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_38 + 2B]
@ C_Code.c:615: 		u16* animRound = &GetAnimRoundData()[0]; 
	ldr	r3, .L240+24	@ tmp179,
	bl	.L10		@
@ C_Code.c:616: 		for (int i = proc->roundId; i < 32; ++i) { 
	ldrb	r3, [r5, r4]	@ i,
@ C_Code.c:616: 		for (int i = proc->roundId; i < 32; ++i) { 
	cmp	r3, #31	@ i,
	bgt	.L235		@,
@ C_Code.c:618: 			animRound[i] = 0xFFFF; 
	movs	r2, #1	@ tmp205,
	rsbs	r2, r2, #0	@ tmp205, tmp205
	mov	ip, r2	@ tmp205, tmp205
@ C_Code.c:617: 			if (animRound[i] == 0xFFFF) { break; } 
	ldr	r1, .L240+28	@ tmp182,
	b	.L236		@
.L239:
@ C_Code.c:618: 			animRound[i] = 0xFFFF; 
	mov	r2, ip	@ tmp205, tmp205
@ C_Code.c:616: 		for (int i = proc->roundId; i < 32; ++i) { 
	adds	r3, r3, #1	@ i,
@ C_Code.c:618: 			animRound[i] = 0xFFFF; 
	strh	r2, [r0, r4]	@ tmp205, MEM[(u16 *)animRound_42 + _65 * 1]
@ C_Code.c:616: 		for (int i = proc->roundId; i < 32; ++i) { 
	cmp	r3, #32	@ i,
	beq	.L235		@,
.L236:
	lsls	r4, r3, #1	@ _65, i,
@ C_Code.c:617: 			if (animRound[i] == 0xFFFF) { break; } 
	ldrh	r2, [r0, r4]	@ MEM[(u16 *)animRound_42 + _65 * 1], MEM[(u16 *)animRound_42 + _65 * 1]
	cmp	r2, r1	@ MEM[(u16 *)animRound_42 + _65 * 1], tmp182
	bne	.L239		@,
.L235:
@ C_Code.c:625: 		side = 1 ^ side; 
	movs	r2, #1	@ tmp188,
	mov	r3, r8	@ _1, _1
	eors	r3, r2	@ _1, tmp188
	movs	r2, r3	@ side, _1
@ C_Code.c:626: 		hp = gEkrGaugeHp[side];
	ldr	r3, .L240	@ tmp189,
	lsls	r1, r2, #1	@ tmp190, side,
@ C_Code.c:626: 		hp = gEkrGaugeHp[side];
	ldrsh	r3, [r1, r3]	@ hp, gEkrGaugeHp
@ C_Code.c:627: 		UpdateHP(proc, HpProc, active_bunit, hp, side); 
	movs	r0, r5	@, proc
	str	r2, [sp]	@ side,
	movs	r1, r6	@, HpProc
	movs	r2, r7	@, active_bunit
	bl	UpdateHP		@
	b	.L234		@
.L241:
	.align	2
.L240:
	.word	gEkrGaugeHp
	.word	BattleApplyExpGains
	.word	gpEkrBattleUnitLeft
	.word	gBanimExpGain
	.word	gpEkrBattleUnitRight
	.word	GetCurrentRound
	.word	GetAnimRoundData
	.word	65535
	.size	CheckForDeath, .-CheckForDeath
	.global	__aeabi_idiv
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
	push	{r4, r5, r6, r7, lr}	@
	mov	r5, r8	@,
	mov	r7, r10	@,
	mov	r6, r9	@,
	mov	lr, fp	@,
	push	{r5, r6, r7, lr}	@
@ C_Code.c:643: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r5, [r0, #56]	@ _1, proc_7(D)->currentRound
@ C_Code.c:641: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	movs	r4, r0	@ proc, tmp210
@ C_Code.c:643: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r0, [r5]	@ *_1, *_1
@ C_Code.c:641: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	movs	r7, r1	@ HpProc, tmp211
	mov	r8, r2	@ active_bunit, tmp212
	movs	r6, r3	@ opp_bunit, tmp213
	sub	sp, sp, #12	@,,
@ C_Code.c:643: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsls	r0, r0, #30	@ tmp220, *_1,
	bmi	.L242		@,
@ C_Code.c:643: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	movs	r3, #3	@ tmp154,
	ldrsb	r3, [r5, r3]	@ tmp154,
	cmp	r3, #0	@ tmp154,
	beq	.L242		@,
@ C_Code.c:644: 	if (round->hpChange <= 0) { return; } // healing 
	movs	r1, #3	@ _14,
	ldr	r3, [sp, #48]	@ tmp229, round
	ldrsb	r1, [r3, r1]	@ _14,* _14
@ C_Code.c:644: 	if (round->hpChange <= 0) { return; } // healing 
	cmp	r1, #0	@ _14,
	ble	.L242		@,
@ C_Code.c:645: 	int side = proc->side; 
	movs	r3, #74	@ tmp157,
	ldrb	r3, [r4, r3]	@ side,
	mov	r10, r3	@ side, side
@ C_Code.c:646: 	int hp = gEkrGaugeHp[proc->side];
	mov	r2, r10	@ side, side
	ldr	r3, .L271	@ tmp158,
	lsls	r2, r2, #1	@ tmp159, side,
@ C_Code.c:646: 	int hp = gEkrGaugeHp[proc->side];
	ldrsh	r3, [r2, r3]	@ hp, gEkrGaugeHp
	mov	fp, r3	@ hp, hp
@ C_Code.c:647: 	if (!hp) { CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp); return; } 
	cmp	r3, #0	@ hp,
	beq	.L266		@,
@ C_Code.c:650: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	movs	r3, #1	@ tmp166,
	mov	r0, r10	@ side, side
@ C_Code.c:650: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	ldr	r2, .L271+4	@ tmp161,
@ C_Code.c:650: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	eors	r3, r0	@ tmp165, side
@ C_Code.c:650: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	lsls	r3, r3, #1	@ tmp167, tmp165,
@ C_Code.c:650: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	ldrsh	r5, [r3, r2]	@ oldDamage, gEkrGaugeDmg
@ C_Code.c:650: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	cmp	r5, r1	@ oldDamage, _14
	ble	.L267		@,
@ C_Code.c:651: 	if (UsingSkillSys == 2) { oldDamage = ABS(round->overDmg); } 
	ldr	r3, .L271+8	@ tmp168,
@ C_Code.c:651: 	if (UsingSkillSys == 2) { oldDamage = ABS(round->overDmg); } 
	ldr	r3, [r3]	@ UsingSkillSys, UsingSkillSys
	cmp	r3, #2	@ UsingSkillSys,
	beq	.L268		@,
.L247:
@ C_Code.c:655: 	int newDamage = (oldDamage * percent) / 100; 
	ldr	r3, [sp, #52]	@ tmp238, percent
	mov	ip, r3	@ tmp238, tmp238
@ C_Code.c:655: 	int newDamage = (oldDamage * percent) / 100; 
	movs	r1, #100	@,
@ C_Code.c:655: 	int newDamage = (oldDamage * percent) / 100; 
	mov	r0, ip	@ tmp173, tmp238
	muls	r0, r5	@ tmp173, oldDamage
@ C_Code.c:655: 	int newDamage = (oldDamage * percent) / 100; 
	ldr	r3, .L271+12	@ tmp176,
	bl	.L10		@
@ C_Code.c:656: 	if (!newDamage) { newDamage = 1; } 
	cmp	r0, #0	@ newDamage,
	bne	.L248		@,
@ C_Code.c:656: 	if (!newDamage) { newDamage = 1; } 
	adds	r0, r0, #1	@ newDamage,
.L248:
@ C_Code.c:657: 	int newHp = hp - newDamage; 
	mov	r3, fp	@ hp, hp
	subs	r3, r3, r0	@ newHp, hp, newDamage
	mov	r9, r3	@ newHp, newHp
@ C_Code.c:658: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	cmp	r3, #0	@ newHp,
	ble	.L269		@,
.L249:
@ C_Code.c:659: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	ldr	r3, .L271+16	@ tmp180,
@ C_Code.c:659: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
@ C_Code.c:659: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	cmp	r3, #0	@ BlockingEnabled,
	bne	.L250		@,
	movs	r3, #1	@ tmp187,
	cmp	r5, r0	@ oldDamage, newDamage
	bgt	.L251		@,
	movs	r3, #0	@ tmp187,
.L251:
	lsls	r3, r3, #24	@ tmp192, tmp187,
	beq	.L250		@,
@ C_Code.c:659: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	movs	r3, #11	@ tmp193,
	movs	r2, #192	@ tmp194,
	ldrsb	r3, [r6, r3]	@ tmp193,
@ C_Code.c:659: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	tst	r2, r3	@ tmp194, tmp193
	beq	.L270		@,
.L250:
@ C_Code.c:662: 	UpdateHP(proc, HpProc, opp_bunit, newHp, side); 
	mov	r3, r10	@ side, side
	movs	r2, r6	@, opp_bunit
	str	r3, [sp]	@ side,
	movs	r1, r7	@, HpProc
	mov	r3, r9	@, newHp
	movs	r0, r4	@, proc
	bl	UpdateHP		@
@ C_Code.c:666: 	CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, newHp); 
	mov	r3, r9	@ newHp, newHp
.L266:
	str	r3, [sp, #4]	@ newHp,
	ldr	r3, [sp, #48]	@ tmp252, round
	mov	r2, r8	@, active_bunit
	str	r3, [sp]	@ tmp252,
	movs	r1, r7	@, HpProc
	movs	r3, r6	@, opp_bunit
	movs	r0, r4	@, proc
	bl	CheckForDeath		@
.L242:
@ C_Code.c:669: } 
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
.L267:
@ C_Code.c:651: 	if (UsingSkillSys == 2) { oldDamage = ABS(round->overDmg); } 
	ldr	r3, .L271+8	@ tmp168,
@ C_Code.c:651: 	if (UsingSkillSys == 2) { oldDamage = ABS(round->overDmg); } 
	ldr	r3, [r3]	@ UsingSkillSys, UsingSkillSys
@ C_Code.c:649: 	int oldDamage = round->hpChange;  
	movs	r5, r1	@ oldDamage, _14
@ C_Code.c:651: 	if (UsingSkillSys == 2) { oldDamage = ABS(round->overDmg); } 
	cmp	r3, #2	@ UsingSkillSys,
	bne	.L247		@,
	b	.L268		@
.L269:
@ C_Code.c:658: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	mov	r3, fp	@ hp, hp
	subs	r3, r3, r5	@ newHp, hp, oldDamage
	mov	r9, r3	@ newHp, newHp
@ C_Code.c:658: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	cmp	r3, #0	@ newHp,
	ble	.L253		@,
@ C_Code.c:658: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	ldr	r3, .L271+20	@ tmp178,
@ C_Code.c:658: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	ldr	r3, [r3]	@ BlockingCanPreventLethal, BlockingCanPreventLethal
@ C_Code.c:658: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	rsbs	r2, r3, #0	@ tmp198, BlockingCanPreventLethal
	adcs	r3, r3, r2	@ tmp197, BlockingCanPreventLethal, tmp198
	mov	r2, r9	@ newHp, newHp
	rsbs	r3, r3, #0	@ tmp199, tmp197
	ands	r2, r3	@ newHp, tmp199
	mov	r9, r2	@ newHp, newHp
	b	.L249		@
.L268:
@ C_Code.c:651: 	if (UsingSkillSys == 2) { oldDamage = ABS(round->overDmg); } 
	ldr	r3, [sp, #48]	@ tmp237, round
	movs	r5, #6	@ tmp170,
	ldrsh	r5, [r3, r5]	@ tmp170, tmp237, tmp170
	asrs	r3, r5, #31	@ tmp221, tmp170,
	adds	r5, r5, r3	@ tmp171, tmp170, tmp221
	eors	r5, r3	@ tmp171, tmp221
@ C_Code.c:651: 	if (UsingSkillSys == 2) { oldDamage = ABS(round->overDmg); } 
	lsls	r5, r5, #16	@ tmp172, tmp171,
	lsrs	r5, r5, #16	@ oldDamage, tmp172,
	b	.L247		@
.L270:
@ C_Code.c:659: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	mov	r3, fp	@ hp, hp
	subs	r3, r3, r5	@ newHp, hp, oldDamage
	mov	r9, r3	@ newHp, newHp
	b	.L250		@
.L253:
@ C_Code.c:658: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	movs	r3, #0	@ newHp,
	mov	r9, r3	@ newHp, newHp
	b	.L249		@
.L272:
	.align	2
.L271:
	.word	gEkrGaugeHp
	.word	gEkrGaugeDmg
	.word	UsingSkillSys
	.word	__aeabi_idiv
	.word	BlockingEnabled
	.word	BlockingCanPreventLethal
	.size	AdjustDamageByPercent, .-AdjustDamageByPercent
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
	push	{r4, r5, lr}	@
@ C_Code.c:518: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r5, #11	@ tmp125,
	movs	r4, #192	@ tmp126,
	ldrsb	r5, [r2, r5]	@ tmp125,
@ C_Code.c:536: void AdjustDamageWithGetter(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int success) { 
	sub	sp, sp, #12	@,,
@ C_Code.c:518: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	ands	r4, r5	@ _14, tmp125
@ C_Code.c:517: 	if (success) { 
	ldr	r5, [sp, #28]	@ tmp137, success
	cmp	r5, #0	@ tmp137,
	beq	.L274		@,
@ C_Code.c:518: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _14,
	bne	.L275		@,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L288	@ tmp127,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, [r4]	@ BlockingEnabled, BlockingEnabled
	cmp	r4, #0	@ BlockingEnabled,
	beq	.L273		@,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L288+4	@ tmp129,
	ldr	r4, [r4]	@ _19,
@ C_Code.c:538: 	if (percent != 100) { 
	cmp	r4, #100	@ _19,
	bne	.L287		@,
.L273:
@ C_Code.c:541: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L274:
@ C_Code.c:524: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _14,
	beq	.L273		@,
@ C_Code.c:527: 	return FailedHitDamagePercent; 
	ldr	r4, .L288+8	@ tmp131,
	ldr	r4, [r4]	@ _19,
.L277:
@ C_Code.c:538: 	if (percent != 100) { 
	cmp	r4, #100	@ _19,
	beq	.L273		@,
.L287:
@ C_Code.c:539: 		AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r4, [sp, #4]	@ _19,
	ldr	r4, [sp, #24]	@ tmp138, round
	str	r4, [sp]	@ tmp138,
	bl	AdjustDamageByPercent		@
@ C_Code.c:541: }
	b	.L273		@
.L275:
@ C_Code.c:522: 		return BonusDamagePercent; 
	ldr	r4, .L288+12	@ tmp130,
	ldr	r4, [r4]	@ _19,
	b	.L277		@
.L289:
	.align	2
.L288:
	.word	BlockingEnabled
	.word	ReducedDamagePercent
	.word	FailedHitDamagePercent
	.word	BonusDamagePercent
	.size	AdjustDamageWithGetter, .-AdjustDamageWithGetter
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
	push	{r4, r5, r6, r7, lr}	@
	mov	r7, r9	@,
	mov	r6, r8	@,
	mov	lr, r10	@,
	movs	r4, r0	@ proc, tmp299
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldr	r0, .L342	@ tmp175,
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldrh	r5, [r0]	@ gBattleStats, gBattleStats
	movs	r0, #252	@ tmp179,
@ C_Code.c:438: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	push	{r6, r7, lr}	@
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	lsls	r0, r0, #2	@ tmp179, tmp179,
@ C_Code.c:438: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r7, r2	@ HpProc, tmp300
	movs	r6, r3	@ round, tmp301
	sub	sp, sp, #8	@,,
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	tst	r5, r0	@ gBattleStats, tmp179
	bne	.L290		@,
@ C_Code.c:97: 	if (TimedHitsDifficultyRam->off) { return false; } 
	ldr	r3, .L342+4	@ tmp184,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_13, *TimedHitsDifficultyRam.0_13
@ C_Code.c:97: 	if (TimedHitsDifficultyRam->off) { return false; } 
	lsls	r3, r3, #25	@ tmp308, *TimedHitsDifficultyRam.0_13,
	bpl	.L338		@,
.L290:
@ C_Code.c:513: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L338:
@ C_Code.c:98: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L342+8	@ tmp194,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L342+12	@ tmp196,
	bl	.L10		@
@ C_Code.c:439: 	if (!AreTimedHitsEnabled()) { return; } 
	cmp	r0, #0	@ tmp302,
	bne	.L290		@,
@ C_Code.c:440: 	if (round->hpChange < 0) { return; } // healing 
	ldrb	r3, [r6, #3]	@ tmp201,
	cmp	r3, #127	@ tmp201,
	bhi	.L290		@,
@ C_Code.c:441: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldr	r3, .L342+16	@ tmp202,
@ C_Code.c:441: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldrh	r2, [r3, #8]	@ tmp205,
	ldrh	r3, [r3, #4]	@ tmp207,
@ C_Code.c:441: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	orrs	r2, r3	@ tmp205, tmp207
@ C_Code.c:445: 	int x = proc->anim2->xPosition; 
	ldr	r3, [r4, #48]	@ proc_8(D)->anim2, proc_8(D)->anim2
@ C_Code.c:445: 	int x = proc->anim2->xPosition; 
	movs	r5, #2	@ x,
	ldrsh	r5, [r3, r5]	@ x, proc_8(D)->anim2, x
@ C_Code.c:441: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	mov	r8, r2	@ keys, tmp205
@ C_Code.c:446: 	if (x > 119) { x -= 40; } 
	cmp	r5, #119	@ x,
	bgt	.LCB1793	@
	b	.L294	@long jump	@
.LCB1793:
@ C_Code.c:446: 	if (x > 119) { x -= 40; } 
	subs	r5, r5, #40	@ x,
.L295:
@ C_Code.c:448: 	struct BattleUnit* active_bunit = proc->active_bunit; 
	ldr	r3, [r4, #60]	@ active_bunit, proc_8(D)->active_bunit
	mov	r9, r3	@ active_bunit, active_bunit
@ C_Code.c:449: 	struct BattleUnit* opp_bunit = proc->opp_bunit; 
	ldr	r3, [r4, #64]	@ opp_bunit, proc_8(D)->opp_bunit
	mov	r10, r3	@ opp_bunit, opp_bunit
@ C_Code.c:450: 	int hitTime = !proc->EkrEfxIsUnitHittedNowFrames; 
	movs	r3, #79	@ tmp211,
@ C_Code.c:451: 	if (hitTime) { // 1 frame 
	ldrb	r3, [r4, r3]	@ tmp212,
	cmp	r3, #0	@ tmp212,
	bne	.L297		@,
@ C_Code.c:453: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	movs	r2, #68	@ tmp213,
@ C_Code.c:453: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	ldrb	r1, [r4, r2]	@ tmp214,
	cmp	r1, #255	@ tmp214,
	bne	.LCB1808	@
	b	.L339	@long jump	@
.LCB1808:
.L298:
@ C_Code.c:454: 		SaveInputFrame(proc, keys); 
	mov	r1, r8	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
@ C_Code.c:455: 		SaveIfWeHitOnTime(proc);
	movs	r0, r4	@, proc
	bl	SaveIfWeHitOnTime		@
@ C_Code.c:456: 		if (!proc->adjustedDmg) { 
	movs	r3, #71	@ tmp218,
@ C_Code.c:456: 		if (!proc->adjustedDmg) { 
	ldrb	r2, [r4, r3]	@ tmp219,
	cmp	r2, #0	@ tmp219,
	bne	.L297		@,
@ C_Code.c:524: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	mov	r2, r9	@ active_bunit, active_bunit
	movs	r1, #192	@ tmp221,
	ldrb	r2, [r2, #11]	@ tmp220,
	lsls	r2, r2, #24	@ tmp220, tmp220,
	asrs	r2, r2, #24	@ tmp220, tmp220,
	ands	r1, r2	@ _110, tmp220
@ C_Code.c:387: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r2, .L342+20	@ tmp222,
@ C_Code.c:391: 	if (CheatCodeOn()) { return true; } 
	ldrb	r2, [r2, #31]	@ tmp225,
	cmp	r2, #127	@ tmp225,
	bls	.LCB1828	@
	b	.L300	@long jump	@
.LCB1828:
@ C_Code.c:392: 	if (AlwaysWork) { return true; } 
	ldr	r2, .L342+24	@ tmp226,
@ C_Code.c:392: 	if (AlwaysWork) { return true; } 
	ldr	r2, [r2]	@ AlwaysWork, AlwaysWork
	cmp	r2, #0	@ AlwaysWork,
	beq	.LCB1832	@
	b	.L300	@long jump	@
.LCB1832:
@ C_Code.c:393: 	return proc->hitOnTime;
	adds	r2, r2, #69	@ tmp228,
@ C_Code.c:457: 			if (DidWeHitOnTime(proc)) { 
	ldrb	r2, [r4, r2]	@ tmp229,
	cmp	r2, #0	@ tmp229,
	bne	.L300		@,
@ C_Code.c:462: 				proc->adjustedDmg = true; 
	movs	r2, #1	@ tmp238,
	strb	r2, [r4, r3]	@ tmp238, proc_8(D)->adjustedDmg
@ C_Code.c:524: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r1, #128	@ _110,
	beq	.L297		@,
@ C_Code.c:527: 	return FailedHitDamagePercent; 
	ldr	r3, .L342+28	@ tmp240,
	ldr	r3, [r3]	@ _97,
.L337:
@ C_Code.c:538: 	if (percent != 100) { 
	cmp	r3, #100	@ _97,
	beq	.L297		@,
@ C_Code.c:539: 		AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r3, [sp, #4]	@ _97,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	movs	r1, r7	@, HpProc
	movs	r0, r4	@, proc
	str	r6, [sp]	@ round,
	bl	AdjustDamageByPercent		@
.L297:
@ C_Code.c:472: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	movs	r3, #74	@ tmp241,
@ C_Code.c:472: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	ldrb	r0, [r4, r3]	@ tmp242,
	ldr	r3, .L342+32	@ tmp243,
	bl	.L10		@
@ C_Code.c:472: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	movs	r3, #68	@ tmp246,
	ldrb	r6, [r4, r3]	@ pretmp_16,
@ C_Code.c:472: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	cmp	r0, #0	@ tmp244,
	bne	.L305		@,
@ C_Code.c:472: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	adds	r3, r3, #8	@ tmp248,
	ldrh	r2, [r4, r3]	@ MEM <struct TimedHitsProc> [(void *)proc_8(D)], MEM <struct TimedHitsProc> [(void *)proc_8(D)]
	ldr	r3, .L342+36	@ tmp250,
	cmp	r2, r3	@ MEM <struct TimedHitsProc> [(void *)proc_8(D)], tmp250
	beq	.L340		@,
.L305:
@ C_Code.c:387: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L342+20	@ tmp251,
@ C_Code.c:391: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp254,
	cmp	r3, #127	@ tmp254,
	bhi	.L307		@,
@ C_Code.c:392: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L342+24	@ tmp255,
@ C_Code.c:392: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L307		@,
@ C_Code.c:393: 	return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp257,
@ C_Code.c:473: 		if (DidWeHitOnTime(proc)) { 
	ldrb	r3, [r4, r3]	@ tmp258,
	cmp	r3, #0	@ tmp258,
	bne	.L307		@,
@ C_Code.c:489: 		else if (proc->timer2 < 20) { 
	cmp	r6, #19	@ pretmp_16,
	bhi	.L309		@,
@ C_Code.c:490: 			if (ChangePaletteWhenButtonIsPressed) { 
	ldr	r2, .L342+40	@ tmp285,
@ C_Code.c:397: 	if (!DisplayPress) { return; } 
	ldr	r3, .L342+44	@ tmp284,
@ C_Code.c:490: 			if (ChangePaletteWhenButtonIsPressed) { 
	ldr	r2, [r2]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
@ C_Code.c:397: 	if (!DisplayPress) { return; } 
	ldr	r3, [r3]	@ pretmp_119, DisplayPress
@ C_Code.c:490: 			if (ChangePaletteWhenButtonIsPressed) { 
	cmp	r2, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L310		@,
@ C_Code.c:397: 	if (!DisplayPress) { return; } 
	cmp	r3, #0	@ pretmp_119,
	bne	.L341		@,
.L309:
@ C_Code.c:497: 		proc->roundEnd = true; 
	movs	r3, #78	@ tmp287,
	movs	r2, #1	@ tmp288,
	strb	r2, [r4, r3]	@ tmp288, proc_8(D)->roundEnd
	b	.L290		@
.L307:
@ C_Code.c:482: 			if (((y > (-16)) && (y < (161)))) { 
	movs	r3, #63	@ tmp259,
	subs	r3, r3, r6	@ tmp260, tmp259, pretmp_16
@ C_Code.c:482: 			if (((y > (-16)) && (y < (161)))) { 
	cmp	r3, #175	@ tmp260,
	bhi	.L309		@,
@ C_Code.c:483: 				if (!gBanimDoneFlag[proc->side]) { // doesn't seem to matter ? 
	movs	r2, #74	@ tmp262,
	ldrb	r2, [r4, r2]	@ tmp263,
@ C_Code.c:483: 				if (!gBanimDoneFlag[proc->side]) { // doesn't seem to matter ? 
	ldr	r3, .L342+48	@ tmp261,
	lsls	r2, r2, #2	@ tmp264, tmp263,
@ C_Code.c:483: 				if (!gBanimDoneFlag[proc->side]) { // doesn't seem to matter ? 
	ldr	r3, [r2, r3]	@ gBanimDoneFlag[_55], gBanimDoneFlag[_55]
	cmp	r3, #0	@ gBanimDoneFlag[_55],
	bne	.L309		@,
@ C_Code.c:479: 			x += xPos[Mod(clock, sizeof(xPos)+1)]; 
	movs	r1, #31	@,
	movs	r0, r6	@, pretmp_16
	ldr	r3, .L342+52	@ tmp266,
	bl	.L10		@
@ C_Code.c:484: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	ldr	r1, .L342+56	@ tmp267,
	movs	r3, r1	@ tmp268, tmp267
@ C_Code.c:479: 			x += xPos[Mod(clock, sizeof(xPos)+1)]; 
	adds	r1, r1, r0	@ tmp275, tmp267, tmp304
	movs	r0, #112	@ tmp274,
@ C_Code.c:481: 			y -= clock; 
	movs	r2, #48	@ tmp269,
@ C_Code.c:479: 			x += xPos[Mod(clock, sizeof(xPos)+1)]; 
	ldrb	r1, [r1, r0]	@ tmp276, xPos
@ C_Code.c:484: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	movs	r0, #224	@ tmp280,
@ C_Code.c:479: 			x += xPos[Mod(clock, sizeof(xPos)+1)]; 
	adds	r1, r1, r5	@ x, tmp276, x
@ C_Code.c:481: 			y -= clock; 
	subs	r6, r2, r6	@ y, tmp269, pretmp_16
@ C_Code.c:484: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	lsls	r0, r0, #8	@ tmp280, tmp280,
	adds	r2, r2, #207	@ tmp271,
	lsls	r1, r1, #23	@ tmp279, x,
	str	r0, [sp]	@ tmp280,
	ldr	r5, .L342+60	@ tmp281,
	movs	r0, #0	@,
	adds	r3, r3, #104	@ tmp268,
	ands	r2, r6	@ tmp272, y
	lsrs	r1, r1, #23	@ tmp278, tmp279,
	bl	.L28		@
	b	.L309		@
.L294:
@ C_Code.c:447: 	else if (x > 40) { x -= 20; } 
	cmp	r5, #40	@ x,
	bgt	.LCB1940	@
	b	.L295	@long jump	@
.LCB1940:
@ C_Code.c:447: 	else if (x > 40) { x -= 20; } 
	subs	r5, r5, #20	@ x,
	b	.L295		@
.L340:
@ C_Code.c:472: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) || (proc->timer2 != 0xFF)) { 
	cmp	r6, #255	@ pretmp_16,
	bne	.L305		@,
@ C_Code.c:501: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	ldr	r3, [r4, #52]	@ proc_8(D)->timer, proc_8(D)->timer
	cmp	r3, #0	@ proc_8(D)->timer,
	bgt	.L311		@,
@ C_Code.c:501: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	movs	r3, #75	@ tmp291,
	strb	r0, [r4, r3]	@ tmp244, proc_8(D)->frame
.L312:
@ C_Code.c:506: 		if (!proc->roundEnd) { 
	movs	r3, #78	@ tmp294,
@ C_Code.c:506: 		if (!proc->roundEnd) { 
	ldrb	r3, [r4, r3]	@ tmp295,
	cmp	r3, #0	@ tmp295,
	beq	.LCB1958	@
	b	.L290	@long jump	@
.LCB1958:
@ C_Code.c:397: 	if (!DisplayPress) { return; } 
	ldr	r3, .L342+44	@ tmp296,
@ C_Code.c:397: 	if (!DisplayPress) { return; } 
	ldr	r3, [r3]	@ DisplayPress, DisplayPress
	cmp	r3, #0	@ DisplayPress,
	bne	.LCB1962	@
	b	.L290	@long jump	@
.LCB1962:
	movs	r3, #15	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L290		@
.L339:
@ C_Code.c:453: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	strb	r3, [r4, r2]	@ tmp212, proc_8(D)->timer2
	b	.L298		@
.L300:
@ C_Code.c:458: 				proc->adjustedDmg = true; 
	movs	r3, #71	@ tmp230,
	movs	r2, #1	@ tmp231,
	strb	r2, [r4, r3]	@ tmp231, proc_8(D)->adjustedDmg
@ C_Code.c:518: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r1, #128	@ _110,
	bne	.L302		@,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L342+64	@ tmp233,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L297		@,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L342+68	@ tmp235,
	ldr	r3, [r3]	@ _79,
@ C_Code.c:519: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L337		@
.L310:
@ C_Code.c:397: 	if (!DisplayPress) { return; } 
	cmp	r3, #0	@ pretmp_119,
	beq	.L309		@,
	movs	r3, #14	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L309		@
.L302:
@ C_Code.c:522: 		return BonusDamagePercent; 
	ldr	r3, .L342+72	@ tmp236,
	ldr	r3, [r3]	@ _79,
	b	.L337		@
.L341:
	movs	r3, #15	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L309		@
.L311:
@ C_Code.c:504: 			SaveInputFrame(proc, keys); 
	mov	r1, r8	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
	b	.L312		@
.L343:
	.align	2
.L342:
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
	.word	PutSprite
	.word	BlockingEnabled
	.word	ReducedDamagePercent
	.word	BonusDamagePercent
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
	push	{r4, r5, r6, r7, lr}	@
@ C_Code.c:259: 	if (!proc->anim) { return; } 
	ldr	r3, [r0, #44]	@ proc_26(D)->anim, proc_26(D)->anim
@ C_Code.c:258: void LoopTimedHitsProc(TimedHitsProc* proc) { 
	movs	r4, r0	@ proc, tmp179
	sub	sp, sp, #12	@,,
@ C_Code.c:259: 	if (!proc->anim) { return; } 
	cmp	r3, #0	@ proc_26(D)->anim,
	beq	.L344		@,
@ C_Code.c:261: 	struct ProcEkrBattle* battleProc = gpProcEkrBattle; 
	ldr	r3, .L366	@ tmp142,
	ldr	r5, [r3]	@ battleProc, gpProcEkrBattle
@ C_Code.c:263: 	if (!battleProc) { return; } // 0 after suspend until battle start 
	cmp	r5, #0	@ battleProc,
	beq	.L344		@,
@ C_Code.c:264: 	if (!proc->anim2) { return; }
	ldr	r3, [r0, #48]	@ proc_26(D)->anim2, proc_26(D)->anim2
	cmp	r3, #0	@ proc_26(D)->anim2,
	beq	.L344		@,
@ C_Code.c:265: 	if (gEkrBattleEndFlag) { return; } // 0 after suspend until battle done
	ldr	r3, .L366+4	@ tmp144,
@ C_Code.c:265: 	if (gEkrBattleEndFlag) { return; } // 0 after suspend until battle done
	ldr	r3, [r3]	@ gEkrBattleEndFlag, gEkrBattleEndFlag
	cmp	r3, #0	@ gEkrBattleEndFlag,
	bne	.L344		@,
@ C_Code.c:269: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	movs	r2, #68	@ tmp148,
@ C_Code.c:268: 	proc->timer++;
	ldr	r3, [r0, #52]	@ proc_26(D)->timer, proc_26(D)->timer
	adds	r3, r3, #1	@ tmp146,
	str	r3, [r0, #52]	@ tmp146, proc_26(D)->timer
@ C_Code.c:269: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	ldrb	r3, [r0, r2]	@ _6,
@ C_Code.c:269: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	cmp	r3, #255	@ _6,
	beq	.L348		@,
@ C_Code.c:269: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	adds	r3, r3, #1	@ tmp149,
	strb	r3, [r0, r2]	@ tmp149, proc_26(D)->timer2
.L348:
@ C_Code.c:273: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	movs	r6, #79	@ tmp152,
	ldrb	r3, [r4, r6]	@ _8,
@ C_Code.c:271: 	struct SkillSysBattleHit* currentRound = proc->currentRound; 
	ldr	r7, [r4, #56]	@ currentRound, proc_26(D)->currentRound
@ C_Code.c:273: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	cmp	r3, #255	@ _8,
	beq	.L349		@,
@ C_Code.c:274: 		proc->EkrEfxIsUnitHittedNowFrames++; 
	adds	r3, r3, #1	@ tmp153,
	strb	r3, [r4, r6]	@ tmp153, proc_26(D)->EkrEfxIsUnitHittedNowFrames
.L350:
@ C_Code.c:279: 	struct NewProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	ldr	r3, .L366+8	@ tmp164,
	ldr	r0, [r3]	@ gProcScr_efxHPBar, gProcScr_efxHPBar
	ldr	r3, .L366+12	@ tmp166,
	bl	.L10		@
@ C_Code.c:280: 	DoStuffIfHit(proc, battleProc, HpProc, currentRound); 
	movs	r3, r7	@, currentRound
@ C_Code.c:279: 	struct NewProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	movs	r6, r0	@ HpProc, tmp181
@ C_Code.c:280: 	DoStuffIfHit(proc, battleProc, HpProc, currentRound); 
	movs	r2, r0	@, HpProc
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
@ C_Code.c:252: 	if (!HpProc) { return false; } // 
	cmp	r6, #0	@ HpProc,
	beq	.L344		@,
@ C_Code.c:254: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #79	@ tmp167,
@ C_Code.c:254: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r3, [r4, r3]	@ tmp168,
	cmp	r3, #0	@ tmp168,
	bne	.L344		@,
@ C_Code.c:282: 		int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId); 
	movs	r6, #70	@ tmp170,
@ C_Code.c:282: 		int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId); 
	ldrb	r3, [r4, r6]	@ tmp171,
	movs	r1, #0	@,
	movs	r2, #0	@,
	ldr	r0, [r4, #48]	@ proc_26(D)->anim2, proc_26(D)->anim2
	ldr	r5, .L366+16	@ tmp172,
	str	r3, [sp]	@ tmp171,
	movs	r3, #0	@,
	bl	.L28		@
	movs	r3, r0	@ x, tmp182
@ C_Code.c:283: 		x = DisplayDamage2(proc->anim, 1, proc->anim->xPosition, x, proc->roundId);  
	ldr	r0, [r4, #44]	@ _17, proc_26(D)->anim
	movs	r1, #2	@ tmp186,
	ldrsh	r2, [r0, r1]	@ tmp173, _17, tmp186
	ldrb	r1, [r4, r6]	@ tmp175,
	str	r1, [sp]	@ tmp175,
	movs	r1, #1	@,
	bl	.L28		@
.L344:
@ C_Code.c:286: } 
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L349:
@ C_Code.c:276: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #74	@ tmp156,
@ C_Code.c:276: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	ldrb	r0, [r4, r3]	@ tmp157,
	ldr	r3, .L366+20	@ tmp158,
	bl	.L10		@
@ C_Code.c:276: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	cmp	r0, #0	@ tmp180,
	beq	.L350		@,
@ C_Code.c:276: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #0	@ tmp162,
	strb	r3, [r4, r6]	@ tmp162, proc_26(D)->EkrEfxIsUnitHittedNowFrames
	b	.L350		@
.L367:
	.align	2
.L366:
	.word	gpProcEkrBattle
	.word	gEkrBattleEndFlag
	.word	gProcScr_efxHPBar
	.word	Proc_Find
	.word	DisplayDamage2
	.word	EkrEfxIsUnitHittedNow
	.size	LoopTimedHitsProc, .-LoopTimedHitsProc
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
@ C_Code.c:681: 	int result = gPlaySt.config.animationType; 
	movs	r2, #66	@ tmp130,
@ C_Code.c:680: int GetBattleAnimPreconfType(void) {
	push	{r4, lr}	@
@ C_Code.c:681: 	int result = gPlaySt.config.animationType; 
	ldr	r3, .L380	@ tmp164,
	ldrb	r0, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:682: 	if (!CheatCodeOn()) { 
	ldrb	r2, [r3, #31]	@ tmp139,
@ C_Code.c:681: 	int result = gPlaySt.config.animationType; 
	lsls	r0, r0, #29	@ tmp134, gPlaySt,
@ C_Code.c:681: 	int result = gPlaySt.config.animationType; 
	lsrs	r0, r0, #30	@ <retval>, tmp134,
@ C_Code.c:682: 	if (!CheatCodeOn()) { 
	cmp	r2, #127	@ tmp139,
	bhi	.L369		@,
@ C_Code.c:683: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, .L380+4	@ tmp140,
@ C_Code.c:683: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, [r2]	@ ForceAnimsOn, ForceAnimsOn
	cmp	r2, #0	@ ForceAnimsOn,
	beq	.L369		@,
@ C_Code.c:683: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	cmp	r0, #2	@ <retval>,
	beq	.L368		@,
.L372:
@ C_Code.c:683: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	movs	r0, #1	@ <retval>,
.L368:
@ C_Code.c:704: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L369:
@ C_Code.c:686:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r2, #66	@ tmp143,
	ldrb	r2, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:686:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r3, #6	@ tmp149,
	ands	r3, r2	@ tmp150, gPlaySt
	cmp	r3, #4	@ tmp150,
	bne	.L368		@,
@ C_Code.c:690:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	movs	r1, #11	@ tmp154,
@ C_Code.c:691:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	movs	r4, #11	@ pretmp_25,
@ C_Code.c:690:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldr	r0, .L380+8	@ tmp153,
@ C_Code.c:691:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldr	r2, .L380+12	@ tmp152,
@ C_Code.c:690:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldrsb	r1, [r0, r1]	@ tmp154,
	adds	r3, r3, #188	@ tmp155,
@ C_Code.c:691:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldrsb	r4, [r2, r4]	@ pretmp_25,* pretmp_25
@ C_Code.c:690:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	tst	r3, r1	@ tmp155, tmp154
	beq	.L379		@,
@ C_Code.c:696:         if (UNIT_FACTION(&gBattleTarget.unit) != FACTION_BLUE)
	tst	r3, r4	@ tmp155, pretmp_25
	bne	.L372		@,
@ C_Code.c:703:         return GetSoloAnimPreconfType(&gBattleTarget.unit);
	movs	r0, r2	@, tmp152
.L379:
	ldr	r3, .L380+16	@ tmp162,
	bl	.L10		@
	b	.L368		@
.L381:
	.align	2
.L380:
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
.LC113:
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
	.word	.LC113
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
	.type	sSprite_Star, %object
	.size	sSprite_Star, 8
sSprite_Star:
	.short	1
	.short	0
	.short	16384
	.short	338
	.type	xPos, %object
	.size	xPos, 30
xPos:
	.ascii	"\000\000\000\001\001\001\002\002\002\003\003\003\004"
	.ascii	"\004\004\005\005\005\004\004\004\003\003\003\002\002"
	.ascii	"\002\001\001\001"
	.space	2
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
.L10:
	bx	r3
.L116:
	bx	r4
.L28:
	bx	r5
.L58:
	bx	r10
