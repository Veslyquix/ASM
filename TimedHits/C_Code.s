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
@ C_Code.c:117:     if (gBattleStats.config &
	ldr	r3, .L8	@ tmp103,
@ C_Code.c:117:     if (gBattleStats.config &
	ldrh	r2, [r3]	@ gBattleStats, gBattleStats
	movs	r3, #252	@ tmp107,
	lsls	r3, r3, #2	@ tmp107, tmp107,
@ C_Code.c:116: {
	push	{r4, lr}	@
@ C_Code.c:117:     if (gBattleStats.config &
	tst	r2, r3	@ gBattleStats, tmp107
	bne	.L4		@,
@ C_Code.c:123:     if (TimedHitsDifficultyRam->off)
	ldr	r3, .L8+4	@ tmp112,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_4, *TimedHitsDifficultyRam.0_4
@ C_Code.c:123:     if (TimedHitsDifficultyRam->off)
	lsls	r3, r3, #25	@ tmp134, *TimedHitsDifficultyRam.0_4,
	bpl	.L7		@,
.L4:
@ C_Code.c:121:         return false;
	movs	r0, #0	@ <retval>,
.L1:
@ C_Code.c:128: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L7:
@ C_Code.c:127:     return !CheckFlag(DisabledFlag);
	ldr	r3, .L8+8	@ tmp122,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L8+12	@ tmp124,
	bl	.L10		@
@ C_Code.c:127:     return !CheckFlag(DisabledFlag);
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
@ C_Code.c:137:     proc->timer2 = 0xFF;
	ldr	r2, .L12	@ tmp98,
@ C_Code.c:152: }
	@ sp needed	@
@ C_Code.c:132:     proc->anim = NULL;
	movs	r3, #0	@ tmp95,
@ C_Code.c:137:     proc->timer2 = 0xFF;
	str	r2, [r0, #68]	@ tmp98, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 68B]
@ C_Code.c:134:     proc->broke = false;
	movs	r2, #72	@ tmp99,
@ C_Code.c:141:     proc->side = 0xFF;
	movs	r1, #255	@ tmp103,
@ C_Code.c:132:     proc->anim = NULL;
	str	r3, [r0, #44]	@ tmp95, proc_2(D)->anim
@ C_Code.c:133:     proc->anim2 = NULL;
	str	r3, [r0, #48]	@ tmp95, proc_2(D)->anim2
@ C_Code.c:136:     proc->timer = 0;
	str	r3, [r0, #52]	@ tmp95, proc_2(D)->timer
@ C_Code.c:134:     proc->broke = false;
	strh	r3, [r0, r2]	@ tmp95, MEM <vector(2) unsigned char> [(unsigned char *)proc_2(D) + 72B]
@ C_Code.c:141:     proc->side = 0xFF;
	adds	r2, r2, #2	@ tmp102,
	strb	r1, [r0, r2]	@ tmp103, proc_2(D)->side
@ C_Code.c:145:     proc->frame = 0;
	ldr	r2, .L12+4	@ tmp108,
	str	r2, [r0, #76]	@ tmp108, MEM <vector(2) short unsigned int> [(short unsigned int *)proc_2(D) + 76B]
@ C_Code.c:149:     proc->codefframe = NO_FRAME;
	ldr	r2, .L12+8	@ tmp109,
	str	r2, [r0, #80]	@ tmp109, MEM <unsigned int> [(void *)proc_2(D) + 80B]
@ C_Code.c:147:     proc->buttonsToPress = 0;
	movs	r2, #84	@ tmp110,
@ C_Code.c:142:     proc->currentRound = NULL;
	str	r3, [r0, #56]	@ tmp95, proc_2(D)->currentRound
@ C_Code.c:143:     proc->active_bunit = NULL;
	str	r3, [r0, #60]	@ tmp95, proc_2(D)->active_bunit
@ C_Code.c:144:     proc->opp_bunit = NULL;
	str	r3, [r0, #64]	@ tmp95, proc_2(D)->opp_bunit
@ C_Code.c:147:     proc->buttonsToPress = 0;
	strh	r3, [r0, r2]	@ tmp95, proc_2(D)->buttonsToPress
@ C_Code.c:151:     proc->readAhead = 0;
	movs	r2, #0	@ tmp101,
	adds	r3, r3, #86	@ tmp113,
	strb	r2, [r0, r3]	@ tmp101, proc_2(D)->readAhead
@ C_Code.c:152: }
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
@ C_Code.c:157:     proc = Proc_Find(TimedHitsProcCmd);
	ldr	r0, .L17	@,
	ldr	r3, .L17+4	@ tmp97,
	bl	.L10		@
	subs	r4, r0, #0	@ proc,,
@ C_Code.c:158:     if (!proc)
	beq	.L16		@,
.L14:
@ C_Code.c:163: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L16:
@ C_Code.c:160:         proc = Proc_Start(TimedHitsProcCmd, (void *)3);
	ldr	r3, .L17+8	@ tmp99,
	movs	r1, #3	@,
	ldr	r0, .L17	@,
	bl	.L10		@
@ C_Code.c:137:     proc->timer2 = 0xFF;
	ldr	r3, .L17+12	@ tmp103,
	str	r3, [r0, #68]	@ tmp103, MEM <vector(4) unsigned char> [(unsigned char *)proc_6 + 68B]
@ C_Code.c:134:     proc->broke = false;
	movs	r3, #72	@ tmp104,
@ C_Code.c:141:     proc->side = 0xFF;
	movs	r2, #255	@ tmp108,
@ C_Code.c:132:     proc->anim = NULL;
	str	r4, [r0, #44]	@ proc, proc_6->anim
@ C_Code.c:133:     proc->anim2 = NULL;
	str	r4, [r0, #48]	@ proc, proc_6->anim2
@ C_Code.c:136:     proc->timer = 0;
	str	r4, [r0, #52]	@ proc, proc_6->timer
@ C_Code.c:134:     proc->broke = false;
	strh	r4, [r0, r3]	@ proc, MEM <vector(2) unsigned char> [(unsigned char *)proc_6 + 72B]
@ C_Code.c:141:     proc->side = 0xFF;
	adds	r3, r3, #2	@ tmp107,
	strb	r2, [r0, r3]	@ tmp108, proc_6->side
@ C_Code.c:145:     proc->frame = 0;
	ldr	r3, .L17+16	@ tmp113,
	str	r3, [r0, #76]	@ tmp113, MEM <vector(2) short unsigned int> [(short unsigned int *)proc_6 + 76B]
@ C_Code.c:149:     proc->codefframe = NO_FRAME;
	ldr	r3, .L17+20	@ tmp114,
	str	r3, [r0, #80]	@ tmp114, MEM <unsigned int> [(void *)proc_6 + 80B]
@ C_Code.c:147:     proc->buttonsToPress = 0;
	movs	r3, #84	@ tmp115,
@ C_Code.c:151:     proc->readAhead = 0;
	movs	r2, #0	@ tmp106,
@ C_Code.c:142:     proc->currentRound = NULL;
	str	r4, [r0, #56]	@ proc, proc_6->currentRound
@ C_Code.c:143:     proc->active_bunit = NULL;
	str	r4, [r0, #60]	@ proc, proc_6->active_bunit
@ C_Code.c:144:     proc->opp_bunit = NULL;
	str	r4, [r0, #64]	@ proc, proc_6->opp_bunit
@ C_Code.c:147:     proc->buttonsToPress = 0;
	strh	r4, [r0, r3]	@ proc, proc_6->buttonsToPress
@ C_Code.c:151:     proc->readAhead = 0;
	adds	r3, r3, #2	@ tmp118,
	strb	r2, [r0, r3]	@ tmp106, proc_6->readAhead
@ C_Code.c:163: }
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
@ C_Code.c:167: {
	movs	r6, r0	@ anim, anim
@ C_Code.c:169:     proc = Proc_Find(TimedHitsProcCmd);
	ldr	r3, .L27	@ tmp113,
	ldr	r0, .L27+4	@ tmp112,
	bl	.L10		@
	subs	r4, r0, #0	@ proc,,
@ C_Code.c:170:     if (!proc)
	beq	.L19		@,
@ C_Code.c:175:     if (proc->roundId == roundId)
	movs	r7, #70	@ tmp115,
@ C_Code.c:174:     int roundId = anim->nextRoundId - 1;
	ldrh	r5, [r6, #14]	@ _2,
@ C_Code.c:175:     if (proc->roundId == roundId)
	ldrb	r3, [r0, r7]	@ _4,
@ C_Code.c:174:     int roundId = anim->nextRoundId - 1;
	subs	r5, r5, #1	@ roundId,
@ C_Code.c:175:     if (proc->roundId == roundId)
	cmp	r3, r5	@ _4, roundId
	beq	.L19		@,
@ C_Code.c:137:     proc->timer2 = 0xFF;
	ldr	r2, .L27+8	@ tmp119,
@ C_Code.c:133:     proc->anim2 = NULL;
	movs	r3, #0	@ tmp117,
@ C_Code.c:137:     proc->timer2 = 0xFF;
	str	r2, [r0, #68]	@ tmp119, MEM <vector(4) unsigned char> [(unsigned char *)proc_20 + 68B]
@ C_Code.c:134:     proc->broke = false;
	movs	r2, #72	@ tmp120,
@ C_Code.c:141:     proc->side = 0xFF;
	movs	r1, #255	@ tmp200,
@ C_Code.c:133:     proc->anim2 = NULL;
	str	r3, [r0, #48]	@ tmp117, proc_20->anim2
@ C_Code.c:136:     proc->timer = 0;
	str	r3, [r0, #52]	@ tmp117, proc_20->timer
@ C_Code.c:134:     proc->broke = false;
	strh	r3, [r0, r2]	@ tmp117, MEM <vector(2) unsigned char> [(unsigned char *)proc_20 + 72B]
@ C_Code.c:141:     proc->side = 0xFF;
	adds	r2, r2, #2	@ tmp198,
	strb	r1, [r0, r2]	@ tmp199, proc_20->side
@ C_Code.c:145:     proc->frame = 0;
	ldr	r2, .L27+12	@ tmp129,
	str	r2, [r0, #76]	@ tmp129, MEM <vector(2) short unsigned int> [(short unsigned int *)proc_20 + 76B]
@ C_Code.c:149:     proc->codefframe = NO_FRAME;
	ldr	r2, .L27+16	@ tmp130,
	str	r2, [r0, #80]	@ tmp130, MEM <unsigned int> [(void *)proc_20 + 80B]
@ C_Code.c:147:     proc->buttonsToPress = 0;
	movs	r2, #84	@ tmp131,
@ C_Code.c:142:     proc->currentRound = NULL;
	str	r3, [r0, #56]	@ tmp117, proc_20->currentRound
@ C_Code.c:143:     proc->active_bunit = NULL;
	str	r3, [r0, #60]	@ tmp117, proc_20->active_bunit
@ C_Code.c:144:     proc->opp_bunit = NULL;
	str	r3, [r0, #64]	@ tmp117, proc_20->opp_bunit
@ C_Code.c:147:     proc->buttonsToPress = 0;
	strh	r3, [r0, r2]	@ tmp117, proc_20->buttonsToPress
@ C_Code.c:151:     proc->readAhead = 0;
	movs	r2, #0	@ tmp122,
	adds	r3, r3, #86	@ tmp134,
	strb	r2, [r0, r3]	@ tmp122, proc_20->readAhead
@ C_Code.c:181:     proc->anim = anim;
	str	r6, [r0, #44]	@ anim, proc_20->anim
@ C_Code.c:182:     proc->anim2 = GetAnimAnotherSide(anim);
	ldr	r3, .L27+20	@ tmp137,
	movs	r0, r6	@, anim
	bl	.L10		@
@ C_Code.c:182:     proc->anim2 = GetAnimAnotherSide(anim);
	str	r0, [r4, #48]	@ _5, proc_20->anim2
@ C_Code.c:186:     proc->currentRound = GetCurrentRound(proc->roundId);
	movs	r0, #255	@ _7,
	ldr	r3, .L27+24	@ tmp142,
@ C_Code.c:183:     proc->roundId = roundId;
	strb	r5, [r4, r7]	@ roundId, proc_20->roundId
@ C_Code.c:186:     proc->currentRound = GetCurrentRound(proc->roundId);
	ands	r0, r5	@ _7, roundId
	bl	.L10		@
@ C_Code.c:187:     proc->side = GetAnimPosition(anim) ^ 1;
	ldr	r3, .L27+28	@ tmp143,
@ C_Code.c:186:     proc->currentRound = GetCurrentRound(proc->roundId);
	str	r0, [r4, #56]	@ _8, proc_20->currentRound
@ C_Code.c:187:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r0, r6	@, anim
	bl	.L10		@
@ C_Code.c:187:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r3, #1	@ tmp145,
@ C_Code.c:187:     proc->side = GetAnimPosition(anim) ^ 1;
	movs	r2, #74	@ tmp202,
@ C_Code.c:187:     proc->side = GetAnimPosition(anim) ^ 1;
	lsls	r0, r0, #24	@ tmp144, _9,
	asrs	r0, r0, #24	@ _10, tmp144,
	eors	r3, r0	@ tmp147, _10
@ C_Code.c:187:     proc->side = GetAnimPosition(anim) ^ 1;
	strb	r3, [r4, r2]	@ tmp147, proc_20->side
@ C_Code.c:188:     proc->active_bunit = gpEkrBattleUnitLeft;
	ldr	r3, .L27+32	@ tmp150,
@ C_Code.c:189:     proc->opp_bunit = gpEkrBattleUnitRight;
	ldr	r2, .L27+36	@ tmp151,
@ C_Code.c:188:     proc->active_bunit = gpEkrBattleUnitLeft;
	ldr	r3, [r3]	@ gpEkrBattleUnitLeft.2_13, gpEkrBattleUnitLeft
@ C_Code.c:189:     proc->opp_bunit = gpEkrBattleUnitRight;
	ldr	r2, [r2]	@ gpEkrBattleUnitRight.3_14, gpEkrBattleUnitRight
@ C_Code.c:188:     proc->active_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #60]	@ gpEkrBattleUnitLeft.2_13, proc_20->active_bunit
@ C_Code.c:189:     proc->opp_bunit = gpEkrBattleUnitRight;
	str	r2, [r4, #64]	@ gpEkrBattleUnitRight.3_14, proc_20->opp_bunit
@ C_Code.c:190:     if (!proc->side)
	cmp	r0, #1	@ _10,
	beq	.L25		@,
@ C_Code.c:195:     if (!proc->loadedImg)
	movs	r6, #73	@ tmp152,
@ C_Code.c:195:     if (!proc->loadedImg)
	ldrb	r7, [r4, r6]	@ tmp153,
	cmp	r7, #0	@ tmp153,
	beq	.L26		@,
.L19:
@ C_Code.c:208: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L25:
@ C_Code.c:195:     if (!proc->loadedImg)
	movs	r6, #73	@ tmp152,
@ C_Code.c:192:         proc->active_bunit = gpEkrBattleUnitRight;
	str	r2, [r4, #60]	@ gpEkrBattleUnitRight.3_14, proc_20->active_bunit
@ C_Code.c:193:         proc->opp_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #64]	@ gpEkrBattleUnitLeft.2_13, proc_20->opp_bunit
@ C_Code.c:195:     if (!proc->loadedImg)
	ldrb	r7, [r4, r6]	@ tmp153,
	cmp	r7, #0	@ tmp153,
	bne	.L19		@,
.L26:
@ C_Code.c:197:         Copy2dChr(&Press_Image, (void *)0x06012980, 6, 2);
	ldr	r5, .L27+40	@ tmp156,
	movs	r3, #2	@,
	movs	r2, #6	@,
	ldr	r0, .L27+44	@ tmp155,
	ldr	r1, .L27+48	@,
	bl	.L29		@
@ C_Code.c:198:         Copy2dChr(&BattleStar, (void *)0x06012a40, 2, 2);   // 0x108
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+52	@ tmp158,
	ldr	r1, .L27+56	@,
	bl	.L29		@
@ C_Code.c:199:         Copy2dChr(&A_Button, (void *)0x06012800, 2, 2);     // 0x140
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+60	@ tmp161,
	ldr	r1, .L27+64	@,
	bl	.L29		@
@ C_Code.c:200:         Copy2dChr(&B_Button, (void *)0x06012840, 2, 2);     // 0x142
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+68	@ tmp164,
	ldr	r1, .L27+72	@,
	bl	.L29		@
@ C_Code.c:201:         Copy2dChr(&Left_Button, (void *)0x06012880, 2, 2);  // 0x144
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+76	@ tmp167,
	ldr	r1, .L27+80	@,
	bl	.L29		@
@ C_Code.c:202:         Copy2dChr(&Right_Button, (void *)0x060128C0, 2, 2); // 0x146
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+84	@ tmp170,
	ldr	r1, .L27+88	@,
	bl	.L29		@
@ C_Code.c:203:         Copy2dChr(&Up_Button, (void *)0x06012900, 2, 2);    // 0x148
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+92	@ tmp173,
	ldr	r1, .L27+96	@,
	bl	.L29		@
@ C_Code.c:204:         Copy2dChr(&Down_Button, (void *)0x06012940, 2, 2);  // 0x14a
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L27+100	@ tmp176,
	ldr	r1, .L27+104	@,
	bl	.L29		@
@ C_Code.c:205:         proc->pressImg = PRESS_DEFAULT;
	movs	r3, #87	@ tmp178,
	strb	r7, [r4, r3]	@ tmp153, proc_20->pressImg
@ C_Code.c:206:         proc->loadedImg = true;
	subs	r3, r3, #86	@ tmp182,
	strb	r3, [r4, r6]	@ tmp182, proc_20->loadedImg
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
@ C_Code.c:288:     if (proc->broke)
	movs	r3, #72	@ tmp96,
@ C_Code.c:288:     if (proc->broke)
	ldrb	r2, [r0, r3]	@ tmp97,
	cmp	r2, #0	@ tmp97,
	bne	.L30		@,
@ C_Code.c:292:     proc->broke = true;
	adds	r2, r2, #1	@ tmp99,
	strb	r2, [r0, r3]	@ tmp99, proc_4(D)->broke
@ C_Code.c:293:     asm("mov r11, r11");
	.syntax divided
@ 293 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L30:
@ C_Code.c:294: }
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
@ C_Code.c:299:     if (!HpProc)
	cmp	r1, #0	@ HpProc,
	beq	.L34		@,
@ C_Code.c:304:     if (proc->EkrEfxIsUnitHittedNowFrames)
	movs	r3, #83	@ tmp99,
@ C_Code.c:304:     if (proc->EkrEfxIsUnitHittedNowFrames)
	ldrb	r0, [r0, r3]	@ tmp101,
	rsbs	r3, r0, #0	@ tmp103, tmp101
	adcs	r0, r0, r3	@ <retval>, tmp101, tmp103
.L32:
@ C_Code.c:309: }
	@ sp needed	@
	bx	lr
.L34:
@ C_Code.c:301:         return false;
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
@ C_Code.c:378:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	movs	r3, #74	@ tmp104,
@ C_Code.c:377: {
	push	{r4, lr}	@
@ C_Code.c:378:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldr	r2, [r0, #60]	@ proc_6(D)->active_bunit, proc_6(D)->active_bunit
@ C_Code.c:392: }
	@ sp needed	@
@ C_Code.c:378:     int wepType = GetItemType(proc->active_bunit->weaponBefore);
	ldrh	r0, [r2, r3]	@ _3,
	ldr	r3, .L36	@ tmp106,
	bl	.L10		@
@ C_Code.c:387:     if (wepType == 7)
	movs	r3, #2	@ tmp111,
@ C_Code.c:383:     if (wepType == 6)
	subs	r0, r0, #5	@ _16,
@ C_Code.c:387:     if (wepType == 7)
	cmp	r3, r0	@ tmp111, _16
	sbcs	r0, r0, r0	@ tmp115
	rsbs	r0, r0, #0	@ _14, tmp115
@ C_Code.c:392: }
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
@ C_Code.c:397:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L63	@ tmp121,
@ C_Code.c:397:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:396: {
	mov	r10, r0	@ proc, proc
	sub	sp, sp, #8	@,,
@ C_Code.c:397:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	cmp	r3, #0	@ AlwaysA,
	bne	.L39		@,
@ C_Code.c:397:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L63+4	@ tmp123,
	ldr	r2, [r3]	@ TimedHitsDifficultyRam.10_2, TimedHitsDifficultyRam
@ C_Code.c:397:     if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.10_2, *TimedHitsDifficultyRam.10_2
	lsls	r3, r3, #26	@ tmp167, *TimedHitsDifficultyRam.10_2,
	bmi	.L39		@,
@ C_Code.c:401:     int keys = proc->buttonsToPress;
	movs	r3, #84	@ tmp133,
@ C_Code.c:401:     int keys = proc->buttonsToPress;
	ldrh	r0, [r0, r3]	@ <retval>,
@ C_Code.c:402:     if (!keys)
	cmp	r0, #0	@ <retval>,
	bne	.L38		@,
@ C_Code.c:404:         u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN };
	ldr	r3, .L63+8	@ tmp135,
	ldr	r1, [r3]	@ tmp138,
	str	r1, [sp]	@ tmp138,
	mov	r1, sp	@ tmp170,
	ldrh	r3, [r3, #4]	@ tmp140,
	strh	r3, [r1, #4]	@ tmp140,
@ C_Code.c:409:         int numberOfRandomButtons = NumberOfRandomButtons;
	ldr	r3, .L63+12	@ tmp142,
	ldr	r3, [r3]	@ numberOfRandomButtons, NumberOfRandomButtons
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:410:         if (!numberOfRandomButtons)
	cmp	r3, #0	@ numberOfRandomButtons,
	beq	.L60		@,
@ C_Code.c:419:         for (int i = 0; i < numberOfRandomButtons; ++i)
	ble	.L53		@,
.L44:
	ldr	r3, .L63+16	@ tmp161,
@ C_Code.c:419:         for (int i = 0; i < numberOfRandomButtons; ++i)
	movs	r4, #0	@ i,
@ C_Code.c:407:         int oppDir = 0;
	movs	r5, #0	@ oppDir,
@ C_Code.c:401:     int keys = proc->buttonsToPress;
	movs	r6, #0	@ keys,
@ C_Code.c:408:         int size = 5; // -1 since we count from 0
	movs	r7, #5	@ size,
	mov	r9, r3	@ tmp161, tmp161
	b	.L52		@
.L46:
@ C_Code.c:419:         for (int i = 0; i < numberOfRandomButtons; ++i)
	adds	r4, r4, #1	@ i,
@ C_Code.c:454:             keys |= button;
	orrs	r6, r0	@ keys, button
@ C_Code.c:419:         for (int i = 0; i < numberOfRandomButtons; ++i)
	cmp	r8, r4	@ numberOfRandomButtons, i
	ble	.L61		@,
.L52:
@ C_Code.c:421:             num = NextRN_N(size);
	movs	r0, r7	@, size
	bl	.L65		@
@ C_Code.c:422:             button = KeysList[num];
	mov	r3, sp	@ tmp177,
	ldrb	r0, [r3, r0]	@ button, KeysList
@ C_Code.c:425:             if (button & 0xF0)
	cmp	r0, #15	@ button,
	bls	.L46		@,
@ C_Code.c:427:                 if (button == DPAD_RIGHT)
	cmp	r0, #16	@ button,
	beq	.L54		@,
@ C_Code.c:431:                 if (button == DPAD_LEFT)
	cmp	r0, #32	@ button,
	beq	.L55		@,
@ C_Code.c:435:                 if (button == DPAD_UP)
	cmp	r0, #64	@ button,
	bne	.L62		@,
@ C_Code.c:437:                     oppDir = DPAD_DOWN;
	movs	r5, #128	@ oppDir,
.L47:
@ C_Code.c:443:                 for (int c = 0; c <= size; ++c)
	cmp	r7, #0	@ size,
	blt	.L46		@,
	adds	r3, r7, #1	@ _13, size,
	mov	ip, r3	@ _13, _13
	mov	r2, sp	@ ivtmp.136,
@ C_Code.c:443:                 for (int c = 0; c <= size; ++c)
	movs	r3, #0	@ c,
	b	.L50		@
.L49:
@ C_Code.c:443:                 for (int c = 0; c <= size; ++c)
	adds	r3, r3, #1	@ c,
@ C_Code.c:443:                 for (int c = 0; c <= size; ++c)
	adds	r2, r2, #1	@ ivtmp.136,
	cmp	ip, r3	@ _13, c
	beq	.L46		@,
.L50:
@ C_Code.c:445:                     if (KeysList[c] == oppDir)
	ldrb	r1, [r2]	@ _9, MEM[(unsigned char *)_22]
@ C_Code.c:445:                     if (KeysList[c] == oppDir)
	cmp	r1, r5	@ _9, oppDir
	bne	.L49		@,
@ C_Code.c:447:                         KeysList[c] = KeysList[size];
	mov	r2, sp	@ tmp179,
@ C_Code.c:447:                         KeysList[c] = KeysList[size];
	mov	r1, sp	@ tmp180,
@ C_Code.c:447:                         KeysList[c] = KeysList[size];
	ldrb	r2, [r2, r7]	@ _10, KeysList
@ C_Code.c:419:         for (int i = 0; i < numberOfRandomButtons; ++i)
	adds	r4, r4, #1	@ i,
@ C_Code.c:447:                         KeysList[c] = KeysList[size];
	strb	r2, [r1, r3]	@ _10, KeysList[c_54]
@ C_Code.c:448:                         size--;
	subs	r7, r7, #1	@ size,
@ C_Code.c:454:             keys |= button;
	orrs	r6, r0	@ keys, button
@ C_Code.c:419:         for (int i = 0; i < numberOfRandomButtons; ++i)
	cmp	r8, r4	@ numberOfRandomButtons, i
	bgt	.L52		@,
.L61:
@ C_Code.c:456:         proc->buttonsToPress = keys;
	movs	r0, r6	@ <retval>, prephitmp_17
.L45:
	movs	r3, #84	@ tmp158,
	mov	r2, r10	@ proc, proc
	strh	r6, [r2, r3]	@ prephitmp_17, proc_28(D)->buttonsToPress
	b	.L38		@
.L39:
@ C_Code.c:399:         return A_BUTTON;
	movs	r0, #1	@ <retval>,
.L38:
@ C_Code.c:459: }
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L60:
@ C_Code.c:412:             numberOfRandomButtons = TimedHitsDifficultyRam->difficulty;
	ldrb	r3, [r2]	@ *TimedHitsDifficultyRam.10_2, *TimedHitsDifficultyRam.10_2
	lsls	r3, r3, #27	@ tmp146, *TimedHitsDifficultyRam.10_2,
@ C_Code.c:414:         if (!numberOfRandomButtons)
	lsrs	r2, r3, #3	@ tmp162, tmp146,
	cmp	r3, #0	@ tmp146,
	bne	.L43		@,
	movs	r2, #128	@ tmp162,
	lsls	r2, r2, #17	@ tmp162, tmp162,
.L43:
	lsrs	r3, r2, #24	@ numberOfRandomButtons, tmp162,
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
	b	.L44		@
.L54:
@ C_Code.c:429:                     oppDir = DPAD_LEFT;
	movs	r5, #32	@ oppDir,
	b	.L47		@
.L55:
@ C_Code.c:433:                     oppDir = DPAD_RIGHT;
	movs	r5, #16	@ oppDir,
	b	.L47		@
.L62:
@ C_Code.c:439:                 if (button == DPAD_DOWN)
	cmp	r0, #128	@ button,
	bne	.L47		@,
@ C_Code.c:441:                     oppDir = DPAD_UP;
	movs	r5, #64	@ oppDir,
	b	.L47		@
.L53:
@ C_Code.c:419:         for (int i = 0; i < numberOfRandomButtons; ++i)
	movs	r6, #0	@ prephitmp_17,
	b	.L45		@
.L64:
	.align	2
.L63:
	.word	AlwaysA
	.word	TimedHitsDifficultyRam
	.word	.LC26
	.word	NumberOfRandomButtons
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
@ C_Code.c:463: {
	movs	r4, r0	@ keys, keys
	ldr	r0, .L72	@ tmp102,
	movs	r2, r0	@ ivtmp.150, tmp102
@ C_Code.c:464:     int c = 0;
	movs	r1, #0	@ <retval>,
	adds	r2, r2, #32	@ ivtmp.150,
	adds	r0, r0, #38	@ _15,
.L68:
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ _21, MEM[(unsigned char *)_38]
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _22, keys
@ C_Code.c:469:             c++;
	subs	r5, r3, #1	@ tmp108, _22
	sbcs	r3, r3, r5	@ tmp107, _22, tmp108
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.150,
@ C_Code.c:469:             c++;
	adds	r1, r1, r3	@ <retval>, <retval>, tmp107
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	cmp	r2, r0	@ ivtmp.150, _15
	bne	.L68		@,
@ C_Code.c:473: }
	@ sp needed	@
	movs	r0, r1	@, <retval>
	pop	{r4, r5}
	pop	{r1}
	bx	r1
.L73:
	.align	2
.L72:
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
@ C_Code.c:476: {
	movs	r4, r1	@ keys, keys
@ C_Code.c:477:     int reqKeys = GetButtonsToPress(proc);
	bl	GetButtonsToPress		@
	mov	ip, r0	@ reqKeys,
	ldr	r0, .L99	@ tmp130,
	movs	r2, r0	@ ivtmp.173, tmp130
	adds	r2, r2, #32	@ ivtmp.173,
@ C_Code.c:478:     int count = CountKeysPressed(reqKeys);
	movs	r1, r2	@ ivtmp.185, ivtmp.173
@ C_Code.c:464:     int c = 0;
	movs	r5, #0	@ c,
	adds	r0, r0, #38	@ _39,
.L76:
@ C_Code.c:467:         if (keys & RomKeysList[i])
	mov	r6, ip	@ reqKeys, reqKeys
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ldrb	r3, [r1]	@ _112, MEM[(unsigned char *)_168]
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ands	r3, r6	@ _113, reqKeys
@ C_Code.c:469:             c++;
	subs	r7, r3, #1	@ tmp149, _113
	sbcs	r3, r3, r7	@ tmp148, _113, tmp149
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	adds	r1, r1, #1	@ ivtmp.185,
@ C_Code.c:469:             c++;
	adds	r5, r5, r3	@ c, c, tmp148
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	cmp	r0, r1	@ _39, ivtmp.185
	bne	.L76		@,
	movs	r1, r2	@ ivtmp.179, ivtmp.173
@ C_Code.c:464:     int c = 0;
	movs	r7, #0	@ c,
.L78:
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ldrb	r3, [r1]	@ _97, MEM[(unsigned char *)_132]
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _98, keys
@ C_Code.c:469:             c++;
	subs	r6, r3, #1	@ tmp152, _98
	sbcs	r3, r3, r6	@ tmp151, _98, tmp152
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	adds	r1, r1, #1	@ ivtmp.179,
@ C_Code.c:469:             c++;
	adds	r7, r7, r3	@ c, c, tmp151
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	cmp	r0, r1	@ _39, ivtmp.179
	bne	.L78		@,
@ C_Code.c:464:     int c = 0;
	movs	r1, #0	@ c,
@ C_Code.c:479:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r5, r7	@ c, c
	blt	.L79		@,
.L81:
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ _16, MEM[(unsigned char *)_88]
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _51, keys
@ C_Code.c:469:             c++;
	subs	r7, r3, #1	@ tmp155, _51
	sbcs	r3, r3, r7	@ tmp154, _51, tmp155
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.173,
@ C_Code.c:469:             c++;
	adds	r1, r1, r3	@ c, c, tmp154
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	cmp	r0, r2	@ _39, ivtmp.173
	bne	.L81		@,
@ C_Code.c:479:     if (ABS(count - CountKeysPressed(keys)) > 1)
	subs	r1, r5, r1	@ _3, c, c
@ C_Code.c:479:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r1, #1	@ _3,
	bgt	.L85		@,
.L82:
@ C_Code.c:483:     reqKeys &= ~keys; // only 0 if we hit all the correct keys (and possibly 1 extra)
	mov	r0, ip	@ reqKeys, reqKeys
	bics	r0, r4	@ reqKeys, keys
@ C_Code.c:484:     return (!reqKeys);
	rsbs	r3, r0, #0	@ tmp145, reqKeys_20
	adcs	r0, r0, r3	@ <retval>, reqKeys_20, tmp145
.L74:
@ C_Code.c:485: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L79:
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ldrb	r3, [r2]	@ _82, MEM[(unsigned char *)_69]
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ands	r3, r4	@ _83, keys
@ C_Code.c:469:             c++;
	subs	r7, r3, #1	@ tmp158, _83
	sbcs	r3, r3, r7	@ tmp157, _83, tmp158
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	adds	r2, r2, #1	@ ivtmp.173,
@ C_Code.c:469:             c++;
	adds	r1, r1, r3	@ c, c, tmp157
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	cmp	r0, r2	@ _39, ivtmp.173
	bne	.L79		@,
@ C_Code.c:479:     if (ABS(count - CountKeysPressed(keys)) > 1)
	subs	r1, r1, r5	@ _4, c, c
@ C_Code.c:479:     if (ABS(count - CountKeysPressed(keys)) > 1)
	cmp	r1, #1	@ _4,
	ble	.L82		@,
.L85:
@ C_Code.c:481:         return false;
	movs	r0, #0	@ <retval>,
	b	.L74		@
.L100:
	.align	2
.L99:
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
@ C_Code.c:489:     struct SkillSysBattleHit * round = proc->currentRound;
	ldr	r3, [r0, #56]	@ round, proc_6(D)->currentRound
@ C_Code.c:490:     if (!round)
	cmp	r3, #0	@ round,
	beq	.L104		@,
@ C_Code.c:494:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	ldr	r2, [r3]	@ *round_7, *round_7
@ C_Code.c:494:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	lsls	r2, r2, #30	@ tmp114, *round_7,
	bmi	.L104		@,
@ C_Code.c:498:     return round->hpChange > 0;
	ldrb	r3, [r3, #3]	@ tmp108,
	lsls	r3, r3, #24	@ tmp108, tmp108,
	asrs	r3, r3, #24	@ tmp108, tmp108,
	asrs	r0, r3, #31	@ tmp110, tmp108,
	subs	r0, r0, r3	@ tmp111, tmp110, tmp108
	lsrs	r0, r0, #31	@ <retval>, tmp111,
.L101:
@ C_Code.c:499: }
	@ sp needed	@
	bx	lr
.L104:
@ C_Code.c:492:         return false;
	movs	r0, #0	@ <retval>,
	b	.L101		@
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
@ C_Code.c:502:     struct Anim * anim = proc->anim;
	ldr	r2, [r0, #44]	@ anim, proc_18(D)->anim
@ C_Code.c:501: {
	push	{r4, r5, r6, lr}	@
@ C_Code.c:501: {
	movs	r4, r0	@ proc, proc
@ C_Code.c:503:     u32 instruction = *anim->pScrCurrent++;
	ldr	r0, [r2, #32]	@ _1, anim_19->pScrCurrent
@ C_Code.c:503:     u32 instruction = *anim->pScrCurrent++;
	ldr	r3, [r0]	@ instruction, *_1
	mov	ip, r3	@ instruction, instruction
@ C_Code.c:504:     if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND)
	movs	r3, #252	@ tmp120,
	mov	r5, ip	@ instruction, instruction
	lsls	r3, r3, #22	@ tmp120, tmp120,
	ands	r3, r5	@ _9, instruction
	movs	r5, #160	@ tmp121,
	lsls	r5, r5, #19	@ tmp121, tmp121,
	cmp	r3, r5	@ _9, tmp121
	beq	.L124		@,
.L107:
@ C_Code.c:523:     instruction = *anim->pScrCurrent--;
	str	r0, [r2, #32]	@ _1, anim_19->pScrCurrent
@ C_Code.c:524:     if (PressedSpecificKeys(proc, keys))
	movs	r0, r4	@, proc
	bl	PressedSpecificKeys		@
@ C_Code.c:524:     if (PressedSpecificKeys(proc, keys))
	cmp	r0, #0	@ _10,
	beq	.L106		@,
@ C_Code.c:526:         if (!proc->frame)
	movs	r3, #76	@ tmp152,
@ C_Code.c:526:         if (!proc->frame)
	ldrh	r2, [r4, r3]	@ tmp153,
	cmp	r2, #0	@ tmp153,
	beq	.L125		@,
.L106:
@ C_Code.c:532: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L124:
@ C_Code.c:506:         if ((ANINS_COMMAND_GET_ID(instruction) == 4) && (proc->code4frame == NO_FRAME))
	movs	r3, #255	@ tmp122,
	mov	r5, ip	@ instruction, instruction
	ands	r3, r5	@ _2, instruction
@ C_Code.c:506:         if ((ANINS_COMMAND_GET_ID(instruction) == 4) && (proc->code4frame == NO_FRAME))
	cmp	r3, #4	@ _2,
	beq	.L126		@,
@ C_Code.c:514:         if ((ANINS_COMMAND_GET_ID(instruction) == 0xF) && (proc->codefframe == NO_FRAME))
	cmp	r3, #15	@ _2,
	bne	.L107		@,
@ C_Code.c:514:         if ((ANINS_COMMAND_GET_ID(instruction) == 0xF) && (proc->codefframe == NO_FRAME))
	adds	r3, r3, #65	@ tmp139,
@ C_Code.c:514:         if ((ANINS_COMMAND_GET_ID(instruction) == 0xF) && (proc->codefframe == NO_FRAME))
	ldrh	r5, [r4, r3]	@ tmp140,
	mov	ip, r5	@ tmp140, tmp140
	ldr	r5, .L127	@ tmp141,
	cmp	ip, r5	@ tmp140, tmp141
	bne	.L107		@,
.L123:
@ C_Code.c:508:             proc->code4frame = proc->timer;
	ldr	r5, [r4, #52]	@ proc_18(D)->timer, proc_18(D)->timer
	strh	r5, [r4, r3]	@ proc_18(D)->timer,
@ C_Code.c:489:     struct SkillSysBattleHit * round = proc->currentRound;
	ldr	r3, [r4, #56]	@ round, proc_18(D)->currentRound
@ C_Code.c:490:     if (!round)
	cmp	r3, #0	@ round,
	beq	.L110		@,
@ C_Code.c:494:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	ldr	r5, [r3]	@ *round_34,* round
@ C_Code.c:494:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	lsls	r5, r5, #30	@ tmp168, *round_34,
	bmi	.L110		@,
@ C_Code.c:517:             if (!IsDamagingRound(proc))
	ldrb	r3, [r3, #3]	@ tmp151,
	lsls	r3, r3, #24	@ tmp151, tmp151,
	asrs	r3, r3, #24	@ tmp151, tmp151,
	cmp	r3, #0	@ tmp151,
	bgt	.L107		@,
.L110:
@ C_Code.c:511:                 proc->timer2 = 0;
	movs	r3, #68	@ tmp129,
	movs	r5, #0	@ tmp130,
	strb	r5, [r4, r3]	@ tmp130, proc_18(D)->timer2
	b	.L107		@
.L125:
@ C_Code.c:529:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	movs	r1, #128	@,
	movs	r0, #159	@,
@ C_Code.c:528:             proc->frame = proc->timer;     // locate is side for stereo?
	ldr	r2, [r4, #52]	@ proc_18(D)->timer, proc_18(D)->timer
@ C_Code.c:529:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	lsls	r1, r1, #1	@,,
@ C_Code.c:528:             proc->frame = proc->timer;     // locate is side for stereo?
	strh	r2, [r4, r3]	@ proc_18(D)->timer, proc_18(D)->frame
@ C_Code.c:529:             PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
	lsls	r0, r0, #1	@,,
	movs	r2, #120	@,
	ldr	r4, .L127+4	@ tmp159,
	subs	r3, r3, #75	@,
	bl	.L129		@
@ C_Code.c:532: }
	b	.L106		@
.L126:
@ C_Code.c:506:         if ((ANINS_COMMAND_GET_ID(instruction) == 4) && (proc->code4frame == NO_FRAME))
	adds	r3, r3, #74	@ tmp123,
@ C_Code.c:506:         if ((ANINS_COMMAND_GET_ID(instruction) == 4) && (proc->code4frame == NO_FRAME))
	ldrh	r5, [r4, r3]	@ tmp124,
	mov	ip, r5	@ tmp124, tmp124
	ldr	r5, .L127	@ tmp125,
	cmp	ip, r5	@ tmp124, tmp125
	bne	.L107		@,
	b	.L123		@
.L128:
	.align	2
.L127:
	.word	65535
	.word	PlaySFX
	.size	SaveInputFrame, .-SaveInputFrame
	.align	1
	.p2align 2,,3
	.global	GetFramesUntilHit
	.syntax unified
	.code	16
	.thumb_func
	.type	GetFramesUntilHit, %function
GetFramesUntilHit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, fp	@,
	mov	r7, r10	@,
	mov	r6, r9	@,
	mov	r5, r8	@,
	push	{r5, r6, r7, lr}	@
@ C_Code.c:537:     struct Anim * anim = proc->anim;
	ldr	r3, [r0, #44]	@ anim, proc_35(D)->anim
@ C_Code.c:536: {
	movs	r2, r0	@ proc, proc
	mov	fp, r1	@ isCast, isCast
	sub	sp, sp, #12	@,,
@ C_Code.c:538:     if (!anim || !anim->pScrCurrent)
	cmp	r3, #0	@ anim,
	beq	.L131		@,
@ C_Code.c:538:     if (!anim || !anim->pScrCurrent)
	ldr	r0, [r3, #32]	@ scr, anim_36->pScrCurrent
@ C_Code.c:538:     if (!anim || !anim->pScrCurrent)
	cmp	r0, #0	@ scr,
	beq	.L131		@,
@ C_Code.c:542:     int isMiss = proc->currentRound && (proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS);
	ldr	r2, [r2, #56]	@ _2, proc_35(D)->currentRound
@ C_Code.c:542:     int isMiss = proc->currentRound && (proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS);
	cmp	r2, #0	@ _2,
	beq	.L150		@,
@ C_Code.c:542:     int isMiss = proc->currentRound && (proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS);
	ldr	r2, [r2]	@ *_2, *_2
@ C_Code.c:542:     int isMiss = proc->currentRound && (proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS);
	lsls	r2, r2, #30	@ tmp135, *_2,
	lsrs	r2, r2, #31	@ iftmp.15_32, tmp135,
	str	r2, [sp, #4]	@ iftmp.15_32, %sfp
.L134:
@ C_Code.c:544:     int frames = anim->timer;
	movs	r4, #6	@ <retval>,
	ldrsh	r4, [r3, r4]	@ <retval>, anim, <retval>
@ C_Code.c:555:             if (ANINS_PTRINS_GET_TYPE(instruction) == 0)
	movs	r3, #192	@ tmp165,
	lsls	r3, r3, #22	@ tmp165, tmp165,
	mov	ip, r3	@ tmp165, tmp165
@ C_Code.c:550:             frames += ANINS_FORCESPRITE_GET_DELAY(instruction);
	movs	r3, #28	@ tmp166,
@ C_Code.c:544:     int frames = anim->timer;
	movs	r1, #128	@ ivtmp_53,
@ C_Code.c:553:         if (ANINS_IS_PTRINS(instruction))
	movs	r5, #128	@ tmp163,
@ C_Code.c:550:             frames += ANINS_FORCESPRITE_GET_DELAY(instruction);
	mov	r9, r3	@ tmp166, tmp166
	subs	r3, r3, #25	@ tmp167,
	mov	r10, r3	@ tmp167, tmp167
@ C_Code.c:544:     int frames = anim->timer;
	lsls	r1, r1, #3	@ ivtmp_53, ivtmp_53,
@ C_Code.c:553:         if (ANINS_IS_PTRINS(instruction))
	lsls	r5, r5, #23	@ tmp163, tmp163,
	b	.L149		@
.L135:
@ C_Code.c:553:         if (ANINS_IS_PTRINS(instruction))
	tst	r3, r5	@ instruction, tmp163
	beq	.L137		@,
@ C_Code.c:555:             if (ANINS_PTRINS_GET_TYPE(instruction) == 0)
	mov	r0, ip	@ tmp165, tmp165
	tst	r3, r0	@ instruction, tmp165
	bne	.L131		@,
@ C_Code.c:547:         u32 instruction = *scr++;
	movs	r0, r2	@ scr, scr
.L136:
@ C_Code.c:545:     for (int i = 0; i < READAHEAD_MAX_WORDS; ++i)
	subs	r1, r1, #1	@ ivtmp_53,
	cmp	r1, #0	@ ivtmp_53,
	beq	.L131		@,
.L149:
@ C_Code.c:547:         u32 instruction = *scr++;
	movs	r2, r0	@ scr, scr
@ C_Code.c:547:         u32 instruction = *scr++;
	ldmia	r2!, {r3}	@ *scr_56, instruction
@ C_Code.c:548:         if (!ANINS_IS_NOT_FORCESPRITE(instruction))
	cmp	r3, #0	@ instruction,
	blt	.L135		@,
@ C_Code.c:550:             frames += ANINS_FORCESPRITE_GET_DELAY(instruction);
	mov	r6, r9	@ tmp166, tmp166
	lsrs	r0, r3, #26	@ _6, instruction,
	ands	r0, r6	@ _7, tmp166
	mov	r6, r10	@ tmp167, tmp167
	ands	r3, r6	@ _8, tmp167
	orrs	r3, r0	@ _9, _7
@ C_Code.c:550:             frames += ANINS_FORCESPRITE_GET_DELAY(instruction);
	adds	r4, r3, r4	@ <retval>, _9, <retval>
@ C_Code.c:547:         u32 instruction = *scr++;
	movs	r0, r2	@ scr, scr
@ C_Code.c:551:             continue;
	b	.L136		@
.L137:
@ C_Code.c:561:         switch (ANINS_GET_TYPE(instruction))
	movs	r7, #63	@ tmp182,
	lsrs	r6, r3, #24	@ _13, instruction,
	ands	r6, r7	@ _13, tmp182
@ C_Code.c:561:         switch (ANINS_GET_TYPE(instruction))
	cmp	r6, #5	@ _14,
	beq	.L138		@,
	bhi	.L139		@,
	cmp	r6, #3	@ _14,
	beq	.L140		@,
	cmp	r6, #4	@ _14,
	bne	.L131		@,
@ C_Code.c:564:                 frames += ANINS_WAIT_GET_DELAY(instruction);
	lsls	r3, r3, #16	@ tmp149, instruction,
	lsrs	r3, r3, #16	@ _15, tmp149,
@ C_Code.c:547:         u32 instruction = *scr++;
	movs	r0, r2	@ scr, scr
@ C_Code.c:564:                 frames += ANINS_WAIT_GET_DELAY(instruction);
	adds	r4, r3, r4	@ <retval>, _15, <retval>
@ C_Code.c:565:                 break;
	b	.L136		@
.L139:
@ C_Code.c:561:         switch (ANINS_GET_TYPE(instruction))
	cmp	r6, #6	@ _14,
	bne	.L131		@,
@ C_Code.c:570:                 frames += ANINS_FRAME_GET_DELAY(instruction);
	lsls	r3, r3, #16	@ tmp154, instruction,
	lsrs	r3, r3, #16	@ _22, tmp154,
@ C_Code.c:570:                 frames += ANINS_FRAME_GET_DELAY(instruction);
	adds	r4, r3, r4	@ <retval>, _22, <retval>
@ C_Code.c:571:                 scr += 2;
	adds	r0, r0, #12	@ scr,
@ C_Code.c:572:                 break;
	b	.L136		@
.L131:
@ C_Code.c:540:         return -1;
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
.L130:
@ C_Code.c:602: }
	movs	r0, r4	@, <retval>
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
.L138:
@ C_Code.c:574:                 switch (ANINS_COMMAND_GET_ID(instruction))
	movs	r0, #255	@ tmp155,
	ands	r3, r0	@ _25, tmp155
@ C_Code.c:574:                 switch (ANINS_COMMAND_GET_ID(instruction))
	cmp	r3, #26	@ _25,
	bhi	.L143		@,
	ldr	r0, .L156	@ tmp159,
	lsls	r3, r3, #2	@ tmp157, _25,
	ldr	r3, [r0, r3]	@ tmp160,
	mov	pc, r3	@ tmp160
	.section	.rodata
	.align	2
.L145:
	.word	.L143
	.word	.L131
	.word	.L143
	.word	.L143
	.word	.L147
	.word	.L146
	.word	.L143
	.word	.L143
	.word	.L130
	.word	.L130
	.word	.L130
	.word	.L130
	.word	.L130
	.word	.L143
	.word	.L143
	.word	.L143
	.word	.L143
	.word	.L143
	.word	.L143
	.word	.L143
	.word	.L143
	.word	.L143
	.word	.L143
	.word	.L143
	.word	.L143
	.word	.L143
	.word	.L130
	.text
.L140:
@ C_Code.c:567:                 frames += ANINS_MOVE_GET_DELAY(instruction);
	lsls	r3, r3, #8	@ tmp151, instruction,
	lsrs	r3, r3, #24	@ _19, tmp151,
@ C_Code.c:547:         u32 instruction = *scr++;
	movs	r0, r2	@ scr, scr
@ C_Code.c:567:                 frames += ANINS_MOVE_GET_DELAY(instruction);
	adds	r4, r3, r4	@ <retval>, _19, <retval>
@ C_Code.c:568:                 break;
	b	.L136		@
.L147:
@ C_Code.c:584:                         if (isMiss)
	ldr	r3, [sp, #4]	@ iftmp.15_32, %sfp
	cmp	r3, #0	@ iftmp.15_32,
	bne	.L130		@,
.L143:
@ C_Code.c:547:         u32 instruction = *scr++;
	movs	r0, r2	@ scr, scr
@ C_Code.c:595:                 frames += 1;
	adds	r4, r4, #1	@ <retval>,
@ C_Code.c:596:                 break;
	b	.L136		@
.L150:
@ C_Code.c:542:     int isMiss = proc->currentRound && (proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS);
	str	r2, [sp, #4]	@ iftmp.15_32, %sfp
	b	.L134		@
.L146:
@ C_Code.c:590:                         *isCast = true;
	movs	r3, #1	@ tmp161,
	mov	r2, fp	@ isCast, isCast
	str	r3, [r2]	@ tmp161, *isCast_42(D)
@ C_Code.c:591:                         return frames;
	b	.L130		@
.L157:
	.align	2
.L156:
	.word	.L145
	.size	GetFramesUntilHit, .-GetFramesUntilHit
	.align	1
	.p2align 2,,3
	.global	SaveInputFrameReadAhead
	.syntax unified
	.code	16
	.thumb_func
	.type	SaveInputFrameReadAhead, %function
SaveInputFrameReadAhead:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
@ C_Code.c:606:     int isCast = false;
	movs	r3, #0	@ tmp120,
@ C_Code.c:605: {
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #12	@,,
@ C_Code.c:605: {
	movs	r7, r1	@ keys, keys
@ C_Code.c:607:     int untilHit = GetFramesUntilHit(proc, &isCast);
	add	r1, sp, #4	@,,
@ C_Code.c:605: {
	movs	r4, r0	@ proc, proc
@ C_Code.c:606:     int isCast = false;
	str	r3, [sp, #4]	@ tmp120, isCast
@ C_Code.c:607:     int untilHit = GetFramesUntilHit(proc, &isCast);
	bl	GetFramesUntilHit		@
@ C_Code.c:647:     int hadPress = proc->frame != 0;
	movs	r3, #76	@ tmp122,
	ldrh	r5, [r4, r3]	@ pretmp_84,
@ C_Code.c:612:             proc->readAhead |= READAHEAD_CAST;
	adds	r3, r3, #10	@ tmp123,
	ldrb	r3, [r4, r3]	@ prephitmp_61,
@ C_Code.c:608:     if (untilHit >= 0)
	cmp	r0, #0	@ untilHit,
	blt	.L159		@,
@ C_Code.c:610:         if (isCast)
	ldr	r2, [sp, #4]	@ isCast, isCast
	cmp	r2, #0	@ isCast,
	beq	.L160		@,
@ C_Code.c:612:             proc->readAhead |= READAHEAD_CAST;
	movs	r2, #8	@ tmp128,
	orrs	r3, r2	@ prephitmp_61, tmp128
.L160:
@ C_Code.c:614:         if (!(proc->readAhead & READAHEAD_FOUND))
	lsls	r2, r3, #31	@ tmp218, prephitmp_61,
	bpl	.L191		@,
.L161:
@ C_Code.c:637:         if (!(proc->readAhead & READAHEAD_PASSED) && untilHit < LenienceFrames)
	lsls	r2, r3, #27	@ tmp221, prephitmp_61,
	bmi	.L164		@,
@ C_Code.c:637:         if (!(proc->readAhead & READAHEAD_PASSED) && untilHit < LenienceFrames)
	ldr	r2, .L194	@ tmp174,
@ C_Code.c:637:         if (!(proc->readAhead & READAHEAD_PASSED) && untilHit < LenienceFrames)
	ldr	r2, [r2]	@ LenienceFrames, LenienceFrames
	cmp	r2, r0	@ LenienceFrames, untilHit
	bgt	.L192		@,
.L164:
@ C_Code.c:643:             proc->readAhead &= ~READAHEAD_WINDOW_OPEN;
	movs	r2, #2	@ tmp182,
	bics	r3, r2	@ tmp181, tmp182
	adds	r2, r2, #84	@ tmp183,
	strb	r3, [r4, r2]	@ tmp181, proc_30(D)->readAhead
.L163:
@ C_Code.c:648:     SaveInputFrame(proc, keys);
	movs	r1, r7	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
@ C_Code.c:649:     if ((proc->readAhead & READAHEAD_FOUND) && !hadPress && proc->frame)
	movs	r2, #86	@ tmp185,
	ldrb	r3, [r4, r2]	@ _20,
@ C_Code.c:649:     if ((proc->readAhead & READAHEAD_FOUND) && !hadPress && proc->frame)
	cmp	r5, #0	@ pretmp_84,
	bne	.L158		@,
	lsls	r1, r3, #31	@ tmp222, _20,
	bmi	.L193		@,
.L158:
@ C_Code.c:656: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L191:
@ C_Code.c:616:             proc->readAhead |= READAHEAD_FOUND;
	movs	r2, #1	@ tmp129,
	orrs	r2, r3	@ tmp138, prephitmp_61
	lsls	r2, r2, #24	@ tmp139, tmp138,
@ C_Code.c:617:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	cmp	r5, #0	@ pretmp_84,
	beq	.L162		@,
@ C_Code.c:617:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	ldr	r1, [r4, #52]	@ proc_30(D)->timer, proc_30(D)->timer
@ C_Code.c:617:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	ldr	r6, .L194	@ tmp143,
@ C_Code.c:617:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	subs	r1, r1, r5	@ _9, proc_30(D)->timer, pretmp_84
@ C_Code.c:617:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	ldr	r6, [r6]	@ LenienceFrames, LenienceFrames
@ C_Code.c:617:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	adds	r1, r1, r0	@ _10, _9, untilHit
@ C_Code.c:617:             if (proc->frame && ((proc->timer - proc->frame) + untilHit >= LenienceFrames))
	cmp	r1, r6	@ _10, LenienceFrames
	blt	.L162		@,
@ C_Code.c:619:                 proc->readAhead |= READAHEAD_BAD_PRESS;
	movs	r2, #5	@ tmp148,
	orrs	r3, r2	@ prephitmp_61, tmp148
	b	.L161		@
.L162:
@ C_Code.c:631:             untilHit = 0; // already past the hit command
	lsrs	r3, r2, #24	@ prephitmp_61, tmp139,
	b	.L161		@
.L159:
@ C_Code.c:623:     else if (proc->readAhead & READAHEAD_FOUND)
	lsls	r2, r3, #31	@ tmp219, prephitmp_61,
	bpl	.L163		@,
@ C_Code.c:625:         if (proc->readAhead & READAHEAD_CAST)
	lsls	r2, r3, #28	@ tmp220, prephitmp_61,
	bpl	.L167		@,
@ C_Code.c:627:             proc->readAhead |= READAHEAD_PASSED; // the spell has started
	movs	r2, #16	@ tmp166,
	orrs	r3, r2	@ prephitmp_61, tmp166
	b	.L164		@
.L193:
@ C_Code.c:649:     if ((proc->readAhead & READAHEAD_FOUND) && !hadPress && proc->frame)
	movs	r1, #76	@ tmp199,
@ C_Code.c:649:     if ((proc->readAhead & READAHEAD_FOUND) && !hadPress && proc->frame)
	ldrh	r1, [r4, r1]	@ tmp200,
	cmp	r1, #0	@ tmp200,
	beq	.L158		@,
@ C_Code.c:651:         if (!(proc->readAhead & READAHEAD_WINDOW_OPEN))
	lsls	r1, r3, #30	@ tmp223, _20,
	bmi	.L158		@,
@ C_Code.c:653:             proc->readAhead |= READAHEAD_BAD_PRESS;
	movs	r1, #4	@ tmp208,
	orrs	r3, r1	@ tmp210, tmp208
	strb	r3, [r4, r2]	@ tmp210, proc_30(D)->readAhead
@ C_Code.c:656: }
	b	.L158		@
.L192:
@ C_Code.c:639:             proc->readAhead |= READAHEAD_WINDOW_OPEN;
	movs	r2, #2	@ tmp176,
	orrs	r3, r2	@ tmp178, tmp176
	movs	r2, #86	@ tmp179,
	strb	r3, [r4, r2]	@ tmp178, proc_30(D)->readAhead
	b	.L163		@
.L167:
@ C_Code.c:631:             untilHit = 0; // already past the hit command
	movs	r0, #0	@ untilHit,
	b	.L161		@
.L195:
	.align	2
.L194:
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
@ C_Code.c:660:     if (proc->readAhead & READAHEAD_FOUND)
	movs	r3, #86	@ tmp103,
@ C_Code.c:662:         if (proc->frame && !(proc->readAhead & READAHEAD_BAD_PRESS))
	movs	r2, #76	@ tmp104,
@ C_Code.c:660:     if (proc->readAhead & READAHEAD_FOUND)
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:662:         if (proc->frame && !(proc->readAhead & READAHEAD_BAD_PRESS))
	ldrh	r2, [r0, r2]	@ pretmp_15,
@ C_Code.c:660:     if (proc->readAhead & READAHEAD_FOUND)
	lsls	r1, r3, #31	@ tmp127, _1,
	bmi	.L207		@,
@ C_Code.c:668:     if (proc->frame)
	cmp	r2, #0	@ pretmp_15,
	beq	.L196		@,
@ C_Code.c:684:         if ((proc->timer - proc->frame) < LenienceFrames)
	ldr	r3, [r0, #52]	@ proc_6(D)->timer, proc_6(D)->timer
	subs	r3, r3, r2	@ _13, proc_6(D)->timer, pretmp_15
@ C_Code.c:684:         if ((proc->timer - proc->frame) < LenienceFrames)
	ldr	r2, .L208	@ tmp124,
@ C_Code.c:684:         if ((proc->timer - proc->frame) < LenienceFrames)
	ldr	r2, [r2]	@ LenienceFrames, LenienceFrames
	cmp	r3, r2	@ _13, LenienceFrames
	bge	.L196		@,
.L199:
@ C_Code.c:664:             proc->hitOnTime = true;
	movs	r3, #69	@ tmp119,
	movs	r2, #1	@ tmp120,
	strb	r2, [r0, r3]	@ tmp120, proc_6(D)->hitOnTime
.L196:
@ C_Code.c:689: }
	@ sp needed	@
	bx	lr
.L207:
@ C_Code.c:662:         if (proc->frame && !(proc->readAhead & READAHEAD_BAD_PRESS))
	cmp	r2, #0	@ pretmp_15,
	beq	.L196		@,
@ C_Code.c:662:         if (proc->frame && !(proc->readAhead & READAHEAD_BAD_PRESS))
	lsls	r3, r3, #29	@ tmp128, _1,
	bmi	.L196		@,
	b	.L199		@
.L209:
	.align	2
.L208:
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
@ C_Code.c:693:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L211	@ tmp98,
@ C_Code.c:694: }
	@ sp needed	@
@ C_Code.c:693:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldrb	r0, [r3, #31]	@ tmp100,
	movs	r3, #127	@ tmp102,
	bics	r0, r3	@ _3, tmp102
@ C_Code.c:694: }
	bx	lr
.L212:
	.align	2
.L211:
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
@ C_Code.c:693:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L217	@ tmp100,
@ C_Code.c:698:     if (CheatCodeOn())
	ldrb	r3, [r3, #31]	@ tmp101,
	cmp	r3, #127	@ tmp101,
	bhi	.L216		@,
@ C_Code.c:702:     if (AlwaysWork)
	ldr	r3, .L217+4	@ tmp102,
@ C_Code.c:702:     if (AlwaysWork)
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L216		@,
@ C_Code.c:706:     return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp104,
	ldrb	r0, [r0, r3]	@ <retval>,
	b	.L213		@
.L216:
@ C_Code.c:700:         return true;
	movs	r0, #1	@ <retval>,
.L213:
@ C_Code.c:707: }
	@ sp needed	@
	bx	lr
.L218:
	.align	2
.L217:
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
@ C_Code.c:711:     if (proc->readAhead & READAHEAD_FOUND)
	movs	r2, #86	@ tmp107,
@ C_Code.c:711:     if (proc->readAhead & READAHEAD_FOUND)
	ldrb	r2, [r0, r2]	@ tmp111,
@ C_Code.c:710: {
	movs	r3, r0	@ proc, proc
@ C_Code.c:711:     if (proc->readAhead & READAHEAD_FOUND)
	lsls	r2, r2, #31	@ tmp133, tmp111,
	bmi	.L222		@,
@ C_Code.c:715:     if (!proc->frame)
	movs	r2, #76	@ tmp117,
	ldrh	r2, [r0, r2]	@ _7,
@ C_Code.c:715:     if (!proc->frame)
	cmp	r2, #0	@ _7,
	beq	.L222		@,
@ C_Code.c:693:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r1, .L226	@ tmp118,
@ C_Code.c:698:     if (CheatCodeOn())
	ldrb	r1, [r1, #31]	@ tmp119,
	cmp	r1, #127	@ tmp119,
	bhi	.L222		@,
@ C_Code.c:702:     if (AlwaysWork)
	ldr	r1, .L226+4	@ tmp120,
	ldr	r0, [r1]	@ <retval>, AlwaysWork
@ C_Code.c:702:     if (AlwaysWork)
	cmp	r0, #0	@ <retval>,
	bne	.L222		@,
@ C_Code.c:706:     return proc->hitOnTime;
	movs	r1, #69	@ tmp121,
@ C_Code.c:719:     if (DidWeHitOnTime(proc))
	ldrb	r1, [r3, r1]	@ tmp122,
	cmp	r1, #0	@ tmp122,
	bne	.L219		@,
@ C_Code.c:723:     return (proc->timer - proc->frame) >= LenienceFrames;
	ldr	r3, [r3, #52]	@ proc_5(D)->timer, proc_5(D)->timer
	subs	r3, r3, r2	@ _11, proc_5(D)->timer, _7
@ C_Code.c:723:     return (proc->timer - proc->frame) >= LenienceFrames;
	ldr	r2, .L226+8	@ tmp125,
	ldr	r2, [r2]	@ LenienceFrames, LenienceFrames
	asrs	r0, r3, #31	@ tmp129, _11,
	lsrs	r1, r2, #31	@ tmp130, LenienceFrames,
	cmp	r3, r2	@ _11, LenienceFrames
	adcs	r0, r0, r1	@ <retval>, tmp129, tmp130
	b	.L219		@
.L222:
@ C_Code.c:713:         return false;
	movs	r0, #0	@ <retval>,
.L219:
@ C_Code.c:724: }
	@ sp needed	@
	bx	lr
.L227:
	.align	2
.L226:
	.word	gPlaySt
	.word	AlwaysWork
	.word	LenienceFrames
	.size	PressedTooEarly, .-PressedTooEarly
	.align	1
	.p2align 2,,3
	.global	SetPressImage
	.syntax unified
	.code	16
	.thumb_func
	.type	SetPressImage, %function
SetPressImage:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ C_Code.c:729:     if (proc->pressImg != img)
	movs	r5, #87	@ tmp100,
	ldrb	r3, [r0, r5]	@ _2,
@ C_Code.c:727: {
	movs	r6, r0	@ proc, proc
	movs	r4, r1	@ img, img
@ C_Code.c:729:     if (proc->pressImg != img)
	cmp	r3, r1	@ _2, img
	beq	.L228		@,
@ C_Code.c:731:         Copy2dChr(images[img], (void *)0x06012980, 6, 2);
	ldr	r3, .L230	@ tmp103,
	lsls	r2, r1, #2	@ tmp104, img,
	adds	r3, r3, r2	@ tmp105, tmp103, tmp104
@ C_Code.c:731:         Copy2dChr(images[img], (void *)0x06012980, 6, 2);
	ldr	r0, [r3, #40]	@ images[img_5(D)], images[img_5(D)]
	movs	r2, #6	@,
	movs	r3, #2	@,
	ldr	r1, .L230+4	@,
	ldr	r7, .L230+8	@ tmp108,
	bl	.L232		@
@ C_Code.c:732:         proc->pressImg = img;
	strb	r4, [r6, r5]	@ img, proc_4(D)->pressImg
.L228:
@ C_Code.c:734: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L231:
	.align	2
.L230:
	.word	.LANCHOR0
	.word	100739456
	.word	Copy2dChr
	.size	SetPressImage, .-SetPressImage
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
	mov	r7, r8	@,
	mov	lr, r9	@,
	push	{r7, lr}	@
	mov	r8, r2	@ y, y
@ C_Code.c:738:     if (!DisplayPress)
	ldr	r2, .L311	@ tmp165,
@ C_Code.c:738:     if (!DisplayPress)
	ldr	r2, [r2]	@ DisplayPress, DisplayPress
@ C_Code.c:737: {
	sub	sp, sp, #20	@,,
@ C_Code.c:737: {
	movs	r6, r0	@ proc, proc
	movs	r5, r3	@ palID, palID
	str	r1, [sp, #8]	@ x, %sfp
@ C_Code.c:738:     if (!DisplayPress)
	cmp	r2, #0	@ DisplayPress,
	beq	.L233		@,
@ C_Code.c:711:     if (proc->readAhead & READAHEAD_FOUND)
	movs	r3, #86	@ tmp167,
@ C_Code.c:711:     if (proc->readAhead & READAHEAD_FOUND)
	ldrb	r2, [r0, r3]	@ tmp171,
	lsls	r2, r2, #31	@ tmp330, tmp171,
	bmi	.L235		@,
@ C_Code.c:715:     if (!proc->frame)
	subs	r3, r3, #10	@ tmp177,
	ldrh	r3, [r0, r3]	@ _14,
@ C_Code.c:715:     if (!proc->frame)
	cmp	r3, #0	@ _14,
	beq	.L235		@,
@ C_Code.c:693:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r2, .L311+4	@ tmp178,
@ C_Code.c:698:     if (CheatCodeOn())
	ldrb	r2, [r2, #31]	@ tmp179,
	cmp	r2, #127	@ tmp179,
	bhi	.L235		@,
@ C_Code.c:702:     if (AlwaysWork)
	ldr	r2, .L311+8	@ tmp180,
@ C_Code.c:702:     if (AlwaysWork)
	ldr	r2, [r2]	@ AlwaysWork, AlwaysWork
	cmp	r2, #0	@ AlwaysWork,
	bne	.L235		@,
@ C_Code.c:706:     return proc->hitOnTime;
	adds	r2, r2, #69	@ tmp182,
@ C_Code.c:719:     if (DidWeHitOnTime(proc))
	ldrb	r2, [r0, r2]	@ tmp183,
	cmp	r2, #0	@ tmp183,
	bne	.L235		@,
@ C_Code.c:723:     return (proc->timer - proc->frame) >= LenienceFrames;
	ldr	r2, [r0, #52]	@ proc_6(D)->timer, proc_6(D)->timer
	subs	r3, r2, r3	@ _18, proc_6(D)->timer, _14
@ C_Code.c:723:     return (proc->timer - proc->frame) >= LenienceFrames;
	ldr	r2, .L311+12	@ tmp186,
@ C_Code.c:742:     if (PressedTooEarly(proc))
	ldr	r2, [r2]	@ LenienceFrames, LenienceFrames
	cmp	r3, r2	@ _18, LenienceFrames
	blt	.L235		@,
.L233:
@ C_Code.c:829: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r6, r7}
	mov	r9, r7
	mov	r8, r6
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L235:
@ C_Code.c:746:     int keys = GetButtonsToPress(proc);
	movs	r0, r6	@, proc
	bl	GetButtonsToPress		@
@ C_Code.c:729:     if (proc->pressImg != img)
	movs	r2, #87	@ tmp341,
@ C_Code.c:748:     if (proc->readAhead & READAHEAD_FOUND)
	movs	r3, #86	@ tmp188,
@ C_Code.c:729:     if (proc->pressImg != img)
	ldrb	r1, [r6, r2]	@ pretmp_112,
@ C_Code.c:748:     if (proc->readAhead & READAHEAD_FOUND)
	subs	r2, r2, #86	@ tmp193,
@ C_Code.c:746:     int keys = GetButtonsToPress(proc);
	movs	r4, r0	@ keys,
@ C_Code.c:748:     if (proc->readAhead & READAHEAD_FOUND)
	movs	r0, r2	@ tmp195, tmp193
@ C_Code.c:748:     if (proc->readAhead & READAHEAD_FOUND)
	ldrb	r3, [r6, r3]	@ _32,
@ C_Code.c:748:     if (proc->readAhead & READAHEAD_FOUND)
	ands	r0, r3	@ tmp195, _32
	mov	r9, r0	@ tmp195, tmp195
	tst	r2, r3	@ tmp193, _32
	bne	.L303		@,
@ C_Code.c:729:     if (proc->pressImg != img)
	cmp	r1, #0	@ pretmp_112,
	beq	.L244		@,
@ C_Code.c:731:         Copy2dChr(images[img], (void *)0x06012980, 6, 2);
	movs	r3, #2	@,
	movs	r2, #6	@,
	ldr	r0, .L311+16	@ tmp237,
	ldr	r1, .L311+20	@,
	ldr	r7, .L311+24	@ tmp238,
	bl	.L232		@
@ C_Code.c:732:         proc->pressImg = img;
	movs	r3, #87	@ tmp354,
	mov	r2, r9	@ tmp195, tmp195
	strb	r2, [r6, r3]	@ tmp195, proc_6(D)->pressImg
.L244:
@ C_Code.c:772:         if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldr	r3, .L311+28	@ tmp242,
@ C_Code.c:772:         if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldr	r3, [r3]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
	cmp	r3, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L246		@,
@ C_Code.c:772:         if (ChangePaletteWhenButtonIsPressed && proc->frame)
	movs	r3, #76	@ tmp246,
@ C_Code.c:772:         if (ChangePaletteWhenButtonIsPressed && proc->frame)
	ldrh	r3, [r6, r3]	@ tmp247,
	cmp	r3, #0	@ tmp247,
	beq	.LCB1500	@
	b	.L304	@long jump	@
.LCB1500:
.L246:
@ C_Code.c:778:     int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); // OAM2_CHR(0);
	lsls	r5, r5, #28	@ tmp245, palID,
	lsrs	r3, r5, #16	@ prephitmp_24, tmp245,
	str	r3, [sp, #12]	@ prephitmp_24, %sfp
	ldr	r5, .L311+32	@ tmp317,
.L243:
@ C_Code.c:779:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2);
	mov	r7, r8	@ y, y
	movs	r6, #255	@ tmp248,
	movs	r3, r5	@ tmp250, tmp317
	ldr	r2, [sp, #8]	@ x, %sfp
	ldr	r0, [sp, #12]	@ prephitmp_24, %sfp
	ands	r6, r7	@ tmp248, y
	lsls	r1, r2, #23	@ tmp252, x,
	mov	r8, r6	@ _55, tmp248
	movs	r2, r6	@, _55
	str	r0, [sp]	@ prephitmp_24,
	ldr	r6, .L311+36	@ tmp318,
	movs	r0, #2	@,
	adds	r3, r3, #56	@ tmp250,
	lsrs	r1, r1, #23	@ _54, tmp252,
	bl	.L313		@
@ C_Code.c:781:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2);
	movs	r3, r5	@ tmp255, tmp317
@ C_Code.c:780:     x += 32;
	ldr	r1, [sp, #8]	@ x_56, %sfp
@ C_Code.c:781:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2);
	ldr	r0, [sp, #12]	@ prephitmp_24, %sfp
@ C_Code.c:780:     x += 32;
	adds	r1, r1, #32	@ x_56,
@ C_Code.c:781:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2);
	lsls	r1, r1, #23	@ tmp258, x_56,
	mov	r2, r8	@, _55
	str	r0, [sp]	@ prephitmp_24,
	adds	r3, r3, #64	@ tmp255,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _57, tmp258,
	bl	.L313		@
@ C_Code.c:782:     y += 16;
	adds	r7, r7, #16	@ y,
	movs	r3, r5	@ ivtmp.228, tmp317
	movs	r0, r5	@ _12, tmp317
@ C_Code.c:779:     PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2);
	mov	r9, r6	@ tmp318, tmp318
@ C_Code.c:782:     y += 16;
	mov	r8, r7	@ y, y
@ C_Code.c:464:     int c = 0;
	movs	r2, #0	@ c,
	adds	r3, r3, #32	@ ivtmp.228,
	adds	r0, r0, #38	@ _12,
.L248:
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ldrb	r1, [r3]	@ _13, MEM[(unsigned char *)_63]
@ C_Code.c:467:         if (keys & RomKeysList[i])
	ands	r1, r4	@ _114, keys
@ C_Code.c:469:             c++;
	subs	r6, r1, #1	@ tmp321, _114
	sbcs	r1, r1, r6	@ tmp320, _114, tmp321
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	adds	r3, r3, #1	@ ivtmp.228,
@ C_Code.c:469:             c++;
	adds	r2, r2, r1	@ c, c, tmp320
@ C_Code.c:465:     for (int i = 0; i < 6; ++i)
	cmp	r0, r3	@ _12, ivtmp.228
	bne	.L248		@,
@ C_Code.c:788:         x += 16;
	ldr	r6, [sp, #8]	@ x, %sfp
@ C_Code.c:786:     if (count == 1)
	cmp	r2, #1	@ c,
	beq	.L305		@,
@ C_Code.c:790:     if (count == 2)
	cmp	r2, #2	@ c,
	bne	.LCB1559	@
	b	.L251	@long jump	@
.LCB1559:
@ C_Code.c:783:     x -= 36;
	subs	r6, r6, #4	@ x,
.L250:
@ C_Code.c:799:     if (keys & A_BUTTON)
	lsls	r3, r4, #31	@ tmp332, keys,
	bmi	.L306		@,
.L252:
@ C_Code.c:804:     if (keys & B_BUTTON)
	lsls	r3, r4, #30	@ tmp333, keys,
	bmi	.L307		@,
.L253:
@ C_Code.c:809:     if (keys & DPAD_LEFT)
	lsls	r3, r4, #26	@ tmp334, keys,
	bmi	.L308		@,
.L254:
@ C_Code.c:814:     if (keys & DPAD_RIGHT)
	lsls	r3, r4, #27	@ tmp335, keys,
	bmi	.L309		@,
.L255:
@ C_Code.c:819:     if (keys & DPAD_UP)
	lsls	r3, r4, #25	@ tmp336, keys,
	bmi	.L310		@,
.L256:
@ C_Code.c:824:     if (keys & DPAD_DOWN)
	lsls	r4, r4, #24	@ tmp337, keys,
	bpl	.L233		@,
@ C_Code.c:826:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp312,
	movs	r3, r5	@ tmp317, tmp317
	ldr	r0, [sp, #12]	@ prephitmp_24, %sfp
	ands	r2, r1	@ _98, y
	lsls	r1, r6, #23	@ tmp315, x,
	str	r0, [sp]	@ prephitmp_24,
	adds	r3, r3, #112	@ tmp317,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _97, tmp315,
	bl	.L65		@
	b	.L233		@
.L303:
@ C_Code.c:752:         if ((proc->readAhead & READAHEAD_BAD_PRESS) || hitHappened ||
	movs	r0, #4	@ tmp206,
@ C_Code.c:751:         int hitHappened = proc->EkrEfxIsUnitHittedNowFrames != 0xFF; // after the hit we only draw this on a fail
	adds	r2, r2, #82	@ tmp197,
@ C_Code.c:751:         int hitHappened = proc->EkrEfxIsUnitHittedNowFrames != 0xFF; // after the hit we only draw this on a fail
	ldrb	r2, [r6, r2]	@ tmp199,
@ C_Code.c:752:         if ((proc->readAhead & READAHEAD_BAD_PRESS) || hitHappened ||
	ands	r0, r3	@ _38, _32
@ C_Code.c:751:         int hitHappened = proc->EkrEfxIsUnitHittedNowFrames != 0xFF; // after the hit we only draw this on a fail
	subs	r2, r2, #255	@ tmp201,
@ C_Code.c:752:         if ((proc->readAhead & READAHEAD_BAD_PRESS) || hitHappened ||
	orrs	r2, r0	@ _39, _38
@ C_Code.c:752:         if ((proc->readAhead & READAHEAD_BAD_PRESS) || hitHappened ||
	bne	.L237		@,
@ C_Code.c:753:             ((proc->readAhead & READAHEAD_PASSED) && !proc->frame))
	adds	r2, r2, #76	@ tmp212,
	ldrh	r2, [r6, r2]	@ pretmp_102,
@ C_Code.c:752:         if ((proc->readAhead & READAHEAD_BAD_PRESS) || hitHappened ||
	lsls	r0, r3, #27	@ tmp331, _32,
	bpl	.L238		@,
@ C_Code.c:753:             ((proc->readAhead & READAHEAD_PASSED) && !proc->frame))
	cmp	r2, #0	@ pretmp_102,
	beq	.L237		@,
.L239:
@ C_Code.c:759:             img = PRESS_SUCCESS;
	movs	r0, #2	@ img,
@ C_Code.c:757:         else if (proc->frame && ChangePaletteWhenButtonIsPressed)
	ldr	r2, .L311+28	@ tmp220,
	ldr	r2, [r2]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
@ C_Code.c:759:             img = PRESS_SUCCESS;
	str	r0, [sp, #12]	@ img, %sfp
@ C_Code.c:757:         else if (proc->frame && ChangePaletteWhenButtonIsPressed)
	cmp	r2, #0	@ ChangePaletteWhenButtonIsPressed,
	bne	.L240		@,
	b	.L241		@
.L305:
@ C_Code.c:788:         x += 16;
	adds	r6, r6, #12	@ x,
@ C_Code.c:799:     if (keys & A_BUTTON)
	lsls	r3, r4, #31	@ tmp332, keys,
	bpl	.L252		@,
.L306:
@ C_Code.c:801:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp267,
	movs	r3, r5	@ tmp266, tmp317
	ldr	r0, [sp, #12]	@ prephitmp_24, %sfp
	ands	r2, r1	@ _73, y
	lsls	r1, r6, #23	@ tmp270, x,
	str	r0, [sp]	@ prephitmp_24,
	adds	r3, r3, #72	@ tmp266,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _72, tmp270,
	bl	.L65		@
@ C_Code.c:802:         x += 18;
	adds	r6, r6, #18	@ x,
@ C_Code.c:804:     if (keys & B_BUTTON)
	lsls	r3, r4, #30	@ tmp333, keys,
	bpl	.L253		@,
.L307:
@ C_Code.c:806:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp276,
	movs	r3, r5	@ tmp275, tmp317
	ldr	r0, [sp, #12]	@ prephitmp_24, %sfp
	ands	r2, r1	@ _78, y
	lsls	r1, r6, #23	@ tmp279, x,
	str	r0, [sp]	@ prephitmp_24,
	adds	r3, r3, #80	@ tmp275,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _77, tmp279,
	bl	.L65		@
@ C_Code.c:807:         x += 18;
	adds	r6, r6, #18	@ x,
@ C_Code.c:809:     if (keys & DPAD_LEFT)
	lsls	r3, r4, #26	@ tmp334, keys,
	bpl	.L254		@,
.L308:
@ C_Code.c:811:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp285,
	movs	r3, r5	@ tmp284, tmp317
	ldr	r0, [sp, #12]	@ prephitmp_24, %sfp
	ands	r2, r1	@ _83, y
	lsls	r1, r6, #23	@ tmp288, x,
	str	r0, [sp]	@ prephitmp_24,
	adds	r3, r3, #88	@ tmp284,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _82, tmp288,
	bl	.L65		@
@ C_Code.c:812:         x += 18;
	adds	r6, r6, #18	@ x,
@ C_Code.c:814:     if (keys & DPAD_RIGHT)
	lsls	r3, r4, #27	@ tmp335, keys,
	bpl	.L255		@,
.L309:
@ C_Code.c:816:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp294,
	movs	r3, r5	@ tmp293, tmp317
	ldr	r0, [sp, #12]	@ prephitmp_24, %sfp
	ands	r2, r1	@ _88, y
	lsls	r1, r6, #23	@ tmp297, x,
	str	r0, [sp]	@ prephitmp_24,
	adds	r3, r3, #96	@ tmp293,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _87, tmp297,
	bl	.L65		@
@ C_Code.c:817:         x += 18;
	adds	r6, r6, #18	@ x,
@ C_Code.c:819:     if (keys & DPAD_UP)
	lsls	r3, r4, #25	@ tmp336, keys,
	bpl	.L256		@,
.L310:
@ C_Code.c:821:         PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2);
	mov	r1, r8	@ y, y
	movs	r2, #255	@ tmp303,
	movs	r3, r5	@ tmp302, tmp317
	ldr	r0, [sp, #12]	@ prephitmp_24, %sfp
	ands	r2, r1	@ _93, y
	lsls	r1, r6, #23	@ tmp306, x,
	str	r0, [sp]	@ prephitmp_24,
	adds	r3, r3, #104	@ tmp302,
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ _92, tmp306,
	bl	.L65		@
@ C_Code.c:822:         x += 18;
	adds	r6, r6, #18	@ x,
	b	.L256		@
.L237:
@ C_Code.c:755:             img = PRESS_FAIL;
	movs	r3, #3	@ img,
	str	r3, [sp, #12]	@ img, %sfp
.L240:
@ C_Code.c:729:     if (proc->pressImg != img)
	ldr	r3, [sp, #12]	@ img, %sfp
@ C_Code.c:731:         Copy2dChr(images[img], (void *)0x06012980, 6, 2);
	ldr	r5, .L311+32	@ tmp317,
@ C_Code.c:729:     if (proc->pressImg != img)
	cmp	r1, r3	@ pretmp_112, img
	beq	.L242		@,
@ C_Code.c:731:         Copy2dChr(images[img], (void *)0x06012980, 6, 2);
	ldr	r7, [sp, #12]	@ img, %sfp
	lsls	r3, r7, #2	@ tmp226, img,
	adds	r3, r5, r3	@ tmp227, tmp317, tmp226
@ C_Code.c:731:         Copy2dChr(images[img], (void *)0x06012980, 6, 2);
	ldr	r0, [r3, #40]	@ images[img_47], images[img_47]
	ldr	r7, .L311+24	@ tmp230,
	movs	r3, #2	@,
	movs	r2, #6	@,
	ldr	r1, .L311+20	@,
	bl	.L232		@
@ C_Code.c:732:         proc->pressImg = img;
	movs	r3, #87	@ tmp231,
	ldr	r7, [sp, #12]	@ img, %sfp
	strb	r7, [r6, r3]	@ img, proc_6(D)->pressImg
.L242:
@ C_Code.c:766:         ApplyPalette(gPal_Press_A_Image, 0x10 + PROMPT_PALETTE);
	movs	r1, #232	@,
	ldr	r3, .L311+40	@ tmp235,
	movs	r2, #32	@,
	ldr	r0, .L311+44	@ tmp234,
	lsls	r1, r1, #2	@,,
	bl	.L10		@
	movs	r3, #208	@ prephitmp_24,
	lsls	r3, r3, #8	@ prephitmp_24, prephitmp_24,
	str	r3, [sp, #12]	@ prephitmp_24, %sfp
	b	.L243		@
.L251:
@ C_Code.c:792:         x += 8;
	adds	r6, r6, #4	@ x,
	b	.L250		@
.L238:
@ C_Code.c:757:         else if (proc->frame && ChangePaletteWhenButtonIsPressed)
	cmp	r2, #0	@ pretmp_102,
	bne	.L239		@,
.L241:
@ C_Code.c:761:         else if (proc->readAhead & READAHEAD_WINDOW_OPEN)
	lsls	r3, r3, #30	@ tmp223, _32,
	lsrs	r3, r3, #31	@ img, tmp223,
	str	r3, [sp, #12]	@ img, %sfp
	b	.L240		@
.L304:
@ C_Code.c:772:         if (ChangePaletteWhenButtonIsPressed && proc->frame)
	movs	r3, #224	@ prephitmp_24,
	lsls	r3, r3, #8	@ prephitmp_24, prephitmp_24,
	str	r3, [sp, #12]	@ prephitmp_24, %sfp
	ldr	r5, .L311+32	@ tmp317,
	b	.L243		@
.L312:
	.align	2
.L311:
	.word	DisplayPress
	.word	gPlaySt
	.word	AlwaysWork
	.word	LenienceFrames
	.word	Press_Image
	.word	100739456
	.word	Copy2dChr
	.word	ChangePaletteWhenButtonIsPressed
	.word	.LANCHOR0
	.word	PutSprite
	.word	CopyToPaletteBuffer
	.word	gPal_Press_A_Image
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
@ C_Code.c:977:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r1, #11	@ _29,
	movs	r3, #192	@ tmp112,
	ldrsb	r1, [r0, r1]	@ _29,* _29
	ands	r3, r1	@ _30, _29
@ C_Code.c:954:     if (success)
	cmp	r2, #0	@ success,
	beq	.L315		@,
@ C_Code.c:956:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _30,
	beq	.L326		@,
@ C_Code.c:967:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L327	@ tmp116,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam.35_16, TimedHitsDifficultyRam
@ C_Code.c:967:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.35_16, *TimedHitsDifficultyRam.35_16
@ C_Code.c:967:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r2, r3, #26	@ tmp145, *TimedHitsDifficultyRam.35_16,
	bmi	.L319		@,
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r2, .L327+4	@ tmp126,
	ldr	r2, [r2]	@ DifficultyThreshold.37_21, DifficultyThreshold
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r3, r3, #27	@ tmp131, *TimedHitsDifficultyRam.35_16,
	lsrs	r3, r3, #27	@ _20, tmp131,
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r3, r2	@ _20, DifficultyThreshold.37_21
	bge	.L320		@,
@ C_Code.c:970:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r3, .L327+8	@ tmp134,
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r2, r3	@ DifficultyThreshold.37_21, NumberOfRandomButtons
	bgt	.L319		@,
.L320:
@ C_Code.c:972:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r2, .L327+12	@ tmp136,
	ldr	r3, .L327+16	@ tmp137,
	ldr	r0, [r2]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r3, [r3]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r0, r0, r3	@ <retval>, BonusDamagePercent, DifficultyBonusPercent
	b	.L314		@
.L315:
@ C_Code.c:977:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _30,
	beq	.L321		@,
@ C_Code.c:981:     return FailedHitDamagePercent;
	ldr	r3, .L327+20	@ tmp141,
	ldr	r0, [r3]	@ <retval>,
.L314:
@ C_Code.c:982: }
	@ sp needed	@
	bx	lr
.L326:
@ C_Code.c:958:             if (BlockingEnabled)
	ldr	r3, .L327+24	@ tmp113,
@ C_Code.c:958:             if (BlockingEnabled)
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L321		@,
@ C_Code.c:960:                 return ReducedDamagePercent;
	ldr	r3, .L327+28	@ tmp115,
	ldr	r0, [r3]	@ <retval>,
	b	.L314		@
.L321:
@ C_Code.c:964:                 return 100;
	movs	r0, #100	@ <retval>,
	b	.L314		@
.L319:
@ C_Code.c:975:         return BonusDamagePercent;
	ldr	r3, .L327+12	@ tmp140,
	ldr	r0, [r3]	@ <retval>,
	b	.L314		@
.L328:
	.align	2
.L327:
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
@ C_Code.c:977:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r1, #11	@ _11,
	movs	r3, #192	@ tmp112,
	ldrsb	r1, [r0, r1]	@ _11,* _11
	ands	r3, r1	@ _5, _11
@ C_Code.c:954:     if (success)
	cmp	r2, #0	@ success,
	beq	.L330		@,
@ C_Code.c:956:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _5,
	beq	.L341		@,
@ C_Code.c:967:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r3, .L342	@ tmp116,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam.35_17, TimedHitsDifficultyRam
@ C_Code.c:967:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.35_17, *TimedHitsDifficultyRam.35_17
@ C_Code.c:967:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r2, r3, #26	@ tmp145, *TimedHitsDifficultyRam.35_17,
	bmi	.L334		@,
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r2, .L342+4	@ tmp126,
	ldr	r2, [r2]	@ DifficultyThreshold.37_22, DifficultyThreshold
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r3, r3, #27	@ tmp131, *TimedHitsDifficultyRam.35_17,
	lsrs	r3, r3, #27	@ _21, tmp131,
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r3, r2	@ _21, DifficultyThreshold.37_22
	bge	.L335		@,
@ C_Code.c:970:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r3, .L342+8	@ tmp134,
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r3, [r3]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r2, r3	@ DifficultyThreshold.37_22, NumberOfRandomButtons
	bgt	.L334		@,
.L335:
@ C_Code.c:972:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r2, .L342+12	@ tmp136,
	ldr	r3, .L342+16	@ tmp137,
	ldr	r0, [r2]	@ BonusDamagePercent, BonusDamagePercent
	ldr	r3, [r3]	@ DifficultyBonusPercent, DifficultyBonusPercent
	adds	r0, r0, r3	@ <retval>, BonusDamagePercent, DifficultyBonusPercent
	b	.L329		@
.L330:
@ C_Code.c:977:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _5,
	beq	.L336		@,
@ C_Code.c:981:     return FailedHitDamagePercent;
	ldr	r3, .L342+20	@ tmp141,
	ldr	r0, [r3]	@ <retval>,
.L329:
@ C_Code.c:987: }
	@ sp needed	@
	bx	lr
.L341:
@ C_Code.c:958:             if (BlockingEnabled)
	ldr	r3, .L342+24	@ tmp113,
@ C_Code.c:958:             if (BlockingEnabled)
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L336		@,
@ C_Code.c:960:                 return ReducedDamagePercent;
	ldr	r3, .L342+28	@ tmp115,
	ldr	r0, [r3]	@ <retval>,
	b	.L329		@
.L336:
@ C_Code.c:964:                 return 100;
	movs	r0, #100	@ <retval>,
	b	.L329		@
.L334:
@ C_Code.c:975:         return BonusDamagePercent;
	ldr	r3, .L342+12	@ tmp140,
	ldr	r0, [r3]	@ <retval>,
	b	.L329		@
.L343:
	.align	2
.L342:
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
@ C_Code.c:1002:     for (int i = id; i < 22; i += 2)
	cmp	r0, #21	@ id,
	bgt	.L344		@,
	ldr	r3, .L352	@ tmp108,
	lsls	r2, r0, #1	@ _13, id,
@ C_Code.c:1005:         if (hp == 0xffff)
	ldr	r5, .L352+4	@ tmp109,
	adds	r2, r2, r3	@ ivtmp.243, _13, tmp108
	b	.L350		@
.L346:
@ C_Code.c:1021:         else if (hp >= difference)
	cmp	r3, r1	@ _1, difference
	blt	.L349		@,
@ C_Code.c:1023:             gEfxHpLut[i] -= difference;
	subs	r4, r3, r1	@ _4, _1, difference
.L348:
@ C_Code.c:1002:     for (int i = id; i < 22; i += 2)
	adds	r0, r0, #2	@ id,
@ C_Code.c:1018:                 gEfxHpLut[i] = 0;
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:1002:     for (int i = id; i < 22; i += 2)
	adds	r2, r2, #4	@ ivtmp.243,
	cmp	r0, #21	@ id,
	bgt	.L344		@,
.L350:
@ C_Code.c:1004:         hp = gEfxHpLut[i];
	ldrh	r3, [r2]	@ _1, MEM[(short unsigned int *)_18]
@ C_Code.c:1005:         if (hp == 0xffff)
	cmp	r3, r5	@ _1, tmp109
	beq	.L344		@,
@ C_Code.c:1009:         if (difference < 0)
	cmp	r1, #0	@ difference,
	bge	.L346		@,
@ C_Code.c:1011:             hp += difference;
	adds	r3, r3, r1	@ hp, _1, difference
@ C_Code.c:1014:                 gEfxHpLut[i] = hp;
	subs	r4, r3, #0	@ _4, hp,
@ C_Code.c:1012:             if (hp > 0)
	bgt	.L348		@,
.L349:
@ C_Code.c:1000: {
	movs	r4, #0	@ _4,
@ C_Code.c:1002:     for (int i = id; i < 22; i += 2)
	adds	r0, r0, #2	@ id,
@ C_Code.c:1018:                 gEfxHpLut[i] = 0;
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:1002:     for (int i = id; i < 22; i += 2)
	adds	r2, r2, #4	@ ivtmp.243,
	cmp	r0, #21	@ id,
	ble	.L350		@,
.L344:
@ C_Code.c:1030: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L353:
	.align	2
.L352:
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
@ C_Code.c:1035: {
	mov	ip, r2	@ some_bunit, some_bunit
	movs	r6, r1	@ HpProc, HpProc
@ C_Code.c:1040:     if (newHp > 127)
	cmp	r3, #127	@ newHp,
	ble	.L355		@,
	movs	r3, #127	@ _12,
.L356:
@ C_Code.c:1044:     int hp = gEkrGaugeHp[side];
	ldr	r1, [sp, #16]	@ tmp146, side
	ldr	r2, .L364	@ tmp114,
	lsls	r1, r1, #1	@ tmp115, tmp146,
	ldrsh	r2, [r1, r2]	@ _1, gEkrGaugeHp
@ C_Code.c:1045:     some_bunit->unit.curHP = newHp;
	mov	r1, ip	@ some_bunit, some_bunit
	strb	r3, [r1, #19]	@ _12, some_bunit_21(D)->unit.curHP
@ C_Code.c:1046:     if (hp == newHp)
	cmp	r3, r2	@ _12, _1
	beq	.L354		@,
@ C_Code.c:1053:         diff = 0 - newDamage;
	ldr	r1, [sp, #20]	@ tmp149, newDamage
	rsbs	r1, r1, #0	@ diff, tmp149
	mov	ip, r1	@ diff, diff
@ C_Code.c:1051:     if (newDamage)
	ldr	r1, [sp, #20]	@ tmp150, newDamage
	cmp	r1, #0	@ tmp150,
	beq	.L361		@,
@ C_Code.c:1056:     if (proc->side == side)
	movs	r1, #74	@ tmp117,
@ C_Code.c:1056:     if (proc->side == side)
	ldr	r4, [sp, #16]	@ tmp152, side
@ C_Code.c:1056:     if (proc->side == side)
	ldrb	r1, [r0, r1]	@ _4,
@ C_Code.c:1056:     if (proc->side == side)
	cmp	r1, r4	@ _4, tmp152
	beq	.L362		@,
.L354:
@ C_Code.c:1075: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L355:
@ C_Code.c:1036:     if (newHp < 0)
	mvns	r2, r3	@ tmp134, newHp
	asrs	r2, r2, #31	@ tmp133, tmp134,
	ands	r3, r2	@ _12, tmp133
	b	.L356		@
.L361:
@ C_Code.c:1050:     int diff = newHp - hp;
	subs	r1, r3, r2	@ diff, _12, _1
	mov	ip, r1	@ diff, diff
@ C_Code.c:1056:     if (proc->side == side)
	movs	r1, #74	@ tmp117,
@ C_Code.c:1056:     if (proc->side == side)
	ldr	r4, [sp, #16]	@ tmp152, side
@ C_Code.c:1056:     if (proc->side == side)
	ldrb	r1, [r0, r1]	@ _4,
@ C_Code.c:1056:     if (proc->side == side)
	cmp	r1, r4	@ _4, tmp152
	bne	.L354		@,
.L362:
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	ldr	r1, [r0, #56]	@ pretmp_40, proc_26(D)->currentRound
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	mov	r0, ip	@ diff, diff
@ C_Code.c:1058:         HpProc->cur = hp;
	strh	r2, [r6, #46]	@ _1, HpProc_27(D)->cur
@ C_Code.c:1059:         if (UsingSkillSys)
	ldr	r2, .L364+4	@ tmp120,
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	asrs	r5, r0, #31	@ tmp142, diff,
@ C_Code.c:1059:         if (UsingSkillSys)
	ldr	r2, [r2]	@ UsingSkillSys.42_5, UsingSkillSys
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	adds	r0, r0, r5	@ _41, diff, tmp142
	eors	r0, r5	@ _41, tmp142
@ C_Code.c:1059:         if (UsingSkillSys)
	cmp	r2, #0	@ UsingSkillSys.42_5,
	beq	.L363		@,
	movs	r5, #80	@ tmp161,
	strh	r3, [r6, r5]	@ _12, HpProc_27(D)->post
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	strb	r0, [r1, #3]	@ _41, pretmp_40->hpChange
@ C_Code.c:1070:         if (UsingSkillSys == 2)
	cmp	r2, #2	@ UsingSkillSys.42_5,
	bne	.L354		@,
@ C_Code.c:1072:             proc->currentRound->overDmg = diff;
	mov	r3, ip	@ diff, diff
	strh	r3, [r1, #6]	@ diff, pretmp_40->overDmg
	b	.L354		@
.L363:
@ C_Code.c:1065:             HpProc->postHpAtkrSS = newHp >> 16;
	movs	r5, #82	@ tmp123,
	strh	r2, [r6, r5]	@ UsingSkillSys.42_5, HpProc_27(D)->postHpAtkrSS
	adds	r2, r2, #80	@ tmp126,
	strh	r3, [r6, r2]	@ _12, HpProc_27(D)->post
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	strb	r0, [r1, #3]	@ _41, pretmp_40->hpChange
	b	.L354		@
.L365:
	.align	2
.L364:
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
@ C_Code.c:1082: {
	movs	r6, r1	@ HpProc, HpProc
@ C_Code.c:1083:     int side = proc->side;
	movs	r1, #74	@ tmp172,
@ C_Code.c:1082: {
	mov	r8, r2	@ active_bunit, active_bunit
	ldr	r2, [sp, #36]	@ hp, hp
	movs	r4, r0	@ proc, proc
@ C_Code.c:1083:     int side = proc->side;
	ldrb	r7, [r0, r1]	@ _1,
@ C_Code.c:1085:     if (hp < 0)
	cmp	r2, #0	@ hp,
	bge	.L367		@,
@ C_Code.c:1087:         hp = gEkrGaugeHp[side];
	ldr	r2, .L410	@ tmp173,
	lsls	r1, r7, #1	@ tmp174, _1,
@ C_Code.c:1087:         hp = gEkrGaugeHp[side];
	ldrsh	r2, [r1, r2]	@ hp, gEkrGaugeHp
.L367:
@ C_Code.c:1089:     if (hp <= 0)
	cmp	r2, #0	@ hp,
	ble	.L405		@,
@ C_Code.c:1153:         HpProc->death = false;
	movs	r3, #41	@ tmp261,
	movs	r2, #0	@ tmp262,
	strb	r2, [r6, r3]	@ tmp262, HpProc_50(D)->death
.L379:
@ C_Code.c:1159:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	movs	r0, #11	@ _23,
@ C_Code.c:1159:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	ldr	r5, .L410+4	@ tmp264,
@ C_Code.c:1159:     struct Unit * unit = GetUnit(gBattleActor.unit.index);
	ldr	r4, .L410+8	@ tmp294,
	ldrsb	r0, [r5, r0]	@ _23,* _23
	bl	.L129		@
@ C_Code.c:1160:     if (UNIT_IS_VALID(unit))
	cmp	r0, #0	@ unit,
	beq	.L381		@,
@ C_Code.c:1160:     if (UNIT_IS_VALID(unit))
	ldr	r3, [r0]	@ unit_77->pCharacterData, unit_77->pCharacterData
	cmp	r3, #0	@ unit_77->pCharacterData,
	beq	.L381		@,
@ C_Code.c:1162:         gBattleActor.unit.exp = unit->exp;
	ldrb	r3, [r0, #9]	@ _25,
@ C_Code.c:1162:         gBattleActor.unit.exp = unit->exp;
	strb	r3, [r5, #9]	@ _25, gBattleActor.unit.exp
@ C_Code.c:1163:         gBattleActor.unit.level = unit->level;
	movs	r3, #8	@ _26,
	ldrsb	r3, [r0, r3]	@ _26,* _26
@ C_Code.c:1163:         gBattleActor.unit.level = unit->level;
	strb	r3, [r5, #8]	@ _26, gBattleActor.unit.level
.L381:
@ C_Code.c:1166:     unit = GetUnit(gBattleTarget.unit.index);
	movs	r0, #11	@ _28,
@ C_Code.c:1166:     unit = GetUnit(gBattleTarget.unit.index);
	ldr	r5, .L410+12	@ tmp272,
@ C_Code.c:1166:     unit = GetUnit(gBattleTarget.unit.index);
	ldrsb	r0, [r5, r0]	@ _28,* _28
	bl	.L129		@
@ C_Code.c:1167:     if (UNIT_IS_VALID(unit))
	cmp	r0, #0	@ unit,
	beq	.L382		@,
@ C_Code.c:1167:     if (UNIT_IS_VALID(unit))
	ldr	r3, [r0]	@ unit_81->pCharacterData, unit_81->pCharacterData
	cmp	r3, #0	@ unit_81->pCharacterData,
	beq	.L382		@,
@ C_Code.c:1169:         gBattleTarget.unit.exp = unit->exp;
	ldrb	r3, [r0, #9]	@ _30,
@ C_Code.c:1169:         gBattleTarget.unit.exp = unit->exp;
	strb	r3, [r5, #9]	@ _30, gBattleTarget.unit.exp
@ C_Code.c:1170:         gBattleTarget.unit.level = unit->level;
	movs	r3, #8	@ _31,
	ldrsb	r3, [r0, r3]	@ _31,* _31
@ C_Code.c:1170:         gBattleTarget.unit.level = unit->level;
	strb	r3, [r5, #8]	@ _31, gBattleTarget.unit.level
.L382:
@ C_Code.c:1177: }
	@ sp needed	@
@ C_Code.c:1174:     BattleApplyExpGains(); // update exp
	ldr	r3, .L410+16	@ tmp280,
	bl	.L10		@
@ C_Code.c:1175:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldr	r2, .L410+20	@ tmp283,
	ldr	r1, [r2]	@ gpEkrBattleUnitLeft, gpEkrBattleUnitLeft
	movs	r2, #110	@ tmp284,
@ C_Code.c:1175:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldr	r3, .L410+24	@ tmp281,
@ C_Code.c:1175:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	ldrsb	r1, [r1, r2]	@ tmp286,
@ C_Code.c:1175:     gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
	strh	r1, [r3]	@ tmp286, gBanimExpGain[0]
@ C_Code.c:1176:     gBanimExpGain[1] = gpEkrBattleUnitRight->expGain;
	ldr	r1, .L410+28	@ tmp289,
	ldr	r1, [r1]	@ gpEkrBattleUnitRight, gpEkrBattleUnitRight
	ldrsb	r2, [r1, r2]	@ tmp292,
@ C_Code.c:1176:     gBanimExpGain[1] = gpEkrBattleUnitRight->expGain;
	strh	r2, [r3, #2]	@ tmp292, gBanimExpGain[1]
@ C_Code.c:1177: }
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L405:
@ C_Code.c:1045:     some_bunit->unit.curHP = newHp;
	movs	r0, #0	@ tmp177,
@ C_Code.c:1044:     int hp = gEkrGaugeHp[side];
	ldr	r1, .L410	@ tmp293,
	lsls	r2, r7, #1	@ tmp176, _1,
	mov	r9, r1	@ tmp293, tmp293
	ldrsh	r1, [r1, r2]	@ _89, gEkrGaugeHp
@ C_Code.c:1045:     some_bunit->unit.curHP = newHp;
	strb	r0, [r3, #19]	@ tmp177, opp_bunit_52(D)->unit.curHP
@ C_Code.c:1044:     int hp = gEkrGaugeHp[side];
	subs	r2, r1, #0	@ hp, _89,
@ C_Code.c:1046:     if (hp == newHp)
	beq	.L369		@,
@ C_Code.c:1051:     if (newDamage)
	ldr	r3, [sp, #40]	@ tmp325, newDamage
	cmp	r3, #0	@ tmp325,
	beq	.L370		@,
@ C_Code.c:1053:         diff = 0 - newDamage;
	movs	r2, r3	@ hp, tmp325
.L370:
	rsbs	r3, r2, #0	@ diff, hp
	mov	r10, r3	@ diff, diff
@ C_Code.c:1059:         if (UsingSkillSys)
	ldr	r3, .L410+32	@ tmp180,
@ C_Code.c:1058:         HpProc->cur = hp;
	strh	r1, [r6, #46]	@ _89, HpProc_50(D)->cur
@ C_Code.c:1059:         if (UsingSkillSys)
	ldr	r3, [r3]	@ UsingSkillSys.42_96, UsingSkillSys
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	asrs	r1, r2, #31	@ tmp313, hp,
	adds	r2, r2, r1	@ _165, hp, tmp313
	eors	r2, r1	@ _165, tmp313
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	ldr	r1, [r4, #56]	@ pretmp_166, proc_46(D)->currentRound
@ C_Code.c:1059:         if (UsingSkillSys)
	cmp	r3, #0	@ UsingSkillSys.42_96,
	beq	.L406		@,
	movs	r0, #0	@ tmp186,
	movs	r5, #80	@ tmp342,
	strh	r0, [r6, r5]	@ tmp186, HpProc_50(D)->post
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r1, #3]	@ _165, pretmp_166->hpChange
@ C_Code.c:1070:         if (UsingSkillSys == 2)
	cmp	r3, #2	@ UsingSkillSys.42_96,
	bne	.L369		@,
@ C_Code.c:1072:             proc->currentRound->overDmg = diff;
	mov	r3, r10	@ diff, diff
	strh	r3, [r1, #6]	@ diff, pretmp_166->overDmg
.L369:
@ C_Code.c:1094:         proc->code4frame = NO_FRAME;
	movs	r5, #1	@ tmp191,
	movs	r3, #78	@ tmp190,
@ C_Code.c:1099:         HpProc->death = true;
	movs	r2, #1	@ tmp194,
@ C_Code.c:1094:         proc->code4frame = NO_FRAME;
	rsbs	r5, r5, #0	@ tmp191, tmp191
	strh	r5, [r4, r3]	@ tmp191, proc_46(D)->code4frame
@ C_Code.c:1099:         HpProc->death = true;
	subs	r3, r3, #37	@ tmp193,
	strb	r2, [r6, r3]	@ tmp194, HpProc_50(D)->death
@ C_Code.c:1110:         round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END;
	ldr	r3, [sp, #32]	@ tmp328, round
	ldrb	r3, [r3, #2]	@ tmp199,
	adds	r2, r2, #175	@ tmp196,
	orrs	r3, r2	@ tmp201, tmp196
	ldr	r2, [sp, #32]	@ tmp329, round
	strb	r3, [r2, #2]	@ tmp201,
@ C_Code.c:1112:         struct SkillSysBattleHit * nextRound = GetCurrentRound(proc->roundId + 1);
	movs	r3, #70	@ tmp330,
	ldrb	r0, [r4, r3]	@ _6,
@ C_Code.c:1112:         struct SkillSysBattleHit * nextRound = GetCurrentRound(proc->roundId + 1);
	ldr	r3, .L410+36	@ tmp206,
	adds	r0, r0, #1	@ _7,
	bl	.L10		@
@ C_Code.c:1113:         nextRound->info = BATTLE_HIT_INFO_END;
	movs	r3, #7	@ tmp212,
	ldrh	r2, [r0, #2]	@ MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_60 + 2B], MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_60 + 2B]
	ands	r3, r2	@ tmp211, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_60 + 2B]
	movs	r2, #128	@ tmp213,
	orrs	r3, r2	@ tmp216, tmp213
	strh	r3, [r0, #2]	@ tmp216, MEM <unsigned short> [(struct SkillSysBattleHit *)nextRound_60 + 2B]
@ C_Code.c:1117:         u16 * animRound = &GetAnimRoundData()[0];
	ldr	r3, .L410+40	@ tmp218,
	bl	.L10		@
@ C_Code.c:1118:         for (int i = proc->roundId; i < 32; ++i)
	movs	r3, #70	@ tmp331,
	ldrb	r3, [r4, r3]	@ i,
@ C_Code.c:1118:         for (int i = proc->roundId; i < 32; ++i)
	cmp	r3, #31	@ i,
	bgt	.L372		@,
@ C_Code.c:1120:             if (animRound[i] == 0xFFFF)
	ldr	r2, .L410+44	@ tmp221,
	mov	ip, r2	@ tmp221, tmp221
	b	.L373		@
.L407:
@ C_Code.c:1118:         for (int i = proc->roundId; i < 32; ++i)
	adds	r3, r3, #1	@ i,
@ C_Code.c:1124:             animRound[i] = 0xFFFF;
	strh	r5, [r0, r2]	@ tmp191, MEM[(u16 *)animRound_64 + _157 * 1]
@ C_Code.c:1118:         for (int i = proc->roundId; i < 32; ++i)
	cmp	r3, #32	@ i,
	beq	.L372		@,
.L373:
	lsls	r2, r3, #1	@ _157, i,
@ C_Code.c:1120:             if (animRound[i] == 0xFFFF)
	ldrh	r1, [r0, r2]	@ MEM[(u16 *)animRound_64 + _157 * 1], MEM[(u16 *)animRound_64 + _157 * 1]
	cmp	r1, ip	@ MEM[(u16 *)animRound_64 + _157 * 1], tmp221
	bne	.L407		@,
.L372:
@ C_Code.c:1131:         side = 1 ^ side;
	movs	r2, #1	@ tmp227,
@ C_Code.c:1132:         hp = gEkrGaugeHp[side];
	mov	r5, r9	@ tmp293, tmp293
@ C_Code.c:1131:         side = 1 ^ side;
	eors	r2, r7	@ side, _1
@ C_Code.c:1132:         hp = gEkrGaugeHp[side];
	lsls	r3, r2, #1	@ tmp229, side,
	ldrsh	r1, [r5, r3]	@ _15, gEkrGaugeHp
@ C_Code.c:1133:         if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL)
	ldr	r3, [sp, #32]	@ tmp334, round
	ldr	r0, [r3]	@ *round_57(D), *round_57(D)
@ C_Code.c:1132:         hp = gEkrGaugeHp[side];
	movs	r3, r1	@ _13, _15
@ C_Code.c:1133:         if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL)
	lsls	r0, r0, #23	@ tmp314, *round_57(D),
	bpl	.L374		@,
@ C_Code.c:1137:             int victimHp = gEkrGaugeHp[proc->side];
	movs	r3, #74	@ tmp238,
	ldrb	r3, [r4, r3]	@ _18,
@ C_Code.c:1137:             int victimHp = gEkrGaugeHp[proc->side];
	lsls	r3, r3, #1	@ tmp240, _18,
@ C_Code.c:1138:             if (drained > victimHp)
	ldrsh	r3, [r5, r3]	@ _14, gEkrGaugeHp
	ldr	r0, [sp, #40]	@ tmp336, newDamage
	cmp	r3, r0	@ _14, tmp336
	ble	.L375		@,
	movs	r3, r0	@ _14, tmp336
.L375:
@ C_Code.c:1143:             if (hp > active_bunit->unit.maxHP)
	mov	r0, r8	@ active_bunit, active_bunit
	ldrb	r0, [r0, #18]	@ _21,
@ C_Code.c:1143:             if (hp > active_bunit->unit.maxHP)
	adds	r3, r3, r1	@ _13, _14, _15
@ C_Code.c:1143:             if (hp > active_bunit->unit.maxHP)
	lsls	r0, r0, #24	@ _21, _21,
	asrs	r0, r0, #24	@ _21, _21,
@ C_Code.c:1143:             if (hp > active_bunit->unit.maxHP)
	cmp	r3, r0	@ _13, _21
	ble	.L374		@,
	movs	r3, r0	@ _13, _21
.L374:
@ C_Code.c:1040:     if (newHp > 127)
	cmp	r3, #127	@ _13,
	bgt	.L408		@,
@ C_Code.c:1036:     if (newHp < 0)
	mvns	r0, r3	@ tmp297, _13
	asrs	r0, r0, #31	@ tmp296, tmp297,
	ands	r3, r0	@ _104, tmp296
.L378:
@ C_Code.c:1045:     some_bunit->unit.curHP = newHp;
	mov	r0, r8	@ active_bunit, active_bunit
	strb	r3, [r0, #19]	@ _104, active_bunit_74(D)->unit.curHP
@ C_Code.c:1046:     if (hp == newHp)
	cmp	r1, r3	@ _15, _104
	bne	.LCB2364	@
	b	.L379	@long jump	@
.LCB2364:
@ C_Code.c:1056:     if (proc->side == side)
	movs	r0, #74	@ tmp245,
	ldrb	r0, [r4, r0]	@ _111,
@ C_Code.c:1056:     if (proc->side == side)
	cmp	r2, r0	@ side, _111
	beq	.LCB2368	@
	b	.L379	@long jump	@
.LCB2368:
@ C_Code.c:1059:         if (UsingSkillSys)
	ldr	r2, .L410+32	@ tmp248,
@ C_Code.c:1050:     int diff = newHp - hp;
	subs	r0, r3, r1	@ diff, _104, _15
@ C_Code.c:1058:         HpProc->cur = hp;
	strh	r1, [r6, #46]	@ _15, HpProc_50(D)->cur
@ C_Code.c:1059:         if (UsingSkillSys)
	ldr	r2, [r2]	@ UsingSkillSys.42_112, UsingSkillSys
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	asrs	r1, r0, #31	@ tmp315, diff,
	adds	r5, r0, r1	@ _161, diff, tmp315
	eors	r5, r1	@ _161, tmp315
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	ldr	r1, [r4, #56]	@ pretmp_163, proc_46(D)->currentRound
@ C_Code.c:1059:         if (UsingSkillSys)
	cmp	r2, #0	@ UsingSkillSys.42_112,
	beq	.L409		@,
	movs	r4, #80	@ tmp257,
	strh	r3, [r6, r4]	@ _104, HpProc_50(D)->post
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	strb	r5, [r1, #3]	@ _161, pretmp_163->hpChange
@ C_Code.c:1070:         if (UsingSkillSys == 2)
	cmp	r2, #2	@ UsingSkillSys.42_112,
	beq	.LCB2384	@
	b	.L379	@long jump	@
.LCB2384:
@ C_Code.c:1072:             proc->currentRound->overDmg = diff;
	strh	r0, [r1, #6]	@ diff, pretmp_163->overDmg
	b	.L379		@
.L408:
@ C_Code.c:1040:     if (newHp > 127)
	movs	r3, #127	@ _104,
	b	.L378		@
.L406:
	str	r3, [r6, #80]	@ UsingSkillSys.42_96, MEM <vector(2) short int> [(short int *)HpProc_50(D) + 80B]
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	strb	r2, [r1, #3]	@ _165, pretmp_166->hpChange
	b	.L369		@
.L409:
@ C_Code.c:1065:             HpProc->postHpAtkrSS = newHp >> 16;
	movs	r0, #82	@ tmp251,
	strh	r2, [r6, r0]	@ UsingSkillSys.42_112, HpProc_50(D)->postHpAtkrSS
	adds	r2, r2, #80	@ tmp254,
	strh	r3, [r6, r2]	@ _104, HpProc_50(D)->post
@ C_Code.c:1069:         proc->currentRound->hpChange = ABS(diff);
	strb	r5, [r1, #3]	@ _161, pretmp_163->hpChange
	b	.L379		@
.L411:
	.align	2
.L410:
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
@ C_Code.c:1184:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	ldr	r5, [r0, #56]	@ _1, proc_48(D)->currentRound
@ C_Code.c:1182: {
	mov	fp, r3	@ opp_bunit, opp_bunit
@ C_Code.c:1184:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	ldr	r3, [r5]	@ *_1, *_1
	lsls	r3, r3, #13	@ tmp144, *_1,
@ C_Code.c:1182: {
	mov	r9, r2	@ active_bunit, active_bunit
	movs	r4, r0	@ proc, proc
	mov	r10, r1	@ HpProc, HpProc
	sub	sp, sp, #36	@,,
@ C_Code.c:1184:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	lsrs	r2, r3, #13	@ _2, tmp144,
@ C_Code.c:1184:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	lsls	r3, r3, #17	@ tmp215, tmp144,
	bmi	.L412		@,
@ C_Code.c:1184:     if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
	movs	r3, #3	@ tmp147,
	ldrsb	r3, [r5, r3]	@ tmp147,
	cmp	r3, #0	@ tmp147,
	beq	.L412		@,
@ C_Code.c:1188:     if (round->hpChange <= 0)
	ldr	r3, [sp, #72]	@ tmp224, round
	ldrb	r3, [r3, #3]	@ _5,
	lsls	r3, r3, #24	@ _5, _5,
	asrs	r3, r3, #24	@ _5, _5,
	str	r3, [sp, #24]	@ _5, %sfp
@ C_Code.c:1188:     if (round->hpChange <= 0)
	cmp	r3, #0	@ _5,
	ble	.L412		@,
@ C_Code.c:1192:     int side = proc->side;
	movs	r3, #74	@ tmp148,
	ldrb	r3, [r0, r3]	@ side,
@ C_Code.c:1193:     int hp = gEkrGaugeHp[proc->side];
	lsls	r1, r3, #1	@ tmp150, side,
@ C_Code.c:1192:     int side = proc->side;
	str	r3, [sp, #16]	@ side, %sfp
@ C_Code.c:1193:     int hp = gEkrGaugeHp[proc->side];
	ldr	r3, .L449	@ tmp149,
@ C_Code.c:1193:     int hp = gEkrGaugeHp[proc->side];
	ldrsh	r3, [r1, r3]	@ hp, gEkrGaugeHp
	str	r3, [sp, #20]	@ hp, %sfp
@ C_Code.c:1194:     if (!hp)
	cmp	r3, #0	@ hp,
	bne	.LCB2469	@
	b	.L445	@long jump	@
.LCB2469:
@ C_Code.c:1212:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	movs	r3, #1	@ tmp159,
	ldr	r0, [sp, #16]	@ side, %sfp
@ C_Code.c:1212:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	ldr	r1, .L449+4	@ tmp154,
@ C_Code.c:1212:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	eors	r3, r0	@ _82, side
@ C_Code.c:1212:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	lsls	r3, r3, #1	@ tmp160, _82,
	ldrsh	r3, [r3, r1]	@ pretmp_83, gEkrGaugeDmg
@ C_Code.c:1204:     if (proc->currentRound->attributes & BATTLE_HIT_ATTR_CRIT)
	lsls	r2, r2, #31	@ tmp216, _2,
	bmi	.L446		@,
@ C_Code.c:1203:     int oldDamage = round->hpChange;
	ldr	r2, [sp, #24]	@ _5, %sfp
	movs	r7, r2	@ oldDamage, _5
@ C_Code.c:1212:     else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
	cmp	r2, r3	@ _5, pretmp_83
	bge	.L417		@,
@ C_Code.c:1214:         oldDamage = gEkrGaugeDmg[side ^ 1];
	movs	r7, r3	@ oldDamage, pretmp_83
.L417:
@ C_Code.c:1217:     if (UsingSkillSys == 2)
	ldr	r3, .L449+8	@ tmp169,
	ldr	r3, [r3]	@ UsingSkillSys.48_16, UsingSkillSys
	str	r3, [sp, #28]	@ UsingSkillSys.48_16, %sfp
@ C_Code.c:1217:     if (UsingSkillSys == 2)
	cmp	r3, #2	@ UsingSkillSys.48_16,
	bne	.L418		@,
@ C_Code.c:1219:         oldDamage = ABS(round->overDmg);
	ldr	r3, [sp, #72]	@ tmp243, round
	movs	r2, #6	@ tmp223,
	ldrsh	r3, [r3, r2]	@ tmp170, tmp243, tmp223
	asrs	r2, r3, #31	@ tmp217, tmp170,
	adds	r3, r3, r2	@ tmp171, tmp170, tmp217
	eors	r3, r2	@ tmp171, tmp217
@ C_Code.c:1219:         oldDamage = ABS(round->overDmg);
	lsls	r3, r3, #16	@ tmp172, tmp171,
	lsrs	r7, r3, #16	@ oldDamage, tmp172,
.L418:
@ C_Code.c:1223:     int newDamage = ((oldDamage * percent)) / 100;
	ldr	r3, [sp, #76]	@ tmp246, percent
	muls	r3, r7	@ _19, oldDamage
@ C_Code.c:1223:     int newDamage = ((oldDamage * percent)) / 100;
	movs	r1, #100	@,
	movs	r0, r3	@, _19
	ldr	r6, .L449+12	@ tmp176,
@ C_Code.c:1223:     int newDamage = ((oldDamage * percent)) / 100;
	mov	r8, r3	@ _19, _19
@ C_Code.c:1223:     int newDamage = ((oldDamage * percent)) / 100;
	bl	.L313		@
@ C_Code.c:1224:     if (newDamage >= oldDamage)
	cmp	r7, r0	@ oldDamage, newDamage_56
	bgt	.L419		@,
@ C_Code.c:1226:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	ldr	r3, .L449+16	@ tmp178,
	ldr	r0, [r3]	@ BonusDamageRounding, BonusDamageRounding
@ C_Code.c:1226:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	movs	r1, #100	@,
@ C_Code.c:1226:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	add	r0, r0, r8	@ _21, _19
@ C_Code.c:1226:         newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
	bl	.L313		@
.L420:
@ C_Code.c:1232:     if (newDamage <= 0)
	subs	r6, r0, #0	@ _7, newDamage,
	bgt	.L421		@,
	movs	r6, #1	@ _7,
.L421:
@ C_Code.c:1236:     int newHp = hp - newDamage;
	ldr	r3, [sp, #20]	@ hp, %sfp
@ C_Code.c:1237:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r1, #11	@ _27,
@ C_Code.c:1236:     int newHp = hp - newDamage;
	subs	r2, r3, r6	@ newHp, hp, _7
@ C_Code.c:1237:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	mov	r3, r9	@ active_bunit, active_bunit
	ldrsb	r1, [r3, r1]	@ _27,* _27
	movs	r3, #192	@ tmp196,
	ands	r3, r1	@ _28, _27
@ C_Code.c:1237:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _28,
	beq	.L447		@,
.L422:
@ C_Code.c:1256:     if (newHp <= 0)
	mvns	r3, r2	@ tmp207, newHp
	asrs	r3, r3, #31	@ tmp206, tmp207,
	ands	r2, r3	@ newHp, tmp206
@ C_Code.c:1261:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r3, [sp, #28]	@ UsingSkillSys.48_16, %sfp
@ C_Code.c:1256:     if (newHp <= 0)
	movs	r1, r2	@ _3, newHp
@ C_Code.c:1261:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r3, #0	@ UsingSkillSys.48_16,
	beq	.L428		@,
@ C_Code.c:1261:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, .L449+20	@ tmp202,
@ C_Code.c:1261:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, [r2]	@ ProcSkillsStackWithTimedHits, ProcSkillsStackWithTimedHits
@ C_Code.c:1261:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldrb	r3, [r5, #4]	@ pretmp_80,
@ C_Code.c:1261:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r2, #0	@ ProcSkillsStackWithTimedHits,
	beq	.L426		@,
@ C_Code.c:1261:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldr	r2, .L449+24	@ tmp204,
@ C_Code.c:1261:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	ldrb	r2, [r2, r3]	@ tmp205, SkillExceptionsTable
	cmp	r2, #0	@ tmp205,
	beq	.L428		@,
.L426:
@ C_Code.c:1261:     if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
	cmp	r3, #0	@ pretmp_80,
	beq	.L428		@,
@ C_Code.c:1266:         newHp = hp - round->hpChange;
	ldr	r3, [sp, #24]	@ _5, %sfp
@ C_Code.c:1265:         newDamage = round->hpChange; // actual oldDamage without choosing between displayed / round dmg
	movs	r6, r3	@ _7, _5
@ C_Code.c:1266:         newHp = hp - round->hpChange;
	ldr	r2, [sp, #20]	@ hp, %sfp
	subs	r1, r2, r3	@ _3, hp, _5
.L428:
@ C_Code.c:1270:     UpdateHP(proc, HpProc, opp_bunit, newHp, side, newDamage);
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
@ C_Code.c:1272:     CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, newHp, newDamage);
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
.L412:
@ C_Code.c:1273: }
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
.L446:
@ C_Code.c:1206:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	lsls	r2, r3, #1	@ tmp164, pretmp_83,
	adds	r3, r2, r3	@ oldDamage, tmp164, pretmp_83
@ C_Code.c:1206:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	ldr	r2, [sp, #24]	@ _5, %sfp
@ C_Code.c:1206:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	movs	r7, r3	@ oldDamage, oldDamage
@ C_Code.c:1206:         if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
	cmp	r3, r2	@ oldDamage, _5
	bge	.L417		@,
	movs	r7, r2	@ oldDamage, _5
	b	.L417		@
.L419:
@ C_Code.c:1230:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	ldr	r3, .L449+28	@ tmp185,
	ldr	r0, [r3]	@ ReducedDamageRounding, ReducedDamageRounding
@ C_Code.c:1230:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	ldr	r3, .L449+32	@ tmp188,
	ldr	r3, [r3]	@ ReducedDamageSubtract, ReducedDamageSubtract
@ C_Code.c:1230:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	add	r0, r0, r8	@ _23, _19
@ C_Code.c:1230:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	movs	r1, #100	@,
@ C_Code.c:1230:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	subs	r0, r0, r3	@ _25, _23, ReducedDamageSubtract
@ C_Code.c:1230:         newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
	bl	.L313		@
	b	.L420		@
.L447:
@ C_Code.c:1241:         if ((hp - oldDamage) <= 0)
	ldr	r3, [sp, #20]	@ hp, %sfp
	subs	r3, r3, r7	@ _29, hp, oldDamage
@ C_Code.c:1241:         if ((hp - oldDamage) <= 0)
	cmp	r3, #0	@ _29,
	ble	.L448		@,
.L423:
@ C_Code.c:1249:         if (!BlockingEnabled)
	ldr	r1, .L449+36	@ tmp200,
@ C_Code.c:1249:         if (!BlockingEnabled)
	ldr	r1, [r1]	@ BlockingEnabled, BlockingEnabled
	cmp	r1, #0	@ BlockingEnabled,
	bne	.L422		@,
@ C_Code.c:1251:             newHp = hp - oldDamage;
	movs	r2, r3	@ newHp, _29
@ C_Code.c:1252:             newDamage = oldDamage;
	movs	r6, r7	@ _7, oldDamage
	b	.L422		@
.L445:
@ C_Code.c:1196:         CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp, 0);
	ldr	r3, [sp, #20]	@ hp, %sfp
	str	r3, [sp, #8]	@ hp,
	str	r3, [sp, #4]	@ hp,
	ldr	r3, [sp, #72]	@ tmp233, round
	mov	r2, r9	@, active_bunit
	str	r3, [sp]	@ tmp233,
	mov	r1, r10	@, HpProc
	mov	r3, fp	@, opp_bunit
	bl	CheckForDeath		@
@ C_Code.c:1197:         return;
	b	.L412		@
.L448:
@ C_Code.c:1243:             if (!BlockingCanPreventLethal)
	ldr	r1, .L449+40	@ tmp198,
@ C_Code.c:1243:             if (!BlockingCanPreventLethal)
	ldr	r1, [r1]	@ BlockingCanPreventLethal, BlockingCanPreventLethal
	cmp	r1, #0	@ BlockingCanPreventLethal,
	bne	.L423		@,
@ C_Code.c:1245:                 newHp = hp - oldDamage;
	movs	r2, r3	@ newHp, _29
@ C_Code.c:1246:                 newDamage = oldDamage;
	movs	r6, r7	@ _7, oldDamage
	b	.L423		@
.L450:
	.align	2
.L449:
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
@ C_Code.c:977:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	movs	r4, #11	@ _15,
	movs	r5, #192	@ tmp115,
	ldrsb	r4, [r2, r4]	@ _15,* _15
@ C_Code.c:992: {
	sub	sp, sp, #12	@,,
@ C_Code.c:977:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	ands	r4, r5	@ _5, tmp115
@ C_Code.c:954:     if (success)
	ldr	r5, [sp, #28]	@ tmp155, success
	cmp	r5, #0	@ tmp155,
	beq	.L452		@,
@ C_Code.c:956:         if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r4, #128	@ _5,
	beq	.L463		@,
@ C_Code.c:967:         if (!TimedHitsDifficultyRam->alwaysA)
	ldr	r4, .L464	@ tmp119,
	ldr	r4, [r4]	@ TimedHitsDifficultyRam.35_21, TimedHitsDifficultyRam
@ C_Code.c:967:         if (!TimedHitsDifficultyRam->alwaysA)
	ldrb	r4, [r4]	@ *TimedHitsDifficultyRam.35_21, *TimedHitsDifficultyRam.35_21
@ C_Code.c:967:         if (!TimedHitsDifficultyRam->alwaysA)
	lsls	r5, r4, #26	@ tmp149, *TimedHitsDifficultyRam.35_21,
	bmi	.L456		@,
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r5, .L464+4	@ tmp129,
	ldr	r5, [r5]	@ DifficultyThreshold.37_26, DifficultyThreshold
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	lsls	r4, r4, #27	@ tmp134, *TimedHitsDifficultyRam.35_21,
	lsrs	r4, r4, #27	@ _25, tmp134,
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	cmp	r4, r5	@ _25, DifficultyThreshold.37_26
	bge	.L457		@,
@ C_Code.c:970:                 (NumberOfRandomButtons >= DifficultyThreshold))
	ldr	r4, .L464+8	@ tmp137,
@ C_Code.c:969:             if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
	ldr	r4, [r4]	@ NumberOfRandomButtons, NumberOfRandomButtons
	cmp	r5, r4	@ DifficultyThreshold.37_26, NumberOfRandomButtons
	bgt	.L456		@,
.L457:
@ C_Code.c:972:                 return BonusDamagePercent + DifficultyBonusPercent;
	ldr	r4, .L464+12	@ tmp140,
	ldr	r5, .L464+16	@ tmp139,
	ldr	r4, [r4]	@ DifficultyBonusPercent, DifficultyBonusPercent
	ldr	r5, [r5]	@ BonusDamagePercent, BonusDamagePercent
	adds	r4, r4, r5	@ _19, DifficultyBonusPercent, BonusDamagePercent
	b	.L455		@
.L452:
@ C_Code.c:977:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r4, #128	@ _5,
	beq	.L458		@,
@ C_Code.c:981:     return FailedHitDamagePercent;
	ldr	r4, .L464+20	@ tmp144,
	ldr	r4, [r4]	@ _19,
.L455:
@ C_Code.c:994:     AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r4, [sp, #4]	@ _19,
	ldr	r4, [sp, #24]	@ tmp163, round
	str	r4, [sp]	@ tmp163,
	bl	AdjustDamageByPercent		@
@ C_Code.c:995: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L463:
@ C_Code.c:958:             if (BlockingEnabled)
	ldr	r4, .L464+24	@ tmp116,
@ C_Code.c:958:             if (BlockingEnabled)
	ldr	r4, [r4]	@ BlockingEnabled, BlockingEnabled
	cmp	r4, #0	@ BlockingEnabled,
	beq	.L458		@,
@ C_Code.c:960:                 return ReducedDamagePercent;
	ldr	r4, .L464+28	@ tmp118,
	ldr	r4, [r4]	@ _19,
	b	.L455		@
.L458:
@ C_Code.c:964:                 return 100;
	movs	r4, #100	@ _19,
	b	.L455		@
.L456:
@ C_Code.c:975:         return BonusDamagePercent;
	ldr	r4, .L464+16	@ tmp143,
	ldr	r4, [r4]	@ _19,
	b	.L455		@
.L465:
	.align	2
.L464:
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r5, r8	@,
	mov	r6, r9	@,
	mov	lr, fp	@,
	mov	r7, r10	@,
	mov	r9, r3	@ round, round
	push	{r5, r6, r7, lr}	@
	movs	r5, r3	@ round, round
@ C_Code.c:117:     if (gBattleStats.config &
	ldr	r3, .L502	@ tmp164,
@ C_Code.c:835: {
	mov	r8, r2	@ HpProc, HpProc
@ C_Code.c:117:     if (gBattleStats.config &
	ldrh	r2, [r3]	@ gBattleStats, gBattleStats
	movs	r3, #252	@ tmp168,
	lsls	r3, r3, #2	@ tmp168, tmp168,
@ C_Code.c:835: {
	movs	r4, r0	@ proc, proc
	sub	sp, sp, #20	@,,
@ C_Code.c:117:     if (gBattleStats.config &
	tst	r2, r3	@ gBattleStats, tmp168
	bne	.L466		@,
@ C_Code.c:123:     if (TimedHitsDifficultyRam->off)
	ldr	r3, .L502+4	@ tmp173,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.0_13, *TimedHitsDifficultyRam.0_13
@ C_Code.c:123:     if (TimedHitsDifficultyRam->off)
	lsls	r3, r3, #25	@ tmp318, *TimedHitsDifficultyRam.0_13,
	bpl	.L499		@,
.L466:
@ C_Code.c:947: }
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
.L499:
@ C_Code.c:127:     return !CheckFlag(DisabledFlag);
	ldr	r3, .L502+8	@ tmp183,
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L502+12	@ tmp185,
	bl	.L10		@
@ C_Code.c:836:     if (!AreTimedHitsEnabled())
	cmp	r0, #0	@ tmp311,
	bne	.L466		@,
@ C_Code.c:840:     if (round->hpChange < 0)
	ldrb	r3, [r5, #3]	@ tmp188,
	cmp	r3, #127	@ tmp188,
	bhi	.L466		@,
@ C_Code.c:844:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	ldr	r3, .L502+16	@ tmp189,
@ C_Code.c:844:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	ldrh	r2, [r3, #8]	@ tmp192,
	ldrh	r3, [r3, #4]	@ tmp194,
@ C_Code.c:844:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	orrs	r2, r3	@ tmp192, tmp194
@ C_Code.c:848:     int x = proc->anim2->xPosition;
	ldr	r3, [r4, #48]	@ proc_8(D)->anim2, proc_8(D)->anim2
@ C_Code.c:848:     int x = proc->anim2->xPosition;
	movs	r5, #2	@ x,
	ldrsh	r5, [r3, r5]	@ x, proc_8(D)->anim2, x
@ C_Code.c:844:     u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
	mov	r10, r2	@ keys, tmp192
@ C_Code.c:849:     if (x > 119)
	cmp	r5, #119	@ x,
	bgt	.LCB2847	@
	b	.L468	@long jump	@
.LCB2847:
@ C_Code.c:851:         x -= 40;
	subs	r5, r5, #40	@ x,
.L469:
@ C_Code.c:859:     int hitTime = !proc->EkrEfxIsUnitHittedNowFrames;
	movs	r3, #83	@ tmp198,
@ C_Code.c:860:     if (hitTime)
	ldrb	r3, [r4, r3]	@ tmp199,
	cmp	r3, #0	@ tmp199,
	bne	.L470		@,
@ C_Code.c:857:     struct BattleUnit * active_bunit = proc->active_bunit;
	ldr	r2, [r4, #60]	@ active_bunit, proc_8(D)->active_bunit
	mov	fp, r2	@ active_bunit, active_bunit
@ C_Code.c:858:     struct BattleUnit * opp_bunit = proc->opp_bunit;
	ldr	r2, [r4, #64]	@ opp_bunit, proc_8(D)->opp_bunit
	str	r2, [sp, #12]	@ opp_bunit, %sfp
@ C_Code.c:863:         if (proc->timer2 == 0xFF)
	movs	r2, #68	@ tmp200,
@ C_Code.c:863:         if (proc->timer2 == 0xFF)
	ldrb	r1, [r4, r2]	@ tmp201,
	cmp	r1, #255	@ tmp201,
	bne	.LCB2862	@
	b	.L500	@long jump	@
.LCB2862:
.L471:
@ C_Code.c:867:         int hadPress = proc->frame != 0;
	movs	r6, #76	@ tmp329,
	ldrh	r3, [r4, r6]	@ _36,
@ C_Code.c:868:         SaveInputFrame(proc, keys);
	mov	r1, r10	@, keys
	movs	r0, r4	@, proc
@ C_Code.c:867:         int hadPress = proc->frame != 0;
	movs	r7, r3	@ _36, _36
@ C_Code.c:868:         SaveInputFrame(proc, keys);
	bl	SaveInputFrame		@
@ C_Code.c:869:         if (!hadPress && proc->frame && (proc->readAhead & READAHEAD_PASSED))
	cmp	r7, #0	@ _36,
	bne	.L472		@,
@ C_Code.c:869:         if (!hadPress && proc->frame && (proc->readAhead & READAHEAD_PASSED))
	ldrh	r3, [r4, r6]	@ tmp207,
	cmp	r3, #0	@ tmp207,
	beq	.L472		@,
@ C_Code.c:869:         if (!hadPress && proc->frame && (proc->readAhead & READAHEAD_PASSED))
	movs	r2, #86	@ tmp208,
	ldrb	r3, [r4, r2]	@ _38,
@ C_Code.c:869:         if (!hadPress && proc->frame && (proc->readAhead & READAHEAD_PASSED))
	lsls	r1, r3, #27	@ tmp319, _38,
	bpl	.L472		@,
@ C_Code.c:871:             proc->readAhead |= READAHEAD_BAD_PRESS;
	movs	r1, #4	@ tmp216,
	orrs	r3, r1	@ tmp218, tmp216
	strb	r3, [r4, r2]	@ tmp218, proc_8(D)->readAhead
.L472:
@ C_Code.c:873:         SaveIfWeHitOnTime(proc);
	movs	r0, r4	@, proc
	bl	SaveIfWeHitOnTime		@
@ C_Code.c:874:         proc->readAhead &= ~READAHEAD_WINDOW_OPEN;
	movs	r2, #86	@ tmp221,
@ C_Code.c:874:         proc->readAhead &= ~READAHEAD_WINDOW_OPEN;
	movs	r1, #2	@ tmp225,
	ldrb	r3, [r4, r2]	@ tmp223,
	bics	r3, r1	@ tmp224, tmp225
	strb	r3, [r4, r2]	@ tmp224, proc_8(D)->readAhead
@ C_Code.c:875:         if (!proc->adjustedDmg)
	movs	r3, #71	@ tmp228,
@ C_Code.c:875:         if (!proc->adjustedDmg)
	ldrb	r2, [r4, r3]	@ tmp229,
	cmp	r2, #0	@ tmp229,
	bne	.L470		@,
@ C_Code.c:693:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r2, .L502+20	@ tmp230,
@ C_Code.c:698:     if (CheatCodeOn())
	ldrb	r2, [r2, #31]	@ tmp231,
	cmp	r2, #127	@ tmp231,
	bls	.LCB2905	@
	b	.L473	@long jump	@
.LCB2905:
@ C_Code.c:702:     if (AlwaysWork)
	ldr	r2, .L502+24	@ tmp232,
@ C_Code.c:702:     if (AlwaysWork)
	ldr	r2, [r2]	@ AlwaysWork, AlwaysWork
	cmp	r2, #0	@ AlwaysWork,
	beq	.LCB2909	@
	b	.L473	@long jump	@
.LCB2909:
@ C_Code.c:706:     return proc->hitOnTime;
	adds	r2, r2, #69	@ tmp234,
@ C_Code.c:877:             if (DidWeHitOnTime(proc))
	ldrb	r2, [r4, r2]	@ tmp235,
	cmp	r2, #0	@ tmp235,
	beq	.LCB2913	@
	b	.L473	@long jump	@
.LCB2913:
@ C_Code.c:884:                 proc->adjustedDmg = true;
	movs	r2, #1	@ tmp241,
	strb	r2, [r4, r3]	@ tmp241, proc_8(D)->adjustedDmg
@ C_Code.c:977:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	mov	r3, fp	@ active_bunit, active_bunit
	movs	r2, #11	@ _92,
	ldrsb	r2, [r3, r2]	@ _92,* _92
	movs	r3, #192	@ tmp244,
	ands	r3, r2	@ _93, _92
@ C_Code.c:977:     if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
	cmp	r3, #128	@ _93,
	bne	.LCB2922	@
	b	.L486	@long jump	@
.LCB2922:
@ C_Code.c:981:     return FailedHitDamagePercent;
	ldr	r3, .L502+28	@ tmp246,
	ldr	r3, [r3]	@ _94, FailedHitDamagePercent
.L475:
@ C_Code.c:994:     AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
	str	r3, [sp, #4]	@ _94,
	mov	r3, r9	@ round, round
	mov	r2, fp	@, active_bunit
	str	r3, [sp]	@ round,
	mov	r1, r8	@, HpProc
	movs	r0, r4	@, proc
	ldr	r3, [sp, #12]	@, %sfp
	bl	AdjustDamageByPercent		@
.L470:
@ C_Code.c:895:     if (EkrEfxIsUnitHittedNow(proc->side) ||
	movs	r3, #74	@ tmp247,
@ C_Code.c:895:     if (EkrEfxIsUnitHittedNow(proc->side) ||
	ldrb	r0, [r4, r3]	@ _46,
	ldr	r3, .L502+32	@ tmp249,
	bl	.L10		@
@ C_Code.c:897:         (proc->timer2 != 0xFF))
	movs	r3, #68	@ tmp252,
	ldrb	r3, [r4, r3]	@ pretmp_109,
	movs	r6, r3	@ pretmp_109, pretmp_109
@ C_Code.c:895:     if (EkrEfxIsUnitHittedNow(proc->side) ||
	cmp	r0, #0	@ tmp312,
	bne	.L476		@,
@ C_Code.c:896:         (((proc->code4frame != NO_FRAME) || (proc->codefframe != NO_FRAME)) && !IsDamagingRound(proc)) ||
	movs	r3, #78	@ tmp253,
@ C_Code.c:895:     if (EkrEfxIsUnitHittedNow(proc->side) ||
	ldr	r2, .L502+36	@ tmp255,
	ldrh	r3, [r4, r3]	@ tmp254,
	cmp	r3, r2	@ tmp254, tmp255
	beq	.L501		@,
.L477:
@ C_Code.c:489:     struct SkillSysBattleHit * round = proc->currentRound;
	ldr	r3, [r4, #56]	@ round, proc_8(D)->currentRound
@ C_Code.c:490:     if (!round)
	cmp	r3, #0	@ round,
	beq	.L476		@,
@ C_Code.c:494:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	ldr	r2, [r3]	@ *round_50, *round_50
@ C_Code.c:494:     if (round->attributes & BATTLE_HIT_ATTR_MISS)
	lsls	r2, r2, #30	@ tmp320, *round_50,
	bmi	.L476		@,
@ C_Code.c:896:         (((proc->code4frame != NO_FRAME) || (proc->codefframe != NO_FRAME)) && !IsDamagingRound(proc)) ||
	ldrb	r3, [r3, #3]	@ tmp265,
	lsls	r3, r3, #24	@ tmp265, tmp265,
	asrs	r3, r3, #24	@ tmp265, tmp265,
	cmp	r3, #0	@ tmp265,
	ble	.L476		@,
.L478:
@ C_Code.c:896:         (((proc->code4frame != NO_FRAME) || (proc->codefframe != NO_FRAME)) && !IsDamagingRound(proc)) ||
	cmp	r6, #255	@ pretmp_109,
	beq	.L479		@,
.L476:
@ C_Code.c:693:     return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L502+20	@ tmp266,
@ C_Code.c:698:     if (CheatCodeOn())
	ldrb	r3, [r3, #31]	@ tmp267,
	cmp	r3, #127	@ tmp267,
	bhi	.L480		@,
@ C_Code.c:702:     if (AlwaysWork)
	ldr	r3, .L502+24	@ tmp268,
@ C_Code.c:702:     if (AlwaysWork)
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L480		@,
@ C_Code.c:706:     return proc->hitOnTime;
	adds	r3, r3, #69	@ tmp270,
@ C_Code.c:899:         if (DidWeHitOnTime(proc))
	ldrb	r3, [r4, r3]	@ tmp271,
	cmp	r3, #0	@ tmp271,
	bne	.L480		@,
@ C_Code.c:918:         else if (proc->timer2 < 20)
	cmp	r6, #19	@ pretmp_109,
	bhi	.L482		@,
@ C_Code.c:920:             if (ChangePaletteWhenButtonIsPressed)
	ldr	r3, .L502+40	@ tmp295,
@ C_Code.c:920:             if (ChangePaletteWhenButtonIsPressed)
	ldr	r3, [r3]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
	cmp	r3, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L483		@,
@ C_Code.c:922:                 DrawButtonsToPress(proc, x, y, 15);
	movs	r3, #15	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress		@
.L482:
@ C_Code.c:929:         proc->roundEnd = true;
	movs	r3, #82	@ tmp297,
	movs	r2, #1	@ tmp298,
	strb	r2, [r4, r3]	@ tmp298, proc_8(D)->roundEnd
	b	.L466		@
.L480:
@ C_Code.c:910:             if (((y > (-16)) && (y < (161))))
	movs	r3, r6	@ _66, pretmp_109
	adds	r3, r3, #112	@ _66,
	cmp	r3, #175	@ _66,
	bhi	.L482		@,
@ C_Code.c:912:                 if (!gBanimDoneFlag[proc->side])
	movs	r2, #74	@ tmp274,
	ldrb	r2, [r4, r2]	@ _68,
@ C_Code.c:912:                 if (!gBanimDoneFlag[proc->side])
	ldr	r3, .L502+44	@ tmp273,
	lsls	r2, r2, #2	@ tmp276, _68,
@ C_Code.c:912:                 if (!gBanimDoneFlag[proc->side])
	ldr	r3, [r2, r3]	@ gBanimDoneFlag[_68], gBanimDoneFlag[_68]
	cmp	r3, #0	@ gBanimDoneFlag[_68],
	bne	.L482		@,
@ C_Code.c:906:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	movs	r1, #31	@,
	movs	r0, r6	@, pretmp_109
	ldr	r3, .L502+48	@ tmp279,
	bl	.L10		@
@ C_Code.c:906:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	movs	r2, #120	@ tmp281,
	ldr	r3, .L502+52	@ tmp280,
	adds	r3, r3, r0	@ tmp282, tmp280, _58
@ C_Code.c:909:             y -= clock;
	movs	r0, #48	@ tmp286,
@ C_Code.c:906:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	ldrb	r1, [r3, r2]	@ _60, xPos
@ C_Code.c:914:                     PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
	movs	r2, #255	@ tmp288,
@ C_Code.c:909:             y -= clock;
	subs	r0, r0, r6	@ y_64, tmp286, pretmp_109
@ C_Code.c:914:                     PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
	ands	r2, r0	@ _71, y_64
	movs	r0, #224	@ tmp293,
@ C_Code.c:906:             x += xPos[Mod(clock, sizeof(xPos) + 1)];
	adds	r1, r1, r5	@ x, _60, x
@ C_Code.c:907:             x += 16;
	adds	r1, r1, #16	@ x_63,
@ C_Code.c:914:                     PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
	lsls	r0, r0, #8	@ tmp293, tmp293,
	lsls	r1, r1, #23	@ tmp292, x_63,
	str	r0, [sp]	@ tmp293,
	ldr	r3, .L502+56	@ tmp285,
	movs	r0, #0	@,
	ldr	r5, .L502+60	@ tmp294,
	lsrs	r1, r1, #23	@ _70, tmp292,
	bl	.L29		@
	b	.L482		@
.L468:
@ C_Code.c:853:     else if (x > 40)
	cmp	r5, #40	@ x,
	bgt	.LCB3045	@
	b	.L469	@long jump	@
.LCB3045:
@ C_Code.c:855:         x -= 20;
	subs	r5, r5, #20	@ x,
	b	.L469		@
.L500:
@ C_Code.c:865:             proc->timer2 = 0;
	strb	r3, [r4, r2]	@ tmp199, proc_8(D)->timer2
	b	.L471		@
.L501:
@ C_Code.c:896:         (((proc->code4frame != NO_FRAME) || (proc->codefframe != NO_FRAME)) && !IsDamagingRound(proc)) ||
	movs	r2, #80	@ tmp256,
@ C_Code.c:896:         (((proc->code4frame != NO_FRAME) || (proc->codefframe != NO_FRAME)) && !IsDamagingRound(proc)) ||
	ldrh	r2, [r4, r2]	@ tmp257,
	cmp	r2, r3	@ tmp257, tmp254
	bne	.L477		@,
	b	.L478		@
.L473:
@ C_Code.c:879:                 proc->adjustedDmg = true;
	movs	r3, #1	@ tmp237,
	movs	r2, #71	@ tmp236,
	strb	r3, [r4, r2]	@ tmp237, proc_8(D)->adjustedDmg
@ C_Code.c:880:                 AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true);
	str	r3, [sp, #4]	@ tmp237,
	mov	r3, r9	@ round, round
	mov	r2, fp	@, active_bunit
	str	r3, [sp]	@ round,
	mov	r1, r8	@, HpProc
	movs	r0, r4	@, proc
	ldr	r3, [sp, #12]	@, %sfp
	bl	AdjustDamageWithGetter		@
	b	.L470		@
.L483:
@ C_Code.c:926:                 DrawButtonsToPress(proc, x, y, 14);
	movs	r3, #14	@,
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress		@
	b	.L482		@
.L479:
@ C_Code.c:933:         if (proc->timer < 1)
	ldr	r3, [r4, #52]	@ proc_8(D)->timer, proc_8(D)->timer
	cmp	r3, #0	@ proc_8(D)->timer,
	bgt	.L484		@,
@ C_Code.c:935:             proc->frame = 0;
	movs	r3, #76	@ tmp301,
	movs	r2, #0	@ tmp302,
	strh	r2, [r4, r3]	@ tmp302, proc_8(D)->frame
.L485:
@ C_Code.c:942:         if (!proc->roundEnd)
	movs	r3, #82	@ tmp304,
@ C_Code.c:942:         if (!proc->roundEnd)
	ldrb	r3, [r4, r3]	@ tmp305,
	cmp	r3, #0	@ tmp305,
	beq	.LCB3099	@
	b	.L466	@long jump	@
.LCB3099:
@ C_Code.c:944:             DrawButtonsToPress(proc, x, y, 15);
	movs	r2, #24	@,
	movs	r1, r5	@, x
	movs	r0, r4	@, proc
	adds	r3, r3, #15	@,
	bl	DrawButtonsToPress		@
	b	.L466		@
.L484:
@ C_Code.c:940:             SaveInputFrameReadAhead(proc, keys);
	mov	r1, r10	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrameReadAhead		@
	b	.L485		@
.L486:
@ C_Code.c:964:                 return 100;
	movs	r3, #100	@ _94,
	b	.L475		@
.L503:
	.align	2
.L502:
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
	.word	.LANCHOR1+24
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
@ C_Code.c:313:     if (!proc->anim)
	ldr	r3, [r0, #44]	@ proc_29(D)->anim, proc_29(D)->anim
@ C_Code.c:312: {
	movs	r4, r0	@ proc, proc
	sub	sp, sp, #12	@,,
@ C_Code.c:313:     if (!proc->anim)
	cmp	r3, #0	@ proc_29(D)->anim,
	beq	.L504		@,
@ C_Code.c:318:     struct ProcEkrBattle * battleProc = gpProcEkrBattle;
	ldr	r3, .L531	@ tmp124,
	ldr	r5, [r3]	@ battleProc, gpProcEkrBattle
@ C_Code.c:320:     if (!battleProc)
	cmp	r5, #0	@ battleProc,
	beq	.L504		@,
@ C_Code.c:324:     if (!proc->anim2)
	ldr	r3, [r0, #48]	@ proc_29(D)->anim2, proc_29(D)->anim2
	cmp	r3, #0	@ proc_29(D)->anim2,
	beq	.L504		@,
@ C_Code.c:328:     if (gEkrBattleEndFlag)
	ldr	r3, .L531+4	@ tmp126,
@ C_Code.c:328:     if (gEkrBattleEndFlag)
	ldr	r3, [r3]	@ gEkrBattleEndFlag, gEkrBattleEndFlag
	cmp	r3, #0	@ gEkrBattleEndFlag,
	bne	.L530		@,
@ C_Code.c:335:     if (proc->timer2 != 0xFF)
	movs	r2, #68	@ tmp131,
@ C_Code.c:334:     proc->timer++;
	ldr	r3, [r0, #52]	@ proc_29(D)->timer, proc_29(D)->timer
	adds	r3, r3, #1	@ _5,
	str	r3, [r0, #52]	@ _5, proc_29(D)->timer
@ C_Code.c:335:     if (proc->timer2 != 0xFF)
	ldrb	r3, [r0, r2]	@ _6,
@ C_Code.c:335:     if (proc->timer2 != 0xFF)
	cmp	r3, #255	@ _6,
	beq	.L507		@,
@ C_Code.c:337:         proc->timer2++;
	adds	r3, r3, #1	@ tmp132,
	strb	r3, [r0, r2]	@ tmp132, proc_29(D)->timer2
.L507:
@ C_Code.c:342:     if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
	movs	r2, #83	@ tmp175,
@ C_Code.c:340:     struct SkillSysBattleHit * currentRound = proc->currentRound;
	ldr	r3, [r4, #56]	@ currentRound, proc_29(D)->currentRound
	movs	r7, r3	@ currentRound, currentRound
@ C_Code.c:342:     if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
	ldrb	r3, [r4, r2]	@ _8,
@ C_Code.c:342:     if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
	cmp	r3, #255	@ _8,
	beq	.L508		@,
@ C_Code.c:344:         proc->EkrEfxIsUnitHittedNowFrames++;
	adds	r3, r3, #1	@ tmp136,
	strb	r3, [r4, r2]	@ tmp136, proc_29(D)->EkrEfxIsUnitHittedNowFrames
.L509:
@ C_Code.c:352:     struct NewProcEfxHPBar * HpProc = Proc_Find(gProcScr_efxHPBarResire);
	ldr	r3, .L531+8	@ tmp147,
	ldr	r0, [r3]	@ gProcScr_efxHPBarResire, gProcScr_efxHPBarResire
	ldr	r3, .L531+12	@ tmp149,
	movs	r6, r3	@ tmp149, tmp149
	bl	.L10		@
@ C_Code.c:353:     if (!HpProc)
	cmp	r0, #0	@ HpProc,
	beq	.L510		@,
@ C_Code.c:357:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r2, r0	@, HpProc
	movs	r3, r7	@, currentRound
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
.L511:
@ C_Code.c:304:     if (proc->EkrEfxIsUnitHittedNowFrames)
	movs	r3, #83	@ tmp153,
@ C_Code.c:304:     if (proc->EkrEfxIsUnitHittedNowFrames)
	ldrb	r3, [r4, r3]	@ tmp154,
	cmp	r3, #0	@ tmp154,
	bne	.L504		@,
@ C_Code.c:361:         int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId);
	movs	r6, #70	@ tmp182,
	ldrb	r3, [r4, r6]	@ tmp157,
	movs	r1, #0	@,
	movs	r2, #0	@,
	ldr	r0, [r4, #48]	@ proc_29(D)->anim2, proc_29(D)->anim2
	ldr	r5, .L531+16	@ tmp158,
	str	r3, [sp]	@ tmp157,
	movs	r3, #0	@,
	bl	.L29		@
	movs	r3, r0	@ x,
@ C_Code.c:362:         x = DisplayDamage2(proc->anim, 1, proc->anim->xPosition, x, proc->roundId);
	ldr	r0, [r4, #44]	@ _18, proc_29(D)->anim
	movs	r1, #2	@ tmp173,
	ldrsh	r2, [r0, r1]	@ _20, _18, tmp173
	ldrb	r1, [r4, r6]	@ tmp161,
	str	r1, [sp]	@ tmp161,
	movs	r1, #1	@,
	bl	.L29		@
.L504:
@ C_Code.c:364: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L530:
@ C_Code.c:330:         Proc_End(proc);
	ldr	r3, .L531+20	@ tmp128,
	bl	.L10		@
@ C_Code.c:331:         return;
	b	.L504		@
.L508:
@ C_Code.c:346:     else if (EkrEfxIsUnitHittedNow(proc->side))
	movs	r3, #74	@ tmp139,
@ C_Code.c:346:     else if (EkrEfxIsUnitHittedNow(proc->side))
	ldrb	r0, [r4, r3]	@ _11,
	ldr	r3, .L531+24	@ tmp141,
	bl	.L10		@
@ C_Code.c:346:     else if (EkrEfxIsUnitHittedNow(proc->side))
	cmp	r0, #0	@ tmp166,
	beq	.L509		@,
@ C_Code.c:348:         proc->EkrEfxIsUnitHittedNowFrames = 0;
	movs	r3, #0	@ tmp145,
	movs	r2, #83	@ tmp177,
	strb	r3, [r4, r2]	@ tmp145, proc_29(D)->EkrEfxIsUnitHittedNowFrames
	b	.L509		@
.L510:
@ C_Code.c:355:         HpProc = Proc_Find(gProcScr_efxHPBar);
	ldr	r3, .L531+28	@ tmp150,
	ldr	r0, [r3]	@ gProcScr_efxHPBar, gProcScr_efxHPBar
	bl	.L313		@
@ C_Code.c:357:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r3, r7	@, currentRound
@ C_Code.c:355:         HpProc = Proc_Find(gProcScr_efxHPBar);
	movs	r6, r0	@ HpProc,
@ C_Code.c:357:     DoStuffIfHit(proc, battleProc, HpProc, currentRound);
	movs	r2, r0	@, HpProc
	movs	r1, r5	@, battleProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit		@
@ C_Code.c:299:     if (!HpProc)
	cmp	r6, #0	@ HpProc,
	bne	.L511		@,
	b	.L504		@
.L532:
	.align	2
.L531:
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
	.type	images.0, %object
	.size	images.0, 16
images.0:
	.word	Press_Image
	.word	Press_Window_Image
	.word	Press_Success_Image
	.word	Press_Fail_Image
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
.L129:
	bx	r4
.L29:
	bx	r5
.L313:
	bx	r6
.L232:
	bx	r7
.L65:
	bx	r9
