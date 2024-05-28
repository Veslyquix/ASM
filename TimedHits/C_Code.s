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
@ C_Code.c:94: 	if (TimedHitsDifficultyRam->off) { return false; } 
	ldr	r3, .L6	@ tmp122,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_1, *TimedHitsDifficultyRam.0_1
@ C_Code.c:94: 	if (TimedHitsDifficultyRam->off) { return false; } 
	movs	r0, #0	@ <retval>,
@ C_Code.c:93: int AreTimedHitsEnabled(void) { 
	push	{r4, lr}	@
@ C_Code.c:94: 	if (TimedHitsDifficultyRam->off) { return false; } 
	lsls	r3, r3, #25	@ tmp142, *TimedHitsDifficultyRam.0_1,
	bmi	.L1		@,
@ C_Code.c:95: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L6+4	@ tmp132,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L6+8	@ tmp134,
	bl	.L8		@
@ C_Code.c:95: 	return !CheckFlag(DisabledFlag); 
	rsbs	r3, r0, #0	@ tmp139, tmp141
	adcs	r0, r0, r3	@ <retval>, tmp141, tmp139
.L1:
@ C_Code.c:96: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L7:
	.align	2
.L6:
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
@ C_Code.c:99: 	proc->anim = NULL; 
	movs	r3, #0	@ tmp115,
@ C_Code.c:118: } 
	@ sp needed	@
@ C_Code.c:104: 	proc->timer2 = 0xFF; 
	movs	r2, #255	@ tmp118,
@ C_Code.c:114: 	proc->buttonsToPress = 0; 
	movs	r1, #84	@ tmp122,
@ C_Code.c:99: 	proc->anim = NULL; 
	str	r3, [r0, #44]	@ tmp115, proc_2(D)->anim
@ C_Code.c:100: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp115, proc_2(D)->anim2
@ C_Code.c:103: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp115, proc_2(D)->timer
@ C_Code.c:109: 	proc->currentRound = NULL; 
	str	r3, [r0, #60]	@ tmp115, proc_2(D)->currentRound
@ C_Code.c:110: 	proc->active_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp115, proc_2(D)->active_bunit
@ C_Code.c:111: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #68]	@ tmp115, proc_2(D)->opp_bunit
@ C_Code.c:104: 	proc->timer2 = 0xFF; 
	str	r2, [r0, #56]	@ tmp118, proc_2(D)->timer2
@ C_Code.c:114: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r1]	@ tmp115, proc_2(D)->buttonsToPress
@ C_Code.c:105: 	proc->hitOnTime = false; 
	str	r3, [r0, #72]	@ tmp115, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 72B]
	ldr	r3, .L10	@ tmp126,
	str	r3, [r0, #76]	@ tmp126, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 76B]
@ C_Code.c:116: 	proc->codefframe = 0xff;
	movs	r3, #80	@ tmp127,
	ldr	r1, .L10+4	@ tmp128,
	strh	r1, [r0, r3]	@ tmp128, MEM <vector(2) unsigned char> [(unsigned char *)proc_2(D) + 80B]
@ C_Code.c:117: 	proc->EkrEfxIsUnitHittedNowFrames = 0xff; 
	adds	r3, r3, #2	@ tmp130,
	strb	r2, [r0, r3]	@ tmp118, proc_2(D)->EkrEfxIsUnitHittedNowFrames
@ C_Code.c:118: } 
	bx	lr
.L11:
	.align	2
.L10:
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
@ C_Code.c:122: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r4, .L15	@ tmp115,
	ldr	r3, .L15+4	@ tmp116,
	movs	r0, r4	@, tmp115
	bl	.L8		@
@ C_Code.c:123: 	if (!proc) { 
	cmp	r0, #0	@ tmp119,
	beq	.L14		@,
.L12:
@ C_Code.c:127: } 
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L14:
@ C_Code.c:124: 		proc = Proc_Start(TimedHitsProcCmd, (void*)3); 
	movs	r1, #3	@,
	movs	r0, r4	@, tmp115
	ldr	r3, .L15+8	@ tmp118,
	bl	.L8		@
@ C_Code.c:127: } 
	b	.L12		@
.L16:
	.align	2
.L15:
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
@ C_Code.c:132: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r3, .L24	@ tmp130,
@ C_Code.c:130: void SetCurrentAnimInProc(struct Anim* anim) { 
	movs	r5, r0	@ anim, tmp195
@ C_Code.c:132: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r0, .L24+4	@ tmp129,
	bl	.L8		@
	subs	r4, r0, #0	@ proc, tmp196,
@ C_Code.c:133: 	if (!proc) { return; } 
	beq	.L17		@,
@ C_Code.c:100: 	proc->anim2 = NULL; 
	movs	r3, #0	@ tmp131,
@ C_Code.c:114: 	proc->buttonsToPress = 0; 
	movs	r2, #84	@ tmp136,
@ C_Code.c:100: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp131, proc_18->anim2
@ C_Code.c:103: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp131, proc_18->timer
@ C_Code.c:109: 	proc->currentRound = NULL; 
	str	r3, [r0, #60]	@ tmp131, proc_18->currentRound
@ C_Code.c:110: 	proc->active_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp131, proc_18->active_bunit
@ C_Code.c:111: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #68]	@ tmp131, proc_18->opp_bunit
@ C_Code.c:114: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r2]	@ tmp131, proc_18->buttonsToPress
@ C_Code.c:105: 	proc->hitOnTime = false; 
	str	r3, [r0, #72]	@ tmp131, MEM <vector(4) unsigned char> [(unsigned char *)proc_18 + 72B]
	ldr	r3, .L24+8	@ tmp140,
	str	r3, [r0, #76]	@ tmp140, MEM <vector(4) unsigned char> [(unsigned char *)proc_18 + 76B]
@ C_Code.c:117: 	proc->EkrEfxIsUnitHittedNowFrames = 0xff; 
	movs	r3, #255	@ tmp142,
	subs	r2, r2, #2	@ tmp141,
	strb	r3, [r0, r2]	@ tmp142, proc_18->EkrEfxIsUnitHittedNowFrames
@ C_Code.c:116: 	proc->codefframe = 0xff;
	subs	r2, r2, #2	@ tmp144,
	strh	r3, [r0, r2]	@ tmp142, MEM <vector(2) unsigned char> [(unsigned char *)proc_18 + 80B]
@ C_Code.c:138: 	proc->anim = anim; 
	str	r5, [r0, #44]	@ anim, proc_18->anim
@ C_Code.c:139: 	proc->anim2 = GetAnimAnotherSide(anim); 
	ldr	r3, .L24+12	@ tmp147,
	movs	r0, r5	@, anim
	bl	.L8		@
@ C_Code.c:139: 	proc->anim2 = GetAnimAnotherSide(anim); 
	str	r0, [r4, #48]	@ tmp197, proc_18->anim2
@ C_Code.c:140: 	proc->roundId = anim->nextRoundId-1; 
	ldrh	r3, [r5, #14]	@ tmp150,
	subs	r3, r3, #1	@ tmp151,
	lsls	r3, r3, #24	@ tmp152, tmp151,
	lsrs	r0, r3, #24	@ _4, tmp152,
@ C_Code.c:140: 	proc->roundId = anim->nextRoundId-1; 
	movs	r3, #73	@ tmp153,
	strb	r0, [r4, r3]	@ _4, proc_18->roundId
@ C_Code.c:143: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	ldr	r3, .L24+16	@ tmp155,
	bl	.L8		@
@ C_Code.c:144: 	proc->side = GetAnimPosition(anim) ^ 1; 
	ldr	r3, .L24+20	@ tmp156,
@ C_Code.c:143: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	str	r0, [r4, #60]	@ tmp198, proc_18->currentRound
@ C_Code.c:144: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r0, r5	@, anim
	bl	.L8		@
@ C_Code.c:144: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r3, #1	@ tmp158,
@ C_Code.c:144: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r2, #77	@ tmp161,
@ C_Code.c:144: 	proc->side = GetAnimPosition(anim) ^ 1; 
	lsls	r0, r0, #24	@ tmp157, tmp199,
	asrs	r0, r0, #24	@ _8, tmp157,
	eors	r3, r0	@ tmp160, _8
@ C_Code.c:144: 	proc->side = GetAnimPosition(anim) ^ 1; 
	strb	r3, [r4, r2]	@ tmp160, proc_18->side
@ C_Code.c:145: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, .L24+24	@ tmp163,
@ C_Code.c:146: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, .L24+28	@ tmp164,
@ C_Code.c:145: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, [r3]	@ gpEkrBattleUnitLeft.2_11, gpEkrBattleUnitLeft
@ C_Code.c:146: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, [r2]	@ gpEkrBattleUnitRight.3_12, gpEkrBattleUnitRight
@ C_Code.c:145: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	str	r3, [r4, #64]	@ gpEkrBattleUnitLeft.2_11, proc_18->active_bunit
@ C_Code.c:146: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #68]	@ gpEkrBattleUnitRight.3_12, proc_18->opp_bunit
@ C_Code.c:147: 	if (!proc->side) { 
	cmp	r0, #1	@ _8,
	beq	.L22		@,
@ C_Code.c:151: 	if (!proc->loadedImg) {
	movs	r6, #76	@ tmp165,
@ C_Code.c:151: 	if (!proc->loadedImg) {
	ldrb	r3, [r4, r6]	@ tmp166,
	cmp	r3, #0	@ tmp166,
	beq	.L23		@,
.L17:
@ C_Code.c:163: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L22:
@ C_Code.c:151: 	if (!proc->loadedImg) {
	movs	r6, #76	@ tmp165,
@ C_Code.c:148: 		proc->active_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #64]	@ gpEkrBattleUnitRight.3_12, proc_18->active_bunit
@ C_Code.c:149: 		proc->opp_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #68]	@ gpEkrBattleUnitLeft.2_11, proc_18->opp_bunit
@ C_Code.c:151: 	if (!proc->loadedImg) {
	ldrb	r3, [r4, r6]	@ tmp166,
	cmp	r3, #0	@ tmp166,
	bne	.L17		@,
.L23:
@ C_Code.c:152: 		proc->timer2 = 0xFF; 
	adds	r3, r3, #255	@ tmp167,
@ C_Code.c:153: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r5, .L24+32	@ tmp170,
	movs	r2, #6	@,
@ C_Code.c:152: 		proc->timer2 = 0xFF; 
	str	r3, [r4, #56]	@ tmp167, proc_18->timer2
@ C_Code.c:153: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r0, .L24+36	@ tmp169,
	ldr	r1, .L24+40	@,
	subs	r3, r3, #253	@,
	bl	.L26		@
@ C_Code.c:154: 		Copy2dChr(&BattleStar, (void*)0x06012a40, 2, 2); // 0x108 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L24+44	@ tmp172,
	ldr	r1, .L24+48	@,
	bl	.L26		@
@ C_Code.c:155: 		Copy2dChr(&A_Button, (void*)0x06012800, 2, 2); // 0x140
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L24+52	@ tmp175,
	ldr	r1, .L24+56	@,
	bl	.L26		@
@ C_Code.c:156: 		Copy2dChr(&B_Button, (void*)0x06012840, 2, 2); // 0x142 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L24+60	@ tmp178,
	ldr	r1, .L24+64	@,
	bl	.L26		@
@ C_Code.c:157: 		Copy2dChr(&Left_Button, (void*)0x06012880, 2, 2); // 0x144
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L24+68	@ tmp181,
	ldr	r1, .L24+72	@,
	bl	.L26		@
@ C_Code.c:158: 		Copy2dChr(&Right_Button, (void*)0x060128C0, 2, 2); // 0x146
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L24+76	@ tmp184,
	ldr	r1, .L24+80	@,
	bl	.L26		@
@ C_Code.c:159: 		Copy2dChr(&Up_Button, (void*)0x06012900, 2, 2); // 0x148
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L24+84	@ tmp187,
	ldr	r1, .L24+88	@,
	bl	.L26		@
@ C_Code.c:160: 		Copy2dChr(&Down_Button, (void*)0x06012940, 2, 2); // 0x14a
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L24+92	@ tmp190,
	ldr	r1, .L24+96	@,
	bl	.L26		@
@ C_Code.c:161: 		proc->loadedImg = true;
	movs	r3, #1	@ tmp193,
	strb	r3, [r4, r6]	@ tmp193, proc_18->loadedImg
	b	.L17		@
.L25:
	.align	2
.L24:
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
@ C_Code.c:245: 	if (proc->broke) { return; } 
	movs	r3, #75	@ tmp116,
@ C_Code.c:245: 	if (proc->broke) { return; } 
	ldrb	r2, [r0, r3]	@ tmp117,
	cmp	r2, #0	@ tmp117,
	bne	.L27		@,
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
.L27:
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
	beq	.L31		@,
@ C_Code.c:254: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #82	@ tmp119,
@ C_Code.c:254: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r0, [r0, r3]	@ tmp121,
	rsbs	r3, r0, #0	@ tmp123, tmp121
	adcs	r0, r0, r3	@ <retval>, tmp121, tmp123
.L29:
@ C_Code.c:256: } 
	@ sp needed	@
	bx	lr
.L31:
@ C_Code.c:252: 	if (!HpProc) { return false; } // 
	movs	r0, #0	@ <retval>,
	b	.L29		@
	.size	HitNow, .-HitNow
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC24:
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
@ C_Code.c:301: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, .L54	@ tmp137,
@ C_Code.c:301: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:300: int GetButtonsToPress(TimedHitsProc* proc) { 
	mov	r8, r0	@ proc, tmp179
	sub	sp, sp, #8	@,,
@ C_Code.c:301: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	cmp	r3, #0	@ AlwaysA,
	bne	.L43		@,
@ C_Code.c:301: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldr	r3, .L54+4	@ tmp139,
	ldr	r2, [r3]	@ TimedHitsDifficultyRam.8_2, TimedHitsDifficultyRam
@ C_Code.c:301: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.8_2, *TimedHitsDifficultyRam.8_2
	lsls	r3, r3, #26	@ tmp181, *TimedHitsDifficultyRam.8_2,
	bmi	.L43		@,
@ C_Code.c:302: 	int keys = proc->buttonsToPress;
	movs	r3, #84	@ tmp149,
@ C_Code.c:302: 	int keys = proc->buttonsToPress;
	ldrh	r0, [r0, r3]	@ <retval>,
@ C_Code.c:303: 	if (!keys) { 
	cmp	r0, #0	@ <retval>,
	bne	.L32		@,
@ C_Code.c:304: 		u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
	ldr	r3, .L54+8	@ tmp151,
	ldr	r1, [r3]	@ tmp154,
	str	r1, [sp]	@ tmp154,
	mov	r1, sp	@ tmp184,
	ldrh	r3, [r3, #4]	@ tmp156,
	strh	r3, [r1, #4]	@ tmp156,
@ C_Code.c:309: 		int numberOfRandomButtons = NumberOfRandomButtons; 
	ldr	r3, .L54+12	@ tmp158,
	ldr	r3, [r3]	@ numberOfRandomButtons, NumberOfRandomButtons
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:310: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	cmp	r3, #0	@ numberOfRandomButtons,
	beq	.L51		@,
@ C_Code.c:312: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	ble	.L44		@,
.L35:
	ldr	r3, .L54+16	@ tmp177,
@ C_Code.c:312: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	movs	r6, #0	@ i,
@ C_Code.c:307: 		int oppDir = 0; 
	movs	r7, #0	@ oppDir,
@ C_Code.c:302: 	int keys = proc->buttonsToPress;
	movs	r5, #0	@ keys,
@ C_Code.c:308: 		int size = 5; // -1 since we count from 0  
	movs	r4, #5	@ size,
	mov	r10, r3	@ tmp177, tmp177
	b	.L41		@
.L37:
@ C_Code.c:312: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r6, r6, #1	@ i,
@ C_Code.c:332: 			keys |= button; 
	orrs	r5, r0	@ keys, button
@ C_Code.c:312: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r9, r6	@ numberOfRandomButtons, i
	ble	.L52		@,
.L41:
@ C_Code.c:313: 			num = NextRN_N(size); 
	movs	r0, r4	@, size
	bl	.L56		@
@ C_Code.c:314: 			button = KeysList[num];
	mov	r3, sp	@ tmp191,
	ldrb	r0, [r3, r0]	@ button, KeysList
@ C_Code.c:317: 			if (button & 0xF0) { // some dpad 
	cmp	r0, #15	@ button,
	bls	.L37		@,
@ C_Code.c:318: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	cmp	r0, #16	@ button,
	beq	.L45		@,
@ C_Code.c:319: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	cmp	r0, #32	@ button,
	beq	.L46		@,
@ C_Code.c:320: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	cmp	r0, #64	@ button,
	bne	.L53		@,
@ C_Code.c:320: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	movs	r7, #128	@ oppDir,
.L38:
@ C_Code.c:322: 				for (int c = 0; c <= size; ++c) { 
	cmp	r4, #0	@ size,
	blt	.L37		@,
	mov	r2, sp	@ ivtmp.82,
@ C_Code.c:322: 				for (int c = 0; c <= size; ++c) { 
	movs	r3, #0	@ c,
	b	.L40		@
.L39:
@ C_Code.c:322: 				for (int c = 0; c <= size; ++c) { 
	adds	r3, r3, #1	@ c,
@ C_Code.c:322: 				for (int c = 0; c <= size; ++c) { 
	adds	r2, r2, #1	@ ivtmp.82,
	cmp	r3, r4	@ c, size
	bgt	.L37		@,
.L40:
@ C_Code.c:323: 					if (KeysList[c] == oppDir) { 
	ldrb	r1, [r2]	@ MEM[(unsigned char *)_45], MEM[(unsigned char *)_45]
@ C_Code.c:323: 					if (KeysList[c] == oppDir) { 
	cmp	r1, r7	@ MEM[(unsigned char *)_45], oppDir
	bne	.L39		@,
@ C_Code.c:324: 						KeysList[c] = KeysList[size]; 
	mov	r2, sp	@ tmp192,
@ C_Code.c:324: 						KeysList[c] = KeysList[size]; 
	mov	r1, sp	@ tmp193,
@ C_Code.c:324: 						KeysList[c] = KeysList[size]; 
	ldrb	r2, [r2, r4]	@ _10, KeysList
@ C_Code.c:312: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r6, r6, #1	@ i,
@ C_Code.c:324: 						KeysList[c] = KeysList[size]; 
	strb	r2, [r1, r3]	@ _10, KeysList[c_53]
@ C_Code.c:325: 						size--; 
	subs	r4, r4, #1	@ size,
@ C_Code.c:332: 			keys |= button; 
	orrs	r5, r0	@ keys, button
@ C_Code.c:312: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r9, r6	@ numberOfRandomButtons, i
	bgt	.L41		@,
.L52:
@ C_Code.c:334: 		proc->buttonsToPress = keys; 
	movs	r0, r5	@ <retval>, keys
	lsls	r3, r5, #16	@ tmp173, keys,
	lsrs	r3, r3, #16	@ prephitmp_15, tmp173,
.L36:
	movs	r2, #84	@ tmp174,
	mov	r1, r8	@ proc, proc
	strh	r3, [r1, r2]	@ prephitmp_15, proc_29(D)->buttonsToPress
	b	.L32		@
.L43:
@ C_Code.c:301: 	if (AlwaysA || TimedHitsDifficultyRam->alwaysA) { return A_BUTTON; } 
	movs	r0, #1	@ <retval>,
.L32:
@ C_Code.c:337: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L51:
@ C_Code.c:310: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.8_2, *TimedHitsDifficultyRam.8_2
	lsls	r3, r3, #27	@ tmp163, *TimedHitsDifficultyRam.8_2,
@ C_Code.c:310: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	lsrs	r2, r3, #27	@ numberOfRandomButtons, tmp163,
	mov	r9, r2	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:311: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	cmp	r3, #0	@ tmp163,
	bne	.L35		@,
@ C_Code.c:311: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	adds	r3, r3, #1	@ numberOfRandomButtons,
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
	b	.L35		@
.L45:
@ C_Code.c:318: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	movs	r7, #32	@ oppDir,
	b	.L38		@
.L46:
@ C_Code.c:319: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	movs	r7, #16	@ oppDir,
	b	.L38		@
.L53:
@ C_Code.c:321: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	cmp	r0, #128	@ button,
	bne	.L38		@,
@ C_Code.c:321: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	movs	r7, #64	@ oppDir,
	b	.L38		@
.L44:
@ C_Code.c:312: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	movs	r3, #0	@ prephitmp_15,
	b	.L36		@
.L55:
	.align	2
.L54:
	.word	AlwaysA
	.word	TimedHitsDifficultyRam
	.word	.LC24
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
@ C_Code.c:393: void DrawButtonsToPress(TimedHitsProc* proc, int x, int y, int palID) { 
	mov	fp, r2	@ y, tmp237
	movs	r7, r0	@ proc, tmp235
	mov	r9, r1	@ x, tmp236
	movs	r6, r3	@ palID, tmp238
@ C_Code.c:395: 	int keys = GetButtonsToPress(proc); 
	bl	GetButtonsToPress		@
@ C_Code.c:397: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r2, .L113	@ tmp153,
@ C_Code.c:397: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r2, [r2]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
@ C_Code.c:395: 	int keys = GetButtonsToPress(proc); 
	movs	r5, r0	@ keys, tmp239
@ C_Code.c:397: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	cmp	r2, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L60		@,
@ C_Code.c:397: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	movs	r3, #78	@ tmp157,
@ C_Code.c:397: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldrb	r3, [r7, r3]	@ tmp158,
	cmp	r3, #0	@ tmp158,
	bne	.L104		@,
.L60:
@ C_Code.c:399: 	int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); //OAM2_CHR(0);
	lsls	r6, r6, #28	@ tmp156, palID,
	lsrs	r6, r6, #16	@ _26, tmp156,
.L59:
@ C_Code.c:400: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	r2, fp	@ y, y
	movs	r3, #255	@ tmp159,
	ldr	r7, .L113+4	@ tmp230,
	ands	r3, r2	@ tmp159, y
	mov	r2, r9	@ x, x
	mov	r8, r3	@ _11, tmp159
	movs	r3, r7	@ tmp161, tmp230
	lsls	r1, r2, #23	@ tmp163, x,
	ldr	r4, .L113+8	@ tmp229,
	mov	r2, r8	@, _11
	movs	r0, #2	@,
	adds	r3, r3, #32	@ tmp161,
	lsrs	r1, r1, #23	@ tmp162, tmp163,
	str	r6, [sp]	@ _26,
	bl	.L115		@
@ C_Code.c:401: 	x += 32; 
	mov	r1, r9	@ x, x
@ C_Code.c:402: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	movs	r3, r7	@ tmp166, tmp230
@ C_Code.c:401: 	x += 32; 
	adds	r1, r1, #32	@ x,
@ C_Code.c:402: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	lsls	r1, r1, #23	@ tmp169, x,
	mov	r2, r8	@, _11
	movs	r0, #2	@,
	adds	r3, r3, #40	@ tmp166,
	str	r6, [sp]	@ _26,
	lsrs	r1, r1, #23	@ tmp168, tmp169,
	bl	.L115		@
@ C_Code.c:403: 	y += 16; x -= 36; 
	movs	r3, #16	@ y,
	mov	r8, r3	@ y, y
@ C_Code.c:400: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	r10, r4	@ tmp229, tmp229
@ C_Code.c:405: 	int count = CountKeysPressed(keys); 
	movs	r2, #5	@ ivtmp_28,
	movs	r4, #1	@ pretmp_81,
@ C_Code.c:341: 	int c = 0; 
	movs	r3, #0	@ c,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r0, #48	@ tmp234,
@ C_Code.c:403: 	y += 16; x -= 36; 
	add	r8, r8, fp	@ y, y
	b	.L63		@
.L105:
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r7, r3	@ tmp174, tmp230, c
	ldrb	r4, [r1, r0]	@ pretmp_81, RomKeysList
.L63:
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r4, r5	@ tmp171, keys
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r1, r4, #1	@ tmp233, tmp171
	sbcs	r4, r4, r1	@ tmp232, tmp171, tmp233
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	subs	r2, r2, #1	@ ivtmp_28,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r3, r3, r4	@ c, c, tmp232
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	cmp	r2, #0	@ ivtmp_28,
	bne	.L105		@,
@ C_Code.c:406: 	if (count == 1) { x += 24; } // centering 
	cmp	r3, #1	@ c,
	beq	.L106		@,
@ C_Code.c:407: 	if (count == 2) { x += 16; } 
	cmp	r3, #2	@ c,
	bne	.L66		@,
@ C_Code.c:407: 	if (count == 2) { x += 16; } 
	mov	r4, r9	@ x, x
	adds	r4, r4, #12	@ x,
.L65:
@ C_Code.c:410: 	if (keys & A_BUTTON) { 
	lsls	r3, r5, #31	@ tmp241, keys,
	bmi	.L107		@,
.L68:
@ C_Code.c:413: 	if (keys & B_BUTTON) { 
	lsls	r3, r5, #30	@ tmp242, keys,
	bmi	.L108		@,
.L69:
@ C_Code.c:416: 	if (keys & DPAD_LEFT) { 
	lsls	r3, r5, #26	@ tmp243, keys,
	bmi	.L109		@,
.L70:
@ C_Code.c:419: 	if (keys & DPAD_RIGHT) { 
	lsls	r3, r5, #27	@ tmp244, keys,
	bmi	.L110		@,
.L71:
@ C_Code.c:422: 	if (keys & DPAD_UP) { 
	lsls	r3, r5, #25	@ tmp245, keys,
	bmi	.L111		@,
.L72:
@ C_Code.c:425: 	if (keys & DPAD_DOWN) { 
	lsls	r5, r5, #24	@ tmp246, keys,
	bmi	.L112		@,
.L57:
@ C_Code.c:432: } 
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
.L104:
	movs	r6, #224	@ _26,
	lsls	r6, r6, #8	@ _26, _26,
	b	.L59		@
.L66:
@ C_Code.c:408: 	if (count == 3) { x += 8; } 
	mov	r2, r9	@ x, x
	adds	r4, r2, #4	@ x, x,
@ C_Code.c:408: 	if (count == 3) { x += 8; } 
	cmp	r3, #3	@ c,
	beq	.L65		@,
@ C_Code.c:403: 	y += 16; x -= 36; 
	subs	r4, r4, #8	@ x,
	b	.L65		@
.L106:
@ C_Code.c:406: 	if (count == 1) { x += 24; } // centering 
	mov	r4, r9	@ x, x
	adds	r4, r4, #20	@ x,
@ C_Code.c:410: 	if (keys & A_BUTTON) { 
	lsls	r3, r5, #31	@ tmp241, keys,
	bpl	.L68		@,
.L107:
@ C_Code.c:411: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp179,
	movs	r3, r7	@ tmp178, tmp230
	ands	r2, r1	@ tmp180, y
	lsls	r1, r4, #23	@ tmp182, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #56	@ tmp178,
	lsrs	r1, r1, #23	@ tmp181, tmp182,
	bl	.L56		@
@ C_Code.c:411: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:413: 	if (keys & B_BUTTON) { 
	lsls	r3, r5, #30	@ tmp242, keys,
	bpl	.L69		@,
.L108:
@ C_Code.c:414: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp188,
	movs	r3, r7	@ tmp187, tmp230
	ands	r2, r1	@ tmp189, y
	lsls	r1, r4, #23	@ tmp191, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #64	@ tmp187,
	lsrs	r1, r1, #23	@ tmp190, tmp191,
	bl	.L56		@
@ C_Code.c:414: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:416: 	if (keys & DPAD_LEFT) { 
	lsls	r3, r5, #26	@ tmp243, keys,
	bpl	.L70		@,
.L109:
@ C_Code.c:417: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp197,
	movs	r3, r7	@ tmp196, tmp230
	ands	r2, r1	@ tmp198, y
	lsls	r1, r4, #23	@ tmp200, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #72	@ tmp196,
	lsrs	r1, r1, #23	@ tmp199, tmp200,
	bl	.L56		@
@ C_Code.c:417: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:419: 	if (keys & DPAD_RIGHT) { 
	lsls	r3, r5, #27	@ tmp244, keys,
	bpl	.L71		@,
.L110:
@ C_Code.c:420: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp206,
	movs	r3, r7	@ tmp205, tmp230
	ands	r2, r1	@ tmp207, y
	lsls	r1, r4, #23	@ tmp209, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #80	@ tmp205,
	lsrs	r1, r1, #23	@ tmp208, tmp209,
	bl	.L56		@
@ C_Code.c:420: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:422: 	if (keys & DPAD_UP) { 
	lsls	r3, r5, #25	@ tmp245, keys,
	bpl	.L72		@,
.L111:
@ C_Code.c:423: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp215,
	movs	r3, r7	@ tmp214, tmp230
	ands	r2, r1	@ tmp216, y
	lsls	r1, r4, #23	@ tmp218, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #88	@ tmp214,
	lsrs	r1, r1, #23	@ tmp217, tmp218,
	bl	.L56		@
@ C_Code.c:423: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:425: 	if (keys & DPAD_DOWN) { 
	lsls	r5, r5, #24	@ tmp246, keys,
	bpl	.L57		@,
.L112:
@ C_Code.c:426: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2); x += 18; 
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp224,
	movs	r3, r7	@ tmp230, tmp230
	ands	r2, r1	@ tmp225, y
	lsls	r1, r4, #23	@ tmp227, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _26,
	adds	r3, r3, #96	@ tmp230,
	lsrs	r1, r1, #23	@ tmp226, tmp227,
	bl	.L56		@
	b	.L57		@
.L114:
	.align	2
.L113:
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
@ C_Code.c:340: int CountKeysPressed(u32 keys) { 
	movs	r1, r0	@ keys, tmp130
	movs	r2, #5	@ ivtmp_1,
	movs	r3, #1	@ pretmp_5,
@ C_Code.c:341: 	int c = 0; 
	movs	r0, #0	@ <retval>,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r4, #48	@ tmp129,
	ldr	r5, .L123	@ tmp128,
	b	.L119		@
.L122:
	adds	r3, r5, r0	@ tmp123, tmp128, <retval>
	ldrb	r3, [r3, r4]	@ pretmp_5, RomKeysList
.L119:
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r1	@ tmp120, keys
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp127, tmp120
	sbcs	r3, r3, r6	@ tmp126, tmp120, tmp127
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	subs	r2, r2, #1	@ ivtmp_1,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r0, r0, r3	@ <retval>, <retval>, tmp126
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	cmp	r2, #0	@ ivtmp_1,
	bne	.L122		@,
@ C_Code.c:347: } 
	@ sp needed	@
	pop	{r4, r5, r6}
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
@ C_Code.c:349: int PressedSpecificKeys(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r1	@ keys, tmp183
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r5, #48	@ tmp181,
@ C_Code.c:350: 	int reqKeys = GetButtonsToPress(proc); 
	bl	GetButtonsToPress		@
@ C_Code.c:351: 	int count = CountKeysPressed(reqKeys); 
	movs	r1, #5	@ ivtmp_22,
	movs	r3, #1	@ pretmp_26,
@ C_Code.c:341: 	int c = 0; 
	movs	r2, #0	@ c,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r6, .L155	@ tmp180,
	b	.L128		@
.L151:
	adds	r3, r6, r2	@ tmp146, tmp180, c
	ldrb	r3, [r3, r5]	@ pretmp_26, RomKeysList
.L128:
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r0	@ tmp143, reqKeys
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r7, r3, #1	@ tmp164, tmp143
	sbcs	r3, r3, r7	@ tmp163, tmp143, tmp164
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	subs	r1, r1, #1	@ ivtmp_22,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r2, r2, r3	@ c, c, tmp163
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	cmp	r1, #0	@ ivtmp_22,
	bne	.L151		@,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r6, .L155	@ tmp178,
	movs	r5, #5	@ ivtmp_35,
	movs	r3, #1	@ prephitmp_52,
@ C_Code.c:341: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	mov	ip, r6	@ tmp178, tmp178
	movs	r7, #48	@ tmp179,
	b	.L127		@
.L152:
	mov	r3, ip	@ tmp178, tmp178
	adds	r3, r3, r1	@ tmp150, tmp178, c
	ldrb	r3, [r3, r7]	@ prephitmp_52, RomKeysList
.L127:
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp147, keys
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp167, tmp147
	sbcs	r3, r3, r6	@ tmp166, tmp147, tmp167
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	subs	r5, r5, #1	@ ivtmp_35,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp166
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	cmp	r5, #0	@ ivtmp_35,
	bne	.L152		@,
	movs	r5, #5	@ ivtmp_57,
	movs	r3, #1	@ prephitmp_5,
@ C_Code.c:352: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r2, r1	@ c, c
	blt	.L140		@,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r6, #48	@ tmp175,
@ C_Code.c:341: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	mov	ip, r6	@ tmp175, tmp175
	ldr	r7, .L155	@ tmp174,
	b	.L134		@
.L153:
	mov	r6, ip	@ tmp175, tmp175
	adds	r3, r7, r1	@ tmp154, tmp174, c
	ldrb	r3, [r3, r6]	@ prephitmp_5, RomKeysList
.L134:
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp151, keys
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp170, tmp151
	sbcs	r3, r3, r6	@ tmp169, tmp151, tmp170
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	subs	r5, r5, #1	@ ivtmp_57,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp169
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	cmp	r5, #0	@ ivtmp_57,
	bne	.L153		@,
@ C_Code.c:352: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r2, r1	@ tmp155, c, c
@ C_Code.c:352: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp155,
	bgt	.L142		@,
.L136:
@ C_Code.c:353: 	return (keys & reqKeys); 
	ands	r0, r4	@ <retval>, keys
.L125:
@ C_Code.c:354: } 
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L140:
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	movs	r6, #48	@ tmp177,
@ C_Code.c:341: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	mov	ip, r6	@ tmp177, tmp177
	ldr	r7, .L155	@ tmp176,
	b	.L131		@
.L154:
	mov	r6, ip	@ tmp177, tmp177
	adds	r3, r7, r1	@ tmp159, tmp176, c
	ldrb	r3, [r3, r6]	@ prephitmp_13, RomKeysList
.L131:
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp156, keys
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp173, tmp156
	sbcs	r3, r3, r6	@ tmp172, tmp156, tmp173
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	subs	r5, r5, #1	@ ivtmp_43,
@ C_Code.c:343: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp172
@ C_Code.c:342: 	for (int i = 0; i < 5; ++i) { 
	cmp	r5, #0	@ ivtmp_43,
	bne	.L154		@,
@ C_Code.c:352: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r1, r2	@ tmp160, c, c
@ C_Code.c:352: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp160,
	ble	.L136		@,
.L142:
@ C_Code.c:352: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	movs	r0, #0	@ <retval>,
	b	.L125		@
.L156:
	.align	2
.L155:
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
@ C_Code.c:356: 	struct Anim* anim = proc->anim; 
	ldr	r5, [r0, #44]	@ anim, proc_17(D)->anim
@ C_Code.c:357: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:357: 	u32 instruction = *anim->pScrCurrent++; 
	adds	r3, r6, #4	@ tmp130, _1,
	str	r3, [r5, #32]	@ tmp130, anim_18->pScrCurrent
@ C_Code.c:358: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	movs	r3, #252	@ tmp132,
@ C_Code.c:355: void SaveInputFrame(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r0	@ proc, tmp151
@ C_Code.c:358: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	movs	r0, #160	@ tmp133,
@ C_Code.c:357: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r2, [r6]	@ instruction, *_1
@ C_Code.c:358: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	lsls	r3, r3, #22	@ tmp132, tmp132,
	ands	r3, r2	@ tmp131, instruction
	lsls	r0, r0, #19	@ tmp133, tmp133,
	cmp	r3, r0	@ tmp131, tmp133
	beq	.L164		@,
.L158:
@ C_Code.c:367: 	if (PressedSpecificKeys(proc, keys)) { 
	movs	r0, r4	@, proc
@ C_Code.c:366: 	instruction = *anim->pScrCurrent--; 
	str	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:367: 	if (PressedSpecificKeys(proc, keys)) { 
	bl	PressedSpecificKeys		@
@ C_Code.c:367: 	if (PressedSpecificKeys(proc, keys)) { 
	cmp	r0, #0	@ tmp153,
	beq	.L157		@,
@ C_Code.c:368: 		if (!proc->frame) { 
	movs	r3, #78	@ tmp143,
@ C_Code.c:368: 		if (!proc->frame) { 
	ldrb	r2, [r4, r3]	@ tmp144,
	cmp	r2, #0	@ tmp144,
	beq	.L165		@,
.L157:
@ C_Code.c:373: }  
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L164:
@ C_Code.c:359: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	movs	r3, #255	@ tmp134,
	ands	r3, r2	@ _4, instruction
@ C_Code.c:359: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	cmp	r3, #4	@ _4,
	beq	.L166		@,
@ C_Code.c:362: 		if (ANINS_COMMAND_GET_ID(instruction) == 0xF) {
	cmp	r3, #15	@ _4,
	bne	.L158		@,
@ C_Code.c:363: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #65	@ tmp141,
	strb	r2, [r4, r3]	@ proc_17(D)->timer,
@ C_Code.c:363: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	movs	r3, #0	@ tmp142,
	str	r3, [r4, #56]	@ tmp142, proc_17(D)->timer2
	b	.L158		@
.L165:
@ C_Code.c:370: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	movs	r1, #128	@,
	movs	r0, #159	@,
@ C_Code.c:369: 			proc->frame = proc->timer; // locate is side for stereo? 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
@ C_Code.c:370: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r1, r1, #1	@,,
@ C_Code.c:369: 			proc->frame = proc->timer; // locate is side for stereo? 
	strb	r2, [r4, r3]	@ proc_17(D)->timer, proc_17(D)->frame
@ C_Code.c:370: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r0, r0, #1	@,,
	movs	r2, #120	@,
	ldr	r4, .L167	@ tmp150,
	subs	r3, r3, #77	@,
	bl	.L115		@
@ C_Code.c:373: }  
	b	.L157		@
.L166:
@ C_Code.c:360: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #75	@ tmp137,
	strb	r2, [r4, r3]	@ proc_17(D)->timer,
@ C_Code.c:360: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	movs	r3, #0	@ tmp138,
	str	r3, [r4, #56]	@ tmp138, proc_17(D)->timer2
	b	.L158		@
.L168:
	.align	2
.L167:
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
@ C_Code.c:375: 	if (proc->frame) { 
	movs	r3, #78	@ tmp128,
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:374: void SaveIfWeHitOnTime(TimedHitsProc* proc) {
	push	{r4, lr}	@
@ C_Code.c:375: 	if (proc->frame) { 
	cmp	r3, #0	@ _1,
	beq	.L169		@,
@ C_Code.c:376: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #80	@ tmp129,
@ C_Code.c:376: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, .L180	@ tmp130,
@ C_Code.c:376: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldrb	r2, [r0, r2]	@ _2,
@ C_Code.c:376: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, [r1]	@ pretmp_33, LenienceFrames
@ C_Code.c:376: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, #255	@ _2,
	beq	.L172		@,
.L179:
@ C_Code.c:376: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	subs	r2, r2, r3	@ tmp131, _2, _1
	asrs	r4, r2, #31	@ tmp147, tmp131,
	adds	r2, r2, r4	@ tmp132, tmp131, tmp147
	eors	r2, r4	@ tmp132, tmp147
@ C_Code.c:376: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, r1	@ tmp132, pretmp_33
	bge	.L173		@,
@ C_Code.c:376: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #72	@ tmp133,
	movs	r4, #1	@ tmp134,
	strb	r4, [r0, r2]	@ tmp134, proc_21(D)->hitOnTime
.L173:
@ C_Code.c:378: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	ldr	r2, [r0, #52]	@ proc_21(D)->timer, proc_21(D)->timer
	subs	r3, r2, r3	@ tmp139, proc_21(D)->timer, _1
@ C_Code.c:378: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	cmp	r3, r1	@ tmp139, pretmp_33
	bge	.L169		@,
@ C_Code.c:378: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	movs	r3, #72	@ tmp141,
	movs	r2, #1	@ tmp142,
	strb	r2, [r0, r3]	@ tmp142, proc_21(D)->hitOnTime
.L169:
@ C_Code.c:381: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L172:
@ C_Code.c:377: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	movs	r2, #79	@ tmp136,
	ldrb	r2, [r0, r2]	@ _8,
@ C_Code.c:377: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	cmp	r2, #255	@ _8,
	bne	.L179		@,
	b	.L173		@
.L181:
	.align	2
.L180:
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
@ C_Code.c:384: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L183	@ tmp118,
@ C_Code.c:385: } 
	@ sp needed	@
@ C_Code.c:384: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldrb	r0, [r3, #31]	@ tmp120,
	movs	r3, #127	@ tmp122,
	bics	r0, r3	@ tmp117, tmp122
@ C_Code.c:385: } 
	bx	lr
.L184:
	.align	2
.L183:
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
@ C_Code.c:384: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L189	@ tmp120,
@ C_Code.c:388: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp123,
	cmp	r3, #127	@ tmp123,
	bhi	.L188		@,
@ C_Code.c:389: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L189+4	@ tmp124,
@ C_Code.c:389: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L188		@,
@ C_Code.c:390: 	return proc->hitOnTime;
	adds	r3, r3, #72	@ tmp126,
	ldrb	r0, [r0, r3]	@ <retval>,
	b	.L185		@
.L188:
@ C_Code.c:388: 	if (CheatCodeOn()) { return true; } 
	movs	r0, #1	@ <retval>,
.L185:
@ C_Code.c:391: }
	@ sp needed	@
	bx	lr
.L190:
	.align	2
.L189:
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
@ C_Code.c:394: 	if (!DisplayPress) { return; } 
	ldr	r4, .L196	@ tmp119,
@ C_Code.c:394: 	if (!DisplayPress) { return; } 
	ldr	r4, [r4]	@ DisplayPress, DisplayPress
	cmp	r4, #0	@ DisplayPress,
	beq	.L191		@,
	bl	DrawButtonsToPress.part.0		@
.L191:
@ C_Code.c:432: } 
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L197:
	.align	2
.L196:
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
@ C_Code.c:517: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp122,
	movs	r3, #192	@ tmp123,
	ldrsb	r1, [r0, r1]	@ tmp122,
	ands	r3, r1	@ _14, tmp122
@ C_Code.c:516: 	if (success) { 
	cmp	r2, #0	@ tmp131,
	beq	.L199		@,
@ C_Code.c:517: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _14,
	bne	.L200		@,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L204	@ tmp124,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L203		@,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L204+4	@ tmp126,
	ldr	r0, [r3]	@ <retval>,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L198		@
.L199:
@ C_Code.c:523: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _14,
	beq	.L203		@,
@ C_Code.c:526: 	return FailedHitDamagePercent; 
	ldr	r3, .L204+8	@ tmp128,
	ldr	r0, [r3]	@ <retval>,
.L198:
@ C_Code.c:527: } 
	@ sp needed	@
	bx	lr
.L200:
@ C_Code.c:521: 		return BonusDamagePercent; 
	ldr	r3, .L204+12	@ tmp127,
	ldr	r0, [r3]	@ <retval>,
	b	.L198		@
.L203:
@ C_Code.c:519: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
	b	.L198		@
.L205:
	.align	2
.L204:
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
@ C_Code.c:517: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp122,
	movs	r3, #192	@ tmp123,
	ldrsb	r1, [r0, r1]	@ tmp122,
	ands	r3, r1	@ _9, tmp122
@ C_Code.c:516: 	if (success) { 
	cmp	r2, #0	@ tmp131,
	beq	.L207		@,
@ C_Code.c:517: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _9,
	bne	.L208		@,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L212	@ tmp124,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L211		@,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L212+4	@ tmp126,
	ldr	r0, [r3]	@ <retval>,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L206		@
.L207:
@ C_Code.c:523: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _9,
	beq	.L211		@,
@ C_Code.c:526: 	return FailedHitDamagePercent; 
	ldr	r3, .L212+8	@ tmp128,
	ldr	r0, [r3]	@ <retval>,
.L206:
@ C_Code.c:531: } 
	@ sp needed	@
	bx	lr
.L208:
@ C_Code.c:521: 		return BonusDamagePercent; 
	ldr	r3, .L212+12	@ tmp127,
	ldr	r0, [r3]	@ <retval>,
	b	.L206		@
.L211:
@ C_Code.c:519: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
@ C_Code.c:530: 	return GetDefaultDamagePercent(active_bunit, opp_bunit, success); 
	b	.L206		@
.L213:
	.align	2
.L212:
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
@ C_Code.c:544: 	for (int i = id; i < 22; i += 2) {
	cmp	r0, #21	@ id,
	bgt	.L214		@,
	ldr	r3, .L224	@ tmp128,
	lsls	r2, r0, #1	@ tmp127, id,
@ C_Code.c:546: 		if (hp == 0xffff) { break; }
	ldr	r5, .L224+4	@ tmp129,
	adds	r2, r2, r3	@ ivtmp.178, tmp127, tmp128
	b	.L218		@
.L216:
	movs	r4, #0	@ _4,
@ C_Code.c:548: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	cmp	r3, r1	@ _1, difference
	blt	.L217		@,
@ C_Code.c:548: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	subs	r3, r3, r1	@ tmp132, _1, difference
.L222:
	lsls	r3, r3, #16	@ tmp133, tmp132,
	lsrs	r4, r3, #16	@ _4, tmp133,
.L217:
@ C_Code.c:544: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:547: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:544: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.178,
	cmp	r0, #21	@ id,
	bgt	.L214		@,
.L218:
@ C_Code.c:545: 		hp = gEfxHpLut[i]; 
	ldrh	r3, [r2]	@ _1, MEM[(short unsigned int *)_18]
@ C_Code.c:546: 		if (hp == 0xffff) { break; }
	cmp	r3, r5	@ _1, tmp129
	beq	.L214		@,
@ C_Code.c:547: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r1, #0	@ difference,
	bge	.L216		@,
@ C_Code.c:547: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	adds	r3, r3, r1	@ hp, _1, difference
	movs	r4, #0	@ _4,
@ C_Code.c:547: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r3, #0	@ hp,
	bgt	.L222		@,
@ C_Code.c:544: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:547: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:544: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.178,
	cmp	r0, #21	@ id,
	ble	.L218		@,
.L214:
@ C_Code.c:552: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L225:
	.align	2
.L224:
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
	ldr	r4, .L234	@ tmp135,
	lsls	r5, r5, #1	@ tmp136, tmp168,
	ldrsh	r4, [r5, r4]	@ _1, gEkrGaugeHp
@ C_Code.c:559: 	some_bunit->unit.curHP = newHp; 
	strb	r3, [r2, #19]	@ _14, some_bunit_22(D)->unit.curHP
@ C_Code.c:560: 	if (hp == newHp) { return; } 
	cmp	r3, r4	@ _14, _1
	beq	.L226		@,
@ C_Code.c:563: 	if (proc->side == side) { 
	movs	r2, #77	@ tmp138,
@ C_Code.c:563: 	if (proc->side == side) { 
	ldr	r5, [sp, #20]	@ tmp169, side
@ C_Code.c:563: 	if (proc->side == side) { 
	ldrb	r2, [r0, r2]	@ tmp139,
@ C_Code.c:563: 	if (proc->side == side) { 
	cmp	r2, r5	@ tmp139, tmp169
	beq	.L233		@,
.L226:
@ C_Code.c:578: }
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L233:
@ C_Code.c:564: 		if (UsingSkillSys) { // uggggh 
	ldr	r2, .L234+4	@ tmp140,
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
	beq	.L231		@,
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
	bne	.L226		@,
@ C_Code.c:576: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	strh	r7, [r0, #6]	@ diff, pretmp_16->overDmg
	b	.L226		@
.L231:
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
	b	.L226		@
.L235:
	.align	2
.L234:
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
	mov	r7, r10	@,
	mov	r6, r9	@,
	mov	lr, fp	@,
	mov	r5, r8	@,
	push	{r5, r6, r7, lr}	@
	sub	sp, sp, #12	@,,
@ C_Code.c:580: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	movs	r6, r3	@ opp_bunit, tmp193
@ C_Code.c:582: 	if (hp < 0) { return; hp = gEkrGaugeHp[side]; } 
	ldr	r3, [sp, #52]	@ tmp198, hp
@ C_Code.c:580: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	movs	r4, r0	@ proc, tmp191
	movs	r7, r1	@ HpProc, tmp192
@ C_Code.c:582: 	if (hp < 0) { return; hp = gEkrGaugeHp[side]; } 
	cmp	r3, #0	@ tmp198,
	blt	.L236		@,
@ C_Code.c:581: 	int side = proc->side; 
	movs	r3, #77	@ tmp139,
	ldrb	r5, [r0, r3]	@ _1,
@ C_Code.c:583: 	if (hp <= 0) { // they are dead 
	ldr	r3, [sp, #52]	@ tmp199, hp
	cmp	r3, #0	@ tmp199,
	bne	.L238		@,
@ C_Code.c:558: 	int hp = gEkrGaugeHp[side];
	ldr	r3, .L244	@ tmp189,
	mov	r8, r3	@ tmp189, tmp189
	mov	r2, r8	@ tmp189, tmp189
	lsls	r3, r5, #1	@ tmp141, _1,
	ldrsh	r3, [r2, r3]	@ _30, gEkrGaugeHp
@ C_Code.c:559: 	some_bunit->unit.curHP = newHp; 
	ldr	r2, [sp, #52]	@ tmp202, hp
	strb	r2, [r6, #19]	@ tmp203, opp_bunit_15(D)->unit.curHP
@ C_Code.c:560: 	if (hp == newHp) { return; } 
	cmp	r3, #0	@ _30,
	beq	.L240		@,
@ C_Code.c:561: 	int diff = newHp - hp; 
	rsbs	r2, r3, #0	@ diff, _30
	mov	ip, r2	@ diff, diff
@ C_Code.c:564: 		if (UsingSkillSys) { // uggggh 
	ldr	r2, .L244+4	@ tmp144,
	ldr	r1, [r2]	@ UsingSkillSys.23_36, UsingSkillSys
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	mov	r2, ip	@ diff, diff
	lsls	r2, r2, #24	@ tmp145, diff,
	asrs	r2, r2, #24	@ _46, tmp145,
	mov	fp, r2	@ _46, _46
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	ldr	r0, [r0, #60]	@ pretmp_38, proc_9(D)->currentRound
@ C_Code.c:564: 		if (UsingSkillSys) { // uggggh 
	cmp	r1, #0	@ UsingSkillSys.23_36,
	beq	.L241		@,
@ C_Code.c:565: 			HpProc->cur = hp; 
	strh	r3, [r7, #46]	@ _30, HpProc_14(D)->cur
@ C_Code.c:566: 			HpProc->post = newHp;
	movs	r3, #80	@ tmp147,
	mov	r10, r3	@ tmp147, tmp147
	mov	r2, r10	@ tmp147, tmp147
	ldr	r3, [sp, #52]	@ tmp206, hp
	strh	r3, [r7, r2]	@ tmp207, HpProc_14(D)->post
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	mov	r3, fp	@ _46, _46
	strb	r3, [r0, #3]	@ _46, pretmp_38->hpChange
@ C_Code.c:576: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	cmp	r1, #2	@ UsingSkillSys.23_36,
	bne	.L240		@,
@ C_Code.c:576: 		if (UsingSkillSys == 2) { proc->currentRound->overDmg = diff; } // used by Huichelaar's banim numbers 
	mov	r3, ip	@ diff, diff
	strh	r3, [r0, #6]	@ diff, pretmp_38->overDmg
.L240:
@ C_Code.c:587: 		proc->code4frame = 0xff;
	movs	r3, #79	@ tmp157,
	movs	r2, #255	@ tmp158,
	strb	r2, [r4, r3]	@ tmp158, proc_9(D)->code4frame
@ C_Code.c:591: 		HpProc->death = true; 
	subs	r3, r3, #78	@ tmp161,
	subs	r2, r2, #214	@ tmp160,
	strb	r3, [r7, r2]	@ tmp161, HpProc_14(D)->death
@ C_Code.c:596: 		proc->anim->nextRoundId = 8; // seems to mostly work for now? see GetAnimNextRoundType
	ldr	r1, [r4, #44]	@ proc_9(D)->anim, proc_9(D)->anim
	subs	r2, r2, #33	@ tmp164,
	strh	r2, [r1, #14]	@ tmp164, _3->nextRoundId
@ C_Code.c:597: 		proc->anim2->nextRoundId = 8; 
	ldr	r1, [r4, #48]	@ proc_9(D)->anim2, proc_9(D)->anim2
	strh	r2, [r1, #14]	@ tmp164, _4->nextRoundId
@ C_Code.c:599: 		gBanimDoneFlag[0] = true; // stop counterattacks ?
	ldr	r2, .L244+8	@ tmp169,
	str	r3, [r2]	@ tmp161, gBanimDoneFlag[0]
@ C_Code.c:600: 		gBanimDoneFlag[1] = true; // [201fb04..201fb07]!! - nothing else is writing to it. good. 
	str	r3, [r2, #4]	@ tmp161, gBanimDoneFlag[1]
@ C_Code.c:602: 		round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END; 
	movs	r2, #176	@ tmp173,
	ldr	r3, [sp, #48]	@ tmp209, round
	ldrb	r3, [r3, #2]	@ tmp176,
	orrs	r3, r2	@ tmp178, tmp173
	ldr	r2, [sp, #48]	@ tmp210, round
	strb	r3, [r2, #2]	@ tmp178,
@ C_Code.c:604: 		BattleApplyExpGains();  // update exp 
	ldr	r3, .L244+12	@ tmp180,
	bl	.L8		@
@ C_Code.c:612: 		side = 1 ^ side; 
	movs	r3, #1	@ tmp184,
@ C_Code.c:613: 		hp = gEkrGaugeHp[side];
	mov	r2, r8	@ tmp189, tmp189
@ C_Code.c:612: 		side = 1 ^ side; 
	eors	r5, r3	@ side, tmp184
@ C_Code.c:613: 		hp = gEkrGaugeHp[side];
	lsls	r3, r5, #1	@ tmp186, side,
@ C_Code.c:613: 		hp = gEkrGaugeHp[side];
	ldrsh	r3, [r2, r3]	@ hp, gEkrGaugeHp
@ C_Code.c:614: 		UpdateHP(proc, HpProc, opp_bunit, hp, side); 
	movs	r1, r7	@, HpProc
	movs	r2, r6	@, opp_bunit
	movs	r0, r4	@, proc
	str	r5, [sp]	@ side,
	bl	UpdateHP		@
.L236:
@ C_Code.c:625: }
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
.L238:
@ C_Code.c:618: 		BattleApplyExpGains();
	ldr	r3, .L244+12	@ tmp188,
	bl	.L8		@
	b	.L236		@
.L241:
@ C_Code.c:570: 			HpProc->post = newHp>>16; 
	str	r1, [r7, #80]	@ UsingSkillSys.23_36, MEM <vector(2) short int> [(short int *)HpProc_14(D) + 80B]
@ C_Code.c:571: 			HpProc->cur = hp>>16; 
	asrs	r1, r3, #16	@ tmp152, _30,
@ C_Code.c:571: 			HpProc->cur = hp>>16; 
	strh	r1, [r7, #46]	@ tmp152, HpProc_14(D)->cur
@ C_Code.c:572: 			HpProc->curHpAtkrSS = hp; 
	strh	r3, [r7, #48]	@ _30, HpProc_14(D)->curHpAtkrSS
@ C_Code.c:575: 		proc->currentRound->hpChange = diff; 
	strb	r2, [r0, #3]	@ _46, pretmp_38->hpChange
	b	.L240		@
.L245:
	.align	2
.L244:
	.word	gEkrGaugeHp
	.word	UsingSkillSys
	.word	gBanimDoneFlag
	.word	BattleApplyExpGains
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
	mov	r7, r8	@,
	mov	lr, r9	@,
	push	{r7, lr}	@
	movs	r4, r0	@ proc, tmp162
@ C_Code.c:629: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r0, [r0, #60]	@ _1, proc_7(D)->currentRound
@ C_Code.c:627: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	movs	r5, r1	@ HpProc, tmp163
@ C_Code.c:629: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r1, [r0]	@ *_1, *_1
@ C_Code.c:627: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	movs	r7, r2	@ active_bunit, tmp164
	movs	r6, r3	@ opp_bunit, tmp165
	sub	sp, sp, #12	@,,
@ C_Code.c:629: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsls	r1, r1, #30	@ tmp167, *_1,
	bmi	.L246		@,
@ C_Code.c:629: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	movs	r3, #3	@ tmp143,
	ldrsb	r3, [r0, r3]	@ tmp143,
	cmp	r3, #0	@ tmp143,
	beq	.L246		@,
@ C_Code.c:630: 	if (round->hpChange <= 0) { return; } // healing 
	movs	r1, #3	@ _14,
	ldr	r3, [sp, #40]	@ tmp174, round
	ldrsb	r1, [r3, r1]	@ _14,* _14
@ C_Code.c:630: 	if (round->hpChange <= 0) { return; } // healing 
	cmp	r1, #0	@ _14,
	ble	.L246		@,
@ C_Code.c:631: 	int side = proc->side; 
	movs	r3, #77	@ tmp146,
	ldrb	r3, [r4, r3]	@ side,
	mov	r9, r3	@ side, side
@ C_Code.c:632: 	int hp = gEkrGaugeHp[proc->side];
	mov	r2, r9	@ side, side
	ldr	r3, .L260	@ tmp147,
	lsls	r2, r2, #1	@ tmp148, side,
@ C_Code.c:632: 	int hp = gEkrGaugeHp[proc->side];
	ldrsh	r3, [r2, r3]	@ hp, gEkrGaugeHp
	mov	r8, r3	@ hp, hp
@ C_Code.c:633: 	if (!hp) { return; } 
	cmp	r3, #0	@ hp,
	beq	.L246		@,
@ C_Code.c:636: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	mov	r0, r9	@ side, side
	movs	r3, #1	@ tmp154,
@ C_Code.c:636: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	ldr	r2, .L260+4	@ tmp149,
@ C_Code.c:636: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	eors	r3, r0	@ tmp153, side
@ C_Code.c:636: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	lsls	r3, r3, #1	@ tmp155, tmp153,
@ C_Code.c:636: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	ldrsh	r0, [r3, r2]	@ oldDamage, gEkrGaugeDmg
@ C_Code.c:636: 	if (gEkrGaugeDmg[side ^ 1] > oldDamage) { oldDamage = gEkrGaugeDmg[side ^ 1]; } 
	cmp	r0, r1	@ oldDamage, _14
	ble	.L259		@,
.L249:
@ C_Code.c:638: 	int newDamage = (oldDamage * percent) / 100; 
	ldr	r3, [sp, #44]	@ tmp156, percent
	muls	r3, r0	@ tmp156, oldDamage
@ C_Code.c:638: 	int newDamage = (oldDamage * percent) / 100; 
	movs	r1, #100	@,
@ C_Code.c:638: 	int newDamage = (oldDamage * percent) / 100; 
	movs	r0, r3	@ tmp156, tmp156
@ C_Code.c:638: 	int newDamage = (oldDamage * percent) / 100; 
	ldr	r3, .L260+8	@ tmp159,
	bl	.L8		@
@ C_Code.c:639: 	if (!newDamage) { newDamage = 1; } 
	cmp	r0, #0	@ newDamage,
	bne	.L250		@,
@ C_Code.c:639: 	if (!newDamage) { newDamage = 1; } 
	adds	r0, r0, #1	@ newDamage,
.L250:
@ C_Code.c:726: 	UpdateHP(proc, HpProc, opp_bunit, gEkrGaugeHp[proc->side] - newDamage, side); 
	mov	r2, r9	@ side, side
	mov	r3, r8	@ hp, hp
	movs	r1, r5	@, HpProc
	subs	r3, r3, r0	@ tmp161, hp, newDamage
	str	r2, [sp]	@ side,
	movs	r0, r4	@, proc
	movs	r2, r6	@, opp_bunit
	bl	UpdateHP		@
@ C_Code.c:730: 	CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp); 
	mov	r3, r8	@ hp, hp
	str	r3, [sp, #4]	@ hp,
	ldr	r3, [sp, #40]	@ tmp184, round
	movs	r2, r7	@, active_bunit
	str	r3, [sp]	@ tmp184,
	movs	r1, r5	@, HpProc
	movs	r3, r6	@, opp_bunit
	movs	r0, r4	@, proc
	bl	CheckForDeath		@
.L246:
@ C_Code.c:745: } 
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r6, r7}
	mov	r9, r7
	mov	r8, r6
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L259:
@ C_Code.c:635: 	int oldDamage = round->hpChange;  
	movs	r0, r1	@ oldDamage, _14
	b	.L249		@
.L261:
	.align	2
.L260:
	.word	gEkrGaugeHp
	.word	gEkrGaugeDmg
	.word	__aeabi_idiv
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
@ C_Code.c:517: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r5, #11	@ tmp125,
	movs	r4, #192	@ tmp126,
	ldrsb	r5, [r2, r5]	@ tmp125,
@ C_Code.c:535: void AdjustDamageWithGetter(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int success) { 
	sub	sp, sp, #12	@,,
@ C_Code.c:517: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	ands	r4, r5	@ _14, tmp125
@ C_Code.c:516: 	if (success) { 
	ldr	r5, [sp, #28]	@ tmp137, success
	cmp	r5, #0	@ tmp137,
	beq	.L263		@,
@ C_Code.c:517: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _14,
	bne	.L264		@,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L277	@ tmp127,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, [r4]	@ BlockingEnabled, BlockingEnabled
	cmp	r4, #0	@ BlockingEnabled,
	beq	.L262		@,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L277+4	@ tmp129,
	ldr	r4, [r4]	@ _19,
@ C_Code.c:537: 	if (percent != 100) { 
	cmp	r4, #100	@ _19,
	bne	.L276		@,
.L262:
@ C_Code.c:540: } 
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L263:
@ C_Code.c:523: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _14,
	beq	.L262		@,
@ C_Code.c:526: 	return FailedHitDamagePercent; 
	ldr	r4, .L277+8	@ tmp131,
	ldr	r4, [r4]	@ _19,
.L266:
@ C_Code.c:537: 	if (percent != 100) { 
	cmp	r4, #100	@ _19,
	beq	.L262		@,
.L276:
@ C_Code.c:538: 		AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r4, [sp, #4]	@ _19,
	ldr	r4, [sp, #24]	@ tmp138, round
	str	r4, [sp]	@ tmp138,
	bl	AdjustDamageByPercent		@
@ C_Code.c:540: } 
	b	.L262		@
.L264:
@ C_Code.c:521: 		return BonusDamagePercent; 
	ldr	r4, .L277+12	@ tmp130,
	ldr	r4, [r4]	@ _19,
	b	.L266		@
.L278:
	.align	2
.L277:
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
@ C_Code.c:437: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldr	r3, .L325	@ tmp166,
@ C_Code.c:437: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldrh	r5, [r3, #8]	@ tmp169,
	ldrh	r3, [r3, #4]	@ tmp171,
@ C_Code.c:437: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	orrs	r5, r3	@ keys, tmp171
@ C_Code.c:441: 	int x = proc->anim2->xPosition; 
	ldr	r3, [r0, #48]	@ proc_5(D)->anim2, proc_5(D)->anim2
@ C_Code.c:435: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r7, r2	@ round, tmp260
@ C_Code.c:441: 	int x = proc->anim2->xPosition; 
	movs	r2, #2	@ tmp267,
	ldrsh	r3, [r3, r2]	@ x, proc_5(D)->anim2, tmp267
	mov	r8, r3	@ x, x
@ C_Code.c:442: 	struct BattleUnit* active_bunit = proc->active_bunit; 
	ldr	r3, [r0, #64]	@ active_bunit, proc_5(D)->active_bunit
	mov	r9, r3	@ active_bunit, active_bunit
@ C_Code.c:443: 	struct BattleUnit* opp_bunit = proc->opp_bunit; 
	ldr	r3, [r0, #68]	@ opp_bunit, proc_5(D)->opp_bunit
	mov	r10, r3	@ opp_bunit, opp_bunit
@ C_Code.c:444: 	int hitTime = !proc->EkrEfxIsUnitHittedNowFrames; 
	movs	r3, #82	@ tmp175,
@ C_Code.c:445: 	if (hitTime) { // 1 frame 
	ldrb	r3, [r0, r3]	@ tmp176,
@ C_Code.c:435: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r4, r0	@ proc, tmp258
	movs	r6, r1	@ HpProc, tmp259
	sub	sp, sp, #8	@,,
@ C_Code.c:445: 	if (hitTime) { // 1 frame 
	cmp	r3, #0	@ tmp176,
	bne	.L281		@,
@ C_Code.c:447: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	ldr	r2, [r0, #56]	@ proc_5(D)->timer2, proc_5(D)->timer2
	cmp	r2, #255	@ proc_5(D)->timer2,
	beq	.L322		@,
.L282:
@ C_Code.c:448: 		SaveInputFrame(proc, keys); 
	movs	r1, r5	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
@ C_Code.c:449: 		SaveIfWeHitOnTime(proc);
	movs	r0, r4	@, proc
	bl	SaveIfWeHitOnTime		@
@ C_Code.c:450: 		if (!proc->adjustedDmg) { 
	movs	r3, #74	@ tmp179,
@ C_Code.c:450: 		if (!proc->adjustedDmg) { 
	ldrb	r2, [r4, r3]	@ tmp180,
	cmp	r2, #0	@ tmp180,
	bne	.L281		@,
@ C_Code.c:384: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r2, .L325+4	@ tmp181,
@ C_Code.c:388: 	if (CheatCodeOn()) { return true; } 
	ldrb	r2, [r2, #31]	@ tmp184,
	cmp	r2, #127	@ tmp184,
	bls	.LCB1720	@
	b	.L284	@long jump	@
.LCB1720:
@ C_Code.c:389: 	if (AlwaysWork) { return true; } 
	ldr	r2, .L325+8	@ tmp185,
@ C_Code.c:389: 	if (AlwaysWork) { return true; } 
	ldr	r2, [r2]	@ AlwaysWork, AlwaysWork
	cmp	r2, #0	@ AlwaysWork,
	beq	.LCB1724	@
	b	.L284	@long jump	@
.LCB1724:
@ C_Code.c:390: 	return proc->hitOnTime;
	adds	r2, r2, #72	@ tmp187,
@ C_Code.c:451: 			if (DidWeHitOnTime(proc)) { 
	ldrb	r2, [r4, r2]	@ tmp188,
	cmp	r2, #0	@ tmp188,
	beq	.LCB1728	@
	b	.L284	@long jump	@
.LCB1728:
@ C_Code.c:457: 				proc->adjustedDmg = true; 
	movs	r2, #1	@ tmp205,
	strb	r2, [r4, r3]	@ tmp205, proc_5(D)->adjustedDmg
@ C_Code.c:523: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	mov	r3, r9	@ active_bunit, active_bunit
	movs	r2, #11	@ tmp207,
	ldrsb	r2, [r3, r2]	@ tmp207,
	movs	r3, #192	@ tmp208,
	ands	r3, r2	@ tmp209, tmp207
@ C_Code.c:523: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ tmp209,
	beq	.L281		@,
@ C_Code.c:526: 	return FailedHitDamagePercent; 
	ldr	r3, .L325+12	@ tmp210,
	ldr	r3, [r3]	@ _96,
.L321:
@ C_Code.c:537: 	if (percent != 100) { 
	cmp	r3, #100	@ _96,
	beq	.L281		@,
@ C_Code.c:538: 		AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r3, [sp, #4]	@ _96,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	movs	r1, r6	@, HpProc
	movs	r0, r4	@, proc
	str	r7, [sp]	@ round,
	bl	AdjustDamageByPercent		@
.L281:
@ C_Code.c:468: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	movs	r3, #77	@ tmp211,
@ C_Code.c:468: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r0, [r4, r3]	@ tmp212,
	ldr	r3, .L325+16	@ tmp213,
	bl	.L8		@
@ C_Code.c:468: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	cmp	r0, #0	@ tmp214,
	bne	.L289		@,
@ C_Code.c:468: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	movs	r3, #79	@ tmp216,
@ C_Code.c:468: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r3, [r4, r3]	@ tmp217,
	cmp	r3, #255	@ tmp217,
	beq	.L323		@,
.L289:
@ C_Code.c:384: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L325+4	@ tmp220,
@ C_Code.c:388: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp223,
@ C_Code.c:488: 		else if (proc->timer2 < 20) { 
	ldr	r5, [r4, #56]	@ pretmp_111, proc_5(D)->timer2
@ C_Code.c:388: 	if (CheatCodeOn()) { return true; } 
	cmp	r3, #127	@ tmp223,
	bhi	.L291		@,
@ C_Code.c:389: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L325+8	@ tmp224,
@ C_Code.c:389: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L291		@,
@ C_Code.c:390: 	return proc->hitOnTime;
	adds	r3, r3, #72	@ tmp226,
@ C_Code.c:471: 		if (DidWeHitOnTime(proc)) { 
	ldrb	r3, [r4, r3]	@ tmp227,
	cmp	r3, #0	@ tmp227,
	bne	.L291		@,
@ C_Code.c:488: 		else if (proc->timer2 < 20) { 
	cmp	r5, #19	@ pretmp_111,
	bgt	.L293		@,
@ C_Code.c:394: 	if (!DisplayPress) { return; } 
	ldr	r3, .L325+20	@ tmp243,
	ldr	r2, [r3]	@ pretmp_104, DisplayPress
@ C_Code.c:489: 			if (ChangePaletteWhenButtonIsPressed) { 
	ldr	r3, .L325+24	@ tmp244,
@ C_Code.c:489: 			if (ChangePaletteWhenButtonIsPressed) { 
	ldr	r3, [r3]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
	cmp	r3, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L294		@,
@ C_Code.c:394: 	if (!DisplayPress) { return; } 
	cmp	r2, #0	@ pretmp_104,
	beq	.L293		@,
	movs	r3, #15	@,
	movs	r2, #24	@,
	mov	r1, r8	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L293		@
.L291:
@ C_Code.c:483: 			if (((y > (-16)) && (y < (161)))) { 
	movs	r3, #63	@ tmp228,
	subs	r3, r3, r5	@ tmp229, tmp228, pretmp_111
@ C_Code.c:483: 			if (((y > (-16)) && (y < (161)))) { 
	cmp	r3, #175	@ tmp229,
	bls	.L324		@,
.L293:
@ C_Code.c:496: 		proc->roundEnd = true; 
	movs	r3, #81	@ tmp246,
	movs	r2, #1	@ tmp247,
	strb	r2, [r4, r3]	@ tmp247, proc_5(D)->roundEnd
.L279:
@ C_Code.c:512: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L322:
@ C_Code.c:447: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	str	r3, [r0, #56]	@ tmp176, proc_5(D)->timer2
	b	.L282		@
.L323:
@ C_Code.c:468: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	subs	r3, r3, #175	@ tmp218,
@ C_Code.c:468: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r3, [r4, r3]	@ tmp219,
	cmp	r3, #255	@ tmp219,
	bne	.L289		@,
@ C_Code.c:500: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	ldr	r3, [r4, #52]	@ proc_5(D)->timer, proc_5(D)->timer
	cmp	r3, #0	@ proc_5(D)->timer,
	bgt	.L296		@,
@ C_Code.c:500: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	movs	r3, #78	@ tmp250,
	strb	r0, [r4, r3]	@ tmp214, proc_5(D)->frame
.L297:
@ C_Code.c:505: 		if (!proc->roundEnd) { 
	movs	r3, #81	@ tmp253,
@ C_Code.c:505: 		if (!proc->roundEnd) { 
	ldrb	r3, [r4, r3]	@ tmp254,
	cmp	r3, #0	@ tmp254,
	bne	.L279		@,
@ C_Code.c:394: 	if (!DisplayPress) { return; } 
	ldr	r3, .L325+20	@ tmp255,
@ C_Code.c:394: 	if (!DisplayPress) { return; } 
	ldr	r3, [r3]	@ DisplayPress, DisplayPress
	cmp	r3, #0	@ DisplayPress,
	beq	.L279		@,
	movs	r3, #15	@,
	movs	r2, #24	@,
	mov	r1, r8	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L279		@
.L294:
	cmp	r2, #0	@ pretmp_104,
	beq	.L293		@,
	movs	r3, #14	@,
	movs	r2, #24	@,
	mov	r1, r8	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L293		@
.L284:
@ C_Code.c:245: 	if (proc->broke) { return; } 
	movs	r3, #75	@ tmp189,
@ C_Code.c:245: 	if (proc->broke) { return; } 
	ldrb	r2, [r4, r3]	@ tmp190,
	cmp	r2, #0	@ tmp190,
	bne	.L286		@,
@ C_Code.c:246: 	proc->broke = true; 
	adds	r2, r2, #1	@ tmp192,
	strb	r2, [r4, r3]	@ tmp192, proc_5(D)->broke
@ C_Code.c:247: 	asm("mov r11, r11");
	.syntax divided
@ 247 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L286:
@ C_Code.c:453: 				proc->adjustedDmg = true; 
	movs	r3, #74	@ tmp194,
	movs	r2, #1	@ tmp195,
	strb	r2, [r4, r3]	@ tmp195, proc_5(D)->adjustedDmg
@ C_Code.c:517: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	mov	r3, r9	@ active_bunit, active_bunit
	movs	r2, #11	@ tmp197,
	ldrsb	r2, [r3, r2]	@ tmp197,
	movs	r3, #192	@ tmp198,
	ands	r3, r2	@ tmp199, tmp197
@ C_Code.c:517: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ tmp199,
	bne	.L287		@,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L325+28	@ tmp200,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	bne	.LCB1887	@
	b	.L281	@long jump	@
.LCB1887:
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L325+32	@ tmp202,
	ldr	r3, [r3]	@ _78,
@ C_Code.c:518: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L321		@
.L324:
@ C_Code.c:478: 			x += Mod(clock, 8) >> 1; 
	movs	r1, #8	@,
	movs	r0, r5	@, pretmp_111
	ldr	r3, .L325+36	@ tmp230,
	bl	.L8		@
@ C_Code.c:480: 			y -= clock; 
	movs	r1, #48	@ tmp233,
@ C_Code.c:484: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	movs	r2, #255	@ tmp235,
@ C_Code.c:480: 			y -= clock; 
	subs	r1, r1, r5	@ y, tmp233, pretmp_111
@ C_Code.c:484: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	ands	r2, r1	@ tmp236, y
@ C_Code.c:478: 			x += Mod(clock, 8) >> 1; 
	asrs	r1, r0, #1	@ tmp237, tmp262,
@ C_Code.c:484: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	movs	r0, #224	@ tmp241,
@ C_Code.c:478: 			x += Mod(clock, 8) >> 1; 
	add	r1, r1, r8	@ x, x
@ C_Code.c:484: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	lsls	r0, r0, #8	@ tmp241, tmp241,
	lsls	r1, r1, #23	@ tmp240, x,
	str	r0, [sp]	@ tmp241,
	ldr	r3, .L325+40	@ tmp232,
	movs	r0, #0	@,
	ldr	r5, .L325+44	@ tmp242,
	lsrs	r1, r1, #23	@ tmp239, tmp240,
	bl	.L26		@
	b	.L293		@
.L287:
@ C_Code.c:521: 		return BonusDamagePercent; 
	ldr	r3, .L325+48	@ tmp203,
	ldr	r3, [r3]	@ _78,
	b	.L321		@
.L296:
@ C_Code.c:503: 			SaveInputFrame(proc, keys); 
	movs	r1, r5	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
	b	.L297		@
.L326:
	.align	2
.L325:
	.word	sKeyStatusBuffer
	.word	gPlaySt
	.word	AlwaysWork
	.word	FailedHitDamagePercent
	.word	EkrEfxIsUnitHittedNow
	.word	DisplayPress
	.word	ChangePaletteWhenButtonIsPressed
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
	push	{r4, r5, r6, lr}	@
@ C_Code.c:435: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r4, r0	@ proc, tmp139
@ C_Code.c:94: 	if (TimedHitsDifficultyRam->off) { return false; } 
	ldr	r0, .L333	@ tmp124,
	ldr	r0, [r0]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r0, [r0]	@ *TimedHitsDifficultyRam.0_10, *TimedHitsDifficultyRam.0_10
@ C_Code.c:435: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r6, r2	@ HpProc, tmp140
	movs	r5, r3	@ round, tmp141
@ C_Code.c:94: 	if (TimedHitsDifficultyRam->off) { return false; } 
	lsls	r0, r0, #25	@ tmp143, *TimedHitsDifficultyRam.0_10,
	bpl	.L332		@,
.L327:
@ C_Code.c:512: } 
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L332:
@ C_Code.c:95: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L333+4	@ tmp134,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L333+8	@ tmp136,
	bl	.L8		@
@ C_Code.c:436: 	if (!AreTimedHitsEnabled()) { return; } 
	cmp	r0, #0	@ tmp142,
	bne	.L327		@,
	movs	r2, r5	@, round
	movs	r1, r6	@, HpProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit.part.0		@
	b	.L327		@
.L334:
	.align	2
.L333:
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
@ C_Code.c:259: 	if (!proc->anim) { return; } 
	ldr	r3, [r0, #44]	@ proc_25(D)->anim, proc_25(D)->anim
@ C_Code.c:258: void LoopTimedHitsProc(TimedHitsProc* proc) { 
	movs	r4, r0	@ proc, tmp195
	sub	sp, sp, #8	@,,
@ C_Code.c:259: 	if (!proc->anim) { return; } 
	cmp	r3, #0	@ proc_25(D)->anim,
	beq	.L335		@,
@ C_Code.c:261: 	struct ProcEkrBattle* battleProc = gpProcEkrBattle; 
	ldr	r3, .L361	@ tmp146,
@ C_Code.c:263: 	if (!battleProc) { return; } 
	ldr	r3, [r3]	@ gpProcEkrBattle, gpProcEkrBattle
	cmp	r3, #0	@ gpProcEkrBattle,
	beq	.L335		@,
@ C_Code.c:264: 	if (!proc->anim2) { return; } 
	ldr	r3, [r0, #48]	@ proc_25(D)->anim2, proc_25(D)->anim2
	cmp	r3, #0	@ proc_25(D)->anim2,
	beq	.L335		@,
@ C_Code.c:266: 	proc->timer++;
	ldr	r3, [r0, #52]	@ proc_25(D)->timer, proc_25(D)->timer
	adds	r3, r3, #1	@ tmp149,
	str	r3, [r0, #52]	@ tmp149, proc_25(D)->timer
@ C_Code.c:267: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	ldr	r3, [r0, #56]	@ _5, proc_25(D)->timer2
@ C_Code.c:267: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	cmp	r3, #255	@ _5,
	beq	.L339		@,
@ C_Code.c:267: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	adds	r3, r3, #1	@ tmp151,
	str	r3, [r0, #56]	@ tmp151, proc_25(D)->timer2
.L339:
@ C_Code.c:271: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	movs	r5, #82	@ tmp152,
	ldrb	r3, [r4, r5]	@ _7,
@ C_Code.c:269: 	struct SkillSysBattleHit* currentRound = proc->currentRound; 
	ldr	r6, [r4, #60]	@ currentRound, proc_25(D)->currentRound
@ C_Code.c:271: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	cmp	r3, #255	@ _7,
	beq	.L340		@,
@ C_Code.c:272: 		proc->EkrEfxIsUnitHittedNowFrames++; 
	adds	r3, r3, #1	@ tmp153,
	strb	r3, [r4, r5]	@ tmp153, proc_25(D)->EkrEfxIsUnitHittedNowFrames
.L341:
@ C_Code.c:277: 	struct NewProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	ldr	r3, .L361+4	@ tmp164,
	ldr	r0, [r3]	@ gProcScr_efxHPBar, gProcScr_efxHPBar
	ldr	r3, .L361+8	@ tmp166,
	bl	.L8		@
@ C_Code.c:94: 	if (TimedHitsDifficultyRam->off) { return false; } 
	ldr	r3, .L361+12	@ tmp168,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_41, *TimedHitsDifficultyRam.0_41
@ C_Code.c:277: 	struct NewProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	movs	r5, r0	@ HpProc, tmp197
@ C_Code.c:94: 	if (TimedHitsDifficultyRam->off) { return false; } 
	lsls	r3, r3, #25	@ tmp202, *TimedHitsDifficultyRam.0_41,
	bmi	.L343		@,
@ C_Code.c:95: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L361+16	@ tmp178,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L361+20	@ tmp180,
	bl	.L8		@
@ C_Code.c:436: 	if (!AreTimedHitsEnabled()) { return; } 
	cmp	r0, #0	@ tmp198,
	bne	.L343		@,
	movs	r2, r6	@, currentRound
	movs	r1, r5	@, HpProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit.part.0		@
.L343:
@ C_Code.c:252: 	if (!HpProc) { return false; } // 
	cmp	r5, #0	@ HpProc,
	beq	.L335		@,
@ C_Code.c:254: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #82	@ tmp183,
@ C_Code.c:254: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r3, [r4, r3]	@ tmp184,
	cmp	r3, #0	@ tmp184,
	bne	.L335		@,
@ C_Code.c:280: 		int x = BAN_DisplayDamage(proc->anim2, 0, 0, 0, proc->roundId); 
	movs	r6, #73	@ tmp186,
@ C_Code.c:280: 		int x = BAN_DisplayDamage(proc->anim2, 0, 0, 0, proc->roundId); 
	ldrb	r3, [r4, r6]	@ tmp187,
	movs	r1, #0	@,
	movs	r2, #0	@,
	ldr	r0, [r4, #48]	@ proc_25(D)->anim2, proc_25(D)->anim2
	ldr	r5, .L361+24	@ tmp188,
	str	r3, [sp]	@ tmp187,
	movs	r3, #0	@,
	bl	.L26		@
	movs	r3, r0	@ x, tmp199
@ C_Code.c:281: 		x = BAN_DisplayDamage(proc->anim, 1, proc->anim->xPosition, x, proc->roundId);  
	ldr	r0, [r4, #44]	@ _16, proc_25(D)->anim
	movs	r1, #2	@ tmp204,
	ldrsh	r2, [r0, r1]	@ tmp189, _16, tmp204
	ldrb	r1, [r4, r6]	@ tmp191,
	str	r1, [sp]	@ tmp191,
	movs	r1, #1	@,
	bl	.L26		@
.L335:
@ C_Code.c:284: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L340:
@ C_Code.c:274: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #77	@ tmp156,
@ C_Code.c:274: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	ldrb	r0, [r4, r3]	@ tmp157,
	ldr	r3, .L361+28	@ tmp158,
	bl	.L8		@
@ C_Code.c:274: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	cmp	r0, #0	@ tmp196,
	beq	.L341		@,
@ C_Code.c:274: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #0	@ tmp162,
	strb	r3, [r4, r5]	@ tmp162, proc_25(D)->EkrEfxIsUnitHittedNowFrames
	b	.L341		@
.L362:
	.align	2
.L361:
	.word	gpProcEkrBattle
	.word	gProcScr_efxHPBar
	.word	Proc_Find
	.word	TimedHitsDifficultyRam
	.word	DisabledFlag
	.word	CheckFlag
	.word	BAN_DisplayDamage
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
@ C_Code.c:757: 	int result = gPlaySt.config.animationType; 
	movs	r2, #66	@ tmp130,
@ C_Code.c:756: int GetBattleAnimPreconfType(void) {
	push	{r4, lr}	@
@ C_Code.c:757: 	int result = gPlaySt.config.animationType; 
	ldr	r3, .L375	@ tmp164,
	ldrb	r0, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:758: 	if (!CheatCodeOn()) { 
	ldrb	r2, [r3, #31]	@ tmp139,
@ C_Code.c:757: 	int result = gPlaySt.config.animationType; 
	lsls	r0, r0, #29	@ tmp134, gPlaySt,
@ C_Code.c:757: 	int result = gPlaySt.config.animationType; 
	lsrs	r0, r0, #30	@ <retval>, tmp134,
@ C_Code.c:758: 	if (!CheatCodeOn()) { 
	cmp	r2, #127	@ tmp139,
	bhi	.L364		@,
@ C_Code.c:759: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, .L375+4	@ tmp140,
@ C_Code.c:759: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, [r2]	@ ForceAnimsOn, ForceAnimsOn
	cmp	r2, #0	@ ForceAnimsOn,
	beq	.L364		@,
@ C_Code.c:759: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	cmp	r0, #2	@ <retval>,
	beq	.L363		@,
.L367:
@ C_Code.c:759: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	movs	r0, #1	@ <retval>,
.L363:
@ C_Code.c:780: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L364:
@ C_Code.c:762:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r2, #66	@ tmp143,
	ldrb	r2, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:762:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r3, #6	@ tmp149,
	ands	r3, r2	@ tmp150, gPlaySt
	cmp	r3, #4	@ tmp150,
	bne	.L363		@,
@ C_Code.c:766:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	movs	r1, #11	@ tmp154,
@ C_Code.c:767:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	movs	r4, #11	@ pretmp_25,
@ C_Code.c:766:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldr	r0, .L375+8	@ tmp153,
@ C_Code.c:767:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldr	r2, .L375+12	@ tmp152,
@ C_Code.c:766:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldrsb	r1, [r0, r1]	@ tmp154,
	adds	r3, r3, #188	@ tmp155,
@ C_Code.c:767:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldrsb	r4, [r2, r4]	@ pretmp_25,* pretmp_25
@ C_Code.c:766:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	tst	r3, r1	@ tmp155, tmp154
	beq	.L374		@,
@ C_Code.c:772:         if (UNIT_FACTION(&gBattleTarget.unit) != FACTION_BLUE)
	tst	r3, r4	@ tmp155, pretmp_25
	bne	.L367		@,
@ C_Code.c:779:         return GetSoloAnimPreconfType(&gBattleTarget.unit);
	movs	r0, r2	@, tmp152
.L374:
	ldr	r3, .L375+16	@ tmp162,
	bl	.L8		@
	b	.L363		@
.L376:
	.align	2
.L375:
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
.LC101:
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
	.word	.LC101
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
.L8:
	bx	r3
.L115:
	bx	r4
.L26:
	bx	r5
.L56:
	bx	r10
