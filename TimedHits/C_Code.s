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
	lsls	r3, r3, #25	@ tmp153, *TimedHitsDifficultyRam.0_4,
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
	rsbs	r3, r0, #0	@ tmp149, tmp151
	adcs	r0, r0, r3	@ <retval>, tmp151, tmp149
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
	ldr	r5, .L17	@ tmp116,
	ldr	r3, .L17+4	@ tmp117,
	movs	r0, r5	@, tmp116
	bl	.L10		@
	subs	r4, r0, #0	@ proc, tmp132,
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
	movs	r0, r5	@, tmp116
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
	movs	r5, r0	@ anim, tmp192
@ C_Code.c:154:     proc = Proc_Find(TimedHitsProcCmd);
	ldr	r3, .L26	@ tmp133,
	ldr	r0, .L26+4	@ tmp132,
	bl	.L10		@
	subs	r4, r0, #0	@ proc, tmp193,
@ C_Code.c:155:     if (!proc)
	beq	.L19		@,
@ C_Code.c:160:     if (proc->roundId == roundId)
	movs	r7, #70	@ tmp135,
@ C_Code.c:159:     int roundId = anim->nextRoundId - 1;
	ldrh	r6, [r5, #14]	@ tmp134,
@ C_Code.c:160:     if (proc->roundId == roundId)
	ldrb	r3, [r0, r7]	@ tmp136,
@ C_Code.c:159:     int roundId = anim->nextRoundId - 1;
	subs	r6, r6, #1	@ roundId,
@ C_Code.c:160:     if (proc->roundId == roundId)
	cmp	r3, r6	@ tmp136, roundId
	beq	.L19		@,
@ C_Code.c:119:     proc->anim2 = NULL;
	movs	r3, #0	@ tmp137,
@ C_Code.c:133:     proc->buttonsToPress = 0;
	movs	r2, #80	@ tmp142,
@ C_Code.c:119:     proc->anim2 = NULL;
	str	r3, [r0, #48]	@ tmp137, proc_20->anim2
@ C_Code.c:122:     proc->timer = 0;
	str	r3, [r0, #52]	@ tmp137, proc_20->timer
@ C_Code.c:128:     proc->currentRound = NULL;
	str	r3, [r0, #56]	@ tmp137, proc_20->currentRound
@ C_Code.c:129:     proc->active_bunit = NULL;
	str	r3, [r0, #60]	@ tmp137, proc_20->active_bunit
@ C_Code.c:130:     proc->opp_bunit = NULL;
	str	r3, [r0, #64]	@ tmp137, proc_20->opp_bunit
@ C_Code.c:133:     proc->buttonsToPress = 0;
	strh	r3, [r0, r2]	@ tmp137, proc_20->buttonsToPress
@ C_Code.c:123:     proc->timer2 = 0xFF;
	ldr	r3, .L26+8	@ tmp145,
	str	r3, [r0, #68]	@ tmp145, MEM <vector(4) unsigned char> [(unsigned char *)proc_20 + 68B]
	subs	r3, r3, #255	@ tmp146,
	str	r3, [r0, #72]	@ tmp146, MEM <vector(4) unsigned char> [(unsigned char *)proc_20 + 72B]
	ldr	r3, .L26+12	@ tmp147,
@ C_Code.c:166:     proc->anim = anim;
	str	r5, [r0, #44]	@ anim, proc_20->anim
@ C_Code.c:123:     proc->timer2 = 0xFF;
	str	r3, [r0, #76]	@ tmp147, MEM <vector(4) unsigned char> [(unsigned char *)proc_20 + 76B]
@ C_Code.c:167:     proc->anim2 = GetAnimAnotherSide(anim);
	ldr	r3, .L26+16	@ tmp148,
	movs	r0, r5	@, anim
	bl	.L10		@
@ C_Code.c:167:     proc->anim2 = GetAnimAnotherSide(anim);
	str	r0, [r4, #48]	@ tmp194, proc_20->anim2
@ C_Code.c:171:     proc->currentRound = GetCurrentRound(proc->roundId);
	movs	r0, #255	@ tmp151,
	ldr	r3, .L26+20	@ tmp153,
@ C_Code.c:168:     proc->roundId = roundId;
	strb	r6, [r4, r7]	@ roundId, proc_20->roundId
@ C_Code.c:171:     proc->currentRound = GetCurrentRound(proc->roundId);
	ands	r0, r6	@ tmp152, roundId
	bl	.L10		@
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	ldr	r3, .L26+24	@ tmp154,
@ C_Code.c:171:     proc->currentRound = GetCurrentRound(proc->roundId);
	str	r0, [r4, #56]	@ tmp195, proc_20->currentRound
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r0, r5	@, anim
	bl	.L10		@
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r3, #1	@ tmp156,
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r2, #74	@ tmp159,
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	lsls	r0, r0, #24	@ tmp155, tmp196,
	asrs	r0, r0, #24	@ _10, tmp155,
	eors	r3, r0	@ tmp158, _10
@ C_Code.c:172:     proc->side = GetAnimPosition(anim) ^ 1;
	strb	r3, [r4, r2]	@ tmp158, proc_20->side
@ C_Code.c:173:     proc->active_bunit = gpEkrBattleUnitLeft;
	ldr	r3, .L26+28	@ tmp161,
@ C_Code.c:174:     proc->opp_bunit = gpEkrBattleUnitRight;
	ldr	r2, .L26+32	@ tmp162,
@ C_Code.c:173:     proc->active_bunit = gpEkrBattleUnitLeft;
	ldr	r3, [r3]	@ gpEkrBattleUnitLeft.2_13, gpEkrBattleUnitLeft
@ C_Code.c:174:     proc->opp_bunit = gpEkrBattleUnitRight;
	ldr	r2, [r2]	@ gpEkrBattleUnitRight.3_14, gpEkrBattleUnitRight
@ C_Code.c:173:     proc->active_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #60]	@ gpEkrBattleUnitLeft.2_13, proc_20->active_bunit
@ C_Code.c:174:     proc->opp_bunit = gpEkrBattleUnitRight;
	str	r2, [r4, #64]	@ gpEkrBattleUnitRight.3_14, proc_20->opp_bunit
@ C_Code.c:175:     if (!proc->side)
	cmp	r0, #1	@ _10,
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
	str	r2, [r4, #60]	@ gpEkrBattleUnitRight.3_14, proc_20->active_bunit
@ C_Code.c:178:         proc->opp_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #64]	@ gpEkrBattleUnitLeft.2_13, proc_20->opp_bunit
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
	strb	r3, [r4, r6]	@ tmp190, proc_20->loadedImg
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
	cmp	r1, #0	@ tmp126,
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
	ldrh	r0, [r2, r3]	@ tmp125,
	ldr	r3, .L35	@ tmp126,
	bl	.L10		@
@ C_Code.c:371:     if (wepType == 7)
	movs	r3, #2	@ tmp131,
@ C_Code.c:367:     if (wepType == 6)
	subs	r0, r0, #5	@ tmp128,
@ C_Code.c:371:     if (wepType == 7)
	cmp	r3, r0	@ tmp131, tmp128
	sbcs	r0, r0, r0	@ tmp135
	rsbs	r0, r0, #0	@ tmp130, tmp135
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
	mov	r6, r8	@,
	mov	lr, r10	@,
	mov	r7, r9	@,
	push	{r6, r7, lr}	@
@ C_Code.c:381:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L69	@ tmp146,
@ C_Code.c:381:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:380: {
	mov	r8, r0	@ proc, tmp198
	sub	sp, sp, #8	@,,
@ C_Code.c:381:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	cmp	r3, #0	@ AlwaysA,
	bne	.L52		@,
@ C_Code.c:381:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L69+4	@ tmp148,
	ldr	r2, [r3]	@ TimedHitsDifficultyRam.10_2, TimedHitsDifficultyRam
@ C_Code.c:381:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.10_2, *TimedHitsDifficultyRam.10_2
	lsls	r3, r3, #26	@ tmp202, *TimedHitsDifficultyRam.10_2,
	bmi	.L52		@,
@ C_Code.c:385:     int keys = proc->buttonsToPress;
	movs	r3, #80	@ tmp158,
@ C_Code.c:385:     int keys = proc->buttonsToPress;
	ldrh	r5, [r0, r3]	@ <retval>,
@ C_Code.c:386:     if (!keys)
	cmp	r5, #0	@ <retval>,
	bne	.L37		@,
@ C_Code.c:388:         u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN };
	ldr	r3, .L69+8	@ tmp160,
	ldr	r1, [r3]	@ tmp163,
	str	r1, [sp]	@ tmp163,
	mov	r1, sp	@ tmp205,
	ldrh	r3, [r3, #4]	@ tmp165,
	strh	r3, [r1, #4]	@ tmp165,
@ C_Code.c:393:         int numberOfRandomButtons = NumberOfRandomButtons;
	ldr	r3, .L69+12	@ tmp167,
	ldr	r3, [r3]	@ numberOfRandomButtons, NumberOfRandomButtons
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:362:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	movs	r3, #74	@ tmp169,
	ldr	r1, [r0, #60]	@ proc_32(D)->active_bunit, proc_32(D)->active_bunit
@ C_Code.c:362:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldrh	r0, [r1, r3]	@ _24,
@ C_Code.c:394:         if (!numberOfRandomButtons)
	mov	r3, r9	@ numberOfRandomButtons, numberOfRandomButtons
	cmp	r3, #0	@ numberOfRandomButtons,
	bne	.L39		@,
@ C_Code.c:396:             numberOfRandomButtons = TimedHitsDifficultyRam->difficulty;
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.10_2, *TimedHitsDifficultyRam.10_2
	lsls	r3, r3, #27	@ tmp174, *TimedHitsDifficultyRam.10_2,
@ C_Code.c:396:             numberOfRandomButtons = TimedHitsDifficultyRam->difficulty;
	lsrs	r3, r3, #27	@ numberOfRandomButtons, tmp174,
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:362:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldr	r3, .L69+16	@ tmp176,
	bl	.L10		@
@ C_Code.c:367:     if (wepType == 6)
	subs	r0, r0, #5	@ tmp177,
@ C_Code.c:402:         if (!numberOfRandomButtons)
	mov	r3, r9	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:371:     if (wepType == 7)
	cmp	r0, #2	@ tmp177,
	bls	.L67		@,
@ C_Code.c:400:             numberOfRandomButtons = numberOfRandomButtons / 2;
	asrs	r3, r3, #1	@ numberOfRandomButtons, numberOfRandomButtons,
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
.L67:
@ C_Code.c:402:         if (!numberOfRandomButtons)
	cmp	r3, #0	@ numberOfRandomButtons,
	bne	.L42		@,
.L41:
@ C_Code.c:404:             numberOfRandomButtons = 1;
	movs	r3, #1	@ numberOfRandomButtons,
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
.L42:
	ldr	r3, .L69+20	@ tmp197,
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	movs	r6, #0	@ i,
@ C_Code.c:391:         int oppDir = 0;
	movs	r7, #0	@ oppDir,
@ C_Code.c:385:     int keys = proc->buttonsToPress;
	movs	r5, #0	@ keys,
@ C_Code.c:392:         int size = 5; // -1 since we count from 0
	movs	r4, #5	@ size,
	mov	r10, r3	@ tmp197, tmp197
	b	.L49		@
.L45:
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	adds	r6, r6, #1	@ i,
@ C_Code.c:442:             keys |= button;
	orrs	r5, r0	@ keys, button
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	cmp	r9, r6	@ numberOfRandomButtons, i
	ble	.L68		@,
.L49:
@ C_Code.c:409:             num = NextRN_N(size);
	movs	r0, r4	@, size
	bl	.L71		@
@ C_Code.c:410:             button = KeysList[num];
	mov	r3, sp	@ tmp220,
	ldrb	r0, [r3, r0]	@ button, KeysList
@ C_Code.c:413:             if (button & 0xF0)
	cmp	r0, #15	@ button,
	bls	.L45		@,
@ C_Code.c:415:                 if (button == DPAD_RIGHT)
	cmp	r0, #16	@ button,
	beq	.L54		@,
@ C_Code.c:419:                 if (button == DPAD_LEFT)
	cmp	r0, #32	@ button,
	beq	.L55		@,
@ C_Code.c:423:                 if (button == DPAD_UP)
	cmp	r0, #64	@ button,
	beq	.L56		@,
@ C_Code.c:427:                 if (button == DPAD_DOWN)
	cmp	r0, #128	@ button,
	bne	.L46		@,
@ C_Code.c:429:                     oppDir = DPAD_UP;
	movs	r7, #64	@ oppDir,
.L46:
@ C_Code.c:431:                 for (int c = 0; c <= size; ++c)
	cmp	r4, #0	@ size,
	blt	.L45		@,
	mov	r2, sp	@ ivtmp.105,
@ C_Code.c:431:                 for (int c = 0; c <= size; ++c)
	movs	r3, #0	@ c,
	b	.L48		@
.L47:
@ C_Code.c:431:                 for (int c = 0; c <= size; ++c)
	adds	r3, r3, #1	@ c,
@ C_Code.c:431:                 for (int c = 0; c <= size; ++c)
	adds	r2, r2, #1	@ ivtmp.105,
	cmp	r3, r4	@ c, size
	bgt	.L45		@,
.L48:
@ C_Code.c:433:                     if (KeysList[c] == oppDir)
	ldrb	r1, [r2]	@ MEM[(unsigned char *)_51], MEM[(unsigned char *)_51]
@ C_Code.c:433:                     if (KeysList[c] == oppDir)
	cmp	r1, r7	@ MEM[(unsigned char *)_51], oppDir
	bne	.L47		@,
@ C_Code.c:435:                         KeysList[c] = KeysList[size];
	mov	r2, sp	@ tmp221,
@ C_Code.c:435:                         KeysList[c] = KeysList[size];
	mov	r1, sp	@ tmp222,
@ C_Code.c:435:                         KeysList[c] = KeysList[size];
	ldrb	r2, [r2, r4]	@ _12, KeysList
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	adds	r6, r6, #1	@ i,
@ C_Code.c:435:                         KeysList[c] = KeysList[size];
	strb	r2, [r1, r3]	@ _12, KeysList[c_66]
@ C_Code.c:436:                         size--;
	subs	r4, r4, #1	@ size,
@ C_Code.c:442:             keys |= button;
	orrs	r5, r0	@ keys, button
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	cmp	r9, r6	@ numberOfRandomButtons, i
	bgt	.L49		@,
.L68:
@ C_Code.c:444:         proc->buttonsToPress = keys;
	lsls	r3, r5, #16	@ tmp190, keys,
	lsrs	r3, r3, #16	@ prephitmp_56, tmp190,
.L44:
	movs	r2, #80	@ tmp191,
	mov	r1, r8	@ proc, proc
	strh	r3, [r1, r2]	@ prephitmp_56, proc_32(D)->buttonsToPress
	b	.L37		@
.L52:
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
	ldr	r3, .L69+16	@ tmp194,
	bl	.L10		@
@ C_Code.c:367:     if (wepType == 6)
	subs	r0, r0, #5	@ tmp195,
@ C_Code.c:371:     if (wepType == 7)
	cmp	r0, #2	@ tmp195,
	bls	.L43		@,
@ C_Code.c:400:             numberOfRandomButtons = numberOfRandomButtons / 2;
	mov	r3, r9	@ numberOfRandomButtons, numberOfRandomButtons
	lsrs	r3, r3, #31	@ tmp179, numberOfRandomButtons,
	add	r3, r3, r9	@ tmp180, numberOfRandomButtons
	asrs	r3, r3, #1	@ numberOfRandomButtons, tmp180,
	mov	r9, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:402:         if (!numberOfRandomButtons)
	beq	.L41		@,
.L43:
@ C_Code.c:407:         for (int i = 0; i < numberOfRandomButtons; ++i)
	mov	r2, r9	@ numberOfRandomButtons, numberOfRandomButtons
	movs	r3, #0	@ prephitmp_56,
	cmp	r2, #0	@ numberOfRandomButtons,
	ble	.L44		@,
	b	.L42		@
.L54:
@ C_Code.c:417:                     oppDir = DPAD_LEFT;
	movs	r7, #32	@ oppDir,
	b	.L46		@
.L55:
@ C_Code.c:421:                     oppDir = DPAD_RIGHT;
	movs	r7, #16	@ oppDir,
	b	.L46		@
.L56:
@ C_Code.c:425:                     oppDir = DPAD_DOWN;
	movs	r7, #128	@ oppDir,
	b	.L46		@
.L70:
	.align	2
.L69:
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r6, r9	@,
	mov	lr, fp	@,
	mov	r7, r10	@,
	mov	r5, r8	@,
	push	{r5, r6, r7, lr}	@
	sub	sp, sp, #12	@,,
@ C_Code.c:544: void DrawButtonsToPress(TimedHitsProc * proc, int x, int y, int palID)
	movs	r7, r2	@ y, tmp237
	movs	r4, r0	@ proc, tmp235
	mov	r9, r1	@ x, tmp236
	movs	r6, r3	@ palID, tmp238
@ C_Code.c:550:     int keys = GetButtonsToPress(proc);
	bl	GetButtonsToPress		@
@ C_Code.c:552:     if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldr	r2, .L127	@ tmp155,
@ C_Code.c:552:     if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldr	r2, [r2]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
@ C_Code.c:550:     int keys = GetButtonsToPress(proc);
	movs	r5, r0	@ keys, tmp239
@ C_Code.c:552:     if (ChangePaletteWhenButtonIsPressed && proc->frame)
	cmp	r2, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L75		@,
@ C_Code.c:552:     if (ChangePaletteWhenButtonIsPressed && proc->frame)
	movs	r3, #75	@ tmp159,
@ C_Code.c:552:     if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldrb	r3, [r4, r3]	@ tmp160,
	cmp	r3, #0	@ tmp160,
	bne	.L118		@,
.L75:
@ C_Code.c:557:     int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); // OAM2_CHR(0);
	lsls	r6, r6, #28	@ tmp158, palID,
	lsrs	r6, r6, #16	@ _78, tmp158,
.L74:
@ C_Code.c:558:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2);
	mov	r2, r9	@ x, x
	movs	r4, #255	@ tmp161,
	ldr	r3, .L127+4	@ tmp230,
	mov	r8, r3	@ tmp230, tmp230
	ands	r4, r7	@ tmp161, y
	lsls	r1, r2, #23	@ tmp165, x,
	mov	fp, r4	@ _11, tmp161
	movs	r2, r4	@, _11
	movs	r0, #2	@,
	ldr	r4, .L127+8	@ tmp231,
	adds	r3, r3, #32	@ tmp163,
	lsrs	r1, r1, #23	@ tmp164, tmp165,
	str	r6, [sp]	@ _78,
	bl	.L129		@
@ C_Code.c:559:     x += 32;
	mov	r1, r9	@ x, x
@ C_Code.c:560:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2);
	mov	r3, r8	@ tmp168, tmp230
@ C_Code.c:559:     x += 32;
	adds	r1, r1, #32	@ x,
@ C_Code.c:560:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2);
	lsls	r1, r1, #23	@ tmp171, x,
	mov	r2, fp	@, _11
	adds	r3, r3, #40	@ tmp168,
	lsrs	r1, r1, #23	@ tmp170, tmp171,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	bl	.L129		@
	mov	r3, r8	@ ivtmp.119, tmp230
	mov	r1, r8	@ _76, tmp230
@ C_Code.c:558:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2);
	mov	r10, r4	@ tmp231, tmp231
@ C_Code.c:452:     int c = 0;
	movs	r2, #0	@ c,
@ C_Code.c:561:     y += 16;
	adds	r7, r7, #16	@ y,
	adds	r3, r3, #48	@ ivtmp.119,
	adds	r1, r1, #54	@ _76,
.L77:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r4, [r3]	@ MEM[(unsigned char *)_96], MEM[(unsigned char *)_96]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r4, r5	@ tmp175, keys
@ C_Code.c:457:             c++;
	subs	r0, r4, #1	@ tmp234, tmp175
	sbcs	r4, r4, r0	@ tmp233, tmp175, tmp234
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r3, r3, #1	@ ivtmp.119,
@ C_Code.c:457:             c++;
	adds	r2, r2, r4	@ c, c, tmp233
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r1, r3	@ _76, ivtmp.119
	bne	.L77		@,
@ C_Code.c:565:     if (count == 1)
	cmp	r2, #1	@ c,
	beq	.L119		@,
@ C_Code.c:571:         x += 8;
	mov	r3, r9	@ x, x
	adds	r4, r3, #4	@ x, x,
@ C_Code.c:569:     if (count == 2)
	cmp	r2, #2	@ c,
	bne	.L120		@,
.L79:
@ C_Code.c:578:     if (keys & A_BUTTON)
	lsls	r3, r5, #31	@ tmp241, keys,
	bmi	.L121		@,
.L81:
@ C_Code.c:583:     if (keys & B_BUTTON)
	lsls	r3, r5, #30	@ tmp242, keys,
	bmi	.L122		@,
.L82:
@ C_Code.c:588:     if (keys & DPAD_LEFT)
	lsls	r3, r5, #26	@ tmp243, keys,
	bmi	.L123		@,
.L83:
@ C_Code.c:593:     if (keys & DPAD_RIGHT)
	lsls	r3, r5, #27	@ tmp244, keys,
	bmi	.L124		@,
.L84:
@ C_Code.c:598:     if (keys & DPAD_UP)
	lsls	r3, r5, #25	@ tmp245, keys,
	bmi	.L125		@,
.L85:
@ C_Code.c:603:     if (keys & DPAD_DOWN)
	lsls	r5, r5, #24	@ tmp246, keys,
	bmi	.L126		@,
.L72:
@ C_Code.c:608: }
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
.L118:
	movs	r6, #224	@ _78,
	lsls	r6, r6, #8	@ _78, _78,
	b	.L74		@
.L119:
@ C_Code.c:567:         x += 16;
	mov	r4, r9	@ x, x
	adds	r4, r4, #12	@ x,
@ C_Code.c:578:     if (keys & A_BUTTON)
	lsls	r3, r5, #31	@ tmp241, keys,
	bpl	.L81		@,
.L121:
@ C_Code.c:580:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2);
	mov	r3, r8	@ tmp179, tmp230
	movs	r2, #255	@ tmp180,
	lsls	r1, r4, #23	@ tmp183, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #56	@ tmp179,
	ands	r2, r7	@ tmp181, y
	lsrs	r1, r1, #23	@ tmp182, tmp183,
	bl	.L71		@
@ C_Code.c:581:         x += 18;
	adds	r4, r4, #18	@ x,
@ C_Code.c:583:     if (keys & B_BUTTON)
	lsls	r3, r5, #30	@ tmp242, keys,
	bpl	.L82		@,
.L122:
@ C_Code.c:585:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2);
	mov	r3, r8	@ tmp188, tmp230
	movs	r2, #255	@ tmp189,
	lsls	r1, r4, #23	@ tmp192, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #64	@ tmp188,
	ands	r2, r7	@ tmp190, y
	lsrs	r1, r1, #23	@ tmp191, tmp192,
	bl	.L71		@
@ C_Code.c:586:         x += 18;
	adds	r4, r4, #18	@ x,
@ C_Code.c:588:     if (keys & DPAD_LEFT)
	lsls	r3, r5, #26	@ tmp243, keys,
	bpl	.L83		@,
.L123:
@ C_Code.c:590:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2);
	mov	r3, r8	@ tmp197, tmp230
	movs	r2, #255	@ tmp198,
	lsls	r1, r4, #23	@ tmp201, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #72	@ tmp197,
	ands	r2, r7	@ tmp199, y
	lsrs	r1, r1, #23	@ tmp200, tmp201,
	bl	.L71		@
@ C_Code.c:591:         x += 18;
	adds	r4, r4, #18	@ x,
@ C_Code.c:593:     if (keys & DPAD_RIGHT)
	lsls	r3, r5, #27	@ tmp244, keys,
	bpl	.L84		@,
.L124:
@ C_Code.c:595:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2);
	mov	r3, r8	@ tmp206, tmp230
	movs	r2, #255	@ tmp207,
	lsls	r1, r4, #23	@ tmp210, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #80	@ tmp206,
	ands	r2, r7	@ tmp208, y
	lsrs	r1, r1, #23	@ tmp209, tmp210,
	bl	.L71		@
@ C_Code.c:596:         x += 18;
	adds	r4, r4, #18	@ x,
@ C_Code.c:598:     if (keys & DPAD_UP)
	lsls	r3, r5, #25	@ tmp245, keys,
	bpl	.L85		@,
.L125:
@ C_Code.c:600:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2);
	mov	r3, r8	@ tmp215, tmp230
	movs	r2, #255	@ tmp216,
	lsls	r1, r4, #23	@ tmp219, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #88	@ tmp215,
	ands	r2, r7	@ tmp217, y
	lsrs	r1, r1, #23	@ tmp218, tmp219,
	bl	.L71		@
@ C_Code.c:601:         x += 18;
	adds	r4, r4, #18	@ x,
@ C_Code.c:603:     if (keys & DPAD_DOWN)
	lsls	r5, r5, #24	@ tmp246, keys,
	bpl	.L72		@,
.L126:
@ C_Code.c:605:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2);
	mov	r3, r8	@ tmp230, tmp230
	movs	r2, #255	@ tmp225,
	lsls	r1, r4, #23	@ tmp228, x,
	movs	r0, #2	@,
	str	r6, [sp]	@ _78,
	adds	r3, r3, #96	@ tmp230,
	ands	r2, r7	@ tmp226, y
	lsrs	r1, r1, #23	@ tmp227, tmp228,
	bl	.L71		@
	b	.L72		@
.L120:
@ C_Code.c:562:     x -= 36;
	subs	r4, r4, #8	@ x,
	b	.L79		@
.L128:
	.align	2
.L127:
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
	ldr	r1, .L136	@ tmp122,
	movs	r2, r1	@ ivtmp.130, tmp122
	push	{r4, r5, lr}	@
@ C_Code.c:451: {
	movs	r4, r0	@ keys, tmp129
@ C_Code.c:452:     int c = 0;
	movs	r0, #0	@ <retval>,
	adds	r2, r2, #48	@ ivtmp.130,
	adds	r1, r1, #54	@ _15,
.L132:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ MEM[(unsigned char *)_34], MEM[(unsigned char *)_34]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r3, r4	@ tmp124, keys
@ C_Code.c:457:             c++;
	subs	r5, r3, #1	@ tmp128, tmp124
	sbcs	r3, r3, r5	@ tmp127, tmp124, tmp128
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.130,
@ C_Code.c:457:             c++;
	adds	r0, r0, r3	@ <retval>, <retval>, tmp127
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r2, r1	@ ivtmp.130, _15
	bne	.L132		@,
@ C_Code.c:461: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r1}
	bx	r1
.L137:
	.align	2
.L136:
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
@ C_Code.c:464: {
	movs	r4, r1	@ keys, tmp180
@ C_Code.c:465:     int reqKeys = GetButtonsToPress(proc);
	bl	GetButtonsToPress		@
	ldr	r5, .L164	@ tmp150,
	movs	r2, r5	@ ivtmp.153, tmp150
	adds	r2, r2, #48	@ ivtmp.153,
	mov	ip, r0	@ reqKeys, tmp181
@ C_Code.c:466:     int count = CountKeysPressed(reqKeys);
	movs	r1, r2	@ ivtmp.165, ivtmp.153
@ C_Code.c:452:     int c = 0;
	movs	r6, #0	@ c,
	adds	r5, r5, #54	@ _58,
.L140:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	mov	r0, ip	@ reqKeys, reqKeys
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r3, [r1]	@ MEM[(unsigned char *)_148], MEM[(unsigned char *)_148]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r3, r0	@ tmp152, reqKeys
@ C_Code.c:457:             c++;
	subs	r7, r3, #1	@ tmp169, tmp152
	sbcs	r3, r3, r7	@ tmp168, tmp152, tmp169
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r1, r1, #1	@ ivtmp.165,
@ C_Code.c:457:             c++;
	adds	r6, r6, r3	@ c, c, tmp168
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r5, r1	@ _58, ivtmp.165
	bne	.L140		@,
	movs	r1, r2	@ ivtmp.159, ivtmp.153
@ C_Code.c:452:     int c = 0;
	movs	r7, #0	@ c,
.L142:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r3, [r1]	@ MEM[(unsigned char *)_124], MEM[(unsigned char *)_124]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r3, r4	@ tmp154, keys
@ C_Code.c:457:             c++;
	subs	r0, r3, #1	@ tmp172, tmp154
	sbcs	r3, r3, r0	@ tmp171, tmp154, tmp172
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r1, r1, #1	@ ivtmp.159,
@ C_Code.c:457:             c++;
	adds	r7, r7, r3	@ c, c, tmp171
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r5, r1	@ _58, ivtmp.159
	bne	.L142		@,
@ C_Code.c:452:     int c = 0;
	movs	r1, #0	@ c,
@ C_Code.c:467:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r6, r7	@ c, c
	blt	.L143		@,
.L145:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ MEM[(unsigned char *)_88], MEM[(unsigned char *)_88]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r3, r4	@ tmp156, keys
@ C_Code.c:457:             c++;
	subs	r7, r3, #1	@ tmp175, tmp156
	sbcs	r3, r3, r7	@ tmp174, tmp156, tmp175
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.153,
@ C_Code.c:457:             c++;
	adds	r1, r1, r3	@ c, c, tmp174
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r2, r5	@ ivtmp.153, _58
	bne	.L145		@,
@ C_Code.c:467:     if (ABS(count - CountKeysPressed(keys)) > 1)
	subs	r1, r6, r1	@ tmp157, c, c
@ C_Code.c:467:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r1, #1	@ tmp157,
	bgt	.L151		@,
.L147:
@ C_Code.c:471:     reqKeys &= ~keys; // only 0 if we hit all the correct keys (and possibly 1 extra)
	mov	r0, ip	@ reqKeys, reqKeys
	bics	r0, r4	@ reqKeys, keys
@ C_Code.c:472:     return (!reqKeys);
	rsbs	r3, r0, #0	@ tmp165, reqKeys
	adcs	r0, r0, r3	@ <retval>, reqKeys, tmp165
.L138:
@ C_Code.c:473: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L143:
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ MEM[(unsigned char *)_69], MEM[(unsigned char *)_69]
@ C_Code.c:455:         if (keys & RomKeysList[i])
	ands	r3, r4	@ tmp159, keys
@ C_Code.c:457:             c++;
	subs	r7, r3, #1	@ tmp178, tmp159
	sbcs	r3, r3, r7	@ tmp177, tmp159, tmp178
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.153,
@ C_Code.c:457:             c++;
	adds	r1, r1, r3	@ c, c, tmp177
@ C_Code.c:453:     for (int i = 0; i < 6; ++i)
	cmp	r2, r5	@ ivtmp.153, _58
	bne	.L143		@,
@ C_Code.c:467:     if (ABS(count - CountKeysPressed(keys)) > 1)
	subs	r1, r1, r6	@ tmp160, c, c
@ C_Code.c:467:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r1, #1	@ tmp160,
	ble	.L147		@,
.L151:
@ C_Code.c:469:         return false;
	movs	r0, #0	@ <retval>,
	b	.L138		@
.L165:
	.align	2
.L164:
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
@ C_Code.c:476:     struct Anim * anim = proc->anim;
	ldr	r5, [r0, #44]	@ anim, proc_17(D)->anim
@ C_Code.c:477:     u32 instruction = *anim->pScrCurrent++;
	ldr	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:477:     u32 instruction = *anim->pScrCurrent++;
	adds	r3, r6, #4	@ tmp130, _1,
	str	r3, [r5, #32]	@ tmp130, anim_18->pScrCurrent
@ C_Code.c:478:     if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND)
	movs	r3, #252	@ tmp132,
@ C_Code.c:475: {
	movs	r4, r0	@ proc, tmp155
@ C_Code.c:478:     if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND)
	movs	r0, #160	@ tmp133,
@ C_Code.c:477:     u32 instruction = *anim->pScrCurrent++;
	ldr	r2, [r6]	@ instruction, *_1
@ C_Code.c:478:     if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND)
	lsls	r3, r3, #22	@ tmp132, tmp132,
	ands	r3, r2	@ tmp131, instruction
	lsls	r0, r0, #19	@ tmp133, tmp133,
	cmp	r3, r0	@ tmp131, tmp133
	beq	.L173		@,
.L167:
@ C_Code.c:492:     if (PressedSpecificKeys(proc, keys))
	movs	r0, r4	@, proc
@ C_Code.c:491:     instruction = *anim->pScrCurrent--;
	str	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:492:     if (PressedSpecificKeys(proc, keys))
	bl	PressedSpecificKeys		@
@ C_Code.c:492:     if (PressedSpecificKeys(proc, keys))
	cmp	r0, #0	@ tmp157,
	beq	.L166		@,
@ C_Code.c:494:         if (!proc->frame)
	movs	r3, #75	@ tmp147,
@ C_Code.c:494:         if (!proc->frame)
	ldrb	r2, [r4, r3]	@ tmp148,
	cmp	r2, #0	@ tmp148,
	beq	.L174		@,
.L166:
@ C_Code.c:500: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L173:
@ C_Code.c:480:         if (ANINS_COMMAND_GET_ID(instruction) == 4)
	movs	r3, #255	@ tmp134,
	ands	r3, r2	@ _4, instruction
@ C_Code.c:480:         if (ANINS_COMMAND_GET_ID(instruction) == 4)
	cmp	r3, #4	@ _4,
	beq	.L175		@,
@ C_Code.c:485:         if (ANINS_COMMAND_GET_ID(instruction) == 0xF)
	cmp	r3, #15	@ _4,
	bne	.L167		@,
@ C_Code.c:487:             proc->codefframe = proc->timer;
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #62	@ tmp143,
	strb	r2, [r4, r3]	@ proc_17(D)->timer, proc_17(D)->codefframe
@ C_Code.c:488:             proc->timer2 = 0;
	movs	r2, #0	@ tmp145,
	subs	r3, r3, #9	@ tmp144,
	strb	r2, [r4, r3]	@ tmp145, proc_17(D)->timer2
	b	.L167		@
.L174:
@ C_Code.c:497:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	movs	r1, #128	@,
	movs	r0, #159	@,
@ C_Code.c:496:             proc->frame = proc->timer;     // locate is side for stereo?
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
@ C_Code.c:497:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	lsls	r1, r1, #1	@,,
@ C_Code.c:496:             proc->frame = proc->timer;     // locate is side for stereo?
	strb	r2, [r4, r3]	@ proc_17(D)->timer, proc_17(D)->frame
@ C_Code.c:497:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	lsls	r0, r0, #1	@,,
	movs	r2, #120	@,
	ldr	r4, .L176	@ tmp154,
	subs	r3, r3, #74	@,
	bl	.L129		@
@ C_Code.c:500: }
	b	.L166		@
.L175:
@ C_Code.c:482:             proc->code4frame = proc->timer;
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #72	@ tmp137,
	strb	r2, [r4, r3]	@ proc_17(D)->timer, proc_17(D)->code4frame
@ C_Code.c:483:             proc->timer2 = 0;
	movs	r2, #0	@ tmp139,
	subs	r3, r3, #8	@ tmp138,
	strb	r2, [r4, r3]	@ tmp139, proc_17(D)->timer2
	b	.L167		@
.L177:
	.align	2
.L176:
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
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:502: {
	push	{r4, lr}	@
@ C_Code.c:503:     if (proc->frame)
	cmp	r3, #0	@ _1,
	beq	.L178		@,
@ C_Code.c:505:         if (proc->codefframe != 0xFF)
	movs	r2, #77	@ tmp129,
@ C_Code.c:507:             if (ABS(proc->codefframe - proc->frame) < (LenienceFrames))
	ldr	r1, .L189	@ tmp130,
@ C_Code.c:505:         if (proc->codefframe != 0xFF)
	ldrb	r2, [r0, r2]	@ _2,
@ C_Code.c:507:             if (ABS(proc->codefframe - proc->frame) < (LenienceFrames))
	ldr	r1, [r1]	@ pretmp_33, LenienceFrames
@ C_Code.c:505:         if (proc->codefframe != 0xFF)
	cmp	r2, #255	@ _2,
	beq	.L181		@,
.L188:
@ C_Code.c:507:             if (ABS(proc->codefframe - proc->frame) < (LenienceFrames))
	subs	r2, r2, r3	@ tmp131, _2, _1
	asrs	r4, r2, #31	@ tmp147, tmp131,
	adds	r2, r2, r4	@ tmp132, tmp131, tmp147
	eors	r2, r4	@ tmp132, tmp147
@ C_Code.c:507:             if (ABS(proc->codefframe - proc->frame) < (LenienceFrames))
	cmp	r2, r1	@ tmp132, pretmp_33
	bge	.L182		@,
@ C_Code.c:509:                 proc->hitOnTime = true;
	movs	r2, #69	@ tmp133,
	movs	r4, #1	@ tmp134,
	strb	r4, [r0, r2]	@ tmp134, proc_21(D)->hitOnTime
.L182:
@ C_Code.c:519:         if ((proc->timer - proc->frame) < LenienceFrames)
	ldr	r2, [r0, #52]	@ proc_21(D)->timer, proc_21(D)->timer
	subs	r3, r2, r3	@ tmp139, proc_21(D)->timer, _1
@ C_Code.c:519:         if ((proc->timer - proc->frame) < LenienceFrames)
	cmp	r3, r1	@ tmp139, pretmp_33
	bge	.L178		@,
@ C_Code.c:521:             proc->hitOnTime = true;
	movs	r3, #69	@ tmp141,
	movs	r2, #1	@ tmp142,
	strb	r2, [r0, r3]	@ tmp142, proc_21(D)->hitOnTime
.L178:
@ C_Code.c:524: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L181:
@ C_Code.c:512:         else if (proc->code4frame != 0xFF)
	movs	r2, #76	@ tmp136,
	ldrb	r2, [r0, r2]	@ _8,
@ C_Code.c:512:         else if (proc->code4frame != 0xFF)
	cmp	r2, #255	@ _8,
	bne	.L188		@,
	b	.L182		@
.L190:
	.align	2
.L189:
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
	ldr	r3, .L192	@ tmp118,
@ C_Code.c:529: }
	@ sp needed	@
@ C_Code.c:528:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldrb	r0, [r3, #31]	@ tmp120,
	movs	r3, #127	@ tmp122,
	bics	r0, r3	@ tmp117, tmp122
@ C_Code.c:529: }
	bx	lr
.L193:
	.align	2
.L192:
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
	ldr	r3, .L198	@ tmp120,
@ C_Code.c:533:     if (CheatCodeOn())
	ldrb	r3, [r3, #31]	@ tmp123,
	cmp	r3, #127	@ tmp123,
	bhi	.L197		@,
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r3, .L198+4	@ tmp124,
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L197		@,
@ C_Code.c:541:     return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp126,
	ldrb	r0, [r0, r3]	@ <retval>,
	b	.L194		@
.L197:
@ C_Code.c:535:         return true;
	movs	r0, #1	@ <retval>,
.L194:
@ C_Code.c:542: }
	@ sp needed	@
	bx	lr
.L199:
	.align	2
.L198:
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
	ldr	r4, .L205	@ tmp119,
@ C_Code.c:546:     if (!DisplayPress)
	ldr	r4, [r4]	@ DisplayPress, DisplayPress
	cmp	r4, #0	@ DisplayPress,
	beq	.L200		@,
	bl	DrawButtonsToPress.part.0		@
.L200:
@ C_Code.c:608: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L206:
	.align	2
.L205:
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
	movs	r1, #11	@ tmp131,
	movs	r3, #192	@ tmp132,
	ldrsb	r1, [r0, r1]	@ tmp131,
	ands	r3, r1	@ _6, tmp131
@ C_Code.c:726:     if (success)
	cmp	r2, #0	@ tmp164,
	beq	.L208		@,
@ C_Code.c:728:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _6,
	beq	.L216		@,
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L217	@ tmp136,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam.25_16, TimedHitsDifficultyRam
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.25_16, *TimedHitsDifficultyRam.25_16
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r2, r3, #26	@ tmp165, *TimedHitsDifficultyRam.25_16,
	bmi	.L211		@,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r2, .L217+4	@ tmp146,
	ldr	r2, [r2]	@ DifficultyThreshold.27_21, DifficultyThreshold
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r3, r3, #27	@ tmp151, *TimedHitsDifficultyRam.25_16,
	lsrs	r3, r3, #27	@ tmp152, tmp151,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r3, r2	@ tmp152, DifficultyThreshold.27_21
	bge	.L212		@,
@ C_Code.c:742:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r3, .L217+8	@ tmp154,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r2, r3	@ DifficultyThreshold.27_21, NumberOfRandomButtons
	bgt	.L211		@,
.L212:
@ C_Code.c:744:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r2, .L217+12	@ tmp156,
	ldr	r3, .L217+16	@ tmp157,
	ldr	r0, [r2]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r3, [r3]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r0, r0, r3	@ <retval>, BonusDamagePercent, DifficultyBonusPercent
	b	.L207		@
.L208:
@ C_Code.c:749:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _6,
	beq	.L214		@,
@ C_Code.c:753:     return FailedHitDamagePercent;
	ldr	r3, .L217+20	@ tmp161,
	ldr	r0, [r3]	@ <retval>,
.L207:
@ C_Code.c:754: }
	@ sp needed	@
	bx	lr
.L216:
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r3, .L217+24	@ tmp133,
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L214		@,
@ C_Code.c:732:                 return ReducedDamagePercent;
	ldr	r3, .L217+28	@ tmp135,
	ldr	r0, [r3]	@ <retval>,
	b	.L207		@
.L211:
@ C_Code.c:747:         return BonusDamagePercent;
	ldr	r3, .L217+12	@ tmp160,
	ldr	r0, [r3]	@ <retval>,
	b	.L207		@
.L214:
@ C_Code.c:736:                 return 100;
	movs	r0, #100	@ <retval>,
	b	.L207		@
.L218:
	.align	2
.L217:
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
	movs	r1, #11	@ tmp131,
	movs	r3, #192	@ tmp132,
	ldrsb	r1, [r0, r1]	@ tmp131,
	ands	r3, r1	@ _11, tmp131
@ C_Code.c:726:     if (success)
	cmp	r2, #0	@ tmp164,
	beq	.L220		@,
@ C_Code.c:728:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _11,
	beq	.L228		@,
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L229	@ tmp136,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam.25_17, TimedHitsDifficultyRam
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.25_17, *TimedHitsDifficultyRam.25_17
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r2, r3, #26	@ tmp165, *TimedHitsDifficultyRam.25_17,
	bmi	.L223		@,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r2, .L229+4	@ tmp146,
	ldr	r2, [r2]	@ DifficultyThreshold.27_22, DifficultyThreshold
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r3, r3, #27	@ tmp151, *TimedHitsDifficultyRam.25_17,
	lsrs	r3, r3, #27	@ tmp152, tmp151,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r3, r2	@ tmp152, DifficultyThreshold.27_22
	bge	.L224		@,
@ C_Code.c:742:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r3, .L229+8	@ tmp154,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r2, r3	@ DifficultyThreshold.27_22, NumberOfRandomButtons
	bgt	.L223		@,
.L224:
@ C_Code.c:744:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r2, .L229+12	@ tmp156,
	ldr	r3, .L229+16	@ tmp157,
	ldr	r0, [r2]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r3, [r3]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r0, r0, r3	@ <retval>, BonusDamagePercent, DifficultyBonusPercent
	b	.L219		@
.L220:
@ C_Code.c:749:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _11,
	beq	.L226		@,
@ C_Code.c:753:     return FailedHitDamagePercent;
	ldr	r3, .L229+20	@ tmp161,
	ldr	r0, [r3]	@ <retval>,
.L219:
@ C_Code.c:759: }
	@ sp needed	@
	bx	lr
.L228:
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r3, .L229+24	@ tmp133,
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L226		@,
@ C_Code.c:732:                 return ReducedDamagePercent;
	ldr	r3, .L229+28	@ tmp135,
	ldr	r0, [r3]	@ <retval>,
	b	.L219		@
.L223:
@ C_Code.c:747:         return BonusDamagePercent;
	ldr	r3, .L229+12	@ tmp160,
	ldr	r0, [r3]	@ <retval>,
	b	.L219		@
.L226:
@ C_Code.c:736:                 return 100;
	movs	r0, #100	@ <retval>,
@ C_Code.c:758:     return GetDefaultDamagePercent(active_bunit, opp_bunit, success);
	b	.L219		@
.L230:
	.align	2
.L229:
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
@ C_Code.c:774:     for (int i = id; i < 22; i += 2)
	cmp	r0, #21	@ id,
	bgt	.L231		@,
	ldr	r3, .L241	@ tmp128,
	lsls	r2, r0, #1	@ tmp127, id,
@ C_Code.c:777:         if (hp == 0xffff)
	ldr	r5, .L241+4	@ tmp129,
	adds	r2, r2, r3	@ ivtmp.195, tmp127, tmp128
	b	.L235		@
.L233:
	movs	r4, #0	@ _4,
@ C_Code.c:793:         else if (hp >= difference)
	cmp	r3, r1	@ _1, difference
	blt	.L234		@,
@ C_Code.c:795:             gEfxHpLut[i] -= difference;
	subs	r3, r3, r1	@ tmp132, _1, difference
.L239:
	lsls	r3, r3, #16	@ tmp133, tmp132,
	lsrs	r4, r3, #16	@ _4, tmp133,
.L234:
@ C_Code.c:774:     for (int i = id; i < 22; i += 2)
	adds	r0, r0, #2	@ id,
@ C_Code.c:790:                 gEfxHpLut[i] = 0;
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:774:     for (int i = id; i < 22; i += 2)
	adds	r2, r2, #4	@ ivtmp.195,
	cmp	r0, #21	@ id,
	bgt	.L231		@,
.L235:
@ C_Code.c:776:         hp = gEfxHpLut[i];
	ldrh	r3, [r2]	@ _1, MEM[(short unsigned int *)_18]
@ C_Code.c:777:         if (hp == 0xffff)
	cmp	r3, r5	@ _1, tmp129
	beq	.L231		@,
@ C_Code.c:781:         if (difference < 0)
	cmp	r1, #0	@ difference,
	bge	.L233		@,
@ C_Code.c:783:             hp += difference;
	adds	r3, r3, r1	@ hp, _1, difference
	movs	r4, #0	@ _4,
@ C_Code.c:784:             if (hp > 0)
	cmp	r3, #0	@ hp,
	bgt	.L239		@,
@ C_Code.c:774:     for (int i = id; i < 22; i += 2)
	adds	r0, r0, #2	@ id,
@ C_Code.c:790:                 gEfxHpLut[i] = 0;
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:774:     for (int i = id; i < 22; i += 2)
	adds	r2, r2, #4	@ ivtmp.195,
	cmp	r0, #21	@ id,
	ble	.L235		@,
.L231:
@ C_Code.c:802: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L242:
	.align	2
.L241:
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
@ C_Code.c:812:     if (newHp > 127)
	cmp	r3, #127	@ newHp,
	ble	.L244		@,
	movs	r3, #127	@ _8,
.L245:
@ C_Code.c:816:     int hp = gEkrGaugeHp[side];
	ldr	r5, [sp, #16]	@ tmp166, side
	ldr	r4, .L255	@ tmp134,
	lsls	r5, r5, #1	@ tmp135, tmp166,
	ldrsh	r4, [r5, r4]	@ _1, gEkrGaugeHp
@ C_Code.c:817:     some_bunit->unit.curHP = newHp;
	strb	r3, [r2, #19]	@ _8, some_bunit_21(D)->unit.curHP
@ C_Code.c:818:     if (hp == newHp)
	cmp	r3, r4	@ _8, _1
	beq	.L243		@,
@ C_Code.c:825:         diff = 0 - newDamage;
	ldr	r2, [sp, #20]	@ tmp167, newDamage
	rsbs	r5, r2, #0	@ diff, tmp167
@ C_Code.c:823:     if (newDamage)
	cmp	r2, #0	@ tmp168,
	beq	.L253		@,
@ C_Code.c:828:     if (proc->side == side)
	movs	r2, #74	@ tmp137,
@ C_Code.c:828:     if (proc->side == side)
	ldr	r6, [sp, #16]	@ tmp169, side
@ C_Code.c:828:     if (proc->side == side)
	ldrb	r2, [r0, r2]	@ tmp138,
@ C_Code.c:828:     if (proc->side == side)
	cmp	r2, r6	@ tmp138, tmp169
	beq	.L254		@,
.L243:
@ C_Code.c:847: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L244:
	mvns	r4, r3	@ tmp154, newHp
	asrs	r4, r4, #31	@ tmp153, tmp154,
	ands	r3, r4	@ _8, tmp153
	b	.L245		@
.L253:
@ C_Code.c:828:     if (proc->side == side)
	movs	r2, #74	@ tmp137,
@ C_Code.c:828:     if (proc->side == side)
	ldr	r6, [sp, #16]	@ tmp169, side
@ C_Code.c:828:     if (proc->side == side)
	ldrb	r2, [r0, r2]	@ tmp138,
@ C_Code.c:822:     int diff = newHp - hp;
	subs	r5, r3, r4	@ diff, _8, _1
@ C_Code.c:828:     if (proc->side == side)
	cmp	r2, r6	@ tmp138, tmp169
	bne	.L243		@,
.L254:
@ C_Code.c:831:         if (UsingSkillSys)
	ldr	r2, .L255+4	@ tmp140,
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	asrs	r6, r5, #31	@ tmp162, diff,
@ C_Code.c:830:         HpProc->cur = hp;
	strh	r4, [r1, #46]	@ _1, HpProc_27(D)->cur
@ C_Code.c:831:         if (UsingSkillSys)
	ldr	r4, [r2]	@ UsingSkillSys.32_5, UsingSkillSys
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	adds	r2, r5, r6	@ tmp141, diff, tmp162
	eors	r2, r6	@ tmp141, tmp162
@ C_Code.c:833:             HpProc->post = newHp;
	lsls	r3, r3, #16	@ _34, _8,
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	lsls	r2, r2, #24	@ tmp142, tmp141,
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	ldr	r0, [r0, #56]	@ pretmp_39, proc_26(D)->currentRound
@ C_Code.c:833:             HpProc->post = newHp;
	asrs	r3, r3, #16	@ _34, _34,
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	asrs	r2, r2, #24	@ _40, tmp142,
@ C_Code.c:831:         if (UsingSkillSys)
	cmp	r4, #0	@ UsingSkillSys.32_5,
	beq	.L251		@,
@ C_Code.c:833:             HpProc->post = newHp;
	movs	r6, #80	@ tmp143,
	strh	r3, [r1, r6]	@ _34, HpProc_27(D)->post
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r0, #3]	@ _40, pretmp_39->hpChange
@ C_Code.c:842:         if (UsingSkillSys == 2)
	cmp	r4, #2	@ UsingSkillSys.32_5,
	bne	.L243		@,
@ C_Code.c:844:             proc->currentRound->overDmg = diff;
	strh	r5, [r0, #6]	@ diff, pretmp_39->overDmg
	b	.L243		@
.L251:
@ C_Code.c:837:             HpProc->postHpAtkrSS = newHp >> 16;
	movs	r5, #82	@ tmp146,
	strh	r4, [r1, r5]	@ UsingSkillSys.32_5, HpProc_27(D)->postHpAtkrSS
@ C_Code.c:838:             HpProc->post = newHp;
	movs	r4, #80	@ tmp149,
	strh	r3, [r1, r4]	@ _34, HpProc_27(D)->post
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r0, #3]	@ _40, pretmp_39->hpChange
	b	.L243		@
.L256:
	.align	2
.L255:
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
	movs	r7, r2	@ active_bunit, tmp282
	movs	r2, r3	@ opp_bunit, tmp283
@ C_Code.c:855:     int side = proc->side;
	movs	r3, #74	@ tmp176,
@ C_Code.c:854: {
	push	{lr}	@
	sub	sp, sp, #8	@,,
@ C_Code.c:854: {
	movs	r6, r1	@ HpProc, tmp281
@ C_Code.c:855:     int side = proc->side;
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:854: {
	ldr	r1, [sp, #36]	@ hp, hp
	movs	r5, r0	@ proc, tmp280
@ C_Code.c:855:     int side = proc->side;
	mov	r8, r3	@ _1, _1
@ C_Code.c:857:     if (hp < 0)
	cmp	r1, #0	@ hp,
	bge	.L258		@,
@ C_Code.c:859:         hp = gEkrGaugeHp[side];
	mov	r1, r8	@ _1, _1
	ldr	r3, .L292	@ tmp177,
	lsls	r1, r1, #1	@ tmp178, _1,
@ C_Code.c:859:         hp = gEkrGaugeHp[side];
	ldrsh	r1, [r1, r3]	@ hp, gEkrGaugeHp
.L258:
@ C_Code.c:861:     if (hp <= 0)
	cmp	r1, #0	@ hp,
	ble	.L288		@,
@ C_Code.c:914:         HpProc->death = false;
	movs	r3, #41	@ tmp242,
	movs	r2, #0	@ tmp243,
	strb	r2, [r6, r3]	@ tmp243, HpProc_43(D)->death
.L267:
@ C_Code.c:920:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	movs	r0, #11	@ tmp246,
@ C_Code.c:920:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	ldr	r5, .L292+4	@ tmp245,
@ C_Code.c:920:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	ldr	r4, .L292+8	@ tmp274,
	ldrsb	r0, [r5, r0]	@ tmp246,
	bl	.L129		@
@ C_Code.c:921:     if (UNIT_IS_VALID(unit))
	cmp	r0, #0	@ unit,
	beq	.L271		@,
@ C_Code.c:921:     if (UNIT_IS_VALID(unit))
	ldr	r3, [r0]	@ unit_68->pCharacterData, unit_68->pCharacterData
	cmp	r3, #0	@ unit_68->pCharacterData,
	beq	.L271		@,
@ C_Code.c:923:         gBattleActor.unit.exp = unit->exp;
	ldrb	r3, [r0, #9]	@ _18,
@ C_Code.c:923:         gBattleActor.unit.exp = unit->exp;
	strb	r3, [r5, #9]	@ _18, gBattleActor.unit.exp
@ C_Code.c:924:         gBattleActor.unit.level = unit->level;
	movs	r3, #8	@ _19,
	ldrsb	r3, [r0, r3]	@ _19,* _19
@ C_Code.c:924:         gBattleActor.unit.level = unit->level;
	strb	r3, [r5, #8]	@ _19, gBattleActor.unit.level
.L271:
@ C_Code.c:927:     unit = GetUnit(gBattleTarget.unit.index);
	movs	r0, #11	@ tmp254,
@ C_Code.c:927:     unit = GetUnit(gBattleTarget.unit.index);
	ldr	r5, .L292+12	@ tmp253,
@ C_Code.c:927:     unit = GetUnit(gBattleTarget.unit.index);
	ldrsb	r0, [r5, r0]	@ tmp254,
	bl	.L129		@
@ C_Code.c:928:     if (UNIT_IS_VALID(unit))
	cmp	r0, #0	@ unit,
	beq	.L272		@,
@ C_Code.c:928:     if (UNIT_IS_VALID(unit))
	ldr	r3, [r0]	@ unit_72->pCharacterData, unit_72->pCharacterData
	cmp	r3, #0	@ unit_72->pCharacterData,
	beq	.L272		@,
@ C_Code.c:930:         gBattleTarget.unit.exp = unit->exp;
	ldrb	r3, [r0, #9]	@ _23,
@ C_Code.c:930:         gBattleTarget.unit.exp = unit->exp;
	strb	r3, [r5, #9]	@ _23, gBattleTarget.unit.exp
@ C_Code.c:931:         gBattleTarget.unit.level = unit->level;
	movs	r3, #8	@ _24,
	ldrsb	r3, [r0, r3]	@ _24,* _24
@ C_Code.c:931:         gBattleTarget.unit.level = unit->level;
	strb	r3, [r5, #8]	@ _24, gBattleTarget.unit.level
.L272:
@ C_Code.c:935:     BattleApplyExpGains(); // update exp
	ldr	r3, .L292+16	@ tmp261,
	bl	.L10		@
@ C_Code.c:936:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldr	r2, .L292+20	@ tmp264,
	ldr	r1, [r2]	@ gpEkrBattleUnitLeft, gpEkrBattleUnitLeft
	movs	r2, #110	@ tmp265,
@ C_Code.c:936:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldr	r3, .L292+24	@ tmp262,
@ C_Code.c:936:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldrsb	r1, [r1, r2]	@ tmp267,
@ C_Code.c:936:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	strh	r1, [r3]	@ tmp267, gBanimExpGain[0]
@ C_Code.c:937:     gBanimExpGain[1] = gpEkrBattleUnitRight->expGain;
	ldr	r1, .L292+28	@ tmp270,
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
.L288:
@ C_Code.c:864:         UpdateHP(proc, HpProc, opp_bunit, hp, side, newDamage);
	ldr	r3, [sp, #40]	@ tmp300, newDamage
	str	r3, [sp, #4]	@ tmp300,
	mov	r3, r8	@ _1, _1
	movs	r1, r6	@, HpProc
	movs	r0, r5	@, proc
	str	r3, [sp]	@ _1,
	movs	r3, #0	@,
	bl	UpdateHP		@
@ C_Code.c:866:         proc->code4frame = 0xff;
	movs	r3, #76	@ tmp179,
	movs	r2, #255	@ tmp180,
@ C_Code.c:884:         struct SkillSysBattleHit * nextRound = GetCurrentRound(proc->roundId + 1);
	movs	r4, #70	@ tmp192,
@ C_Code.c:866:         proc->code4frame = 0xff;
	strb	r2, [r5, r3]	@ tmp180, proc_39(D)->code4frame
@ C_Code.c:871:         HpProc->death = true;
	subs	r3, r3, #35	@ tmp182,
	subs	r2, r2, #254	@ tmp183,
	strb	r2, [r6, r3]	@ tmp183, HpProc_43(D)->death
@ C_Code.c:882:         round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END;
	ldr	r3, [sp, #32]	@ tmp302, round
	ldrb	r3, [r3, #2]	@ tmp188,
	adds	r2, r2, #175	@ tmp185,
	orrs	r3, r2	@ tmp190, tmp185
	ldr	r2, [sp, #32]	@ tmp303, round
	strb	r3, [r2, #2]	@ tmp190,
@ C_Code.c:884:         struct SkillSysBattleHit * nextRound = GetCurrentRound(proc->roundId + 1);
	ldrb	r0, [r5, r4]	@ tmp193,
@ C_Code.c:884:         struct SkillSysBattleHit * nextRound = GetCurrentRound(proc->roundId + 1);
	ldr	r3, .L292+32	@ tmp195,
	adds	r0, r0, #1	@ tmp194,
	bl	.L10		@
@ C_Code.c:885:         nextRound->info = BATTLE_HIT_INFO_END;
	movs	r3, #7	@ tmp201,
	ldrh	r2, [r0, #2]	@ MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B], MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B]
	ands	r3, r2	@ tmp200, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B]
	movs	r2, #128	@ tmp202,
	orrs	r3, r2	@ tmp205, tmp202
	strh	r3, [r0, #2]	@ tmp205, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_54 + 2B]
@ C_Code.c:889:         u16 * animRound = &GetAnimRoundData()[0];
	ldr	r3, .L292+36	@ tmp207,
	bl	.L10		@
@ C_Code.c:890:         for (int i = proc->roundId; i < 32; ++i)
	ldrb	r3, [r5, r4]	@ i,
@ C_Code.c:890:         for (int i = proc->roundId; i < 32; ++i)
	cmp	r3, #31	@ i,
	bgt	.L263		@,
@ C_Code.c:896:             animRound[i] = 0xFFFF;
	movs	r2, #1	@ tmp279,
	rsbs	r2, r2, #0	@ tmp279, tmp279
	mov	ip, r2	@ tmp279, tmp279
@ C_Code.c:892:             if (animRound[i] == 0xFFFF)
	ldr	r1, .L292+40	@ tmp222,
	b	.L260		@
.L289:
@ C_Code.c:896:             animRound[i] = 0xFFFF;
	mov	r2, ip	@ tmp279, tmp279
@ C_Code.c:890:         for (int i = proc->roundId; i < 32; ++i)
	adds	r3, r3, #1	@ i,
@ C_Code.c:896:             animRound[i] = 0xFFFF;
	strh	r2, [r0, r4]	@ tmp279, MEM[(u16 *)animRound_58 + _111 * 1]
@ C_Code.c:890:         for (int i = proc->roundId; i < 32; ++i)
	cmp	r3, #32	@ i,
	beq	.L263		@,
.L260:
	lsls	r4, r3, #1	@ _111, i,
@ C_Code.c:892:             if (animRound[i] == 0xFFFF)
	ldrh	r2, [r0, r4]	@ MEM[(u16 *)animRound_58 + _111 * 1], MEM[(u16 *)animRound_58 + _111 * 1]
	cmp	r2, r1	@ MEM[(u16 *)animRound_58 + _111 * 1], tmp222
	bne	.L289		@,
.L263:
@ C_Code.c:903:         side = 1 ^ side;
	movs	r2, #1	@ tmp212,
	mov	r3, r8	@ _1, _1
	eors	r3, r2	@ _1, tmp212
	movs	r2, r3	@ side, _1
@ C_Code.c:904:         hp = gEkrGaugeHp[side];
	ldr	r3, .L292	@ tmp213,
	lsls	r1, r2, #1	@ tmp214, side,
	ldrsh	r1, [r1, r3]	@ _13, gEkrGaugeHp
@ C_Code.c:905:         if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL)
	ldr	r3, [sp, #32]	@ tmp306, round
	ldr	r0, [r3]	@ *round_51(D), *round_51(D)
@ C_Code.c:907:             hp += newDamage;
	ldr	r3, [sp, #40]	@ tmp307, newDamage
	adds	r3, r3, r1	@ hp, tmp307, _13
@ C_Code.c:905:         if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL)
	lsls	r0, r0, #23	@ tmp290, *round_51(D),
	bpl	.L290		@,
@ C_Code.c:812:     if (newHp > 127)
	cmp	r3, #127	@ hp,
	bgt	.L291		@,
.L264:
	mvns	r0, r3	@ tmp276, hp
	asrs	r0, r0, #31	@ tmp275, tmp276,
	ands	r3, r0	@ _80, tmp275
.L265:
@ C_Code.c:817:     some_bunit->unit.curHP = newHp;
	strb	r3, [r7, #19]	@ _80, active_bunit_65(D)->unit.curHP
@ C_Code.c:818:     if (hp == newHp)
	cmp	r1, r3	@ _13, _80
	bne	.LCB1661	@
	b	.L267	@long jump	@
.LCB1661:
@ C_Code.c:828:     if (proc->side == side)
	movs	r0, #74	@ tmp226,
	ldrb	r0, [r5, r0]	@ tmp227,
@ C_Code.c:828:     if (proc->side == side)
	cmp	r2, r0	@ side, tmp227
	beq	.LCB1665	@
	b	.L267	@long jump	@
.LCB1665:
@ C_Code.c:822:     int diff = newHp - hp;
	subs	r4, r3, r1	@ diff, _80, _13
@ C_Code.c:831:         if (UsingSkillSys)
	ldr	r2, .L292+44	@ tmp229,
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	ldr	r0, [r5, #56]	@ pretmp_125, proc_39(D)->currentRound
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	asrs	r5, r4, #31	@ tmp291, diff,
@ C_Code.c:830:         HpProc->cur = hp;
	strh	r1, [r6, #46]	@ _13, HpProc_43(D)->cur
@ C_Code.c:831:         if (UsingSkillSys)
	ldr	r1, [r2]	@ UsingSkillSys.32_88, UsingSkillSys
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	adds	r2, r4, r5	@ tmp230, diff, tmp291
	eors	r2, r5	@ tmp230, tmp291
@ C_Code.c:833:             HpProc->post = newHp;
	lsls	r3, r3, #16	@ _126, _80,
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	lsls	r2, r2, #24	@ tmp231, tmp230,
@ C_Code.c:833:             HpProc->post = newHp;
	asrs	r3, r3, #16	@ _126, _126,
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	asrs	r2, r2, #24	@ _127, tmp231,
@ C_Code.c:831:         if (UsingSkillSys)
	cmp	r1, #0	@ UsingSkillSys.32_88,
	beq	.L269		@,
@ C_Code.c:833:             HpProc->post = newHp;
	movs	r5, #80	@ tmp232,
	strh	r3, [r6, r5]	@ _126, HpProc_43(D)->post
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r0, #3]	@ _127, pretmp_125->hpChange
@ C_Code.c:842:         if (UsingSkillSys == 2)
	cmp	r1, #2	@ UsingSkillSys.32_88,
	beq	.LCB1684	@
	b	.L267	@long jump	@
.LCB1684:
@ C_Code.c:844:             proc->currentRound->overDmg = diff;
	strh	r4, [r0, #6]	@ diff, pretmp_125->overDmg
	b	.L267		@
.L291:
@ C_Code.c:812:     if (newHp > 127)
	movs	r3, #127	@ _80,
	b	.L265		@
.L290:
@ C_Code.c:904:         hp = gEkrGaugeHp[side];
	movs	r3, r1	@ hp, _13
@ C_Code.c:812:     if (newHp > 127)
	cmp	r3, #127	@ hp,
	ble	.L264		@,
	b	.L291		@
.L269:
@ C_Code.c:837:             HpProc->postHpAtkrSS = newHp >> 16;
	movs	r4, #82	@ tmp235,
	strh	r1, [r6, r4]	@ UsingSkillSys.32_88, HpProc_43(D)->postHpAtkrSS
@ C_Code.c:838:             HpProc->post = newHp;
	movs	r1, #80	@ tmp238,
	strh	r3, [r6, r1]	@ _126, HpProc_43(D)->post
@ C_Code.c:841:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r0, #3]	@ _127, pretmp_125->hpChange
	b	.L267		@
.L293:
	.align	2
.L292:
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
@ C_Code.c:945:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	ldr	r3, [r0, #56]	@ _1, proc_48(D)->currentRound
	mov	r9, r3	@ _1, _1
@ C_Code.c:945:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	ldr	r3, [r3]	@ *_1, *_1
	lsls	r3, r3, #13	@ tmp163, *_1,
@ C_Code.c:943: {
	movs	r6, r2	@ active_bunit, tmp227
	movs	r4, r0	@ proc, tmp225
	movs	r5, r1	@ HpProc, tmp226
	sub	sp, sp, #36	@,,
@ C_Code.c:945:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	lsrs	r2, r3, #13	@ _2, tmp163,
@ C_Code.c:945:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	lsls	r3, r3, #17	@ tmp232, tmp163,
	bmi	.L294		@,
@ C_Code.c:945:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	mov	r3, r9	@ _1, _1
	ldrb	r3, [r3, #3]	@ tmp166,
	lsls	r3, r3, #24	@ tmp166, tmp166,
	asrs	r3, r3, #24	@ tmp166, tmp166,
	beq	.L294		@,
@ C_Code.c:949:     if (round->hpChange <= 0)
	movs	r1, #3	@ _6,
	ldr	r3, [sp, #72]	@ tmp244, round
	ldrsb	r1, [r3, r1]	@ _6,* _6
@ C_Code.c:949:     if (round->hpChange <= 0)
	cmp	r1, #0	@ _6,
	ble	.L294		@,
@ C_Code.c:953:     int side = proc->side;
	movs	r3, #74	@ tmp169,
	ldrb	r3, [r0, r3]	@ side,
	movs	r0, r3	@ side, side
	str	r3, [sp, #20]	@ side, %sfp
@ C_Code.c:954:     int hp = gEkrGaugeHp[proc->side];
	ldr	r3, .L332	@ tmp170,
	lsls	r0, r0, #1	@ tmp171, side,
@ C_Code.c:954:     int hp = gEkrGaugeHp[proc->side];
	ldrsh	r3, [r0, r3]	@ hp, gEkrGaugeHp
	str	r3, [sp, #24]	@ hp, %sfp
@ C_Code.c:955:     if (!hp)
	cmp	r3, #0	@ hp,
	bne	.LCB1772	@
	b	.L329	@long jump	@
.LCB1772:
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	movs	r3, #1	@ tmp179,
	ldr	r0, [sp, #20]	@ side, %sfp
@ C_Code.c:964:     int oldDamage = round->hpChange;
	mov	r8, r1	@ oldDamage, _6
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	eors	r3, r0	@ tmp178, side
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	ldr	r1, .L332+4	@ tmp174,
	lsls	r3, r3, #1	@ tmp180, tmp178,
	ldrsh	r3, [r3, r1]	@ pretmp_81, gEkrGaugeDmg
@ C_Code.c:965:     if (proc->currentRound->attributes & BATTLE_HIT_ATTR_CRIT)
	lsls	r2, r2, #31	@ tmp233, _2,
	bpl	.L297		@,
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	lsls	r2, r3, #1	@ tmp184, pretmp_81,
	adds	r3, r2, r3	@ tmp185, tmp184, pretmp_81
@ C_Code.c:967:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	cmp	r8, r3	@ oldDamage, tmp185
	blt	.L327		@,
.L299:
@ C_Code.c:978:     if (UsingSkillSys == 2)
	ldr	r3, .L332+8	@ tmp186,
	ldr	r3, [r3]	@ UsingSkillSys.38_16, UsingSkillSys
	str	r3, [sp, #28]	@ UsingSkillSys.38_16, %sfp
@ C_Code.c:978:     if (UsingSkillSys == 2)
	cmp	r3, #2	@ UsingSkillSys.38_16,
	bne	.L300		@,
@ C_Code.c:980:         oldDamage = ABS(round->overDmg);
	ldr	r3, [sp, #72]	@ tmp255, round
	movs	r2, #6	@ tmp240,
	ldrsh	r3, [r3, r2]	@ tmp187, tmp255, tmp240
	asrs	r2, r3, #31	@ tmp234, tmp187,
	adds	r3, r3, r2	@ tmp188, tmp187, tmp234
	eors	r3, r2	@ tmp188, tmp234
@ C_Code.c:980:         oldDamage = ABS(round->overDmg);
	lsls	r3, r3, #16	@ tmp189, tmp188,
	lsrs	r3, r3, #16	@ oldDamage, tmp189,
	mov	r8, r3	@ oldDamage, oldDamage
.L300:
@ C_Code.c:984:     int newDamage = ((oldDamage * percent)) / 100;
	ldr	r2, [sp, #76]	@ tmp258, percent
	mov	r3, r8	@ _19, oldDamage
	muls	r3, r2	@ _19, tmp258
	mov	fp, r3	@ _19, _19
@ C_Code.c:984:     int newDamage = ((oldDamage * percent)) / 100;
	ldr	r3, .L332+12	@ tmp193,
	movs	r1, #100	@,
	mov	r0, fp	@, _19
	mov	r10, r3	@ tmp193, tmp193
	bl	.L10		@
@ C_Code.c:985:     if (newDamage >= oldDamage)
	cmp	r8, r0	@ oldDamage, tmp229
	bgt	.L301		@,
@ C_Code.c:987:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	ldr	r3, .L332+16	@ tmp195,
	ldr	r0, [r3]	@ BonusDamageRounding, BonusDamageRounding
@ C_Code.c:987:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	movs	r1, #100	@,
@ C_Code.c:987:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	add	r0, r0, fp	@ tmp196, _19
@ C_Code.c:987:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	bl	.L71		@
.L302:
@ C_Code.c:993:     if (newDamage <= 0)
	mov	r10, r0	@ newDamage, newDamage
	cmp	r0, #0	@ newDamage,
	bgt	.L303		@,
	movs	r3, #1	@ newDamage,
	mov	r10, r3	@ newDamage, newDamage
.L303:
@ C_Code.c:997:     int newHp = hp - newDamage;
	mov	r2, r10	@ newDamage, newDamage
	ldr	r3, [sp, #24]	@ hp, %sfp
@ C_Code.c:998:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r1, #11	@ tmp212,
@ C_Code.c:997:     int newHp = hp - newDamage;
	subs	r2, r3, r2	@ newHp, hp, newDamage
@ C_Code.c:998:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r3, #192	@ tmp213,
	ldrsb	r1, [r6, r1]	@ tmp212,
	ands	r3, r1	@ tmp214, tmp212
@ C_Code.c:998:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ tmp214,
	beq	.L330		@,
.L304:
@ C_Code.c:1017:     if (newHp <= 0)
	mvns	r3, r2	@ tmp224, newHp
	asrs	r3, r3, #31	@ tmp223, tmp224,
	ands	r2, r3	@ newHp, tmp223
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r3, [sp, #28]	@ UsingSkillSys.38_16, %sfp
@ C_Code.c:1017:     if (newHp <= 0)
	mov	fp, r2	@ _3, newHp
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r3, #0	@ UsingSkillSys.38_16,
	beq	.L307		@,
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	mov	r3, r9	@ _1, _1
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, .L332+20	@ tmp219,
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, [r2]	@ ProcSkillsStackWithTimedHits, ProcSkillsStackWithTimedHits
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldrb	r3, [r3, #4]	@ pretmp_78,
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r2, #0	@ ProcSkillsStackWithTimedHits,
	beq	.L308		@,
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, .L332+24	@ tmp221,
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldrb	r2, [r2, r3]	@ tmp222, SkillExceptionsTable
	cmp	r2, #0	@ tmp222,
	bne	.L308		@,
.L307:
@ C_Code.c:1031:     UpdateHP(proc, HpProc, opp_bunit, newHp, side, newDamage);
	mov	r3, r10	@ newDamage, newDamage
	str	r3, [sp, #4]	@ newDamage,
	ldr	r3, [sp, #20]	@ side, %sfp
	movs	r2, r7	@, opp_bunit
	str	r3, [sp]	@ side,
	movs	r1, r5	@, HpProc
	mov	r3, fp	@, _3
	movs	r0, r4	@, proc
	bl	UpdateHP		@
@ C_Code.c:1033:     CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, newHp, newDamage);
	mov	r3, r10	@ newDamage, newDamage
	str	r3, [sp, #8]	@ newDamage,
	mov	r3, fp	@ _3, _3
.L328:
	str	r3, [sp, #4]	@ _3,
	ldr	r3, [sp, #72]	@ tmp276, round
	movs	r2, r6	@, active_bunit
	str	r3, [sp]	@ tmp276,
	movs	r1, r5	@, HpProc
	movs	r3, r7	@, opp_bunit
	movs	r0, r4	@, proc
	bl	CheckForDeath		@
.L294:
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
.L297:
@ C_Code.c:973:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	cmp	r8, r3	@ oldDamage, pretmp_81
	bge	.L299		@,
.L327:
@ C_Code.c:975:         oldDamage = gEkrGaugeDmg[side ^ 1];
	mov	r8, r3	@ oldDamage, pretmp_81
	b	.L299		@
.L308:
@ C_Code.c:1022:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r3, #0	@ pretmp_78,
	beq	.L307		@,
@ C_Code.c:1027:         newHp = hp - oldDamage;
	mov	r2, r8	@ oldDamage, oldDamage
	ldr	r3, [sp, #24]	@ hp, %sfp
	subs	r3, r3, r2	@ _3, hp, oldDamage
	mov	fp, r3	@ _3, _3
@ C_Code.c:1026:         newDamage = oldDamage;
	mov	r10, r8	@ newDamage, oldDamage
	b	.L307		@
.L301:
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	ldr	r3, .L332+28	@ tmp202,
	ldr	r0, [r3]	@ ReducedDamageRounding, ReducedDamageRounding
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	ldr	r3, .L332+32	@ tmp205,
	ldr	r3, [r3]	@ ReducedDamageSubtract, ReducedDamageSubtract
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	add	r0, r0, fp	@ tmp203, _19
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	movs	r1, #100	@,
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	subs	r0, r0, r3	@ tmp206, tmp203, ReducedDamageSubtract
@ C_Code.c:991:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	bl	.L71		@
	b	.L302		@
.L330:
@ C_Code.c:1002:         if ((hp - oldDamage) <= 0)
	mov	r1, r8	@ oldDamage, oldDamage
	ldr	r3, [sp, #24]	@ hp, %sfp
	subs	r3, r3, r1	@ _29, hp, oldDamage
@ C_Code.c:1002:         if ((hp - oldDamage) <= 0)
	cmp	r3, #0	@ _29,
	ble	.L331		@,
.L305:
@ C_Code.c:1010:         if (!BlockingEnabled)
	ldr	r1, .L332+36	@ tmp217,
@ C_Code.c:1010:         if (!BlockingEnabled)
	ldr	r1, [r1]	@ BlockingEnabled, BlockingEnabled
	cmp	r1, #0	@ BlockingEnabled,
	bne	.L304		@,
@ C_Code.c:1012:             newHp = hp - oldDamage;
	movs	r2, r3	@ newHp, _29
@ C_Code.c:1013:             newDamage = oldDamage;
	mov	r10, r8	@ newDamage, oldDamage
	b	.L304		@
.L329:
@ C_Code.c:957:         CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp, 0);
	str	r3, [sp, #8]	@ hp,
	b	.L328		@
.L331:
@ C_Code.c:1004:             if (!BlockingCanPreventLethal)
	ldr	r1, .L332+40	@ tmp215,
@ C_Code.c:1004:             if (!BlockingCanPreventLethal)
	ldr	r1, [r1]	@ BlockingCanPreventLethal, BlockingCanPreventLethal
	cmp	r1, #0	@ BlockingCanPreventLethal,
	bne	.L305		@,
@ C_Code.c:1006:                 newHp = hp - oldDamage;
	movs	r2, r3	@ newHp, _29
@ C_Code.c:1007:                 newDamage = oldDamage;
	mov	r10, r8	@ newDamage, oldDamage
	b	.L305		@
.L333:
	.align	2
.L332:
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
	movs	r5, #11	@ tmp134,
	movs	r4, #192	@ tmp135,
	ldrsb	r5, [r2, r5]	@ tmp134,
@ C_Code.c:764: {
	sub	sp, sp, #12	@,,
@ C_Code.c:728:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	ands	r4, r5	@ _15, tmp134
@ C_Code.c:726:     if (success)
	ldr	r5, [sp, #28]	@ tmp173, success
	cmp	r5, #0	@ tmp173,
	beq	.L335		@,
@ C_Code.c:728:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r4, #128	@ _15,
	beq	.L343		@,
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r4, .L344	@ tmp139,
	ldr	r4, [r4]	@ TimedHitsDifficultyRam.25_21, TimedHitsDifficultyRam
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r4, [r4]	@ *TimedHitsDifficultyRam.25_21, *TimedHitsDifficultyRam.25_21
@ C_Code.c:739:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r5, r4, #26	@ tmp169, *TimedHitsDifficultyRam.25_21,
	bmi	.L338		@,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r5, .L344+4	@ tmp149,
	ldr	r5, [r5]	@ DifficultyThreshold.27_26, DifficultyThreshold
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r4, r4, #27	@ tmp154, *TimedHitsDifficultyRam.25_21,
	lsrs	r4, r4, #27	@ tmp155, tmp154,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r4, r5	@ tmp155, DifficultyThreshold.27_26
	bge	.L339		@,
@ C_Code.c:742:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r4, .L344+8	@ tmp157,
@ C_Code.c:741:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r4, [r4]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r5, r4	@ DifficultyThreshold.27_26, NumberOfRandomButtons
	bgt	.L338		@,
.L339:
@ C_Code.c:744:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r4, .L344+12	@ tmp159,
	ldr	r5, .L344+16	@ tmp160,
	ldr	r4, [r4]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r5, [r5]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r4, r4, r5	@ _19, BonusDamagePercent, DifficultyBonusPercent
	b	.L337		@
.L335:
@ C_Code.c:749:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r4, #128	@ _15,
	beq	.L341		@,
@ C_Code.c:753:     return FailedHitDamagePercent;
	ldr	r4, .L344+20	@ tmp164,
	ldr	r4, [r4]	@ _19,
.L337:
@ C_Code.c:766:     AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r4, [sp, #4]	@ _19,
	ldr	r4, [sp, #24]	@ tmp174, round
	str	r4, [sp]	@ tmp174,
	bl	AdjustDamageByPercent		@
@ C_Code.c:767: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L343:
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r4, .L344+24	@ tmp136,
@ C_Code.c:730:             if (BlockingEnabled)
	ldr	r4, [r4]	@ BlockingEnabled, BlockingEnabled
	cmp	r4, #0	@ BlockingEnabled,
	beq	.L341		@,
@ C_Code.c:732:                 return ReducedDamagePercent;
	ldr	r4, .L344+28	@ tmp138,
	ldr	r4, [r4]	@ _19,
	b	.L337		@
.L338:
@ C_Code.c:747:         return BonusDamagePercent;
	ldr	r4, .L344+12	@ tmp163,
	ldr	r4, [r4]	@ _19,
	b	.L337		@
.L341:
@ C_Code.c:736:                 return 100;
	movs	r4, #100	@ _19,
	b	.L337		@
.L345:
	.align	2
.L344:
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
	.type	DoStuffIfHit, %function
DoStuffIfHit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r7, r9	@,
	mov	r6, r8	@,
	mov	lr, r10	@,
	movs	r4, r0	@ proc, tmp296
@ C_Code.c:103:     if (gBattleStats.config &
	ldr	r0, .L383	@ tmp174,
@ C_Code.c:103:     if (gBattleStats.config &
	ldrh	r5, [r0]	@ gBattleStats, gBattleStats
	movs	r0, #252	@ tmp178,
@ C_Code.c:614: {
	push	{r6, r7, lr}	@
@ C_Code.c:103:     if (gBattleStats.config &
	lsls	r0, r0, #2	@ tmp178, tmp178,
@ C_Code.c:614: {
	movs	r7, r2	@ HpProc, tmp297
	movs	r6, r3	@ round, tmp298
	sub	sp, sp, #8	@,,
@ C_Code.c:103:     if (gBattleStats.config &
	tst	r5, r0	@ gBattleStats, tmp178
	bne	.L346		@,
@ C_Code.c:109:     if (TimedHitsDifficultyRam->off)
	ldr	r3, .L383+4	@ tmp183,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_13, *TimedHitsDifficultyRam.0_13
@ C_Code.c:109:     if (TimedHitsDifficultyRam->off)
	lsls	r3, r3, #25	@ tmp305, *TimedHitsDifficultyRam.0_13,
	bpl	.L379		@,
.L346:
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
.L379:
@ C_Code.c:113:     return !CheckFlag(DisabledFlag);
	ldr	r3, .L383+8	@ tmp193,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L383+12	@ tmp195,
	bl	.L10		@
@ C_Code.c:615:     if (!AreTimedHitsEnabled())
	cmp	r0, #0	@ tmp299,
	bne	.L346		@,
@ C_Code.c:619:     if (round->hpChange < 0)
	ldrb	r3, [r6, #3]	@ tmp200,
	cmp	r3, #127	@ tmp200,
	bhi	.L346		@,
@ C_Code.c:623:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	ldr	r3, .L383+16	@ tmp201,
@ C_Code.c:623:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	ldrh	r2, [r3, #8]	@ tmp204,
	ldrh	r3, [r3, #4]	@ tmp206,
@ C_Code.c:623:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	orrs	r2, r3	@ tmp204, tmp206
@ C_Code.c:627:     int x = proc->anim2->xPosition;
	ldr	r3, [r4, #48]	@ proc_8(D)->anim2, proc_8(D)->anim2
@ C_Code.c:627:     int x = proc->anim2->xPosition;
	movs	r5, #2	@ x,
	ldrsh	r5, [r3, r5]	@ x, proc_8(D)->anim2, x
@ C_Code.c:623:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	mov	r8, r2	@ keys, tmp204
@ C_Code.c:628:     if (x > 119)
	cmp	r5, #119	@ x,
	bgt	.LCB2145	@
	b	.L350	@long jump	@
.LCB2145:
@ C_Code.c:630:         x -= 40;
	subs	r5, r5, #40	@ x,
.L351:
@ C_Code.c:636:     struct BattleUnit * active_bunit = proc->active_bunit;
	ldr	r3, [r4, #60]	@ active_bunit, proc_8(D)->active_bunit
	mov	r9, r3	@ active_bunit, active_bunit
@ C_Code.c:637:     struct BattleUnit * opp_bunit = proc->opp_bunit;
	ldr	r3, [r4, #64]	@ opp_bunit, proc_8(D)->opp_bunit
	mov	r10, r3	@ opp_bunit, opp_bunit
@ C_Code.c:638:     int hitTime = !proc->EkrEfxIsUnitHittedNowFrames;
	movs	r3, #79	@ tmp210,
@ C_Code.c:639:     if (hitTime)
	ldrb	r3, [r4, r3]	@ tmp211,
	cmp	r3, #0	@ tmp211,
	bne	.L353		@,
@ C_Code.c:642:         if (proc->timer2 == 0xFF)
	movs	r2, #68	@ tmp212,
@ C_Code.c:642:         if (proc->timer2 == 0xFF)
	ldrb	r1, [r4, r2]	@ tmp213,
	cmp	r1, #255	@ tmp213,
	bne	.LCB2160	@
	b	.L380	@long jump	@
.LCB2160:
.L354:
@ C_Code.c:646:         SaveInputFrame(proc, keys);
	mov	r1, r8	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
@ C_Code.c:647:         SaveIfWeHitOnTime(proc);
	movs	r0, r4	@, proc
	bl	SaveIfWeHitOnTime		@
@ C_Code.c:648:         if (!proc->adjustedDmg)
	movs	r3, #71	@ tmp217,
@ C_Code.c:648:         if (!proc->adjustedDmg)
	ldrb	r2, [r4, r3]	@ tmp218,
	cmp	r2, #0	@ tmp218,
	bne	.L353		@,
@ C_Code.c:528:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r2, .L383+20	@ tmp219,
@ C_Code.c:533:     if (CheatCodeOn())
	ldrb	r2, [r2, #31]	@ tmp222,
	cmp	r2, #127	@ tmp222,
	bls	.LCB2174	@
	b	.L356	@long jump	@
.LCB2174:
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r2, .L383+24	@ tmp223,
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r2, [r2]	@ AlwaysWork, AlwaysWork
	cmp	r2, #0	@ AlwaysWork,
	beq	.LCB2178	@
	b	.L356	@long jump	@
.LCB2178:
@ C_Code.c:541:     return proc->hitOnTime;
	adds	r2, r2, #69	@ tmp225,
@ C_Code.c:650:             if (DidWeHitOnTime(proc))
	ldrb	r2, [r4, r2]	@ tmp226,
	cmp	r2, #0	@ tmp226,
	beq	.LCB2182	@
	b	.L356	@long jump	@
.LCB2182:
@ C_Code.c:657:                 proc->adjustedDmg = true;
	movs	r2, #1	@ tmp232,
	strb	r2, [r4, r3]	@ tmp232, proc_8(D)->adjustedDmg
@ C_Code.c:749:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	mov	r3, r9	@ active_bunit, active_bunit
	movs	r2, #11	@ tmp234,
	ldrsb	r2, [r3, r2]	@ tmp234,
	movs	r3, #192	@ tmp235,
	ands	r3, r2	@ tmp236, tmp234
@ C_Code.c:749:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ tmp236,
	bne	.LCB2191	@
	b	.L368	@long jump	@
.LCB2191:
@ C_Code.c:753:     return FailedHitDamagePercent;
	ldr	r3, .L383+28	@ tmp237,
	ldr	r3, [r3]	@ _85, FailedHitDamagePercent
.L358:
@ C_Code.c:766:     AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r3, [sp, #4]	@ _85,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	movs	r1, r7	@, HpProc
	movs	r0, r4	@, proc
	str	r6, [sp]	@ round,
	bl	AdjustDamageByPercent		@
.L353:
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	movs	r3, #74	@ tmp238,
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	ldrb	r0, [r4, r3]	@ tmp239,
	ldr	r3, .L383+32	@ tmp240,
	bl	.L10		@
@ C_Code.c:669:         (proc->timer2 != 0xFF))
	movs	r3, #68	@ tmp243,
	ldrb	r6, [r4, r3]	@ pretmp_16,
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	cmp	r0, #0	@ tmp241,
	bne	.L360		@,
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	adds	r3, r3, #8	@ tmp245,
	ldrh	r2, [r4, r3]	@ MEM <struct TimedHitsProc> [(void *)proc_8(D)], MEM <struct TimedHitsProc> [(void *)proc_8(D)]
	ldr	r3, .L383+36	@ tmp247,
	cmp	r2, r3	@ MEM <struct TimedHitsProc> [(void *)proc_8(D)], tmp247
	beq	.L381		@,
.L360:
@ C_Code.c:528:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L383+20	@ tmp248,
@ C_Code.c:533:     if (CheatCodeOn())
	ldrb	r3, [r3, #31]	@ tmp251,
	cmp	r3, #127	@ tmp251,
	bhi	.L362		@,
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r3, .L383+24	@ tmp252,
@ C_Code.c:537:     if (AlwaysWork)
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L362		@,
@ C_Code.c:541:     return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp254,
@ C_Code.c:671:         if (DidWeHitOnTime(proc))
	ldrb	r3, [r4, r3]	@ tmp255,
	cmp	r3, #0	@ tmp255,
	bne	.L362		@,
@ C_Code.c:690:         else if (proc->timer2 < 20)
	cmp	r6, #19	@ pretmp_16,
	bhi	.L364		@,
@ C_Code.c:692:             if (ChangePaletteWhenButtonIsPressed)
	ldr	r2, .L383+40	@ tmp282,
@ C_Code.c:546:     if (!DisplayPress)
	ldr	r3, .L383+44	@ tmp281,
@ C_Code.c:692:             if (ChangePaletteWhenButtonIsPressed)
	ldr	r2, [r2]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
@ C_Code.c:546:     if (!DisplayPress)
	ldr	r3, [r3]	@ pretmp_105, DisplayPress
@ C_Code.c:692:             if (ChangePaletteWhenButtonIsPressed)
	cmp	r2, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L365		@,
@ C_Code.c:546:     if (!DisplayPress)
	cmp	r3, #0	@ pretmp_105,
	bne	.L382		@,
.L364:
@ C_Code.c:701:         proc->roundEnd = true;
	movs	r3, #78	@ tmp284,
	movs	r2, #1	@ tmp285,
	strb	r2, [r4, r3]	@ tmp285, proc_8(D)->roundEnd
	b	.L346		@
.L362:
@ C_Code.c:682:             if (((y > (-16)) && (y < (161))))
	movs	r3, #63	@ tmp256,
	subs	r3, r3, r6	@ tmp257, tmp256, pretmp_16
@ C_Code.c:682:             if (((y > (-16)) && (y < (161))))
	cmp	r3, #175	@ tmp257,
	bhi	.L364		@,
@ C_Code.c:684:                 if (!gBanimDoneFlag[proc->side])
	movs	r2, #74	@ tmp259,
	ldrb	r2, [r4, r2]	@ tmp260,
@ C_Code.c:684:                 if (!gBanimDoneFlag[proc->side])
	ldr	r3, .L383+48	@ tmp258,
	lsls	r2, r2, #2	@ tmp261, tmp260,
@ C_Code.c:684:                 if (!gBanimDoneFlag[proc->side])
	ldr	r3, [r2, r3]	@ gBanimDoneFlag[_56], gBanimDoneFlag[_56]
	cmp	r3, #0	@ gBanimDoneFlag[_56],
	bne	.L364		@,
@ C_Code.c:678:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	movs	r1, #31	@,
	movs	r0, r6	@, pretmp_16
	ldr	r3, .L383+52	@ tmp263,
	bl	.L10		@
@ C_Code.c:678:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	ldr	r3, .L383+56	@ tmp264,
	movs	r2, #104	@ tmp265,
	adds	r3, r3, r0	@ tmp266, tmp264, tmp301
@ C_Code.c:681:             y -= clock;
	movs	r0, #48	@ tmp270,
@ C_Code.c:678:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	ldrb	r1, [r3, r2]	@ tmp267, xPos
@ C_Code.c:681:             y -= clock;
	subs	r0, r0, r6	@ y, tmp270, pretmp_16
@ C_Code.c:686:                     PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
	adds	r2, r2, #151	@ tmp272,
	ands	r2, r0	@ tmp273, y
	movs	r0, #224	@ tmp277,
@ C_Code.c:678:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	adds	r1, r1, r5	@ x, tmp267, x
@ C_Code.c:679:             x += 16;
	adds	r1, r1, #16	@ x,
@ C_Code.c:686:                     PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
	lsls	r0, r0, #8	@ tmp277, tmp277,
	lsls	r1, r1, #23	@ tmp276, x,
	str	r0, [sp]	@ tmp277,
	ldr	r3, .L383+60	@ tmp269,
	movs	r0, #0	@,
	ldr	r5, .L383+64	@ tmp278,
	lsrs	r1, r1, #23	@ tmp275, tmp276,
	bl	.L28		@
	b	.L364		@
.L350:
@ C_Code.c:632:     else if (x > 40)
	cmp	r5, #40	@ x,
	bgt	.LCB2290	@
	b	.L351	@long jump	@
.LCB2290:
@ C_Code.c:634:         x -= 20;
	subs	r5, r5, #20	@ x,
	b	.L351		@
.L381:
@ C_Code.c:668:     if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
	cmp	r6, #255	@ pretmp_16,
	bne	.L360		@,
@ C_Code.c:705:         if (proc->timer < 1)
	ldr	r3, [r4, #52]	@ proc_8(D)->timer, proc_8(D)->timer
	cmp	r3, #0	@ proc_8(D)->timer,
	bgt	.L366		@,
@ C_Code.c:707:             proc->frame = 0;
	movs	r3, #75	@ tmp288,
	strb	r0, [r4, r3]	@ tmp241, proc_8(D)->frame
.L367:
@ C_Code.c:714:         if (!proc->roundEnd)
	movs	r3, #78	@ tmp291,
@ C_Code.c:714:         if (!proc->roundEnd)
	ldrb	r3, [r4, r3]	@ tmp292,
	cmp	r3, #0	@ tmp292,
	beq	.LCB2308	@
	b	.L346	@long jump	@
.LCB2308:
@ C_Code.c:546:     if (!DisplayPress)
	ldr	r3, .L383+44	@ tmp293,
@ C_Code.c:546:     if (!DisplayPress)
	ldr	r3, [r3]	@ DisplayPress, DisplayPress
	cmp	r3, #0	@ DisplayPress,
	bne	.LCB2312	@
	b	.L346	@long jump	@
.LCB2312:
	movs	r3, #15	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L346		@
.L380:
@ C_Code.c:644:             proc->timer2 = 0;
	strb	r3, [r4, r2]	@ tmp211, proc_8(D)->timer2
	b	.L354		@
.L356:
@ C_Code.c:652:                 proc->adjustedDmg = true;
	movs	r3, #1	@ tmp228,
	movs	r2, #71	@ tmp227,
@ C_Code.c:653:                 AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true);
	movs	r1, r7	@, HpProc
@ C_Code.c:652:                 proc->adjustedDmg = true;
	strb	r3, [r4, r2]	@ tmp228, proc_8(D)->adjustedDmg
@ C_Code.c:653:                 AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true);
	movs	r0, r4	@, proc
	str	r3, [sp, #4]	@ tmp228,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	str	r6, [sp]	@ round,
	bl	AdjustDamageWithGetter		@
	b	.L353		@
.L365:
@ C_Code.c:546:     if (!DisplayPress)
	cmp	r3, #0	@ pretmp_105,
	beq	.L364		@,
	movs	r3, #14	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L364		@
.L382:
	movs	r3, #15	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L364		@
.L366:
@ C_Code.c:712:             SaveInputFrame(proc, keys);
	mov	r1, r8	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
	b	.L367		@
.L368:
@ C_Code.c:736:                 return 100;
	movs	r3, #100	@ _85,
	b	.L358		@
.L384:
	.align	2
.L383:
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
	movs	r4, r0	@ proc, tmp185
	sub	sp, sp, #12	@,,
@ C_Code.c:297:     if (!proc->anim)
	cmp	r3, #0	@ proc_29(D)->anim,
	beq	.L385		@,
@ C_Code.c:302:     struct ProcEkrBattle * battleProc = gpProcEkrBattle;
	ldr	r3, .L411	@ tmp144,
	ldr	r5, [r3]	@ battleProc, gpProcEkrBattle
@ C_Code.c:304:     if (!battleProc)
	cmp	r5, #0	@ battleProc,
	beq	.L385		@,
@ C_Code.c:308:     if (!proc->anim2)
	ldr	r3, [r0, #48]	@ proc_29(D)->anim2, proc_29(D)->anim2
	cmp	r3, #0	@ proc_29(D)->anim2,
	beq	.L385		@,
@ C_Code.c:312:     if (gEkrBattleEndFlag)
	ldr	r3, .L411+4	@ tmp146,
@ C_Code.c:312:     if (gEkrBattleEndFlag)
	ldr	r3, [r3]	@ gEkrBattleEndFlag, gEkrBattleEndFlag
	cmp	r3, #0	@ gEkrBattleEndFlag,
	bne	.L410		@,
@ C_Code.c:319:     if (proc->timer2 != 0xFF)
	movs	r2, #68	@ tmp151,
@ C_Code.c:318:     proc->timer++;
	ldr	r3, [r0, #52]	@ proc_29(D)->timer, proc_29(D)->timer
	adds	r3, r3, #1	@ tmp149,
	str	r3, [r0, #52]	@ tmp149, proc_29(D)->timer
@ C_Code.c:319:     if (proc->timer2 != 0xFF)
	ldrb	r3, [r0, r2]	@ _6,
@ C_Code.c:319:     if (proc->timer2 != 0xFF)
	cmp	r3, #255	@ _6,
	beq	.L390		@,
@ C_Code.c:321:         proc->timer2++;
	adds	r3, r3, #1	@ tmp152,
	strb	r3, [r0, r2]	@ tmp152, proc_29(D)->timer2
.L390:
@ C_Code.c:326:     if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
	movs	r6, #79	@ tmp155,
	ldrb	r3, [r4, r6]	@ _8,
@ C_Code.c:324:     struct SkillSysBattleHit * currentRound = proc->currentRound;
	ldr	r7, [r4, #56]	@ currentRound, proc_29(D)->currentRound
@ C_Code.c:326:     if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
	cmp	r3, #255	@ _8,
	beq	.L391		@,
@ C_Code.c:328:         proc->EkrEfxIsUnitHittedNowFrames++;
	adds	r3, r3, #1	@ tmp156,
	strb	r3, [r4, r6]	@ tmp156, proc_29(D)->EkrEfxIsUnitHittedNowFrames
.L392:
@ C_Code.c:336:     struct NewProcEfxHPBar * HpProc = Proc_Find(gProcScr_efxHPBarResire);
	ldr	r3, .L411+8	@ tmp167,
	ldr	r6, .L411+12	@ tmp169,
	ldr	r0, [r3]	@ gProcScr_efxHPBarResire, gProcScr_efxHPBarResire
	bl	.L413		@
	subs	r2, r0, #0	@ HpProc, tmp187,
@ C_Code.c:337:     if (!HpProc)
	beq	.L393		@,
@ C_Code.c:341:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r3, r7	@, currentRound
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
.L394:
@ C_Code.c:288:     if (proc->EkrEfxIsUnitHittedNowFrames)
	movs	r3, #79	@ tmp173,
@ C_Code.c:288:     if (proc->EkrEfxIsUnitHittedNowFrames)
	ldrb	r3, [r4, r3]	@ tmp174,
	cmp	r3, #0	@ tmp174,
	bne	.L385		@,
@ C_Code.c:345:         int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId);
	movs	r6, #70	@ tmp176,
@ C_Code.c:345:         int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId);
	ldrb	r3, [r4, r6]	@ tmp177,
	movs	r1, #0	@,
	movs	r2, #0	@,
	ldr	r0, [r4, #48]	@ proc_29(D)->anim2, proc_29(D)->anim2
	ldr	r5, .L411+16	@ tmp178,
	str	r3, [sp]	@ tmp177,
	movs	r3, #0	@,
	bl	.L28		@
	movs	r3, r0	@ x, tmp189
@ C_Code.c:346:         x = DisplayDamage2(proc->anim, 1, proc->anim->xPosition, x, proc->roundId);
	ldr	r0, [r4, #44]	@ _18, proc_29(D)->anim
	movs	r1, #2	@ tmp193,
	ldrsh	r2, [r0, r1]	@ tmp179, _18, tmp193
	ldrb	r1, [r4, r6]	@ tmp181,
	str	r1, [sp]	@ tmp181,
	movs	r1, #1	@,
	bl	.L28		@
.L385:
@ C_Code.c:348: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L410:
@ C_Code.c:314:         Proc_End(proc);
	ldr	r3, .L411+20	@ tmp148,
	bl	.L10		@
@ C_Code.c:315:         return;
	b	.L385		@
.L391:
@ C_Code.c:330:     else if (EkrEfxIsUnitHittedNow(proc->side))
	movs	r3, #74	@ tmp159,
@ C_Code.c:330:     else if (EkrEfxIsUnitHittedNow(proc->side))
	ldrb	r0, [r4, r3]	@ tmp160,
	ldr	r3, .L411+24	@ tmp161,
	bl	.L10		@
@ C_Code.c:330:     else if (EkrEfxIsUnitHittedNow(proc->side))
	cmp	r0, #0	@ tmp186,
	beq	.L392		@,
@ C_Code.c:332:         proc->EkrEfxIsUnitHittedNowFrames = 0;
	movs	r3, #0	@ tmp165,
	strb	r3, [r4, r6]	@ tmp165, proc_29(D)->EkrEfxIsUnitHittedNowFrames
	b	.L392		@
.L393:
@ C_Code.c:339:         HpProc = Proc_Find(gProcScr_efxHPBar);
	ldr	r3, .L411+28	@ tmp170,
	ldr	r0, [r3]	@ gProcScr_efxHPBar, gProcScr_efxHPBar
	bl	.L413		@
@ C_Code.c:341:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r3, r7	@, currentRound
@ C_Code.c:339:         HpProc = Proc_Find(gProcScr_efxHPBar);
	movs	r6, r0	@ HpProc, tmp188
@ C_Code.c:341:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r2, r0	@, HpProc
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
@ C_Code.c:283:     if (!HpProc)
	cmp	r6, #0	@ HpProc,
	bne	.L394		@,
	b	.L385		@
.L412:
	.align	2
.L411:
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
	.type	GetBattleAnimPreconfType, %function
GetBattleAnimPreconfType:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:1047:     int result = gPlaySt.config.animationType;
	movs	r2, #66	@ tmp130,
@ C_Code.c:1046: {
	push	{r4, lr}	@
@ C_Code.c:1047:     int result = gPlaySt.config.animationType;
	ldr	r3, .L426	@ tmp164,
	ldrb	r0, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:1048:     if (!CheatCodeOn())
	ldrb	r2, [r3, #31]	@ tmp139,
@ C_Code.c:1047:     int result = gPlaySt.config.animationType;
	lsls	r0, r0, #29	@ tmp134, gPlaySt,
@ C_Code.c:1047:     int result = gPlaySt.config.animationType;
	lsrs	r0, r0, #30	@ <retval>, tmp134,
@ C_Code.c:1048:     if (!CheatCodeOn())
	cmp	r2, #127	@ tmp139,
	bhi	.L415		@,
@ C_Code.c:1050:         if (ForceAnimsOn)
	ldr	r2, .L426+4	@ tmp140,
@ C_Code.c:1050:         if (ForceAnimsOn)
	ldr	r2, [r2]	@ ForceAnimsOn, ForceAnimsOn
	cmp	r2, #0	@ ForceAnimsOn,
	beq	.L415		@,
@ C_Code.c:1052:             if (result == 2)
	cmp	r0, #2	@ <retval>,
	beq	.L414		@,
.L418:
@ C_Code.c:1058:                 return 1;
	movs	r0, #1	@ <retval>,
.L414:
@ C_Code.c:1081: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L415:
@ C_Code.c:1063:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r2, #66	@ tmp143,
	ldrb	r2, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:1063:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r3, #6	@ tmp149,
	ands	r3, r2	@ tmp150, gPlaySt
	cmp	r3, #4	@ tmp150,
	bne	.L414		@,
@ C_Code.c:1067:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	movs	r1, #11	@ tmp154,
@ C_Code.c:1068:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	movs	r4, #11	@ pretmp_25,
@ C_Code.c:1067:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldr	r0, .L426+8	@ tmp153,
@ C_Code.c:1068:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldr	r2, .L426+12	@ tmp152,
@ C_Code.c:1067:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldrsb	r1, [r0, r1]	@ tmp154,
	adds	r3, r3, #188	@ tmp155,
@ C_Code.c:1068:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldrsb	r4, [r2, r4]	@ pretmp_25,* pretmp_25
@ C_Code.c:1067:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	tst	r3, r1	@ tmp155, tmp154
	beq	.L425		@,
@ C_Code.c:1073:         if (UNIT_FACTION(&gBattleTarget.unit) != FACTION_BLUE)
	tst	r3, r4	@ tmp155, pretmp_25
	bne	.L418		@,
@ C_Code.c:1080:         return GetSoloAnimPreconfType(&gBattleTarget.unit);
	movs	r0, r2	@, tmp152
.L425:
	ldr	r3, .L426+16	@ tmp162,
	bl	.L10		@
	b	.L414		@
.L427:
	.align	2
.L426:
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
.LC136:
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
	.word	.LC136
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
	.ident	"GCC: (devkitARM release 63) 13.2.0"
	.text
	.code 16
	.align	1
.L10:
	bx	r3
.L129:
	bx	r4
.L28:
	bx	r5
.L413:
	bx	r6
.L71:
	bx	r10
