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
@ GNU C23 (devkitARM release 66) version 15.1.0 (arm-none-eabi)
@	compiled by GNU C version 13.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

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
@ C_Code.c:103:     if (gBattleStats.config &
	ldr	r3, .L8	@ tmp123,
@ C_Code.c:103:     if (gBattleStats.config &
	ldrh	r2, [r3]	@ gBattleStats, gBattleStats
	movs	r3, #252	@ tmp127,
	lsls	r3, r3, #2	@ tmp127, tmp127,
@ C_Code.c:102: {
	push	{r4, lr}	@
@ C_Code.c:103:     if (gBattleStats.config &
	tst	r2, r3	@ gBattleStats, tmp127
	bne	.L3		@,
@ C_Code.c:109:     if (TimedHitsDifficultyRam->off)
	ldr	r3, .L8+4	@ tmp132,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_4, *TimedHitsDifficultyRam.0_4
@ C_Code.c:107:         return false;
	movs	r0, #0	@ <retval>,
@ C_Code.c:109:     if (TimedHitsDifficultyRam->off)
	lsls	r3, r3, #25	@ tmp154, *TimedHitsDifficultyRam.0_4,
	bpl	.L7		@,
.L1:
@ C_Code.c:114: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L7:
@ C_Code.c:113:     return !CheckFlag(DisabledFlag);
	ldr	r3, .L8+8	@ tmp142,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L8+12	@ tmp144,
	bl	.L10		@
@ C_Code.c:113:     return !CheckFlag(DisabledFlag);
	movs	r3, #1	@ tmp147,
	eors	r0, r3	@ tmp149, tmp147
	lsls	r0, r0, #24	@ tmp150, tmp149,
	lsrs	r0, r0, #24	@ <retval>, tmp150,
	b	.L1		@
.L3:
@ C_Code.c:107:         return false;
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
@ C_Code.c:118:     proc->anim = NULL;
	movs	r3, #0	@ tmp115,
@ C_Code.c:137: }
	@ sp needed	@
@ C_Code.c:133:     proc->buttonsToPress = 0;
	movs	r2, #80	@ tmp121,
@ C_Code.c:118:     proc->anim = NULL;
	str	r3, [r0, #44]	@ tmp115, proc_2(D)->anim
@ C_Code.c:119:     proc->anim2 = NULL;
	str	r3, [r0, #48]	@ tmp115, proc_2(D)->anim2
@ C_Code.c:122:     proc->timer = 0;
	str	r3, [r0, #52]	@ tmp115, proc_2(D)->timer
@ C_Code.c:128:     proc->currentRound = NULL;
	str	r3, [r0, #56]	@ tmp115, proc_2(D)->currentRound
@ C_Code.c:129:     proc->active_bunit = NULL;
	str	r3, [r0, #60]	@ tmp115, proc_2(D)->active_bunit
@ C_Code.c:130:     proc->opp_bunit = NULL;
	str	r3, [r0, #64]	@ tmp115, proc_2(D)->opp_bunit
@ C_Code.c:133:     proc->buttonsToPress = 0;
	strh	r3, [r0, r2]	@ tmp115, proc_2(D)->buttonsToPress
@ C_Code.c:123:     proc->timer2 = 0xFF;
	ldr	r3, .L12	@ tmp124,
	str	r3, [r0, #68]	@ tmp124, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 68B]
	subs	r3, r3, #255	@ tmp125,
	str	r3, [r0, #72]	@ tmp125, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 72B]
	ldr	r3, .L12+4	@ tmp126,
	str	r3, [r0, #76]	@ tmp126, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 76B]
@ C_Code.c:137: }
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
	.type	StartTimedHitsProc, %function
StartTimedHitsProc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:142:     proc = Proc_Find(TimedHitsProcCmd);
	ldr	r0, .L17	@,
	ldr	r3, .L17+4	@ tmp117,
	bl	.L10		@
	subs	r4, r0, #0	@ proc,,
@ C_Code.c:143:     if (!proc)
	beq	.L16		@,
.L14:
@ C_Code.c:148: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L16:
@ C_Code.c:145:         proc = Proc_Start(TimedHitsProcCmd, (void *)3);
	ldr	r3, .L17+8	@ tmp119,
	movs	r1, #3	@,
	ldr	r0, .L17	@,
	bl	.L10		@
@ C_Code.c:133:     proc->buttonsToPress = 0;
	movs	r3, #80	@ tmp126,
@ C_Code.c:118:     proc->anim = NULL;
	str	r4, [r0, #44]	@ proc, proc_6->anim
@ C_Code.c:119:     proc->anim2 = NULL;
	str	r4, [r0, #48]	@ proc, proc_6->anim2
@ C_Code.c:122:     proc->timer = 0;
	str	r4, [r0, #52]	@ proc, proc_6->timer
@ C_Code.c:128:     proc->currentRound = NULL;
	str	r4, [r0, #56]	@ proc, proc_6->currentRound
@ C_Code.c:129:     proc->active_bunit = NULL;
	str	r4, [r0, #60]	@ proc, proc_6->active_bunit
@ C_Code.c:130:     proc->opp_bunit = NULL;
	str	r4, [r0, #64]	@ proc, proc_6->opp_bunit
@ C_Code.c:133:     proc->buttonsToPress = 0;
	strh	r4, [r0, r3]	@ proc, proc_6->buttonsToPress
@ C_Code.c:123:     proc->timer2 = 0xFF;
	ldr	r3, .L17+12	@ tmp129,
	str	r3, [r0, #68]	@ tmp129, MEM <vector(4) unsigned char> [(unsigned char *)proc_6 + 68B]
	subs	r3, r3, #255	@ tmp130,
	str	r3, [r0, #72]	@ tmp130, MEM <vector(4) unsigned char> [(unsigned char *)proc_6 + 72B]
	ldr	r3, .L17+16	@ tmp131,
	str	r3, [r0, #76]	@ tmp131, MEM <vector(4) unsigned char> [(unsigned char *)proc_6 + 76B]
@ C_Code.c:148: }
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
	.type	SetCurrentAnimInProc, %function
SetCurrentAnimInProc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ C_Code.c:152: {
	movs	r6, r0	@ anim, anim
@ C_Code.c:154:     proc = Proc_Find(TimedHitsProcCmd);
	ldr	r3, .L26	@ tmp133,
	ldr	r0, .L26+4	@ tmp132,
	bl	.L10		@
	subs	r4, r0, #0	@ proc,,
@ C_Code.c:155:     if (!proc)
	beq	.L19		@,
@ C_Code.c:160:     if (proc->roundId == roundId)
	movs	r7, #70	@ tmp135,
@ C_Code.c:159:     int roundId = anim->nextRoundId - 1;
	ldrh	r5, [r6, #14]	@ _2,
@ C_Code.c:160:     if (proc->roundId == roundId)
	ldrb	r3, [r0, r7]	@ _4,
@ C_Code.c:159:     int roundId = anim->nextRoundId - 1;
	subs	r5, r5, #1	@ roundId,
@ C_Code.c:160:     if (proc->roundId == roundId)
	cmp	r3, r5	@ _4, roundId
	beq	.L19		@,
@ C_Code.c:119:     proc->anim2 = NULL;
	movs	r3, #0	@ tmp137,
@ C_Code.c:133:     proc->buttonsToPress = 0;
	movs	r2, #80	@ tmp142,
@ C_Code.c:119:     proc->anim2 = NULL;
	str	r3, [r0, #48]	@ tmp137, proc_19->anim2
@ C_Code.c:122:     proc->timer = 0;
	str	r3, [r0, #52]	@ tmp137, proc_19->timer
@ C_Code.c:128:     proc->currentRound = NULL;
	str	r3, [r0, #56]	@ tmp137, proc_19->currentRound
@ C_Code.c:129:     proc->active_bunit = NULL;
	str	r3, [r0, #60]	@ tmp137, proc_19->active_bunit
@ C_Code.c:130:     proc->opp_bunit = NULL;
	str	r3, [r0, #64]	@ tmp137, proc_19->opp_bunit
@ C_Code.c:133:     proc->buttonsToPress = 0;
	strh	r3, [r0, r2]	@ tmp137, proc_19->buttonsToPress
@ C_Code.c:123:     proc->timer2 = 0xFF;
	ldr	r3, .L26+8	@ tmp145,
	str	r3, [r0, #68]	@ tmp145, MEM <vector(4) unsigned char> [(unsigned char *)proc_19 + 68B]
	subs	r3, r3, #255	@ tmp146,
	str	r3, [r0, #72]	@ tmp146, MEM <vector(4) unsigned char> [(unsigned char *)proc_19 + 72B]
	ldr	r3, .L26+12	@ tmp147,
@ C_Code.c:166:     proc->anim = anim;
	str	r6, [r0, #44]	@ anim, proc_19->anim
@ C_Code.c:123:     proc->timer2 = 0xFF;
	str	r3, [r0, #76]	@ tmp147, MEM <vector(4) unsigned char> [(unsigned char *)proc_19 + 76B]
@ C_Code.c:167:     proc->anim2 = GetAnimAnotherSide(anim);
	ldr	r3, .L26+16	@ tmp148,
	movs	r0, r6	@, anim
	bl	.L10		@
@ C_Code.c:167:     proc->anim2 = GetAnimAnotherSide(anim);
	str	r0, [r4, #48]	@ _5, proc_19->anim2
@ C_Code.c:171:     proc->currentRound = GetCurrentRound(proc->roundId);
	movs	r0, #255	@ tmp151,
	ldr	r3, .L26+20	@ tmp153,
@ C_Code.c:168:     proc->roundId = roundId;
	strb	r5, [r4, r7]	@ roundId, proc_19->roundId
@ C_Code.c:171:     proc->currentRound = GetCurrentRound(proc->roundId);
	ands	r0, r5	@ _45, roundId
	bl	.L10		@
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	ldr	r3, .L26+24	@ tmp154,
@ C_Code.c:171:     proc->currentRound = GetCurrentRound(proc->roundId);
	str	r0, [r4, #56]	@ _7, proc_19->currentRound
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r0, r6	@, anim
	bl	.L10		@
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r3, #1	@ tmp156,
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r2, #74	@ tmp159,
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	lsls	r0, r0, #24	@ tmp155, _8,
	asrs	r0, r0, #24	@ _9, tmp155,
	eors	r3, r0	@ tmp158, _9
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	strb	r3, [r4, r2]	@ tmp158, proc_19->side
@ C_Code.c:173:     proc->active_bunit = gpEkrBattleUnitLeft;
	ldr	r3, .L26+28	@ tmp161,
@ C_Code.c:174:     proc->opp_bunit = gpEkrBattleUnitRight;
	ldr	r2, .L26+32	@ tmp162,
@ C_Code.c:173:     proc->active_bunit = gpEkrBattleUnitLeft;
	ldr	r3, [r3]	@ gpEkrBattleUnitLeft.2_12, gpEkrBattleUnitLeft
@ C_Code.c:174:     proc->opp_bunit = gpEkrBattleUnitRight;
	ldr	r2, [r2]	@ gpEkrBattleUnitRight.3_13, gpEkrBattleUnitRight
@ C_Code.c:173:     proc->active_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #60]	@ gpEkrBattleUnitLeft.2_12, proc_19->active_bunit
@ C_Code.c:174:     proc->opp_bunit = gpEkrBattleUnitRight;
	str	r2, [r4, #64]	@ gpEkrBattleUnitRight.3_13, proc_19->opp_bunit
@ C_Code.c:175:     if (!proc->side)
	cmp	r0, #1	@ _9,
	beq	.L24		@,
@ C_Code.c:180:     if (!proc->loadedImg)
	movs	r6, #73	@ tmp163,
@ C_Code.c:180:     if (!proc->loadedImg)
	ldrb	r3, [r4, r6]	@ tmp164,
	cmp	r3, #0	@ tmp164,
	beq	.L25		@,
.L19:
@ C_Code.c:192: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L24:
@ C_Code.c:180:     if (!proc->loadedImg)
	movs	r6, #73	@ tmp163,
@ C_Code.c:177:         proc->active_bunit = gpEkrBattleUnitRight;
	str	r2, [r4, #60]	@ gpEkrBattleUnitRight.3_13, proc_19->active_bunit
@ C_Code.c:178:         proc->opp_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #64]	@ gpEkrBattleUnitLeft.2_12, proc_19->opp_bunit
@ C_Code.c:180:     if (!proc->loadedImg)
	ldrb	r3, [r4, r6]	@ tmp164,
	cmp	r3, #0	@ tmp164,
	bne	.L19		@,
.L25:
@ C_Code.c:182:         Copy2dChr(&Press_Image, (void *)0x06012980, 6, 2);
	ldr	r5, .L26+36	@ tmp167,
	movs	r2, #6	@,
	ldr	r0, .L26+40	@ tmp166,
	ldr	r1, .L26+44	@,
	adds	r3, r3, #2	@,
	bl	.L28		@
@ C_Code.c:183:         Copy2dChr(&BattleStar, (void *)0x06012a40, 2, 2);   // 0x108
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+48	@ tmp169,
	ldr	r1, .L26+52	@,
	bl	.L28		@
@ C_Code.c:184:         Copy2dChr(&A_Button, (void *)0x06012800, 2, 2);     // 0x140
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+56	@ tmp172,
	ldr	r1, .L26+60	@,
	bl	.L28		@
@ C_Code.c:185:         Copy2dChr(&B_Button, (void *)0x06012840, 2, 2);     // 0x142
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+64	@ tmp175,
	ldr	r1, .L26+68	@,
	bl	.L28		@
@ C_Code.c:186:         Copy2dChr(&Left_Button, (void *)0x06012880, 2, 2);  // 0x144
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+72	@ tmp178,
	ldr	r1, .L26+76	@,
	bl	.L28		@
@ C_Code.c:187:         Copy2dChr(&Right_Button, (void *)0x060128C0, 2, 2); // 0x146
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+80	@ tmp181,
	ldr	r1, .L26+84	@,
	bl	.L28		@
@ C_Code.c:188:         Copy2dChr(&Up_Button, (void *)0x06012900, 2, 2);    // 0x148
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+88	@ tmp184,
	ldr	r1, .L26+92	@,
	bl	.L28		@
@ C_Code.c:189:         Copy2dChr(&Down_Button, (void *)0x06012940, 2, 2);  // 0x14a
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L26+96	@ tmp187,
	ldr	r1, .L26+100	@,
	bl	.L28		@
@ C_Code.c:190:         proc->loadedImg = true;
	movs	r3, #1	@ tmp190,
	strb	r3, [r4, r6]	@ tmp190, proc_19->loadedImg
	b	.L19		@
.L27:
	.align	2
.L26:
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
	.type	BreakOnce, %function
BreakOnce:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:272:     if (proc->broke)
	movs	r3, #72	@ tmp116,
@ C_Code.c:272:     if (proc->broke)
	ldrb	r2, [r0, r3]	@ tmp117,
	cmp	r2, #0	@ tmp117,
	bne	.L29		@,
@ C_Code.c:276:     proc->broke = true;
	adds	r2, r2, #1	@ tmp119,
	strb	r2, [r0, r3]	@ tmp119, proc_4(D)->broke
@ C_Code.c:277:     asm("mov r11, r11");
	.syntax divided
@ 277 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L29:
@ C_Code.c:278: }
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
@ C_Code.c:283:     if (!HpProc)
	cmp	r1, #0	@ HpProc,
	beq	.L33		@,
@ C_Code.c:288:     if (proc->EkrEfxIsUnitHittedNowFrames)
	movs	r3, #79	@ tmp119,
@ C_Code.c:288:     if (proc->EkrEfxIsUnitHittedNowFrames)
	ldrb	r0, [r0, r3]	@ tmp121,
	rsbs	r3, r0, #0	@ tmp123, tmp121
	adcs	r0, r0, r3	@ <retval>, tmp121, tmp123
.L31:
@ C_Code.c:293: }
	@ sp needed	@
	bx	lr
.L33:
@ C_Code.c:285:         return false;
	movs	r0, #0	@ <retval>,
	b	.L31		@
	.size	HitNow, .-HitNow
	.align	1
	.p2align 2,,3
	.global	IsNotMagicAnimation
	.syntax unified
	.code	16
	.thumb_func
	.type	IsNotMagicAnimation, %function
IsNotMagicAnimation:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:362:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	movs	r3, #74	@ tmp124,
@ C_Code.c:361: {
	push	{r4, lr}	@
@ C_Code.c:362:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldr	r2, [r0, #60]	@ proc_6(D)->active_bunit, proc_6(D)->active_bunit
@ C_Code.c:376: }
	@ sp needed	@
@ C_Code.c:362:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldrh	r0, [r2, r3]	@ _3,
	ldr	r3, .L35	@ tmp126,
	bl	.L10		@
@ C_Code.c:371:     if (wepType == 7)
	movs	r3, #2	@ tmp131,
@ C_Code.c:367:     if (wepType == 6)
	subs	r0, r0, #5	@ _4,
@ C_Code.c:371:     if (wepType == 7)
	cmp	r3, r0	@ tmp131, _4
	sbcs	r0, r0, r0	@ tmp135
	rsbs	r0, r0, #0	@ _15, tmp135
@ C_Code.c:376: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L36:
	.align	2
.L35:
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
	.type	GetButtonsToPress, %function
GetButtonsToPress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r10	@,
	mov	r7, r9	@,
	mov	r6, r8	@,
	push	{r6, r7, lr}	@
@ C_Code.c:381:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L65	@ tmp149,
@ C_Code.c:381:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:380: {
	mov	r10, r0	@ proc, proc
	sub	sp, sp, #8	@,,
@ C_Code.c:381:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	cmp	r3, #0	@ AlwaysA,
	bne	.L53		@,
@ C_Code.c:381:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L65+4	@ tmp151,
	ldr	r2, [r3]	@ TimedHitsDifficultyRam.10_2, TimedHitsDifficultyRam
@ C_Code.c:381:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.10_2, *TimedHitsDifficultyRam.10_2
	lsls	r3, r3, #26	@ tmp210, *TimedHitsDifficultyRam.10_2,
	bmi	.L53		@,
@ C_Code.c:385:     int keys = proc->buttonsToPress;
	movs	r3, #80	@ tmp161,
@ C_Code.c:385:     int keys = proc->buttonsToPress;
	ldrh	r5, [r0, r3]	@ <retval>,
@ C_Code.c:386:     if (!keys)
	cmp	r5, #0	@ <retval>,
	bne	.L37		@,
@ C_Code.c:388:         u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN };
	ldr	r3, .L65+8	@ tmp163,
	ldr	r1, [r3]	@ tmp166,
	str	r1, [sp]	@ tmp166,
	mov	r1, sp	@ tmp213,
	ldrh	r3, [r3, #4]	@ tmp168,
	strh	r3, [r1, #4]	@ tmp168,
@ C_Code.c:393:         int numberOfRandomButtons = NumberOfRandomButtons;
	ldr	r3, .L65+12	@ tmp170,
	ldr	r4, [r3]	@ numberOfRandomButtons, NumberOfRandomButtons
@ C_Code.c:362:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	movs	r3, #74	@ tmp172,
	ldr	r1, [r0, #60]	@ proc_31(D)->active_bunit, proc_31(D)->active_bunit
@ C_Code.c:393:         int numberOfRandomButtons = NumberOfRandomButtons;
	mov	r8, r4	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:362:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldrh	r0, [r1, r3]	@ _70,
@ C_Code.c:394:         if (!numberOfRandomButtons)
	cmp	r4, #0	@ numberOfRandomButtons,
	bne	.L39		@,
@ C_Code.c:362:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldr	r3, .L65+16	@ tmp179,
@ C_Code.c:396:             numberOfRandomButtons = TimedHitsDifficultyRam->difficulty;
	ldrb	r4, [r2]	@ *TimedHitsDifficultyRam.10_2, *TimedHitsDifficultyRam.10_2
@ C_Code.c:362:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	bl	.L10		@
@ C_Code.c:396:             numberOfRandomButtons = TimedHitsDifficultyRam->difficulty;
	lsls	r4, r4, #27	@ tmp177, *TimedHitsDifficultyRam.10_2,
@ C_Code.c:367:     if (wepType == 6)
	subs	r0, r0, #5	@ _52,
@ C_Code.c:396:             numberOfRandomButtons = TimedHitsDifficultyRam->difficulty;
	lsrs	r4, r4, #27	@ _6, tmp177,
@ C_Code.c:371:     if (wepType == 7)
	cmp	r0, #2	@ _52,
	bhi	.L40		@,
@ C_Code.c:402:         if (!numberOfRandomButtons)
	adds	r3, r4, #0	@ _13, _6
	cmp	r4, #0	@ _6,
	beq	.L63		@,
.L41:
	lsls	r3, r3, #24	@ tmp185, _13,
	lsrs	r3, r3, #24	@ numberOfRandomButtons, tmp185,
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
	b	.L42		@
.L53:
@ C_Code.c:383:         return A_BUTTON;
	movs	r5, #1	@ <retval>,
.L37:
@ C_Code.c:447: }
	movs	r0, r5	@, <retval>
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L39:
@ C_Code.c:362:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldr	r3, .L65+16	@ tmp202,
	bl	.L10		@
@ C_Code.c:367:     if (wepType == 6)
	subs	r0, r0, #5	@ _20,
@ C_Code.c:371:     if (wepType == 7)
	cmp	r0, #2	@ _20,
	bls	.L50		@,
@ C_Code.c:400:             numberOfRandomButtons = numberOfRandomButtons / 2;
	mov	r2, r8	@ numberOfRandomButtons, numberOfRandomButtons
	lsrs	r3, r2, #31	@ tmp187, numberOfRandomButtons,
	adds	r3, r3, r2	@ tmp188, tmp187, numberOfRandomButtons
	asrs	r3, r3, #1	@ numberOfRandomButtons, tmp188,
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:402:         if (!numberOfRandomButtons)
	bne	.L50		@,
.L54:
@ C_Code.c:404:             numberOfRandomButtons = 1;
	movs	r3, #1	@ numberOfRandomButtons,
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
.L42:
	ldr	r3, .L65+20	@ tmp204,
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	movs	r6, #0	@ i,
@ C_Code.c:391:         int oppDir = 0;
	movs	r7, #0	@ oppDir,
@ C_Code.c:385:     int keys = proc->buttonsToPress;
	movs	r5, #0	@ keys,
@ C_Code.c:392:         int size = 5; // -1 since we count from 0
	movs	r4, #5	@ size,
	mov	r9, r3	@ tmp204, tmp204
	b	.L49		@
.L45:
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	adds	r6, r6, #1	@ i,
@ C_Code.c:442:             keys |= button;
	orrs	r5, r0	@ keys, button
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	cmp	r8, r6	@ numberOfRandomButtons, i
	ble	.L64		@,
.L49:
@ C_Code.c:409:             num = NextRN_N(size);
	movs	r0, r4	@, size
	bl	.L67		@
@ C_Code.c:410:             button = KeysList[num];
	mov	r3, sp	@ tmp230,
	ldrb	r0, [r3, r0]	@ button, KeysList
@ C_Code.c:413:             if (button & 0xF0)
	cmp	r0, #15	@ button,
	bls	.L45		@,
@ C_Code.c:415:                 if (button == DPAD_RIGHT)
	cmp	r0, #16	@ button,
	beq	.L56		@,
@ C_Code.c:419:                 if (button == DPAD_LEFT)
	cmp	r0, #32	@ button,
	beq	.L57		@,
@ C_Code.c:423:                 if (button == DPAD_UP)
	cmp	r0, #64	@ button,
	beq	.L58		@,
@ C_Code.c:427:                 if (button == DPAD_DOWN)
	cmp	r0, #128	@ button,
	bne	.L46		@,
@ C_Code.c:429:                     oppDir = DPAD_UP;
	movs	r7, #64	@ oppDir,
.L46:
@ C_Code.c:431:                 for (int c = 0; c <= size; ++c)
	cmp	r4, #0	@ size,
	blt	.L45		@,
	mov	r2, sp	@ ivtmp.103,
@ C_Code.c:431:                 for (int c = 0; c <= size; ++c)
	movs	r3, #0	@ c,
	b	.L48		@
.L47:
@ C_Code.c:431:                 for (int c = 0; c <= size; ++c)
	adds	r3, r3, #1	@ c,
@ C_Code.c:431:                 for (int c = 0; c <= size; ++c)
	adds	r2, r2, #1	@ ivtmp.103,
	cmp	r3, r4	@ c, size
	bgt	.L45		@,
.L48:
@ C_Code.c:433:                     if (KeysList[c] == oppDir)
	ldrb	r1, [r2]	@ _10, MEM[(unsigned char *)_15]
@ C_Code.c:433:                     if (KeysList[c] == oppDir)
	cmp	r1, r7	@ _10, oppDir
	bne	.L47		@,
@ C_Code.c:435:                         KeysList[c] = KeysList[size];
	mov	r2, sp	@ tmp231,
@ C_Code.c:435:                         KeysList[c] = KeysList[size];
	mov	r1, sp	@ tmp232,
@ C_Code.c:435:                         KeysList[c] = KeysList[size];
	ldrb	r2, [r2, r4]	@ _11, KeysList
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	adds	r6, r6, #1	@ i,
@ C_Code.c:435:                         KeysList[c] = KeysList[size];
	strb	r2, [r1, r3]	@ _11, KeysList[c_66]
@ C_Code.c:436:                         size--;
	subs	r4, r4, #1	@ size,
@ C_Code.c:442:             keys |= button;
	orrs	r5, r0	@ keys, button
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	cmp	r8, r6	@ numberOfRandomButtons, i
	bgt	.L49		@,
.L64:
@ C_Code.c:444:         proc->buttonsToPress = keys;
	lsls	r3, r5, #16	@ tmp198, keys,
	lsrs	r3, r3, #16	@ prephitmp_56, tmp198,
.L44:
	movs	r2, #80	@ tmp199,
	mov	r1, r10	@ proc, proc
	strh	r3, [r1, r2]	@ prephitmp_56, proc_31(D)->buttonsToPress
	b	.L37		@
.L50:
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	mov	r3, r8	@ numberOfRandomButtons, numberOfRandomButtons
	cmp	r3, #0	@ numberOfRandomButtons,
	bgt	.L42		@,
	movs	r3, #0	@ prephitmp_56,
	b	.L44		@
.L56:
@ C_Code.c:417:                     oppDir = DPAD_LEFT;
	movs	r7, #32	@ oppDir,
	b	.L46		@
.L57:
@ C_Code.c:421:                     oppDir = DPAD_RIGHT;
	movs	r7, #16	@ oppDir,
	b	.L46		@
.L58:
@ C_Code.c:425:                     oppDir = DPAD_DOWN;
	movs	r7, #128	@ oppDir,
	b	.L46		@
.L40:
@ C_Code.c:400:             numberOfRandomButtons = numberOfRandomButtons / 2;
	asrs	r3, r4, #1	@ numberOfRandomButtons, _6,
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:402:         if (!numberOfRandomButtons)
	cmp	r3, #0	@ numberOfRandomButtons,
	bgt	.L42		@,
	b	.L54		@
.L63:
	movs	r3, #1	@ _13,
	b	.L41		@
.L66:
	.align	2
.L65:
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
	.type	DrawButtonsToPress.part.0, %function
DrawButtonsToPress.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r10	@,
	mov	r7, r9	@,
	mov	r6, r8	@,
	push	{r6, r7, lr}	@
	sub	sp, sp, #16	@,,
@ C_Code.c:544: void DrawButtonsToPress(TimedHitsProc * proc, int x, int y, int palID)
	movs	r6, r3	@ palID, palID
	movs	r7, r0	@ proc, proc
	movs	r5, r1	@ x, x
	str	r2, [sp, #12]	@ y, %sfp
@ C_Code.c:550:     int keys = GetButtonsToPress(proc);
	bl	GetButtonsToPress		@
@ C_Code.c:552:     if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldr	r3, .L121	@ tmp155,
@ C_Code.c:552:     if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldr	r3, [r3]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
@ C_Code.c:550:     int keys = GetButtonsToPress(proc);
	movs	r4, r0	@ keys,
@ C_Code.c:552:     if (ChangePaletteWhenButtonIsPressed && proc->frame)
	cmp	r3, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L71		@,
@ C_Code.c:552:     if (ChangePaletteWhenButtonIsPressed && proc->frame)
	movs	r3, #75	@ tmp159,
@ C_Code.c:552:     if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldrb	r3, [r7, r3]	@ tmp160,
	cmp	r3, #0	@ tmp160,
	bne	.L113		@,
.L71:
@ C_Code.c:557:     int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); // OAM2_CHR(0);
	lsls	r6, r6, #28	@ tmp158, palID,
	lsrs	r3, r6, #16	@ _80, tmp158,
	mov	r9, r3	@ _80, _80
.L70:
@ C_Code.c:558:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2);
	movs	r3, #255	@ tmp161,
	ldr	r7, .L121+4	@ tmp230,
	ldr	r2, [sp, #12]	@ _11, %sfp
	mov	r0, r9	@ _80, _80
	ands	r2, r3	@ _11, tmp161
	movs	r3, r7	@ tmp163, tmp230
	lsls	r1, r5, #23	@ tmp165, x,
	ldr	r6, .L121+8	@ tmp231,
	str	r0, [sp]	@ _80,
	adds	r3, r3, #32	@ tmp163,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _9, tmp165,
	mov	r8, r2	@ _11, _11
	bl	.L123		@
@ C_Code.c:559:     x += 32;
	movs	r1, r5	@ x_12, x
@ C_Code.c:560:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2);
	mov	r2, r9	@ _80, _80
	movs	r3, r7	@ tmp168, tmp230
@ C_Code.c:559:     x += 32;
	adds	r1, r1, #32	@ x_12,
@ C_Code.c:560:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2);
	lsls	r1, r1, #23	@ tmp171, x_12,
	movs	r0, #2	@,
	str	r2, [sp]	@ _80,
	adds	r3, r3, #40	@ tmp168,
	mov	r2, r8	@, _11
	lsrs	r1, r1, #23	@ _13, tmp171,
	bl	.L123		@
@ C_Code.c:558:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2);
	mov	r10, r6	@ tmp231, tmp231
@ C_Code.c:561:     y += 16;
	ldr	r6, [sp, #12]	@ y, %sfp
	movs	r3, r7	@ ivtmp.117, tmp230
	movs	r0, r7	@ _76, tmp230
	adds	r6, r6, #16	@ y,
	mov	r8, r6	@ y, y
@ C_Code.c:452:     int c = 0;
	movs	r2, #0	@ c,
	adds	r3, r3, #48	@ ivtmp.117,
	adds	r0, r0, #54	@ _76,
.L73:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r1, [r3]	@ _7, MEM[(unsigned char *)_98]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r1, r4	@ _84, keys
@ C_Code.c:457:             c++;
	subs	r6, r1, #1	@ tmp234, _84
	sbcs	r1, r1, r6	@ tmp233, _84, tmp234
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r3, r3, #1	@ ivtmp.117,
@ C_Code.c:457:             c++;
	adds	r2, r2, r1	@ c, c, tmp233
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r3, r0	@ ivtmp.117, _76
	bne	.L73		@,
@ C_Code.c:565:     if (count == 1)
	cmp	r2, #1	@ c,
	bne	.LCB673	@
	b	.L114	@long jump	@
.LCB673:
@ C_Code.c:569:     if (count == 2)
	cmp	r2, #2	@ c,
	beq	.L76		@,
@ C_Code.c:562:     x -= 36;
	subs	r5, r5, #4	@ x,
.L75:
@ C_Code.c:578:     if (keys & A_BUTTON)
	lsls	r3, r4, #31	@ tmp241, keys,
	bmi	.L115		@,
.L77:
@ C_Code.c:583:     if (keys & B_BUTTON)
	lsls	r3, r4, #30	@ tmp242, keys,
	bmi	.L116		@,
.L78:
@ C_Code.c:588:     if (keys & DPAD_LEFT)
	lsls	r3, r4, #26	@ tmp243, keys,
	bmi	.L117		@,
.L79:
@ C_Code.c:593:     if (keys & DPAD_RIGHT)
	lsls	r3, r4, #27	@ tmp244, keys,
	bmi	.L118		@,
.L80:
@ C_Code.c:598:     if (keys & DPAD_UP)
	lsls	r3, r4, #25	@ tmp245, keys,
	bmi	.L119		@,
.L81:
@ C_Code.c:603:     if (keys & DPAD_DOWN)
	lsls	r4, r4, #24	@ tmp246, keys,
	bmi	.L120		@,
.L68:
@ C_Code.c:608: }
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L113:
	movs	r3, #224	@ _80,
	lsls	r3, r3, #8	@ _80, _80,
	mov	r9, r3	@ _80, _80
	b	.L70		@
.L76:
@ C_Code.c:571:         x += 8;
	adds	r5, r5, #4	@ x,
@ C_Code.c:578:     if (keys & A_BUTTON)
	lsls	r3, r4, #31	@ tmp241, keys,
	bpl	.L77		@,
.L115:
@ C_Code.c:580:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp180,
	mov	r0, r9	@ _80, _80
	movs	r3, r7	@ tmp179, tmp230
	ands	r2, r1	@ _29, y
	lsls	r1, r5, #23	@ tmp183, x,
	str	r0, [sp]	@ _80,
	adds	r3, r3, #56	@ tmp179,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _28, tmp183,
	bl	.L124		@
@ C_Code.c:581:         x += 18;
	adds	r5, r5, #18	@ x,
@ C_Code.c:583:     if (keys & B_BUTTON)
	lsls	r3, r4, #30	@ tmp242, keys,
	bpl	.L78		@,
.L116:
@ C_Code.c:585:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp189,
	mov	r0, r9	@ _80, _80
	movs	r3, r7	@ tmp188, tmp230
	ands	r2, r1	@ _34, y
	lsls	r1, r5, #23	@ tmp192, x,
	str	r0, [sp]	@ _80,
	adds	r3, r3, #64	@ tmp188,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _33, tmp192,
	bl	.L124		@
@ C_Code.c:586:         x += 18;
	adds	r5, r5, #18	@ x,
@ C_Code.c:588:     if (keys & DPAD_LEFT)
	lsls	r3, r4, #26	@ tmp243, keys,
	bpl	.L79		@,
.L117:
@ C_Code.c:590:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp198,
	mov	r0, r9	@ _80, _80
	movs	r3, r7	@ tmp197, tmp230
	ands	r2, r1	@ _39, y
	lsls	r1, r5, #23	@ tmp201, x,
	str	r0, [sp]	@ _80,
	adds	r3, r3, #72	@ tmp197,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _38, tmp201,
	bl	.L124		@
@ C_Code.c:591:         x += 18;
	adds	r5, r5, #18	@ x,
@ C_Code.c:593:     if (keys & DPAD_RIGHT)
	lsls	r3, r4, #27	@ tmp244, keys,
	bpl	.L80		@,
.L118:
@ C_Code.c:595:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp207,
	mov	r0, r9	@ _80, _80
	movs	r3, r7	@ tmp206, tmp230
	ands	r2, r1	@ _44, y
	lsls	r1, r5, #23	@ tmp210, x,
	str	r0, [sp]	@ _80,
	adds	r3, r3, #80	@ tmp206,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _43, tmp210,
	bl	.L124		@
@ C_Code.c:596:         x += 18;
	adds	r5, r5, #18	@ x,
@ C_Code.c:598:     if (keys & DPAD_UP)
	lsls	r3, r4, #25	@ tmp245, keys,
	bpl	.L81		@,
.L119:
@ C_Code.c:600:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp216,
	mov	r0, r9	@ _80, _80
	movs	r3, r7	@ tmp215, tmp230
	ands	r2, r1	@ _49, y
	lsls	r1, r5, #23	@ tmp219, x,
	str	r0, [sp]	@ _80,
	adds	r3, r3, #88	@ tmp215,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _48, tmp219,
	bl	.L124		@
@ C_Code.c:601:         x += 18;
	adds	r5, r5, #18	@ x,
@ C_Code.c:603:     if (keys & DPAD_DOWN)
	lsls	r4, r4, #24	@ tmp246, keys,
	bpl	.L68		@,
.L120:
@ C_Code.c:605:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2);
	mov	r1, r8	@ y, y
	mov	r0, r9	@ _80, _80
	movs	r3, r7	@ tmp230, tmp230
	movs	r2, #255	@ tmp225,
	lsls	r5, r5, #23	@ tmp228, x,
	str	r0, [sp]	@ _80,
	ands	r2, r1	@ _54, y
	movs	r0, #2	@,
	adds	r3, r3, #96	@ tmp230,
	lsrs	r1, r5, #23	@ _53, tmp228,
	bl	.L124		@
	b	.L68		@
.L114:
@ C_Code.c:567:         x += 16;
	adds	r5, r5, #12	@ x,
	b	.L75		@
.L122:
	.align	2
.L121:
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
	push	{r4, r5, lr}	@
@ C_Code.c:451: {
	movs	r4, r0	@ keys, keys
	ldr	r0, .L131	@ tmp122,
	movs	r2, r0	@ ivtmp.128, tmp122
@ C_Code.c:452:     int c = 0;
	movs	r1, #0	@ <retval>,
	adds	r2, r2, #48	@ ivtmp.128,
	adds	r0, r0, #54	@ _15,
.L127:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ _21, MEM[(unsigned char *)_36]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _22, keys
@ C_Code.c:457:             c++;
	subs	r5, r3, #1	@ tmp128, _22
	sbcs	r3, r3, r5	@ tmp127, _22, tmp128
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.128,
@ C_Code.c:457:             c++;
	adds	r1, r1, r3	@ <retval>, <retval>, tmp127
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r2, r0	@ ivtmp.128, _15
	bne	.L127		@,
@ C_Code.c:461: }
	@ sp needed	@
	movs	r0, r1	@, <retval>
	pop	{r4, r5}
	pop	{r1}
	bx	r1
.L132:
	.align	2
.L131:
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #12	@,,
@ C_Code.c:464: {
	movs	r4, r1	@ keys, keys
@ C_Code.c:465:     int reqKeys = GetButtonsToPress(proc);
	bl	GetButtonsToPress		@
	mov	ip, r0	@ reqKeys,
	ldr	r0, .L160	@ tmp150,
	movs	r2, r0	@ ivtmp.151, tmp150
	adds	r2, r2, #48	@ ivtmp.151,
@ C_Code.c:466:     int count = CountKeysPressed(reqKeys);
	movs	r1, r2	@ ivtmp.163, ivtmp.151
@ C_Code.c:452:     int c = 0;
	movs	r5, #0	@ c,
	adds	r0, r0, #54	@ _39,
.L135:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	mov	r6, ip	@ reqKeys, reqKeys
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r3, [r1]	@ _112, MEM[(unsigned char *)_158]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r3, r6	@ _113, reqKeys
@ C_Code.c:457:             c++;
	subs	r7, r3, #1	@ tmp169, _113
	sbcs	r3, r3, r7	@ tmp168, _113, tmp169
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r1, r1, #1	@ ivtmp.163,
@ C_Code.c:457:             c++;
	adds	r5, r5, r3	@ c, c, tmp168
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r0, r1	@ _39, ivtmp.163
	bne	.L135		@,
	movs	r1, r2	@ ivtmp.157, ivtmp.151
@ C_Code.c:452:     int c = 0;
	movs	r7, #0	@ c,
.L137:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r3, [r1]	@ _97, MEM[(unsigned char *)_128]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _98, keys
@ C_Code.c:457:             c++;
	subs	r6, r3, #1	@ tmp172, _98
	sbcs	r3, r3, r6	@ tmp171, _98, tmp172
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r1, r1, #1	@ ivtmp.157,
@ C_Code.c:457:             c++;
	adds	r7, r7, r3	@ c, c, tmp171
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r0, r1	@ _39, ivtmp.157
	bne	.L137		@,
@ C_Code.c:452:     int c = 0;
	movs	r1, #0	@ c,
@ C_Code.c:467:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r5, r7	@ c, c
	blt	.L138		@,
.L140:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ _16, MEM[(unsigned char *)_88]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _51, keys
@ C_Code.c:457:             c++;
	subs	r7, r3, #1	@ tmp175, _51
	sbcs	r3, r3, r7	@ tmp174, _51, tmp175
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.151,
@ C_Code.c:457:             c++;
	adds	r1, r1, r3	@ c, c, tmp174
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r0, r2	@ _39, ivtmp.151
	bne	.L140		@,
@ C_Code.c:467:     if (ABS(count - CountKeysPressed(keys)) > 1)
	subs	r1, r5, r1	@ _3, c, c
@ C_Code.c:467:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r1, #1	@ _3,
	bgt	.L159		@,
.L142:
@ C_Code.c:471:     reqKeys &= ~keys; // only 0 if we hit all the correct keys (and possibly 1 extra)
	mov	r6, ip	@ reqKeys, reqKeys
	bics	r6, r4	@ reqKeys, keys
@ C_Code.c:472:     return (!reqKeys);
	rsbs	r0, r6, #0	@ <retval>, reqKeys_20
	adcs	r0, r0, r6	@ <retval>, reqKeys_20
.L133:
@ C_Code.c:473: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L138:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ _82, MEM[(unsigned char *)_69]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _83, keys
@ C_Code.c:457:             c++;
	subs	r7, r3, #1	@ tmp178, _83
	sbcs	r3, r3, r7	@ tmp177, _83, tmp178
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.151,
@ C_Code.c:457:             c++;
	adds	r1, r1, r3	@ c, c, tmp177
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r0, r2	@ _39, ivtmp.151
	bne	.L138		@,
@ C_Code.c:469:         return false;
	movs	r0, #0	@ <retval>,
@ C_Code.c:467:     if (ABS(count - CountKeysPressed(keys)) > 1)
	subs	r1, r1, r5	@ _4, c, c
@ C_Code.c:467:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r1, #1	@ _4,
	bgt	.L133		@,
	b	.L142		@
.L159:
@ C_Code.c:469:         return false;
	movs	r0, #0	@ <retval>,
	b	.L133		@
.L161:
	.align	2
.L160:
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
@ C_Code.c:476:     struct Anim * anim = proc->anim;
	ldr	r2, [r0, #44]	@ anim, proc_16(D)->anim
@ C_Code.c:475: {
	push	{r4, r5, r6, lr}	@
@ C_Code.c:475: {
	movs	r4, r0	@ proc, proc
@ C_Code.c:477:     u32 instruction = *anim->pScrCurrent++;
	ldr	r0, [r2, #32]	@ _1, anim_17->pScrCurrent
@ C_Code.c:477:     u32 instruction = *anim->pScrCurrent++;
	ldr	r3, [r0]	@ instruction, *_1
	mov	ip, r3	@ instruction, instruction
@ C_Code.c:478:     if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND)
	movs	r3, #252	@ tmp130,
	mov	r5, ip	@ instruction, instruction
	lsls	r3, r3, #22	@ tmp130, tmp130,
	ands	r3, r5	@ _7, instruction
	movs	r5, #160	@ tmp131,
	lsls	r5, r5, #19	@ tmp131, tmp131,
	cmp	r3, r5	@ _7, tmp131
	beq	.L169		@,
.L163:
@ C_Code.c:491:     instruction = *anim->pScrCurrent--;
	str	r0, [r2, #32]	@ _1, anim_17->pScrCurrent
@ C_Code.c:492:     if (PressedSpecificKeys(proc, keys))
	movs	r0, r4	@, proc
	bl	PressedSpecificKeys		@
@ C_Code.c:492:     if (PressedSpecificKeys(proc, keys))
	cmp	r0, #0	@ _8,
	beq	.L162		@,
@ C_Code.c:494:         if (!proc->frame)
	movs	r3, #75	@ tmp145,
@ C_Code.c:494:         if (!proc->frame)
	ldrb	r2, [r4, r3]	@ tmp146,
	cmp	r2, #0	@ tmp146,
	beq	.L170		@,
.L162:
@ C_Code.c:500: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L169:
@ C_Code.c:480:         if (ANINS_COMMAND_GET_ID(instruction) == 4)
	movs	r3, #255	@ tmp132,
	mov	r5, ip	@ instruction, instruction
	ands	r3, r5	@ _2, instruction
@ C_Code.c:480:         if (ANINS_COMMAND_GET_ID(instruction) == 4)
	cmp	r3, #4	@ _2,
	beq	.L171		@,
@ C_Code.c:485:         if (ANINS_COMMAND_GET_ID(instruction) == 0xF)
	cmp	r3, #15	@ _2,
	bne	.L163		@,
@ C_Code.c:487:             proc->codefframe = proc->timer;
	ldr	r5, [r4, #52]	@ proc_16(D)->timer, proc_16(D)->timer
	adds	r3, r3, #62	@ tmp141,
	strb	r5, [r4, r3]	@ proc_16(D)->timer, proc_16(D)->codefframe
@ C_Code.c:488:             proc->timer2 = 0;
	movs	r5, #0	@ tmp143,
	subs	r3, r3, #9	@ tmp142,
	strb	r5, [r4, r3]	@ tmp143, proc_16(D)->timer2
	b	.L163		@
.L170:
@ C_Code.c:497:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	movs	r1, #128	@,
	movs	r0, #159	@,
@ C_Code.c:496:             proc->frame = proc->timer;     // locate is side for stereo?
	ldr	r2, [r4, #52]	@ proc_16(D)->timer, proc_16(D)->timer
@ C_Code.c:497:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	lsls	r1, r1, #1	@,,
@ C_Code.c:496:             proc->frame = proc->timer;     // locate is side for stereo?
	strb	r2, [r4, r3]	@ proc_16(D)->timer, proc_16(D)->frame
@ C_Code.c:497:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	lsls	r0, r0, #1	@,,
	movs	r2, #120	@,
	ldr	r4, .L172	@ tmp152,
	subs	r3, r3, #74	@,
	bl	.L174		@
@ C_Code.c:500: }
	b	.L162		@
.L171:
@ C_Code.c:482:             proc->code4frame = proc->timer;
	ldr	r5, [r4, #52]	@ proc_16(D)->timer, proc_16(D)->timer
	adds	r3, r3, #72	@ tmp135,
	strb	r5, [r4, r3]	@ proc_16(D)->timer, proc_16(D)->code4frame
@ C_Code.c:483:             proc->timer2 = 0;
	movs	r5, #0	@ tmp137,
	subs	r3, r3, #8	@ tmp136,
	strb	r5, [r4, r3]	@ tmp137, proc_16(D)->timer2
	b	.L163		@
.L173:
	.align	2
.L172:
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
@ C_Code.c:503:     if (proc->frame)
	movs	r3, #75	@ tmp128,
@ C_Code.c:502: {
	push	{r4, lr}	@
@ C_Code.c:503:     if (proc->frame)
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:503:     if (proc->frame)
	cmp	r3, #0	@ _1,
	beq	.L175		@,
@ C_Code.c:505:         if (proc->codefframe != 0xFF)
	movs	r2, #77	@ tmp129,
@ C_Code.c:507:             if (ABS(proc->codefframe - proc->frame) < (LenienceFrames))
	ldr	r1, .L186	@ tmp130,
@ C_Code.c:505:         if (proc->codefframe != 0xFF)
	ldrb	r2, [r0, r2]	@ _2,
@ C_Code.c:507:             if (ABS(proc->codefframe - proc->frame) < (LenienceFrames))
	ldr	r1, [r1]	@ pretmp_34, LenienceFrames
@ C_Code.c:505:         if (proc->codefframe != 0xFF)
	cmp	r2, #255	@ _2,
	beq	.L178		@,
.L185:
@ C_Code.c:507:             if (ABS(proc->codefframe - proc->frame) < (LenienceFrames))
	subs	r2, r2, r3	@ _5, _2, _1
	asrs	r4, r2, #31	@ tmp147, _5,
	adds	r2, r2, r4	@ _6, _5, tmp147
	eors	r2, r4	@ _6, tmp147
@ C_Code.c:507:             if (ABS(proc->codefframe - proc->frame) < (LenienceFrames))
	cmp	r2, r1	@ _6, pretmp_34
	bge	.L179		@,
@ C_Code.c:509:                 proc->hitOnTime = true;
	movs	r2, #69	@ tmp133,
	movs	r4, #1	@ tmp134,
	strb	r4, [r0, r2]	@ tmp134, proc_21(D)->hitOnTime
.L179:
@ C_Code.c:519:         if ((proc->timer - proc->frame) < LenienceFrames)
	ldr	r2, [r0, #52]	@ proc_21(D)->timer, proc_21(D)->timer
	subs	r3, r2, r3	@ _16, proc_21(D)->timer, _1
@ C_Code.c:519:         if ((proc->timer - proc->frame) < LenienceFrames)
	cmp	r3, r1	@ _16, pretmp_34
	bge	.L175		@,
@ C_Code.c:521:             proc->hitOnTime = true;
	movs	r3, #69	@ tmp141,
	movs	r2, #1	@ tmp142,
	strb	r2, [r0, r3]	@ tmp142, proc_21(D)->hitOnTime
.L175:
@ C_Code.c:524: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L178:
@ C_Code.c:512:         else if (proc->code4frame != 0xFF)
	movs	r2, #76	@ tmp136,
	ldrb	r2, [r0, r2]	@ _8,
@ C_Code.c:512:         else if (proc->code4frame != 0xFF)
	cmp	r2, #255	@ _8,
	bne	.L185		@,
	b	.L179		@
.L187:
	.align	2
.L186:
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
@ C_Code.c:528:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L189	@ tmp118,
@ C_Code.c:529: }
	@ sp needed	@
@ C_Code.c:528:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldrb	r0, [r3, #31]	@ tmp120,
	movs	r3, #127	@ tmp122,
	bics	r0, r3	@ _3, tmp122
@ C_Code.c:529: }
	bx	lr
.L190:
	.align	2
.L189:
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
@ C_Code.c:528:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L195	@ tmp120,
@ C_Code.c:533:     if (CheatCodeOn())
	ldrb	r3, [r3, #31]	@ tmp123,
	cmp	r3, #127	@ tmp123,
	bhi	.L194		@,
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r3, .L195+4	@ tmp124,
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L194		@,
@ C_Code.c:541:     return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp126,
	ldrb	r0, [r0, r3]	@ <retval>,
	b	.L191		@
.L194:
@ C_Code.c:535:         return true;
	movs	r0, #1	@ <retval>,
.L191:
@ C_Code.c:542: }
	@ sp needed	@
	bx	lr
.L196:
	.align	2
.L195:
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
@ C_Code.c:546:     if (!DisplayPress)
	ldr	r4, .L202	@ tmp119,
@ C_Code.c:546:     if (!DisplayPress)
	ldr	r4, [r4]	@ DisplayPress, DisplayPress
	cmp	r4, #0	@ DisplayPress,
	beq	.L197		@,
	bl	DrawButtonsToPress.part.0		@
.L197:
@ C_Code.c:608: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L203:
	.align	2
.L202:
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
@ C_Code.c:728:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r1, #11	@ _29,
	movs	r3, #192	@ tmp132,
	ldrsb	r1, [r0, r1]	@ _29,* _29
	ands	r3, r1	@ _30, _29
@ C_Code.c:726:     if (success)
	cmp	r2, #0	@ success,
	beq	.L205		@,
@ C_Code.c:728:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _30,
	beq	.L213		@,
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L214	@ tmp136,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam.25_16, TimedHitsDifficultyRam
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.25_16, *TimedHitsDifficultyRam.25_16
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r2, r3, #26	@ tmp165, *TimedHitsDifficultyRam.25_16,
	bmi	.L208		@,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r2, .L214+4	@ tmp146,
	ldr	r2, [r2]	@ DifficultyThreshold.27_21, DifficultyThreshold
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r3, r3, #27	@ tmp151, *TimedHitsDifficultyRam.25_16,
	lsrs	r3, r3, #27	@ _20, tmp151,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r3, r2	@ _20, DifficultyThreshold.27_21
	bge	.L209		@,
@ C_Code.c:742:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r3, .L214+8	@ tmp154,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r2, r3	@ DifficultyThreshold.27_21, NumberOfRandomButtons
	bgt	.L208		@,
.L209:
@ C_Code.c:744:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r2, .L214+12	@ tmp156,
	ldr	r3, .L214+16	@ tmp157,
	ldr	r0, [r2]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r3, [r3]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r0, r0, r3	@ <retval>, BonusDamagePercent, DifficultyBonusPercent
	b	.L204		@
.L205:
@ C_Code.c:749:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _30,
	beq	.L211		@,
@ C_Code.c:753:     return FailedHitDamagePercent;
	ldr	r3, .L214+20	@ tmp161,
	ldr	r0, [r3]	@ <retval>,
.L204:
@ C_Code.c:754: }
	@ sp needed	@
	bx	lr
.L213:
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r3, .L214+24	@ tmp133,
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L211		@,
@ C_Code.c:732:                 return ReducedDamagePercent;
	ldr	r3, .L214+28	@ tmp135,
	ldr	r0, [r3]	@ <retval>,
	b	.L204		@
.L211:
@ C_Code.c:736:                 return 100;
	movs	r0, #100	@ <retval>,
	b	.L204		@
.L208:
@ C_Code.c:747:         return BonusDamagePercent;
	ldr	r3, .L214+12	@ tmp160,
	ldr	r0, [r3]	@ <retval>,
	b	.L204		@
.L215:
	.align	2
.L214:
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
	.type	GetDamagePercent, %function
GetDamagePercent:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:728:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r1, #11	@ _11,
	movs	r3, #192	@ tmp132,
	ldrsb	r1, [r0, r1]	@ _11,* _11
	ands	r3, r1	@ _5, _11
@ C_Code.c:726:     if (success)
	cmp	r2, #0	@ success,
	beq	.L217		@,
@ C_Code.c:728:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _5,
	beq	.L225		@,
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L226	@ tmp136,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam.25_17, TimedHitsDifficultyRam
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.25_17, *TimedHitsDifficultyRam.25_17
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r2, r3, #26	@ tmp165, *TimedHitsDifficultyRam.25_17,
	bmi	.L220		@,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r2, .L226+4	@ tmp146,
	ldr	r2, [r2]	@ DifficultyThreshold.27_22, DifficultyThreshold
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r3, r3, #27	@ tmp151, *TimedHitsDifficultyRam.25_17,
	lsrs	r3, r3, #27	@ _21, tmp151,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r3, r2	@ _21, DifficultyThreshold.27_22
	bge	.L221		@,
@ C_Code.c:742:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r3, .L226+8	@ tmp154,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r2, r3	@ DifficultyThreshold.27_22, NumberOfRandomButtons
	bgt	.L220		@,
.L221:
@ C_Code.c:744:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r2, .L226+12	@ tmp156,
	ldr	r3, .L226+16	@ tmp157,
	ldr	r0, [r2]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r3, [r3]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r0, r0, r3	@ <retval>, BonusDamagePercent, DifficultyBonusPercent
	b	.L216		@
.L217:
@ C_Code.c:749:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _5,
	beq	.L223		@,
@ C_Code.c:753:     return FailedHitDamagePercent;
	ldr	r3, .L226+20	@ tmp161,
	ldr	r0, [r3]	@ <retval>,
.L216:
@ C_Code.c:759: }
	@ sp needed	@
	bx	lr
.L225:
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r3, .L226+24	@ tmp133,
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L223		@,
@ C_Code.c:732:                 return ReducedDamagePercent;
	ldr	r3, .L226+28	@ tmp135,
	ldr	r0, [r3]	@ <retval>,
	b	.L216		@
.L223:
@ C_Code.c:736:                 return 100;
	movs	r0, #100	@ <retval>,
@ C_Code.c:758:     return GetDefaultDamagePercent(active_bunit, opp_bunit, success);
	b	.L216		@
.L220:
@ C_Code.c:747:         return BonusDamagePercent;
	ldr	r3, .L226+12	@ tmp160,
	ldr	r0, [r3]	@ <retval>,
	b	.L216		@
.L227:
	.align	2
.L226:
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
	.type	AdjustCurrentRound, %function
AdjustCurrentRound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}	@
@ C_Code.c:772: {
	movs	r4, r1	@ difference, difference
@ C_Code.c:774:     for (int i = id; i < 22; i += 2)
	cmp	r0, #21	@ id,
	bgt	.L228		@,
	ldr	r3, .L238	@ tmp128,
	lsls	r2, r0, #1	@ _13, id,
@ C_Code.c:777:         if (hp == 0xffff)
	ldr	r5, .L238+4	@ tmp129,
	adds	r2, r2, r3	@ ivtmp.193, _13, tmp128
	b	.L232		@
.L230:
	movs	r1, #0	@ _4,
@ C_Code.c:793:         else if (hp >= difference)
	cmp	r3, r4	@ _1, difference
	blt	.L231		@,
@ C_Code.c:795:             gEfxHpLut[i] -= difference;
	subs	r3, r3, r4	@ tmp132, _1, difference
.L236:
	lsls	r3, r3, #16	@ tmp133, tmp132,
	lsrs	r1, r3, #16	@ _4, tmp133,
.L231:
@ C_Code.c:774:     for (int i = id; i < 22; i += 2)
	adds	r0, r0, #2	@ id,
@ C_Code.c:790:                 gEfxHpLut[i] = 0;
	strh	r1, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:774:     for (int i = id; i < 22; i += 2)
	adds	r2, r2, #4	@ ivtmp.193,
	cmp	r0, #21	@ id,
	bgt	.L228		@,
.L232:
@ C_Code.c:776:         hp = gEfxHpLut[i];
	ldrh	r3, [r2]	@ _1, MEM[(short unsigned int *)_18]
@ C_Code.c:777:         if (hp == 0xffff)
	cmp	r3, r5	@ _1, tmp129
	beq	.L228		@,
@ C_Code.c:781:         if (difference < 0)
	cmp	r4, #0	@ difference,
	bge	.L230		@,
@ C_Code.c:783:             hp += difference;
	adds	r3, r3, r4	@ hp, _1, difference
	movs	r1, #0	@ _4,
@ C_Code.c:784:             if (hp > 0)
	cmp	r3, #0	@ hp,
	bgt	.L236		@,
@ C_Code.c:774:     for (int i = id; i < 22; i += 2)
	adds	r0, r0, #2	@ id,
@ C_Code.c:790:                 gEfxHpLut[i] = 0;
	strh	r1, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:774:     for (int i = id; i < 22; i += 2)
	adds	r2, r2, #4	@ ivtmp.193,
	cmp	r0, #21	@ id,
	ble	.L232		@,
.L228:
@ C_Code.c:802: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L239:
	.align	2
.L238:
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
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ C_Code.c:807: {
	mov	ip, r2	@ some_bunit, some_bunit
	movs	r6, r1	@ HpProc, HpProc
@ C_Code.c:812:     if (newHp > 127)
	cmp	r3, #127	@ newHp,
	ble	.L241		@,
	movs	r3, #127	@ _8,
.L242:
@ C_Code.c:816:     int hp = gEkrGaugeHp[side];
	ldr	r1, [sp, #16]	@ tmp166, side
	ldr	r2, .L252	@ tmp134,
	lsls	r1, r1, #1	@ tmp135, tmp166,
	ldrsh	r2, [r1, r2]	@ _1, gEkrGaugeHp
@ C_Code.c:817:     some_bunit->unit.curHP = newHp;
	mov	r1, ip	@ some_bunit, some_bunit
	strb	r3, [r1, #19]	@ _8, some_bunit_21(D)->unit.curHP
@ C_Code.c:818:     if (hp == newHp)
	cmp	r3, r2	@ _8, _1
	beq	.L240		@,
@ C_Code.c:825:         diff = 0 - newDamage;
	ldr	r1, [sp, #20]	@ tmp169, newDamage
	rsbs	r1, r1, #0	@ diff, tmp169
	mov	ip, r1	@ diff, diff
@ C_Code.c:823:     if (newDamage)
	ldr	r1, [sp, #20]	@ tmp170, newDamage
	cmp	r1, #0	@ tmp170,
	beq	.L250		@,
@ C_Code.c:828:     if (proc->side == side)
	movs	r1, #74	@ tmp137,
@ C_Code.c:828:     if (proc->side == side)
	ldr	r4, [sp, #16]	@ tmp172, side
@ C_Code.c:828:     if (proc->side == side)
	ldrb	r1, [r0, r1]	@ _4,
@ C_Code.c:828:     if (proc->side == side)
	cmp	r1, r4	@ _4, tmp172
	beq	.L251		@,
.L240:
@ C_Code.c:847: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L241:
@ C_Code.c:808:     if (newHp < 0)
	mvns	r2, r3	@ tmp154, newHp
	asrs	r2, r2, #31	@ tmp153, tmp154,
	ands	r3, r2	@ _8, tmp153
	b	.L242		@
.L250:
@ C_Code.c:822:     int diff = newHp - hp;
	subs	r1, r3, r2	@ diff, _8, _1
	mov	ip, r1	@ diff, diff
@ C_Code.c:828:     if (proc->side == side)
	movs	r1, #74	@ tmp137,
@ C_Code.c:828:     if (proc->side == side)
	ldr	r4, [sp, #16]	@ tmp172, side
@ C_Code.c:828:     if (proc->side == side)
	ldrb	r1, [r0, r1]	@ _4,
@ C_Code.c:828:     if (proc->side == side)
	cmp	r1, r4	@ _4, tmp172
	bne	.L240		@,
.L251:
@ C_Code.c:830:         HpProc->cur = hp;
	strh	r2, [r6, #46]	@ _1, HpProc_27(D)->cur
@ C_Code.c:831:         if (UsingSkillSys)
	ldr	r2, .L252+4	@ tmp140,
	ldr	r1, [r2]	@ UsingSkillSys.32_5, UsingSkillSys
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	mov	r2, ip	@ diff, diff
	asrs	r5, r2, #31	@ tmp162, diff,
	adds	r2, r2, r5	@ _39, diff, tmp162
	eors	r2, r5	@ _39, tmp162
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	lsls	r2, r2, #24	@ tmp142, _39,
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	ldr	r0, [r0, #56]	@ pretmp_40, proc_26(D)->currentRound
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	asrs	r2, r2, #24	@ _41, tmp142,
@ C_Code.c:831:         if (UsingSkillSys)
	cmp	r1, #0	@ UsingSkillSys.32_5,
	beq	.L248		@,
@ C_Code.c:833:             HpProc->post = newHp;
	movs	r5, #80	@ tmp177,
	strh	r3, [r6, r5]	@ _8, HpProc_27(D)->post
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r0, #3]	@ _41, pretmp_40->hpChange
@ C_Code.c:842:         if (UsingSkillSys == 2)
	cmp	r1, #2	@ UsingSkillSys.32_5,
	bne	.L240		@,
@ C_Code.c:844:             proc->currentRound->overDmg = diff;
	mov	r3, ip	@ diff, diff
	strh	r3, [r0, #6]	@ diff, pretmp_40->overDmg
	b	.L240		@
.L248:
@ C_Code.c:837:             HpProc->postHpAtkrSS = newHp >> 16;
	movs	r4, #82	@ tmp146,
	strh	r1, [r6, r4]	@ UsingSkillSys.32_5, HpProc_27(D)->postHpAtkrSS
@ C_Code.c:838:             HpProc->post = newHp;
	movs	r1, #80	@ tmp149,
	strh	r3, [r6, r1]	@ _8, HpProc_27(D)->post
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r0, #3]	@ _41, pretmp_40->hpChange
	b	.L240		@
.L253:
	.align	2
.L252:
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
	@ args = 12, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r8	@,
	movs	r5, r1	@ HpProc, HpProc
@ C_Code.c:855:     int side = proc->side;
	movs	r1, #74	@ tmp176,
@ C_Code.c:854: {
	push	{lr}	@
	sub	sp, sp, #8	@,,
@ C_Code.c:854: {
	mov	r8, r2	@ active_bunit, active_bunit
	movs	r2, r3	@ opp_bunit, opp_bunit
	ldr	r3, [sp, #36]	@ hp, hp
	movs	r4, r0	@ proc, proc
@ C_Code.c:855:     int side = proc->side;
	ldrb	r6, [r0, r1]	@ _1,
@ C_Code.c:857:     if (hp < 0)
	cmp	r3, #0	@ hp,
	bge	.L255		@,
@ C_Code.c:859:         hp = gEkrGaugeHp[side];
	ldr	r3, .L289	@ tmp177,
	lsls	r1, r6, #1	@ tmp178, _1,
@ C_Code.c:859:         hp = gEkrGaugeHp[side];
	ldrsh	r3, [r1, r3]	@ hp, gEkrGaugeHp
.L255:
@ C_Code.c:861:     if (hp <= 0)
	cmp	r3, #0	@ hp,
	ble	.L285		@,
@ C_Code.c:914:         HpProc->death = false;
	movs	r3, #41	@ tmp242,
	movs	r2, #0	@ tmp243,
	strb	r2, [r5, r3]	@ tmp243, HpProc_43(D)->death
.L264:
@ C_Code.c:920:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	movs	r0, #11	@ _16,
@ C_Code.c:920:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	ldr	r5, .L289+4	@ tmp245,
@ C_Code.c:920:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	ldr	r4, .L289+8	@ tmp274,
	ldrsb	r0, [r5, r0]	@ _16,* _16
	bl	.L174		@
@ C_Code.c:921:     if (UNIT_IS_VALID(unit))
	cmp	r0, #0	@ unit,
	beq	.L268		@,
@ C_Code.c:921:     if (UNIT_IS_VALID(unit))
	ldr	r3, [r0]	@ unit_68->pCharacterData, unit_68->pCharacterData
	cmp	r3, #0	@ unit_68->pCharacterData,
	beq	.L268		@,
@ C_Code.c:923:         gBattleActor.unit.exp = unit->exp;
	ldrb	r3, [r0, #9]	@ _18,
@ C_Code.c:923:         gBattleActor.unit.exp = unit->exp;
	strb	r3, [r5, #9]	@ _18, gBattleActor.unit.exp
@ C_Code.c:924:         gBattleActor.unit.level = unit->level;
	movs	r3, #8	@ _19,
	ldrsb	r3, [r0, r3]	@ _19,* _19
@ C_Code.c:924:         gBattleActor.unit.level = unit->level;
	strb	r3, [r5, #8]	@ _19, gBattleActor.unit.level
.L268:
@ C_Code.c:927:     unit = GetUnit(gBattleTarget.unit.index);
	movs	r0, #11	@ _21,
@ C_Code.c:927:     unit = GetUnit(gBattleTarget.unit.index);
	ldr	r5, .L289+12	@ tmp253,
@ C_Code.c:927:     unit = GetUnit(gBattleTarget.unit.index);
	ldrsb	r0, [r5, r0]	@ _21,* _21
	bl	.L174		@
@ C_Code.c:928:     if (UNIT_IS_VALID(unit))
	cmp	r0, #0	@ unit,
	beq	.L269		@,
@ C_Code.c:928:     if (UNIT_IS_VALID(unit))
	ldr	r3, [r0]	@ unit_72->pCharacterData, unit_72->pCharacterData
	cmp	r3, #0	@ unit_72->pCharacterData,
	beq	.L269		@,
@ C_Code.c:930:         gBattleTarget.unit.exp = unit->exp;
	ldrb	r3, [r0, #9]	@ _23,
@ C_Code.c:930:         gBattleTarget.unit.exp = unit->exp;
	strb	r3, [r5, #9]	@ _23, gBattleTarget.unit.exp
@ C_Code.c:931:         gBattleTarget.unit.level = unit->level;
	movs	r3, #8	@ _24,
	ldrsb	r3, [r0, r3]	@ _24,* _24
@ C_Code.c:931:         gBattleTarget.unit.level = unit->level;
	strb	r3, [r5, #8]	@ _24, gBattleTarget.unit.level
.L269:
@ C_Code.c:935:     BattleApplyExpGains(); // update exp
	ldr	r3, .L289+16	@ tmp261,
	bl	.L10		@
@ C_Code.c:936:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldr	r2, .L289+20	@ tmp264,
	ldr	r1, [r2]	@ gpEkrBattleUnitLeft, gpEkrBattleUnitLeft
	movs	r2, #110	@ tmp265,
@ C_Code.c:936:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldr	r3, .L289+24	@ tmp262,
@ C_Code.c:936:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldrsb	r1, [r1, r2]	@ tmp267,
@ C_Code.c:936:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	strh	r1, [r3]	@ tmp267, gBanimExpGain[0]
@ C_Code.c:937:     gBanimExpGain[1] = gpEkrBattleUnitRight->expGain;
	ldr	r1, .L289+28	@ tmp270,
	ldr	r1, [r1]	@ gpEkrBattleUnitRight, gpEkrBattleUnitRight
	ldrsb	r2, [r1, r2]	@ tmp273,
@ C_Code.c:937:     gBanimExpGain[1] = gpEkrBattleUnitRight->expGain;
	strh	r2, [r3, #2]	@ tmp273, gBanimExpGain[1]
@ C_Code.c:938: }
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L285:
@ C_Code.c:864:         UpdateHP(proc, HpProc, opp_bunit, hp, side, newDamage);
	ldr	r3, [sp, #40]	@ tmp298, newDamage
	movs	r1, r5	@, HpProc
	movs	r0, r4	@, proc
	str	r3, [sp, #4]	@ tmp298,
	str	r6, [sp]	@ _1,
	movs	r3, #0	@,
	bl	UpdateHP		@
@ C_Code.c:866:         proc->code4frame = 0xff;
	movs	r3, #76	@ tmp179,
	movs	r2, #255	@ tmp180,
@ C_Code.c:884:         struct SkillSysBattleHit * nextRound = GetCurrentRound(proc->roundId + 1);
	movs	r7, #70	@ tmp192,
@ C_Code.c:866:         proc->code4frame = 0xff;
	strb	r2, [r4, r3]	@ tmp180, proc_39(D)->code4frame
@ C_Code.c:871:         HpProc->death = true;
	subs	r3, r3, #35	@ tmp182,
	subs	r2, r2, #254	@ tmp183,
	strb	r2, [r5, r3]	@ tmp183, HpProc_43(D)->death
@ C_Code.c:882:         round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END;
	ldr	r3, [sp, #32]	@ tmp299, round
	ldrb	r3, [r3, #2]	@ tmp188,
	adds	r2, r2, #175	@ tmp185,
	orrs	r3, r2	@ tmp190, tmp185
	ldr	r2, [sp, #32]	@ tmp300, round
	strb	r3, [r2, #2]	@ tmp190,
@ C_Code.c:884:         struct SkillSysBattleHit * nextRound = GetCurrentRound(proc->roundId + 1);
	ldrb	r0, [r4, r7]	@ _6,
@ C_Code.c:884:         struct SkillSysBattleHit * nextRound = GetCurrentRound(proc->roundId + 1);
	ldr	r3, .L289+32	@ tmp195,
	adds	r0, r0, #1	@ _7,
	bl	.L10		@
@ C_Code.c:885:         nextRound->info = BATTLE_HIT_INFO_END;
	movs	r3, #7	@ tmp201,
	ldrh	r2, [r0, #2]	@ MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B], MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B]
	ands	r3, r2	@ tmp200, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B]
	movs	r2, #128	@ tmp202,
	orrs	r3, r2	@ tmp205, tmp202
	strh	r3, [r0, #2]	@ tmp205, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B]
@ C_Code.c:889:         u16 * animRound = &GetAnimRoundData()[0];
	ldr	r3, .L289+36	@ tmp207,
	bl	.L10		@
@ C_Code.c:890:         for (int i = proc->roundId; i < 32; ++i)
	ldrb	r3, [r4, r7]	@ i,
@ C_Code.c:890:         for (int i = proc->roundId; i < 32; ++i)
	cmp	r3, #31	@ i,
	bgt	.L260		@,
@ C_Code.c:892:             if (animRound[i] == 0xFFFF)
	ldr	r2, .L289+40	@ tmp222,
@ C_Code.c:896:             animRound[i] = 0xFFFF;
	subs	r7, r7, #71	@ tmp279,
@ C_Code.c:892:             if (animRound[i] == 0xFFFF)
	mov	ip, r2	@ tmp222, tmp222
	b	.L257		@
.L286:
@ C_Code.c:890:         for (int i = proc->roundId; i < 32; ++i)
	adds	r3, r3, #1	@ i,
@ C_Code.c:896:             animRound[i] = 0xFFFF;
	strh	r7, [r0, r2]	@ tmp279, MEM[(u16 *)animRound_58 + _113 * 1]
@ C_Code.c:890:         for (int i = proc->roundId; i < 32; ++i)
	cmp	r3, #32	@ i,
	beq	.L260		@,
.L257:
	lsls	r2, r3, #1	@ _113, i,
@ C_Code.c:892:             if (animRound[i] == 0xFFFF)
	ldrh	r1, [r0, r2]	@ MEM[(u16 *)animRound_58 + _113 * 1], MEM[(u16 *)animRound_58 + _113 * 1]
	cmp	r1, ip	@ MEM[(u16 *)animRound_58 + _113 * 1], tmp222
	bne	.L286		@,
.L260:
@ C_Code.c:903:         side = 1 ^ side;
	movs	r2, #1	@ tmp212,
@ C_Code.c:904:         hp = gEkrGaugeHp[side];
	ldr	r3, .L289	@ tmp213,
@ C_Code.c:903:         side = 1 ^ side;
	eors	r2, r6	@ side, _1
@ C_Code.c:904:         hp = gEkrGaugeHp[side];
	lsls	r1, r2, #1	@ tmp214, side,
	ldrsh	r1, [r1, r3]	@ _13, gEkrGaugeHp
@ C_Code.c:905:         if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL)
	ldr	r3, [sp, #32]	@ tmp302, round
	ldr	r0, [r3]	@ *round_51(D), *round_51(D)
@ C_Code.c:907:             hp += newDamage;
	ldr	r3, [sp, #40]	@ tmp303, newDamage
	adds	r3, r3, r1	@ hp, tmp303, _13
@ C_Code.c:905:         if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL)
	lsls	r0, r0, #23	@ tmp290, *round_51(D),
	bpl	.L287		@,
@ C_Code.c:812:     if (newHp > 127)
	cmp	r3, #127	@ hp,
	bgt	.L288		@,
.L261:
@ C_Code.c:808:     if (newHp < 0)
	mvns	r0, r3	@ tmp276, hp
	asrs	r0, r0, #31	@ tmp275, tmp276,
	ands	r3, r0	@ _80, tmp275
.L262:
@ C_Code.c:817:     some_bunit->unit.curHP = newHp;
	mov	r0, r8	@ active_bunit, active_bunit
	strb	r3, [r0, #19]	@ _80, active_bunit_65(D)->unit.curHP
@ C_Code.c:818:     if (hp == newHp)
	cmp	r1, r3	@ _13, _80
	bne	.LCB1705	@
	b	.L264	@long jump	@
.LCB1705:
@ C_Code.c:828:     if (proc->side == side)
	movs	r0, #74	@ tmp226,
	ldrb	r0, [r4, r0]	@ _87,
@ C_Code.c:828:     if (proc->side == side)
	cmp	r2, r0	@ side, _87
	beq	.LCB1709	@
	b	.L264	@long jump	@
.LCB1709:
@ C_Code.c:822:     int diff = newHp - hp;
	subs	r6, r3, r1	@ diff, _80, _13
@ C_Code.c:831:         if (UsingSkillSys)
	ldr	r2, .L289+44	@ tmp229,
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	ldr	r0, [r4, #56]	@ pretmp_126, proc_39(D)->currentRound
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	asrs	r4, r6, #31	@ tmp291, diff,
@ C_Code.c:830:         HpProc->cur = hp;
	strh	r1, [r5, #46]	@ _13, HpProc_43(D)->cur
@ C_Code.c:831:         if (UsingSkillSys)
	ldr	r1, [r2]	@ UsingSkillSys.32_88, UsingSkillSys
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	adds	r2, r6, r4	@ _125, diff, tmp291
	eors	r2, r4	@ _125, tmp291
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	lsls	r2, r2, #24	@ tmp231, _125,
	asrs	r2, r2, #24	@ _128, tmp231,
@ C_Code.c:831:         if (UsingSkillSys)
	cmp	r1, #0	@ UsingSkillSys.32_88,
	beq	.L266		@,
@ C_Code.c:833:             HpProc->post = newHp;
	movs	r4, #80	@ tmp232,
	strh	r3, [r5, r4]	@ _80, HpProc_43(D)->post
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r0, #3]	@ _128, pretmp_126->hpChange
@ C_Code.c:842:         if (UsingSkillSys == 2)
	cmp	r1, #2	@ UsingSkillSys.32_88,
	beq	.LCB1726	@
	b	.L264	@long jump	@
.LCB1726:
@ C_Code.c:844:             proc->currentRound->overDmg = diff;
	strh	r6, [r0, #6]	@ diff, pretmp_126->overDmg
	b	.L264		@
.L288:
@ C_Code.c:812:     if (newHp > 127)
	movs	r3, #127	@ _80,
	b	.L262		@
.L287:
@ C_Code.c:904:         hp = gEkrGaugeHp[side];
	movs	r3, r1	@ hp, _13
@ C_Code.c:812:     if (newHp > 127)
	cmp	r3, #127	@ hp,
	ble	.L261		@,
	b	.L288		@
.L266:
@ C_Code.c:837:             HpProc->postHpAtkrSS = newHp >> 16;
	movs	r4, #82	@ tmp235,
	strh	r1, [r5, r4]	@ UsingSkillSys.32_88, HpProc_43(D)->postHpAtkrSS
@ C_Code.c:838:             HpProc->post = newHp;
	movs	r1, #80	@ tmp238,
	strh	r3, [r5, r1]	@ _80, HpProc_43(D)->post
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r0, #3]	@ _128, pretmp_126->hpChange
	b	.L264		@
.L290:
	.align	2
.L289:
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
	.align	1
	.p2align 2,,3
	.global	AdjustDamageByPercent
	.syntax unified
	.code	16
	.thumb_func
	.type	AdjustDamageByPercent, %function
AdjustDamageByPercent:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, fp	@,
	mov	r7, r10	@,
	mov	r6, r9	@,
	mov	r5, r8	@,
	push	{r5, r6, r7, lr}	@
@ C_Code.c:945:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	ldr	r5, [r0, #56]	@ _1, proc_48(D)->currentRound
@ C_Code.c:943: {
	mov	fp, r3	@ opp_bunit, opp_bunit
@ C_Code.c:945:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	ldr	r3, [r5]	@ *_1, *_1
	lsls	r3, r3, #13	@ tmp164, *_1,
@ C_Code.c:943: {
	mov	r9, r2	@ active_bunit, active_bunit
	movs	r4, r0	@ proc, proc
	mov	r10, r1	@ HpProc, HpProc
	sub	sp, sp, #36	@,,
@ C_Code.c:945:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	lsrs	r2, r3, #13	@ _2, tmp164,
@ C_Code.c:945:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	lsls	r3, r3, #17	@ tmp233, tmp164,
	bmi	.L291		@,
@ C_Code.c:945:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	movs	r3, #3	@ tmp167,
	ldrsb	r3, [r5, r3]	@ tmp167,
	cmp	r3, #0	@ tmp167,
	beq	.L291		@,
@ C_Code.c:949:     if (round->hpChange <= 0)
	ldr	r3, [sp, #72]	@ tmp242, round
	ldrb	r3, [r3, #3]	@ _5,
	lsls	r3, r3, #24	@ _5, _5,
	asrs	r3, r3, #24	@ _5, _5,
	str	r3, [sp, #24]	@ _5, %sfp
@ C_Code.c:949:     if (round->hpChange <= 0)
	cmp	r3, #0	@ _5,
	ble	.L291		@,
@ C_Code.c:953:     int side = proc->side;
	movs	r3, #74	@ tmp170,
	ldrb	r3, [r0, r3]	@ side,
@ C_Code.c:954:     int hp = gEkrGaugeHp[proc->side];
	lsls	r1, r3, #1	@ tmp172, side,
@ C_Code.c:953:     int side = proc->side;
	str	r3, [sp, #16]	@ side, %sfp
@ C_Code.c:954:     int hp = gEkrGaugeHp[proc->side];
	ldr	r3, .L329	@ tmp171,
@ C_Code.c:954:     int hp = gEkrGaugeHp[proc->side];
	ldrsh	r3, [r1, r3]	@ hp, gEkrGaugeHp
	str	r3, [sp, #20]	@ hp, %sfp
@ C_Code.c:955:     if (!hp)
	cmp	r3, #0	@ hp,
	bne	.LCB1812	@
	b	.L325	@long jump	@
.LCB1812:
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	movs	r3, #1	@ tmp180,
	ldr	r0, [sp, #16]	@ side, %sfp
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	ldr	r1, .L329+4	@ tmp175,
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	eors	r3, r0	@ _82, side
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	lsls	r3, r3, #1	@ tmp181, _82,
	ldrsh	r3, [r3, r1]	@ pretmp_83, gEkrGaugeDmg
@ C_Code.c:965:     if (proc->currentRound->attributes & BATTLE_HIT_ATTR_CRIT)
	lsls	r2, r2, #31	@ tmp234, _2,
	bmi	.L326		@,
@ C_Code.c:964:     int oldDamage = round->hpChange;
	ldr	r2, [sp, #24]	@ _5, %sfp
	movs	r7, r2	@ oldDamage, _5
@ C_Code.c:973:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	cmp	r2, r3	@ _5, pretmp_83
	bge	.L296		@,
@ C_Code.c:975:         oldDamage = gEkrGaugeDmg[side ^ 1];
	movs	r7, r3	@ oldDamage, pretmp_83
.L296:
@ C_Code.c:978:     if (UsingSkillSys == 2)
	ldr	r3, .L329+8	@ tmp187,
	ldr	r3, [r3]	@ UsingSkillSys.38_16, UsingSkillSys
	str	r3, [sp, #28]	@ UsingSkillSys.38_16, %sfp
@ C_Code.c:978:     if (UsingSkillSys == 2)
	cmp	r3, #2	@ UsingSkillSys.38_16,
	bne	.L297		@,
@ C_Code.c:980:         oldDamage = ABS(round->overDmg);
	ldr	r3, [sp, #72]	@ tmp261, round
	movs	r2, #6	@ tmp241,
	ldrsh	r3, [r3, r2]	@ tmp188, tmp261, tmp241
	asrs	r2, r3, #31	@ tmp235, tmp188,
	adds	r3, r3, r2	@ tmp189, tmp188, tmp235
	eors	r3, r2	@ tmp189, tmp235
@ C_Code.c:980:         oldDamage = ABS(round->overDmg);
	lsls	r3, r3, #16	@ tmp190, tmp189,
	lsrs	r7, r3, #16	@ oldDamage, tmp190,
.L297:
@ C_Code.c:984:     int newDamage = ((oldDamage * percent)) / 100;
	ldr	r3, [sp, #76]	@ tmp264, percent
	muls	r3, r7	@ _19, oldDamage
@ C_Code.c:984:     int newDamage = ((oldDamage * percent)) / 100;
	movs	r1, #100	@,
	movs	r0, r3	@, _19
	ldr	r6, .L329+12	@ tmp194,
@ C_Code.c:984:     int newDamage = ((oldDamage * percent)) / 100;
	mov	r8, r3	@ _19, _19
@ C_Code.c:984:     int newDamage = ((oldDamage * percent)) / 100;
	bl	.L123		@
@ C_Code.c:985:     if (newDamage >= oldDamage)
	cmp	r7, r0	@ oldDamage, newDamage_56
	bgt	.L298		@,
@ C_Code.c:987:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	ldr	r3, .L329+16	@ tmp196,
	ldr	r0, [r3]	@ BonusDamageRounding, BonusDamageRounding
@ C_Code.c:987:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	movs	r1, #100	@,
@ C_Code.c:987:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	add	r0, r0, r8	@ _21, _19
@ C_Code.c:987:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	bl	.L123		@
.L299:
@ C_Code.c:993:     if (newDamage <= 0)
	subs	r6, r0, #0	@ newDamage, newDamage,
	bgt	.L300		@,
	movs	r6, #1	@ newDamage,
.L300:
@ C_Code.c:997:     int newHp = hp - newDamage;
	ldr	r3, [sp, #20]	@ hp, %sfp
@ C_Code.c:998:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r1, #11	@ _27,
@ C_Code.c:997:     int newHp = hp - newDamage;
	subs	r2, r3, r6	@ newHp, hp, newDamage
@ C_Code.c:998:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	mov	r3, r9	@ active_bunit, active_bunit
	ldrsb	r1, [r3, r1]	@ _27,* _27
	movs	r3, #192	@ tmp214,
	ands	r3, r1	@ _28, _27
@ C_Code.c:998:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _28,
	beq	.L327		@,
.L301:
@ C_Code.c:1017:     if (newHp <= 0)
	mvns	r3, r2	@ tmp225, newHp
	asrs	r3, r3, #31	@ tmp224, tmp225,
	ands	r2, r3	@ newHp, tmp224
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r3, [sp, #28]	@ UsingSkillSys.38_16, %sfp
@ C_Code.c:1017:     if (newHp <= 0)
	movs	r1, r2	@ _3, newHp
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r3, #0	@ UsingSkillSys.38_16,
	beq	.L304		@,
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, .L329+20	@ tmp220,
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, [r2]	@ ProcSkillsStackWithTimedHits, ProcSkillsStackWithTimedHits
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldrb	r3, [r5, #4]	@ pretmp_80,
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r2, #0	@ ProcSkillsStackWithTimedHits,
	beq	.L305		@,
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, .L329+24	@ tmp222,
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldrb	r2, [r2, r3]	@ tmp223, SkillExceptionsTable
	cmp	r2, #0	@ tmp223,
	beq	.L304		@,
.L305:
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r3, #0	@ pretmp_80,
	beq	.L304		@,
@ C_Code.c:1027:         newHp = hp - round->hpChange;
	ldr	r3, [sp, #24]	@ _5, %sfp
@ C_Code.c:1026:         newDamage = round->hpChange; // actual oldDamage without choosing between displayed / round dmg
	movs	r6, r3	@ newDamage, _5
@ C_Code.c:1027:         newHp = hp - round->hpChange;
	ldr	r2, [sp, #20]	@ hp, %sfp
	subs	r1, r2, r3	@ _3, hp, _5
.L304:
@ C_Code.c:1031:     UpdateHP(proc, HpProc, opp_bunit, newHp, side, newDamage);
	mov	r7, fp	@ opp_bunit, opp_bunit
	mov	r8, r1	@ _3, _3
	ldr	r3, [sp, #16]	@ side, %sfp
	movs	r2, r7	@, opp_bunit
	movs	r0, r4	@, proc
	str	r3, [sp]	@ side,
	str	r6, [sp, #4]	@ newDamage,
	movs	r3, r1	@, _3
	mov	r1, r10	@, HpProc
	bl	UpdateHP		@
@ C_Code.c:1033:     CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, newHp, newDamage);
	mov	r0, r8	@ _3, _3
	str	r0, [sp, #4]	@ _3,
	ldr	r0, [sp, #72]	@ tmp295, round
	movs	r3, r7	@, opp_bunit
	str	r0, [sp]	@ tmp295,
	mov	r2, r9	@, active_bunit
	mov	r1, r10	@, HpProc
	movs	r0, r4	@, proc
	str	r6, [sp, #8]	@ newDamage,
	bl	CheckForDeath		@
.L291:
@ C_Code.c:1034: }
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
.L326:
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	lsls	r2, r3, #1	@ tmp185, pretmp_83,
	adds	r3, r2, r3	@ oldDamage, tmp185, pretmp_83
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	ldr	r2, [sp, #24]	@ _5, %sfp
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	movs	r7, r3	@ oldDamage, oldDamage
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	cmp	r3, r2	@ oldDamage, _5
	bge	.L296		@,
	movs	r7, r2	@ oldDamage, _5
	b	.L296		@
.L298:
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	ldr	r3, .L329+28	@ tmp203,
	ldr	r0, [r3]	@ ReducedDamageRounding, ReducedDamageRounding
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	ldr	r3, .L329+32	@ tmp206,
	ldr	r3, [r3]	@ ReducedDamageSubtract, ReducedDamageSubtract
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	add	r0, r0, r8	@ _23, _19
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	movs	r1, #100	@,
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	subs	r0, r0, r3	@ _25, _23, ReducedDamageSubtract
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	bl	.L123		@
	b	.L299		@
.L327:
@ C_Code.c:1002:         if ((hp - oldDamage) <= 0)
	ldr	r3, [sp, #20]	@ hp, %sfp
	subs	r3, r3, r7	@ _29, hp, oldDamage
@ C_Code.c:1002:         if ((hp - oldDamage) <= 0)
	cmp	r3, #0	@ _29,
	ble	.L328		@,
.L302:
@ C_Code.c:1010:         if (!BlockingEnabled)
	ldr	r1, .L329+36	@ tmp218,
@ C_Code.c:1010:         if (!BlockingEnabled)
	ldr	r1, [r1]	@ BlockingEnabled, BlockingEnabled
	cmp	r1, #0	@ BlockingEnabled,
	bne	.L301		@,
@ C_Code.c:1012:             newHp = hp - oldDamage;
	movs	r2, r3	@ newHp, _29
@ C_Code.c:1013:             newDamage = oldDamage;
	movs	r6, r7	@ newDamage, oldDamage
	b	.L301		@
.L325:
@ C_Code.c:957:         CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp, 0);
	ldr	r3, [sp, #20]	@ hp, %sfp
	str	r3, [sp, #8]	@ hp,
	str	r3, [sp, #4]	@ hp,
	ldr	r3, [sp, #72]	@ tmp251, round
	mov	r2, r9	@, active_bunit
	str	r3, [sp]	@ tmp251,
	mov	r1, r10	@, HpProc
	mov	r3, fp	@, opp_bunit
	bl	CheckForDeath		@
@ C_Code.c:958:         return;
	b	.L291		@
.L328:
@ C_Code.c:1004:             if (!BlockingCanPreventLethal)
	ldr	r1, .L329+40	@ tmp216,
@ C_Code.c:1004:             if (!BlockingCanPreventLethal)
	ldr	r1, [r1]	@ BlockingCanPreventLethal, BlockingCanPreventLethal
	cmp	r1, #0	@ BlockingCanPreventLethal,
	bne	.L302		@,
@ C_Code.c:1006:                 newHp = hp - oldDamage;
	movs	r2, r3	@ newHp, _29
@ C_Code.c:1007:                 newDamage = oldDamage;
	movs	r6, r7	@ newDamage, oldDamage
	b	.L302		@
.L330:
	.align	2
.L329:
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
	.type	AdjustDamageWithGetter, %function
AdjustDamageWithGetter:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}	@
@ C_Code.c:728:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r4, #11	@ _15,
	movs	r5, #192	@ tmp135,
	ldrsb	r4, [r2, r4]	@ _15,* _15
@ C_Code.c:764: {
	sub	sp, sp, #12	@,,
@ C_Code.c:728:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	ands	r4, r5	@ _5, tmp135
@ C_Code.c:726:     if (success)
	ldr	r5, [sp, #28]	@ tmp175, success
	cmp	r5, #0	@ tmp175,
	beq	.L332		@,
@ C_Code.c:728:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r4, #128	@ _5,
	beq	.L340		@,
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r4, .L341	@ tmp139,
	ldr	r4, [r4]	@ TimedHitsDifficultyRam.25_21, TimedHitsDifficultyRam
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r4, [r4]	@ *TimedHitsDifficultyRam.25_21, *TimedHitsDifficultyRam.25_21
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r5, r4, #26	@ tmp169, *TimedHitsDifficultyRam.25_21,
	bmi	.L335		@,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r5, .L341+4	@ tmp149,
	ldr	r5, [r5]	@ DifficultyThreshold.27_26, DifficultyThreshold
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r4, r4, #27	@ tmp154, *TimedHitsDifficultyRam.25_21,
	lsrs	r4, r4, #27	@ _25, tmp154,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r4, r5	@ _25, DifficultyThreshold.27_26
	bge	.L336		@,
@ C_Code.c:742:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r4, .L341+8	@ tmp157,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r4, [r4]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r5, r4	@ DifficultyThreshold.27_26, NumberOfRandomButtons
	bgt	.L335		@,
.L336:
@ C_Code.c:744:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r4, .L341+12	@ tmp160,
	ldr	r5, .L341+16	@ tmp159,
	ldr	r4, [r4]	@ DifficultyBonusPercent, DifficultyBonusPercent
	ldr	r5, [r5]	@ BonusDamagePercent, BonusDamagePercent
	adds	r4, r4, r5	@ _19, DifficultyBonusPercent, BonusDamagePercent
	b	.L334		@
.L332:
@ C_Code.c:749:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r4, #128	@ _5,
	beq	.L338		@,
@ C_Code.c:753:     return FailedHitDamagePercent;
	ldr	r4, .L341+20	@ tmp164,
	ldr	r4, [r4]	@ _19,
.L334:
@ C_Code.c:766:     AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r4, [sp, #4]	@ _19,
	ldr	r4, [sp, #24]	@ tmp183, round
	str	r4, [sp]	@ tmp183,
	bl	AdjustDamageByPercent		@
@ C_Code.c:767: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L340:
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r4, .L341+24	@ tmp136,
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r4, [r4]	@ BlockingEnabled, BlockingEnabled
	cmp	r4, #0	@ BlockingEnabled,
	beq	.L338		@,
@ C_Code.c:732:                 return ReducedDamagePercent;
	ldr	r4, .L341+28	@ tmp138,
	ldr	r4, [r4]	@ _19,
	b	.L334		@
.L338:
@ C_Code.c:736:                 return 100;
	movs	r4, #100	@ _19,
	b	.L334		@
.L335:
@ C_Code.c:747:         return BonusDamagePercent;
	ldr	r4, .L341+16	@ tmp163,
	ldr	r4, [r4]	@ _19,
	b	.L334		@
.L342:
	.align	2
.L341:
	.word	TimedHitsDifficultyRam
	.word	DifficultyThreshold
	.word	NumberOfRandomButtons
	.word	DifficultyBonusPercent
	.word	BonusDamagePercent
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
	.type	DoStuffIfHit, %function
DoStuffIfHit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r7, r9	@,
	mov	r6, r8	@,
	mov	lr, r10	@,
	movs	r5, r3	@ round, round
	push	{r6, r7, lr}	@
	movs	r7, r3	@ round, round
@ C_Code.c:103:     if (gBattleStats.config &
	ldr	r3, .L379	@ tmp176,
@ C_Code.c:614: {
	movs	r6, r2	@ HpProc, HpProc
@ C_Code.c:103:     if (gBattleStats.config &
	ldrh	r2, [r3]	@ gBattleStats, gBattleStats
	movs	r3, #252	@ tmp180,
	lsls	r3, r3, #2	@ tmp180, tmp180,
@ C_Code.c:614: {
	movs	r4, r0	@ proc, proc
	sub	sp, sp, #8	@,,
@ C_Code.c:103:     if (gBattleStats.config &
	tst	r2, r3	@ gBattleStats, tmp180
	bne	.L343		@,
@ C_Code.c:109:     if (TimedHitsDifficultyRam->off)
	ldr	r3, .L379+4	@ tmp185,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_13, *TimedHitsDifficultyRam.0_13
@ C_Code.c:109:     if (TimedHitsDifficultyRam->off)
	lsls	r3, r3, #25	@ tmp311, *TimedHitsDifficultyRam.0_13,
	bpl	.L375		@,
.L343:
@ C_Code.c:719: }
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L375:
@ C_Code.c:113:     return !CheckFlag(DisabledFlag);
	ldr	r3, .L379+8	@ tmp195,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L379+12	@ tmp197,
	bl	.L10		@
@ C_Code.c:615:     if (!AreTimedHitsEnabled())
	cmp	r0, #0	@ tmp305,
	bne	.L343		@,
@ C_Code.c:619:     if (round->hpChange < 0)
	ldrb	r3, [r5, #3]	@ tmp202,
	cmp	r3, #127	@ tmp202,
	bhi	.L343		@,
@ C_Code.c:623:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	ldr	r3, .L379+16	@ tmp203,
@ C_Code.c:623:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	ldrh	r2, [r3, #8]	@ tmp206,
	ldrh	r3, [r3, #4]	@ tmp208,
@ C_Code.c:623:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	orrs	r2, r3	@ tmp206, tmp208
@ C_Code.c:627:     int x = proc->anim2->xPosition;
	ldr	r3, [r4, #48]	@ proc_6(D)->anim2, proc_6(D)->anim2
@ C_Code.c:627:     int x = proc->anim2->xPosition;
	movs	r5, #2	@ x,
	ldrsh	r5, [r3, r5]	@ x, proc_6(D)->anim2, x
@ C_Code.c:623:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	mov	r8, r2	@ keys, tmp206
@ C_Code.c:628:     if (x > 119)
	cmp	r5, #119	@ x,
	bgt	.LCB2188	@
	b	.L347	@long jump	@
.LCB2188:
@ C_Code.c:630:         x -= 40;
	subs	r5, r5, #40	@ x,
.L348:
@ C_Code.c:638:     int hitTime = !proc->EkrEfxIsUnitHittedNowFrames;
	movs	r3, #79	@ tmp212,
@ C_Code.c:639:     if (hitTime)
	ldrb	r3, [r4, r3]	@ tmp213,
	cmp	r3, #0	@ tmp213,
	bne	.L350		@,
@ C_Code.c:636:     struct BattleUnit * active_bunit = proc->active_bunit;
	ldr	r2, [r4, #60]	@ active_bunit, proc_6(D)->active_bunit
	mov	r9, r2	@ active_bunit, active_bunit
@ C_Code.c:637:     struct BattleUnit * opp_bunit = proc->opp_bunit;
	ldr	r2, [r4, #64]	@ opp_bunit, proc_6(D)->opp_bunit
	mov	r10, r2	@ opp_bunit, opp_bunit
@ C_Code.c:642:         if (proc->timer2 == 0xFF)
	movs	r2, #68	@ tmp214,
@ C_Code.c:642:         if (proc->timer2 == 0xFF)
	ldrb	r1, [r4, r2]	@ tmp215,
	cmp	r1, #255	@ tmp215,
	bne	.LCB2203	@
	b	.L376	@long jump	@
.LCB2203:
.L351:
@ C_Code.c:646:         SaveInputFrame(proc, keys);
	mov	r1, r8	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
@ C_Code.c:647:         SaveIfWeHitOnTime(proc);
	movs	r0, r4	@, proc
	bl	SaveIfWeHitOnTime		@
@ C_Code.c:648:         if (!proc->adjustedDmg)
	movs	r3, #71	@ tmp219,
@ C_Code.c:648:         if (!proc->adjustedDmg)
	ldrb	r2, [r4, r3]	@ tmp220,
	cmp	r2, #0	@ tmp220,
	bne	.L350		@,
@ C_Code.c:528:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r2, .L379+20	@ tmp221,
@ C_Code.c:533:     if (CheatCodeOn())
	ldrb	r2, [r2, #31]	@ tmp224,
	cmp	r2, #127	@ tmp224,
	bls	.LCB2217	@
	b	.L353	@long jump	@
.LCB2217:
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r2, .L379+24	@ tmp225,
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r2, [r2]	@ AlwaysWork, AlwaysWork
	cmp	r2, #0	@ AlwaysWork,
	beq	.LCB2221	@
	b	.L353	@long jump	@
.LCB2221:
@ C_Code.c:541:     return proc->hitOnTime;
	adds	r2, r2, #69	@ tmp227,
@ C_Code.c:650:             if (DidWeHitOnTime(proc))
	ldrb	r2, [r4, r2]	@ tmp228,
	cmp	r2, #0	@ tmp228,
	beq	.LCB2225	@
	b	.L353	@long jump	@
.LCB2225:
@ C_Code.c:657:                 proc->adjustedDmg = true;
	movs	r2, #1	@ tmp234,
	strb	r2, [r4, r3]	@ tmp234, proc_6(D)->adjustedDmg
@ C_Code.c:749:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	mov	r3, r9	@ active_bunit, active_bunit
	movs	r2, #11	@ _84,
	ldrsb	r2, [r3, r2]	@ _84,* _84
	movs	r3, #192	@ tmp237,
	ands	r3, r2	@ _85, _84
@ C_Code.c:749:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _85,
	bne	.LCB2234	@
	b	.L364	@long jump	@
.LCB2234:
@ C_Code.c:753:     return FailedHitDamagePercent;
	ldr	r3, .L379+28	@ tmp239,
	ldr	r3, [r3]	@ _86, FailedHitDamagePercent
.L355:
@ C_Code.c:766:     AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r3, [sp, #4]	@ _86,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	movs	r1, r6	@, HpProc
	movs	r0, r4	@, proc
	str	r7, [sp]	@ round,
	bl	AdjustDamageByPercent		@
.L350:
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	movs	r3, #74	@ tmp240,
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	ldrb	r0, [r4, r3]	@ _39,
	ldr	r3, .L379+32	@ tmp242,
	bl	.L10		@
@ C_Code.c:669:         (proc->timer2 != 0xFF))
	movs	r3, #68	@ tmp245,
	ldrb	r3, [r4, r3]	@ pretmp_116,
	movs	r6, r3	@ pretmp_116, pretmp_116
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	cmp	r0, #0	@ tmp306,
	bne	.L356		@,
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	movs	r3, #76	@ tmp246,
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	ldrb	r3, [r4, r3]	@ tmp247,
	cmp	r3, #255	@ tmp247,
	beq	.L377		@,
.L356:
@ C_Code.c:528:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L379+20	@ tmp255,
@ C_Code.c:533:     if (CheatCodeOn())
	ldrb	r3, [r3, #31]	@ tmp258,
	cmp	r3, #127	@ tmp258,
	bhi	.L358		@,
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r3, .L379+24	@ tmp259,
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L358		@,
@ C_Code.c:541:     return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp261,
@ C_Code.c:671:         if (DidWeHitOnTime(proc))
	ldrb	r3, [r4, r3]	@ tmp262,
	cmp	r3, #0	@ tmp262,
	bne	.L358		@,
@ C_Code.c:690:         else if (proc->timer2 < 20)
	cmp	r6, #19	@ pretmp_116,
	bhi	.L360		@,
@ C_Code.c:546:     if (!DisplayPress)
	ldr	r3, .L379+36	@ tmp287,
	ldr	r2, [r3]	@ pretmp_17, DisplayPress
@ C_Code.c:692:             if (ChangePaletteWhenButtonIsPressed)
	ldr	r3, .L379+40	@ tmp288,
@ C_Code.c:692:             if (ChangePaletteWhenButtonIsPressed)
	ldr	r3, [r3]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
	cmp	r3, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L361		@,
@ C_Code.c:546:     if (!DisplayPress)
	cmp	r2, #0	@ pretmp_17,
	bne	.L378		@,
.L360:
@ C_Code.c:701:         proc->roundEnd = true;
	movs	r3, #78	@ tmp290,
	movs	r2, #1	@ tmp291,
	strb	r2, [r4, r3]	@ tmp291, proc_6(D)->roundEnd
	b	.L343		@
.L358:
@ C_Code.c:682:             if (((y > (-16)) && (y < (161))))
	movs	r3, r6	@ _55, pretmp_116
	adds	r3, r3, #112	@ _55,
	cmp	r3, #175	@ _55,
	bhi	.L360		@,
@ C_Code.c:684:                 if (!gBanimDoneFlag[proc->side])
	movs	r2, #74	@ tmp265,
	ldrb	r2, [r4, r2]	@ _57,
@ C_Code.c:684:                 if (!gBanimDoneFlag[proc->side])
	ldr	r3, .L379+44	@ tmp264,
	lsls	r2, r2, #2	@ tmp267, _57,
@ C_Code.c:684:                 if (!gBanimDoneFlag[proc->side])
	ldr	r3, [r2, r3]	@ gBanimDoneFlag[_57], gBanimDoneFlag[_57]
	cmp	r3, #0	@ gBanimDoneFlag[_57],
	bne	.L360		@,
@ C_Code.c:678:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	movs	r1, #31	@,
	movs	r0, r6	@, pretmp_116
	ldr	r3, .L379+48	@ tmp269,
	bl	.L10		@
@ C_Code.c:678:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	movs	r2, #104	@ tmp271,
	ldr	r3, .L379+52	@ tmp270,
	adds	r3, r3, r0	@ tmp272, tmp270, _47
@ C_Code.c:681:             y -= clock;
	movs	r0, #48	@ tmp276,
@ C_Code.c:678:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	ldrb	r1, [r3, r2]	@ _49, xPos
@ C_Code.c:686:                     PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
	movs	r2, #255	@ tmp278,
@ C_Code.c:681:             y -= clock;
	subs	r0, r0, r6	@ y_53, tmp276, pretmp_116
@ C_Code.c:686:                     PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
	ands	r2, r0	@ _60, y_53
	movs	r0, #224	@ tmp283,
@ C_Code.c:678:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	adds	r1, r1, r5	@ x, _49, x
@ C_Code.c:679:             x += 16;
	adds	r1, r1, #16	@ x_52,
@ C_Code.c:686:                     PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
	lsls	r0, r0, #8	@ tmp283, tmp283,
	lsls	r1, r1, #23	@ tmp282, x_52,
	str	r0, [sp]	@ tmp283,
	ldr	r3, .L379+56	@ tmp275,
	movs	r0, #0	@,
	ldr	r5, .L379+60	@ tmp284,
	lsrs	r1, r1, #23	@ _59, tmp282,
	bl	.L28		@
	b	.L360		@
.L347:
@ C_Code.c:632:     else if (x > 40)
	cmp	r5, #40	@ x,
	bgt	.LCB2333	@
	b	.L348	@long jump	@
.LCB2333:
@ C_Code.c:634:         x -= 20;
	subs	r5, r5, #20	@ x,
	b	.L348		@
.L376:
@ C_Code.c:644:             proc->timer2 = 0;
	strb	r3, [r4, r2]	@ tmp213, proc_6(D)->timer2
	b	.L351		@
.L377:
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	subs	r3, r3, #178	@ tmp248,
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	ldrb	r3, [r4, r3]	@ tmp250,
	ands	r3, r6	@ tmp253, pretmp_116
	cmp	r3, #255	@ tmp253,
	bne	.L356		@,
@ C_Code.c:705:         if (proc->timer < 1)
	ldr	r3, [r4, #52]	@ proc_6(D)->timer, proc_6(D)->timer
	cmp	r3, #0	@ proc_6(D)->timer,
	bgt	.L362		@,
@ C_Code.c:707:             proc->frame = 0;
	movs	r3, #75	@ tmp294,
	strb	r0, [r4, r3]	@ tmp306, proc_6(D)->frame
.L363:
@ C_Code.c:714:         if (!proc->roundEnd)
	movs	r3, #78	@ tmp297,
@ C_Code.c:714:         if (!proc->roundEnd)
	ldrb	r3, [r4, r3]	@ tmp298,
	cmp	r3, #0	@ tmp298,
	beq	.LCB2361	@
	b	.L343	@long jump	@
.LCB2361:
@ C_Code.c:546:     if (!DisplayPress)
	ldr	r3, .L379+36	@ tmp299,
@ C_Code.c:546:     if (!DisplayPress)
	ldr	r3, [r3]	@ DisplayPress, DisplayPress
	cmp	r3, #0	@ DisplayPress,
	bne	.LCB2365	@
	b	.L343	@long jump	@
.LCB2365:
	movs	r3, #15	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L343		@
.L353:
@ C_Code.c:652:                 proc->adjustedDmg = true;
	movs	r3, #1	@ tmp230,
	movs	r2, #71	@ tmp229,
@ C_Code.c:653:                 AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true);
	movs	r1, r6	@, HpProc
@ C_Code.c:652:                 proc->adjustedDmg = true;
	strb	r3, [r4, r2]	@ tmp230, proc_6(D)->adjustedDmg
@ C_Code.c:653:                 AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true);
	movs	r0, r4	@, proc
	str	r3, [sp, #4]	@ tmp230,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	str	r7, [sp]	@ round,
	bl	AdjustDamageWithGetter		@
	b	.L350		@
.L361:
@ C_Code.c:546:     if (!DisplayPress)
	cmp	r2, #0	@ pretmp_17,
	beq	.L360		@,
	movs	r3, #14	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L360		@
.L378:
	movs	r3, #15	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L360		@
.L364:
@ C_Code.c:736:                 return 100;
	movs	r3, #100	@ _86,
	b	.L355		@
.L362:
@ C_Code.c:712:             SaveInputFrame(proc, keys);
	mov	r1, r8	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
	b	.L363		@
.L380:
	.align	2
.L379:
	.word	gBattleStats
	.word	TimedHitsDifficultyRam
	.word	DisabledFlag
	.word	CheckFlag
	.word	sKeyStatusBuffer
	.word	gPlaySt
	.word	AlwaysWork
	.word	FailedHitDamagePercent
	.word	EkrEfxIsUnitHittedNow
	.word	DisplayPress
	.word	ChangePaletteWhenButtonIsPressed
	.word	gBanimDoneFlag
	.word	Mod
	.word	.LANCHOR0
	.word	.LANCHOR1+8
	.word	PutSprite
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
@ C_Code.c:297:     if (!proc->anim)
	ldr	r3, [r0, #44]	@ proc_29(D)->anim, proc_29(D)->anim
@ C_Code.c:296: {
	movs	r4, r0	@ proc, proc
	sub	sp, sp, #12	@,,
@ C_Code.c:297:     if (!proc->anim)
	cmp	r3, #0	@ proc_29(D)->anim,
	beq	.L381		@,
@ C_Code.c:302:     struct ProcEkrBattle * battleProc = gpProcEkrBattle;
	ldr	r3, .L407	@ tmp144,
	ldr	r5, [r3]	@ battleProc, gpProcEkrBattle
@ C_Code.c:304:     if (!battleProc)
	cmp	r5, #0	@ battleProc,
	beq	.L381		@,
@ C_Code.c:308:     if (!proc->anim2)
	ldr	r3, [r0, #48]	@ proc_29(D)->anim2, proc_29(D)->anim2
	cmp	r3, #0	@ proc_29(D)->anim2,
	beq	.L381		@,
@ C_Code.c:312:     if (gEkrBattleEndFlag)
	ldr	r3, .L407+4	@ tmp146,
@ C_Code.c:312:     if (gEkrBattleEndFlag)
	ldr	r3, [r3]	@ gEkrBattleEndFlag, gEkrBattleEndFlag
	cmp	r3, #0	@ gEkrBattleEndFlag,
	bne	.L406		@,
@ C_Code.c:319:     if (proc->timer2 != 0xFF)
	movs	r2, #68	@ tmp151,
@ C_Code.c:318:     proc->timer++;
	ldr	r3, [r0, #52]	@ proc_29(D)->timer, proc_29(D)->timer
	adds	r3, r3, #1	@ _5,
	str	r3, [r0, #52]	@ _5, proc_29(D)->timer
@ C_Code.c:319:     if (proc->timer2 != 0xFF)
	ldrb	r3, [r0, r2]	@ _6,
@ C_Code.c:319:     if (proc->timer2 != 0xFF)
	cmp	r3, #255	@ _6,
	beq	.L386		@,
@ C_Code.c:321:         proc->timer2++;
	adds	r3, r3, #1	@ tmp152,
	strb	r3, [r0, r2]	@ tmp152, proc_29(D)->timer2
.L386:
@ C_Code.c:326:     if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
	movs	r2, #79	@ tmp195,
@ C_Code.c:324:     struct SkillSysBattleHit * currentRound = proc->currentRound;
	ldr	r3, [r4, #56]	@ currentRound, proc_29(D)->currentRound
	movs	r7, r3	@ currentRound, currentRound
@ C_Code.c:326:     if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
	ldrb	r3, [r4, r2]	@ _8,
@ C_Code.c:326:     if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
	cmp	r3, #255	@ _8,
	beq	.L387		@,
@ C_Code.c:328:         proc->EkrEfxIsUnitHittedNowFrames++;
	adds	r3, r3, #1	@ tmp156,
	strb	r3, [r4, r2]	@ tmp156, proc_29(D)->EkrEfxIsUnitHittedNowFrames
.L388:
@ C_Code.c:336:     struct NewProcEfxHPBar * HpProc = Proc_Find(gProcScr_efxHPBarResire);
	ldr	r3, .L407+8	@ tmp167,
	ldr	r0, [r3]	@ gProcScr_efxHPBarResire, gProcScr_efxHPBarResire
	ldr	r3, .L407+12	@ tmp169,
	movs	r6, r3	@ tmp169, tmp169
	bl	.L10		@
@ C_Code.c:337:     if (!HpProc)
	cmp	r0, #0	@ HpProc,
	beq	.L389		@,
@ C_Code.c:341:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r2, r0	@, HpProc
	movs	r3, r7	@, currentRound
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
.L390:
@ C_Code.c:288:     if (proc->EkrEfxIsUnitHittedNowFrames)
	movs	r3, #79	@ tmp173,
@ C_Code.c:288:     if (proc->EkrEfxIsUnitHittedNowFrames)
	ldrb	r3, [r4, r3]	@ tmp174,
	cmp	r3, #0	@ tmp174,
	bne	.L381		@,
@ C_Code.c:345:         int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId);
	movs	r6, #70	@ tmp202,
	ldrb	r3, [r4, r6]	@ tmp177,
	movs	r1, #0	@,
	movs	r2, #0	@,
	ldr	r0, [r4, #48]	@ proc_29(D)->anim2, proc_29(D)->anim2
	ldr	r5, .L407+16	@ tmp178,
	str	r3, [sp]	@ tmp177,
	movs	r3, #0	@,
	bl	.L28		@
	movs	r3, r0	@ x,
@ C_Code.c:346:         x = DisplayDamage2(proc->anim, 1, proc->anim->xPosition, x, proc->roundId);
	ldr	r0, [r4, #44]	@ _18, proc_29(D)->anim
	movs	r1, #2	@ tmp193,
	ldrsh	r2, [r0, r1]	@ _20, _18, tmp193
	ldrb	r1, [r4, r6]	@ tmp181,
	str	r1, [sp]	@ tmp181,
	movs	r1, #1	@,
	bl	.L28		@
.L381:
@ C_Code.c:348: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L406:
@ C_Code.c:314:         Proc_End(proc);
	ldr	r3, .L407+20	@ tmp148,
	bl	.L10		@
@ C_Code.c:315:         return;
	b	.L381		@
.L387:
@ C_Code.c:330:     else if (EkrEfxIsUnitHittedNow(proc->side))
	movs	r3, #74	@ tmp159,
@ C_Code.c:330:     else if (EkrEfxIsUnitHittedNow(proc->side))
	ldrb	r0, [r4, r3]	@ _11,
	ldr	r3, .L407+24	@ tmp161,
	bl	.L10		@
@ C_Code.c:330:     else if (EkrEfxIsUnitHittedNow(proc->side))
	cmp	r0, #0	@ tmp186,
	beq	.L388		@,
@ C_Code.c:332:         proc->EkrEfxIsUnitHittedNowFrames = 0;
	movs	r3, #0	@ tmp165,
	movs	r2, #79	@ tmp197,
	strb	r3, [r4, r2]	@ tmp165, proc_29(D)->EkrEfxIsUnitHittedNowFrames
	b	.L388		@
.L389:
@ C_Code.c:339:         HpProc = Proc_Find(gProcScr_efxHPBar);
	ldr	r3, .L407+28	@ tmp170,
	ldr	r0, [r3]	@ gProcScr_efxHPBar, gProcScr_efxHPBar
	bl	.L123		@
@ C_Code.c:341:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r3, r7	@, currentRound
@ C_Code.c:339:         HpProc = Proc_Find(gProcScr_efxHPBar);
	movs	r6, r0	@ HpProc,
@ C_Code.c:341:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r2, r0	@, HpProc
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
@ C_Code.c:283:     if (!HpProc)
	cmp	r6, #0	@ HpProc,
	bne	.L390		@,
	b	.L381		@
.L408:
	.align	2
.L407:
	.word	gpProcEkrBattle
	.word	gEkrBattleEndFlag
	.word	gProcScr_efxHPBarResire
	.word	Proc_Find
	.word	DisplayDamage2
	.word	Proc_End
	.word	EkrEfxIsUnitHittedNow
	.word	gProcScr_efxHPBar
	.size	LoopTimedHitsProc, .-LoopTimedHitsProc
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
.LC131:
	.ascii	"TimedHitsProcName\000"
	.global	gEkrBg2QuakeVec
	.section	.rodata
	.align	3
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
	.word	.LC131
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
	.global	__aeabi_idiv
	.ident	"GCC: (devkitARM release 66) 15.1.0"
	.text
	.code 16
	.align	1
.L10:
	bx	r3
.L174:
	bx	r4
.L28:
	bx	r5
.L123:
	bx	r6
.L67:
	bx	r9
.L124:
	bx	r10
