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
@ C_Code.c:107: 	proc->timer2 = 0xFF; 
	movs	r2, #255	@ tmp118,
@ C_Code.c:117: 	proc->buttonsToPress = 0; 
	movs	r1, #84	@ tmp122,
@ C_Code.c:102: 	proc->anim = NULL; 
	str	r3, [r0, #44]	@ tmp115, proc_2(D)->anim
@ C_Code.c:103: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp115, proc_2(D)->anim2
@ C_Code.c:106: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp115, proc_2(D)->timer
@ C_Code.c:112: 	proc->currentRound = NULL; 
	str	r3, [r0, #60]	@ tmp115, proc_2(D)->currentRound
@ C_Code.c:113: 	proc->active_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp115, proc_2(D)->active_bunit
@ C_Code.c:114: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #68]	@ tmp115, proc_2(D)->opp_bunit
@ C_Code.c:107: 	proc->timer2 = 0xFF; 
	str	r2, [r0, #56]	@ tmp118, proc_2(D)->timer2
@ C_Code.c:117: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r1]	@ tmp115, proc_2(D)->buttonsToPress
@ C_Code.c:108: 	proc->hitOnTime = false; 
	str	r3, [r0, #72]	@ tmp115, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 72B]
	ldr	r3, .L12	@ tmp126,
	str	r3, [r0, #76]	@ tmp126, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 76B]
@ C_Code.c:119: 	proc->codefframe = 0xff;
	movs	r3, #80	@ tmp127,
	ldr	r1, .L12+4	@ tmp128,
	strh	r1, [r0, r3]	@ tmp128, MEM <vector(2) unsigned char> [(unsigned char *)proc_2(D) + 80B]
@ C_Code.c:120: 	proc->EkrEfxIsUnitHittedNowFrames = 0xff; 
	adds	r3, r3, #2	@ tmp130,
	strb	r2, [r0, r3]	@ tmp118, proc_2(D)->EkrEfxIsUnitHittedNowFrames
@ C_Code.c:121: } 
	bx	lr
.L13:
	.align	2
.L12:
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
	movs	r5, r0	@ anim, tmp195
@ C_Code.c:135: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r0, .L26+4	@ tmp129,
	bl	.L10		@
	subs	r4, r0, #0	@ proc, tmp196,
@ C_Code.c:136: 	if (!proc) { return; } 
	beq	.L19		@,
@ C_Code.c:103: 	proc->anim2 = NULL; 
	movs	r3, #0	@ tmp131,
@ C_Code.c:117: 	proc->buttonsToPress = 0; 
	movs	r2, #84	@ tmp136,
@ C_Code.c:103: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp131, proc_18->anim2
@ C_Code.c:106: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp131, proc_18->timer
@ C_Code.c:112: 	proc->currentRound = NULL; 
	str	r3, [r0, #60]	@ tmp131, proc_18->currentRound
@ C_Code.c:113: 	proc->active_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp131, proc_18->active_bunit
@ C_Code.c:114: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #68]	@ tmp131, proc_18->opp_bunit
@ C_Code.c:117: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r2]	@ tmp131, proc_18->buttonsToPress
@ C_Code.c:108: 	proc->hitOnTime = false; 
	str	r3, [r0, #72]	@ tmp131, MEM <vector(4) unsigned char> [(unsigned char *)proc_18 + 72B]
	ldr	r3, .L26+8	@ tmp140,
	str	r3, [r0, #76]	@ tmp140, MEM <vector(4) unsigned char> [(unsigned char *)proc_18 + 76B]
@ C_Code.c:120: 	proc->EkrEfxIsUnitHittedNowFrames = 0xff; 
	movs	r3, #255	@ tmp142,
	subs	r2, r2, #2	@ tmp141,
	strb	r3, [r0, r2]	@ tmp142, proc_18->EkrEfxIsUnitHittedNowFrames
@ C_Code.c:119: 	proc->codefframe = 0xff;
	subs	r2, r2, #2	@ tmp144,
	strh	r3, [r0, r2]	@ tmp142, MEM <vector(2) unsigned char> [(unsigned char *)proc_18 + 80B]
@ C_Code.c:141: 	proc->anim = anim; 
	str	r5, [r0, #44]	@ anim, proc_18->anim
@ C_Code.c:142: 	proc->anim2 = GetAnimAnotherSide(anim); 
	ldr	r3, .L26+12	@ tmp147,
	movs	r0, r5	@, anim
	bl	.L10		@
@ C_Code.c:142: 	proc->anim2 = GetAnimAnotherSide(anim); 
	str	r0, [r4, #48]	@ tmp197, proc_18->anim2
@ C_Code.c:143: 	proc->roundId = anim->nextRoundId-1; 
	ldrh	r3, [r5, #14]	@ tmp150,
	subs	r3, r3, #1	@ tmp151,
	lsls	r3, r3, #24	@ tmp152, tmp151,
	lsrs	r0, r3, #24	@ _4, tmp152,
@ C_Code.c:143: 	proc->roundId = anim->nextRoundId-1; 
	movs	r3, #73	@ tmp153,
	strb	r0, [r4, r3]	@ _4, proc_18->roundId
@ C_Code.c:146: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	ldr	r3, .L26+16	@ tmp155,
	bl	.L10		@
@ C_Code.c:147: 	proc->side = GetAnimPosition(anim) ^ 1; 
	ldr	r3, .L26+20	@ tmp156,
@ C_Code.c:146: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	str	r0, [r4, #60]	@ tmp198, proc_18->currentRound
@ C_Code.c:147: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r0, r5	@, anim
	bl	.L10		@
@ C_Code.c:147: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r3, #1	@ tmp158,
@ C_Code.c:147: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r2, #77	@ tmp161,
@ C_Code.c:147: 	proc->side = GetAnimPosition(anim) ^ 1; 
	lsls	r0, r0, #24	@ tmp157, tmp199,
	asrs	r0, r0, #24	@ _8, tmp157,
	eors	r3, r0	@ tmp160, _8
@ C_Code.c:147: 	proc->side = GetAnimPosition(anim) ^ 1; 
	strb	r3, [r4, r2]	@ tmp160, proc_18->side
@ C_Code.c:148: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, .L26+24	@ tmp163,
@ C_Code.c:149: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, .L26+28	@ tmp164,
@ C_Code.c:148: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, [r3]	@ gpEkrBattleUnitLeft.2_11, gpEkrBattleUnitLeft
@ C_Code.c:149: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, [r2]	@ gpEkrBattleUnitRight.3_12, gpEkrBattleUnitRight
@ C_Code.c:148: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	str	r3, [r4, #64]	@ gpEkrBattleUnitLeft.2_11, proc_18->active_bunit
@ C_Code.c:149: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #68]	@ gpEkrBattleUnitRight.3_12, proc_18->opp_bunit
@ C_Code.c:150: 	if (!proc->side) { 
	cmp	r0, #1	@ _8,
	beq	.L24		@,
@ C_Code.c:154: 	if (!proc->loadedImg) {
	movs	r6, #76	@ tmp165,
@ C_Code.c:154: 	if (!proc->loadedImg) {
	ldrb	r3, [r4, r6]	@ tmp166,
	cmp	r3, #0	@ tmp166,
	beq	.L25		@,
.L19:
@ C_Code.c:166: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L24:
@ C_Code.c:154: 	if (!proc->loadedImg) {
	movs	r6, #76	@ tmp165,
@ C_Code.c:151: 		proc->active_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #64]	@ gpEkrBattleUnitRight.3_12, proc_18->active_bunit
@ C_Code.c:152: 		proc->opp_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #68]	@ gpEkrBattleUnitLeft.2_11, proc_18->opp_bunit
@ C_Code.c:154: 	if (!proc->loadedImg) {
	ldrb	r3, [r4, r6]	@ tmp166,
	cmp	r3, #0	@ tmp166,
	bne	.L19		@,
.L25:
@ C_Code.c:155: 		proc->timer2 = 0xFF; 
	adds	r3, r3, #255	@ tmp167,
@ C_Code.c:156: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r5, .L26+32	@ tmp170,
	movs	r2, #6	@,
@ C_Code.c:155: 		proc->timer2 = 0xFF; 
	str	r3, [r4, #56]	@ tmp167, proc_18->timer2
@ C_Code.c:156: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r0, .L26+36	@ tmp169,
	ldr	r1, .L26+40	@,
	subs	r3, r3, #253	@,
	bl	.L28		@
@ C_Code.c:157: 		Copy2dChr(&BattleStar, (void*)0x06012a40, 2, 2); // 0x108 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+44	@ tmp172,
	ldr	r1, .L26+48	@,
	bl	.L28		@
@ C_Code.c:158: 		Copy2dChr(&A_Button, (void*)0x06012800, 2, 2); // 0x140
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+52	@ tmp175,
	ldr	r1, .L26+56	@,
	bl	.L28		@
@ C_Code.c:159: 		Copy2dChr(&B_Button, (void*)0x06012840, 2, 2); // 0x142 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+60	@ tmp178,
	ldr	r1, .L26+64	@,
	bl	.L28		@
@ C_Code.c:160: 		Copy2dChr(&Left_Button, (void*)0x06012880, 2, 2); // 0x144
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+68	@ tmp181,
	ldr	r1, .L26+72	@,
	bl	.L28		@
@ C_Code.c:161: 		Copy2dChr(&Right_Button, (void*)0x060128C0, 2, 2); // 0x146
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+76	@ tmp184,
	ldr	r1, .L26+80	@,
	bl	.L28		@
@ C_Code.c:162: 		Copy2dChr(&Up_Button, (void*)0x06012900, 2, 2); // 0x148
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+84	@ tmp187,
	ldr	r1, .L26+88	@,
	bl	.L28		@
@ C_Code.c:163: 		Copy2dChr(&Down_Button, (void*)0x06012940, 2, 2); // 0x14a
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+92	@ tmp190,
	ldr	r1, .L26+96	@,
	bl	.L28		@
@ C_Code.c:164: 		proc->loadedImg = true;
	movs	r3, #1	@ tmp193,
	strb	r3, [r4, r6]	@ tmp193, proc_18->loadedImg
	b	.L19		@
.L27:
	.align	2
.L26:
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
@ C_Code.c:248: 	if (proc->broke) { return; } 
	movs	r3, #75	@ tmp116,
@ C_Code.c:248: 	if (proc->broke) { return; } 
	ldrb	r2, [r0, r3]	@ tmp117,
	cmp	r2, #0	@ tmp117,
	bne	.L29		@,
@ C_Code.c:249: 	proc->broke = true; 
	adds	r2, r2, #1	@ tmp119,
	strb	r2, [r0, r3]	@ tmp119, proc_4(D)->broke
@ C_Code.c:250: 	asm("mov r11, r11");
	.syntax divided
@ 250 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L29:
@ C_Code.c:251: } 
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
@ C_Code.c:255: 	if (!HpProc) { return false; } // 
	cmp	r1, #0	@ tmp126,
	beq	.L33		@,
@ C_Code.c:257: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #82	@ tmp119,
@ C_Code.c:257: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r0, [r0, r3]	@ tmp121,
	rsbs	r3, r0, #0	@ tmp123, tmp121
	adcs	r0, r0, r3	@ <retval>, tmp121, tmp123
.L31:
@ C_Code.c:259: } 
	@ sp needed	@
	bx	lr
.L33:
@ C_Code.c:255: 	if (!HpProc) { return false; } // 
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
@ C_Code.c:305: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, .L56	@ tmp137,
@ C_Code.c:305: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:304: int GetButtonsToPress(TimedHitsProc* proc) { 
	mov	r8, r0	@ proc, tmp179
	sub	sp, sp, #8	@,,
@ C_Code.c:305: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	cmp	r3, #0	@ AlwaysA,
	bne	.L45		@,
@ C_Code.c:305: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, .L56+4	@ tmp139,
	ldr	r2, [r3]	@ TimedHitsDifficultyRam.8_2, TimedHitsDifficultyRam
@ C_Code.c:305: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.8_2, *TimedHitsDifficultyRam.8_2
	lsls	r3, r3, #26	@ tmp181, *TimedHitsDifficultyRam.8_2,
	bmi	.L45		@,
@ C_Code.c:306: 	int keys = proc->buttonsToPress;
	movs	r3, #84	@ tmp149,
@ C_Code.c:306: 	int keys = proc->buttonsToPress;
	ldrh	r0, [r0, r3]	@ <retval>,
@ C_Code.c:307: 	if (!keys) { 
	cmp	r0, #0	@ <retval>,
	bne	.L34		@,
@ C_Code.c:308: 		u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
	ldr	r3, .L56+8	@ tmp151,
	ldr	r1, [r3]	@ tmp154,
	str	r1, [sp]	@ tmp154,
	mov	r1, sp	@ tmp184,
	ldrh	r3, [r3, #4]	@ tmp156,
	strh	r3, [r1, #4]	@ tmp156,
@ C_Code.c:313: 		int numberOfRandomButtons = NumberOfRandomButtons; 
	ldr	r3, .L56+12	@ tmp158,
	ldr	r3, [r3]	@ numberOfRandomButtons, NumberOfRandomButtons
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:314: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	cmp	r3, #0	@ numberOfRandomButtons,
	beq	.L53		@,
@ C_Code.c:316: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	ble	.L46		@,
.L37:
	ldr	r3, .L56+16	@ tmp177,
@ C_Code.c:316: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	movs	r6, #0	@ i,
@ C_Code.c:311: 		int oppDir = 0; 
	movs	r7, #0	@ oppDir,
@ C_Code.c:306: 	int keys = proc->buttonsToPress;
	movs	r5, #0	@ keys,
@ C_Code.c:312: 		int size = 5; // -1 since we count from 0  
	movs	r4, #5	@ size,
	mov	r10, r3	@ tmp177, tmp177
	b	.L43		@
.L39:
@ C_Code.c:316: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r6, r6, #1	@ i,
@ C_Code.c:336: 			keys |= button; 
	orrs	r5, r0	@ keys, button
@ C_Code.c:316: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r9, r6	@ numberOfRandomButtons, i
	ble	.L54		@,
.L43:
@ C_Code.c:317: 			num = NextRN_N(size); 
	movs	r0, r4	@, size
	bl	.L58		@
@ C_Code.c:318: 			button = KeysList[num];
	mov	r3, sp	@ tmp191,
	ldrb	r0, [r3, r0]	@ button, KeysList
@ C_Code.c:321: 			if (button & 0xF0) { // some dpad 
	cmp	r0, #15	@ button,
	bls	.L39		@,
@ C_Code.c:322: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	cmp	r0, #16	@ button,
	beq	.L47		@,
@ C_Code.c:323: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	cmp	r0, #32	@ button,
	beq	.L48		@,
@ C_Code.c:324: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	cmp	r0, #64	@ button,
	bne	.L55		@,
@ C_Code.c:324: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	movs	r7, #128	@ oppDir,
.L40:
@ C_Code.c:326: 				for (int c = 0; c <= size; ++c) { 
	cmp	r4, #0	@ size,
	blt	.L39		@,
	mov	r2, sp	@ ivtmp.88,
@ C_Code.c:326: 				for (int c = 0; c <= size; ++c) { 
	movs	r3, #0	@ c,
	b	.L42		@
.L41:
@ C_Code.c:326: 				for (int c = 0; c <= size; ++c) { 
	adds	r3, r3, #1	@ c,
@ C_Code.c:326: 				for (int c = 0; c <= size; ++c) { 
	adds	r2, r2, #1	@ ivtmp.88,
	cmp	r3, r4	@ c, size
	bgt	.L39		@,
.L42:
@ C_Code.c:327: 					if (KeysList[c] == oppDir) { 
	ldrb	r1, [r2]	@ MEM[(unsigned char *)_45], MEM[(unsigned char *)_45]
@ C_Code.c:327: 					if (KeysList[c] == oppDir) { 
	cmp	r1, r7	@ MEM[(unsigned char *)_45], oppDir
	bne	.L41		@,
@ C_Code.c:328: 						KeysList[c] = KeysList[size]; 
	mov	r2, sp	@ tmp192,
@ C_Code.c:328: 						KeysList[c] = KeysList[size]; 
	mov	r1, sp	@ tmp193,
@ C_Code.c:328: 						KeysList[c] = KeysList[size]; 
	ldrb	r2, [r2, r4]	@ _10, KeysList
@ C_Code.c:316: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r6, r6, #1	@ i,
@ C_Code.c:328: 						KeysList[c] = KeysList[size]; 
	strb	r2, [r1, r3]	@ _10, KeysList[c_53]
@ C_Code.c:329: 						size--; 
	subs	r4, r4, #1	@ size,
@ C_Code.c:336: 			keys |= button; 
	orrs	r5, r0	@ keys, button
@ C_Code.c:316: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r9, r6	@ numberOfRandomButtons, i
	bgt	.L43		@,
.L54:
@ C_Code.c:338: 		proc->buttonsToPress = keys; 
	movs	r0, r5	@ <retval>, keys
	lsls	r3, r5, #16	@ tmp173, keys,
	lsrs	r3, r3, #16	@ prephitmp_15, tmp173,
.L38:
	movs	r2, #84	@ tmp174,
	mov	r1, r8	@ proc, proc
	strh	r3, [r1, r2]	@ prephitmp_15, proc_29(D)->buttonsToPress
	b	.L34		@
.L45:
@ C_Code.c:305: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	movs	r0, #1	@ <retval>,
.L34:
@ C_Code.c:341: } 
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
@ C_Code.c:314: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.8_2, *TimedHitsDifficultyRam.8_2
	lsls	r3, r3, #27	@ tmp163, *TimedHitsDifficultyRam.8_2,
@ C_Code.c:314: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	lsrs	r2, r3, #27	@ numberOfRandomButtons, tmp163,
	mov	r9, r2	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:315: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	cmp	r3, #0	@ tmp163,
	bne	.L37		@,
@ C_Code.c:315: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	adds	r3, r3, #1	@ numberOfRandomButtons,
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
	b	.L37		@
.L47:
@ C_Code.c:322: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	movs	r7, #32	@ oppDir,
	b	.L40		@
.L48:
@ C_Code.c:323: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	movs	r7, #16	@ oppDir,
	b	.L40		@
.L55:
@ C_Code.c:325: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	cmp	r0, #128	@ button,
	bne	.L40		@,
@ C_Code.c:325: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	movs	r7, #64	@ oppDir,
	b	.L40		@
.L46:
@ C_Code.c:316: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
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
	mov	lr, fp	@,
	mov	r6, r9	@,
	mov	r7, r10	@,
	mov	r5, r8	@,
	push	{r5, r6, r7, lr}	@
	sub	sp, sp, #12	@,,
@ C_Code.c:397: void DrawButtonsToPress(TimedHitsProc* proc, int x, int y, int palID) { 
	mov	fp, r2	@ y, tmp237
	movs	r7, r0	@ proc, tmp235
	mov	r9, r1	@ x, tmp236
	movs	r6, r3	@ palID, tmp238
@ C_Code.c:399: 	int keys = GetButtonsToPress(proc); 
	bl	GetButtonsToPress		@
@ C_Code.c:401: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r2, .L115	@ tmp153,
@ C_Code.c:401: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r2, [r2]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
@ C_Code.c:399: 	int keys = GetButtonsToPress(proc); 
	movs	r5, r0	@ keys, tmp239
@ C_Code.c:401: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	cmp	r2, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L62		@,
@ C_Code.c:401: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	movs	r3, #78	@ tmp157,
@ C_Code.c:401: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldrb	r3, [r7, r3]	@ tmp158,
	cmp	r3, #0	@ tmp158,
	bne	.L106		@,
.L62:
@ C_Code.c:403: 	int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); //OAM2_CHR(0);
	lsls	r6, r6, #28	@ tmp156, palID,
	lsrs	r6, r6, #16	@ _26, tmp156,
.L61:
@ C_Code.c:404: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	r2, fp	@ y, y
	movs	r3, #255	@ tmp159,
	ldr	r7, .L115+4	@ tmp229,
	ands	r3, r2	@ tmp159, y
	mov	r2, r9	@ x, x
	mov	r8, r3	@ _11, tmp159
	movs	r3, r7	@ tmp161, tmp229
	lsls	r1, r2, #23	@ tmp163, x,
	ldr	r4, .L115+8	@ tmp230,
	mov	r2, r8	@, _11
	movs	r0, #2	@,
	adds	r3, r3, #32	@ tmp161,
	lsrs	r1, r1, #23	@ tmp162, tmp163,
	str	r6, [sp]	@ _26,
	bl	.L117		@
@ C_Code.c:405: 	x += 32; 
	mov	r1, r9	@ x, x
@ C_Code.c:406: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	movs	r3, r7	@ tmp166, tmp229
@ C_Code.c:405: 	x += 32; 
	adds	r1, r1, #32	@ x,
@ C_Code.c:406: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	lsls	r1, r1, #23	@ tmp169, x,
	mov	r2, r8	@, _11
	movs	r0, #2	@,
	adds	r3, r3, #40	@ tmp166,
	str	r6, [sp]	@ _26,
	lsrs	r1, r1, #23	@ tmp168, tmp169,
	bl	.L117		@
@ C_Code.c:407: 	y += 16; x -= 36; 
	movs	r3, #16	@ y,
	mov	r8, r3	@ y, y
@ C_Code.c:404: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	r10, r4	@ tmp230, tmp230
@ C_Code.c:409: 	int count = CountKeysPressed(keys); 
	movs	r2, #5	@ ivtmp_28,
	movs	r4, #1	@ pretmp_81,
@ C_Code.c:345: 	int c = 0; 
	movs	r3, #0	@ c,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r0, #48	@ tmp234,
@ C_Code.c:407: 	y += 16; x -= 36; 
	add	r8, r8, fp	@ y, y
	b	.L65		@
.L107:
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r7, r3	@ tmp174, tmp229, c
	ldrb	r4, [r1, r0]	@ pretmp_81, RomKeysList
.L65:
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r4, r5	@ tmp171, keys
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r1, r4, #1	@ tmp233, tmp171
	sbcs	r4, r4, r1	@ tmp232, tmp171, tmp233
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	subs	r2, r2, #1	@ ivtmp_28,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r3, r3, r4	@ c, c, tmp232
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	cmp	r2, #0	@ ivtmp_28,
	bne	.L107		@,
@ C_Code.c:410: 	if (count == 1) { x += 24; } // centering 
	cmp	r3, #1	@ c,
	beq	.L108		@,
@ C_Code.c:411: 	if (count == 2) { x += 16; } 
	cmp	r3, #2	@ c,
	bne	.L68		@,
@ C_Code.c:411: 	if (count == 2) { x += 16; } 
	mov	r4, r9	@ x, x
	adds	r4, r4, #12	@ x,
.L67:
@ C_Code.c:414: 	if (keys & A_BUTTON) { 
	lsls	r3, r5, #31	@ tmp241, keys,
	bmi	.L109		@,
.L70:
@ C_Code.c:417: 	if (keys & B_BUTTON) { 
	lsls	r3, r5, #30	@ tmp242, keys,
	bmi	.L110		@,
.L71:
@ C_Code.c:420: 	if (keys & DPAD_LEFT) { 
	lsls	r3, r5, #26	@ tmp243, keys,
	bmi	.L111		@,
.L72:
@ C_Code.c:423: 	if (keys & DPAD_RIGHT) { 
	lsls	r3, r5, #27	@ tmp244, keys,
	bmi	.L112		@,
.L73:
@ C_Code.c:426: 	if (keys & DPAD_UP) { 
	lsls	r3, r5, #25	@ tmp245, keys,
	bmi	.L113		@,
.L74:
@ C_Code.c:429: 	if (keys & DPAD_DOWN) { 
	lsls	r5, r5, #24	@ tmp246, keys,
	bmi	.L114		@,
.L59:
@ C_Code.c:436: } 
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
.L106:
	movs	r6, #224	@ _26,
	lsls	r6, r6, #8	@ _26, _26,
	b	.L61		@
.L68:
@ C_Code.c:412: 	if (count == 3) { x += 8; } 
	mov	r2, r9	@ x, x
	adds	r4, r2, #4	@ x, x,
@ C_Code.c:412: 	if (count == 3) { x += 8; } 
	cmp	r3, #3	@ c,
	beq	.L67		@,
@ C_Code.c:407: 	y += 16; x -= 36; 
	subs	r4, r4, #8	@ x,
	b	.L67		@
.L108:
@ C_Code.c:410: 	if (count == 1) { x += 24; } // centering 
	mov	r4, r9	@ x, x
	adds	r4, r4, #20	@ x,
@ C_Code.c:414: 	if (keys & A_BUTTON) { 
	lsls	r3, r5, #31	@ tmp241, keys,
	bpl	.L70		@,
.L109:
@ C_Code.c:415: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp179,
	movs	r3, r7	@ tmp178, tmp229
	ands	r2, r1	@ tmp180, y
	lsls	r1, r4, #23	@ tmp182, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #56	@ tmp178,
	lsrs	r1, r1, #23	@ tmp181, tmp182,
	bl	.L58		@
@ C_Code.c:415: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:417: 	if (keys & B_BUTTON) { 
	lsls	r3, r5, #30	@ tmp242, keys,
	bpl	.L71		@,
.L110:
@ C_Code.c:418: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp188,
	movs	r3, r7	@ tmp187, tmp229
	ands	r2, r1	@ tmp189, y
	lsls	r1, r4, #23	@ tmp191, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #64	@ tmp187,
	lsrs	r1, r1, #23	@ tmp190, tmp191,
	bl	.L58		@
@ C_Code.c:418: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:420: 	if (keys & DPAD_LEFT) { 
	lsls	r3, r5, #26	@ tmp243, keys,
	bpl	.L72		@,
.L111:
@ C_Code.c:421: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp197,
	movs	r3, r7	@ tmp196, tmp229
	ands	r2, r1	@ tmp198, y
	lsls	r1, r4, #23	@ tmp200, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #72	@ tmp196,
	lsrs	r1, r1, #23	@ tmp199, tmp200,
	bl	.L58		@
@ C_Code.c:421: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:423: 	if (keys & DPAD_RIGHT) { 
	lsls	r3, r5, #27	@ tmp244, keys,
	bpl	.L73		@,
.L112:
@ C_Code.c:424: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp206,
	movs	r3, r7	@ tmp205, tmp229
	ands	r2, r1	@ tmp207, y
	lsls	r1, r4, #23	@ tmp209, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #80	@ tmp205,
	lsrs	r1, r1, #23	@ tmp208, tmp209,
	bl	.L58		@
@ C_Code.c:424: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:426: 	if (keys & DPAD_UP) { 
	lsls	r3, r5, #25	@ tmp245, keys,
	bpl	.L74		@,
.L113:
@ C_Code.c:427: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp215,
	movs	r3, r7	@ tmp214, tmp229
	ands	r2, r1	@ tmp216, y
	lsls	r1, r4, #23	@ tmp218, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #88	@ tmp214,
	lsrs	r1, r1, #23	@ tmp217, tmp218,
	bl	.L58		@
@ C_Code.c:427: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:429: 	if (keys & DPAD_DOWN) { 
	lsls	r5, r5, #24	@ tmp246, keys,
	bpl	.L59		@,
.L114:
@ C_Code.c:430: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp224,
	movs	r3, r7	@ tmp229, tmp229
	ands	r2, r1	@ tmp225, y
	lsls	r1, r4, #23	@ tmp227, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #96	@ tmp229,
	lsrs	r1, r1, #23	@ tmp226, tmp227,
	bl	.L58		@
	b	.L59		@
.L116:
	.align	2
.L115:
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
	push	{r4, r5, r6, lr}	@
@ C_Code.c:344: int CountKeysPressed(u32 keys) { 
	movs	r1, r0	@ keys, tmp130
	movs	r2, #5	@ ivtmp_1,
	movs	r3, #1	@ pretmp_5,
@ C_Code.c:345: 	int c = 0; 
	movs	r0, #0	@ <retval>,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r4, #48	@ tmp129,
	ldr	r5, .L125	@ tmp128,
	b	.L121		@
.L124:
	adds	r3, r5, r0	@ tmp123, tmp128, <retval>
	ldrb	r3, [r3, r4]	@ pretmp_5, RomKeysList
.L121:
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r1	@ tmp120, keys
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp127, tmp120
	sbcs	r3, r3, r6	@ tmp126, tmp120, tmp127
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	subs	r2, r2, #1	@ ivtmp_1,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r0, r0, r3	@ <retval>, <retval>, tmp126
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	cmp	r2, #0	@ ivtmp_1,
	bne	.L124		@,
@ C_Code.c:351: } 
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L126:
	.align	2
.L125:
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
@ C_Code.c:353: int PressedSpecificKeys(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r1	@ keys, tmp183
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r5, #48	@ tmp181,
@ C_Code.c:354: 	int reqKeys = GetButtonsToPress(proc); 
	bl	GetButtonsToPress		@
@ C_Code.c:355: 	int count = CountKeysPressed(reqKeys); 
	movs	r1, #5	@ ivtmp_22,
	movs	r3, #1	@ pretmp_26,
@ C_Code.c:345: 	int c = 0; 
	movs	r2, #0	@ c,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r6, .L157	@ tmp180,
	b	.L130		@
.L153:
	adds	r3, r6, r2	@ tmp146, tmp180, c
	ldrb	r3, [r3, r5]	@ pretmp_26, RomKeysList
.L130:
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r0	@ tmp143, reqKeys
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r7, r3, #1	@ tmp164, tmp143
	sbcs	r3, r3, r7	@ tmp163, tmp143, tmp164
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	subs	r1, r1, #1	@ ivtmp_22,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r2, r2, r3	@ c, c, tmp163
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	cmp	r1, #0	@ ivtmp_22,
	bne	.L153		@,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r6, .L157	@ tmp178,
	movs	r5, #5	@ ivtmp_35,
	movs	r3, #1	@ prephitmp_52,
@ C_Code.c:345: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	mov	ip, r6	@ tmp178, tmp178
	movs	r7, #48	@ tmp179,
	b	.L129		@
.L154:
	mov	r3, ip	@ tmp178, tmp178
	adds	r3, r3, r1	@ tmp150, tmp178, c
	ldrb	r3, [r3, r7]	@ prephitmp_52, RomKeysList
.L129:
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp147, keys
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp167, tmp147
	sbcs	r3, r3, r6	@ tmp166, tmp147, tmp167
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	subs	r5, r5, #1	@ ivtmp_35,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp166
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	cmp	r5, #0	@ ivtmp_35,
	bne	.L154		@,
	movs	r5, #5	@ ivtmp_57,
	movs	r3, #1	@ prephitmp_5,
@ C_Code.c:356: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r2, r1	@ c, c
	blt	.L142		@,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r6, #48	@ tmp175,
@ C_Code.c:345: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	mov	ip, r6	@ tmp175, tmp175
	ldr	r7, .L157	@ tmp174,
	b	.L136		@
.L155:
	mov	r6, ip	@ tmp175, tmp175
	adds	r3, r7, r1	@ tmp154, tmp174, c
	ldrb	r3, [r3, r6]	@ prephitmp_5, RomKeysList
.L136:
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp151, keys
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp170, tmp151
	sbcs	r3, r3, r6	@ tmp169, tmp151, tmp170
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	subs	r5, r5, #1	@ ivtmp_57,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp169
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	cmp	r5, #0	@ ivtmp_57,
	bne	.L155		@,
@ C_Code.c:356: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r2, r1	@ tmp155, c, c
@ C_Code.c:356: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp155,
	bgt	.L144		@,
.L138:
@ C_Code.c:357: 	return (keys & reqKeys); 
	ands	r0, r4	@ <retval>, keys
.L127:
@ C_Code.c:358: } 
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L142:
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r6, #48	@ tmp177,
@ C_Code.c:345: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	mov	ip, r6	@ tmp177, tmp177
	ldr	r7, .L157	@ tmp176,
	b	.L133		@
.L156:
	mov	r6, ip	@ tmp177, tmp177
	adds	r3, r7, r1	@ tmp159, tmp176, c
	ldrb	r3, [r3, r6]	@ prephitmp_13, RomKeysList
.L133:
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp156, keys
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp173, tmp156
	sbcs	r3, r3, r6	@ tmp172, tmp156, tmp173
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	subs	r5, r5, #1	@ ivtmp_43,
@ C_Code.c:347: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp172
@ C_Code.c:346: 	for (int i = 0; i < 5; ++i) { 
	cmp	r5, #0	@ ivtmp_43,
	bne	.L156		@,
@ C_Code.c:356: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r1, r2	@ tmp160, c, c
@ C_Code.c:356: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp160,
	ble	.L138		@,
.L144:
@ C_Code.c:356: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	movs	r0, #0	@ <retval>,
	b	.L127		@
.L158:
	.align	2
.L157:
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
@ C_Code.c:360: 	struct Anim* anim = proc->anim; 
	ldr	r5, [r0, #44]	@ anim, proc_17(D)->anim
@ C_Code.c:361: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:361: 	u32 instruction = *anim->pScrCurrent++; 
	adds	r3, r6, #4	@ tmp130, _1,
	str	r3, [r5, #32]	@ tmp130, anim_18->pScrCurrent
@ C_Code.c:362: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	movs	r3, #252	@ tmp132,
@ C_Code.c:359: void SaveInputFrame(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r0	@ proc, tmp151
@ C_Code.c:362: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	movs	r0, #160	@ tmp133,
@ C_Code.c:361: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r2, [r6]	@ instruction, *_1
@ C_Code.c:362: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	lsls	r3, r3, #22	@ tmp132, tmp132,
	ands	r3, r2	@ tmp131, instruction
	lsls	r0, r0, #19	@ tmp133, tmp133,
	cmp	r3, r0	@ tmp131, tmp133
	beq	.L166		@,
.L160:
@ C_Code.c:371: 	if (PressedSpecificKeys(proc, keys)) { 
	movs	r0, r4	@, proc
@ C_Code.c:370: 	instruction = *anim->pScrCurrent--; 
	str	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:371: 	if (PressedSpecificKeys(proc, keys)) { 
	bl	PressedSpecificKeys		@
@ C_Code.c:371: 	if (PressedSpecificKeys(proc, keys)) { 
	cmp	r0, #0	@ tmp153,
	beq	.L159		@,
@ C_Code.c:372: 		if (!proc->frame) { 
	movs	r3, #78	@ tmp143,
@ C_Code.c:372: 		if (!proc->frame) { 
	ldrb	r2, [r4, r3]	@ tmp144,
	cmp	r2, #0	@ tmp144,
	beq	.L167		@,
.L159:
@ C_Code.c:377: }  
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L166:
@ C_Code.c:363: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	movs	r3, #255	@ tmp134,
	ands	r3, r2	@ _4, instruction
@ C_Code.c:363: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	cmp	r3, #4	@ _4,
	beq	.L168		@,
@ C_Code.c:366: 		if (ANINS_COMMAND_GET_ID(instruction) == 0xF) {
	cmp	r3, #15	@ _4,
	bne	.L160		@,
@ C_Code.c:367: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #65	@ tmp141,
	strb	r2, [r4, r3]	@ proc_17(D)->timer,
@ C_Code.c:367: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	movs	r3, #0	@ tmp142,
	str	r3, [r4, #56]	@ tmp142, proc_17(D)->timer2
	b	.L160		@
.L167:
@ C_Code.c:374: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	movs	r1, #128	@,
	movs	r0, #159	@,
@ C_Code.c:373: 			proc->frame = proc->timer; // locate is side for stereo? 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
@ C_Code.c:374: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r1, r1, #1	@,,
@ C_Code.c:373: 			proc->frame = proc->timer; // locate is side for stereo? 
	strb	r2, [r4, r3]	@ proc_17(D)->timer, proc_17(D)->frame
@ C_Code.c:374: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r0, r0, #1	@,,
	movs	r2, #120	@,
	ldr	r4, .L169	@ tmp150,
	subs	r3, r3, #77	@,
	bl	.L117		@
@ C_Code.c:377: }  
	b	.L159		@
.L168:
@ C_Code.c:364: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #75	@ tmp137,
	strb	r2, [r4, r3]	@ proc_17(D)->timer,
@ C_Code.c:364: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	movs	r3, #0	@ tmp138,
	str	r3, [r4, #56]	@ tmp138, proc_17(D)->timer2
	b	.L160		@
.L170:
	.align	2
.L169:
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
@ C_Code.c:379: 	if (proc->frame) { 
	movs	r3, #78	@ tmp128,
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:378: void SaveIfWeHitOnTime(TimedHitsProc* proc) {
	push	{r4, lr}	@
@ C_Code.c:379: 	if (proc->frame) { 
	cmp	r3, #0	@ _1,
	beq	.L171		@,
@ C_Code.c:380: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #80	@ tmp129,
@ C_Code.c:380: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, .L182	@ tmp130,
@ C_Code.c:380: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldrb	r2, [r0, r2]	@ _2,
@ C_Code.c:380: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, [r1]	@ pretmp_33, LenienceFrames
@ C_Code.c:380: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, #255	@ _2,
	beq	.L174		@,
.L181:
@ C_Code.c:380: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	subs	r2, r2, r3	@ tmp131, _2, _1
	asrs	r4, r2, #31	@ tmp147, tmp131,
	adds	r2, r2, r4	@ tmp132, tmp131, tmp147
	eors	r2, r4	@ tmp132, tmp147
@ C_Code.c:380: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, r1	@ tmp132, pretmp_33
	bge	.L175		@,
@ C_Code.c:380: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #72	@ tmp133,
	movs	r4, #1	@ tmp134,
	strb	r4, [r0, r2]	@ tmp134, proc_21(D)->hitOnTime
.L175:
@ C_Code.c:382: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	ldr	r2, [r0, #52]	@ proc_21(D)->timer, proc_21(D)->timer
	subs	r3, r2, r3	@ tmp139, proc_21(D)->timer, _1
@ C_Code.c:382: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	cmp	r3, r1	@ tmp139, pretmp_33
	bge	.L171		@,
@ C_Code.c:382: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	movs	r3, #72	@ tmp141,
	movs	r2, #1	@ tmp142,
	strb	r2, [r0, r3]	@ tmp142, proc_21(D)->hitOnTime
.L171:
@ C_Code.c:385: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L174:
@ C_Code.c:381: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	movs	r2, #79	@ tmp136,
	ldrb	r2, [r0, r2]	@ _8,
@ C_Code.c:381: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	cmp	r2, #255	@ _8,
	bne	.L181		@,
	b	.L175		@
.L183:
	.align	2
.L182:
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
@ C_Code.c:388: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L185	@ tmp118,
@ C_Code.c:389: } 
	@ sp needed	@
@ C_Code.c:388: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldrb	r0, [r3, #31]	@ tmp120,
	movs	r3, #127	@ tmp122,
	bics	r0, r3	@ tmp117, tmp122
@ C_Code.c:389: } 
	bx	lr
.L186:
	.align	2
.L185:
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
@ C_Code.c:388: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L191	@ tmp120,
@ C_Code.c:392: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp123,
	cmp	r3, #127	@ tmp123,
	bhi	.L190		@,
@ C_Code.c:393: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L191+4	@ tmp124,
@ C_Code.c:393: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L190		@,
@ C_Code.c:394: 	return proc->hitOnTime;
	adds	r3, r3, #72	@ tmp126,
	ldrb	r0, [r0, r3]	@ <retval>,
	b	.L187		@
.L190:
@ C_Code.c:392: 	if (CheatCodeOn()) { return true; } 
	movs	r0, #1	@ <retval>,
.L187:
@ C_Code.c:395: }
	@ sp needed	@
	bx	lr
.L192:
	.align	2
.L191:
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
@ C_Code.c:398: 	if (!DisplayPress) { return; } 
	ldr	r4, .L198	@ tmp119,
@ C_Code.c:398: 	if (!DisplayPress) { return; } 
	ldr	r4, [r4]	@ DisplayPress, DisplayPress
	cmp	r4, #0	@ DisplayPress,
	beq	.L193		@,
	bl	DrawButtonsToPress.part.0		@
.L193:
@ C_Code.c:436: } 
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L199:
	.align	2
.L198:
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
@ C_Code.c:516: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp122,
	movs	r3, #192	@ tmp123,
	ldrsb	r1, [r0, r1]	@ tmp122,
	ands	r3, r1	@ _14, tmp122
@ C_Code.c:515: 	if (success) { 
	cmp	r2, #0	@ tmp131,
	beq	.L201		@,
@ C_Code.c:516: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _14,
	bne	.L202		@,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L206	@ tmp124,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L205		@,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L206+4	@ tmp126,
	ldr	r0, [r3]	@ <retval>,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L200		@
.L201:
@ C_Code.c:522: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _14,
	beq	.L205		@,
@ C_Code.c:525: 	return FailedHitDamagePercent; 
	ldr	r3, .L206+8	@ tmp128,
	ldr	r0, [r3]	@ <retval>,
.L200:
@ C_Code.c:526: } 
	@ sp needed	@
	bx	lr
.L202:
@ C_Code.c:520: 		return BonusDamagePercent; 
	ldr	r3, .L206+12	@ tmp127,
	ldr	r0, [r3]	@ <retval>,
	b	.L200		@
.L205:
@ C_Code.c:518: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
	b	.L200		@
.L207:
	.align	2
.L206:
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
@ C_Code.c:516: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp122,
	movs	r3, #192	@ tmp123,
	ldrsb	r1, [r0, r1]	@ tmp122,
	ands	r3, r1	@ _9, tmp122
@ C_Code.c:515: 	if (success) { 
	cmp	r2, #0	@ tmp131,
	beq	.L209		@,
@ C_Code.c:516: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _9,
	bne	.L210		@,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L214	@ tmp124,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L213		@,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L214+4	@ tmp126,
	ldr	r0, [r3]	@ <retval>,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L208		@
.L209:
@ C_Code.c:522: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _9,
	beq	.L213		@,
@ C_Code.c:525: 	return FailedHitDamagePercent; 
	ldr	r3, .L214+8	@ tmp128,
	ldr	r0, [r3]	@ <retval>,
.L208:
@ C_Code.c:530: } 
	@ sp needed	@
	bx	lr
.L210:
@ C_Code.c:520: 		return BonusDamagePercent; 
	ldr	r3, .L214+12	@ tmp127,
	ldr	r0, [r3]	@ <retval>,
	b	.L208		@
.L213:
@ C_Code.c:518: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
@ C_Code.c:529: 	return GetDefaultDamagePercent(active_bunit, opp_bunit, success); 
	b	.L208		@
.L215:
	.align	2
.L214:
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
@ C_Code.c:545: 	for (int i = id; i < 22; i += 2) {
	cmp	r0, #21	@ id,
	bgt	.L216		@,
	ldr	r3, .L226	@ tmp128,
	lsls	r2, r0, #1	@ tmp127, id,
@ C_Code.c:547: 		if (hp == 0xffff) { break; }
	ldr	r5, .L226+4	@ tmp129,
	adds	r2, r2, r3	@ ivtmp.184, tmp127, tmp128
	b	.L220		@
.L218:
	movs	r4, #0	@ _4,
@ C_Code.c:549: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	cmp	r3, r1	@ _1, difference
	blt	.L219		@,
@ C_Code.c:549: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	subs	r3, r3, r1	@ tmp132, _1, difference
.L224:
	lsls	r3, r3, #16	@ tmp133, tmp132,
	lsrs	r4, r3, #16	@ _4, tmp133,
.L219:
@ C_Code.c:545: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:548: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:545: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.184,
	cmp	r0, #21	@ id,
	bgt	.L216		@,
.L220:
@ C_Code.c:546: 		hp = gEfxHpLut[i]; 
	ldrh	r3, [r2]	@ _1, MEM[(short unsigned int *)_18]
@ C_Code.c:547: 		if (hp == 0xffff) { break; }
	cmp	r3, r5	@ _1, tmp129
	beq	.L216		@,
@ C_Code.c:548: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r1, #0	@ difference,
	bge	.L218		@,
@ C_Code.c:548: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	adds	r3, r3, r1	@ hp, _1, difference
	movs	r4, #0	@ _4,
@ C_Code.c:548: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r3, #0	@ hp,
	bgt	.L224		@,
@ C_Code.c:545: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:548: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:545: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.184,
	cmp	r0, #21	@ id,
	ble	.L220		@,
.L216:
@ C_Code.c:553: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L227:
	.align	2
.L226:
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
@ C_Code.c:557: 	if (newHp < 0) { newHp = 0; } 
	mvns	r4, r3	@ tmp157, newHp
@ C_Code.c:558: 	int hp = gEkrGaugeHp[side];
	ldr	r5, [sp, #20]	@ tmp168, side
@ C_Code.c:557: 	if (newHp < 0) { newHp = 0; } 
	asrs	r4, r4, #31	@ tmp156, tmp157,
	ands	r3, r4	@ _14, tmp156
@ C_Code.c:558: 	int hp = gEkrGaugeHp[side];
	ldr	r4, .L236	@ tmp135,
	lsls	r5, r5, #1	@ tmp136, tmp168,
	ldrsh	r4, [r5, r4]	@ _1, gEkrGaugeHp
@ C_Code.c:559: 	some_bunit->unit.curHP = newHp; 
	strb	r3, [r2, #19]	@ _14, some_bunit_22(D)->unit.curHP
@ C_Code.c:560: 	if (hp == newHp) { return; } 
	cmp	r3, r4	@ _14, _1
	beq	.L228		@,
@ C_Code.c:563: 	if (proc->side == side) { 
	movs	r2, #77	@ tmp138,
@ C_Code.c:563: 	if (proc->side == side) { 
	ldr	r5, [sp, #20]	@ tmp169, side
@ C_Code.c:563: 	if (proc->side == side) { 
	ldrb	r2, [r0, r2]	@ tmp139,
@ C_Code.c:563: 	if (proc->side == side) { 
	cmp	r2, r5	@ tmp139, tmp169
	beq	.L235		@,
.L228:
@ C_Code.c:578: }
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L235:
@ C_Code.c:564: 		if (UsingSkillSys) { // uggggh 
	ldr	r2, .L236+4	@ tmp140,
@ C_Code.c:561: 	int diff = newHp - hp; 
	subs	r7, r3, r4	@ diff, _14, _1
@ C_Code.c:564: 		if (UsingSkillSys) { // uggggh 
	ldr	r6, [r2]	@ UsingSkillSys.23_5, UsingSkillSys
@ C_Code.c:566: 			HpProc->post = newHp;
	lsls	r5, r3, #16	@ _35, _14,
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	lsls	r2, r7, #24	@ tmp141, diff,
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	ldr	r0, [r0, #60]	@ pretmp_16, proc_25(D)->currentRound
@ C_Code.c:566: 			HpProc->post = newHp;
	asrs	r5, r5, #16	@ _35, _35,
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	asrs	r2, r2, #24	@ _39, tmp141,
@ C_Code.c:564: 		if (UsingSkillSys) { // uggggh 
	cmp	r6, #0	@ UsingSkillSys.23_5,
	beq	.L233		@,
@ C_Code.c:566: 			HpProc->post = newHp;
	movs	r3, #80	@ tmp143,
@ C_Code.c:565: 			HpProc->cur = hp; 
	strh	r4, [r1, #46]	@ _1, HpProc_26(D)->cur
@ C_Code.c:566: 			HpProc->post = newHp;
	strh	r5, [r1, r3]	@ _35, HpProc_26(D)->post
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	strb	r2, [r0, #3]	@ _39, pretmp_16->hpChange
@ C_Code.c:576: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	cmp	r6, #2	@ UsingSkillSys.23_5,
	bne	.L228		@,
@ C_Code.c:576: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	strh	r7, [r0, #6]	@ diff, pretmp_16->overDmg
	b	.L228		@
.L233:
@ C_Code.c:569: 			HpProc->postHpAtkrSS = newHp; 
	movs	r6, #82	@ tmp146,
	strh	r5, [r1, r6]	@ _35, HpProc_26(D)->postHpAtkrSS
@ C_Code.c:570: 			HpProc->post = newHp>>16; 
	movs	r5, #80	@ tmp149,
@ C_Code.c:570: 			HpProc->post = newHp>>16; 
	asrs	r3, r3, #16	@ tmp148, _14,
@ C_Code.c:570: 			HpProc->post = newHp>>16; 
	strh	r3, [r1, r5]	@ tmp148, HpProc_26(D)->post
@ C_Code.c:571: 			HpProc->cur = hp>>16; 
	asrs	r3, r4, #16	@ tmp151, _1,
@ C_Code.c:571: 			HpProc->cur = hp>>16; 
	strh	r3, [r1, #46]	@ tmp151, HpProc_26(D)->cur
@ C_Code.c:572: 			HpProc->curHpAtkrSS = hp; 
	strh	r4, [r1, #48]	@ _1, HpProc_26(D)->curHpAtkrSS
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	strb	r2, [r0, #3]	@ _39, pretmp_16->hpChange
	b	.L228		@
.L237:
	.align	2
.L236:
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
	mov	r6, r8	@,
	mov	r7, r9	@,
	mov	lr, r10	@,
	push	{r6, r7, lr}	@
	movs	r6, r1	@ HpProc, tmp248
@ C_Code.c:583: 	int side = proc->side; 
	movs	r1, #77	@ tmp162,
@ C_Code.c:582: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	sub	sp, sp, #8	@,,
@ C_Code.c:582: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	movs	r7, r2	@ active_bunit, tmp249
@ C_Code.c:583: 	int side = proc->side; 
	ldrb	r1, [r0, r1]	@ _1,
@ C_Code.c:582: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	ldr	r2, [sp, #44]	@ hp, hp
	movs	r5, r0	@ proc, tmp247
@ C_Code.c:583: 	int side = proc->side; 
	mov	r8, r1	@ _1, _1
@ C_Code.c:585: 	if (hp < 0) { hp = gEkrGaugeHp[side]; } 
	cmp	r2, #0	@ hp,
	bge	.L239		@,
@ C_Code.c:585: 	if (hp < 0) { hp = gEkrGaugeHp[side]; } 
	ldr	r2, .L253	@ tmp163,
	lsls	r1, r1, #1	@ tmp164, _1,
@ C_Code.c:585: 	if (hp < 0) { hp = gEkrGaugeHp[side]; } 
	ldrsh	r2, [r1, r2]	@ hp, gEkrGaugeHp
.L239:
@ C_Code.c:586: 	if (hp <= 0) { // they are dead 
	cmp	r2, #0	@ hp,
	ble	.L251		@,
.L240:
@ C_Code.c:640: 	BattleApplyExpGains();  // update exp 
	ldr	r3, .L253+4	@ tmp230,
	bl	.L10		@
@ C_Code.c:641: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	ldr	r2, .L253+8	@ tmp233,
	ldr	r1, [r2]	@ gpEkrBattleUnitLeft, gpEkrBattleUnitLeft
	movs	r2, #110	@ tmp234,
@ C_Code.c:641: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	ldr	r3, .L253+12	@ tmp231,
@ C_Code.c:641: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	ldrsb	r1, [r1, r2]	@ tmp236,
@ C_Code.c:641: 	gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain; 
	strh	r1, [r3]	@ tmp236, gBanimExpGain[0]
@ C_Code.c:642: 	gBanimExpGain[1] = gpEkrBattleUnitRight->expGain; 
	ldr	r1, .L253+16	@ tmp239,
	ldr	r1, [r1]	@ gpEkrBattleUnitRight, gpEkrBattleUnitRight
	ldrsb	r2, [r1, r2]	@ tmp242,
@ C_Code.c:642: 	gBanimExpGain[1] = gpEkrBattleUnitRight->expGain; 
	strh	r2, [r3, #2]	@ tmp242, gBanimExpGain[1]
@ C_Code.c:644: }
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L251:
@ C_Code.c:558: 	int hp = gEkrGaugeHp[side];
	ldr	r2, .L253	@ tmp243,
	mov	r9, r2	@ tmp243, tmp243
	mov	r2, r8	@ _1, _1
	mov	r1, r9	@ tmp243, tmp243
	lsls	r2, r2, #1	@ tmp166, _1,
	ldrsh	r2, [r1, r2]	@ _60, gEkrGaugeHp
@ C_Code.c:559: 	some_bunit->unit.curHP = newHp; 
	movs	r1, #0	@ tmp167,
	strb	r1, [r3, #19]	@ tmp167, opp_bunit_36(D)->unit.curHP
@ C_Code.c:560: 	if (hp == newHp) { return; } 
	cmp	r2, #0	@ _60,
	beq	.L242		@,
@ C_Code.c:564: 		if (UsingSkillSys) { // uggggh 
	ldr	r3, .L253+20	@ tmp169,
@ C_Code.c:561: 	int diff = newHp - hp; 
	rsbs	r4, r2, #0	@ diff, _60
@ C_Code.c:564: 		if (UsingSkillSys) { // uggggh 
	ldr	r0, [r3]	@ UsingSkillSys.23_66, UsingSkillSys
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	lsls	r3, r4, #24	@ tmp170, diff,
	asrs	r3, r3, #24	@ _94, tmp170,
	mov	r10, r3	@ _94, _94
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	ldr	r3, [r5, #60]	@ pretmp_95, proc_30(D)->currentRound
@ C_Code.c:564: 		if (UsingSkillSys) { // uggggh 
	cmp	r0, #0	@ UsingSkillSys.23_66,
	beq	.L243		@,
@ C_Code.c:565: 			HpProc->cur = hp; 
	strh	r2, [r6, #46]	@ _60, HpProc_35(D)->cur
@ C_Code.c:566: 			HpProc->post = newHp;
	movs	r2, #80	@ tmp172,
	strh	r1, [r6, r2]	@ tmp167, HpProc_35(D)->post
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	mov	r2, r10	@ _94, _94
	strb	r2, [r3, #3]	@ _94, pretmp_95->hpChange
@ C_Code.c:576: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	cmp	r0, #2	@ UsingSkillSys.23_66,
	bne	.L242		@,
@ C_Code.c:576: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	strh	r4, [r3, #6]	@ diff, pretmp_95->overDmg
.L242:
@ C_Code.c:590: 		proc->code4frame = 0xff;
	movs	r3, #79	@ tmp182,
	movs	r2, #255	@ tmp183,
	strb	r2, [r5, r3]	@ tmp183, proc_30(D)->code4frame
@ C_Code.c:595: 		HpProc->death = true; 
	subs	r3, r3, #38	@ tmp185,
	subs	r2, r2, #254	@ tmp186,
	strb	r2, [r6, r3]	@ tmp186, HpProc_35(D)->death
@ C_Code.c:600: 		proc->anim->nextRoundId = 0; // seems to mostly work for now? see GetAnimNextRoundType
	movs	r3, #0	@ tmp189,
	ldr	r2, [r5, #44]	@ proc_30(D)->anim, proc_30(D)->anim
	strh	r3, [r2, #14]	@ tmp189, _3->nextRoundId
@ C_Code.c:601: 		proc->anim2->nextRoundId = 0; 
	ldr	r2, [r5, #48]	@ proc_30(D)->anim2, proc_30(D)->anim2
	strh	r3, [r2, #14]	@ tmp189, _4->nextRoundId
@ C_Code.c:606: 		round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END; 
	movs	r2, #176	@ tmp194,
@ C_Code.c:608: 		struct SkillSysBattleHit* nextRound = GetCurrentRound(proc->roundId + 1); 
	movs	r4, #73	@ tmp201,
@ C_Code.c:606: 		round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END; 
	ldr	r3, [sp, #40]	@ tmp270, round
	ldrb	r3, [r3, #2]	@ tmp197,
	orrs	r3, r2	@ tmp199, tmp194
	ldr	r2, [sp, #40]	@ tmp271, round
	strb	r3, [r2, #2]	@ tmp199,
@ C_Code.c:608: 		struct SkillSysBattleHit* nextRound = GetCurrentRound(proc->roundId + 1); 
	ldrb	r0, [r5, r4]	@ tmp202,
@ C_Code.c:608: 		struct SkillSysBattleHit* nextRound = GetCurrentRound(proc->roundId + 1); 
	ldr	r3, .L253+24	@ tmp204,
	adds	r0, r0, #1	@ tmp203,
	bl	.L10		@
@ C_Code.c:609: 		nextRound->info = BATTLE_HIT_INFO_END; 
	movs	r3, #7	@ tmp210,
	ldrh	r2, [r0, #2]	@ MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_45 + 2B], MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_45 + 2B]
	ands	r3, r2	@ tmp209, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_45 + 2B]
	movs	r2, #128	@ tmp211,
	orrs	r3, r2	@ tmp214, tmp211
	strh	r3, [r0, #2]	@ tmp214, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_45 + 2B]
@ C_Code.c:613: 		u16* animRound = &GetAnimRoundData()[proc->roundId]; 
	ldr	r3, .L253+28	@ tmp216,
	bl	.L10		@
@ C_Code.c:613: 		u16* animRound = &GetAnimRoundData()[proc->roundId]; 
	ldrb	r4, [r5, r4]	@ i,
	lsls	r3, r4, #2	@ tmp225, i,
	adds	r3, r0, r3	@ ivtmp.197, tmp252, tmp225
@ C_Code.c:614: 		for (int i = proc->roundId; i < 32; ++i) { 
	cmp	r4, #31	@ i,
	bgt	.L247		@,
@ C_Code.c:616: 			animRound[i] = 0xFFFF; 
	movs	r0, #1	@ tmp246,
@ C_Code.c:615: 			if (animRound[i] == 0xFFFF) { break; } 
	ldr	r1, .L253+32	@ tmp227,
@ C_Code.c:616: 			animRound[i] = 0xFFFF; 
	rsbs	r0, r0, #0	@ tmp246, tmp246
	b	.L248		@
.L252:
@ C_Code.c:614: 		for (int i = proc->roundId; i < 32; ++i) { 
	adds	r4, r4, #1	@ i,
@ C_Code.c:616: 			animRound[i] = 0xFFFF; 
	strh	r0, [r3]	@ tmp246, MEM[(u16 *)_92]
@ C_Code.c:614: 		for (int i = proc->roundId; i < 32; ++i) { 
	adds	r3, r3, #2	@ ivtmp.197,
	cmp	r4, #32	@ i,
	beq	.L247		@,
.L248:
@ C_Code.c:615: 			if (animRound[i] == 0xFFFF) { break; } 
	ldrh	r2, [r3]	@ MEM[(u16 *)_92], MEM[(u16 *)_92]
	cmp	r2, r1	@ MEM[(u16 *)_92], tmp227
	bne	.L252		@,
.L247:
@ C_Code.c:630: 		side = 1 ^ side; 
	movs	r2, #1	@ tmp221,
	mov	r3, r8	@ _1, _1
	eors	r3, r2	@ _1, tmp221
	movs	r2, r3	@ side, _1
@ C_Code.c:631: 		hp = gEkrGaugeHp[side];
	mov	r1, r9	@ tmp243, tmp243
@ C_Code.c:631: 		hp = gEkrGaugeHp[side];
	lsls	r3, r3, #1	@ tmp223, side,
@ C_Code.c:631: 		hp = gEkrGaugeHp[side];
	ldrsh	r3, [r1, r3]	@ hp, gEkrGaugeHp
@ C_Code.c:632: 		UpdateHP(proc, HpProc, active_bunit, hp, side); 
	movs	r0, r5	@, proc
	str	r2, [sp]	@ side,
	movs	r1, r6	@, HpProc
	movs	r2, r7	@, active_bunit
	bl	UpdateHP		@
	b	.L240		@
.L243:
@ C_Code.c:572: 			HpProc->curHpAtkrSS = hp; 
	strh	r2, [r6, #48]	@ _60, HpProc_35(D)->curHpAtkrSS
@ C_Code.c:571: 			HpProc->cur = hp>>16; 
	asrs	r1, r2, #16	@ tmp177, _60,
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	mov	r2, r10	@ _94, _94
@ C_Code.c:570: 			HpProc->post = newHp>>16; 
	str	r0, [r6, #80]	@ UsingSkillSys.23_66, MEM <vector(2) short int> [(short int *)HpProc_35(D) + 80B]
@ C_Code.c:571: 			HpProc->cur = hp>>16; 
	strh	r1, [r6, #46]	@ tmp177, HpProc_35(D)->cur
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	strb	r2, [r3, #3]	@ _94, pretmp_95->hpChange
	b	.L242		@
.L254:
	.align	2
.L253:
	.word	gEkrGaugeHp
	.word	BattleApplyExpGains
	.word	gpEkrBattleUnitLeft
	.word	gBanimExpGain
	.word	gpEkrBattleUnitRight
	.word	UsingSkillSys
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
@ C_Code.c:648: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r5, [r0, #60]	@ _1, proc_7(D)->currentRound
@ C_Code.c:646: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	movs	r4, r0	@ proc, tmp205
@ C_Code.c:648: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r0, [r5]	@ *_1, *_1
@ C_Code.c:646: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	movs	r7, r1	@ HpProc, tmp206
	mov	r8, r2	@ active_bunit, tmp207
	movs	r6, r3	@ opp_bunit, tmp208
	sub	sp, sp, #12	@,,
@ C_Code.c:648: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsls	r0, r0, #30	@ tmp215, *_1,
	bmi	.L255		@,
@ C_Code.c:648: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	movs	r3, #3	@ tmp152,
	ldrsb	r3, [r5, r3]	@ tmp152,
	cmp	r3, #0	@ tmp152,
	beq	.L255		@,
@ C_Code.c:649: 	if (round->hpChange <= 0) { return; } // healing 
	movs	r1, #3	@ _14,
	ldr	r3, [sp, #48]	@ tmp222, round
	ldrsb	r1, [r3, r1]	@ _14,* _14
@ C_Code.c:649: 	if (round->hpChange <= 0) { return; } // healing 
	cmp	r1, #0	@ _14,
	ble	.L255		@,
@ C_Code.c:650: 	int side = proc->side; 
	movs	r3, #77	@ tmp155,
	ldrb	r3, [r4, r3]	@ side,
	mov	r9, r3	@ side, side
@ C_Code.c:651: 	int hp = gEkrGaugeHp[proc->side];
	mov	r2, r9	@ side, side
	ldr	r3, .L284	@ tmp156,
	lsls	r2, r2, #1	@ tmp157, side,
@ C_Code.c:651: 	int hp = gEkrGaugeHp[proc->side];
	ldrsh	r5, [r2, r3]	@ hp, gEkrGaugeHp
@ C_Code.c:652: 	if (!hp) { CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp); return; } 
	cmp	r5, #0	@ hp,
	beq	.L279		@,
@ C_Code.c:655: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	movs	r3, #1	@ tmp164,
	mov	r0, r9	@ side, side
@ C_Code.c:655: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	ldr	r2, .L284+4	@ tmp159,
@ C_Code.c:655: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	eors	r3, r0	@ tmp163, side
@ C_Code.c:655: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	lsls	r3, r3, #1	@ tmp165, tmp163,
@ C_Code.c:655: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	ldrsh	r3, [r3, r2]	@ oldDamage, gEkrGaugeDmg
	mov	fp, r3	@ oldDamage, oldDamage
@ C_Code.c:655: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	cmp	r3, r1	@ oldDamage, _14
	ble	.L280		@,
.L259:
@ C_Code.c:657: 	int newDamage = (oldDamage * percent) / 100; 
	ldr	r3, [sp, #52]	@ tmp228, percent
@ C_Code.c:657: 	int newDamage = (oldDamage * percent) / 100; 
	movs	r1, #100	@,
@ C_Code.c:657: 	int newDamage = (oldDamage * percent) / 100; 
	mov	r0, fp	@ tmp166, oldDamage
	muls	r0, r3	@ tmp166, tmp228
@ C_Code.c:657: 	int newDamage = (oldDamage * percent) / 100; 
	ldr	r3, .L284+8	@ tmp169,
	bl	.L10		@
@ C_Code.c:658: 	if (!newDamage) { newDamage = 1; } 
	cmp	r0, #0	@ newDamage,
	beq	.L281		@,
@ C_Code.c:659: 	int newHp = hp - newDamage; 
	subs	r3, r5, r0	@ newHp, hp, newDamage
	mov	r10, r3	@ newHp, newHp
@ C_Code.c:660: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	cmp	r3, #0	@ newHp,
	ble	.L282		@,
.L262:
@ C_Code.c:661: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	ldr	r3, .L284+12	@ tmp173,
@ C_Code.c:661: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
@ C_Code.c:661: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	cmp	r3, #0	@ BlockingEnabled,
	bne	.L263		@,
	movs	r3, #1	@ tmp180,
	cmp	fp, r0	@ oldDamage, newDamage
	bgt	.L264		@,
	movs	r3, #0	@ tmp180,
.L264:
	lsls	r3, r3, #24	@ tmp185, tmp180,
	bne	.L283		@,
.L263:
@ C_Code.c:744: 	UpdateHP(proc, HpProc, opp_bunit, newHp, side); 
	mov	r3, r9	@ side, side
	movs	r2, r6	@, opp_bunit
	str	r3, [sp]	@ side,
	movs	r1, r7	@, HpProc
	mov	r3, r10	@, newHp
	movs	r0, r4	@, proc
	bl	UpdateHP		@
@ C_Code.c:748: 	CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, newHp); 
	mov	r3, r10	@ newHp, newHp
	str	r3, [sp, #4]	@ newHp,
.L278:
	ldr	r3, [sp, #48]	@ tmp242, round
	mov	r2, r8	@, active_bunit
	str	r3, [sp]	@ tmp242,
	movs	r1, r7	@, HpProc
	movs	r3, r6	@, opp_bunit
	movs	r0, r4	@, proc
	bl	CheckForDeath		@
.L255:
@ C_Code.c:763: } 
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
.L281:
@ C_Code.c:659: 	int newHp = hp - newDamage; 
	subs	r3, r5, #1	@ newHp, hp,
	mov	r10, r3	@ newHp, newHp
@ C_Code.c:660: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	mov	r2, r10	@ newHp, newHp
	rsbs	r3, r5, #0	@ tmp190, hp
	asrs	r3, r3, #31	@ tmp189, tmp190,
	ands	r2, r3	@ newHp, tmp189
	mov	r10, r2	@ newHp, newHp
@ C_Code.c:658: 	if (!newDamage) { newDamage = 1; } 
	adds	r0, r0, #1	@ newDamage,
	b	.L262		@
.L280:
@ C_Code.c:654: 	int oldDamage = round->hpChange;  
	mov	fp, r1	@ oldDamage, _14
	b	.L259		@
.L279:
@ C_Code.c:652: 	if (!hp) { CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp); return; } 
	str	r5, [sp, #4]	@ hp,
	b	.L278		@
.L283:
@ C_Code.c:661: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	movs	r3, #11	@ tmp186,
	movs	r2, #192	@ tmp187,
	ldrsb	r3, [r6, r3]	@ tmp186,
@ C_Code.c:661: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	tst	r2, r3	@ tmp187, tmp186
	bne	.L263		@,
@ C_Code.c:661: 	if (!BlockingEnabled && (newDamage < oldDamage) && (UNIT_FACTION(&opp_bunit->unit) == FACTION_BLUE)) { newHp = hp - oldDamage; } 
	mov	r3, fp	@ oldDamage, oldDamage
	subs	r3, r5, r3	@ newHp, hp, oldDamage
	mov	r10, r3	@ newHp, newHp
	b	.L263		@
.L282:
@ C_Code.c:660: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	mov	r3, fp	@ oldDamage, oldDamage
	subs	r3, r5, r3	@ newHp, hp, oldDamage
	mov	r10, r3	@ newHp, newHp
@ C_Code.c:660: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	cmp	r3, #0	@ newHp,
	ble	.L265		@,
@ C_Code.c:660: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	ldr	r3, .L284+16	@ tmp171,
@ C_Code.c:660: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	ldr	r3, [r3]	@ BlockingCanPreventLethal, BlockingCanPreventLethal
@ C_Code.c:660: 	if (newHp <= 0) { newHp = 0; if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
	rsbs	r2, r3, #0	@ tmp193, BlockingCanPreventLethal
	adcs	r3, r3, r2	@ tmp192, BlockingCanPreventLethal, tmp193
	mov	r2, r10	@ newHp, newHp
	rsbs	r3, r3, #0	@ tmp194, tmp192
	ands	r2, r3	@ newHp, tmp194
	mov	r10, r2	@ newHp, newHp
	b	.L262		@
.L265:
	movs	r3, #0	@ newHp,
	mov	r10, r3	@ newHp, newHp
	b	.L262		@
.L285:
	.align	2
.L284:
	.word	gEkrGaugeHp
	.word	gEkrGaugeDmg
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
@ C_Code.c:516: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r5, #11	@ tmp125,
	movs	r4, #192	@ tmp126,
	ldrsb	r5, [r2, r5]	@ tmp125,
@ C_Code.c:534: void AdjustDamageWithGetter(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int success) { 
	sub	sp, sp, #12	@,,
@ C_Code.c:516: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	ands	r4, r5	@ _14, tmp125
@ C_Code.c:515: 	if (success) { 
	ldr	r5, [sp, #28]	@ tmp137, success
	cmp	r5, #0	@ tmp137,
	beq	.L287		@,
@ C_Code.c:516: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _14,
	bne	.L288		@,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L301	@ tmp127,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, [r4]	@ BlockingEnabled, BlockingEnabled
	cmp	r4, #0	@ BlockingEnabled,
	beq	.L286		@,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L301+4	@ tmp129,
	ldr	r4, [r4]	@ _19,
@ C_Code.c:536: 	if (percent != 100) { 
	cmp	r4, #100	@ _19,
	bne	.L300		@,
.L286:
@ C_Code.c:539: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L287:
@ C_Code.c:522: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _14,
	beq	.L286		@,
@ C_Code.c:525: 	return FailedHitDamagePercent; 
	ldr	r4, .L301+8	@ tmp131,
	ldr	r4, [r4]	@ _19,
.L290:
@ C_Code.c:536: 	if (percent != 100) { 
	cmp	r4, #100	@ _19,
	beq	.L286		@,
.L300:
@ C_Code.c:537: 		AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r4, [sp, #4]	@ _19,
	ldr	r4, [sp, #24]	@ tmp138, round
	str	r4, [sp]	@ tmp138,
	bl	AdjustDamageByPercent		@
@ C_Code.c:539: }
	b	.L286		@
.L288:
@ C_Code.c:520: 		return BonusDamagePercent; 
	ldr	r4, .L301+12	@ tmp130,
	ldr	r4, [r4]	@ _19,
	b	.L290		@
.L302:
	.align	2
.L301:
	.word	BlockingEnabled
	.word	ReducedDamagePercent
	.word	FailedHitDamagePercent
	.word	BonusDamagePercent
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
@ C_Code.c:442: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldr	r3, .L349	@ tmp162,
@ C_Code.c:442: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldrh	r5, [r3, #8]	@ tmp165,
	ldrh	r3, [r3, #4]	@ tmp167,
@ C_Code.c:442: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	orrs	r5, r3	@ keys, tmp167
@ C_Code.c:446: 	int x = proc->anim2->xPosition; 
	ldr	r3, [r0, #48]	@ proc_5(D)->anim2, proc_5(D)->anim2
@ C_Code.c:439: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r7, r2	@ round, tmp247
@ C_Code.c:446: 	int x = proc->anim2->xPosition; 
	movs	r2, #2	@ tmp254,
	ldrsh	r3, [r3, r2]	@ x, proc_5(D)->anim2, tmp254
	mov	r8, r3	@ x, x
@ C_Code.c:447: 	struct BattleUnit* active_bunit = proc->active_bunit; 
	ldr	r3, [r0, #64]	@ active_bunit, proc_5(D)->active_bunit
	mov	r9, r3	@ active_bunit, active_bunit
@ C_Code.c:448: 	struct BattleUnit* opp_bunit = proc->opp_bunit; 
	ldr	r3, [r0, #68]	@ opp_bunit, proc_5(D)->opp_bunit
	mov	r10, r3	@ opp_bunit, opp_bunit
@ C_Code.c:449: 	int hitTime = !proc->EkrEfxIsUnitHittedNowFrames; 
	movs	r3, #82	@ tmp171,
@ C_Code.c:450: 	if (hitTime) { // 1 frame 
	ldrb	r3, [r0, r3]	@ tmp172,
@ C_Code.c:439: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r4, r0	@ proc, tmp245
	movs	r6, r1	@ HpProc, tmp246
	sub	sp, sp, #8	@,,
@ C_Code.c:450: 	if (hitTime) { // 1 frame 
	cmp	r3, #0	@ tmp172,
	bne	.L305		@,
@ C_Code.c:451: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	ldr	r2, [r0, #56]	@ proc_5(D)->timer2, proc_5(D)->timer2
	cmp	r2, #255	@ proc_5(D)->timer2,
	beq	.L345		@,
.L306:
@ C_Code.c:452: 		SaveInputFrame(proc, keys); 
	movs	r1, r5	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
@ C_Code.c:453: 		SaveIfWeHitOnTime(proc);
	movs	r0, r4	@, proc
	bl	SaveIfWeHitOnTime		@
@ C_Code.c:454: 		if (!proc->adjustedDmg) { 
	movs	r3, #74	@ tmp175,
@ C_Code.c:454: 		if (!proc->adjustedDmg) { 
	ldrb	r2, [r4, r3]	@ tmp176,
	cmp	r2, #0	@ tmp176,
	beq	.L346		@,
.L305:
@ C_Code.c:470: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	movs	r3, #77	@ tmp198,
@ C_Code.c:470: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r0, [r4, r3]	@ tmp199,
	ldr	r3, .L349+4	@ tmp200,
	bl	.L10		@
@ C_Code.c:470: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	cmp	r0, #0	@ tmp201,
	bne	.L312		@,
@ C_Code.c:470: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	movs	r3, #79	@ tmp203,
@ C_Code.c:470: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r3, [r4, r3]	@ tmp204,
	cmp	r3, #255	@ tmp204,
	beq	.L347		@,
.L312:
@ C_Code.c:388: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L349+8	@ tmp207,
@ C_Code.c:392: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp210,
@ C_Code.c:487: 		else if (proc->timer2 < 20) { 
	ldr	r5, [r4, #56]	@ pretmp_104, proc_5(D)->timer2
@ C_Code.c:392: 	if (CheatCodeOn()) { return true; } 
	cmp	r3, #127	@ tmp210,
	bhi	.L314		@,
@ C_Code.c:393: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L349+12	@ tmp211,
@ C_Code.c:393: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L314		@,
@ C_Code.c:394: 	return proc->hitOnTime;
	adds	r3, r3, #72	@ tmp213,
@ C_Code.c:471: 		if (DidWeHitOnTime(proc)) { 
	ldrb	r3, [r4, r3]	@ tmp214,
	cmp	r3, #0	@ tmp214,
	bne	.L314		@,
@ C_Code.c:487: 		else if (proc->timer2 < 20) { 
	cmp	r5, #19	@ pretmp_104,
	bgt	.L316		@,
@ C_Code.c:398: 	if (!DisplayPress) { return; } 
	ldr	r3, .L349+16	@ tmp230,
	ldr	r2, [r3]	@ pretmp_67, DisplayPress
@ C_Code.c:488: 			if (ChangePaletteWhenButtonIsPressed) { 
	ldr	r3, .L349+20	@ tmp231,
@ C_Code.c:488: 			if (ChangePaletteWhenButtonIsPressed) { 
	ldr	r3, [r3]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
	cmp	r3, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L317		@,
@ C_Code.c:398: 	if (!DisplayPress) { return; } 
	cmp	r2, #0	@ pretmp_67,
	beq	.L316		@,
	movs	r3, #15	@,
	movs	r2, #24	@,
	mov	r1, r8	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L316		@
.L346:
@ C_Code.c:522: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	mov	r2, r9	@ active_bunit, active_bunit
	movs	r1, #11	@ tmp177,
	ldrsb	r1, [r2, r1]	@ tmp177,
	movs	r2, #192	@ tmp178,
	ands	r2, r1	@ _114, tmp177
@ C_Code.c:388: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r1, .L349+8	@ tmp179,
@ C_Code.c:392: 	if (CheatCodeOn()) { return true; } 
	ldrb	r1, [r1, #31]	@ tmp182,
	cmp	r1, #127	@ tmp182,
	bhi	.L308		@,
@ C_Code.c:393: 	if (AlwaysWork) { return true; } 
	ldr	r1, .L349+12	@ tmp183,
@ C_Code.c:393: 	if (AlwaysWork) { return true; } 
	ldr	r1, [r1]	@ AlwaysWork, AlwaysWork
	cmp	r1, #0	@ AlwaysWork,
	bne	.L308		@,
@ C_Code.c:394: 	return proc->hitOnTime;
	adds	r1, r1, #72	@ tmp185,
@ C_Code.c:455: 			if (DidWeHitOnTime(proc)) { 
	ldrb	r1, [r4, r1]	@ tmp186,
	cmp	r1, #0	@ tmp186,
	bne	.L308		@,
@ C_Code.c:460: 				proc->adjustedDmg = true; 
	movs	r1, #1	@ tmp195,
	strb	r1, [r4, r3]	@ tmp195, proc_5(D)->adjustedDmg
@ C_Code.c:522: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r2, #128	@ _114,
	beq	.L305		@,
@ C_Code.c:525: 	return FailedHitDamagePercent; 
	ldr	r3, .L349+24	@ tmp197,
	ldr	r3, [r3]	@ _91,
.L344:
@ C_Code.c:536: 	if (percent != 100) { 
	cmp	r3, #100	@ _91,
	beq	.L305		@,
@ C_Code.c:537: 		AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r3, [sp, #4]	@ _91,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	movs	r1, r6	@, HpProc
	movs	r0, r4	@, proc
	str	r7, [sp]	@ round,
	bl	AdjustDamageByPercent		@
	b	.L305		@
.L314:
@ C_Code.c:482: 			if (((y > (-16)) && (y < (161)))) { 
	movs	r3, #63	@ tmp215,
	subs	r3, r3, r5	@ tmp216, tmp215, pretmp_104
@ C_Code.c:482: 			if (((y > (-16)) && (y < (161)))) { 
	cmp	r3, #175	@ tmp216,
	bls	.L348		@,
.L316:
@ C_Code.c:495: 		proc->roundEnd = true; 
	movs	r3, #81	@ tmp233,
	movs	r2, #1	@ tmp234,
	strb	r2, [r4, r3]	@ tmp234, proc_5(D)->roundEnd
.L303:
@ C_Code.c:511: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L345:
@ C_Code.c:451: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	str	r3, [r0, #56]	@ tmp172, proc_5(D)->timer2
	b	.L306		@
.L347:
@ C_Code.c:470: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	subs	r3, r3, #175	@ tmp205,
@ C_Code.c:470: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r3, [r4, r3]	@ tmp206,
	cmp	r3, #255	@ tmp206,
	bne	.L312		@,
@ C_Code.c:499: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	ldr	r3, [r4, #52]	@ proc_5(D)->timer, proc_5(D)->timer
	cmp	r3, #0	@ proc_5(D)->timer,
	bgt	.L319		@,
@ C_Code.c:499: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	movs	r3, #78	@ tmp237,
	strb	r0, [r4, r3]	@ tmp201, proc_5(D)->frame
.L320:
@ C_Code.c:504: 		if (!proc->roundEnd) { 
	movs	r3, #81	@ tmp240,
@ C_Code.c:504: 		if (!proc->roundEnd) { 
	ldrb	r3, [r4, r3]	@ tmp241,
	cmp	r3, #0	@ tmp241,
	bne	.L303		@,
@ C_Code.c:398: 	if (!DisplayPress) { return; } 
	ldr	r3, .L349+16	@ tmp242,
@ C_Code.c:398: 	if (!DisplayPress) { return; } 
	ldr	r3, [r3]	@ DisplayPress, DisplayPress
	cmp	r3, #0	@ DisplayPress,
	beq	.L303		@,
	movs	r3, #15	@,
	movs	r2, #24	@,
	mov	r1, r8	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L303		@
.L317:
	cmp	r2, #0	@ pretmp_67,
	beq	.L316		@,
	movs	r3, #14	@,
	movs	r2, #24	@,
	mov	r1, r8	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L316		@
.L308:
@ C_Code.c:456: 				proc->adjustedDmg = true; 
	movs	r3, #74	@ tmp187,
	movs	r1, #1	@ tmp188,
	strb	r1, [r4, r3]	@ tmp188, proc_5(D)->adjustedDmg
@ C_Code.c:516: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r2, #128	@ _114,
	bne	.L310		@,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L349+28	@ tmp190,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	bne	.LCB2017	@
	b	.L305	@long jump	@
.LCB2017:
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L349+32	@ tmp192,
	ldr	r3, [r3]	@ _73,
@ C_Code.c:517: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L344		@
.L348:
@ C_Code.c:477: 			x += Mod(clock, 8) >> 1; 
	movs	r1, #8	@,
	movs	r0, r5	@, pretmp_104
	ldr	r3, .L349+36	@ tmp217,
	bl	.L10		@
@ C_Code.c:479: 			y -= clock; 
	movs	r1, #48	@ tmp220,
@ C_Code.c:483: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	movs	r2, #255	@ tmp222,
@ C_Code.c:479: 			y -= clock; 
	subs	r1, r1, r5	@ y, tmp220, pretmp_104
@ C_Code.c:483: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	ands	r2, r1	@ tmp223, y
@ C_Code.c:477: 			x += Mod(clock, 8) >> 1; 
	asrs	r1, r0, #1	@ tmp224, tmp249,
@ C_Code.c:483: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	movs	r0, #224	@ tmp228,
@ C_Code.c:477: 			x += Mod(clock, 8) >> 1; 
	add	r1, r1, r8	@ x, x
@ C_Code.c:483: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	lsls	r0, r0, #8	@ tmp228, tmp228,
	lsls	r1, r1, #23	@ tmp227, x,
	str	r0, [sp]	@ tmp228,
	ldr	r3, .L349+40	@ tmp219,
	movs	r0, #0	@,
	ldr	r5, .L349+44	@ tmp229,
	lsrs	r1, r1, #23	@ tmp226, tmp227,
	bl	.L28		@
	b	.L316		@
.L310:
@ C_Code.c:520: 		return BonusDamagePercent; 
	ldr	r3, .L349+48	@ tmp193,
	ldr	r3, [r3]	@ _73,
	b	.L344		@
.L319:
@ C_Code.c:502: 			SaveInputFrame(proc, keys); 
	movs	r1, r5	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
	b	.L320		@
.L350:
	.align	2
.L349:
	.word	sKeyStatusBuffer
	.word	EkrEfxIsUnitHittedNow
	.word	gPlaySt
	.word	AlwaysWork
	.word	DisplayPress
	.word	ChangePaletteWhenButtonIsPressed
	.word	FailedHitDamagePercent
	.word	BlockingEnabled
	.word	ReducedDamagePercent
	.word	Mod
	.word	.LANCHOR0+104
	.word	PutSprite
	.word	BonusDamagePercent
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
	push	{r3, r4, r5, r6, r7, lr}	@
@ C_Code.c:439: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r4, r3	@ round, tmp155
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldr	r3, .L357	@ tmp126,
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldrh	r5, [r3]	@ gBattleStats, gBattleStats
	movs	r3, #252	@ tmp130,
	lsls	r3, r3, #2	@ tmp130, tmp130,
@ C_Code.c:439: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r7, r0	@ proc, tmp153
	movs	r6, r2	@ HpProc, tmp154
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	tst	r5, r3	@ gBattleStats, tmp130
	bne	.L351		@,
@ C_Code.c:97: 	if (TimedHitsDifficultyRam->off) { return false; } 
	ldr	r3, .L357+4	@ tmp135,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_13, *TimedHitsDifficultyRam.0_13
@ C_Code.c:97: 	if (TimedHitsDifficultyRam->off) { return false; } 
	lsls	r3, r3, #25	@ tmp158, *TimedHitsDifficultyRam.0_13,
	bpl	.L356		@,
.L351:
@ C_Code.c:511: } 
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L356:
@ C_Code.c:98: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L357+8	@ tmp145,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L357+12	@ tmp147,
	bl	.L10		@
@ C_Code.c:440: 	if (!AreTimedHitsEnabled()) { return; } 
	cmp	r0, #0	@ tmp156,
	bne	.L351		@,
@ C_Code.c:441: 	if (round->hpChange < 0) { return; } // healing 
	ldrb	r3, [r4, #3]	@ tmp152,
	cmp	r3, #127	@ tmp152,
	bhi	.L351		@,
	movs	r2, r4	@, round
	movs	r1, r6	@, HpProc
	movs	r0, r7	@, proc
	bl	DoStuffIfHit.part.0		@
	b	.L351		@
.L358:
	.align	2
.L357:
	.word	gBattleStats
	.word	TimedHitsDifficultyRam
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
@ C_Code.c:262: 	if (!proc->anim) { return; } 
	ldr	r3, [r0, #44]	@ proc_25(D)->anim, proc_25(D)->anim
@ C_Code.c:261: void LoopTimedHitsProc(TimedHitsProc* proc) { 
	movs	r4, r0	@ proc, tmp209
	sub	sp, sp, #8	@,,
@ C_Code.c:262: 	if (!proc->anim) { return; } 
	cmp	r3, #0	@ proc_25(D)->anim,
	beq	.L359		@,
@ C_Code.c:264: 	struct ProcEkrBattle* battleProc = gpProcEkrBattle; 
	ldr	r3, .L386	@ tmp149,
@ C_Code.c:266: 	if (!battleProc) { return; } 
	ldr	r3, [r3]	@ gpProcEkrBattle, gpProcEkrBattle
	cmp	r3, #0	@ gpProcEkrBattle,
	beq	.L359		@,
@ C_Code.c:267: 	if (!proc->anim2) { return; } 
	ldr	r3, [r0, #48]	@ proc_25(D)->anim2, proc_25(D)->anim2
	cmp	r3, #0	@ proc_25(D)->anim2,
	beq	.L359		@,
@ C_Code.c:269: 	proc->timer++;
	ldr	r3, [r0, #52]	@ proc_25(D)->timer, proc_25(D)->timer
	adds	r3, r3, #1	@ tmp152,
	str	r3, [r0, #52]	@ tmp152, proc_25(D)->timer
@ C_Code.c:270: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	ldr	r3, [r0, #56]	@ _5, proc_25(D)->timer2
@ C_Code.c:270: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	cmp	r3, #255	@ _5,
	beq	.L363		@,
@ C_Code.c:270: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	adds	r3, r3, #1	@ tmp154,
	str	r3, [r0, #56]	@ tmp154, proc_25(D)->timer2
.L363:
@ C_Code.c:274: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	movs	r5, #82	@ tmp155,
	ldrb	r3, [r4, r5]	@ _7,
@ C_Code.c:272: 	struct SkillSysBattleHit* currentRound = proc->currentRound; 
	ldr	r6, [r4, #60]	@ currentRound, proc_25(D)->currentRound
@ C_Code.c:274: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	cmp	r3, #255	@ _7,
	beq	.L364		@,
@ C_Code.c:275: 		proc->EkrEfxIsUnitHittedNowFrames++; 
	adds	r3, r3, #1	@ tmp156,
	strb	r3, [r4, r5]	@ tmp156, proc_25(D)->EkrEfxIsUnitHittedNowFrames
.L365:
@ C_Code.c:280: 	struct NewProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	ldr	r3, .L386+4	@ tmp167,
	ldr	r0, [r3]	@ gProcScr_efxHPBar, gProcScr_efxHPBar
	ldr	r3, .L386+8	@ tmp169,
	bl	.L10		@
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldr	r3, .L386+12	@ tmp170,
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	ldrh	r2, [r3]	@ gBattleStats, gBattleStats
	movs	r3, #252	@ tmp174,
	lsls	r3, r3, #2	@ tmp174, tmp174,
@ C_Code.c:280: 	struct NewProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	movs	r5, r0	@ HpProc, tmp211
@ C_Code.c:94: 	if (gBattleStats.config & (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS | BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING)) { 
	tst	r2, r3	@ gBattleStats, tmp174
	bne	.L367		@,
@ C_Code.c:97: 	if (TimedHitsDifficultyRam->off) { return false; } 
	ldr	r3, .L386+16	@ tmp179,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_44, *TimedHitsDifficultyRam.0_44
@ C_Code.c:97: 	if (TimedHitsDifficultyRam->off) { return false; } 
	lsls	r3, r3, #25	@ tmp217, *TimedHitsDifficultyRam.0_44,
	bpl	.L385		@,
.L367:
@ C_Code.c:255: 	if (!HpProc) { return false; } // 
	cmp	r5, #0	@ HpProc,
	beq	.L359		@,
@ C_Code.c:257: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #82	@ tmp197,
@ C_Code.c:257: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r3, [r4, r3]	@ tmp198,
	cmp	r3, #0	@ tmp198,
	bne	.L359		@,
@ C_Code.c:284: 		int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId); 
	movs	r6, #73	@ tmp200,
@ C_Code.c:284: 		int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId); 
	ldrb	r3, [r4, r6]	@ tmp201,
	movs	r1, #0	@,
	movs	r2, #0	@,
	ldr	r0, [r4, #48]	@ proc_25(D)->anim2, proc_25(D)->anim2
	ldr	r5, .L386+20	@ tmp202,
	str	r3, [sp]	@ tmp201,
	movs	r3, #0	@,
	bl	.L28		@
	movs	r3, r0	@ x, tmp213
@ C_Code.c:285: 		x = DisplayDamage2(proc->anim, 1, proc->anim->xPosition, x, proc->roundId);  
	ldr	r0, [r4, #44]	@ _16, proc_25(D)->anim
	movs	r1, #2	@ tmp219,
	ldrsh	r2, [r0, r1]	@ tmp203, _16, tmp219
	ldrb	r1, [r4, r6]	@ tmp205,
	str	r1, [sp]	@ tmp205,
	movs	r1, #1	@,
	bl	.L28		@
.L359:
@ C_Code.c:288: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L385:
@ C_Code.c:98: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L386+24	@ tmp189,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L386+28	@ tmp191,
	bl	.L10		@
@ C_Code.c:440: 	if (!AreTimedHitsEnabled()) { return; } 
	cmp	r0, #0	@ tmp212,
	bne	.L367		@,
@ C_Code.c:441: 	if (round->hpChange < 0) { return; } // healing 
	ldrb	r3, [r6, #3]	@ tmp196,
	cmp	r3, #127	@ tmp196,
	bhi	.L367		@,
	movs	r2, r6	@, currentRound
	movs	r1, r5	@, HpProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit.part.0		@
	b	.L367		@
.L364:
@ C_Code.c:277: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #77	@ tmp159,
@ C_Code.c:277: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	ldrb	r0, [r4, r3]	@ tmp160,
	ldr	r3, .L386+32	@ tmp161,
	bl	.L10		@
@ C_Code.c:277: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	cmp	r0, #0	@ tmp210,
	beq	.L365		@,
@ C_Code.c:277: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #0	@ tmp165,
	strb	r3, [r4, r5]	@ tmp165, proc_25(D)->EkrEfxIsUnitHittedNowFrames
	b	.L365		@
.L387:
	.align	2
.L386:
	.word	gpProcEkrBattle
	.word	gProcScr_efxHPBar
	.word	Proc_Find
	.word	gBattleStats
	.word	TimedHitsDifficultyRam
	.word	DisplayDamage2
	.word	DisabledFlag
	.word	CheckFlag
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
@ C_Code.c:775: 	int result = gPlaySt.config.animationType; 
	movs	r2, #66	@ tmp130,
@ C_Code.c:774: int GetBattleAnimPreconfType(void) {
	push	{r4, lr}	@
@ C_Code.c:775: 	int result = gPlaySt.config.animationType; 
	ldr	r3, .L400	@ tmp164,
	ldrb	r0, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:776: 	if (!CheatCodeOn()) { 
	ldrb	r2, [r3, #31]	@ tmp139,
@ C_Code.c:775: 	int result = gPlaySt.config.animationType; 
	lsls	r0, r0, #29	@ tmp134, gPlaySt,
@ C_Code.c:775: 	int result = gPlaySt.config.animationType; 
	lsrs	r0, r0, #30	@ <retval>, tmp134,
@ C_Code.c:776: 	if (!CheatCodeOn()) { 
	cmp	r2, #127	@ tmp139,
	bhi	.L389		@,
@ C_Code.c:777: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, .L400+4	@ tmp140,
@ C_Code.c:777: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, [r2]	@ ForceAnimsOn, ForceAnimsOn
	cmp	r2, #0	@ ForceAnimsOn,
	beq	.L389		@,
@ C_Code.c:777: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	cmp	r0, #2	@ <retval>,
	beq	.L388		@,
.L392:
@ C_Code.c:777: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	movs	r0, #1	@ <retval>,
.L388:
@ C_Code.c:798: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L389:
@ C_Code.c:780:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r2, #66	@ tmp143,
	ldrb	r2, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:780:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r3, #6	@ tmp149,
	ands	r3, r2	@ tmp150, gPlaySt
	cmp	r3, #4	@ tmp150,
	bne	.L388		@,
@ C_Code.c:784:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	movs	r1, #11	@ tmp154,
@ C_Code.c:785:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	movs	r4, #11	@ pretmp_25,
@ C_Code.c:784:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldr	r0, .L400+8	@ tmp153,
@ C_Code.c:785:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldr	r2, .L400+12	@ tmp152,
@ C_Code.c:784:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldrsb	r1, [r0, r1]	@ tmp154,
	adds	r3, r3, #188	@ tmp155,
@ C_Code.c:785:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldrsb	r4, [r2, r4]	@ pretmp_25,* pretmp_25
@ C_Code.c:784:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	tst	r3, r1	@ tmp155, tmp154
	beq	.L399		@,
@ C_Code.c:790:         if (UNIT_FACTION(&gBattleTarget.unit) != FACTION_BLUE)
	tst	r3, r4	@ tmp155, pretmp_25
	bne	.L392		@,
@ C_Code.c:797:         return GetSoloAnimPreconfType(&gBattleTarget.unit);
	movs	r0, r2	@, tmp152
.L399:
	ldr	r3, .L400+16	@ tmp162,
	bl	.L10		@
	b	.L388		@
.L401:
	.align	2
.L400:
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
.LC110:
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
	.word	.LC110
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
.L117:
	bx	r4
.L28:
	bx	r5
.L58:
	bx	r10
