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
	.global	AreTimedHitsEnabled
	.syntax unified
	.code	16
	.thumb_func
	.type	AreTimedHitsEnabled, %function
AreTimedHitsEnabled:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:113:     if (gBattleStats.config &
	ldr	r3, .L8	@ tmp103,
@ C_Code.c:113:     if (gBattleStats.config &
	ldrh	r2, [r3]	@ gBattleStats, gBattleStats
	movs	r3, #252	@ tmp107,
	lsls	r3, r3, #2	@ tmp107, tmp107,
@ C_Code.c:112: {
	push	{r4, lr}	@
@ C_Code.c:113:     if (gBattleStats.config &
	tst	r2, r3	@ gBattleStats, tmp107
	bne	.L4		@,
@ C_Code.c:119:     if (TimedHitsDifficultyRam->off)
	ldr	r3, .L8+4	@ tmp112,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_4, *TimedHitsDifficultyRam.0_4
@ C_Code.c:119:     if (TimedHitsDifficultyRam->off)
	lsls	r3, r3, #25	@ tmp134, *TimedHitsDifficultyRam.0_4,
	bpl	.L7		@,
.L4:
@ C_Code.c:117:         return false;
	movs	r0, #0	@ <retval>,
.L1:
@ C_Code.c:124: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L7:
@ C_Code.c:123:     return !CheckFlag(DisabledFlag);
	ldr	r3, .L8+8	@ tmp122,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L8+12	@ tmp124,
	bl	.L10		@
@ C_Code.c:123:     return !CheckFlag(DisabledFlag);
	movs	r3, #1	@ tmp127,
	eors	r0, r3	@ tmp129, tmp127
	lsls	r0, r0, #24	@ tmp130, tmp129,
	lsrs	r0, r0, #24	@ <retval>, tmp130,
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
@ C_Code.c:133:     proc->timer2 = 0xFF;
	ldr	r2, .L12	@ tmp98,
@ C_Code.c:148: }
	@ sp needed	@
@ C_Code.c:128:     proc->anim = NULL;
	movs	r3, #0	@ tmp95,
@ C_Code.c:133:     proc->timer2 = 0xFF;
	str	r2, [r0, #68]	@ tmp98, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 68B]
@ C_Code.c:130:     proc->broke = false;
	movs	r2, #72	@ tmp99,
@ C_Code.c:137:     proc->side = 0xFF;
	movs	r1, #255	@ tmp103,
@ C_Code.c:128:     proc->anim = NULL;
	str	r3, [r0, #44]	@ tmp95, proc_2(D)->anim
@ C_Code.c:129:     proc->anim2 = NULL;
	str	r3, [r0, #48]	@ tmp95, proc_2(D)->anim2
@ C_Code.c:132:     proc->timer = 0;
	str	r3, [r0, #52]	@ tmp95, proc_2(D)->timer
@ C_Code.c:130:     proc->broke = false;
	strh	r3, [r0, r2]	@ tmp95, MEM <vector(2) unsigned char> [(unsigned char *)proc_2(D) + 72B]
@ C_Code.c:137:     proc->side = 0xFF;
	adds	r2, r2, #2	@ tmp102,
	strb	r1, [r0, r2]	@ tmp103, proc_2(D)->side
@ C_Code.c:141:     proc->frame = 0;
	ldr	r2, .L12+4	@ tmp108,
	str	r2, [r0, #76]	@ tmp108, MEM <vector(2) short unsigned int> [(short unsigned int *)proc_2(D) + 76B]
@ C_Code.c:145:     proc->codefframe = NO_FRAME;
	ldr	r2, .L12+8	@ tmp109,
	str	r2, [r0, #80]	@ tmp109, MEM <unsigned int> [(void *)proc_2(D) + 80B]
@ C_Code.c:143:     proc->buttonsToPress = 0;
	movs	r2, #84	@ tmp110,
@ C_Code.c:138:     proc->currentRound = NULL;
	str	r3, [r0, #56]	@ tmp95, proc_2(D)->currentRound
@ C_Code.c:139:     proc->active_bunit = NULL;
	str	r3, [r0, #60]	@ tmp95, proc_2(D)->active_bunit
@ C_Code.c:140:     proc->opp_bunit = NULL;
	str	r3, [r0, #64]	@ tmp95, proc_2(D)->opp_bunit
@ C_Code.c:143:     proc->buttonsToPress = 0;
	strh	r3, [r0, r2]	@ tmp95, proc_2(D)->buttonsToPress
@ C_Code.c:147:     proc->readAhead = 0;
	movs	r2, #0	@ tmp101,
	adds	r3, r3, #86	@ tmp113,
	strb	r2, [r0, r3]	@ tmp101, proc_2(D)->readAhead
@ C_Code.c:148: }
	bx	lr
.L13:
	.align	2
.L12:
	.word	16711935
	.word	-65536
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
@ C_Code.c:153:     proc = Proc_Find(TimedHitsProcCmd);
	ldr	r0, .L17	@,
	ldr	r3, .L17+4	@ tmp97,
	bl	.L10		@
	subs	r4, r0, #0	@ proc,,
@ C_Code.c:154:     if (!proc)
	beq	.L16		@,
.L14:
@ C_Code.c:159: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L16:
@ C_Code.c:156:         proc = Proc_Start(TimedHitsProcCmd, (void *)3);
	ldr	r3, .L17+8	@ tmp99,
	movs	r1, #3	@,
	ldr	r0, .L17	@,
	bl	.L10		@
@ C_Code.c:133:     proc->timer2 = 0xFF;
	ldr	r3, .L17+12	@ tmp103,
	str	r3, [r0, #68]	@ tmp103, MEM <vector(4) unsigned char> [(unsigned char *)proc_6 + 68B]
@ C_Code.c:130:     proc->broke = false;
	movs	r3, #72	@ tmp104,
@ C_Code.c:137:     proc->side = 0xFF;
	movs	r2, #255	@ tmp108,
@ C_Code.c:128:     proc->anim = NULL;
	str	r4, [r0, #44]	@ proc, proc_6->anim
@ C_Code.c:129:     proc->anim2 = NULL;
	str	r4, [r0, #48]	@ proc, proc_6->anim2
@ C_Code.c:132:     proc->timer = 0;
	str	r4, [r0, #52]	@ proc, proc_6->timer
@ C_Code.c:130:     proc->broke = false;
	strh	r4, [r0, r3]	@ proc, MEM <vector(2) unsigned char> [(unsigned char *)proc_6 + 72B]
@ C_Code.c:137:     proc->side = 0xFF;
	adds	r3, r3, #2	@ tmp107,
	strb	r2, [r0, r3]	@ tmp108, proc_6->side
@ C_Code.c:141:     proc->frame = 0;
	ldr	r3, .L17+16	@ tmp113,
	str	r3, [r0, #76]	@ tmp113, MEM <vector(2) short unsigned int> [(short unsigned int *)proc_6 + 76B]
@ C_Code.c:145:     proc->codefframe = NO_FRAME;
	ldr	r3, .L17+20	@ tmp114,
	str	r3, [r0, #80]	@ tmp114, MEM <unsigned int> [(void *)proc_6 + 80B]
@ C_Code.c:143:     proc->buttonsToPress = 0;
	movs	r3, #84	@ tmp115,
@ C_Code.c:147:     proc->readAhead = 0;
	movs	r2, #0	@ tmp106,
@ C_Code.c:138:     proc->currentRound = NULL;
	str	r4, [r0, #56]	@ proc, proc_6->currentRound
@ C_Code.c:139:     proc->active_bunit = NULL;
	str	r4, [r0, #60]	@ proc, proc_6->active_bunit
@ C_Code.c:140:     proc->opp_bunit = NULL;
	str	r4, [r0, #64]	@ proc, proc_6->opp_bunit
@ C_Code.c:143:     proc->buttonsToPress = 0;
	strh	r4, [r0, r3]	@ proc, proc_6->buttonsToPress
@ C_Code.c:147:     proc->readAhead = 0;
	adds	r3, r3, #2	@ tmp118,
	strb	r2, [r0, r3]	@ tmp106, proc_6->readAhead
@ C_Code.c:159: }
	b	.L14		@
.L18:
	.align	2
.L17:
	.word	.LANCHOR0
	.word	Proc_Find
	.word	Proc_Start
	.word	16711935
	.word	-65536
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
@ C_Code.c:163: {
	movs	r6, r0	@ anim, anim
@ C_Code.c:165:     proc = Proc_Find(TimedHitsProcCmd);
	ldr	r3, .L27	@ tmp113,
	ldr	r0, .L27+4	@ tmp112,
	bl	.L10		@
	subs	r4, r0, #0	@ proc,,
@ C_Code.c:166:     if (!proc)
	beq	.L19		@,
@ C_Code.c:171:     if (proc->roundId == roundId)
	movs	r7, #70	@ tmp115,
@ C_Code.c:170:     int roundId = anim->nextRoundId - 1;
	ldrh	r5, [r6, #14]	@ _2,
@ C_Code.c:171:     if (proc->roundId == roundId)
	ldrb	r3, [r0, r7]	@ _4,
@ C_Code.c:170:     int roundId = anim->nextRoundId - 1;
	subs	r5, r5, #1	@ roundId,
@ C_Code.c:171:     if (proc->roundId == roundId)
	cmp	r3, r5	@ _4, roundId
	beq	.L19		@,
@ C_Code.c:133:     proc->timer2 = 0xFF;
	ldr	r2, .L27+8	@ tmp119,
@ C_Code.c:129:     proc->anim2 = NULL;
	movs	r3, #0	@ tmp117,
@ C_Code.c:133:     proc->timer2 = 0xFF;
	str	r2, [r0, #68]	@ tmp119, MEM <vector(4) unsigned char> [(unsigned char *)proc_20 + 68B]
@ C_Code.c:130:     proc->broke = false;
	movs	r2, #72	@ tmp120,
@ C_Code.c:137:     proc->side = 0xFF;
	movs	r1, #255	@ tmp197,
@ C_Code.c:129:     proc->anim2 = NULL;
	str	r3, [r0, #48]	@ tmp117, proc_20->anim2
@ C_Code.c:132:     proc->timer = 0;
	str	r3, [r0, #52]	@ tmp117, proc_20->timer
@ C_Code.c:130:     proc->broke = false;
	strh	r3, [r0, r2]	@ tmp117, MEM <vector(2) unsigned char> [(unsigned char *)proc_20 + 72B]
@ C_Code.c:137:     proc->side = 0xFF;
	adds	r2, r2, #2	@ tmp195,
	strb	r1, [r0, r2]	@ tmp196, proc_20->side
@ C_Code.c:141:     proc->frame = 0;
	ldr	r2, .L27+12	@ tmp129,
	str	r2, [r0, #76]	@ tmp129, MEM <vector(2) short unsigned int> [(short unsigned int *)proc_20 + 76B]
@ C_Code.c:145:     proc->codefframe = NO_FRAME;
	ldr	r2, .L27+16	@ tmp130,
	str	r2, [r0, #80]	@ tmp130, MEM <unsigned int> [(void *)proc_20 + 80B]
@ C_Code.c:143:     proc->buttonsToPress = 0;
	movs	r2, #84	@ tmp131,
@ C_Code.c:138:     proc->currentRound = NULL;
	str	r3, [r0, #56]	@ tmp117, proc_20->currentRound
@ C_Code.c:139:     proc->active_bunit = NULL;
	str	r3, [r0, #60]	@ tmp117, proc_20->active_bunit
@ C_Code.c:140:     proc->opp_bunit = NULL;
	str	r3, [r0, #64]	@ tmp117, proc_20->opp_bunit
@ C_Code.c:143:     proc->buttonsToPress = 0;
	strh	r3, [r0, r2]	@ tmp117, proc_20->buttonsToPress
@ C_Code.c:147:     proc->readAhead = 0;
	movs	r2, #0	@ tmp122,
	adds	r3, r3, #86	@ tmp134,
	strb	r2, [r0, r3]	@ tmp122, proc_20->readAhead
@ C_Code.c:177:     proc->anim = anim;
	str	r6, [r0, #44]	@ anim, proc_20->anim
@ C_Code.c:178:     proc->anim2 = GetAnimAnotherSide(anim);
	ldr	r3, .L27+20	@ tmp137,
	movs	r0, r6	@, anim
	bl	.L10		@
@ C_Code.c:178:     proc->anim2 = GetAnimAnotherSide(anim);
	str	r0, [r4, #48]	@ _5, proc_20->anim2
@ C_Code.c:182:     proc->currentRound = GetCurrentRound(proc->roundId);
	movs	r0, #255	@ _7,
	ldr	r3, .L27+24	@ tmp142,
@ C_Code.c:179:     proc->roundId = roundId;
	strb	r5, [r4, r7]	@ roundId, proc_20->roundId
@ C_Code.c:182:     proc->currentRound = GetCurrentRound(proc->roundId);
	ands	r0, r5	@ _7, roundId
	bl	.L10		@
@ C_Code.c:183:     proc->side = GetAnimPosition(anim) ^ 1;
	ldr	r3, .L27+28	@ tmp143,
@ C_Code.c:182:     proc->currentRound = GetCurrentRound(proc->roundId);
	str	r0, [r4, #56]	@ _8, proc_20->currentRound
@ C_Code.c:183:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r0, r6	@, anim
	bl	.L10		@
@ C_Code.c:183:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r3, #1	@ tmp145,
@ C_Code.c:183:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r2, #74	@ tmp199,
@ C_Code.c:183:     proc->side = GetAnimPosition(anim) ^ 1;
	lsls	r0, r0, #24	@ tmp144, _9,
	asrs	r0, r0, #24	@ _10, tmp144,
	eors	r3, r0	@ tmp147, _10
@ C_Code.c:183:     proc->side = GetAnimPosition(anim) ^ 1;
	strb	r3, [r4, r2]	@ tmp147, proc_20->side
@ C_Code.c:184:     proc->active_bunit = gpEkrBattleUnitLeft;
	ldr	r3, .L27+32	@ tmp150,
@ C_Code.c:185:     proc->opp_bunit = gpEkrBattleUnitRight;
	ldr	r2, .L27+36	@ tmp151,
@ C_Code.c:184:     proc->active_bunit = gpEkrBattleUnitLeft;
	ldr	r3, [r3]	@ gpEkrBattleUnitLeft.2_13, gpEkrBattleUnitLeft
@ C_Code.c:185:     proc->opp_bunit = gpEkrBattleUnitRight;
	ldr	r2, [r2]	@ gpEkrBattleUnitRight.3_14, gpEkrBattleUnitRight
@ C_Code.c:184:     proc->active_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #60]	@ gpEkrBattleUnitLeft.2_13, proc_20->active_bunit
@ C_Code.c:185:     proc->opp_bunit = gpEkrBattleUnitRight;
	str	r2, [r4, #64]	@ gpEkrBattleUnitRight.3_14, proc_20->opp_bunit
@ C_Code.c:186:     if (!proc->side)
	cmp	r0, #1	@ _10,
	beq	.L25		@,
@ C_Code.c:191:     if (!proc->loadedImg)
	movs	r6, #73	@ tmp152,
@ C_Code.c:191:     if (!proc->loadedImg)
	ldrb	r3, [r4, r6]	@ tmp153,
	cmp	r3, #0	@ tmp153,
	beq	.L26		@,
.L19:
@ C_Code.c:203: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L25:
@ C_Code.c:191:     if (!proc->loadedImg)
	movs	r6, #73	@ tmp152,
@ C_Code.c:188:         proc->active_bunit = gpEkrBattleUnitRight;
	str	r2, [r4, #60]	@ gpEkrBattleUnitRight.3_14, proc_20->active_bunit
@ C_Code.c:189:         proc->opp_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #64]	@ gpEkrBattleUnitLeft.2_13, proc_20->opp_bunit
@ C_Code.c:191:     if (!proc->loadedImg)
	ldrb	r3, [r4, r6]	@ tmp153,
	cmp	r3, #0	@ tmp153,
	bne	.L19		@,
.L26:
@ C_Code.c:193:         Copy2dChr(&Press_Image, (void *)0x06012980, 6, 2);
	ldr	r5, .L27+40	@ tmp156,
	movs	r2, #6	@,
	ldr	r0, .L27+44	@ tmp155,
	ldr	r1, .L27+48	@,
	adds	r3, r3, #2	@,
	bl	.L29		@
@ C_Code.c:194:         Copy2dChr(&BattleStar, (void *)0x06012a40, 2, 2);   // 0x108
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+52	@ tmp158,
	ldr	r1, .L27+56	@,
	bl	.L29		@
@ C_Code.c:195:         Copy2dChr(&A_Button, (void *)0x06012800, 2, 2);     // 0x140
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+60	@ tmp161,
	ldr	r1, .L27+64	@,
	bl	.L29		@
@ C_Code.c:196:         Copy2dChr(&B_Button, (void *)0x06012840, 2, 2);     // 0x142
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+68	@ tmp164,
	ldr	r1, .L27+72	@,
	bl	.L29		@
@ C_Code.c:197:         Copy2dChr(&Left_Button, (void *)0x06012880, 2, 2);  // 0x144
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+76	@ tmp167,
	ldr	r1, .L27+80	@,
	bl	.L29		@
@ C_Code.c:198:         Copy2dChr(&Right_Button, (void *)0x060128C0, 2, 2); // 0x146
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+84	@ tmp170,
	ldr	r1, .L27+88	@,
	bl	.L29		@
@ C_Code.c:199:         Copy2dChr(&Up_Button, (void *)0x06012900, 2, 2);    // 0x148
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+92	@ tmp173,
	ldr	r1, .L27+96	@,
	bl	.L29		@
@ C_Code.c:200:         Copy2dChr(&Down_Button, (void *)0x06012940, 2, 2);  // 0x14a
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+100	@ tmp176,
	ldr	r1, .L27+104	@,
	bl	.L29		@
@ C_Code.c:201:         proc->loadedImg = true;
	movs	r3, #1	@ tmp179,
	strb	r3, [r4, r6]	@ tmp179, proc_20->loadedImg
	b	.L19		@
.L28:
	.align	2
.L27:
	.word	Proc_Find
	.word	.LANCHOR0
	.word	16711935
	.word	-65536
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
@ C_Code.c:283:     if (proc->broke)
	movs	r3, #72	@ tmp96,
@ C_Code.c:283:     if (proc->broke)
	ldrb	r2, [r0, r3]	@ tmp97,
	cmp	r2, #0	@ tmp97,
	bne	.L30		@,
@ C_Code.c:287:     proc->broke = true;
	adds	r2, r2, #1	@ tmp99,
	strb	r2, [r0, r3]	@ tmp99, proc_4(D)->broke
@ C_Code.c:288:     asm("mov r11, r11");
	.syntax divided
@ 288 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L30:
@ C_Code.c:289: }
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
@ C_Code.c:294:     if (!HpProc)
	cmp	r1, #0	@ HpProc,
	beq	.L34		@,
@ C_Code.c:299:     if (proc->EkrEfxIsUnitHittedNowFrames)
	movs	r3, #83	@ tmp99,
@ C_Code.c:299:     if (proc->EkrEfxIsUnitHittedNowFrames)
	ldrb	r0, [r0, r3]	@ tmp101,
	rsbs	r3, r0, #0	@ tmp103, tmp101
	adcs	r0, r0, r3	@ <retval>, tmp101, tmp103
.L32:
@ C_Code.c:304: }
	@ sp needed	@
	bx	lr
.L34:
@ C_Code.c:296:         return false;
	movs	r0, #0	@ <retval>,
	b	.L32		@
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
@ C_Code.c:373:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	movs	r3, #74	@ tmp104,
@ C_Code.c:372: {
	push	{r4, lr}	@
@ C_Code.c:373:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldr	r2, [r0, #60]	@ proc_6(D)->active_bunit, proc_6(D)->active_bunit
@ C_Code.c:387: }
	@ sp needed	@
@ C_Code.c:373:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldrh	r0, [r2, r3]	@ _3,
	ldr	r3, .L36	@ tmp106,
	bl	.L10		@
@ C_Code.c:382:     if (wepType == 7)
	movs	r3, #2	@ tmp111,
@ C_Code.c:378:     if (wepType == 6)
	subs	r0, r0, #5	@ _16,
@ C_Code.c:382:     if (wepType == 7)
	cmp	r3, r0	@ tmp111, _16
	sbcs	r0, r0, r0	@ tmp115
	rsbs	r0, r0, #0	@ _14, tmp115
@ C_Code.c:387: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L37:
	.align	2
.L36:
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
@ C_Code.c:392:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L68	@ tmp132,
@ C_Code.c:392:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:391: {
	mov	r10, r0	@ proc, proc
	sub	sp, sp, #8	@,,
@ C_Code.c:392:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	cmp	r3, #0	@ AlwaysA,
	bne	.L39		@,
@ C_Code.c:392:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L68+4	@ tmp134,
	ldr	r2, [r3]	@ TimedHitsDifficultyRam.10_2, TimedHitsDifficultyRam
@ C_Code.c:392:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.10_2, *TimedHitsDifficultyRam.10_2
	lsls	r3, r3, #26	@ tmp191, *TimedHitsDifficultyRam.10_2,
	bmi	.L39		@,
@ C_Code.c:396:     int keys = proc->buttonsToPress;
	movs	r3, #84	@ tmp144,
@ C_Code.c:396:     int keys = proc->buttonsToPress;
	ldrh	r4, [r0, r3]	@ <retval>,
@ C_Code.c:397:     if (!keys)
	cmp	r4, #0	@ <retval>,
	bne	.L38		@,
@ C_Code.c:399:         u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN };
	ldr	r3, .L68+8	@ tmp146,
	ldr	r1, [r3]	@ tmp149,
	str	r1, [sp]	@ tmp149,
	mov	r1, sp	@ tmp194,
	ldrh	r3, [r3, #4]	@ tmp151,
	strh	r3, [r1, #4]	@ tmp151,
@ C_Code.c:404:         int numberOfRandomButtons = NumberOfRandomButtons;
	ldr	r3, .L68+12	@ tmp153,
	ldr	r5, [r3]	@ numberOfRandomButtons, NumberOfRandomButtons
@ C_Code.c:373:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	movs	r3, #74	@ tmp155,
	ldr	r1, [r0, #60]	@ proc_31(D)->active_bunit, proc_31(D)->active_bunit
@ C_Code.c:404:         int numberOfRandomButtons = NumberOfRandomButtons;
	mov	r8, r5	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:373:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldrh	r0, [r1, r3]	@ _54,
@ C_Code.c:405:         if (!numberOfRandomButtons)
	cmp	r5, #0	@ numberOfRandomButtons,
	bne	.L42		@,
@ C_Code.c:373:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldr	r3, .L68+16	@ tmp162,
@ C_Code.c:407:             numberOfRandomButtons = TimedHitsDifficultyRam->difficulty;
	ldrb	r4, [r2]	@ *TimedHitsDifficultyRam.10_2, *TimedHitsDifficultyRam.10_2
@ C_Code.c:373:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	bl	.L10		@
@ C_Code.c:407:             numberOfRandomButtons = TimedHitsDifficultyRam->difficulty;
	lsls	r4, r4, #27	@ tmp160, *TimedHitsDifficultyRam.10_2,
@ C_Code.c:378:     if (wepType == 6)
	subs	r0, r0, #5	@ _28,
@ C_Code.c:407:             numberOfRandomButtons = TimedHitsDifficultyRam->difficulty;
	lsrs	r4, r4, #27	@ _6, tmp160,
@ C_Code.c:382:     if (wepType == 7)
	cmp	r0, #2	@ _28,
	bhi	.L43		@,
@ C_Code.c:413:         if (!numberOfRandomButtons)
	adds	r3, r4, #0	@ _68, _6
	cmp	r4, #0	@ _6,
	beq	.L66		@,
.L44:
	lsls	r3, r3, #24	@ tmp168, _68,
	lsrs	r3, r3, #24	@ numberOfRandomButtons, tmp168,
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
	b	.L45		@
.L39:
@ C_Code.c:394:         return A_BUTTON;
	movs	r4, #1	@ <retval>,
.L38:
@ C_Code.c:458: }
	movs	r0, r4	@, <retval>
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L42:
@ C_Code.c:373:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldr	r3, .L68+16	@ tmp183,
	bl	.L10		@
@ C_Code.c:378:     if (wepType == 6)
	subs	r0, r0, #5	@ _76,
@ C_Code.c:382:     if (wepType == 7)
	cmp	r0, #2	@ _76,
	bls	.L55		@,
@ C_Code.c:411:             numberOfRandomButtons = numberOfRandomButtons / 2;
	mov	r2, r8	@ numberOfRandomButtons, numberOfRandomButtons
	lsrs	r3, r2, #31	@ tmp170, numberOfRandomButtons,
	adds	r3, r3, r2	@ tmp171, tmp170, numberOfRandomButtons
	asrs	r3, r3, #1	@ numberOfRandomButtons, tmp171,
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:413:         if (!numberOfRandomButtons)
	bne	.L55		@,
.L57:
@ C_Code.c:415:             numberOfRandomButtons = 1;
	movs	r3, #1	@ numberOfRandomButtons,
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
.L45:
	ldr	r3, .L68+20	@ tmp186,
@ C_Code.c:418:         for (int i = 0; i < numberOfRandomButtons; ++i)
	movs	r4, #0	@ i,
@ C_Code.c:402:         int oppDir = 0;
	movs	r5, #0	@ oppDir,
@ C_Code.c:396:     int keys = proc->buttonsToPress;
	movs	r6, #0	@ keys,
@ C_Code.c:403:         int size = 5; // -1 since we count from 0
	movs	r7, #5	@ size,
	mov	r9, r3	@ tmp186, tmp186
	b	.L54		@
.L48:
@ C_Code.c:418:         for (int i = 0; i < numberOfRandomButtons; ++i)
	adds	r4, r4, #1	@ i,
@ C_Code.c:453:             keys |= button;
	orrs	r6, r0	@ keys, button
@ C_Code.c:418:         for (int i = 0; i < numberOfRandomButtons; ++i)
	cmp	r8, r4	@ numberOfRandomButtons, i
	ble	.L67		@,
.L54:
@ C_Code.c:420:             num = NextRN_N(size);
	movs	r0, r7	@, size
	bl	.L70		@
@ C_Code.c:421:             button = KeysList[num];
	mov	r3, sp	@ tmp211,
	ldrb	r0, [r3, r0]	@ button, KeysList
@ C_Code.c:424:             if (button & 0xF0)
	cmp	r0, #15	@ button,
	bls	.L48		@,
@ C_Code.c:426:                 if (button == DPAD_RIGHT)
	cmp	r0, #16	@ button,
	beq	.L59		@,
@ C_Code.c:430:                 if (button == DPAD_LEFT)
	cmp	r0, #32	@ button,
	beq	.L60		@,
@ C_Code.c:434:                 if (button == DPAD_UP)
	cmp	r0, #64	@ button,
	beq	.L61		@,
@ C_Code.c:438:                 if (button == DPAD_DOWN)
	cmp	r0, #128	@ button,
	bne	.L49		@,
@ C_Code.c:440:                     oppDir = DPAD_UP;
	movs	r5, #64	@ oppDir,
.L49:
@ C_Code.c:442:                 for (int c = 0; c <= size; ++c)
	cmp	r7, #0	@ size,
	blt	.L48		@,
	adds	r3, r7, #1	@ _13, size,
	mov	ip, r3	@ _13, _13
	mov	r2, sp	@ ivtmp.134,
@ C_Code.c:442:                 for (int c = 0; c <= size; ++c)
	movs	r3, #0	@ c,
	b	.L52		@
.L51:
@ C_Code.c:442:                 for (int c = 0; c <= size; ++c)
	adds	r3, r3, #1	@ c,
@ C_Code.c:442:                 for (int c = 0; c <= size; ++c)
	adds	r2, r2, #1	@ ivtmp.134,
	cmp	ip, r3	@ _13, c
	beq	.L48		@,
.L52:
@ C_Code.c:444:                     if (KeysList[c] == oppDir)
	ldrb	r1, [r2]	@ _10, MEM[(unsigned char *)_58]
@ C_Code.c:444:                     if (KeysList[c] == oppDir)
	cmp	r1, r5	@ _10, oppDir
	bne	.L51		@,
@ C_Code.c:446:                         KeysList[c] = KeysList[size];
	mov	r2, sp	@ tmp213,
@ C_Code.c:446:                         KeysList[c] = KeysList[size];
	mov	r1, sp	@ tmp214,
@ C_Code.c:446:                         KeysList[c] = KeysList[size];
	ldrb	r2, [r2, r7]	@ _11, KeysList
@ C_Code.c:418:         for (int i = 0; i < numberOfRandomButtons; ++i)
	adds	r4, r4, #1	@ i,
@ C_Code.c:446:                         KeysList[c] = KeysList[size];
	strb	r2, [r1, r3]	@ _11, KeysList[c_65]
@ C_Code.c:447:                         size--;
	subs	r7, r7, #1	@ size,
@ C_Code.c:453:             keys |= button;
	orrs	r6, r0	@ keys, button
@ C_Code.c:418:         for (int i = 0; i < numberOfRandomButtons; ++i)
	cmp	r8, r4	@ numberOfRandomButtons, i
	bgt	.L54		@,
.L67:
@ C_Code.c:455:         proc->buttonsToPress = keys;
	movs	r4, r6	@ <retval>, _56
.L47:
	movs	r3, #84	@ tmp180,
	mov	r2, r10	@ proc, proc
	strh	r6, [r2, r3]	@ _56, proc_31(D)->buttonsToPress
	b	.L38		@
.L55:
@ C_Code.c:418:         for (int i = 0; i < numberOfRandomButtons; ++i)
	mov	r3, r8	@ numberOfRandomButtons, numberOfRandomButtons
	cmp	r3, #0	@ numberOfRandomButtons,
	bgt	.L45		@,
	movs	r6, #0	@ _56,
	b	.L47		@
.L59:
@ C_Code.c:428:                     oppDir = DPAD_LEFT;
	movs	r5, #32	@ oppDir,
	b	.L49		@
.L60:
@ C_Code.c:432:                     oppDir = DPAD_RIGHT;
	movs	r5, #16	@ oppDir,
	b	.L49		@
.L61:
@ C_Code.c:436:                     oppDir = DPAD_DOWN;
	movs	r5, #128	@ oppDir,
	b	.L49		@
.L43:
@ C_Code.c:411:             numberOfRandomButtons = numberOfRandomButtons / 2;
	asrs	r3, r4, #1	@ numberOfRandomButtons, _6,
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:413:         if (!numberOfRandomButtons)
	cmp	r3, #0	@ numberOfRandomButtons,
	bgt	.L45		@,
	b	.L57		@
.L66:
	movs	r3, #1	@ _68,
	b	.L44		@
.L69:
	.align	2
.L68:
	.word	AlwaysA
	.word	TimedHitsDifficultyRam
	.word	.LC26
	.word	NumberOfRandomButtons
	.word	GetItemType
	.word	NextRN_N
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
	push	{r4, r5, lr}	@
@ C_Code.c:462: {
	movs	r4, r0	@ keys, keys
	ldr	r0, .L77	@ tmp102,
	movs	r2, r0	@ ivtmp.148, tmp102
@ C_Code.c:463:     int c = 0;
	movs	r1, #0	@ <retval>,
	adds	r2, r2, #32	@ ivtmp.148,
	adds	r0, r0, #38	@ _15,
.L73:
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ _21, MEM[(unsigned char *)_38]
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _22, keys
@ C_Code.c:468:             c++;
	subs	r5, r3, #1	@ tmp108, _22
	sbcs	r3, r3, r5	@ tmp107, _22, tmp108
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.148,
@ C_Code.c:468:             c++;
	adds	r1, r1, r3	@ <retval>, <retval>, tmp107
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	cmp	r2, r0	@ ivtmp.148, _15
	bne	.L73		@,
@ C_Code.c:472: }
	@ sp needed	@
	movs	r0, r1	@, <retval>
	pop	{r4, r5}
	pop	{r1}
	bx	r1
.L78:
	.align	2
.L77:
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
@ C_Code.c:475: {
	movs	r4, r1	@ keys, keys
@ C_Code.c:476:     int reqKeys = GetButtonsToPress(proc);
	bl	GetButtonsToPress		@
	mov	ip, r0	@ reqKeys,
	ldr	r0, .L104	@ tmp130,
	movs	r2, r0	@ ivtmp.171, tmp130
	adds	r2, r2, #32	@ ivtmp.171,
@ C_Code.c:477:     int count = CountKeysPressed(reqKeys);
	movs	r1, r2	@ ivtmp.183, ivtmp.171
@ C_Code.c:463:     int c = 0;
	movs	r5, #0	@ c,
	adds	r0, r0, #38	@ _39,
.L81:
@ C_Code.c:466:         if (keys & RomKeysList[i])
	mov	r6, ip	@ reqKeys, reqKeys
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ldrb	r3, [r1]	@ _112, MEM[(unsigned char *)_168]
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ands	r3, r6	@ _113, reqKeys
@ C_Code.c:468:             c++;
	subs	r7, r3, #1	@ tmp149, _113
	sbcs	r3, r3, r7	@ tmp148, _113, tmp149
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	adds	r1, r1, #1	@ ivtmp.183,
@ C_Code.c:468:             c++;
	adds	r5, r5, r3	@ c, c, tmp148
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	cmp	r0, r1	@ _39, ivtmp.183
	bne	.L81		@,
	movs	r1, r2	@ ivtmp.177, ivtmp.171
@ C_Code.c:463:     int c = 0;
	movs	r7, #0	@ c,
.L83:
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ldrb	r3, [r1]	@ _97, MEM[(unsigned char *)_132]
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _98, keys
@ C_Code.c:468:             c++;
	subs	r6, r3, #1	@ tmp152, _98
	sbcs	r3, r3, r6	@ tmp151, _98, tmp152
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	adds	r1, r1, #1	@ ivtmp.177,
@ C_Code.c:468:             c++;
	adds	r7, r7, r3	@ c, c, tmp151
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	cmp	r0, r1	@ _39, ivtmp.177
	bne	.L83		@,
@ C_Code.c:463:     int c = 0;
	movs	r1, #0	@ c,
@ C_Code.c:478:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r5, r7	@ c, c
	blt	.L84		@,
.L86:
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ _16, MEM[(unsigned char *)_88]
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _51, keys
@ C_Code.c:468:             c++;
	subs	r7, r3, #1	@ tmp155, _51
	sbcs	r3, r3, r7	@ tmp154, _51, tmp155
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.171,
@ C_Code.c:468:             c++;
	adds	r1, r1, r3	@ c, c, tmp154
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	cmp	r0, r2	@ _39, ivtmp.171
	bne	.L86		@,
@ C_Code.c:478:     if (ABS(count - CountKeysPressed(keys)) > 1)
	subs	r1, r5, r1	@ _3, c, c
@ C_Code.c:478:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r1, #1	@ _3,
	bgt	.L90		@,
.L87:
@ C_Code.c:482:     reqKeys &= ~keys; // only 0 if we hit all the correct keys (and possibly 1 extra)
	mov	r0, ip	@ reqKeys, reqKeys
	bics	r0, r4	@ reqKeys, keys
@ C_Code.c:483:     return (!reqKeys);
	rsbs	r3, r0, #0	@ tmp145, reqKeys_20
	adcs	r0, r0, r3	@ <retval>, reqKeys_20, tmp145
.L79:
@ C_Code.c:484: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L84:
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ _82, MEM[(unsigned char *)_69]
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _83, keys
@ C_Code.c:468:             c++;
	subs	r7, r3, #1	@ tmp158, _83
	sbcs	r3, r3, r7	@ tmp157, _83, tmp158
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.171,
@ C_Code.c:468:             c++;
	adds	r1, r1, r3	@ c, c, tmp157
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	cmp	r0, r2	@ _39, ivtmp.171
	bne	.L84		@,
@ C_Code.c:478:     if (ABS(count - CountKeysPressed(keys)) > 1)
	subs	r1, r1, r5	@ _4, c, c
@ C_Code.c:478:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r1, #1	@ _4,
	ble	.L87		@,
.L90:
@ C_Code.c:480:         return false;
	movs	r0, #0	@ <retval>,
	b	.L79		@
.L105:
	.align	2
.L104:
	.word	.LANCHOR0
	.size	PressedSpecificKeys, .-PressedSpecificKeys
	.align	1
	.p2align 2,,3
	.global	IsDamagingRound
	.syntax unified
	.code	16
	.thumb_func
	.type	IsDamagingRound, %function
IsDamagingRound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:488:     struct SkillSysBattleHit * round = proc->currentRound;
	ldr	r3, [r0, #56]	@ round, proc_6(D)->currentRound
@ C_Code.c:489:     if (!round)
	cmp	r3, #0	@ round,
	beq	.L109		@,
@ C_Code.c:493:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	ldr	r2, [r3]	@ *round_7, *round_7
@ C_Code.c:493:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	lsls	r2, r2, #30	@ tmp114, *round_7,
	bmi	.L109		@,
@ C_Code.c:497:     return round->hpChange > 0;
	ldrb	r3, [r3, #3]	@ tmp108,
	lsls	r3, r3, #24	@ tmp108, tmp108,
	asrs	r3, r3, #24	@ tmp108, tmp108,
	asrs	r0, r3, #31	@ tmp110, tmp108,
	subs	r0, r0, r3	@ tmp111, tmp110, tmp108
	lsrs	r0, r0, #31	@ <retval>, tmp111,
.L106:
@ C_Code.c:498: }
	@ sp needed	@
	bx	lr
.L109:
@ C_Code.c:491:         return false;
	movs	r0, #0	@ <retval>,
	b	.L106		@
	.size	IsDamagingRound, .-IsDamagingRound
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
@ C_Code.c:501:     struct Anim * anim = proc->anim;
	ldr	r2, [r0, #44]	@ anim, proc_18(D)->anim
@ C_Code.c:500: {
	push	{r4, r5, r6, lr}	@
@ C_Code.c:500: {
	movs	r4, r0	@ proc, proc
@ C_Code.c:502:     u32 instruction = *anim->pScrCurrent++;
	ldr	r0, [r2, #32]	@ _1, anim_19->pScrCurrent
@ C_Code.c:502:     u32 instruction = *anim->pScrCurrent++;
	ldr	r3, [r0]	@ instruction, *_1
	mov	ip, r3	@ instruction, instruction
@ C_Code.c:503:     if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND)
	movs	r3, #252	@ tmp120,
	mov	r5, ip	@ instruction, instruction
	lsls	r3, r3, #22	@ tmp120, tmp120,
	ands	r3, r5	@ _9, instruction
	movs	r5, #160	@ tmp121,
	lsls	r5, r5, #19	@ tmp121, tmp121,
	cmp	r3, r5	@ _9, tmp121
	beq	.L129		@,
.L112:
@ C_Code.c:522:     instruction = *anim->pScrCurrent--;
	str	r0, [r2, #32]	@ _1, anim_19->pScrCurrent
@ C_Code.c:523:     if (PressedSpecificKeys(proc, keys))
	movs	r0, r4	@, proc
	bl	PressedSpecificKeys		@
@ C_Code.c:523:     if (PressedSpecificKeys(proc, keys))
	cmp	r0, #0	@ _10,
	beq	.L111		@,
@ C_Code.c:525:         if (!proc->frame)
	movs	r3, #76	@ tmp152,
@ C_Code.c:525:         if (!proc->frame)
	ldrh	r2, [r4, r3]	@ tmp153,
	cmp	r2, #0	@ tmp153,
	beq	.L130		@,
.L111:
@ C_Code.c:531: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L129:
@ C_Code.c:505:         if ((ANINS_COMMAND_GET_ID(instruction) == 4) && (proc->code4frame == NO_FRAME))
	movs	r3, #255	@ tmp122,
	mov	r5, ip	@ instruction, instruction
	ands	r3, r5	@ _2, instruction
@ C_Code.c:505:         if ((ANINS_COMMAND_GET_ID(instruction) == 4) && (proc->code4frame == NO_FRAME))
	cmp	r3, #4	@ _2,
	beq	.L131		@,
@ C_Code.c:513:         if ((ANINS_COMMAND_GET_ID(instruction) == 0xF) && (proc->codefframe == NO_FRAME))
	cmp	r3, #15	@ _2,
	bne	.L112		@,
@ C_Code.c:513:         if ((ANINS_COMMAND_GET_ID(instruction) == 0xF) && (proc->codefframe == NO_FRAME))
	adds	r3, r3, #65	@ tmp139,
@ C_Code.c:513:         if ((ANINS_COMMAND_GET_ID(instruction) == 0xF) && (proc->codefframe == NO_FRAME))
	ldrh	r5, [r4, r3]	@ tmp140,
	mov	ip, r5	@ tmp140, tmp140
	ldr	r5, .L132	@ tmp141,
	cmp	ip, r5	@ tmp140, tmp141
	bne	.L112		@,
.L128:
@ C_Code.c:507:             proc->code4frame = proc->timer;
	ldr	r5, [r4, #52]	@ proc_18(D)->timer, proc_18(D)->timer
	strh	r5, [r4, r3]	@ proc_18(D)->timer,
@ C_Code.c:488:     struct SkillSysBattleHit * round = proc->currentRound;
	ldr	r3, [r4, #56]	@ round, proc_18(D)->currentRound
@ C_Code.c:489:     if (!round)
	cmp	r3, #0	@ round,
	beq	.L115		@,
@ C_Code.c:493:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	ldr	r5, [r3]	@ *round_34,* round
@ C_Code.c:493:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	lsls	r5, r5, #30	@ tmp168, *round_34,
	bmi	.L115		@,
@ C_Code.c:516:             if (!IsDamagingRound(proc))
	ldrb	r3, [r3, #3]	@ tmp151,
	lsls	r3, r3, #24	@ tmp151, tmp151,
	asrs	r3, r3, #24	@ tmp151, tmp151,
	cmp	r3, #0	@ tmp151,
	bgt	.L112		@,
.L115:
@ C_Code.c:510:                 proc->timer2 = 0;
	movs	r3, #68	@ tmp129,
	movs	r5, #0	@ tmp130,
	strb	r5, [r4, r3]	@ tmp130, proc_18(D)->timer2
	b	.L112		@
.L130:
@ C_Code.c:528:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	movs	r1, #128	@,
	movs	r0, #159	@,
@ C_Code.c:527:             proc->frame = proc->timer;     // locate is side for stereo?
	ldr	r2, [r4, #52]	@ proc_18(D)->timer, proc_18(D)->timer
@ C_Code.c:528:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	lsls	r1, r1, #1	@,,
@ C_Code.c:527:             proc->frame = proc->timer;     // locate is side for stereo?
	strh	r2, [r4, r3]	@ proc_18(D)->timer, proc_18(D)->frame
@ C_Code.c:528:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	lsls	r0, r0, #1	@,,
	movs	r2, #120	@,
	ldr	r4, .L132+4	@ tmp159,
	subs	r3, r3, #75	@,
	bl	.L134		@
@ C_Code.c:531: }
	b	.L111		@
.L131:
@ C_Code.c:505:         if ((ANINS_COMMAND_GET_ID(instruction) == 4) && (proc->code4frame == NO_FRAME))
	adds	r3, r3, #74	@ tmp123,
@ C_Code.c:505:         if ((ANINS_COMMAND_GET_ID(instruction) == 4) && (proc->code4frame == NO_FRAME))
	ldrh	r5, [r4, r3]	@ tmp124,
	mov	ip, r5	@ tmp124, tmp124
	ldr	r5, .L132	@ tmp125,
	cmp	ip, r5	@ tmp124, tmp125
	bne	.L112		@,
	b	.L128		@
.L133:
	.align	2
.L132:
	.word	65535
	.word	PlaySFX
	.size	SaveInputFrame, .-SaveInputFrame
	.align	1
	.p2align 2,,3
	.global	GetFramesUntilPhysicalHit
	.syntax unified
	.code	16
	.thumb_func
	.type	GetFramesUntilPhysicalHit, %function
GetFramesUntilPhysicalHit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, fp	@,
	mov	r7, r10	@,
	mov	r6, r9	@,
	mov	r5, r8	@,
@ C_Code.c:536:     struct Anim * anim = proc->anim;
	ldr	r3, [r0, #44]	@ anim, proc_34(D)->anim
@ C_Code.c:535: {
	movs	r2, r0	@ proc, proc
	push	{r5, r6, r7, lr}	@
@ C_Code.c:537:     if (!anim || !anim->pScrCurrent)
	cmp	r3, #0	@ anim,
	beq	.L136		@,
@ C_Code.c:537:     if (!anim || !anim->pScrCurrent)
	ldr	r0, [r3, #32]	@ scr, anim_35->pScrCurrent
@ C_Code.c:537:     if (!anim || !anim->pScrCurrent)
	cmp	r0, #0	@ scr,
	beq	.L136		@,
@ C_Code.c:541:     int isMiss = proc->currentRound && (proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS);
	ldr	r2, [r2, #56]	@ _2, proc_34(D)->currentRound
@ C_Code.c:541:     int isMiss = proc->currentRound && (proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS);
	cmp	r2, #0	@ _2,
	beq	.L154		@,
@ C_Code.c:541:     int isMiss = proc->currentRound && (proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS);
	ldr	r2, [r2]	@ *_2, *_2
@ C_Code.c:541:     int isMiss = proc->currentRound && (proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS);
	lsls	r2, r2, #30	@ tmp134, *_2,
	lsrs	r2, r2, #31	@ iftmp.15_32, tmp134,
	mov	fp, r2	@ iftmp.15_32, iftmp.15_32
.L139:
@ C_Code.c:543:     int frames = anim->timer;
	movs	r4, #6	@ <retval>,
	ldrsh	r4, [r3, r4]	@ <retval>, anim, <retval>
@ C_Code.c:554:             if (ANINS_PTRINS_GET_TYPE(instruction) == 0)
	movs	r3, #192	@ tmp163,
	lsls	r3, r3, #22	@ tmp163, tmp163,
	mov	ip, r3	@ tmp163, tmp163
@ C_Code.c:549:             frames += ANINS_FORCESPRITE_GET_DELAY(instruction);
	movs	r3, #28	@ tmp164,
@ C_Code.c:543:     int frames = anim->timer;
	movs	r1, #128	@ ivtmp_27,
@ C_Code.c:552:         if (ANINS_IS_PTRINS(instruction))
	movs	r5, #128	@ tmp161,
@ C_Code.c:549:             frames += ANINS_FORCESPRITE_GET_DELAY(instruction);
	mov	r9, r3	@ tmp164, tmp164
	subs	r3, r3, #25	@ tmp165,
	mov	r10, r3	@ tmp165, tmp165
@ C_Code.c:543:     int frames = anim->timer;
	lsls	r1, r1, #3	@ ivtmp_27, ivtmp_27,
@ C_Code.c:552:         if (ANINS_IS_PTRINS(instruction))
	lsls	r5, r5, #23	@ tmp161, tmp161,
	b	.L153		@
.L140:
@ C_Code.c:552:         if (ANINS_IS_PTRINS(instruction))
	tst	r3, r5	@ instruction, tmp161
	beq	.L142		@,
@ C_Code.c:554:             if (ANINS_PTRINS_GET_TYPE(instruction) == 0)
	mov	r0, ip	@ tmp163, tmp163
	tst	r3, r0	@ instruction, tmp163
	bne	.L136		@,
@ C_Code.c:546:         u32 instruction = *scr++;
	movs	r0, r2	@ scr, scr
.L141:
@ C_Code.c:544:     for (int i = 0; i < READAHEAD_MAX_WORDS; ++i)
	subs	r1, r1, #1	@ ivtmp_27,
	cmp	r1, #0	@ ivtmp_27,
	beq	.L136		@,
.L153:
@ C_Code.c:546:         u32 instruction = *scr++;
	movs	r2, r0	@ scr, scr
@ C_Code.c:546:         u32 instruction = *scr++;
	ldmia	r2!, {r3}	@ *scr_53, instruction
@ C_Code.c:547:         if (!ANINS_IS_NOT_FORCESPRITE(instruction))
	cmp	r3, #0	@ instruction,
	blt	.L140		@,
@ C_Code.c:549:             frames += ANINS_FORCESPRITE_GET_DELAY(instruction);
	mov	r6, r9	@ tmp164, tmp164
	lsrs	r0, r3, #26	@ _6, instruction,
	ands	r0, r6	@ _7, tmp164
	mov	r6, r10	@ tmp165, tmp165
	ands	r3, r6	@ _8, tmp165
	orrs	r3, r0	@ _9, _7
@ C_Code.c:549:             frames += ANINS_FORCESPRITE_GET_DELAY(instruction);
	adds	r4, r3, r4	@ <retval>, _9, <retval>
@ C_Code.c:546:         u32 instruction = *scr++;
	movs	r0, r2	@ scr, scr
@ C_Code.c:550:             continue;
	b	.L141		@
.L142:
@ C_Code.c:560:         switch (ANINS_GET_TYPE(instruction))
	movs	r7, #63	@ tmp179,
	lsrs	r6, r3, #24	@ _13, instruction,
	ands	r6, r7	@ _13, tmp179
@ C_Code.c:560:         switch (ANINS_GET_TYPE(instruction))
	cmp	r6, #5	@ _14,
	beq	.L143		@,
	bhi	.L144		@,
	cmp	r6, #3	@ _14,
	beq	.L145		@,
	cmp	r6, #4	@ _14,
	bne	.L136		@,
@ C_Code.c:563:                 frames += ANINS_WAIT_GET_DELAY(instruction);
	lsls	r3, r3, #16	@ tmp148, instruction,
	lsrs	r3, r3, #16	@ _15, tmp148,
@ C_Code.c:546:         u32 instruction = *scr++;
	movs	r0, r2	@ scr, scr
@ C_Code.c:563:                 frames += ANINS_WAIT_GET_DELAY(instruction);
	adds	r4, r3, r4	@ <retval>, _15, <retval>
@ C_Code.c:564:                 break;
	b	.L141		@
.L144:
@ C_Code.c:560:         switch (ANINS_GET_TYPE(instruction))
	cmp	r6, #6	@ _14,
	bne	.L136		@,
@ C_Code.c:569:                 frames += ANINS_FRAME_GET_DELAY(instruction);
	lsls	r3, r3, #16	@ tmp153, instruction,
	lsrs	r3, r3, #16	@ _22, tmp153,
@ C_Code.c:569:                 frames += ANINS_FRAME_GET_DELAY(instruction);
	adds	r4, r3, r4	@ <retval>, _22, <retval>
@ C_Code.c:570:                 scr += 2;
	adds	r0, r0, #12	@ scr,
@ C_Code.c:571:                 break;
	b	.L141		@
.L136:
@ C_Code.c:539:         return -1;
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
.L135:
@ C_Code.c:599: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	mov	fp, r7
	mov	r10, r6
	mov	r9, r5
	mov	r8, r4
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L143:
@ C_Code.c:573:                 switch (ANINS_COMMAND_GET_ID(instruction))
	movs	r0, #255	@ tmp154,
	ands	r3, r0	@ _25, tmp154
@ C_Code.c:573:                 switch (ANINS_COMMAND_GET_ID(instruction))
	cmp	r3, #26	@ _25,
	bhi	.L148		@,
	ldr	r0, .L160	@ tmp158,
	lsls	r3, r3, #2	@ tmp156, _25,
	ldr	r3, [r0, r3]	@ tmp159,
	mov	pc, r3	@ tmp159
	.section	.rodata
	.align	2
.L150:
	.word	.L148
	.word	.L136
	.word	.L148
	.word	.L148
	.word	.L151
	.word	.L136
	.word	.L148
	.word	.L148
	.word	.L135
	.word	.L135
	.word	.L135
	.word	.L135
	.word	.L135
	.word	.L148
	.word	.L148
	.word	.L148
	.word	.L148
	.word	.L148
	.word	.L148
	.word	.L148
	.word	.L148
	.word	.L148
	.word	.L148
	.word	.L148
	.word	.L148
	.word	.L148
	.word	.L135
	.text
.L145:
@ C_Code.c:566:                 frames += ANINS_MOVE_GET_DELAY(instruction);
	lsls	r3, r3, #8	@ tmp150, instruction,
	lsrs	r3, r3, #24	@ _19, tmp150,
@ C_Code.c:546:         u32 instruction = *scr++;
	movs	r0, r2	@ scr, scr
@ C_Code.c:566:                 frames += ANINS_MOVE_GET_DELAY(instruction);
	adds	r4, r3, r4	@ <retval>, _19, <retval>
@ C_Code.c:567:                 break;
	b	.L141		@
.L151:
@ C_Code.c:583:                         if (isMiss)
	mov	r3, fp	@ iftmp.15_32, iftmp.15_32
	cmp	r3, #0	@ iftmp.15_32,
	bne	.L135		@,
.L148:
@ C_Code.c:546:         u32 instruction = *scr++;
	movs	r0, r2	@ scr, scr
@ C_Code.c:592:                 frames += 1;
	adds	r4, r4, #1	@ <retval>,
@ C_Code.c:593:                 break;
	b	.L141		@
.L154:
@ C_Code.c:541:     int isMiss = proc->currentRound && (proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS);
	mov	fp, r2	@ iftmp.15_32, iftmp.15_32
	b	.L139		@
.L161:
	.align	2
.L160:
	.word	.L150
	.size	GetFramesUntilPhysicalHit, .-GetFramesUntilPhysicalHit
	.align	1
	.p2align 2,,3
	.global	SaveInputFrameReadAhead
	.syntax unified
	.code	16
	.thumb_func
	.type	SaveInputFrameReadAhead, %function
SaveInputFrameReadAhead:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ C_Code.c:602: {
	movs	r4, r0	@ proc, proc
	movs	r7, r1	@ keys, keys
@ C_Code.c:603:     int untilHit = GetFramesUntilPhysicalHit(proc);
	bl	GetFramesUntilPhysicalHit		@
@ C_Code.c:609:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	movs	r3, #76	@ tmp116,
	ldrh	r5, [r4, r3]	@ pretmp_57,
@ C_Code.c:606:         if (!(proc->readAhead & READAHEAD_FOUND))
	adds	r3, r3, #10	@ tmp117,
	ldrb	r2, [r4, r3]	@ pretmp_45,
	subs	r3, r3, #85	@ tmp121,
	ands	r3, r2	@ _20, pretmp_45
@ C_Code.c:604:     if (untilHit >= 0)
	cmp	r0, #0	@ untilHit,
	blt	.L163		@,
@ C_Code.c:606:         if (!(proc->readAhead & READAHEAD_FOUND))
	cmp	r3, #0	@ _20,
	beq	.L185		@,
.L189:
	ldr	r1, .L193	@ tmp175,
.L164:
@ C_Code.c:622:         if (untilHit < LenienceFrames)
	ldr	r3, [r1]	@ LenienceFrames, LenienceFrames
	cmp	r3, r0	@ LenienceFrames, untilHit
	bgt	.L190		@,
@ C_Code.c:628:             proc->readAhead &= ~READAHEAD_WINDOW_OPEN;
	movs	r3, #2	@ tmp144,
	bics	r2, r3	@ tmp143, tmp144
	adds	r3, r3, #84	@ tmp145,
	strb	r2, [r4, r3]	@ tmp143, proc_25(D)->readAhead
.L167:
@ C_Code.c:633:     SaveInputFrame(proc, keys);
	movs	r1, r7	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
@ C_Code.c:634:     if ((proc->readAhead & READAHEAD_FOUND) && !hadPress && proc->frame)
	movs	r2, #86	@ tmp147,
	ldrb	r3, [r4, r2]	@ _17,
@ C_Code.c:634:     if ((proc->readAhead & READAHEAD_FOUND) && !hadPress && proc->frame)
	cmp	r5, #0	@ pretmp_57,
	bne	.L162		@,
	lsls	r1, r3, #31	@ tmp181, _17,
	bmi	.L191		@,
.L162:
@ C_Code.c:641: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L185:
@ C_Code.c:608:             proc->readAhead |= READAHEAD_FOUND;
	movs	r3, #1	@ tmp118,
	orrs	r3, r2	@ tmp125, pretmp_45
	lsls	r3, r3, #24	@ tmp126, tmp125,
@ C_Code.c:609:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	cmp	r5, #0	@ pretmp_57,
	beq	.L192		@,
@ C_Code.c:609:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	ldr	r1, [r4, #52]	@ proc_25(D)->timer, proc_25(D)->timer
	subs	r1, r1, r5	@ _7, proc_25(D)->timer, pretmp_57
@ C_Code.c:609:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	mov	ip, r1	@ _7, _7
@ C_Code.c:609:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	ldr	r1, .L193	@ tmp175,
@ C_Code.c:609:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	ldr	r6, [r1]	@ LenienceFrames, LenienceFrames
@ C_Code.c:609:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	add	ip, ip, r0	@ _7, untilHit
@ C_Code.c:609:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	cmp	ip, r6	@ _8, LenienceFrames
	blt	.L165		@,
@ C_Code.c:611:                 proc->readAhead |= READAHEAD_PRESSED_EARLY;
	movs	r3, #5	@ tmp135,
	orrs	r2, r3	@ pretmp_45, tmp135
	b	.L164		@
.L190:
@ C_Code.c:624:             proc->readAhead |= READAHEAD_WINDOW_OPEN;
	movs	r3, #2	@ tmp138,
	orrs	r3, r2	@ tmp140, pretmp_45
	movs	r2, #86	@ tmp141,
	strb	r3, [r4, r2]	@ tmp140, proc_25(D)->readAhead
	b	.L167		@
.L163:
@ C_Code.c:615:     else if (proc->readAhead & READAHEAD_FOUND)
	cmp	r3, #0	@ _20,
	beq	.L167		@,
@ C_Code.c:617:         untilHit = 0; // already past the hit command
	movs	r0, #0	@ untilHit,
	b	.L189		@
.L191:
@ C_Code.c:634:     if ((proc->readAhead & READAHEAD_FOUND) && !hadPress && proc->frame)
	movs	r1, #76	@ tmp161,
@ C_Code.c:634:     if ((proc->readAhead & READAHEAD_FOUND) && !hadPress && proc->frame)
	ldrh	r1, [r4, r1]	@ tmp162,
	cmp	r1, #0	@ tmp162,
	beq	.L162		@,
@ C_Code.c:636:         if (!(proc->readAhead & READAHEAD_WINDOW_OPEN))
	lsls	r1, r3, #30	@ tmp182, _17,
	bmi	.L162		@,
@ C_Code.c:638:             proc->readAhead |= READAHEAD_PRESSED_EARLY;
	movs	r1, #4	@ tmp170,
	orrs	r3, r1	@ tmp172, tmp170
	strb	r3, [r4, r2]	@ tmp172, proc_25(D)->readAhead
@ C_Code.c:641: }
	b	.L162		@
.L192:
	ldr	r1, .L193	@ tmp175,
.L165:
@ C_Code.c:602: {
	lsrs	r2, r3, #24	@ pretmp_45, tmp126,
	b	.L164		@
.L194:
	.align	2
.L193:
	.word	LenienceFrames
	.size	SaveInputFrameReadAhead, .-SaveInputFrameReadAhead
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
	@ link register save eliminated.
@ C_Code.c:645:     if (proc->readAhead & READAHEAD_FOUND)
	movs	r3, #86	@ tmp103,
@ C_Code.c:647:         if (proc->frame && !(proc->readAhead & READAHEAD_PRESSED_EARLY))
	movs	r2, #76	@ tmp104,
@ C_Code.c:645:     if (proc->readAhead & READAHEAD_FOUND)
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:647:         if (proc->frame && !(proc->readAhead & READAHEAD_PRESSED_EARLY))
	ldrh	r2, [r0, r2]	@ pretmp_15,
@ C_Code.c:645:     if (proc->readAhead & READAHEAD_FOUND)
	lsls	r1, r3, #31	@ tmp127, _1,
	bmi	.L206		@,
@ C_Code.c:653:     if (proc->frame)
	cmp	r2, #0	@ pretmp_15,
	beq	.L195		@,
@ C_Code.c:669:         if ((proc->timer - proc->frame) < LenienceFrames)
	ldr	r3, [r0, #52]	@ proc_6(D)->timer, proc_6(D)->timer
	subs	r3, r3, r2	@ _13, proc_6(D)->timer, pretmp_15
@ C_Code.c:669:         if ((proc->timer - proc->frame) < LenienceFrames)
	ldr	r2, .L207	@ tmp124,
@ C_Code.c:669:         if ((proc->timer - proc->frame) < LenienceFrames)
	ldr	r2, [r2]	@ LenienceFrames, LenienceFrames
	cmp	r3, r2	@ _13, LenienceFrames
	bge	.L195		@,
.L198:
@ C_Code.c:649:             proc->hitOnTime = true;
	movs	r3, #69	@ tmp119,
	movs	r2, #1	@ tmp120,
	strb	r2, [r0, r3]	@ tmp120, proc_6(D)->hitOnTime
.L195:
@ C_Code.c:674: }
	@ sp needed	@
	bx	lr
.L206:
@ C_Code.c:647:         if (proc->frame && !(proc->readAhead & READAHEAD_PRESSED_EARLY))
	cmp	r2, #0	@ pretmp_15,
	beq	.L195		@,
@ C_Code.c:647:         if (proc->frame && !(proc->readAhead & READAHEAD_PRESSED_EARLY))
	lsls	r3, r3, #29	@ tmp128, _1,
	bmi	.L195		@,
	b	.L198		@
.L208:
	.align	2
.L207:
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
@ C_Code.c:678:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L210	@ tmp98,
@ C_Code.c:679: }
	@ sp needed	@
@ C_Code.c:678:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldrb	r0, [r3, #31]	@ tmp100,
	movs	r3, #127	@ tmp102,
	bics	r0, r3	@ _3, tmp102
@ C_Code.c:679: }
	bx	lr
.L211:
	.align	2
.L210:
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
@ C_Code.c:678:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L216	@ tmp100,
@ C_Code.c:683:     if (CheatCodeOn())
	ldrb	r3, [r3, #31]	@ tmp101,
	cmp	r3, #127	@ tmp101,
	bhi	.L215		@,
@ C_Code.c:687:     if (AlwaysWork)
	ldr	r3, .L216+4	@ tmp102,
@ C_Code.c:687:     if (AlwaysWork)
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L215		@,
@ C_Code.c:691:     return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp104,
	ldrb	r0, [r0, r3]	@ <retval>,
	b	.L212		@
.L215:
@ C_Code.c:685:         return true;
	movs	r0, #1	@ <retval>,
.L212:
@ C_Code.c:692: }
	@ sp needed	@
	bx	lr
.L217:
	.align	2
.L216:
	.word	gPlaySt
	.word	AlwaysWork
	.size	DidWeHitOnTime, .-DidWeHitOnTime
	.align	1
	.p2align 2,,3
	.global	PressedTooEarly
	.syntax unified
	.code	16
	.thumb_func
	.type	PressedTooEarly, %function
PressedTooEarly:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ C_Code.c:696:     if (proc->readAhead & READAHEAD_FOUND)
	movs	r2, #86	@ tmp107,
@ C_Code.c:696:     if (proc->readAhead & READAHEAD_FOUND)
	ldrb	r2, [r0, r2]	@ tmp111,
@ C_Code.c:695: {
	movs	r3, r0	@ proc, proc
@ C_Code.c:696:     if (proc->readAhead & READAHEAD_FOUND)
	lsls	r2, r2, #31	@ tmp133, tmp111,
	bmi	.L221		@,
@ C_Code.c:700:     if (!proc->frame)
	movs	r2, #76	@ tmp117,
	ldrh	r2, [r0, r2]	@ _7,
@ C_Code.c:700:     if (!proc->frame)
	cmp	r2, #0	@ _7,
	beq	.L221		@,
@ C_Code.c:678:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r1, .L225	@ tmp118,
@ C_Code.c:683:     if (CheatCodeOn())
	ldrb	r1, [r1, #31]	@ tmp119,
	cmp	r1, #127	@ tmp119,
	bhi	.L221		@,
@ C_Code.c:687:     if (AlwaysWork)
	ldr	r1, .L225+4	@ tmp120,
	ldr	r0, [r1]	@ <retval>, AlwaysWork
@ C_Code.c:687:     if (AlwaysWork)
	cmp	r0, #0	@ <retval>,
	bne	.L221		@,
@ C_Code.c:691:     return proc->hitOnTime;
	movs	r1, #69	@ tmp121,
@ C_Code.c:704:     if (DidWeHitOnTime(proc))
	ldrb	r1, [r3, r1]	@ tmp122,
	cmp	r1, #0	@ tmp122,
	bne	.L218		@,
@ C_Code.c:708:     return (proc->timer - proc->frame) >= LenienceFrames;
	ldr	r3, [r3, #52]	@ proc_5(D)->timer, proc_5(D)->timer
	subs	r3, r3, r2	@ _11, proc_5(D)->timer, _7
@ C_Code.c:708:     return (proc->timer - proc->frame) >= LenienceFrames;
	ldr	r2, .L225+8	@ tmp125,
	ldr	r2, [r2]	@ LenienceFrames, LenienceFrames
	asrs	r0, r3, #31	@ tmp129, _11,
	lsrs	r1, r2, #31	@ tmp130, LenienceFrames,
	cmp	r3, r2	@ _11, LenienceFrames
	adcs	r0, r0, r1	@ <retval>, tmp129, tmp130
	b	.L218		@
.L221:
@ C_Code.c:698:         return false;
	movs	r0, #0	@ <retval>,
.L218:
@ C_Code.c:709: }
	@ sp needed	@
	bx	lr
.L226:
	.align	2
.L225:
	.word	gPlaySt
	.word	AlwaysWork
	.word	LenienceFrames
	.size	PressedTooEarly, .-PressedTooEarly
	.align	1
	.p2align 2,,3
	.global	DrawButtonsToPress
	.syntax unified
	.code	16
	.thumb_func
	.type	DrawButtonsToPress, %function
DrawButtonsToPress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r7, r9	@,
	mov	r6, r8	@,
	mov	lr, r10	@,
	push	{r6, r7, lr}	@
	mov	r9, r2	@ y, y
@ C_Code.c:713:     if (!DisplayPress)
	ldr	r2, .L297	@ tmp159,
@ C_Code.c:713:     if (!DisplayPress)
	ldr	r2, [r2]	@ DisplayPress, DisplayPress
@ C_Code.c:712: {
	movs	r5, r0	@ proc, proc
	movs	r7, r1	@ x, x
	movs	r6, r3	@ palID, palID
	sub	sp, sp, #16	@,,
@ C_Code.c:713:     if (!DisplayPress)
	cmp	r2, #0	@ DisplayPress,
	beq	.L227		@,
@ C_Code.c:696:     if (proc->readAhead & READAHEAD_FOUND)
	movs	r3, #86	@ tmp161,
@ C_Code.c:696:     if (proc->readAhead & READAHEAD_FOUND)
	ldrb	r2, [r0, r3]	@ tmp165,
	lsls	r2, r2, #31	@ tmp307, tmp165,
	bmi	.L229		@,
@ C_Code.c:700:     if (!proc->frame)
	subs	r3, r3, #10	@ tmp171,
	ldrh	r3, [r0, r3]	@ _14,
@ C_Code.c:700:     if (!proc->frame)
	cmp	r3, #0	@ _14,
	beq	.L229		@,
@ C_Code.c:678:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r2, .L297+4	@ tmp172,
@ C_Code.c:683:     if (CheatCodeOn())
	ldrb	r2, [r2, #31]	@ tmp173,
	cmp	r2, #127	@ tmp173,
	bhi	.L229		@,
@ C_Code.c:687:     if (AlwaysWork)
	ldr	r2, .L297+8	@ tmp174,
@ C_Code.c:687:     if (AlwaysWork)
	ldr	r2, [r2]	@ AlwaysWork, AlwaysWork
	cmp	r2, #0	@ AlwaysWork,
	bne	.L229		@,
@ C_Code.c:691:     return proc->hitOnTime;
	adds	r2, r2, #69	@ tmp176,
@ C_Code.c:704:     if (DidWeHitOnTime(proc))
	ldrb	r2, [r0, r2]	@ tmp177,
	cmp	r2, #0	@ tmp177,
	bne	.L229		@,
@ C_Code.c:708:     return (proc->timer - proc->frame) >= LenienceFrames;
	ldr	r2, [r0, #52]	@ proc_5(D)->timer, proc_5(D)->timer
	subs	r3, r2, r3	@ _18, proc_5(D)->timer, _14
@ C_Code.c:708:     return (proc->timer - proc->frame) >= LenienceFrames;
	ldr	r2, .L297+12	@ tmp180,
@ C_Code.c:717:     if (PressedTooEarly(proc))
	ldr	r2, [r2]	@ LenienceFrames, LenienceFrames
	cmp	r3, r2	@ _18, LenienceFrames
	blt	.L229		@,
.L227:
@ C_Code.c:798: }
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L229:
@ C_Code.c:721:     int keys = GetButtonsToPress(proc);
	movs	r0, r5	@, proc
	bl	GetButtonsToPress		@
@ C_Code.c:723:     if (proc->readAhead & READAHEAD_FOUND)
	movs	r3, #86	@ tmp182,
	ldrb	r2, [r5, r3]	@ _32,
@ C_Code.c:721:     int keys = GetButtonsToPress(proc);
	movs	r4, r0	@ keys,
@ C_Code.c:723:     if (proc->readAhead & READAHEAD_FOUND)
	lsls	r3, r2, #31	@ tmp308, _32,
	bpl	.L230		@,
@ C_Code.c:726:         int hitHappened = proc->EkrEfxIsUnitHittedNowFrames != 0xFF; // after the hit we only draw this on a fail
	movs	r3, #83	@ tmp190,
@ C_Code.c:727:         if ((proc->readAhead & READAHEAD_PRESSED_EARLY) || hitHappened)
	movs	r1, #4	@ tmp199,
@ C_Code.c:726:         int hitHappened = proc->EkrEfxIsUnitHittedNowFrames != 0xFF; // after the hit we only draw this on a fail
	ldrb	r3, [r5, r3]	@ tmp192,
@ C_Code.c:727:         if ((proc->readAhead & READAHEAD_PRESSED_EARLY) || hitHappened)
	ands	r1, r2	@ _38, _32
@ C_Code.c:726:         int hitHappened = proc->EkrEfxIsUnitHittedNowFrames != 0xFF; // after the hit we only draw this on a fail
	subs	r3, r3, #255	@ tmp194,
@ C_Code.c:727:         if ((proc->readAhead & READAHEAD_PRESSED_EARLY) || hitHappened)
	orrs	r3, r1	@ _39, _38
@ C_Code.c:727:         if ((proc->readAhead & READAHEAD_PRESSED_EARLY) || hitHappened)
	beq	.LCB1442	@
	b	.L246	@long jump	@
.LCB1442:
@ C_Code.c:731:         else if (proc->frame && ChangePaletteWhenButtonIsPressed)
	adds	r3, r3, #76	@ tmp205,
@ C_Code.c:731:         else if (proc->frame && ChangePaletteWhenButtonIsPressed)
	ldrh	r3, [r5, r3]	@ tmp206,
	cmp	r3, #0	@ tmp206,
	beq	.L232		@,
@ C_Code.c:731:         else if (proc->frame && ChangePaletteWhenButtonIsPressed)
	ldr	r3, .L297+16	@ tmp207,
	ldr	r3, [r3]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
	cmp	r3, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L232		@,
@ C_Code.c:733:             pal = gPal_TimedHitsSuccess;
	ldr	r0, .L297+20	@ pal,
	b	.L231		@
.L230:
@ C_Code.c:742:     else if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldr	r3, .L297+16	@ tmp218,
@ C_Code.c:742:     else if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldr	r3, [r3]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
	cmp	r3, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L235		@,
@ C_Code.c:742:     else if (ChangePaletteWhenButtonIsPressed && proc->frame)
	movs	r3, #76	@ tmp222,
@ C_Code.c:742:     else if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldrh	r3, [r5, r3]	@ tmp223,
	cmp	r3, #0	@ tmp223,
	beq	.LCB1463	@
	b	.L289	@long jump	@
.LCB1463:
.L235:
@ C_Code.c:747:     int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); // OAM2_CHR(0);
	lsls	r3, r6, #28	@ tmp221, palID,
	lsrs	r3, r3, #16	@ prephitmp_22, tmp221,
	str	r3, [sp, #12]	@ prephitmp_22, %sfp
.L233:
@ C_Code.c:748:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2);
	mov	r2, r9	@ y, y
	movs	r3, #255	@ tmp224,
	ldr	r5, .L297+24	@ tmp293,
	ands	r3, r2	@ tmp224, y
	movs	r2, r3	@ _50, tmp224
	movs	r3, r5	@ tmp226, tmp293
	ldr	r0, [sp, #12]	@ prephitmp_22, %sfp
	lsls	r1, r7, #23	@ tmp228, x,
	ldr	r6, .L297+28	@ tmp294,
	str	r0, [sp]	@ prephitmp_22,
	adds	r3, r3, #40	@ tmp226,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _49, tmp228,
	mov	r8, r2	@ _50, _50
	bl	.L299		@
@ C_Code.c:749:     x += 32;
	movs	r1, r7	@ x_51, x
@ C_Code.c:750:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2);
	movs	r3, r5	@ tmp231, tmp293
	ldr	r0, [sp, #12]	@ prephitmp_22, %sfp
@ C_Code.c:749:     x += 32;
	adds	r1, r1, #32	@ x_51,
@ C_Code.c:750:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2);
	lsls	r1, r1, #23	@ tmp234, x_51,
	mov	r2, r8	@, _50
	str	r0, [sp]	@ prephitmp_22,
	adds	r3, r3, #48	@ tmp231,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _52, tmp234,
	bl	.L299		@
@ C_Code.c:748:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2);
	mov	r10, r6	@ tmp294, tmp294
@ C_Code.c:751:     y += 16;
	mov	r6, r9	@ y, y
	movs	r3, r5	@ ivtmp.223, tmp293
	movs	r0, r5	@ _30, tmp293
	adds	r6, r6, #16	@ y,
	mov	r8, r6	@ y, y
@ C_Code.c:463:     int c = 0;
	movs	r2, #0	@ c,
	adds	r3, r3, #32	@ ivtmp.223,
	adds	r0, r0, #38	@ _30,
.L237:
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ldrb	r1, [r3]	@ _47, MEM[(unsigned char *)_58]
@ C_Code.c:466:         if (keys & RomKeysList[i])
	ands	r1, r4	@ _48, keys
@ C_Code.c:468:             c++;
	subs	r6, r1, #1	@ tmp297, _48
	sbcs	r1, r1, r6	@ tmp296, _48, tmp297
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	adds	r3, r3, #1	@ ivtmp.223,
@ C_Code.c:468:             c++;
	adds	r2, r2, r1	@ c, c, tmp296
@ C_Code.c:464:     for (int i = 0; i < 6; ++i)
	cmp	r3, r0	@ ivtmp.223, _30
	bne	.L237		@,
@ C_Code.c:755:     if (count == 1)
	cmp	r2, #1	@ c,
	beq	.L290		@,
@ C_Code.c:759:     if (count == 2)
	cmp	r2, #2	@ c,
	beq	.L240		@,
@ C_Code.c:752:     x -= 36;
	subs	r6, r7, #4	@ x, x,
.L239:
@ C_Code.c:768:     if (keys & A_BUTTON)
	lsls	r3, r4, #31	@ tmp310, keys,
	bmi	.L291		@,
.L241:
@ C_Code.c:773:     if (keys & B_BUTTON)
	lsls	r3, r4, #30	@ tmp311, keys,
	bmi	.L292		@,
.L242:
@ C_Code.c:778:     if (keys & DPAD_LEFT)
	lsls	r3, r4, #26	@ tmp312, keys,
	bmi	.L293		@,
.L243:
@ C_Code.c:783:     if (keys & DPAD_RIGHT)
	lsls	r3, r4, #27	@ tmp313, keys,
	bmi	.L294		@,
.L244:
@ C_Code.c:788:     if (keys & DPAD_UP)
	lsls	r3, r4, #25	@ tmp314, keys,
	bmi	.L295		@,
.L245:
@ C_Code.c:793:     if (keys & DPAD_DOWN)
	lsls	r4, r4, #24	@ tmp315, keys,
	bpl	.L227		@,
@ C_Code.c:795:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp288,
	movs	r3, r5	@ tmp293, tmp293
	ldr	r0, [sp, #12]	@ prephitmp_22, %sfp
	ands	r2, r1	@ _93, y
	lsls	r1, r6, #23	@ tmp291, x,
	str	r0, [sp]	@ prephitmp_22,
	adds	r3, r3, #96	@ tmp293,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _92, tmp291,
	bl	.L300		@
	b	.L227		@
.L232:
@ C_Code.c:735:         else if (proc->readAhead & READAHEAD_WINDOW_OPEN)
	lsls	r2, r2, #30	@ tmp309, _32,
	bpl	.L296		@,
@ C_Code.c:737:             pal = gPal_TimedHitsWindow;
	ldr	r0, .L297+32	@ pal,
	b	.L231		@
.L290:
@ C_Code.c:757:         x += 16;
	movs	r6, r7	@ x, x
	adds	r6, r6, #12	@ x,
@ C_Code.c:768:     if (keys & A_BUTTON)
	lsls	r3, r4, #31	@ tmp310, keys,
	bpl	.L241		@,
.L291:
@ C_Code.c:770:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp243,
	movs	r3, r5	@ tmp242, tmp293
	ldr	r0, [sp, #12]	@ prephitmp_22, %sfp
	ands	r2, r1	@ _68, y
	lsls	r1, r6, #23	@ tmp246, x,
	str	r0, [sp]	@ prephitmp_22,
	adds	r3, r3, #56	@ tmp242,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _67, tmp246,
	bl	.L300		@
@ C_Code.c:771:         x += 18;
	adds	r6, r6, #18	@ x,
@ C_Code.c:773:     if (keys & B_BUTTON)
	lsls	r3, r4, #30	@ tmp311, keys,
	bpl	.L242		@,
.L292:
@ C_Code.c:775:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp252,
	movs	r3, r5	@ tmp251, tmp293
	ldr	r0, [sp, #12]	@ prephitmp_22, %sfp
	ands	r2, r1	@ _73, y
	lsls	r1, r6, #23	@ tmp255, x,
	str	r0, [sp]	@ prephitmp_22,
	adds	r3, r3, #64	@ tmp251,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _72, tmp255,
	bl	.L300		@
@ C_Code.c:776:         x += 18;
	adds	r6, r6, #18	@ x,
@ C_Code.c:778:     if (keys & DPAD_LEFT)
	lsls	r3, r4, #26	@ tmp312, keys,
	bpl	.L243		@,
.L293:
@ C_Code.c:780:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp261,
	movs	r3, r5	@ tmp260, tmp293
	ldr	r0, [sp, #12]	@ prephitmp_22, %sfp
	ands	r2, r1	@ _78, y
	lsls	r1, r6, #23	@ tmp264, x,
	str	r0, [sp]	@ prephitmp_22,
	adds	r3, r3, #72	@ tmp260,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _77, tmp264,
	bl	.L300		@
@ C_Code.c:781:         x += 18;
	adds	r6, r6, #18	@ x,
@ C_Code.c:783:     if (keys & DPAD_RIGHT)
	lsls	r3, r4, #27	@ tmp313, keys,
	bpl	.L244		@,
.L294:
@ C_Code.c:785:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp270,
	movs	r3, r5	@ tmp269, tmp293
	ldr	r0, [sp, #12]	@ prephitmp_22, %sfp
	ands	r2, r1	@ _83, y
	lsls	r1, r6, #23	@ tmp273, x,
	str	r0, [sp]	@ prephitmp_22,
	adds	r3, r3, #80	@ tmp269,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _82, tmp273,
	bl	.L300		@
@ C_Code.c:786:         x += 18;
	adds	r6, r6, #18	@ x,
@ C_Code.c:788:     if (keys & DPAD_UP)
	lsls	r3, r4, #25	@ tmp314, keys,
	bpl	.L245		@,
.L295:
@ C_Code.c:790:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp279,
	movs	r3, r5	@ tmp278, tmp293
	ldr	r0, [sp, #12]	@ prephitmp_22, %sfp
	ands	r2, r1	@ _88, y
	lsls	r1, r6, #23	@ tmp282, x,
	str	r0, [sp]	@ prephitmp_22,
	adds	r3, r3, #88	@ tmp278,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _87, tmp282,
	bl	.L300		@
@ C_Code.c:791:         x += 18;
	adds	r6, r6, #18	@ x,
	b	.L245		@
.L246:
@ C_Code.c:729:             pal = gPal_TimedHitsFail;
	ldr	r0, .L297+36	@ pal,
.L231:
@ C_Code.c:739:         ApplyPalette(pal, 0x10 + PROMPT_PALETTE);
	movs	r1, #232	@,
	ldr	r3, .L297+40	@ tmp217,
	movs	r2, #32	@,
	lsls	r1, r1, #2	@,,
	bl	.L10		@
	movs	r3, #208	@ prephitmp_22,
	lsls	r3, r3, #8	@ prephitmp_22, prephitmp_22,
	str	r3, [sp, #12]	@ prephitmp_22, %sfp
	b	.L233		@
.L240:
@ C_Code.c:761:         x += 8;
	adds	r6, r7, #4	@ x, x,
	b	.L239		@
.L289:
@ C_Code.c:742:     else if (ChangePaletteWhenButtonIsPressed && proc->frame)
	movs	r3, #224	@ prephitmp_22,
	lsls	r3, r3, #8	@ prephitmp_22, prephitmp_22,
	str	r3, [sp, #12]	@ prephitmp_22, %sfp
	b	.L233		@
.L296:
@ C_Code.c:725:         const u16 * pal = gPal_TimedHitsDefault;
	ldr	r0, .L297+44	@ pal,
	b	.L231		@
.L298:
	.align	2
.L297:
	.word	DisplayPress
	.word	gPlaySt
	.word	AlwaysWork
	.word	LenienceFrames
	.word	ChangePaletteWhenButtonIsPressed
	.word	gPal_TimedHitsSuccess
	.word	.LANCHOR0
	.word	PutSprite
	.word	gPal_TimedHitsWindow
	.word	gPal_TimedHitsFail
	.word	CopyToPaletteBuffer
	.word	gPal_TimedHitsDefault
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
@ C_Code.c:941:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r1, #11	@ _29,
	movs	r3, #192	@ tmp112,
	ldrsb	r1, [r0, r1]	@ _29,* _29
	ands	r3, r1	@ _30, _29
@ C_Code.c:918:     if (success)
	cmp	r2, #0	@ success,
	beq	.L302		@,
@ C_Code.c:920:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _30,
	beq	.L313		@,
@ C_Code.c:931:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L314	@ tmp116,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam.34_16, TimedHitsDifficultyRam
@ C_Code.c:931:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.34_16, *TimedHitsDifficultyRam.34_16
@ C_Code.c:931:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r2, r3, #26	@ tmp145, *TimedHitsDifficultyRam.34_16,
	bmi	.L306		@,
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r2, .L314+4	@ tmp126,
	ldr	r2, [r2]	@ DifficultyThreshold.36_21, DifficultyThreshold
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r3, r3, #27	@ tmp131, *TimedHitsDifficultyRam.34_16,
	lsrs	r3, r3, #27	@ _20, tmp131,
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r3, r2	@ _20, DifficultyThreshold.36_21
	bge	.L307		@,
@ C_Code.c:934:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r3, .L314+8	@ tmp134,
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r2, r3	@ DifficultyThreshold.36_21, NumberOfRandomButtons
	bgt	.L306		@,
.L307:
@ C_Code.c:936:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r2, .L314+12	@ tmp136,
	ldr	r3, .L314+16	@ tmp137,
	ldr	r0, [r2]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r3, [r3]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r0, r0, r3	@ <retval>, BonusDamagePercent, DifficultyBonusPercent
	b	.L301		@
.L302:
@ C_Code.c:941:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _30,
	beq	.L308		@,
@ C_Code.c:945:     return FailedHitDamagePercent;
	ldr	r3, .L314+20	@ tmp141,
	ldr	r0, [r3]	@ <retval>,
.L301:
@ C_Code.c:946: }
	@ sp needed	@
	bx	lr
.L313:
@ C_Code.c:922:             if (BlockingEnabled)
	ldr	r3, .L314+24	@ tmp113,
@ C_Code.c:922:             if (BlockingEnabled)
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L308		@,
@ C_Code.c:924:                 return ReducedDamagePercent;
	ldr	r3, .L314+28	@ tmp115,
	ldr	r0, [r3]	@ <retval>,
	b	.L301		@
.L308:
@ C_Code.c:928:                 return 100;
	movs	r0, #100	@ <retval>,
	b	.L301		@
.L306:
@ C_Code.c:939:         return BonusDamagePercent;
	ldr	r3, .L314+12	@ tmp140,
	ldr	r0, [r3]	@ <retval>,
	b	.L301		@
.L315:
	.align	2
.L314:
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
@ C_Code.c:941:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r1, #11	@ _11,
	movs	r3, #192	@ tmp112,
	ldrsb	r1, [r0, r1]	@ _11,* _11
	ands	r3, r1	@ _5, _11
@ C_Code.c:918:     if (success)
	cmp	r2, #0	@ success,
	beq	.L317		@,
@ C_Code.c:920:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _5,
	beq	.L328		@,
@ C_Code.c:931:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L329	@ tmp116,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam.34_17, TimedHitsDifficultyRam
@ C_Code.c:931:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.34_17, *TimedHitsDifficultyRam.34_17
@ C_Code.c:931:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r2, r3, #26	@ tmp145, *TimedHitsDifficultyRam.34_17,
	bmi	.L321		@,
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r2, .L329+4	@ tmp126,
	ldr	r2, [r2]	@ DifficultyThreshold.36_22, DifficultyThreshold
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r3, r3, #27	@ tmp131, *TimedHitsDifficultyRam.34_17,
	lsrs	r3, r3, #27	@ _21, tmp131,
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r3, r2	@ _21, DifficultyThreshold.36_22
	bge	.L322		@,
@ C_Code.c:934:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r3, .L329+8	@ tmp134,
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r2, r3	@ DifficultyThreshold.36_22, NumberOfRandomButtons
	bgt	.L321		@,
.L322:
@ C_Code.c:936:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r2, .L329+12	@ tmp136,
	ldr	r3, .L329+16	@ tmp137,
	ldr	r0, [r2]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r3, [r3]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r0, r0, r3	@ <retval>, BonusDamagePercent, DifficultyBonusPercent
	b	.L316		@
.L317:
@ C_Code.c:941:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _5,
	beq	.L323		@,
@ C_Code.c:945:     return FailedHitDamagePercent;
	ldr	r3, .L329+20	@ tmp141,
	ldr	r0, [r3]	@ <retval>,
.L316:
@ C_Code.c:951: }
	@ sp needed	@
	bx	lr
.L328:
@ C_Code.c:922:             if (BlockingEnabled)
	ldr	r3, .L329+24	@ tmp113,
@ C_Code.c:922:             if (BlockingEnabled)
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L323		@,
@ C_Code.c:924:                 return ReducedDamagePercent;
	ldr	r3, .L329+28	@ tmp115,
	ldr	r0, [r3]	@ <retval>,
	b	.L316		@
.L323:
@ C_Code.c:928:                 return 100;
	movs	r0, #100	@ <retval>,
	b	.L316		@
.L321:
@ C_Code.c:939:         return BonusDamagePercent;
	ldr	r3, .L329+12	@ tmp140,
	ldr	r0, [r3]	@ <retval>,
	b	.L316		@
.L330:
	.align	2
.L329:
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
@ C_Code.c:966:     for (int i = id; i < 22; i += 2)
	cmp	r0, #21	@ id,
	bgt	.L331		@,
	ldr	r3, .L339	@ tmp108,
	lsls	r2, r0, #1	@ _13, id,
@ C_Code.c:969:         if (hp == 0xffff)
	ldr	r5, .L339+4	@ tmp109,
	adds	r2, r2, r3	@ ivtmp.238, _13, tmp108
	b	.L337		@
.L333:
@ C_Code.c:985:         else if (hp >= difference)
	cmp	r3, r1	@ _1, difference
	blt	.L336		@,
@ C_Code.c:987:             gEfxHpLut[i] -= difference;
	subs	r4, r3, r1	@ _4, _1, difference
.L335:
@ C_Code.c:966:     for (int i = id; i < 22; i += 2)
	adds	r0, r0, #2	@ id,
@ C_Code.c:982:                 gEfxHpLut[i] = 0;
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:966:     for (int i = id; i < 22; i += 2)
	adds	r2, r2, #4	@ ivtmp.238,
	cmp	r0, #21	@ id,
	bgt	.L331		@,
.L337:
@ C_Code.c:968:         hp = gEfxHpLut[i];
	ldrh	r3, [r2]	@ _1, MEM[(short unsigned int *)_18]
@ C_Code.c:969:         if (hp == 0xffff)
	cmp	r3, r5	@ _1, tmp109
	beq	.L331		@,
@ C_Code.c:973:         if (difference < 0)
	cmp	r1, #0	@ difference,
	bge	.L333		@,
@ C_Code.c:975:             hp += difference;
	adds	r3, r3, r1	@ hp, _1, difference
@ C_Code.c:978:                 gEfxHpLut[i] = hp;
	subs	r4, r3, #0	@ _4, hp,
@ C_Code.c:976:             if (hp > 0)
	bgt	.L335		@,
.L336:
@ C_Code.c:964: {
	movs	r4, #0	@ _4,
@ C_Code.c:966:     for (int i = id; i < 22; i += 2)
	adds	r0, r0, #2	@ id,
@ C_Code.c:982:                 gEfxHpLut[i] = 0;
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:966:     for (int i = id; i < 22; i += 2)
	adds	r2, r2, #4	@ ivtmp.238,
	cmp	r0, #21	@ id,
	ble	.L337		@,
.L331:
@ C_Code.c:994: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L340:
	.align	2
.L339:
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
@ C_Code.c:999: {
	mov	ip, r2	@ some_bunit, some_bunit
	movs	r6, r1	@ HpProc, HpProc
@ C_Code.c:1004:     if (newHp > 127)
	cmp	r3, #127	@ newHp,
	ble	.L342		@,
	movs	r3, #127	@ _12,
.L343:
@ C_Code.c:1008:     int hp = gEkrGaugeHp[side];
	ldr	r1, [sp, #16]	@ tmp146, side
	ldr	r2, .L351	@ tmp114,
	lsls	r1, r1, #1	@ tmp115, tmp146,
	ldrsh	r2, [r1, r2]	@ _1, gEkrGaugeHp
@ C_Code.c:1009:     some_bunit->unit.curHP = newHp;
	mov	r1, ip	@ some_bunit, some_bunit
	strb	r3, [r1, #19]	@ _12, some_bunit_21(D)->unit.curHP
@ C_Code.c:1010:     if (hp == newHp)
	cmp	r3, r2	@ _12, _1
	beq	.L341		@,
@ C_Code.c:1017:         diff = 0 - newDamage;
	ldr	r1, [sp, #20]	@ tmp149, newDamage
	rsbs	r1, r1, #0	@ diff, tmp149
	mov	ip, r1	@ diff, diff
@ C_Code.c:1015:     if (newDamage)
	ldr	r1, [sp, #20]	@ tmp150, newDamage
	cmp	r1, #0	@ tmp150,
	beq	.L348		@,
@ C_Code.c:1020:     if (proc->side == side)
	movs	r1, #74	@ tmp117,
@ C_Code.c:1020:     if (proc->side == side)
	ldr	r4, [sp, #16]	@ tmp152, side
@ C_Code.c:1020:     if (proc->side == side)
	ldrb	r1, [r0, r1]	@ _4,
@ C_Code.c:1020:     if (proc->side == side)
	cmp	r1, r4	@ _4, tmp152
	beq	.L349		@,
.L341:
@ C_Code.c:1039: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L342:
@ C_Code.c:1000:     if (newHp < 0)
	mvns	r2, r3	@ tmp134, newHp
	asrs	r2, r2, #31	@ tmp133, tmp134,
	ands	r3, r2	@ _12, tmp133
	b	.L343		@
.L348:
@ C_Code.c:1014:     int diff = newHp - hp;
	subs	r1, r3, r2	@ diff, _12, _1
	mov	ip, r1	@ diff, diff
@ C_Code.c:1020:     if (proc->side == side)
	movs	r1, #74	@ tmp117,
@ C_Code.c:1020:     if (proc->side == side)
	ldr	r4, [sp, #16]	@ tmp152, side
@ C_Code.c:1020:     if (proc->side == side)
	ldrb	r1, [r0, r1]	@ _4,
@ C_Code.c:1020:     if (proc->side == side)
	cmp	r1, r4	@ _4, tmp152
	bne	.L341		@,
.L349:
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	ldr	r1, [r0, #56]	@ pretmp_40, proc_26(D)->currentRound
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	mov	r0, ip	@ diff, diff
@ C_Code.c:1022:         HpProc->cur = hp;
	strh	r2, [r6, #46]	@ _1, HpProc_27(D)->cur
@ C_Code.c:1023:         if (UsingSkillSys)
	ldr	r2, .L351+4	@ tmp120,
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	asrs	r5, r0, #31	@ tmp142, diff,
@ C_Code.c:1023:         if (UsingSkillSys)
	ldr	r2, [r2]	@ UsingSkillSys.41_5, UsingSkillSys
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	adds	r0, r0, r5	@ _41, diff, tmp142
	eors	r0, r5	@ _41, tmp142
@ C_Code.c:1023:         if (UsingSkillSys)
	cmp	r2, #0	@ UsingSkillSys.41_5,
	beq	.L350		@,
	movs	r5, #80	@ tmp161,
	strh	r3, [r6, r5]	@ _12, HpProc_27(D)->post
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	strb	r0, [r1, #3]	@ _41, pretmp_40->hpChange
@ C_Code.c:1034:         if (UsingSkillSys == 2)
	cmp	r2, #2	@ UsingSkillSys.41_5,
	bne	.L341		@,
@ C_Code.c:1036:             proc->currentRound->overDmg = diff;
	mov	r3, ip	@ diff, diff
	strh	r3, [r1, #6]	@ diff, pretmp_40->overDmg
	b	.L341		@
.L350:
@ C_Code.c:1029:             HpProc->postHpAtkrSS = newHp >> 16;
	movs	r5, #82	@ tmp123,
	strh	r2, [r6, r5]	@ UsingSkillSys.41_5, HpProc_27(D)->postHpAtkrSS
	adds	r2, r2, #80	@ tmp126,
	strh	r3, [r6, r2]	@ _12, HpProc_27(D)->post
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	strb	r0, [r1, #3]	@ _41, pretmp_40->hpChange
	b	.L341		@
.L352:
	.align	2
.L351:
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
	mov	r6, r8	@,
	mov	r7, r9	@,
	mov	lr, r10	@,
	push	{r6, r7, lr}	@
@ C_Code.c:1046: {
	movs	r6, r1	@ HpProc, HpProc
@ C_Code.c:1047:     int side = proc->side;
	movs	r1, #74	@ tmp172,
@ C_Code.c:1046: {
	mov	r8, r2	@ active_bunit, active_bunit
	ldr	r2, [sp, #36]	@ hp, hp
	movs	r4, r0	@ proc, proc
@ C_Code.c:1047:     int side = proc->side;
	ldrb	r7, [r0, r1]	@ _1,
@ C_Code.c:1049:     if (hp < 0)
	cmp	r2, #0	@ hp,
	bge	.L354		@,
@ C_Code.c:1051:         hp = gEkrGaugeHp[side];
	ldr	r2, .L397	@ tmp173,
	lsls	r1, r7, #1	@ tmp174, _1,
@ C_Code.c:1051:         hp = gEkrGaugeHp[side];
	ldrsh	r2, [r1, r2]	@ hp, gEkrGaugeHp
.L354:
@ C_Code.c:1053:     if (hp <= 0)
	cmp	r2, #0	@ hp,
	ble	.L392		@,
@ C_Code.c:1117:         HpProc->death = false;
	movs	r3, #41	@ tmp261,
	movs	r2, #0	@ tmp262,
	strb	r2, [r6, r3]	@ tmp262, HpProc_50(D)->death
.L366:
@ C_Code.c:1123:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	movs	r0, #11	@ _23,
@ C_Code.c:1123:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	ldr	r5, .L397+4	@ tmp264,
@ C_Code.c:1123:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	ldr	r4, .L397+8	@ tmp294,
	ldrsb	r0, [r5, r0]	@ _23,* _23
	bl	.L134		@
@ C_Code.c:1124:     if (UNIT_IS_VALID(unit))
	cmp	r0, #0	@ unit,
	beq	.L368		@,
@ C_Code.c:1124:     if (UNIT_IS_VALID(unit))
	ldr	r3, [r0]	@ unit_77->pCharacterData, unit_77->pCharacterData
	cmp	r3, #0	@ unit_77->pCharacterData,
	beq	.L368		@,
@ C_Code.c:1126:         gBattleActor.unit.exp = unit->exp;
	ldrb	r3, [r0, #9]	@ _25,
@ C_Code.c:1126:         gBattleActor.unit.exp = unit->exp;
	strb	r3, [r5, #9]	@ _25, gBattleActor.unit.exp
@ C_Code.c:1127:         gBattleActor.unit.level = unit->level;
	movs	r3, #8	@ _26,
	ldrsb	r3, [r0, r3]	@ _26,* _26
@ C_Code.c:1127:         gBattleActor.unit.level = unit->level;
	strb	r3, [r5, #8]	@ _26, gBattleActor.unit.level
.L368:
@ C_Code.c:1130:     unit = GetUnit(gBattleTarget.unit.index);
	movs	r0, #11	@ _28,
@ C_Code.c:1130:     unit = GetUnit(gBattleTarget.unit.index);
	ldr	r5, .L397+12	@ tmp272,
@ C_Code.c:1130:     unit = GetUnit(gBattleTarget.unit.index);
	ldrsb	r0, [r5, r0]	@ _28,* _28
	bl	.L134		@
@ C_Code.c:1131:     if (UNIT_IS_VALID(unit))
	cmp	r0, #0	@ unit,
	beq	.L369		@,
@ C_Code.c:1131:     if (UNIT_IS_VALID(unit))
	ldr	r3, [r0]	@ unit_81->pCharacterData, unit_81->pCharacterData
	cmp	r3, #0	@ unit_81->pCharacterData,
	beq	.L369		@,
@ C_Code.c:1133:         gBattleTarget.unit.exp = unit->exp;
	ldrb	r3, [r0, #9]	@ _30,
@ C_Code.c:1133:         gBattleTarget.unit.exp = unit->exp;
	strb	r3, [r5, #9]	@ _30, gBattleTarget.unit.exp
@ C_Code.c:1134:         gBattleTarget.unit.level = unit->level;
	movs	r3, #8	@ _31,
	ldrsb	r3, [r0, r3]	@ _31,* _31
@ C_Code.c:1134:         gBattleTarget.unit.level = unit->level;
	strb	r3, [r5, #8]	@ _31, gBattleTarget.unit.level
.L369:
@ C_Code.c:1141: }
	@ sp needed	@
@ C_Code.c:1138:     BattleApplyExpGains(); // update exp
	ldr	r3, .L397+16	@ tmp280,
	bl	.L10		@
@ C_Code.c:1139:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldr	r2, .L397+20	@ tmp283,
	ldr	r1, [r2]	@ gpEkrBattleUnitLeft, gpEkrBattleUnitLeft
	movs	r2, #110	@ tmp284,
@ C_Code.c:1139:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldr	r3, .L397+24	@ tmp281,
@ C_Code.c:1139:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldrsb	r1, [r1, r2]	@ tmp286,
@ C_Code.c:1139:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	strh	r1, [r3]	@ tmp286, gBanimExpGain[0]
@ C_Code.c:1140:     gBanimExpGain[1] = gpEkrBattleUnitRight->expGain;
	ldr	r1, .L397+28	@ tmp289,
	ldr	r1, [r1]	@ gpEkrBattleUnitRight, gpEkrBattleUnitRight
	ldrsb	r2, [r1, r2]	@ tmp292,
@ C_Code.c:1140:     gBanimExpGain[1] = gpEkrBattleUnitRight->expGain;
	strh	r2, [r3, #2]	@ tmp292, gBanimExpGain[1]
@ C_Code.c:1141: }
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L392:
@ C_Code.c:1009:     some_bunit->unit.curHP = newHp;
	movs	r0, #0	@ tmp177,
@ C_Code.c:1008:     int hp = gEkrGaugeHp[side];
	ldr	r1, .L397	@ tmp293,
	lsls	r2, r7, #1	@ tmp176, _1,
	mov	r9, r1	@ tmp293, tmp293
	ldrsh	r1, [r1, r2]	@ _89, gEkrGaugeHp
@ C_Code.c:1009:     some_bunit->unit.curHP = newHp;
	strb	r0, [r3, #19]	@ tmp177, opp_bunit_52(D)->unit.curHP
@ C_Code.c:1008:     int hp = gEkrGaugeHp[side];
	subs	r2, r1, #0	@ hp, _89,
@ C_Code.c:1010:     if (hp == newHp)
	beq	.L356		@,
@ C_Code.c:1015:     if (newDamage)
	ldr	r3, [sp, #40]	@ tmp325, newDamage
	cmp	r3, #0	@ tmp325,
	beq	.L357		@,
@ C_Code.c:1017:         diff = 0 - newDamage;
	movs	r2, r3	@ hp, tmp325
.L357:
	rsbs	r3, r2, #0	@ diff, hp
	mov	r10, r3	@ diff, diff
@ C_Code.c:1023:         if (UsingSkillSys)
	ldr	r3, .L397+32	@ tmp180,
@ C_Code.c:1022:         HpProc->cur = hp;
	strh	r1, [r6, #46]	@ _89, HpProc_50(D)->cur
@ C_Code.c:1023:         if (UsingSkillSys)
	ldr	r3, [r3]	@ UsingSkillSys.41_96, UsingSkillSys
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	asrs	r1, r2, #31	@ tmp313, hp,
	adds	r2, r2, r1	@ _165, hp, tmp313
	eors	r2, r1	@ _165, tmp313
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	ldr	r1, [r4, #56]	@ pretmp_166, proc_46(D)->currentRound
@ C_Code.c:1023:         if (UsingSkillSys)
	cmp	r3, #0	@ UsingSkillSys.41_96,
	beq	.L393		@,
	movs	r0, #0	@ tmp186,
	movs	r5, #80	@ tmp342,
	strh	r0, [r6, r5]	@ tmp186, HpProc_50(D)->post
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r1, #3]	@ _165, pretmp_166->hpChange
@ C_Code.c:1034:         if (UsingSkillSys == 2)
	cmp	r3, #2	@ UsingSkillSys.41_96,
	bne	.L356		@,
@ C_Code.c:1036:             proc->currentRound->overDmg = diff;
	mov	r3, r10	@ diff, diff
	strh	r3, [r1, #6]	@ diff, pretmp_166->overDmg
.L356:
@ C_Code.c:1058:         proc->code4frame = NO_FRAME;
	movs	r5, #1	@ tmp191,
	movs	r3, #78	@ tmp190,
@ C_Code.c:1063:         HpProc->death = true;
	movs	r2, #1	@ tmp194,
@ C_Code.c:1058:         proc->code4frame = NO_FRAME;
	rsbs	r5, r5, #0	@ tmp191, tmp191
	strh	r5, [r4, r3]	@ tmp191, proc_46(D)->code4frame
@ C_Code.c:1063:         HpProc->death = true;
	subs	r3, r3, #37	@ tmp193,
	strb	r2, [r6, r3]	@ tmp194, HpProc_50(D)->death
@ C_Code.c:1074:         round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END;
	ldr	r3, [sp, #32]	@ tmp328, round
	ldrb	r3, [r3, #2]	@ tmp199,
	adds	r2, r2, #175	@ tmp196,
	orrs	r3, r2	@ tmp201, tmp196
	ldr	r2, [sp, #32]	@ tmp329, round
	strb	r3, [r2, #2]	@ tmp201,
@ C_Code.c:1076:         struct SkillSysBattleHit * nextRound = GetCurrentRound(proc->roundId + 1);
	movs	r3, #70	@ tmp330,
	ldrb	r0, [r4, r3]	@ _6,
@ C_Code.c:1076:         struct SkillSysBattleHit * nextRound = GetCurrentRound(proc->roundId + 1);
	ldr	r3, .L397+36	@ tmp206,
	adds	r0, r0, #1	@ _7,
	bl	.L10		@
@ C_Code.c:1077:         nextRound->info = BATTLE_HIT_INFO_END;
	movs	r3, #7	@ tmp212,
	ldrh	r2, [r0, #2]	@ MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_60 + 2B], MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_60 + 2B]
	ands	r3, r2	@ tmp211, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_60 + 2B]
	movs	r2, #128	@ tmp213,
	orrs	r3, r2	@ tmp216, tmp213
	strh	r3, [r0, #2]	@ tmp216, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_60 + 2B]
@ C_Code.c:1081:         u16 * animRound = &GetAnimRoundData()[0];
	ldr	r3, .L397+40	@ tmp218,
	bl	.L10		@
@ C_Code.c:1082:         for (int i = proc->roundId; i < 32; ++i)
	movs	r3, #70	@ tmp331,
	ldrb	r3, [r4, r3]	@ i,
@ C_Code.c:1082:         for (int i = proc->roundId; i < 32; ++i)
	cmp	r3, #31	@ i,
	bgt	.L359		@,
@ C_Code.c:1084:             if (animRound[i] == 0xFFFF)
	ldr	r2, .L397+44	@ tmp221,
	mov	ip, r2	@ tmp221, tmp221
	b	.L360		@
.L394:
@ C_Code.c:1082:         for (int i = proc->roundId; i < 32; ++i)
	adds	r3, r3, #1	@ i,
@ C_Code.c:1088:             animRound[i] = 0xFFFF;
	strh	r5, [r0, r2]	@ tmp191, MEM[(u16 *)animRound_64 + _157 * 1]
@ C_Code.c:1082:         for (int i = proc->roundId; i < 32; ++i)
	cmp	r3, #32	@ i,
	beq	.L359		@,
.L360:
	lsls	r2, r3, #1	@ _157, i,
@ C_Code.c:1084:             if (animRound[i] == 0xFFFF)
	ldrh	r1, [r0, r2]	@ MEM[(u16 *)animRound_64 + _157 * 1], MEM[(u16 *)animRound_64 + _157 * 1]
	cmp	r1, ip	@ MEM[(u16 *)animRound_64 + _157 * 1], tmp221
	bne	.L394		@,
.L359:
@ C_Code.c:1095:         side = 1 ^ side;
	movs	r2, #1	@ tmp227,
@ C_Code.c:1096:         hp = gEkrGaugeHp[side];
	mov	r5, r9	@ tmp293, tmp293
@ C_Code.c:1095:         side = 1 ^ side;
	eors	r2, r7	@ side, _1
@ C_Code.c:1096:         hp = gEkrGaugeHp[side];
	lsls	r3, r2, #1	@ tmp229, side,
	ldrsh	r1, [r5, r3]	@ _15, gEkrGaugeHp
@ C_Code.c:1097:         if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL)
	ldr	r3, [sp, #32]	@ tmp334, round
	ldr	r0, [r3]	@ *round_57(D), *round_57(D)
@ C_Code.c:1096:         hp = gEkrGaugeHp[side];
	movs	r3, r1	@ _13, _15
@ C_Code.c:1097:         if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL)
	lsls	r0, r0, #23	@ tmp314, *round_57(D),
	bpl	.L361		@,
@ C_Code.c:1101:             int victimHp = gEkrGaugeHp[proc->side];
	movs	r3, #74	@ tmp238,
	ldrb	r3, [r4, r3]	@ _18,
@ C_Code.c:1101:             int victimHp = gEkrGaugeHp[proc->side];
	lsls	r3, r3, #1	@ tmp240, _18,
@ C_Code.c:1102:             if (drained > victimHp)
	ldrsh	r3, [r5, r3]	@ _14, gEkrGaugeHp
	ldr	r0, [sp, #40]	@ tmp336, newDamage
	cmp	r3, r0	@ _14, tmp336
	ble	.L362		@,
	movs	r3, r0	@ _14, tmp336
.L362:
@ C_Code.c:1107:             if (hp > active_bunit->unit.maxHP)
	mov	r0, r8	@ active_bunit, active_bunit
	ldrb	r0, [r0, #18]	@ _21,
@ C_Code.c:1107:             if (hp > active_bunit->unit.maxHP)
	adds	r3, r3, r1	@ _13, _14, _15
@ C_Code.c:1107:             if (hp > active_bunit->unit.maxHP)
	lsls	r0, r0, #24	@ _21, _21,
	asrs	r0, r0, #24	@ _21, _21,
@ C_Code.c:1107:             if (hp > active_bunit->unit.maxHP)
	cmp	r3, r0	@ _13, _21
	ble	.L361		@,
	movs	r3, r0	@ _13, _21
.L361:
@ C_Code.c:1004:     if (newHp > 127)
	cmp	r3, #127	@ _13,
	bgt	.L395		@,
@ C_Code.c:1000:     if (newHp < 0)
	mvns	r0, r3	@ tmp297, _13
	asrs	r0, r0, #31	@ tmp296, tmp297,
	ands	r3, r0	@ _104, tmp296
.L365:
@ C_Code.c:1009:     some_bunit->unit.curHP = newHp;
	mov	r0, r8	@ active_bunit, active_bunit
	strb	r3, [r0, #19]	@ _104, active_bunit_74(D)->unit.curHP
@ C_Code.c:1010:     if (hp == newHp)
	cmp	r1, r3	@ _15, _104
	bne	.LCB2276	@
	b	.L366	@long jump	@
.LCB2276:
@ C_Code.c:1020:     if (proc->side == side)
	movs	r0, #74	@ tmp245,
	ldrb	r0, [r4, r0]	@ _111,
@ C_Code.c:1020:     if (proc->side == side)
	cmp	r2, r0	@ side, _111
	beq	.LCB2280	@
	b	.L366	@long jump	@
.LCB2280:
@ C_Code.c:1023:         if (UsingSkillSys)
	ldr	r2, .L397+32	@ tmp248,
@ C_Code.c:1014:     int diff = newHp - hp;
	subs	r0, r3, r1	@ diff, _104, _15
@ C_Code.c:1022:         HpProc->cur = hp;
	strh	r1, [r6, #46]	@ _15, HpProc_50(D)->cur
@ C_Code.c:1023:         if (UsingSkillSys)
	ldr	r2, [r2]	@ UsingSkillSys.41_112, UsingSkillSys
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	asrs	r1, r0, #31	@ tmp315, diff,
	adds	r5, r0, r1	@ _161, diff, tmp315
	eors	r5, r1	@ _161, tmp315
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	ldr	r1, [r4, #56]	@ pretmp_163, proc_46(D)->currentRound
@ C_Code.c:1023:         if (UsingSkillSys)
	cmp	r2, #0	@ UsingSkillSys.41_112,
	beq	.L396		@,
	movs	r4, #80	@ tmp257,
	strh	r3, [r6, r4]	@ _104, HpProc_50(D)->post
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	strb	r5, [r1, #3]	@ _161, pretmp_163->hpChange
@ C_Code.c:1034:         if (UsingSkillSys == 2)
	cmp	r2, #2	@ UsingSkillSys.41_112,
	beq	.LCB2296	@
	b	.L366	@long jump	@
.LCB2296:
@ C_Code.c:1036:             proc->currentRound->overDmg = diff;
	strh	r0, [r1, #6]	@ diff, pretmp_163->overDmg
	b	.L366		@
.L395:
@ C_Code.c:1004:     if (newHp > 127)
	movs	r3, #127	@ _104,
	b	.L365		@
.L393:
	str	r3, [r6, #80]	@ UsingSkillSys.41_96, MEM <vector(2) short int> [(short int *)HpProc_50(D) + 80B]
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r1, #3]	@ _165, pretmp_166->hpChange
	b	.L356		@
.L396:
@ C_Code.c:1029:             HpProc->postHpAtkrSS = newHp >> 16;
	movs	r0, #82	@ tmp251,
	strh	r2, [r6, r0]	@ UsingSkillSys.41_112, HpProc_50(D)->postHpAtkrSS
	adds	r2, r2, #80	@ tmp254,
	strh	r3, [r6, r2]	@ _104, HpProc_50(D)->post
@ C_Code.c:1033:         proc->currentRound->hpChange = ABS(diff);
	strb	r5, [r1, #3]	@ _161, pretmp_163->hpChange
	b	.L366		@
.L398:
	.align	2
.L397:
	.word	gEkrGaugeHp
	.word	gBattleActor
	.word	GetUnit
	.word	gBattleTarget
	.word	BattleApplyExpGains
	.word	gpEkrBattleUnitLeft
	.word	gBanimExpGain
	.word	gpEkrBattleUnitRight
	.word	UsingSkillSys
	.word	GetCurrentRound
	.word	GetAnimRoundData
	.word	65535
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
@ C_Code.c:1148:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	ldr	r5, [r0, #56]	@ _1, proc_48(D)->currentRound
@ C_Code.c:1146: {
	mov	fp, r3	@ opp_bunit, opp_bunit
@ C_Code.c:1148:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	ldr	r3, [r5]	@ *_1, *_1
	lsls	r3, r3, #13	@ tmp144, *_1,
@ C_Code.c:1146: {
	mov	r9, r2	@ active_bunit, active_bunit
	movs	r4, r0	@ proc, proc
	mov	r10, r1	@ HpProc, HpProc
	sub	sp, sp, #36	@,,
@ C_Code.c:1148:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	lsrs	r2, r3, #13	@ _2, tmp144,
@ C_Code.c:1148:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	lsls	r3, r3, #17	@ tmp215, tmp144,
	bmi	.L399		@,
@ C_Code.c:1148:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	movs	r3, #3	@ tmp147,
	ldrsb	r3, [r5, r3]	@ tmp147,
	cmp	r3, #0	@ tmp147,
	beq	.L399		@,
@ C_Code.c:1152:     if (round->hpChange <= 0)
	ldr	r3, [sp, #72]	@ tmp224, round
	ldrb	r3, [r3, #3]	@ _5,
	lsls	r3, r3, #24	@ _5, _5,
	asrs	r3, r3, #24	@ _5, _5,
	str	r3, [sp, #24]	@ _5, %sfp
@ C_Code.c:1152:     if (round->hpChange <= 0)
	cmp	r3, #0	@ _5,
	ble	.L399		@,
@ C_Code.c:1156:     int side = proc->side;
	movs	r3, #74	@ tmp148,
	ldrb	r3, [r0, r3]	@ side,
@ C_Code.c:1157:     int hp = gEkrGaugeHp[proc->side];
	lsls	r1, r3, #1	@ tmp150, side,
@ C_Code.c:1156:     int side = proc->side;
	str	r3, [sp, #16]	@ side, %sfp
@ C_Code.c:1157:     int hp = gEkrGaugeHp[proc->side];
	ldr	r3, .L436	@ tmp149,
@ C_Code.c:1157:     int hp = gEkrGaugeHp[proc->side];
	ldrsh	r3, [r1, r3]	@ hp, gEkrGaugeHp
	str	r3, [sp, #20]	@ hp, %sfp
@ C_Code.c:1158:     if (!hp)
	cmp	r3, #0	@ hp,
	bne	.LCB2381	@
	b	.L432	@long jump	@
.LCB2381:
@ C_Code.c:1176:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	movs	r3, #1	@ tmp159,
	ldr	r0, [sp, #16]	@ side, %sfp
@ C_Code.c:1176:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	ldr	r1, .L436+4	@ tmp154,
@ C_Code.c:1176:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	eors	r3, r0	@ _82, side
@ C_Code.c:1176:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	lsls	r3, r3, #1	@ tmp160, _82,
	ldrsh	r3, [r3, r1]	@ pretmp_83, gEkrGaugeDmg
@ C_Code.c:1168:     if (proc->currentRound->attributes & BATTLE_HIT_ATTR_CRIT)
	lsls	r2, r2, #31	@ tmp216, _2,
	bmi	.L433		@,
@ C_Code.c:1167:     int oldDamage = round->hpChange;
	ldr	r2, [sp, #24]	@ _5, %sfp
	movs	r7, r2	@ oldDamage, _5
@ C_Code.c:1176:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	cmp	r2, r3	@ _5, pretmp_83
	bge	.L404		@,
@ C_Code.c:1178:         oldDamage = gEkrGaugeDmg[side ^ 1];
	movs	r7, r3	@ oldDamage, pretmp_83
.L404:
@ C_Code.c:1181:     if (UsingSkillSys == 2)
	ldr	r3, .L436+8	@ tmp169,
	ldr	r3, [r3]	@ UsingSkillSys.47_16, UsingSkillSys
	str	r3, [sp, #28]	@ UsingSkillSys.47_16, %sfp
@ C_Code.c:1181:     if (UsingSkillSys == 2)
	cmp	r3, #2	@ UsingSkillSys.47_16,
	bne	.L405		@,
@ C_Code.c:1183:         oldDamage = ABS(round->overDmg);
	ldr	r3, [sp, #72]	@ tmp243, round
	movs	r2, #6	@ tmp223,
	ldrsh	r3, [r3, r2]	@ tmp170, tmp243, tmp223
	asrs	r2, r3, #31	@ tmp217, tmp170,
	adds	r3, r3, r2	@ tmp171, tmp170, tmp217
	eors	r3, r2	@ tmp171, tmp217
@ C_Code.c:1183:         oldDamage = ABS(round->overDmg);
	lsls	r3, r3, #16	@ tmp172, tmp171,
	lsrs	r7, r3, #16	@ oldDamage, tmp172,
.L405:
@ C_Code.c:1187:     int newDamage = ((oldDamage * percent)) / 100;
	ldr	r3, [sp, #76]	@ tmp246, percent
	muls	r3, r7	@ _19, oldDamage
@ C_Code.c:1187:     int newDamage = ((oldDamage * percent)) / 100;
	movs	r1, #100	@,
	movs	r0, r3	@, _19
	ldr	r6, .L436+12	@ tmp176,
@ C_Code.c:1187:     int newDamage = ((oldDamage * percent)) / 100;
	mov	r8, r3	@ _19, _19
@ C_Code.c:1187:     int newDamage = ((oldDamage * percent)) / 100;
	bl	.L299		@
@ C_Code.c:1188:     if (newDamage >= oldDamage)
	cmp	r7, r0	@ oldDamage, newDamage_56
	bgt	.L406		@,
@ C_Code.c:1190:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	ldr	r3, .L436+16	@ tmp178,
	ldr	r0, [r3]	@ BonusDamageRounding, BonusDamageRounding
@ C_Code.c:1190:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	movs	r1, #100	@,
@ C_Code.c:1190:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	add	r0, r0, r8	@ _21, _19
@ C_Code.c:1190:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	bl	.L299		@
.L407:
@ C_Code.c:1196:     if (newDamage <= 0)
	subs	r6, r0, #0	@ _7, newDamage,
	bgt	.L408		@,
	movs	r6, #1	@ _7,
.L408:
@ C_Code.c:1200:     int newHp = hp - newDamage;
	ldr	r3, [sp, #20]	@ hp, %sfp
@ C_Code.c:1201:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r1, #11	@ _27,
@ C_Code.c:1200:     int newHp = hp - newDamage;
	subs	r2, r3, r6	@ newHp, hp, _7
@ C_Code.c:1201:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	mov	r3, r9	@ active_bunit, active_bunit
	ldrsb	r1, [r3, r1]	@ _27,* _27
	movs	r3, #192	@ tmp196,
	ands	r3, r1	@ _28, _27
@ C_Code.c:1201:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _28,
	beq	.L434		@,
.L409:
@ C_Code.c:1220:     if (newHp <= 0)
	mvns	r3, r2	@ tmp207, newHp
	asrs	r3, r3, #31	@ tmp206, tmp207,
	ands	r2, r3	@ newHp, tmp206
@ C_Code.c:1225:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r3, [sp, #28]	@ UsingSkillSys.47_16, %sfp
@ C_Code.c:1220:     if (newHp <= 0)
	movs	r1, r2	@ _3, newHp
@ C_Code.c:1225:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r3, #0	@ UsingSkillSys.47_16,
	beq	.L415		@,
@ C_Code.c:1225:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, .L436+20	@ tmp202,
@ C_Code.c:1225:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, [r2]	@ ProcSkillsStackWithTimedHits, ProcSkillsStackWithTimedHits
@ C_Code.c:1225:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldrb	r3, [r5, #4]	@ pretmp_80,
@ C_Code.c:1225:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r2, #0	@ ProcSkillsStackWithTimedHits,
	beq	.L413		@,
@ C_Code.c:1225:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, .L436+24	@ tmp204,
@ C_Code.c:1225:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldrb	r2, [r2, r3]	@ tmp205, SkillExceptionsTable
	cmp	r2, #0	@ tmp205,
	beq	.L415		@,
.L413:
@ C_Code.c:1225:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r3, #0	@ pretmp_80,
	beq	.L415		@,
@ C_Code.c:1230:         newHp = hp - round->hpChange;
	ldr	r3, [sp, #24]	@ _5, %sfp
@ C_Code.c:1229:         newDamage = round->hpChange; // actual oldDamage without choosing between displayed / round dmg
	movs	r6, r3	@ _7, _5
@ C_Code.c:1230:         newHp = hp - round->hpChange;
	ldr	r2, [sp, #20]	@ hp, %sfp
	subs	r1, r2, r3	@ _3, hp, _5
.L415:
@ C_Code.c:1234:     UpdateHP(proc, HpProc, opp_bunit, newHp, side, newDamage);
	mov	r7, fp	@ opp_bunit, opp_bunit
	mov	r8, r1	@ _3, _3
	ldr	r3, [sp, #16]	@ side, %sfp
	movs	r2, r7	@, opp_bunit
	movs	r0, r4	@, proc
	str	r3, [sp]	@ side,
	str	r6, [sp, #4]	@ _7,
	movs	r3, r1	@, _3
	mov	r1, r10	@, HpProc
	bl	UpdateHP		@
@ C_Code.c:1236:     CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, newHp, newDamage);
	mov	r0, r8	@ _3, _3
	str	r0, [sp, #4]	@ _3,
	ldr	r0, [sp, #72]	@ tmp277, round
	movs	r3, r7	@, opp_bunit
	str	r0, [sp]	@ tmp277,
	mov	r2, r9	@, active_bunit
	mov	r1, r10	@, HpProc
	movs	r0, r4	@, proc
	str	r6, [sp, #8]	@ _7,
	bl	CheckForDeath		@
.L399:
@ C_Code.c:1237: }
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
.L433:
@ C_Code.c:1170:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	lsls	r2, r3, #1	@ tmp164, pretmp_83,
	adds	r3, r2, r3	@ oldDamage, tmp164, pretmp_83
@ C_Code.c:1170:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	ldr	r2, [sp, #24]	@ _5, %sfp
@ C_Code.c:1170:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	movs	r7, r3	@ oldDamage, oldDamage
@ C_Code.c:1170:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	cmp	r3, r2	@ oldDamage, _5
	bge	.L404		@,
	movs	r7, r2	@ oldDamage, _5
	b	.L404		@
.L406:
@ C_Code.c:1194:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	ldr	r3, .L436+28	@ tmp185,
	ldr	r0, [r3]	@ ReducedDamageRounding, ReducedDamageRounding
@ C_Code.c:1194:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	ldr	r3, .L436+32	@ tmp188,
	ldr	r3, [r3]	@ ReducedDamageSubtract, ReducedDamageSubtract
@ C_Code.c:1194:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	add	r0, r0, r8	@ _23, _19
@ C_Code.c:1194:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	movs	r1, #100	@,
@ C_Code.c:1194:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	subs	r0, r0, r3	@ _25, _23, ReducedDamageSubtract
@ C_Code.c:1194:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	bl	.L299		@
	b	.L407		@
.L434:
@ C_Code.c:1205:         if ((hp - oldDamage) <= 0)
	ldr	r3, [sp, #20]	@ hp, %sfp
	subs	r3, r3, r7	@ _29, hp, oldDamage
@ C_Code.c:1205:         if ((hp - oldDamage) <= 0)
	cmp	r3, #0	@ _29,
	ble	.L435		@,
.L410:
@ C_Code.c:1213:         if (!BlockingEnabled)
	ldr	r1, .L436+36	@ tmp200,
@ C_Code.c:1213:         if (!BlockingEnabled)
	ldr	r1, [r1]	@ BlockingEnabled, BlockingEnabled
	cmp	r1, #0	@ BlockingEnabled,
	bne	.L409		@,
@ C_Code.c:1215:             newHp = hp - oldDamage;
	movs	r2, r3	@ newHp, _29
@ C_Code.c:1216:             newDamage = oldDamage;
	movs	r6, r7	@ _7, oldDamage
	b	.L409		@
.L432:
@ C_Code.c:1160:         CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp, 0);
	ldr	r3, [sp, #20]	@ hp, %sfp
	str	r3, [sp, #8]	@ hp,
	str	r3, [sp, #4]	@ hp,
	ldr	r3, [sp, #72]	@ tmp233, round
	mov	r2, r9	@, active_bunit
	str	r3, [sp]	@ tmp233,
	mov	r1, r10	@, HpProc
	mov	r3, fp	@, opp_bunit
	bl	CheckForDeath		@
@ C_Code.c:1161:         return;
	b	.L399		@
.L435:
@ C_Code.c:1207:             if (!BlockingCanPreventLethal)
	ldr	r1, .L436+40	@ tmp198,
@ C_Code.c:1207:             if (!BlockingCanPreventLethal)
	ldr	r1, [r1]	@ BlockingCanPreventLethal, BlockingCanPreventLethal
	cmp	r1, #0	@ BlockingCanPreventLethal,
	bne	.L410		@,
@ C_Code.c:1209:                 newHp = hp - oldDamage;
	movs	r2, r3	@ newHp, _29
@ C_Code.c:1210:                 newDamage = oldDamage;
	movs	r6, r7	@ _7, oldDamage
	b	.L410		@
.L437:
	.align	2
.L436:
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
@ C_Code.c:941:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r4, #11	@ _15,
	movs	r5, #192	@ tmp115,
	ldrsb	r4, [r2, r4]	@ _15,* _15
@ C_Code.c:956: {
	sub	sp, sp, #12	@,,
@ C_Code.c:941:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	ands	r4, r5	@ _5, tmp115
@ C_Code.c:918:     if (success)
	ldr	r5, [sp, #28]	@ tmp155, success
	cmp	r5, #0	@ tmp155,
	beq	.L439		@,
@ C_Code.c:920:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r4, #128	@ _5,
	beq	.L450		@,
@ C_Code.c:931:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r4, .L451	@ tmp119,
	ldr	r4, [r4]	@ TimedHitsDifficultyRam.34_21, TimedHitsDifficultyRam
@ C_Code.c:931:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r4, [r4]	@ *TimedHitsDifficultyRam.34_21, *TimedHitsDifficultyRam.34_21
@ C_Code.c:931:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r5, r4, #26	@ tmp149, *TimedHitsDifficultyRam.34_21,
	bmi	.L443		@,
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r5, .L451+4	@ tmp129,
	ldr	r5, [r5]	@ DifficultyThreshold.36_26, DifficultyThreshold
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r4, r4, #27	@ tmp134, *TimedHitsDifficultyRam.34_21,
	lsrs	r4, r4, #27	@ _25, tmp134,
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r4, r5	@ _25, DifficultyThreshold.36_26
	bge	.L444		@,
@ C_Code.c:934:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r4, .L451+8	@ tmp137,
@ C_Code.c:933:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r4, [r4]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r5, r4	@ DifficultyThreshold.36_26, NumberOfRandomButtons
	bgt	.L443		@,
.L444:
@ C_Code.c:936:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r4, .L451+12	@ tmp140,
	ldr	r5, .L451+16	@ tmp139,
	ldr	r4, [r4]	@ DifficultyBonusPercent, DifficultyBonusPercent
	ldr	r5, [r5]	@ BonusDamagePercent, BonusDamagePercent
	adds	r4, r4, r5	@ _19, DifficultyBonusPercent, BonusDamagePercent
	b	.L442		@
.L439:
@ C_Code.c:941:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r4, #128	@ _5,
	beq	.L445		@,
@ C_Code.c:945:     return FailedHitDamagePercent;
	ldr	r4, .L451+20	@ tmp144,
	ldr	r4, [r4]	@ _19,
.L442:
@ C_Code.c:958:     AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r4, [sp, #4]	@ _19,
	ldr	r4, [sp, #24]	@ tmp163, round
	str	r4, [sp]	@ tmp163,
	bl	AdjustDamageByPercent		@
@ C_Code.c:959: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L450:
@ C_Code.c:922:             if (BlockingEnabled)
	ldr	r4, .L451+24	@ tmp116,
@ C_Code.c:922:             if (BlockingEnabled)
	ldr	r4, [r4]	@ BlockingEnabled, BlockingEnabled
	cmp	r4, #0	@ BlockingEnabled,
	beq	.L445		@,
@ C_Code.c:924:                 return ReducedDamagePercent;
	ldr	r4, .L451+28	@ tmp118,
	ldr	r4, [r4]	@ _19,
	b	.L442		@
.L445:
@ C_Code.c:928:                 return 100;
	movs	r4, #100	@ _19,
	b	.L442		@
.L443:
@ C_Code.c:939:         return BonusDamagePercent;
	ldr	r4, .L451+16	@ tmp143,
	ldr	r4, [r4]	@ _19,
	b	.L442		@
.L452:
	.align	2
.L451:
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
@ C_Code.c:113:     if (gBattleStats.config &
	ldr	r3, .L481	@ tmp159,
@ C_Code.c:804: {
	movs	r6, r2	@ HpProc, HpProc
@ C_Code.c:113:     if (gBattleStats.config &
	ldrh	r2, [r3]	@ gBattleStats, gBattleStats
	movs	r3, #252	@ tmp163,
	lsls	r3, r3, #2	@ tmp163, tmp163,
@ C_Code.c:804: {
	movs	r4, r0	@ proc, proc
	sub	sp, sp, #8	@,,
@ C_Code.c:113:     if (gBattleStats.config &
	tst	r2, r3	@ gBattleStats, tmp163
	bne	.L453		@,
@ C_Code.c:119:     if (TimedHitsDifficultyRam->off)
	ldr	r3, .L481+4	@ tmp168,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_13, *TimedHitsDifficultyRam.0_13
@ C_Code.c:119:     if (TimedHitsDifficultyRam->off)
	lsls	r3, r3, #25	@ tmp295, *TimedHitsDifficultyRam.0_13,
	bpl	.L478		@,
.L453:
@ C_Code.c:911: }
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L478:
@ C_Code.c:123:     return !CheckFlag(DisabledFlag);
	ldr	r3, .L481+8	@ tmp178,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L481+12	@ tmp180,
	bl	.L10		@
@ C_Code.c:805:     if (!AreTimedHitsEnabled())
	cmp	r0, #0	@ tmp289,
	bne	.L453		@,
@ C_Code.c:809:     if (round->hpChange < 0)
	ldrb	r3, [r5, #3]	@ tmp183,
	cmp	r3, #127	@ tmp183,
	bhi	.L453		@,
@ C_Code.c:813:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	ldr	r3, .L481+16	@ tmp184,
@ C_Code.c:813:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	ldrh	r2, [r3, #8]	@ tmp187,
	ldrh	r3, [r3, #4]	@ tmp189,
@ C_Code.c:813:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	orrs	r2, r3	@ tmp187, tmp189
@ C_Code.c:817:     int x = proc->anim2->xPosition;
	ldr	r3, [r4, #48]	@ proc_8(D)->anim2, proc_8(D)->anim2
@ C_Code.c:817:     int x = proc->anim2->xPosition;
	movs	r5, #2	@ x,
	ldrsh	r5, [r3, r5]	@ x, proc_8(D)->anim2, x
@ C_Code.c:813:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	mov	r8, r2	@ keys, tmp187
@ C_Code.c:818:     if (x > 119)
	cmp	r5, #119	@ x,
	bgt	.LCB2757	@
	b	.L455	@long jump	@
.LCB2757:
@ C_Code.c:820:         x -= 40;
	subs	r5, r5, #40	@ x,
.L456:
@ C_Code.c:828:     int hitTime = !proc->EkrEfxIsUnitHittedNowFrames;
	movs	r3, #83	@ tmp193,
@ C_Code.c:829:     if (hitTime)
	ldrb	r3, [r4, r3]	@ tmp194,
	cmp	r3, #0	@ tmp194,
	bne	.L457		@,
@ C_Code.c:826:     struct BattleUnit * active_bunit = proc->active_bunit;
	ldr	r2, [r4, #60]	@ active_bunit, proc_8(D)->active_bunit
	mov	r9, r2	@ active_bunit, active_bunit
@ C_Code.c:827:     struct BattleUnit * opp_bunit = proc->opp_bunit;
	ldr	r2, [r4, #64]	@ opp_bunit, proc_8(D)->opp_bunit
	mov	r10, r2	@ opp_bunit, opp_bunit
@ C_Code.c:832:         if (proc->timer2 == 0xFF)
	movs	r2, #68	@ tmp195,
@ C_Code.c:832:         if (proc->timer2 == 0xFF)
	ldrb	r1, [r4, r2]	@ tmp196,
	cmp	r1, #255	@ tmp196,
	bne	.LCB2772	@
	b	.L479	@long jump	@
.LCB2772:
.L458:
@ C_Code.c:836:         SaveInputFrame(proc, keys);
	mov	r1, r8	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
@ C_Code.c:837:         SaveIfWeHitOnTime(proc);
	movs	r0, r4	@, proc
	bl	SaveIfWeHitOnTime		@
@ C_Code.c:838:         proc->readAhead &= ~READAHEAD_WINDOW_OPEN;
	movs	r2, #86	@ tmp200,
@ C_Code.c:838:         proc->readAhead &= ~READAHEAD_WINDOW_OPEN;
	movs	r1, #2	@ tmp204,
	ldrb	r3, [r4, r2]	@ tmp202,
	bics	r3, r1	@ tmp203, tmp204
	strb	r3, [r4, r2]	@ tmp203, proc_8(D)->readAhead
@ C_Code.c:839:         if (!proc->adjustedDmg)
	movs	r3, #71	@ tmp207,
@ C_Code.c:839:         if (!proc->adjustedDmg)
	ldrb	r2, [r4, r3]	@ tmp208,
	cmp	r2, #0	@ tmp208,
	bne	.L457		@,
@ C_Code.c:678:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r2, .L481+20	@ tmp209,
@ C_Code.c:683:     if (CheatCodeOn())
	ldrb	r2, [r2, #31]	@ tmp210,
	cmp	r2, #127	@ tmp210,
	bls	.LCB2791	@
	b	.L459	@long jump	@
.LCB2791:
@ C_Code.c:687:     if (AlwaysWork)
	ldr	r2, .L481+24	@ tmp211,
@ C_Code.c:687:     if (AlwaysWork)
	ldr	r2, [r2]	@ AlwaysWork, AlwaysWork
	cmp	r2, #0	@ AlwaysWork,
	beq	.LCB2795	@
	b	.L459	@long jump	@
.LCB2795:
@ C_Code.c:691:     return proc->hitOnTime;
	adds	r2, r2, #69	@ tmp213,
@ C_Code.c:841:             if (DidWeHitOnTime(proc))
	ldrb	r2, [r4, r2]	@ tmp214,
	cmp	r2, #0	@ tmp214,
	beq	.LCB2799	@
	b	.L459	@long jump	@
.LCB2799:
@ C_Code.c:848:                 proc->adjustedDmg = true;
	movs	r2, #1	@ tmp220,
	strb	r2, [r4, r3]	@ tmp220, proc_8(D)->adjustedDmg
@ C_Code.c:941:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	mov	r3, r9	@ active_bunit, active_bunit
	movs	r2, #11	@ _87,
	ldrsb	r2, [r3, r2]	@ _87,* _87
	movs	r3, #192	@ tmp223,
	ands	r3, r2	@ _88, _87
@ C_Code.c:941:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _88,
	bne	.LCB2808	@
	b	.L472	@long jump	@
.LCB2808:
@ C_Code.c:945:     return FailedHitDamagePercent;
	ldr	r3, .L481+28	@ tmp225,
	ldr	r3, [r3]	@ _89, FailedHitDamagePercent
.L461:
@ C_Code.c:958:     AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r3, [sp, #4]	@ _89,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	movs	r1, r6	@, HpProc
	movs	r0, r4	@, proc
	str	r7, [sp]	@ round,
	bl	AdjustDamageByPercent		@
.L457:
@ C_Code.c:859:     if (EkrEfxIsUnitHittedNow(proc->side) ||
	movs	r3, #74	@ tmp226,
@ C_Code.c:859:     if (EkrEfxIsUnitHittedNow(proc->side) ||
	ldrb	r0, [r4, r3]	@ _41,
	ldr	r3, .L481+32	@ tmp228,
	bl	.L10		@
@ C_Code.c:861:         (proc->timer2 != 0xFF))
	movs	r3, #68	@ tmp231,
	ldrb	r3, [r4, r3]	@ pretmp_104,
	movs	r6, r3	@ pretmp_104, pretmp_104
@ C_Code.c:859:     if (EkrEfxIsUnitHittedNow(proc->side) ||
	cmp	r0, #0	@ tmp290,
	bne	.L462		@,
@ C_Code.c:860:         (((proc->code4frame != NO_FRAME) || (proc->codefframe != NO_FRAME)) && !IsDamagingRound(proc)) ||
	movs	r3, #78	@ tmp232,
@ C_Code.c:859:     if (EkrEfxIsUnitHittedNow(proc->side) ||
	ldr	r2, .L481+36	@ tmp234,
	ldrh	r3, [r4, r3]	@ tmp233,
	cmp	r3, r2	@ tmp233, tmp234
	beq	.L480		@,
.L463:
@ C_Code.c:488:     struct SkillSysBattleHit * round = proc->currentRound;
	ldr	r3, [r4, #56]	@ round, proc_8(D)->currentRound
@ C_Code.c:489:     if (!round)
	cmp	r3, #0	@ round,
	beq	.L462		@,
@ C_Code.c:493:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	ldr	r2, [r3]	@ *round_45, *round_45
@ C_Code.c:493:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	lsls	r2, r2, #30	@ tmp296, *round_45,
	bmi	.L462		@,
@ C_Code.c:860:         (((proc->code4frame != NO_FRAME) || (proc->codefframe != NO_FRAME)) && !IsDamagingRound(proc)) ||
	ldrb	r3, [r3, #3]	@ tmp244,
	lsls	r3, r3, #24	@ tmp244, tmp244,
	asrs	r3, r3, #24	@ tmp244, tmp244,
	cmp	r3, #0	@ tmp244,
	ble	.L462		@,
.L464:
@ C_Code.c:860:         (((proc->code4frame != NO_FRAME) || (proc->codefframe != NO_FRAME)) && !IsDamagingRound(proc)) ||
	cmp	r6, #255	@ pretmp_104,
	beq	.L465		@,
.L462:
@ C_Code.c:678:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L481+20	@ tmp245,
@ C_Code.c:683:     if (CheatCodeOn())
	ldrb	r3, [r3, #31]	@ tmp246,
	cmp	r3, #127	@ tmp246,
	bhi	.L466		@,
@ C_Code.c:687:     if (AlwaysWork)
	ldr	r3, .L481+24	@ tmp247,
@ C_Code.c:687:     if (AlwaysWork)
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L466		@,
@ C_Code.c:691:     return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp249,
@ C_Code.c:863:         if (DidWeHitOnTime(proc))
	ldrb	r3, [r4, r3]	@ tmp250,
	cmp	r3, #0	@ tmp250,
	bne	.L466		@,
@ C_Code.c:882:         else if (proc->timer2 < 20)
	cmp	r6, #19	@ pretmp_104,
	bhi	.L468		@,
@ C_Code.c:884:             if (ChangePaletteWhenButtonIsPressed)
	ldr	r3, .L481+40	@ tmp274,
@ C_Code.c:884:             if (ChangePaletteWhenButtonIsPressed)
	ldr	r3, [r3]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
	cmp	r3, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L469		@,
@ C_Code.c:886:                 DrawButtonsToPress(proc, x, y, 15);
	movs	r3, #15	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress		@
.L468:
@ C_Code.c:893:         proc->roundEnd = true;
	movs	r3, #82	@ tmp276,
	movs	r2, #1	@ tmp277,
	strb	r2, [r4, r3]	@ tmp277, proc_8(D)->roundEnd
	b	.L453		@
.L466:
@ C_Code.c:874:             if (((y > (-16)) && (y < (161))))
	movs	r3, r6	@ _61, pretmp_104
	adds	r3, r3, #112	@ _61,
	cmp	r3, #175	@ _61,
	bhi	.L468		@,
@ C_Code.c:876:                 if (!gBanimDoneFlag[proc->side])
	movs	r2, #74	@ tmp253,
	ldrb	r2, [r4, r2]	@ _63,
@ C_Code.c:876:                 if (!gBanimDoneFlag[proc->side])
	ldr	r3, .L481+44	@ tmp252,
	lsls	r2, r2, #2	@ tmp255, _63,
@ C_Code.c:876:                 if (!gBanimDoneFlag[proc->side])
	ldr	r3, [r2, r3]	@ gBanimDoneFlag[_63], gBanimDoneFlag[_63]
	cmp	r3, #0	@ gBanimDoneFlag[_63],
	bne	.L468		@,
@ C_Code.c:870:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	movs	r1, #31	@,
	movs	r0, r6	@, pretmp_104
	ldr	r3, .L481+48	@ tmp258,
	bl	.L10		@
@ C_Code.c:870:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	movs	r2, #104	@ tmp260,
	ldr	r3, .L481+52	@ tmp259,
	adds	r3, r3, r0	@ tmp261, tmp259, _53
@ C_Code.c:873:             y -= clock;
	movs	r0, #48	@ tmp265,
@ C_Code.c:870:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	ldrb	r1, [r3, r2]	@ _55, xPos
@ C_Code.c:878:                     PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
	movs	r2, #255	@ tmp267,
@ C_Code.c:873:             y -= clock;
	subs	r0, r0, r6	@ y_59, tmp265, pretmp_104
@ C_Code.c:878:                     PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
	ands	r2, r0	@ _66, y_59
	movs	r0, #224	@ tmp272,
@ C_Code.c:870:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	adds	r1, r1, r5	@ x, _55, x
@ C_Code.c:871:             x += 16;
	adds	r1, r1, #16	@ x_58,
@ C_Code.c:878:                     PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
	lsls	r0, r0, #8	@ tmp272, tmp272,
	lsls	r1, r1, #23	@ tmp271, x_58,
	str	r0, [sp]	@ tmp272,
	ldr	r3, .L481+56	@ tmp264,
	movs	r0, #0	@,
	ldr	r5, .L481+60	@ tmp273,
	lsrs	r1, r1, #23	@ _65, tmp271,
	bl	.L29		@
	b	.L468		@
.L455:
@ C_Code.c:822:     else if (x > 40)
	cmp	r5, #40	@ x,
	bgt	.LCB2930	@
	b	.L456	@long jump	@
.LCB2930:
@ C_Code.c:824:         x -= 20;
	subs	r5, r5, #20	@ x,
	b	.L456		@
.L479:
@ C_Code.c:834:             proc->timer2 = 0;
	strb	r3, [r4, r2]	@ tmp194, proc_8(D)->timer2
	b	.L458		@
.L480:
@ C_Code.c:860:         (((proc->code4frame != NO_FRAME) || (proc->codefframe != NO_FRAME)) && !IsDamagingRound(proc)) ||
	movs	r2, #80	@ tmp235,
@ C_Code.c:860:         (((proc->code4frame != NO_FRAME) || (proc->codefframe != NO_FRAME)) && !IsDamagingRound(proc)) ||
	ldrh	r2, [r4, r2]	@ tmp236,
	cmp	r2, r3	@ tmp236, tmp233
	bne	.L463		@,
	b	.L464		@
.L459:
@ C_Code.c:843:                 proc->adjustedDmg = true;
	movs	r3, #1	@ tmp216,
	movs	r2, #71	@ tmp215,
@ C_Code.c:844:                 AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true);
	movs	r1, r6	@, HpProc
@ C_Code.c:843:                 proc->adjustedDmg = true;
	strb	r3, [r4, r2]	@ tmp216, proc_8(D)->adjustedDmg
@ C_Code.c:844:                 AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true);
	movs	r0, r4	@, proc
	str	r3, [sp, #4]	@ tmp216,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	str	r7, [sp]	@ round,
	bl	AdjustDamageWithGetter		@
	b	.L457		@
.L469:
@ C_Code.c:890:                 DrawButtonsToPress(proc, x, y, 14);
	movs	r3, #14	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress		@
	b	.L468		@
.L465:
@ C_Code.c:897:         if (proc->timer < 1)
	ldr	r3, [r4, #52]	@ proc_8(D)->timer, proc_8(D)->timer
	cmp	r3, #0	@ proc_8(D)->timer,
	bgt	.L470		@,
@ C_Code.c:899:             proc->frame = 0;
	movs	r3, #76	@ tmp280,
	movs	r2, #0	@ tmp281,
	strh	r2, [r4, r3]	@ tmp281, proc_8(D)->frame
.L471:
@ C_Code.c:906:         if (!proc->roundEnd)
	movs	r3, #82	@ tmp283,
@ C_Code.c:906:         if (!proc->roundEnd)
	ldrb	r3, [r4, r3]	@ tmp284,
	cmp	r3, #0	@ tmp284,
	beq	.LCB2983	@
	b	.L453	@long jump	@
.LCB2983:
@ C_Code.c:908:             DrawButtonsToPress(proc, x, y, 15);
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	adds	r3, r3, #15	@,
	bl	DrawButtonsToPress		@
	b	.L453		@
.L470:
@ C_Code.c:904:             SaveInputFrameReadAhead(proc, keys);
	mov	r1, r8	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrameReadAhead		@
	b	.L471		@
.L472:
@ C_Code.c:928:                 return 100;
	movs	r3, #100	@ _89,
	b	.L461		@
.L482:
	.align	2
.L481:
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
@ C_Code.c:308:     if (!proc->anim)
	ldr	r3, [r0, #44]	@ proc_29(D)->anim, proc_29(D)->anim
@ C_Code.c:307: {
	movs	r4, r0	@ proc, proc
	sub	sp, sp, #12	@,,
@ C_Code.c:308:     if (!proc->anim)
	cmp	r3, #0	@ proc_29(D)->anim,
	beq	.L483		@,
@ C_Code.c:313:     struct ProcEkrBattle * battleProc = gpProcEkrBattle;
	ldr	r3, .L510	@ tmp124,
	ldr	r5, [r3]	@ battleProc, gpProcEkrBattle
@ C_Code.c:315:     if (!battleProc)
	cmp	r5, #0	@ battleProc,
	beq	.L483		@,
@ C_Code.c:319:     if (!proc->anim2)
	ldr	r3, [r0, #48]	@ proc_29(D)->anim2, proc_29(D)->anim2
	cmp	r3, #0	@ proc_29(D)->anim2,
	beq	.L483		@,
@ C_Code.c:323:     if (gEkrBattleEndFlag)
	ldr	r3, .L510+4	@ tmp126,
@ C_Code.c:323:     if (gEkrBattleEndFlag)
	ldr	r3, [r3]	@ gEkrBattleEndFlag, gEkrBattleEndFlag
	cmp	r3, #0	@ gEkrBattleEndFlag,
	bne	.L509		@,
@ C_Code.c:330:     if (proc->timer2 != 0xFF)
	movs	r2, #68	@ tmp131,
@ C_Code.c:329:     proc->timer++;
	ldr	r3, [r0, #52]	@ proc_29(D)->timer, proc_29(D)->timer
	adds	r3, r3, #1	@ _5,
	str	r3, [r0, #52]	@ _5, proc_29(D)->timer
@ C_Code.c:330:     if (proc->timer2 != 0xFF)
	ldrb	r3, [r0, r2]	@ _6,
@ C_Code.c:330:     if (proc->timer2 != 0xFF)
	cmp	r3, #255	@ _6,
	beq	.L486		@,
@ C_Code.c:332:         proc->timer2++;
	adds	r3, r3, #1	@ tmp132,
	strb	r3, [r0, r2]	@ tmp132, proc_29(D)->timer2
.L486:
@ C_Code.c:337:     if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
	movs	r2, #83	@ tmp175,
@ C_Code.c:335:     struct SkillSysBattleHit * currentRound = proc->currentRound;
	ldr	r3, [r4, #56]	@ currentRound, proc_29(D)->currentRound
	movs	r7, r3	@ currentRound, currentRound
@ C_Code.c:337:     if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
	ldrb	r3, [r4, r2]	@ _8,
@ C_Code.c:337:     if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
	cmp	r3, #255	@ _8,
	beq	.L487		@,
@ C_Code.c:339:         proc->EkrEfxIsUnitHittedNowFrames++;
	adds	r3, r3, #1	@ tmp136,
	strb	r3, [r4, r2]	@ tmp136, proc_29(D)->EkrEfxIsUnitHittedNowFrames
.L488:
@ C_Code.c:347:     struct NewProcEfxHPBar * HpProc = Proc_Find(gProcScr_efxHPBarResire);
	ldr	r3, .L510+8	@ tmp147,
	ldr	r0, [r3]	@ gProcScr_efxHPBarResire, gProcScr_efxHPBarResire
	ldr	r3, .L510+12	@ tmp149,
	movs	r6, r3	@ tmp149, tmp149
	bl	.L10		@
@ C_Code.c:348:     if (!HpProc)
	cmp	r0, #0	@ HpProc,
	beq	.L489		@,
@ C_Code.c:352:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r2, r0	@, HpProc
	movs	r3, r7	@, currentRound
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
.L490:
@ C_Code.c:299:     if (proc->EkrEfxIsUnitHittedNowFrames)
	movs	r3, #83	@ tmp153,
@ C_Code.c:299:     if (proc->EkrEfxIsUnitHittedNowFrames)
	ldrb	r3, [r4, r3]	@ tmp154,
	cmp	r3, #0	@ tmp154,
	bne	.L483		@,
@ C_Code.c:356:         int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId);
	movs	r6, #70	@ tmp182,
	ldrb	r3, [r4, r6]	@ tmp157,
	movs	r1, #0	@,
	movs	r2, #0	@,
	ldr	r0, [r4, #48]	@ proc_29(D)->anim2, proc_29(D)->anim2
	ldr	r5, .L510+16	@ tmp158,
	str	r3, [sp]	@ tmp157,
	movs	r3, #0	@,
	bl	.L29		@
	movs	r3, r0	@ x,
@ C_Code.c:357:         x = DisplayDamage2(proc->anim, 1, proc->anim->xPosition, x, proc->roundId);
	ldr	r0, [r4, #44]	@ _18, proc_29(D)->anim
	movs	r1, #2	@ tmp173,
	ldrsh	r2, [r0, r1]	@ _20, _18, tmp173
	ldrb	r1, [r4, r6]	@ tmp161,
	str	r1, [sp]	@ tmp161,
	movs	r1, #1	@,
	bl	.L29		@
.L483:
@ C_Code.c:359: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L509:
@ C_Code.c:325:         Proc_End(proc);
	ldr	r3, .L510+20	@ tmp128,
	bl	.L10		@
@ C_Code.c:326:         return;
	b	.L483		@
.L487:
@ C_Code.c:341:     else if (EkrEfxIsUnitHittedNow(proc->side))
	movs	r3, #74	@ tmp139,
@ C_Code.c:341:     else if (EkrEfxIsUnitHittedNow(proc->side))
	ldrb	r0, [r4, r3]	@ _11,
	ldr	r3, .L510+24	@ tmp141,
	bl	.L10		@
@ C_Code.c:341:     else if (EkrEfxIsUnitHittedNow(proc->side))
	cmp	r0, #0	@ tmp166,
	beq	.L488		@,
@ C_Code.c:343:         proc->EkrEfxIsUnitHittedNowFrames = 0;
	movs	r3, #0	@ tmp145,
	movs	r2, #83	@ tmp177,
	strb	r3, [r4, r2]	@ tmp145, proc_29(D)->EkrEfxIsUnitHittedNowFrames
	b	.L488		@
.L489:
@ C_Code.c:350:         HpProc = Proc_Find(gProcScr_efxHPBar);
	ldr	r3, .L510+28	@ tmp150,
	ldr	r0, [r3]	@ gProcScr_efxHPBar, gProcScr_efxHPBar
	bl	.L299		@
@ C_Code.c:352:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r3, r7	@, currentRound
@ C_Code.c:350:         HpProc = Proc_Find(gProcScr_efxHPBar);
	movs	r6, r0	@ HpProc,
@ C_Code.c:352:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r2, r0	@, HpProc
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
@ C_Code.c:294:     if (!HpProc)
	cmp	r6, #0	@ HpProc,
	bne	.L490		@,
	b	.L483		@
.L511:
	.align	2
.L510:
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
.LC145:
	.ascii	"TimedHitsProcName\000"
	.global	gEkrBg2QuakeVec
	.bss
	.align	2
	.type	gEkrBg2QuakeVec, %object
	.size	gEkrBg2QuakeVec, 4
gEkrBg2QuakeVec:
	.space	4
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
	.word	.LC145
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
	.global	__aeabi_idiv
	.ident	"GCC: (devkitARM) 16.1.0"
	.text
	.code 16
	.align	1
.L10:
	bx	r3
.L134:
	bx	r4
.L29:
	bx	r5
.L299:
	bx	r6
.L70:
	bx	r9
.L300:
	bx	r10
