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
@ C_Code.c:301: 		u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
	ldr	r3, .L21	@ tmp133,
	ldr	r2, [r3]	@ tmp136,
@ C_Code.c:297: int GetButtonsToPress(TimedHitsProc* proc) { 
	sub	sp, sp, #8	@,,
@ C_Code.c:301: 		u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
	str	r2, [sp]	@ tmp136,
	mov	r2, sp	@ tmp166,
	ldrh	r3, [r3, #4]	@ tmp138,
	strh	r3, [r2, #4]	@ tmp138,
@ C_Code.c:306: 		int numberOfRandomButtons = NumberOfRandomButtons; 
	ldr	r3, .L21+4	@ tmp140,
	ldr	r3, [r3]	@ numberOfRandomButtons, NumberOfRandomButtons
@ C_Code.c:297: int GetButtonsToPress(TimedHitsProc* proc) { 
	mov	r10, r0	@ proc, tmp163
@ C_Code.c:306: 		int numberOfRandomButtons = NumberOfRandomButtons; 
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:307: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	cmp	r3, #0	@ numberOfRandomButtons,
	bne	.L2		@,
@ C_Code.c:307: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	ldr	r3, .L21+8	@ tmp142,
	ldr	r3, [r3]	@ TimedHitsDifficultyRam, TimedHitsDifficultyRam
	ldrb	r3, [r3]	@ *TimedHitsDifficultyRam.8_2, *TimedHitsDifficultyRam.8_2
	lsls	r3, r3, #29	@ tmp147, *TimedHitsDifficultyRam.8_2,
@ C_Code.c:307: 		if (!numberOfRandomButtons) { numberOfRandomButtons = TimedHitsDifficultyRam->difficulty; } 
	lsrs	r2, r3, #29	@ numberOfRandomButtons, tmp147,
	mov	r8, r2	@ numberOfRandomButtons, numberOfRandomButtons
@ C_Code.c:308: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	cmp	r3, #0	@ tmp147,
	beq	.L18		@,
.L3:
	ldr	r3, .L21+12	@ tmp161,
@ C_Code.c:304: 		int oppDir = 0; 
	movs	r6, #0	@ oppDir,
@ C_Code.c:309: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	movs	r5, #0	@ i,
@ C_Code.c:299: 	int keys = proc->buttonsToPress;
	movs	r7, #0	@ <retval>,
@ C_Code.c:305: 		int size = 5; // -1 since we count from 0  
	movs	r4, #5	@ size,
	mov	r9, r3	@ tmp161, tmp161
	b	.L9		@
.L5:
@ C_Code.c:309: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r5, r5, #1	@ i,
@ C_Code.c:329: 			keys |= button; 
	orrs	r7, r0	@ <retval>, button
@ C_Code.c:309: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r5, r8	@ i, numberOfRandomButtons
	bge	.L19		@,
.L9:
@ C_Code.c:310: 			num = NextRN_N(size); 
	movs	r0, r4	@, size
	bl	.L23		@
@ C_Code.c:311: 			button = KeysList[num];
	mov	r3, sp	@ tmp173,
	ldrb	r0, [r3, r0]	@ button, KeysList
@ C_Code.c:314: 			if (button & 0xF0) { // some dpad 
	cmp	r0, #15	@ button,
	bls	.L5		@,
@ C_Code.c:315: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	cmp	r0, #16	@ button,
	beq	.L11		@,
@ C_Code.c:316: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	cmp	r0, #32	@ button,
	beq	.L12		@,
@ C_Code.c:317: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	cmp	r0, #64	@ button,
	bne	.L20		@,
@ C_Code.c:317: 				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
	movs	r6, #128	@ oppDir,
.L6:
@ C_Code.c:319: 				for (int c = 0; c <= size; ++c) { 
	cmp	r4, #0	@ size,
	blt	.L5		@,
	mov	r2, sp	@ ivtmp.61,
@ C_Code.c:319: 				for (int c = 0; c <= size; ++c) { 
	movs	r3, #0	@ c,
	b	.L8		@
.L7:
@ C_Code.c:319: 				for (int c = 0; c <= size; ++c) { 
	adds	r3, r3, #1	@ c,
@ C_Code.c:319: 				for (int c = 0; c <= size; ++c) { 
	adds	r2, r2, #1	@ ivtmp.61,
	cmp	r3, r4	@ c, size
	bgt	.L5		@,
.L8:
@ C_Code.c:320: 					if (KeysList[c] == oppDir) { 
	ldrb	r1, [r2]	@ MEM[(unsigned char *)_22], MEM[(unsigned char *)_22]
@ C_Code.c:320: 					if (KeysList[c] == oppDir) { 
	cmp	r1, r6	@ MEM[(unsigned char *)_22], oppDir
	bne	.L7		@,
@ C_Code.c:321: 						KeysList[c] = KeysList[size]; 
	mov	r2, sp	@ tmp174,
@ C_Code.c:321: 						KeysList[c] = KeysList[size]; 
	mov	r1, sp	@ tmp175,
@ C_Code.c:321: 						KeysList[c] = KeysList[size]; 
	ldrb	r2, [r2, r4]	@ _13, KeysList
@ C_Code.c:309: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	adds	r5, r5, #1	@ i,
@ C_Code.c:321: 						KeysList[c] = KeysList[size]; 
	strb	r2, [r1, r3]	@ _13, KeysList[c_42]
@ C_Code.c:322: 						size--; 
	subs	r4, r4, #1	@ size,
@ C_Code.c:329: 			keys |= button; 
	orrs	r7, r0	@ <retval>, button
@ C_Code.c:309: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r5, r8	@ i, numberOfRandomButtons
	blt	.L9		@,
.L19:
@ C_Code.c:331: 		proc->buttonsToPress = keys; 
	lsls	r3, r7, #16	@ tmp157, <retval>,
	lsrs	r3, r3, #16	@ _5, tmp157,
.L4:
	movs	r2, #84	@ tmp158,
	mov	r1, r10	@ proc, proc
@ C_Code.c:334: } 
	movs	r0, r7	@, <retval>
@ C_Code.c:331: 		proc->buttonsToPress = keys; 
	strh	r3, [r1, r2]	@ _5, proc_24(D)->buttonsToPress
@ C_Code.c:334: } 
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
@ C_Code.c:315: 				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
	movs	r6, #32	@ oppDir,
	b	.L6		@
.L2:
@ C_Code.c:309: 		for (int i = 0; i < numberOfRandomButtons; ++i) { 
	cmp	r3, #0	@ numberOfRandomButtons,
	bgt	.L3		@,
	movs	r3, #0	@ _5,
@ C_Code.c:299: 	int keys = proc->buttonsToPress;
	movs	r7, #0	@ <retval>,
	b	.L4		@
.L18:
@ C_Code.c:308: 		if (!numberOfRandomButtons) { numberOfRandomButtons = 1; }
	adds	r3, r3, #1	@ numberOfRandomButtons,
	mov	r8, r3	@ numberOfRandomButtons, numberOfRandomButtons
	b	.L3		@
.L12:
@ C_Code.c:316: 				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
	movs	r6, #16	@ oppDir,
	b	.L6		@
.L20:
@ C_Code.c:318: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
	cmp	r0, #128	@ button,
	bne	.L6		@,
@ C_Code.c:318: 				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
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
	.syntax unified
	.code	16
	.thumb_func
	.type	DrawButtonsToPress.part.0, %function
DrawButtonsToPress.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	r5, r8	@,
	mov	r6, r9	@,
	mov	lr, fp	@,
	mov	r7, r10	@,
	push	{r5, r6, r7, lr}	@
	movs	r5, r3	@ palID, tmp271
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, .L78	@ tmp162,
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:390: void DrawButtonsToPress(TimedHitsProc* proc, int x, int y, int palID) { 
	sub	sp, sp, #36	@,,
@ C_Code.c:390: void DrawButtonsToPress(TimedHitsProc* proc, int x, int y, int palID) { 
	movs	r6, r0	@ proc, tmp268
	mov	r8, r1	@ x, tmp269
	str	r2, [sp, #8]	@ tmp270, %sfp
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	cmp	r3, #0	@ AlwaysA,
	beq	.LCB172	@
	b	.L43	@long jump	@
.LCB172:
@ C_Code.c:299: 	int keys = proc->buttonsToPress;
	adds	r3, r3, #84	@ tmp164,
	ldrh	r4, [r0, r3]	@ _78,
@ C_Code.c:300: 	if (!keys) { 
	cmp	r4, #0	@ _78,
	beq	.L26		@,
.L68:
@ C_Code.c:407: 	if (keys & A_BUTTON) { 
	movs	r3, #1	@ tmp195,
	ands	r3, r4	@ tmp195, _26
	mov	fp, r3	@ _87, tmp195
@ C_Code.c:410: 	if (keys & B_BUTTON) { 
	movs	r3, #2	@ tmp196,
	ands	r3, r4	@ tmp196, _26
	str	r3, [sp, #12]	@ tmp196, %sfp
@ C_Code.c:413: 	if (keys & DPAD_LEFT) { 
	movs	r3, #32	@ tmp197,
	ands	r3, r4	@ tmp197, _26
	str	r3, [sp, #16]	@ tmp197, %sfp
@ C_Code.c:416: 	if (keys & DPAD_RIGHT) { 
	movs	r3, #16	@ tmp198,
	ands	r3, r4	@ tmp198, _26
	str	r3, [sp, #20]	@ tmp198, %sfp
@ C_Code.c:419: 	if (keys & DPAD_UP) { 
	movs	r3, #64	@ tmp199,
	ands	r3, r4	@ tmp199, _26
	str	r3, [sp, #24]	@ tmp199, %sfp
@ C_Code.c:422: 	if (keys & DPAD_DOWN) { 
	movs	r3, #128	@ tmp200,
	ands	r3, r4	@ tmp200, _26
	str	r3, [sp, #28]	@ tmp200, %sfp
.L25:
@ C_Code.c:394: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r3, .L78+4	@ tmp201,
@ C_Code.c:394: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldr	r3, [r3]	@ ChangePaletteWhenButtonIsPressed, ChangePaletteWhenButtonIsPressed
	cmp	r3, #0	@ ChangePaletteWhenButtonIsPressed,
	beq	.L29		@,
@ C_Code.c:394: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	movs	r3, #78	@ tmp205,
@ C_Code.c:394: 	if (ChangePaletteWhenButtonIsPressed && proc->frame) { palID = 14; } 
	ldrb	r3, [r6, r3]	@ tmp206,
	cmp	r3, #0	@ tmp206,
	bne	.L69		@,
.L29:
@ C_Code.c:396: 	int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); //OAM2_CHR(0);
	lsls	r5, r5, #28	@ tmp204, palID,
	lsrs	r5, r5, #16	@ _110, tmp204,
.L28:
@ C_Code.c:397: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	movs	r3, #255	@ tmp207,
	ldr	r7, [sp, #8]	@ y, %sfp
	ands	r3, r7	@ tmp207, y
	mov	r9, r3	@ _11, tmp207
	mov	r3, r8	@ x, x
	ldr	r6, .L78+8	@ tmp263,
	lsls	r1, r3, #23	@ tmp210, x,
	ldr	r7, .L78+12	@ tmp264,
	movs	r3, r6	@, tmp263
	mov	r2, r9	@, _11
	movs	r0, #2	@,
	lsrs	r1, r1, #23	@ tmp209, tmp210,
	str	r5, [sp]	@ _110,
	bl	.L80		@
@ C_Code.c:398: 	x += 32; 
	mov	r1, r8	@ x, x
@ C_Code.c:399: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	movs	r3, r6	@ tmp213, tmp263
@ C_Code.c:398: 	x += 32; 
	adds	r1, r1, #32	@ x,
@ C_Code.c:399: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	lsls	r1, r1, #23	@ tmp216, x,
	mov	r2, r9	@, _11
	adds	r3, r3, #8	@ tmp213,
	lsrs	r1, r1, #23	@ tmp215, tmp216,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	bl	.L80		@
@ C_Code.c:397: 	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	mov	r10, r7	@ tmp264, tmp264
@ C_Code.c:400: 	y += 16; x -= 36; 
	ldr	r7, [sp, #8]	@ y, %sfp
	movs	r1, #5	@ ivtmp_5,
	movs	r3, #1	@ pretmp_112,
@ C_Code.c:338: 	int c = 0; 
	movs	r2, #0	@ c,
@ C_Code.c:400: 	y += 16; x -= 36; 
	adds	r7, r7, #16	@ y,
	b	.L32		@
.L70:
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r3, r6, r2	@ tmp220, tmp263, c
	ldrb	r3, [r3, #16]	@ pretmp_112, RomKeysList
.L32:
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp218, _26
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r0, r3, #1	@ tmp267, tmp218
	sbcs	r3, r3, r0	@ tmp266, tmp218, tmp267
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	subs	r1, r1, #1	@ ivtmp_5,
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r2, r2, r3	@ c, c, tmp266
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	cmp	r1, #0	@ ivtmp_5,
	bne	.L70		@,
@ C_Code.c:403: 	if (count == 1) { x += 24; } // centering 
	cmp	r2, #1	@ c,
	beq	.L71		@,
@ C_Code.c:404: 	if (count == 2) { x += 16; } 
	cmp	r2, #2	@ c,
	bne	.L35		@,
@ C_Code.c:404: 	if (count == 2) { x += 16; } 
	mov	r4, r8	@ x, x
	adds	r4, r4, #12	@ x,
.L34:
@ C_Code.c:407: 	if (keys & A_BUTTON) { 
	mov	r3, fp	@ _87, _87
	cmp	r3, #0	@ _87,
	bne	.L72		@,
.L37:
@ C_Code.c:410: 	if (keys & B_BUTTON) { 
	ldr	r3, [sp, #12]	@ _90, %sfp
	cmp	r3, #0	@ _90,
	bne	.L73		@,
.L38:
@ C_Code.c:413: 	if (keys & DPAD_LEFT) { 
	ldr	r3, [sp, #16]	@ _93, %sfp
	cmp	r3, #0	@ _93,
	bne	.L74		@,
.L39:
@ C_Code.c:416: 	if (keys & DPAD_RIGHT) { 
	ldr	r3, [sp, #20]	@ _96, %sfp
	cmp	r3, #0	@ _96,
	bne	.L75		@,
.L40:
@ C_Code.c:419: 	if (keys & DPAD_UP) { 
	ldr	r3, [sp, #24]	@ _99, %sfp
	cmp	r3, #0	@ _99,
	bne	.L76		@,
.L41:
@ C_Code.c:422: 	if (keys & DPAD_DOWN) { 
	ldr	r3, [sp, #28]	@ _102, %sfp
	cmp	r3, #0	@ _102,
	bne	.L77		@,
.L24:
@ C_Code.c:429: } 
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
.L26:
	bl	GetButtonsToPress.part.0		@
	movs	r4, r0	@ _26, tmp272
	b	.L68		@
.L69:
	movs	r5, #224	@ _110,
	lsls	r5, r5, #8	@ _110, _110,
	b	.L28		@
.L35:
@ C_Code.c:405: 	if (count == 3) { x += 8; } 
	mov	r3, r8	@ x, x
	adds	r4, r3, #4	@ x, x,
@ C_Code.c:405: 	if (count == 3) { x += 8; } 
	cmp	r2, #3	@ c,
	beq	.L34		@,
@ C_Code.c:400: 	y += 16; x -= 36; 
	subs	r4, r4, #8	@ x,
	b	.L34		@
.L71:
@ C_Code.c:403: 	if (count == 1) { x += 24; } // centering 
	mov	r4, r8	@ x, x
@ C_Code.c:407: 	if (keys & A_BUTTON) { 
	mov	r3, fp	@ _87, _87
@ C_Code.c:403: 	if (count == 1) { x += 24; } // centering 
	adds	r4, r4, #20	@ x,
@ C_Code.c:407: 	if (keys & A_BUTTON) { 
	cmp	r3, #0	@ _87,
	beq	.L37		@,
.L72:
@ C_Code.c:408: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp222, tmp263
	movs	r2, #255	@ tmp223,
	lsls	r1, r4, #23	@ tmp226, x,
	adds	r3, r3, #24	@ tmp222,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	ands	r2, r7	@ tmp224, y
	lsrs	r1, r1, #23	@ tmp225, tmp226,
	bl	.L81		@
@ C_Code.c:410: 	if (keys & B_BUTTON) { 
	ldr	r3, [sp, #12]	@ _90, %sfp
@ C_Code.c:408: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:410: 	if (keys & B_BUTTON) { 
	cmp	r3, #0	@ _90,
	beq	.L38		@,
.L73:
@ C_Code.c:411: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp229, tmp263
	movs	r2, #255	@ tmp230,
	lsls	r1, r4, #23	@ tmp233, x,
	adds	r3, r3, #32	@ tmp229,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	ands	r2, r7	@ tmp231, y
	lsrs	r1, r1, #23	@ tmp232, tmp233,
	bl	.L81		@
@ C_Code.c:413: 	if (keys & DPAD_LEFT) { 
	ldr	r3, [sp, #16]	@ _93, %sfp
@ C_Code.c:411: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:413: 	if (keys & DPAD_LEFT) { 
	cmp	r3, #0	@ _93,
	beq	.L39		@,
.L74:
@ C_Code.c:414: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp236, tmp263
	movs	r2, #255	@ tmp237,
	lsls	r1, r4, #23	@ tmp240, x,
	adds	r3, r3, #40	@ tmp236,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	ands	r2, r7	@ tmp238, y
	lsrs	r1, r1, #23	@ tmp239, tmp240,
	bl	.L81		@
@ C_Code.c:416: 	if (keys & DPAD_RIGHT) { 
	ldr	r3, [sp, #20]	@ _96, %sfp
@ C_Code.c:414: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:416: 	if (keys & DPAD_RIGHT) { 
	cmp	r3, #0	@ _96,
	beq	.L40		@,
.L75:
@ C_Code.c:417: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp243, tmp263
	movs	r2, #255	@ tmp244,
	lsls	r1, r4, #23	@ tmp247, x,
	adds	r3, r3, #48	@ tmp243,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	ands	r2, r7	@ tmp245, y
	lsrs	r1, r1, #23	@ tmp246, tmp247,
	bl	.L81		@
@ C_Code.c:419: 	if (keys & DPAD_UP) { 
	ldr	r3, [sp, #24]	@ _99, %sfp
@ C_Code.c:417: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:419: 	if (keys & DPAD_UP) { 
	cmp	r3, #0	@ _99,
	beq	.L41		@,
.L76:
@ C_Code.c:420: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp250, tmp263
	movs	r2, #255	@ tmp251,
	lsls	r1, r4, #23	@ tmp254, x,
	adds	r3, r3, #56	@ tmp250,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	ands	r2, r7	@ tmp252, y
	lsrs	r1, r1, #23	@ tmp253, tmp254,
	bl	.L81		@
@ C_Code.c:422: 	if (keys & DPAD_DOWN) { 
	ldr	r3, [sp, #28]	@ _102, %sfp
@ C_Code.c:420: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	adds	r4, r4, #18	@ x,
@ C_Code.c:422: 	if (keys & DPAD_DOWN) { 
	cmp	r3, #0	@ _102,
	beq	.L24		@,
.L77:
@ C_Code.c:423: 		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2); x += 18; 
	movs	r3, r6	@ tmp263, tmp263
	movs	r2, #255	@ tmp258,
	lsls	r1, r4, #23	@ tmp261, x,
	movs	r0, #2	@,
	str	r5, [sp]	@ _110,
	adds	r3, r3, #64	@ tmp263,
	ands	r2, r7	@ tmp259, y
	lsrs	r1, r1, #23	@ tmp260, tmp261,
	bl	.L81		@
	b	.L24		@
.L43:
	movs	r3, #0	@ _102,
	str	r3, [sp, #28]	@ _102, %sfp
	str	r3, [sp, #24]	@ _99, %sfp
	str	r3, [sp, #20]	@ _96, %sfp
	str	r3, [sp, #16]	@ _93, %sfp
	str	r3, [sp, #12]	@ _90, %sfp
	adds	r3, r3, #1	@ _87,
	mov	fp, r3	@ _87, _87
	movs	r4, #1	@ _26,
	b	.L25		@
.L79:
	.align	2
.L78:
	.word	AlwaysA
	.word	ChangePaletteWhenButtonIsPressed
	.word	.LANCHOR0
	.word	PutSprite
	.size	DrawButtonsToPress.part.0, .-DrawButtonsToPress.part.0
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
@ C_Code.c:93: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L83	@ tmp118,
@ C_Code.c:92: int AreTimedHitsEnabled(void) { 
	push	{r4, lr}	@
@ C_Code.c:93: 	return !CheckFlag(DisabledFlag); 
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
@ C_Code.c:94: }
	@ sp needed	@
@ C_Code.c:93: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L83+4	@ tmp120,
	bl	.L85		@
@ C_Code.c:93: 	return !CheckFlag(DisabledFlag); 
	rsbs	r3, r0, #0	@ tmp126, tmp127
	adcs	r0, r0, r3	@ tmp125, tmp127, tmp126
@ C_Code.c:94: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L84:
	.align	2
.L83:
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
@ C_Code.c:97: 	proc->anim = NULL; 
	movs	r3, #0	@ tmp115,
@ C_Code.c:116: } 
	@ sp needed	@
@ C_Code.c:102: 	proc->timer2 = 0xFF; 
	movs	r2, #255	@ tmp118,
@ C_Code.c:112: 	proc->buttonsToPress = 0; 
	movs	r1, #84	@ tmp122,
@ C_Code.c:97: 	proc->anim = NULL; 
	str	r3, [r0, #44]	@ tmp115, proc_2(D)->anim
@ C_Code.c:98: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp115, proc_2(D)->anim2
@ C_Code.c:101: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp115, proc_2(D)->timer
@ C_Code.c:107: 	proc->currentRound = NULL; 
	str	r3, [r0, #60]	@ tmp115, proc_2(D)->currentRound
@ C_Code.c:108: 	proc->active_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp115, proc_2(D)->active_bunit
@ C_Code.c:109: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #68]	@ tmp115, proc_2(D)->opp_bunit
@ C_Code.c:102: 	proc->timer2 = 0xFF; 
	str	r2, [r0, #56]	@ tmp118, proc_2(D)->timer2
@ C_Code.c:112: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r1]	@ tmp115, proc_2(D)->buttonsToPress
@ C_Code.c:103: 	proc->hitOnTime = false; 
	str	r3, [r0, #72]	@ tmp115, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 72B]
	ldr	r3, .L87	@ tmp126,
	str	r3, [r0, #76]	@ tmp126, MEM <vector(4) unsigned char> [(unsigned char *)proc_2(D) + 76B]
@ C_Code.c:114: 	proc->codefframe = 0xff;
	movs	r3, #80	@ tmp127,
	ldr	r1, .L87+4	@ tmp128,
	strh	r1, [r0, r3]	@ tmp128, MEM <vector(2) unsigned char> [(unsigned char *)proc_2(D) + 80B]
@ C_Code.c:115: 	proc->EkrEfxIsUnitHittedNowFrames = 0xff; 
	adds	r3, r3, #2	@ tmp130,
	strb	r2, [r0, r3]	@ tmp118, proc_2(D)->EkrEfxIsUnitHittedNowFrames
@ C_Code.c:116: } 
	bx	lr
.L88:
	.align	2
.L87:
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
@ C_Code.c:120: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r4, .L92	@ tmp116,
	ldr	r3, .L92+4	@ tmp117,
	movs	r0, r4	@, tmp116
	bl	.L85		@
@ C_Code.c:121: 	if (!proc) { 
	cmp	r0, #0	@ tmp121,
	beq	.L91		@,
.L89:
@ C_Code.c:125: } 
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L91:
@ C_Code.c:122: 		proc = Proc_Start(TimedHitsProcCmd, (void*)3); 
	movs	r1, #3	@,
	movs	r0, r4	@, tmp116
	ldr	r3, .L92+8	@ tmp120,
	bl	.L85		@
@ C_Code.c:125: } 
	b	.L89		@
.L93:
	.align	2
.L92:
	.word	.LANCHOR0+72
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
@ C_Code.c:130: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r3, .L102	@ tmp133,
@ C_Code.c:128: void SetCurrentAnimInProc(struct Anim* anim) { 
	movs	r5, r0	@ anim, tmp199
@ C_Code.c:130: 	proc = Proc_Find(TimedHitsProcCmd); 
	ldr	r0, .L102+4	@ tmp132,
	bl	.L85		@
	subs	r4, r0, #0	@ proc, tmp200,
@ C_Code.c:131: 	if (!proc) { return; } 
	beq	.L94		@,
@ C_Code.c:98: 	proc->anim2 = NULL; 
	movs	r3, #0	@ tmp134,
@ C_Code.c:112: 	proc->buttonsToPress = 0; 
	movs	r2, #84	@ tmp139,
@ C_Code.c:98: 	proc->anim2 = NULL; 
	str	r3, [r0, #48]	@ tmp134, proc_20->anim2
@ C_Code.c:101: 	proc->timer = 0; 
	str	r3, [r0, #52]	@ tmp134, proc_20->timer
@ C_Code.c:107: 	proc->currentRound = NULL; 
	str	r3, [r0, #60]	@ tmp134, proc_20->currentRound
@ C_Code.c:108: 	proc->active_bunit = NULL; 
	str	r3, [r0, #64]	@ tmp134, proc_20->active_bunit
@ C_Code.c:109: 	proc->opp_bunit = NULL; 
	str	r3, [r0, #68]	@ tmp134, proc_20->opp_bunit
@ C_Code.c:112: 	proc->buttonsToPress = 0; 
	strh	r3, [r0, r2]	@ tmp134, proc_20->buttonsToPress
@ C_Code.c:103: 	proc->hitOnTime = false; 
	str	r3, [r0, #72]	@ tmp134, MEM <vector(4) unsigned char> [(unsigned char *)proc_20 + 72B]
	ldr	r3, .L102+8	@ tmp143,
	str	r3, [r0, #76]	@ tmp143, MEM <vector(4) unsigned char> [(unsigned char *)proc_20 + 76B]
@ C_Code.c:115: 	proc->EkrEfxIsUnitHittedNowFrames = 0xff; 
	movs	r3, #255	@ tmp145,
	subs	r2, r2, #2	@ tmp144,
	strb	r3, [r0, r2]	@ tmp145, proc_20->EkrEfxIsUnitHittedNowFrames
@ C_Code.c:114: 	proc->codefframe = 0xff;
	subs	r2, r2, #2	@ tmp147,
	strh	r3, [r0, r2]	@ tmp145, MEM <vector(2) unsigned char> [(unsigned char *)proc_20 + 80B]
@ C_Code.c:136: 	proc->anim = anim; 
	str	r5, [r0, #44]	@ anim, proc_20->anim
@ C_Code.c:137: 	proc->anim2 = GetAnimAnotherSide(anim); 
	ldr	r3, .L102+12	@ tmp150,
	movs	r0, r5	@, anim
	bl	.L85		@
@ C_Code.c:137: 	proc->anim2 = GetAnimAnotherSide(anim); 
	str	r0, [r4, #48]	@ _1, proc_20->anim2
@ C_Code.c:139: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	ldrh	r3, [r5, #14]	@ _2,
@ C_Code.c:139: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	ldrh	r0, [r0, #14]	@ _3,
@ C_Code.c:139: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	cmp	r3, r0	@ _2, _3
	bhi	.L101		@,
@ C_Code.c:139: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	subs	r0, r0, #1	@ tmp155,
	lsls	r0, r0, #24	@ tmp156, tmp155,
	lsrs	r0, r0, #24	@ iftmp.1_15, tmp156,
.L98:
@ C_Code.c:139: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	movs	r3, #73	@ tmp157,
	strb	r0, [r4, r3]	@ iftmp.1_15, proc_20->roundId
@ C_Code.c:140: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	ldr	r3, .L102+16	@ tmp159,
	bl	.L85		@
@ C_Code.c:141: 	proc->side = GetAnimPosition(anim) ^ 1; 
	ldr	r3, .L102+20	@ tmp160,
@ C_Code.c:140: 	proc->currentRound = GetCurrentRound(proc->roundId); 
	str	r0, [r4, #60]	@ tmp202, proc_20->currentRound
@ C_Code.c:141: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r0, r5	@, anim
	bl	.L85		@
@ C_Code.c:141: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r3, #1	@ tmp162,
@ C_Code.c:141: 	proc->side = GetAnimPosition(anim) ^ 1; 
	movs	r2, #77	@ tmp165,
@ C_Code.c:141: 	proc->side = GetAnimPosition(anim) ^ 1; 
	lsls	r0, r0, #24	@ tmp161, tmp203,
	asrs	r0, r0, #24	@ _9, tmp161,
	eors	r3, r0	@ tmp164, _9
@ C_Code.c:141: 	proc->side = GetAnimPosition(anim) ^ 1; 
	strb	r3, [r4, r2]	@ tmp164, proc_20->side
@ C_Code.c:142: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, .L102+24	@ tmp167,
@ C_Code.c:143: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, .L102+28	@ tmp168,
@ C_Code.c:142: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	ldr	r3, [r3]	@ gpEkrBattleUnitLeft.2_12, gpEkrBattleUnitLeft
@ C_Code.c:143: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	ldr	r2, [r2]	@ gpEkrBattleUnitRight.3_13, gpEkrBattleUnitRight
@ C_Code.c:142: 	proc->active_bunit = gpEkrBattleUnitLeft; 
	str	r3, [r4, #64]	@ gpEkrBattleUnitLeft.2_12, proc_20->active_bunit
@ C_Code.c:143: 	proc->opp_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #68]	@ gpEkrBattleUnitRight.3_13, proc_20->opp_bunit
@ C_Code.c:144: 	if (!proc->side) { 
	cmp	r0, #1	@ _9,
	bne	.L99		@,
@ C_Code.c:145: 		proc->active_bunit = gpEkrBattleUnitRight; 
	str	r2, [r4, #64]	@ gpEkrBattleUnitRight.3_13, proc_20->active_bunit
@ C_Code.c:146: 		proc->opp_bunit = gpEkrBattleUnitLeft;
	str	r3, [r4, #68]	@ gpEkrBattleUnitLeft.2_12, proc_20->opp_bunit
.L99:
@ C_Code.c:148: 	if (!proc->loadedImg) {
	movs	r6, #76	@ tmp169,
@ C_Code.c:148: 	if (!proc->loadedImg) {
	ldrb	r3, [r4, r6]	@ tmp170,
	cmp	r3, #0	@ tmp170,
	bne	.L94		@,
@ C_Code.c:149: 		proc->timer2 = 0xFF; 
	adds	r3, r3, #255	@ tmp171,
@ C_Code.c:150: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r5, .L102+32	@ tmp174,
	movs	r2, #6	@,
@ C_Code.c:149: 		proc->timer2 = 0xFF; 
	str	r3, [r4, #56]	@ tmp171, proc_20->timer2
@ C_Code.c:150: 		Copy2dChr(&Press_Image, (void*)0x06012980, 6, 2);
	ldr	r0, .L102+36	@ tmp173,
	ldr	r1, .L102+40	@,
	subs	r3, r3, #253	@,
	bl	.L104		@
@ C_Code.c:151: 		Copy2dChr(&BattleStar, (void*)0x06012a40, 2, 2); // 0x108 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L102+44	@ tmp176,
	ldr	r1, .L102+48	@,
	bl	.L104		@
@ C_Code.c:152: 		Copy2dChr(&A_Button, (void*)0x06012800, 2, 2); // 0x140
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L102+52	@ tmp179,
	ldr	r1, .L102+56	@,
	bl	.L104		@
@ C_Code.c:153: 		Copy2dChr(&B_Button, (void*)0x06012840, 2, 2); // 0x142 
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L102+60	@ tmp182,
	ldr	r1, .L102+64	@,
	bl	.L104		@
@ C_Code.c:154: 		Copy2dChr(&Left_Button, (void*)0x06012880, 2, 2); // 0x144
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L102+68	@ tmp185,
	ldr	r1, .L102+72	@,
	bl	.L104		@
@ C_Code.c:155: 		Copy2dChr(&Right_Button, (void*)0x060128C0, 2, 2); // 0x146
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L102+76	@ tmp188,
	ldr	r1, .L102+80	@,
	bl	.L104		@
@ C_Code.c:156: 		Copy2dChr(&Up_Button, (void*)0x06012900, 2, 2); // 0x148
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L102+84	@ tmp191,
	ldr	r1, .L102+88	@,
	bl	.L104		@
@ C_Code.c:157: 		Copy2dChr(&Down_Button, (void*)0x06012940, 2, 2); // 0x14a
	movs	r3, #2	@,
	movs	r2, #2	@,
	ldr	r0, .L102+92	@ tmp194,
	ldr	r1, .L102+96	@,
	bl	.L104		@
@ C_Code.c:158: 		proc->loadedImg = true;
	movs	r3, #1	@ tmp197,
	strb	r3, [r4, r6]	@ tmp197, proc_20->loadedImg
.L94:
@ C_Code.c:160: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L101:
@ C_Code.c:139: 	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	subs	r3, r3, #1	@ tmp152,
	lsls	r3, r3, #24	@ tmp153, tmp152,
	lsrs	r0, r3, #24	@ iftmp.1_15, tmp153,
	b	.L98		@
.L103:
	.align	2
.L102:
	.word	Proc_Find
	.word	.LANCHOR0+72
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
@ C_Code.c:242: 	if (proc->broke) { return; } 
	movs	r3, #75	@ tmp116,
@ C_Code.c:242: 	if (proc->broke) { return; } 
	ldrb	r2, [r0, r3]	@ tmp117,
	cmp	r2, #0	@ tmp117,
	bne	.L105		@,
@ C_Code.c:243: 	proc->broke = true; 
	adds	r2, r2, #1	@ tmp119,
	strb	r2, [r0, r3]	@ tmp119, proc_4(D)->broke
@ C_Code.c:244: 	asm("mov r11, r11");
	.syntax divided
@ 244 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L105:
@ C_Code.c:245: } 
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
@ C_Code.c:249: 	if (!HpProc) { return false; } // 
	cmp	r1, #0	@ tmp126,
	beq	.L109		@,
@ C_Code.c:251: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #82	@ tmp119,
@ C_Code.c:251: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r0, [r0, r3]	@ tmp121,
	rsbs	r3, r0, #0	@ tmp123, tmp121
	adcs	r0, r0, r3	@ <retval>, tmp121, tmp123
.L107:
@ C_Code.c:253: } 
	@ sp needed	@
	bx	lr
.L109:
@ C_Code.c:249: 	if (!HpProc) { return false; } // 
	movs	r0, #0	@ <retval>,
	b	.L107		@
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
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r2, .L113	@ tmp118,
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r2, [r2]	@ AlwaysA, AlwaysA
@ C_Code.c:297: int GetButtonsToPress(TimedHitsProc* proc) { 
	movs	r3, r0	@ proc, tmp122
	push	{r4, lr}	@
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	cmp	r2, #0	@ AlwaysA,
	bne	.L112		@,
@ C_Code.c:299: 	int keys = proc->buttonsToPress;
	adds	r2, r2, #84	@ tmp120,
@ C_Code.c:299: 	int keys = proc->buttonsToPress;
	ldrh	r0, [r0, r2]	@ <retval>,
@ C_Code.c:300: 	if (!keys) { 
	cmp	r0, #0	@ <retval>,
	bne	.L110		@,
	movs	r0, r3	@, proc
	bl	GetButtonsToPress.part.0		@
.L110:
@ C_Code.c:334: } 
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L112:
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	movs	r0, #1	@ <retval>,
	b	.L110		@
.L114:
	.align	2
.L113:
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
	movs	r1, r0	@ keys, tmp128
	push	{r4, r5, lr}	@
@ C_Code.c:337: int CountKeysPressed(u32 keys) { 
	movs	r2, #5	@ ivtmp_1,
	movs	r3, #1	@ pretmp_5,
@ C_Code.c:338: 	int c = 0; 
	movs	r0, #0	@ <retval>,
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r4, .L122	@ tmp127,
	b	.L118		@
.L121:
	adds	r3, r4, r0	@ tmp122, tmp127, <retval>
	ldrb	r3, [r3, #16]	@ pretmp_5, RomKeysList
.L118:
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r1	@ tmp120, keys
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r5, r3, #1	@ tmp126, tmp120
	sbcs	r3, r3, r5	@ tmp125, tmp120, tmp126
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	subs	r2, r2, #1	@ ivtmp_1,
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r0, r0, r3	@ <retval>, <retval>, tmp125
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	cmp	r2, #0	@ ivtmp_1,
	bne	.L121		@,
@ C_Code.c:344: } 
	@ sp needed	@
	pop	{r4, r5}
	pop	{r1}
	bx	r1
.L123:
	.align	2
.L122:
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
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, .L158	@ tmp145,
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	ldr	r3, [r3]	@ AlwaysA, AlwaysA
@ C_Code.c:346: int PressedSpecificKeys(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r1	@ keys, tmp180
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	cmp	r3, #0	@ AlwaysA,
	bne	.L140		@,
@ C_Code.c:299: 	int keys = proc->buttonsToPress;
	adds	r3, r3, #84	@ tmp147,
	ldrh	r5, [r0, r3]	@ keys,
@ C_Code.c:300: 	if (!keys) { 
	cmp	r5, #0	@ keys,
	beq	.L126		@,
.L153:
@ C_Code.c:348: 	int count = CountKeysPressed(reqKeys); 
	movs	r0, r5	@ prephitmp_13, keys
.L125:
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	movs	r1, #5	@ ivtmp_26,
	movs	r3, #1	@ pretmp_59,
@ C_Code.c:338: 	int c = 0; 
	movs	r2, #0	@ c,
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r6, .L158+4	@ tmp178,
	b	.L129		@
.L154:
	adds	r3, r6, r2	@ tmp150, tmp178, c
	ldrb	r3, [r3, #16]	@ pretmp_59, RomKeysList
.L129:
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r0	@ tmp148, prephitmp_13
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r7, r3, #1	@ tmp165, tmp148
	sbcs	r3, r3, r7	@ tmp164, tmp148, tmp165
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	subs	r1, r1, #1	@ ivtmp_26,
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r2, r2, r3	@ c, c, tmp164
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	cmp	r1, #0	@ ivtmp_26,
	bne	.L154		@,
	movs	r0, #5	@ ivtmp_35,
	movs	r3, #1	@ pretmp_74,
@ C_Code.c:338: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r7, .L158+4	@ tmp177,
	b	.L128		@
.L155:
	adds	r3, r7, r1	@ tmp153, tmp177, c
	ldrb	r3, [r3, #16]	@ pretmp_74, RomKeysList
.L128:
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp151, keys
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r6, r3, #1	@ tmp168, tmp151
	sbcs	r3, r3, r6	@ tmp167, tmp151, tmp168
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	subs	r0, r0, #1	@ ivtmp_35,
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp167
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	cmp	r0, #0	@ ivtmp_35,
	bne	.L155		@,
	movs	r0, #5	@ ivtmp_62,
	movs	r3, #1	@ pretmp_78,
@ C_Code.c:349: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r2, r1	@ c, c
	blt	.L142		@,
@ C_Code.c:338: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r6, .L158+4	@ tmp175,
	b	.L135		@
.L156:
	adds	r3, r6, r1	@ tmp156, tmp175, c
	ldrb	r3, [r3, #16]	@ pretmp_78, RomKeysList
.L135:
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp154, keys
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r7, r3, #1	@ tmp171, tmp154
	sbcs	r3, r3, r7	@ tmp170, tmp154, tmp171
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	subs	r0, r0, #1	@ ivtmp_62,
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp170
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	cmp	r0, #0	@ ivtmp_62,
	bne	.L156		@,
@ C_Code.c:349: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r2, r1	@ tmp157, c, c
@ C_Code.c:349: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp157,
	bgt	.L144		@,
.L137:
@ C_Code.c:350: 	return (keys & reqKeys); 
	movs	r0, r5	@ keys, keys
	ands	r0, r4	@ keys, keys
.L124:
@ C_Code.c:351: } 
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L126:
	bl	GetButtonsToPress.part.0		@
	movs	r5, r0	@ keys, tmp181
	b	.L153		@
.L142:
@ C_Code.c:338: 	int c = 0; 
	movs	r1, #0	@ c,
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	ldr	r6, .L158+4	@ tmp176,
	b	.L132		@
.L157:
	adds	r3, r6, r1	@ tmp160, tmp176, c
	ldrb	r3, [r3, #16]	@ pretmp_76, RomKeysList
.L132:
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	ands	r3, r4	@ tmp158, keys
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	subs	r7, r3, #1	@ tmp174, tmp158
	sbcs	r3, r3, r7	@ tmp173, tmp158, tmp174
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	subs	r0, r0, #1	@ ivtmp_43,
@ C_Code.c:340: 		if (keys & RomKeysList[c]) { c++; } 
	adds	r1, r1, r3	@ c, c, tmp173
@ C_Code.c:339: 	for (int i = 0; i < 5; ++i) { 
	cmp	r0, #0	@ ivtmp_43,
	bne	.L157		@,
@ C_Code.c:349: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	subs	r1, r1, r2	@ tmp161, c, c
@ C_Code.c:349: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	cmp	r1, #1	@ tmp161,
	ble	.L137		@,
.L144:
@ C_Code.c:349: 	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	movs	r0, #0	@ <retval>,
	b	.L124		@
.L140:
	movs	r0, #1	@ prephitmp_13,
@ C_Code.c:298: 	if (AlwaysA) { return A_BUTTON; } 
	movs	r5, #1	@ keys,
	b	.L125		@
.L159:
	.align	2
.L158:
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
@ C_Code.c:353: 	struct Anim* anim = proc->anim; 
	ldr	r5, [r0, #44]	@ anim, proc_17(D)->anim
@ C_Code.c:354: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:354: 	u32 instruction = *anim->pScrCurrent++; 
	adds	r3, r6, #4	@ tmp130, _1,
	str	r3, [r5, #32]	@ tmp130, anim_18->pScrCurrent
@ C_Code.c:355: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	movs	r3, #252	@ tmp132,
@ C_Code.c:352: void SaveInputFrame(TimedHitsProc* proc, u32 keys) { 
	movs	r4, r0	@ proc, tmp151
@ C_Code.c:355: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	movs	r0, #160	@ tmp133,
@ C_Code.c:354: 	u32 instruction = *anim->pScrCurrent++; 
	ldr	r2, [r6]	@ instruction, *_1
@ C_Code.c:355: 	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
	lsls	r3, r3, #22	@ tmp132, tmp132,
	ands	r3, r2	@ tmp131, instruction
	lsls	r0, r0, #19	@ tmp133, tmp133,
	cmp	r3, r0	@ tmp131, tmp133
	beq	.L167		@,
.L161:
@ C_Code.c:364: 	if (PressedSpecificKeys(proc, keys)) { 
	movs	r0, r4	@, proc
@ C_Code.c:363: 	instruction = *anim->pScrCurrent--; 
	str	r6, [r5, #32]	@ _1, anim_18->pScrCurrent
@ C_Code.c:364: 	if (PressedSpecificKeys(proc, keys)) { 
	bl	PressedSpecificKeys		@
@ C_Code.c:364: 	if (PressedSpecificKeys(proc, keys)) { 
	cmp	r0, #0	@ tmp153,
	beq	.L160		@,
@ C_Code.c:365: 		if (!proc->frame) { 
	movs	r3, #78	@ tmp143,
@ C_Code.c:365: 		if (!proc->frame) { 
	ldrb	r2, [r4, r3]	@ tmp144,
	cmp	r2, #0	@ tmp144,
	beq	.L168		@,
.L160:
@ C_Code.c:370: }  
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L167:
@ C_Code.c:356: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	movs	r3, #255	@ tmp134,
	ands	r3, r2	@ _4, instruction
@ C_Code.c:356: 		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
	cmp	r3, #4	@ _4,
	beq	.L169		@,
@ C_Code.c:359: 		if (ANINS_COMMAND_GET_ID(instruction) == 0xF) {
	cmp	r3, #15	@ _4,
	bne	.L161		@,
@ C_Code.c:360: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #65	@ tmp141,
	strb	r2, [r4, r3]	@ proc_17(D)->timer,
@ C_Code.c:360: 			proc->codefframe = proc->timer; proc->timer2 = 0; 
	movs	r3, #0	@ tmp142,
	str	r3, [r4, #56]	@ tmp142, proc_17(D)->timer2
	b	.L161		@
.L168:
@ C_Code.c:367: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	movs	r1, #128	@,
	movs	r0, #159	@,
@ C_Code.c:366: 			proc->frame = proc->timer; // locate is side for stereo? 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
@ C_Code.c:367: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r1, r1, #1	@,,
@ C_Code.c:366: 			proc->frame = proc->timer; // locate is side for stereo? 
	strb	r2, [r4, r3]	@ proc_17(D)->timer, proc_17(D)->frame
@ C_Code.c:367: 			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
	lsls	r0, r0, #1	@,,
	movs	r2, #120	@,
	ldr	r4, .L170	@ tmp150,
	subs	r3, r3, #77	@,
	bl	.L172		@
@ C_Code.c:370: }  
	b	.L160		@
.L169:
@ C_Code.c:357: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	ldr	r2, [r4, #52]	@ proc_17(D)->timer, proc_17(D)->timer
	adds	r3, r3, #75	@ tmp137,
	strb	r2, [r4, r3]	@ proc_17(D)->timer,
@ C_Code.c:357: 			proc->code4frame = proc->timer; proc->timer2 = 0; 
	movs	r3, #0	@ tmp138,
	str	r3, [r4, #56]	@ tmp138, proc_17(D)->timer2
	b	.L161		@
.L171:
	.align	2
.L170:
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
@ C_Code.c:372: 	if (proc->frame) { 
	movs	r3, #78	@ tmp128,
	ldrb	r3, [r0, r3]	@ _1,
@ C_Code.c:371: void SaveIfWeHitOnTime(TimedHitsProc* proc) {
	push	{r4, lr}	@
@ C_Code.c:372: 	if (proc->frame) { 
	cmp	r3, #0	@ _1,
	beq	.L173		@,
@ C_Code.c:373: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #80	@ tmp129,
@ C_Code.c:373: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, .L184	@ tmp130,
@ C_Code.c:373: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldrb	r2, [r0, r2]	@ _2,
@ C_Code.c:373: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	ldr	r1, [r1]	@ pretmp_33, LenienceFrames
@ C_Code.c:373: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, #255	@ _2,
	beq	.L176		@,
.L183:
@ C_Code.c:373: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	subs	r2, r2, r3	@ tmp131, _2, _1
	asrs	r4, r2, #31	@ tmp147, tmp131,
	adds	r2, r2, r4	@ tmp132, tmp131, tmp147
	eors	r2, r4	@ tmp132, tmp147
@ C_Code.c:373: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	cmp	r2, r1	@ tmp132, pretmp_33
	bge	.L177		@,
@ C_Code.c:373: 		if (proc->codefframe != 0xFF) { if (ABS(proc->codefframe - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } }
	movs	r2, #72	@ tmp133,
	movs	r4, #1	@ tmp134,
	strb	r4, [r0, r2]	@ tmp134, proc_21(D)->hitOnTime
.L177:
@ C_Code.c:375: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	ldr	r2, [r0, #52]	@ proc_21(D)->timer, proc_21(D)->timer
	subs	r3, r2, r3	@ tmp139, proc_21(D)->timer, _1
@ C_Code.c:375: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	cmp	r3, r1	@ tmp139, pretmp_33
	bge	.L173		@,
@ C_Code.c:375: 		if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; } 
	movs	r3, #72	@ tmp141,
	movs	r2, #1	@ tmp142,
	strb	r2, [r0, r3]	@ tmp142, proc_21(D)->hitOnTime
.L173:
@ C_Code.c:378: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L176:
@ C_Code.c:374: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	movs	r2, #79	@ tmp136,
	ldrb	r2, [r0, r2]	@ _8,
@ C_Code.c:374: 		else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	cmp	r2, #255	@ _8,
	bne	.L183		@,
	b	.L177		@
.L185:
	.align	2
.L184:
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
@ C_Code.c:381: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L187	@ tmp118,
@ C_Code.c:382: } 
	@ sp needed	@
@ C_Code.c:381: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldrb	r0, [r3, #31]	@ tmp120,
	movs	r3, #127	@ tmp122,
	bics	r0, r3	@ tmp117, tmp122
@ C_Code.c:382: } 
	bx	lr
.L188:
	.align	2
.L187:
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
@ C_Code.c:381: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L193	@ tmp120,
@ C_Code.c:385: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp123,
	cmp	r3, #127	@ tmp123,
	bhi	.L192		@,
@ C_Code.c:386: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L193+4	@ tmp124,
@ C_Code.c:386: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L192		@,
@ C_Code.c:387: 	return proc->hitOnTime;
	adds	r3, r3, #72	@ tmp126,
	ldrb	r0, [r0, r3]	@ <retval>,
	b	.L189		@
.L192:
@ C_Code.c:385: 	if (CheatCodeOn()) { return true; } 
	movs	r0, #1	@ <retval>,
.L189:
@ C_Code.c:388: }
	@ sp needed	@
	bx	lr
.L194:
	.align	2
.L193:
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
@ C_Code.c:391: 	if (!DisplayPress) { return; } 
	ldr	r4, .L200	@ tmp119,
@ C_Code.c:391: 	if (!DisplayPress) { return; } 
	ldr	r4, [r4]	@ DisplayPress, DisplayPress
	cmp	r4, #0	@ DisplayPress,
	beq	.L195		@,
	bl	DrawButtonsToPress.part.0		@
.L195:
@ C_Code.c:429: } 
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L201:
	.align	2
.L200:
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
@ C_Code.c:509: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp122,
	movs	r3, #192	@ tmp123,
	ldrsb	r1, [r0, r1]	@ tmp122,
	ands	r3, r1	@ _14, tmp122
@ C_Code.c:508: 	if (success) { 
	cmp	r2, #0	@ tmp131,
	beq	.L203		@,
@ C_Code.c:509: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _14,
	bne	.L204		@,
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L208	@ tmp124,
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L207		@,
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L208+4	@ tmp126,
	ldr	r0, [r3]	@ <retval>,
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L202		@
.L203:
@ C_Code.c:515: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _14,
	beq	.L207		@,
@ C_Code.c:518: 	return FailedHitDamagePercent; 
	ldr	r3, .L208+8	@ tmp128,
	ldr	r0, [r3]	@ <retval>,
.L202:
@ C_Code.c:519: } 
	@ sp needed	@
	bx	lr
.L204:
@ C_Code.c:513: 		return BonusDamagePercent; 
	ldr	r3, .L208+12	@ tmp127,
	ldr	r0, [r3]	@ <retval>,
	b	.L202		@
.L207:
@ C_Code.c:511: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
	b	.L202		@
.L209:
	.align	2
.L208:
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
@ C_Code.c:509: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r1, #11	@ tmp122,
	movs	r3, #192	@ tmp123,
	ldrsb	r1, [r0, r1]	@ tmp122,
	ands	r3, r1	@ _9, tmp122
@ C_Code.c:508: 	if (success) { 
	cmp	r2, #0	@ tmp131,
	beq	.L211		@,
@ C_Code.c:509: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _9,
	bne	.L212		@,
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L216	@ tmp124,
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, [r3]	@ BlockingEnabled, BlockingEnabled
	cmp	r3, #0	@ BlockingEnabled,
	beq	.L215		@,
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r3, .L216+4	@ tmp126,
	ldr	r0, [r3]	@ <retval>,
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L210		@
.L211:
@ C_Code.c:515: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ _9,
	beq	.L215		@,
@ C_Code.c:518: 	return FailedHitDamagePercent; 
	ldr	r3, .L216+8	@ tmp128,
	ldr	r0, [r3]	@ <retval>,
.L210:
@ C_Code.c:523: } 
	@ sp needed	@
	bx	lr
.L212:
@ C_Code.c:513: 		return BonusDamagePercent; 
	ldr	r3, .L216+12	@ tmp127,
	ldr	r0, [r3]	@ <retval>,
	b	.L210		@
.L215:
@ C_Code.c:511: 			else { return 100; } 
	movs	r0, #100	@ <retval>,
@ C_Code.c:522: 	return GetDefaultDamagePercent(active_bunit, opp_bunit, success); 
	b	.L210		@
.L217:
	.align	2
.L216:
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
@ C_Code.c:527: 	for (int i = id; i < 22; i += 2) {
	cmp	r0, #21	@ id,
	bgt	.L218		@,
	ldr	r3, .L228	@ tmp128,
	lsls	r2, r0, #1	@ tmp127, id,
@ C_Code.c:529: 		if (hp == 0xffff) { break; }
	ldr	r5, .L228+4	@ tmp129,
	adds	r2, r2, r3	@ ivtmp.186, tmp127, tmp128
	b	.L222		@
.L220:
	movs	r4, #0	@ _4,
@ C_Code.c:531: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	cmp	r3, r1	@ _1, difference
	blt	.L221		@,
@ C_Code.c:531: 		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
	subs	r3, r3, r1	@ tmp132, _1, difference
.L226:
	lsls	r3, r3, #16	@ tmp133, tmp132,
	lsrs	r4, r3, #16	@ _4, tmp133,
.L221:
@ C_Code.c:527: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:530: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:527: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.186,
	cmp	r0, #21	@ id,
	bgt	.L218		@,
.L222:
@ C_Code.c:528: 		hp = gEfxHpLut[i]; 
	ldrh	r3, [r2]	@ _1, MEM[(short unsigned int *)_18]
@ C_Code.c:529: 		if (hp == 0xffff) { break; }
	cmp	r3, r5	@ _1, tmp129
	beq	.L218		@,
@ C_Code.c:530: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r1, #0	@ difference,
	bge	.L220		@,
@ C_Code.c:530: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	adds	r3, r3, r1	@ hp, _1, difference
	movs	r4, #0	@ _4,
@ C_Code.c:530: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	cmp	r3, #0	@ hp,
	bgt	.L226		@,
@ C_Code.c:527: 	for (int i = id; i < 22; i += 2) {
	adds	r0, r0, #2	@ id,
@ C_Code.c:530: 		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
	strh	r4, [r2]	@ _4, MEM[(short unsigned int *)_18]
@ C_Code.c:527: 	for (int i = id; i < 22; i += 2) {
	adds	r2, r2, #4	@ ivtmp.186,
	cmp	r0, #21	@ id,
	ble	.L222		@,
.L218:
@ C_Code.c:545: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L229:
	.align	2
.L228:
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
@ C_Code.c:557: 	int side = proc->side; 
	movs	r2, #77	@ tmp143,
@ C_Code.c:556: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	push	{lr}	@
@ C_Code.c:556: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	movs	r7, r3	@ opp_bunit, tmp203
	ldr	r0, [sp, #28]	@ hp, hp
@ C_Code.c:557: 	int side = proc->side; 
	ldrb	r3, [r4, r2]	@ _1,
@ C_Code.c:556: void CheckForDeath(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	movs	r5, r1	@ HpProc, tmp201
@ C_Code.c:557: 	int side = proc->side; 
	mov	r8, r3	@ _1, _1
@ C_Code.c:561: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	cmp	r0, #0	@ hp,
	blt	.L234		@,
.L231:
@ C_Code.c:562: 	if (hp <= 0) { // they are dead 
	cmp	r0, #0	@ hp,
	ble	.L235		@,
.L230:
@ C_Code.c:603: }
	@ sp needed	@
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L235:
@ C_Code.c:568: 		opp_bunit->unit.curHP = 0; 
	movs	r3, #0	@ tmp153,
	strb	r3, [r7, #19]	@ tmp153, opp_bunit_32(D)->unit.curHP
@ C_Code.c:569: 		if (UsingSkillSys) { HpProc->post = 0; } 
	ldr	r3, .L236	@ tmp155,
@ C_Code.c:569: 		if (UsingSkillSys) { HpProc->post = 0; } 
	ldr	r3, [r3]	@ UsingSkillSys, UsingSkillSys
	cmp	r3, #0	@ UsingSkillSys,
	bne	.L233		@,
@ C_Code.c:570: 		else { HpProc->post = 0; HpProc->postHpAtkrSS = 0; } 
	movs	r2, #82	@ tmp157,
	strh	r3, [r5, r2]	@ UsingSkillSys, HpProc_34(D)->postHpAtkrSS
.L233:
	movs	r3, #80	@ tmp160,
	movs	r2, #0	@ tmp161,
	strh	r2, [r5, r3]	@ tmp161, HpProc_34(D)->post
@ C_Code.c:572: 		proc->code4frame = 0xff;
	subs	r3, r3, #1	@ tmp163,
	adds	r2, r2, #255	@ tmp164,
	strb	r2, [r4, r3]	@ tmp164, proc_24(D)->code4frame
@ C_Code.c:576: 		HpProc->death = true; 
	subs	r3, r3, #78	@ tmp167,
	subs	r2, r2, #214	@ tmp166,
	strb	r3, [r5, r2]	@ tmp167, HpProc_34(D)->death
@ C_Code.c:581: 		proc->anim->nextRoundId = 8; // seems to mostly work for now? see GetAnimNextRoundType
	ldr	r1, [r4, #44]	@ proc_24(D)->anim, proc_24(D)->anim
	subs	r2, r2, #33	@ tmp170,
	strh	r2, [r1, #14]	@ tmp170, _10->nextRoundId
@ C_Code.c:582: 		proc->anim2->nextRoundId = 8; 
	ldr	r1, [r4, #48]	@ proc_24(D)->anim2, proc_24(D)->anim2
	strh	r2, [r1, #14]	@ tmp170, _11->nextRoundId
@ C_Code.c:584: 		gBanimDoneFlag[0] = true; // stop counterattacks ?
	ldr	r2, .L236+4	@ tmp175,
	str	r3, [r2]	@ tmp167, gBanimDoneFlag[0]
@ C_Code.c:585: 		gBanimDoneFlag[1] = true; // [201fb04..201fb07]!! - nothing else is writing to it. good. 
	str	r3, [r2, #4]	@ tmp167, gBanimDoneFlag[1]
@ C_Code.c:587: 		round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END; 
	movs	r2, #176	@ tmp179,
	ldr	r3, [sp, #24]	@ tmp215, round
	ldrb	r3, [r3, #2]	@ tmp182,
	orrs	r3, r2	@ tmp184, tmp179
	ldr	r2, [sp, #24]	@ tmp216, round
	strb	r3, [r2, #2]	@ tmp184,
@ C_Code.c:592: 		side = 1 ^ side; 
	movs	r3, #1	@ tmp189,
	mov	r2, r8	@ _1, _1
	eors	r2, r3	@ _1, tmp189
	movs	r3, r2	@ side, _1
@ C_Code.c:593: 		id = (gEfxHpLutOff[side] * 2) + (side);
	ldr	r2, .L236+8	@ tmp190,
	lsls	r1, r3, #1	@ tmp191, side,
	ldrsh	r0, [r1, r2]	@ tmp192, gEfxHpLutOff
@ C_Code.c:593: 		id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r0, r0, #1	@ tmp193, tmp192,
@ C_Code.c:593: 		id = (gEfxHpLutOff[side] * 2) + (side);
	adds	r0, r0, r3	@ id, tmp193, side
@ C_Code.c:594: 		hp = GetEfxHp(id); 
	ldr	r3, .L236+12	@ tmp195,
	bl	.L85		@
@ C_Code.c:596: 		active_bunit->unit.curHP = hp; 
	strb	r0, [r6, #19]	@ tmp205, active_bunit_48(D)->unit.curHP
@ C_Code.c:603: }
	b	.L230		@
.L234:
@ C_Code.c:560: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	mov	r2, r8	@ _1, _1
	ldr	r3, .L236+8	@ tmp144,
	lsls	r2, r2, #1	@ tmp145, _1,
	ldrsh	r0, [r2, r3]	@ tmp146, gEfxHpLutOff
@ C_Code.c:560: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r0, r0, #1	@ tmp147, tmp146,
@ C_Code.c:561: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	ldr	r3, .L236+12	@ tmp149,
@ C_Code.c:560: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	add	r0, r0, r8	@ id, _1
@ C_Code.c:561: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	bl	.L85		@
@ C_Code.c:561: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	ldr	r3, [sp, #24]	@ tmp214, round
	ldrb	r3, [r3, #3]	@ tmp152,
	lsls	r3, r3, #24	@ tmp152, tmp152,
	asrs	r3, r3, #24	@ tmp152, tmp152,
@ C_Code.c:561: 	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	subs	r0, r0, r3	@ hp, tmp204, tmp152
	b	.L231		@
.L237:
	.align	2
.L236:
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
@ C_Code.c:608: 	int side = proc->side; 
	movs	r3, #77	@ tmp216,
@ C_Code.c:605: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	push	{r5, r6, r7, lr}	@
	mov	fp, r2	@ active_bunit, tmp348
@ C_Code.c:608: 	int side = proc->side; 
	ldrb	r2, [r0, r3]	@ side,
@ C_Code.c:609: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	ldr	r3, .L272	@ tmp217,
@ C_Code.c:605: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	movs	r7, r1	@ HpProc, tmp347
@ C_Code.c:609: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r1, r2, #1	@ tmp218, side,
	ldrsh	r5, [r1, r3]	@ tmp219, gEfxHpLutOff
@ C_Code.c:609: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	lsls	r5, r5, #1	@ tmp220, tmp219,
@ C_Code.c:609: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	adds	r3, r5, r2	@ id, tmp220, side
@ C_Code.c:605: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	sub	sp, sp, #20	@,,
@ C_Code.c:609: 	int id = (gEfxHpLutOff[side] * 2) + (side);
	str	r3, [sp, #8]	@ id, %sfp
@ C_Code.c:605: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	mov	r9, r0	@ proc, tmp346
@ C_Code.c:610: 	int hp = GetEfxHp(id); // + round->hpChange; 
	movs	r0, r3	@, id
	ldr	r3, .L272+4	@ tmp221,
	bl	.L85		@
	subs	r6, r0, #0	@ tmp222, tmp350,
@ C_Code.c:611: 	if (!hp) { return; } 
	beq	.L238		@,
@ C_Code.c:613: 	int damage = (round->hpChange * percent) / 100; 
	ldr	r3, [sp, #56]	@ tmp362, round
	ldrb	r3, [r3, #3]	@ _11,
	lsls	r3, r3, #24	@ _11, _11,
	asrs	r3, r3, #24	@ _11, _11,
	mov	r10, r3	@ _11, _11
	movs	r4, r3	@ _197, _11
@ C_Code.c:613: 	int damage = (round->hpChange * percent) / 100; 
	ldr	r3, [sp, #60]	@ tmp364, percent
@ C_Code.c:613: 	int damage = (round->hpChange * percent) / 100; 
	movs	r1, #100	@,
@ C_Code.c:613: 	int damage = (round->hpChange * percent) / 100; 
	mov	r0, r10	@ tmp224, _11
	muls	r0, r3	@ tmp224, tmp364
@ C_Code.c:613: 	int damage = (round->hpChange * percent) / 100; 
	ldr	r3, .L272+8	@ tmp227,
	bl	.L85		@
	subs	r1, r0, #0	@ damage, tmp351,
@ C_Code.c:614: 	if (!damage) { damage = 1; } 
	bne	.L240		@,
@ C_Code.c:614: 	if (!damage) { damage = 1; } 
	adds	r1, r1, #1	@ damage,
.L240:
@ C_Code.c:616: 	if (damage > round->hpChange) { 
	cmp	r10, r1	@ _11, damage
	blt	.L267		@,
@ C_Code.c:637: 	else if (round->hpChange != hp) { 
	cmp	r6, r10	@ tmp222, _11
	bne	.LCB1510	@
	b	.L249	@long jump	@
.LCB1510:
@ C_Code.c:638: 		damage = round->hpChange - damage; 
	mov	r3, r10	@ _11, _11
	subs	r0, r3, r1	@ damage, _11, damage
@ C_Code.c:640: 		if (UsingSkillSys) { // uggggh 
	ldr	r3, .L272+12	@ tmp259,
	ldr	r2, [r3]	@ UsingSkillSys.24_50, UsingSkillSys
@ C_Code.c:649: 		opp_bunit->unit.curHP += damage; 
	mov	r3, r8	@ opp_bunit, opp_bunit
@ C_Code.c:650: 		round->hpChange -= damage; 
	mov	r5, r10	@ _11, _11
@ C_Code.c:649: 		opp_bunit->unit.curHP += damage; 
	ldrb	r3, [r3, #19]	@ tmp262,
	lsls	r4, r0, #24	@ tmp260, damage,
	lsrs	r4, r4, #24	@ _222, tmp260,
	adds	r3, r4, r3	@ tmp263, _222, tmp262
	lsls	r3, r3, #24	@ tmp264, tmp263,
@ C_Code.c:650: 		round->hpChange -= damage; 
	subs	r4, r5, r4	@ tmp266, _11, _222
@ C_Code.c:649: 		opp_bunit->unit.curHP += damage; 
	asrs	r3, r3, #24	@ _226, tmp264,
@ C_Code.c:650: 		round->hpChange -= damage; 
	lsls	r4, r4, #24	@ tmp267, tmp266,
@ C_Code.c:649: 		opp_bunit->unit.curHP += damage; 
	str	r3, [sp, #12]	@ _226, %sfp
@ C_Code.c:639: 		hp += damage; 
	adds	r6, r6, r0	@ hp, tmp222, damage
@ C_Code.c:650: 		round->hpChange -= damage; 
	asrs	r4, r4, #24	@ _229, tmp267,
@ C_Code.c:640: 		if (UsingSkillSys) { // uggggh 
	cmp	r2, #0	@ UsingSkillSys.24_50,
	beq	.L250		@,
@ C_Code.c:641: 			HpProc->post += damage;
	lsls	r0, r0, #16	@ tmp268, damage,
	lsrs	r5, r0, #16	@ _53, tmp268,
@ C_Code.c:641: 			HpProc->post += damage;
	movs	r0, #80	@ tmp269,
@ C_Code.c:641: 			HpProc->post += damage;
	mov	ip, r5	@ _53, _53
@ C_Code.c:641: 			HpProc->post += damage;
	movs	r3, r0	@ tmp269, tmp269
@ C_Code.c:641: 			HpProc->post += damage;
	ldrh	r0, [r7, r0]	@ tmp271,
	add	r0, r0, ip	@ tmp272, _53
	strh	r0, [r7, r3]	@ tmp272, HpProc_21(D)->post
@ C_Code.c:649: 		opp_bunit->unit.curHP += damage; 
	mov	r0, r8	@ opp_bunit, opp_bunit
	ldr	r3, [sp, #12]	@ _226, %sfp
	strb	r3, [r0, #19]	@ _226, opp_bunit_34(D)->unit.curHP
@ C_Code.c:650: 		round->hpChange -= damage; 
	ldr	r3, [sp, #56]	@ tmp391, round
	strb	r4, [r3, #3]	@ _229, round_10(D)->hpChange
@ C_Code.c:651: 		if (UsingSkillSys == 2) { round->overDmg += damage; } // used by Huichelaar's banim numbers 
	cmp	r2, #2	@ UsingSkillSys.24_50,
	bne	.L252		@,
@ C_Code.c:651: 		if (UsingSkillSys == 2) { round->overDmg += damage; } // used by Huichelaar's banim numbers 
	ldr	r3, [sp, #56]	@ tmp395, round
	ldrh	r3, [r3, #6]	@ tmp286,
	ldr	r2, [sp, #56]	@ tmp398, round
	add	r3, r3, ip	@ tmp287, _53
	strh	r3, [r2, #6]	@ tmp287, round_10(D)->overDmg
	b	.L252		@
.L267:
@ C_Code.c:620: 		if (hp < 0) { damage -= ABS(hp); } 
	mov	r3, r10	@ _11, _11
@ C_Code.c:617: 		hp -= damage;
	subs	r0, r6, r1	@ hp, tmp222, damage
@ C_Code.c:618: 		damage -= round->hpChange; 
	subs	r1, r1, r3	@ damage, damage, _11
@ C_Code.c:620: 		if (hp < 0) { damage -= ABS(hp); } 
	cmp	r0, #0	@ hp,
	blt	.L268		@,
.L243:
@ C_Code.c:624: 		if (UsingSkillSys) { // uggggh 
	ldr	r3, .L272+12	@ tmp229,
	ldr	r2, [r3]	@ UsingSkillSys.22_20, UsingSkillSys
@ C_Code.c:633: 		opp_bunit->unit.curHP -= damage; 
	mov	r3, r8	@ opp_bunit, opp_bunit
@ C_Code.c:694: 	if (hp < 0) { hp = 0; } 
	mvns	r6, r0	@ tmp341, hp
@ C_Code.c:633: 		opp_bunit->unit.curHP -= damage; 
	ldrb	r3, [r3, #19]	@ tmp232,
	lsls	r4, r1, #24	@ tmp230, damage,
	lsrs	r4, r4, #24	@ _213, tmp230,
	subs	r3, r3, r4	@ tmp233, tmp232, _213
@ C_Code.c:634: 		round->hpChange += damage; 
	add	r4, r4, r10	@ tmp236, _11
@ C_Code.c:633: 		opp_bunit->unit.curHP -= damage; 
	lsls	r3, r3, #24	@ tmp234, tmp233,
@ C_Code.c:634: 		round->hpChange += damage; 
	lsls	r4, r4, #24	@ tmp237, tmp236,
@ C_Code.c:694: 	if (hp < 0) { hp = 0; } 
	asrs	r6, r6, #31	@ tmp340, tmp341,
@ C_Code.c:633: 		opp_bunit->unit.curHP -= damage; 
	asrs	r3, r3, #24	@ _217, tmp234,
@ C_Code.c:634: 		round->hpChange += damage; 
	asrs	r4, r4, #24	@ _220, tmp237,
@ C_Code.c:694: 	if (hp < 0) { hp = 0; } 
	ands	r6, r0	@ prephitmp_210, hp
@ C_Code.c:624: 		if (UsingSkillSys) { // uggggh 
	cmp	r2, #0	@ UsingSkillSys.22_20,
	bne	.L269		@,
@ C_Code.c:628: 			post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	movs	r0, #82	@ tmp247,
@ C_Code.c:628: 			post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	ldrsh	r2, [r7, r0]	@ post,
@ C_Code.c:629: 			post -= damage; 
	subs	r2, r2, r1	@ post, post, damage
@ C_Code.c:630: 			HpProc->postHpAtkrSS = post; 
	strh	r2, [r7, r0]	@ post, HpProc_21(D)->postHpAtkrSS
@ C_Code.c:631: 			HpProc->post = post>>16; 
	asrs	r2, r2, #16	@ tmp250, post,
@ C_Code.c:631: 			HpProc->post = post>>16; 
	subs	r0, r0, #2	@ tmp251,
	strh	r2, [r7, r0]	@ tmp250, HpProc_21(D)->post
@ C_Code.c:633: 		opp_bunit->unit.curHP -= damage; 
	mov	r2, r8	@ opp_bunit, opp_bunit
	strb	r3, [r2, #19]	@ _217, opp_bunit_34(D)->unit.curHP
@ C_Code.c:634: 		round->hpChange += damage; 
	ldr	r3, [sp, #56]	@ tmp378, round
	strb	r4, [r3, #3]	@ _220, round_10(D)->hpChange
.L248:
@ C_Code.c:693: 	AdjustAllRounds(id, damage, round->hpChange);
	movs	r2, r4	@, _197
	ldr	r0, [sp, #8]	@, %sfp
	bl	AdjustAllRounds		@
@ C_Code.c:695: 	CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp); 
	ldr	r3, [sp, #56]	@ tmp415, round
	mov	r2, fp	@, active_bunit
	str	r3, [sp]	@ tmp415,
	movs	r1, r7	@, HpProc
	mov	r3, r8	@, opp_bunit
	mov	r0, r9	@, proc
	str	r6, [sp, #4]	@ prephitmp_210,
	bl	CheckForDeath		@
.L238:
@ C_Code.c:710: } 
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
.L269:
@ C_Code.c:625: 			HpProc->post -= damage;
	movs	r5, #80	@ tmp239,
@ C_Code.c:625: 			HpProc->post -= damage;
	lsls	r0, r1, #16	@ tmp238, damage,
	lsrs	r0, r0, #16	@ _25, tmp238,
	str	r0, [sp, #12]	@ _25, %sfp
@ C_Code.c:625: 			HpProc->post -= damage;
	mov	r10, r5	@ tmp239, tmp239
@ C_Code.c:625: 			HpProc->post -= damage;
	ldrh	r5, [r7, r5]	@ tmp241,
	subs	r5, r5, r0	@ tmp242, tmp241, _25
	mov	ip, r5	@ tmp242, tmp242
	mov	r5, r10	@ tmp239, tmp239
	mov	r0, ip	@ tmp242, tmp242
	strh	r0, [r7, r5]	@ tmp242, HpProc_21(D)->post
@ C_Code.c:633: 		opp_bunit->unit.curHP -= damage; 
	mov	r0, r8	@ opp_bunit, opp_bunit
	strb	r3, [r0, #19]	@ _217, opp_bunit_34(D)->unit.curHP
@ C_Code.c:634: 		round->hpChange += damage; 
	ldr	r3, [sp, #56]	@ tmp376, round
	strb	r4, [r3, #3]	@ _220, round_10(D)->hpChange
@ C_Code.c:635: 		if (UsingSkillSys == 2) { round->overDmg -= damage; } // used by Huichelaar's banim numbers 
	cmp	r2, #2	@ UsingSkillSys.22_20,
	bne	.L248		@,
@ C_Code.c:635: 		if (UsingSkillSys == 2) { round->overDmg -= damage; } // used by Huichelaar's banim numbers 
	ldr	r3, [sp, #56]	@ tmp379, round
	ldr	r2, [sp, #12]	@ _25, %sfp
	ldrh	r3, [r3, #6]	@ tmp256,
	subs	r3, r3, r2	@ tmp257, tmp256, _25
	ldr	r2, [sp, #56]	@ tmp380, round
	strh	r3, [r2, #6]	@ tmp257, round_10(D)->overDmg
	b	.L248		@
.L268:
@ C_Code.c:620: 		if (hp < 0) { damage -= ABS(hp); } 
	subs	r1, r6, r3	@ damage, tmp222, _11
	b	.L243		@
.L250:
@ C_Code.c:644: 			post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	movs	r2, #82	@ tmp277,
@ C_Code.c:644: 			post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	ldrsh	r5, [r7, r2]	@ post,
	mov	ip, r5	@ post, post
@ C_Code.c:645: 			post += damage; 
	add	r0, r0, ip	@ post, post
@ C_Code.c:646: 			HpProc->postHpAtkrSS = post; 
	strh	r0, [r7, r2]	@ post, HpProc_21(D)->postHpAtkrSS
@ C_Code.c:647: 			HpProc->post = post>>16; 
	subs	r2, r2, #2	@ tmp281,
@ C_Code.c:647: 			HpProc->post = post>>16; 
	asrs	r0, r0, #16	@ tmp280, post,
@ C_Code.c:647: 			HpProc->post = post>>16; 
	strh	r0, [r7, r2]	@ tmp280, HpProc_21(D)->post
@ C_Code.c:649: 		opp_bunit->unit.curHP += damage; 
	mov	r2, r8	@ opp_bunit, opp_bunit
	ldr	r3, [sp, #12]	@ _226, %sfp
	strb	r3, [r2, #19]	@ _226, opp_bunit_34(D)->unit.curHP
@ C_Code.c:650: 		round->hpChange -= damage; 
	ldr	r3, [sp, #56]	@ tmp394, round
	strb	r4, [r3, #3]	@ _229, round_10(D)->hpChange
.L252:
@ C_Code.c:652: 		damage = 0 - damage;
	mov	r3, r10	@ _11, _11
	subs	r1, r1, r3	@ damage, damage, _11
@ C_Code.c:694: 	if (hp < 0) { hp = 0; } 
	mvns	r3, r6	@ tmp343, hp
	asrs	r3, r3, #31	@ tmp342, tmp343,
	ands	r6, r3	@ prephitmp_210, tmp342
	b	.L248		@
.L249:
@ C_Code.c:656: 		if ((hp == 1)) { // deal lethal anyway 
	cmp	r6, #1	@ tmp222,
	beq	.L270		@,
@ C_Code.c:674: 		else if (BlockingCanPreventLethal) { // leave alive with 1 hp 
	ldr	r3, .L272+16	@ tmp307,
@ C_Code.c:674: 		else if (BlockingCanPreventLethal) { // leave alive with 1 hp 
	ldr	r3, [r3]	@ BlockingCanPreventLethal, BlockingCanPreventLethal
	cmp	r3, #0	@ BlockingCanPreventLethal,
	beq	.L271		@,
@ C_Code.c:677: 			if (UsingSkillSys) { // uggggh 
	ldr	r3, .L272+12	@ tmp309,
	ldr	r2, [r3]	@ UsingSkillSys.29_85, UsingSkillSys
@ C_Code.c:687: 			opp_bunit->unit.curHP += 1; 
	mov	r3, r8	@ opp_bunit, opp_bunit
@ C_Code.c:688: 			round->hpChange -= 1; 
	mov	r1, r10	@ _11, _11
@ C_Code.c:687: 			opp_bunit->unit.curHP += 1; 
	ldrb	r3, [r3, #19]	@ tmp311,
@ C_Code.c:688: 			round->hpChange -= 1; 
	subs	r4, r1, #1	@ tmp315, _11,
@ C_Code.c:687: 			opp_bunit->unit.curHP += 1; 
	adds	r3, r3, #1	@ tmp312,
	lsls	r3, r3, #24	@ tmp313, tmp312,
@ C_Code.c:688: 			round->hpChange -= 1; 
	lsls	r4, r4, #24	@ tmp316, tmp315,
@ C_Code.c:687: 			opp_bunit->unit.curHP += 1; 
	asrs	r3, r3, #24	@ _237, tmp313,
@ C_Code.c:688: 			round->hpChange -= 1; 
	asrs	r4, r4, #24	@ _240, tmp316,
@ C_Code.c:677: 			if (UsingSkillSys) { // uggggh 
	cmp	r2, #0	@ UsingSkillSys.29_85,
	beq	.L260		@,
@ C_Code.c:678: 				HpProc->post += 1;
	movs	r0, #80	@ tmp317,
@ C_Code.c:686: 			HpProc->post += 1;
	ldrh	r1, [r7, r0]	@ tmp319,
	adds	r1, r1, #2	@ tmp320,
	strh	r1, [r7, r0]	@ tmp320, HpProc_21(D)->post
@ C_Code.c:687: 			opp_bunit->unit.curHP += 1; 
	mov	r1, r8	@ opp_bunit, opp_bunit
	strb	r3, [r1, #19]	@ _237, opp_bunit_34(D)->unit.curHP
@ C_Code.c:688: 			round->hpChange -= 1; 
	ldr	r3, [sp, #56]	@ tmp409, round
	strb	r4, [r3, #3]	@ _240, round_10(D)->hpChange
@ C_Code.c:689: 			if (UsingSkillSys == 2) { round->overDmg += 1; } 
	cmp	r2, #2	@ UsingSkillSys.29_85,
	bne	.L262		@,
@ C_Code.c:689: 			if (UsingSkillSys == 2) { round->overDmg += 1; } 
	ldr	r3, [sp, #56]	@ tmp412, round
	ldrh	r3, [r3, #6]	@ tmp336,
	ldr	r2, [sp, #56]	@ tmp413, round
	adds	r3, r3, #1	@ tmp337,
	strh	r3, [r2, #6]	@ tmp337, round_10(D)->overDmg
.L262:
@ C_Code.c:690: 			damage = 0 - damage;
	movs	r1, #1	@ tmp339,
	mov	r3, r10	@ _11, _11
@ C_Code.c:693: 	AdjustAllRounds(id, damage, round->hpChange);
	movs	r6, #1	@ prephitmp_210,
@ C_Code.c:690: 			damage = 0 - damage;
	subs	r1, r1, r3	@ damage, tmp339, _11
	b	.L248		@
.L271:
@ C_Code.c:694: 	if (hp < 0) { hp = 0; } 
	mvns	r3, r6	@ tmp345, tmp222
	asrs	r3, r3, #31	@ tmp344, tmp345,
	ands	r6, r3	@ prephitmp_210, tmp344
	b	.L248		@
.L270:
@ C_Code.c:659: 			if (UsingSkillSys) { // uggggh 
	ldr	r3, .L272+12	@ tmp289,
	ldr	r6, [r3]	@ prephitmp_210, UsingSkillSys
@ C_Code.c:669: 			round->hpChange += damage; 
	movs	r3, #2	@ _233,
@ C_Code.c:659: 			if (UsingSkillSys) { // uggggh 
	cmp	r6, #0	@ prephitmp_210,
	beq	.L255		@,
@ C_Code.c:660: 				HpProc->post = 0;
	movs	r2, #80	@ tmp293,
	movs	r1, #0	@ tmp294,
	strh	r1, [r7, r2]	@ tmp294, HpProc_21(D)->post
@ C_Code.c:668: 			opp_bunit->unit.curHP = 0; 
	movs	r2, #0	@ tmp295,
	mov	r1, r8	@ opp_bunit, opp_bunit
	strb	r2, [r1, #19]	@ tmp295, opp_bunit_34(D)->unit.curHP
@ C_Code.c:669: 			round->hpChange += damage; 
	ldr	r2, [sp, #56]	@ tmp401, round
@ C_Code.c:693: 	AdjustAllRounds(id, damage, round->hpChange);
	movs	r4, #2	@ _197,
@ C_Code.c:669: 			round->hpChange += damage; 
	strb	r3, [r2, #3]	@ _233, round_10(D)->hpChange
@ C_Code.c:670: 			if (UsingSkillSys == 2) { round->overDmg -= damage; } 
	cmp	r6, #2	@ prephitmp_210,
	bne	.L257		@,
@ C_Code.c:670: 			if (UsingSkillSys == 2) { round->overDmg -= damage; } 
	ldr	r3, [sp, #56]	@ tmp404, round
	ldrh	r3, [r3, #6]	@ tmp304,
	ldr	r2, [sp, #56]	@ tmp405, round
	subs	r3, r3, #1	@ tmp305,
	strh	r3, [r2, #6]	@ tmp305, round_10(D)->overDmg
.L257:
@ C_Code.c:671: 			damage = 0 - damage;
	movs	r1, #1	@ damage,
@ C_Code.c:614: 	if (!damage) { damage = 1; } 
	movs	r6, #0	@ prephitmp_210,
@ C_Code.c:671: 			damage = 0 - damage;
	rsbs	r1, r1, #0	@ damage, damage
	b	.L248		@
.L255:
@ C_Code.c:668: 			opp_bunit->unit.curHP = 0; 
	mov	r2, r8	@ opp_bunit, opp_bunit
@ C_Code.c:671: 			damage = 0 - damage;
	movs	r1, #1	@ damage,
@ C_Code.c:666: 				HpProc->post = post>>16; 
	str	r6, [r7, #80]	@ prephitmp_210, MEM <vector(2) short int> [(short int *)HpProc_21(D) + 80B]
@ C_Code.c:668: 			opp_bunit->unit.curHP = 0; 
	strb	r6, [r2, #19]	@ prephitmp_210, opp_bunit_34(D)->unit.curHP
@ C_Code.c:669: 			round->hpChange += damage; 
	ldr	r2, [sp, #56]	@ tmp403, round
@ C_Code.c:693: 	AdjustAllRounds(id, damage, round->hpChange);
	movs	r4, #2	@ _197,
@ C_Code.c:669: 			round->hpChange += damage; 
	strb	r3, [r2, #3]	@ _233, round_10(D)->hpChange
@ C_Code.c:671: 			damage = 0 - damage;
	rsbs	r1, r1, #0	@ damage, damage
	b	.L248		@
.L260:
@ C_Code.c:681: 				post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	movs	r1, #82	@ tmp325,
@ C_Code.c:681: 				post = HpProc->postHpAtkrSS; // we only need the lower 16 bits anyway 
	ldrsh	r2, [r7, r1]	@ post,
@ C_Code.c:682: 				post += 1; 
	adds	r2, r2, #1	@ post,
@ C_Code.c:683: 				HpProc->postHpAtkrSS = post; 
	strh	r2, [r7, r1]	@ post, HpProc_21(D)->postHpAtkrSS
@ C_Code.c:684: 				HpProc->post = post>>16; 
	asrs	r2, r2, #16	@ tmp328, post,
@ C_Code.c:686: 			HpProc->post += 1;
	adds	r2, r2, #1	@ tmp330,
	subs	r1, r1, #2	@ tmp331,
	strh	r2, [r7, r1]	@ tmp330, HpProc_21(D)->post
@ C_Code.c:687: 			opp_bunit->unit.curHP += 1; 
	mov	r2, r8	@ opp_bunit, opp_bunit
	strb	r3, [r2, #19]	@ _237, opp_bunit_34(D)->unit.curHP
@ C_Code.c:688: 			round->hpChange -= 1; 
	ldr	r3, [sp, #56]	@ tmp411, round
	strb	r4, [r3, #3]	@ _240, round_10(D)->hpChange
	b	.L262		@
.L273:
	.align	2
.L272:
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
@ C_Code.c:509: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	movs	r5, #11	@ tmp129,
	movs	r4, #192	@ tmp130,
	ldrsb	r5, [r2, r5]	@ tmp129,
@ C_Code.c:549: void AdjustDamageWithGetter(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int success) { 
	sub	sp, sp, #8	@,,
@ C_Code.c:509: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	ands	r4, r5	@ _29, tmp129
@ C_Code.c:508: 	if (success) { 
	ldr	r5, [sp, #28]	@ tmp149, success
	cmp	r5, #0	@ tmp149,
	beq	.L275		@,
@ C_Code.c:509: 		if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _29,
	beq	.L292		@,
@ C_Code.c:513: 		return BonusDamagePercent; 
	ldr	r4, .L294	@ tmp134,
	ldr	r4, [r4]	@ _19,
.L278:
@ C_Code.c:551: 	if (percent != 100) { 
	cmp	r4, #100	@ _19,
	beq	.L274		@,
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r6, [r0, #60]	@ _24, proc_7(D)->currentRound
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r5, [r6]	@ *_24, *_24
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsls	r5, r5, #30	@ tmp147, *_24,
	bmi	.L274		@,
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	movs	r5, #3	@ tmp142,
	ldrsb	r5, [r6, r5]	@ tmp142,
	cmp	r5, #0	@ tmp142,
	bne	.L293		@,
.L274:
@ C_Code.c:554: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L292:
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L294+4	@ tmp131,
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, [r4]	@ BlockingEnabled, BlockingEnabled
	cmp	r4, #0	@ BlockingEnabled,
	beq	.L274		@,
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	ldr	r4, .L294+8	@ tmp133,
	ldr	r4, [r4]	@ _19,
@ C_Code.c:510: 			if (BlockingEnabled) { return ReducedDamagePercent; }
	b	.L278		@
.L275:
@ C_Code.c:515: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r4, #128	@ _29,
	beq	.L274		@,
@ C_Code.c:518: 	return FailedHitDamagePercent; 
	ldr	r4, .L294+12	@ tmp135,
	ldr	r4, [r4]	@ _19,
	b	.L278		@
.L293:
	str	r4, [sp, #4]	@ _19,
	ldr	r4, [sp, #24]	@ tmp150, round
	str	r4, [sp]	@ tmp150,
	bl	AdjustDamageByPercent.part.0		@
@ C_Code.c:554: } 
	b	.L274		@
.L295:
	.align	2
.L294:
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
@ C_Code.c:434: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldr	r3, .L332	@ tmp164,
@ C_Code.c:434: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	ldrh	r5, [r3, #8]	@ tmp167,
	ldrh	r3, [r3, #4]	@ tmp169,
@ C_Code.c:434: 	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	orrs	r5, r3	@ keys, tmp169
@ C_Code.c:438: 	int x = proc->anim2->xPosition; 
	ldr	r3, [r0, #48]	@ proc_5(D)->anim2, proc_5(D)->anim2
@ C_Code.c:432: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r7, r2	@ round, tmp259
@ C_Code.c:438: 	int x = proc->anim2->xPosition; 
	movs	r2, #2	@ tmp268,
	ldrsh	r3, [r3, r2]	@ x, proc_5(D)->anim2, tmp268
	mov	r8, r3	@ x, x
@ C_Code.c:439: 	struct BattleUnit* active_bunit = proc->active_bunit; 
	ldr	r3, [r0, #64]	@ active_bunit, proc_5(D)->active_bunit
	mov	r9, r3	@ active_bunit, active_bunit
@ C_Code.c:440: 	struct BattleUnit* opp_bunit = proc->opp_bunit; 
	ldr	r3, [r0, #68]	@ opp_bunit, proc_5(D)->opp_bunit
	mov	r10, r3	@ opp_bunit, opp_bunit
@ C_Code.c:441: 	int hitTime = !proc->EkrEfxIsUnitHittedNowFrames; 
	movs	r3, #82	@ tmp173,
@ C_Code.c:442: 	if (hitTime) { // 1 frame 
	ldrb	r3, [r0, r3]	@ tmp174,
@ C_Code.c:432: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r4, r0	@ proc, tmp257
	movs	r6, r1	@ HpProc, tmp258
	sub	sp, sp, #8	@,,
@ C_Code.c:442: 	if (hitTime) { // 1 frame 
	cmp	r3, #0	@ tmp174,
	bne	.L298		@,
@ C_Code.c:444: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	ldr	r2, [r0, #56]	@ proc_5(D)->timer2, proc_5(D)->timer2
	cmp	r2, #255	@ proc_5(D)->timer2,
	bne	.LCB1907	@
	b	.L329	@long jump	@
.LCB1907:
.L299:
@ C_Code.c:445: 		SaveInputFrame(proc, keys); 
	movs	r1, r5	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
@ C_Code.c:446: 		SaveIfWeHitOnTime(proc);
	movs	r0, r4	@, proc
	bl	SaveIfWeHitOnTime		@
@ C_Code.c:447: 		if (!proc->adjustedDmg) { 
	movs	r3, #74	@ tmp177,
@ C_Code.c:447: 		if (!proc->adjustedDmg) { 
	ldrb	r2, [r4, r3]	@ tmp178,
	cmp	r2, #0	@ tmp178,
	bne	.L298		@,
@ C_Code.c:381: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r2, .L332+4	@ tmp179,
@ C_Code.c:385: 	if (CheatCodeOn()) { return true; } 
	ldrb	r2, [r2, #31]	@ tmp182,
	cmp	r2, #127	@ tmp182,
	bhi	.L301		@,
@ C_Code.c:386: 	if (AlwaysWork) { return true; } 
	ldr	r2, .L332+8	@ tmp183,
@ C_Code.c:386: 	if (AlwaysWork) { return true; } 
	ldr	r2, [r2]	@ AlwaysWork, AlwaysWork
	cmp	r2, #0	@ AlwaysWork,
	bne	.L301		@,
@ C_Code.c:387: 	return proc->hitOnTime;
	adds	r2, r2, #72	@ tmp185,
@ C_Code.c:448: 			if (DidWeHitOnTime(proc)) { 
	ldrb	r2, [r4, r2]	@ tmp186,
	cmp	r2, #0	@ tmp186,
	bne	.L301		@,
@ C_Code.c:454: 				proc->adjustedDmg = true; 
	movs	r2, #1	@ tmp197,
	strb	r2, [r4, r3]	@ tmp197, proc_5(D)->adjustedDmg
@ C_Code.c:515: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	mov	r3, r9	@ active_bunit, active_bunit
	movs	r2, #11	@ tmp199,
	ldrsb	r2, [r3, r2]	@ tmp199,
	movs	r3, #192	@ tmp200,
	ands	r3, r2	@ tmp201, tmp199
@ C_Code.c:515: 	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { 
	cmp	r3, #128	@ tmp201,
	beq	.L304		@,
@ C_Code.c:518: 	return FailedHitDamagePercent; 
	ldr	r3, .L332+12	@ tmp202,
	ldr	r3, [r3]	@ _80, FailedHitDamagePercent
@ C_Code.c:551: 	if (percent != 100) { 
	cmp	r3, #100	@ _80,
	beq	.L304		@,
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r1, [r4, #60]	@ _85, proc_5(D)->currentRound
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r2, [r1]	@ *_85, *_85
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsls	r2, r2, #30	@ tmp265, *_85,
	bmi	.L304		@,
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	movs	r2, #3	@ tmp209,
	ldrsb	r2, [r1, r2]	@ tmp209,
	cmp	r2, #0	@ tmp209,
	beq	.L304		@,
	str	r3, [sp, #4]	@ _80,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	movs	r1, r6	@, HpProc
	movs	r0, r4	@, proc
	str	r7, [sp]	@ round,
	bl	AdjustDamageByPercent.part.0		@
	b	.L304		@
.L301:
@ C_Code.c:242: 	if (proc->broke) { return; } 
	movs	r3, #75	@ tmp187,
@ C_Code.c:242: 	if (proc->broke) { return; } 
	ldrb	r2, [r4, r3]	@ tmp188,
	cmp	r2, #0	@ tmp188,
	bne	.L303		@,
@ C_Code.c:243: 	proc->broke = true; 
	adds	r2, r2, #1	@ tmp190,
	strb	r2, [r4, r3]	@ tmp190, proc_5(D)->broke
@ C_Code.c:244: 	asm("mov r11, r11");
	.syntax divided
@ 244 "C_Code.c" 1
	mov r11, r11
@ 0 "" 2
	.thumb
	.syntax unified
.L303:
@ C_Code.c:450: 				proc->adjustedDmg = true; 
	movs	r3, #1	@ tmp193,
	movs	r2, #74	@ tmp192,
@ C_Code.c:451: 				AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true); 
	movs	r1, r6	@, HpProc
@ C_Code.c:450: 				proc->adjustedDmg = true; 
	strb	r3, [r4, r2]	@ tmp193, proc_5(D)->adjustedDmg
@ C_Code.c:451: 				AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true); 
	movs	r0, r4	@, proc
	str	r3, [sp, #4]	@ tmp193,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	str	r7, [sp]	@ round,
	bl	AdjustDamageWithGetter		@
.L304:
@ C_Code.c:460: 			CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, (-1)); 
	movs	r3, #1	@ tmp210,
	rsbs	r3, r3, #0	@ tmp210, tmp210
	str	r3, [sp, #4]	@ tmp210,
	mov	r2, r9	@, active_bunit
	mov	r3, r10	@, opp_bunit
	movs	r1, r6	@, HpProc
	movs	r0, r4	@, proc
	str	r7, [sp]	@ round,
	bl	CheckForDeath		@
.L298:
@ C_Code.c:465: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	movs	r3, #77	@ tmp211,
@ C_Code.c:465: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r0, [r4, r3]	@ tmp212,
	ldr	r3, .L332+16	@ tmp213,
	bl	.L85		@
@ C_Code.c:465: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	cmp	r0, #0	@ tmp214,
	bne	.L305		@,
@ C_Code.c:465: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	movs	r3, #79	@ tmp216,
@ C_Code.c:465: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r3, [r4, r3]	@ tmp217,
	cmp	r3, #255	@ tmp217,
	beq	.L330		@,
.L305:
@ C_Code.c:381: 	return (gPlaySt.unk1F & 0x80); // 202BD0F
	ldr	r3, .L332+4	@ tmp220,
@ C_Code.c:385: 	if (CheatCodeOn()) { return true; } 
	ldrb	r3, [r3, #31]	@ tmp223,
@ C_Code.c:485: 		else if (proc->timer2 < 20) { 
	ldr	r5, [r4, #56]	@ pretmp_99, proc_5(D)->timer2
@ C_Code.c:385: 	if (CheatCodeOn()) { return true; } 
	cmp	r3, #127	@ tmp223,
	bhi	.L307		@,
@ C_Code.c:386: 	if (AlwaysWork) { return true; } 
	ldr	r3, .L332+8	@ tmp224,
@ C_Code.c:386: 	if (AlwaysWork) { return true; } 
	ldr	r3, [r3]	@ AlwaysWork, AlwaysWork
	cmp	r3, #0	@ AlwaysWork,
	bne	.L307		@,
@ C_Code.c:387: 	return proc->hitOnTime;
	adds	r3, r3, #72	@ tmp226,
@ C_Code.c:468: 		if (DidWeHitOnTime(proc)) { 
	ldrb	r3, [r4, r3]	@ tmp227,
	cmp	r3, #0	@ tmp227,
	bne	.L307		@,
@ C_Code.c:485: 		else if (proc->timer2 < 20) { 
	cmp	r5, #19	@ pretmp_99,
	bgt	.L309		@,
@ C_Code.c:391: 	if (!DisplayPress) { return; } 
	ldr	r3, .L332+20	@ tmp243,
@ C_Code.c:391: 	if (!DisplayPress) { return; } 
	ldr	r3, [r3]	@ DisplayPress, DisplayPress
	cmp	r3, #0	@ DisplayPress,
	beq	.L309		@,
	movs	r3, #14	@,
	movs	r2, #24	@,
	mov	r1, r8	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L309		@
.L307:
@ C_Code.c:480: 			if (((y > (-16)) && (y < (161)))) { 
	movs	r3, #63	@ tmp228,
	subs	r3, r3, r5	@ tmp229, tmp228, pretmp_99
@ C_Code.c:480: 			if (((y > (-16)) && (y < (161)))) { 
	cmp	r3, #175	@ tmp229,
	bls	.L331		@,
.L309:
@ C_Code.c:488: 		proc->roundEnd = true; 
	movs	r3, #81	@ tmp245,
	movs	r2, #1	@ tmp246,
	strb	r2, [r4, r3]	@ tmp246, proc_5(D)->roundEnd
.L296:
@ C_Code.c:504: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r5, r6, r7}
	mov	r10, r7
	mov	r9, r6
	mov	r8, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L329:
@ C_Code.c:444: 		if (proc->timer2 == 0xFF) { proc->timer2 = 0; }  
	str	r3, [r0, #56]	@ tmp174, proc_5(D)->timer2
	b	.L299		@
.L330:
@ C_Code.c:465: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	subs	r3, r3, #175	@ tmp218,
@ C_Code.c:465: 	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	ldrb	r3, [r4, r3]	@ tmp219,
	cmp	r3, #255	@ tmp219,
	bne	.L305		@,
@ C_Code.c:492: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	ldr	r3, [r4, #52]	@ proc_5(D)->timer, proc_5(D)->timer
	cmp	r3, #0	@ proc_5(D)->timer,
	bgt	.L311		@,
@ C_Code.c:492: 		if (proc->timer < 1) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
	movs	r3, #78	@ tmp249,
	strb	r0, [r4, r3]	@ tmp214, proc_5(D)->frame
.L312:
@ C_Code.c:497: 		if (!proc->roundEnd) { 
	movs	r3, #81	@ tmp252,
@ C_Code.c:497: 		if (!proc->roundEnd) { 
	ldrb	r3, [r4, r3]	@ tmp253,
	cmp	r3, #0	@ tmp253,
	bne	.L296		@,
@ C_Code.c:391: 	if (!DisplayPress) { return; } 
	ldr	r3, .L332+20	@ tmp254,
@ C_Code.c:391: 	if (!DisplayPress) { return; } 
	ldr	r3, [r3]	@ DisplayPress, DisplayPress
	cmp	r3, #0	@ DisplayPress,
	beq	.L296		@,
	movs	r3, #15	@,
	movs	r2, #24	@,
	mov	r1, r8	@, x
	movs	r0, r4	@, proc
	bl	DrawButtonsToPress.part.0		@
	b	.L296		@
.L331:
@ C_Code.c:475: 			x += Mod(clock, 8) >> 1; 
	movs	r1, #8	@,
	movs	r0, r5	@, pretmp_99
	ldr	r3, .L332+24	@ tmp230,
	bl	.L85		@
@ C_Code.c:477: 			y -= clock; 
	movs	r1, #48	@ tmp233,
@ C_Code.c:481: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	movs	r2, #255	@ tmp235,
@ C_Code.c:477: 			y -= clock; 
	subs	r1, r1, r5	@ y, tmp233, pretmp_99
@ C_Code.c:481: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	ands	r2, r1	@ tmp236, y
@ C_Code.c:475: 			x += Mod(clock, 8) >> 1; 
	asrs	r1, r0, #1	@ tmp237, tmp261,
@ C_Code.c:481: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	movs	r0, #224	@ tmp241,
@ C_Code.c:475: 			x += Mod(clock, 8) >> 1; 
	add	r1, r1, r8	@ x, x
@ C_Code.c:481: 				PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2); 
	lsls	r0, r0, #8	@ tmp241, tmp241,
	lsls	r1, r1, #23	@ tmp240, x,
	str	r0, [sp]	@ tmp241,
	ldr	r3, .L332+28	@ tmp232,
	movs	r0, #0	@,
	ldr	r5, .L332+32	@ tmp242,
	lsrs	r1, r1, #23	@ tmp239, tmp240,
	bl	.L104		@
	b	.L309		@
.L311:
@ C_Code.c:495: 			SaveInputFrame(proc, keys); 
	movs	r1, r5	@, keys
	movs	r0, r4	@, proc
	bl	SaveInputFrame		@
	b	.L312		@
.L333:
	.align	2
.L332:
	.word	sKeyStatusBuffer
	.word	gPlaySt
	.word	AlwaysWork
	.word	FailedHitDamagePercent
	.word	EkrEfxIsUnitHittedNow
	.word	DisplayPress
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
@ C_Code.c:432: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r6, r3	@ round, tmp127
@ C_Code.c:93: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L336	@ tmp120,
@ C_Code.c:432: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r4, r0	@ proc, tmp125
@ C_Code.c:93: 	return !CheckFlag(DisabledFlag); 
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L336+4	@ tmp122,
@ C_Code.c:432: void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct NewProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	movs	r5, r2	@ HpProc, tmp126
@ C_Code.c:93: 	return !CheckFlag(DisabledFlag); 
	bl	.L85		@
@ C_Code.c:433: 	if (!AreTimedHitsEnabled()) { return; } 
	cmp	r0, #0	@ tmp128,
	bne	.L334		@,
	movs	r2, r6	@, round
	movs	r1, r5	@, HpProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit.part.0		@
.L334:
@ C_Code.c:504: } 
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L337:
	.align	2
.L336:
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
@ C_Code.c:256: 	if (!proc->anim) { return; } 
	ldr	r3, [r0, #44]	@ proc_25(D)->anim, proc_25(D)->anim
@ C_Code.c:255: void LoopTimedHitsProc(TimedHitsProc* proc) { 
	movs	r4, r0	@ proc, tmp181
	sub	sp, sp, #8	@,,
@ C_Code.c:256: 	if (!proc->anim) { return; } 
	cmp	r3, #0	@ proc_25(D)->anim,
	beq	.L338		@,
@ C_Code.c:258: 	struct ProcEkrBattle* battleProc = gpProcEkrBattle; 
	ldr	r3, .L361	@ tmp143,
@ C_Code.c:260: 	if (!battleProc) { return; } 
	ldr	r3, [r3]	@ gpProcEkrBattle, gpProcEkrBattle
	cmp	r3, #0	@ gpProcEkrBattle,
	beq	.L338		@,
@ C_Code.c:261: 	if (!proc->anim2) { return; } 
	ldr	r3, [r0, #48]	@ proc_25(D)->anim2, proc_25(D)->anim2
	cmp	r3, #0	@ proc_25(D)->anim2,
	beq	.L338		@,
@ C_Code.c:263: 	proc->timer++;
	ldr	r3, [r0, #52]	@ proc_25(D)->timer, proc_25(D)->timer
	adds	r3, r3, #1	@ tmp146,
	str	r3, [r0, #52]	@ tmp146, proc_25(D)->timer
@ C_Code.c:264: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	ldr	r3, [r0, #56]	@ _5, proc_25(D)->timer2
@ C_Code.c:264: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	cmp	r3, #255	@ _5,
	beq	.L342		@,
@ C_Code.c:264: 	if (proc->timer2 != 0xFF) { proc->timer2++; } 
	adds	r3, r3, #1	@ tmp148,
	str	r3, [r0, #56]	@ tmp148, proc_25(D)->timer2
.L342:
@ C_Code.c:268: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	movs	r5, #82	@ tmp149,
	ldrb	r3, [r4, r5]	@ _7,
@ C_Code.c:266: 	struct SkillSysBattleHit* currentRound = proc->currentRound; 
	ldr	r6, [r4, #60]	@ currentRound, proc_25(D)->currentRound
@ C_Code.c:268: 	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
	cmp	r3, #255	@ _7,
	beq	.L343		@,
@ C_Code.c:269: 		proc->EkrEfxIsUnitHittedNowFrames++; 
	adds	r3, r3, #1	@ tmp150,
	strb	r3, [r4, r5]	@ tmp150, proc_25(D)->EkrEfxIsUnitHittedNowFrames
.L344:
@ C_Code.c:274: 	struct NewProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	ldr	r3, .L361+4	@ tmp161,
	ldr	r0, [r3]	@ gProcScr_efxHPBar, gProcScr_efxHPBar
	ldr	r3, .L361+8	@ tmp163,
	bl	.L85		@
@ C_Code.c:93: 	return !CheckFlag(DisabledFlag); 
	ldr	r3, .L361+12	@ tmp164,
@ C_Code.c:274: 	struct NewProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	movs	r5, r0	@ HpProc, tmp183
@ C_Code.c:93: 	return !CheckFlag(DisabledFlag); 
	ldr	r0, [r3]	@ DisabledFlag, DisabledFlag
	ldr	r3, .L361+16	@ tmp166,
	bl	.L85		@
@ C_Code.c:433: 	if (!AreTimedHitsEnabled()) { return; } 
	cmp	r0, #0	@ tmp184,
	bne	.L345		@,
	movs	r2, r6	@, currentRound
	movs	r1, r5	@, HpProc
	movs	r0, r4	@, proc
	bl	DoStuffIfHit.part.0		@
.L345:
@ C_Code.c:249: 	if (!HpProc) { return false; } // 
	cmp	r5, #0	@ HpProc,
	beq	.L338		@,
@ C_Code.c:251: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	movs	r3, #82	@ tmp169,
@ C_Code.c:251: 	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	ldrb	r3, [r4, r3]	@ tmp170,
	cmp	r3, #0	@ tmp170,
	bne	.L338		@,
@ C_Code.c:277: 		int x = BAN_DisplayDamage(proc->anim2, 0, 0, 0, proc->roundId); 
	movs	r6, #73	@ tmp172,
@ C_Code.c:277: 		int x = BAN_DisplayDamage(proc->anim2, 0, 0, 0, proc->roundId); 
	ldrb	r3, [r4, r6]	@ tmp173,
	movs	r1, #0	@,
	movs	r2, #0	@,
	ldr	r0, [r4, #48]	@ proc_25(D)->anim2, proc_25(D)->anim2
	ldr	r5, .L361+20	@ tmp174,
	str	r3, [sp]	@ tmp173,
	movs	r3, #0	@,
	bl	.L104		@
	movs	r3, r0	@ x, tmp185
@ C_Code.c:278: 		x = BAN_DisplayDamage(proc->anim, 1, proc->anim->xPosition, x, proc->roundId);  
	ldr	r0, [r4, #44]	@ _16, proc_25(D)->anim
	movs	r1, #2	@ tmp189,
	ldrsh	r2, [r0, r1]	@ tmp175, _16, tmp189
	ldrb	r1, [r4, r6]	@ tmp177,
	str	r1, [sp]	@ tmp177,
	movs	r1, #1	@,
	bl	.L104		@
.L338:
@ C_Code.c:281: } 
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L343:
@ C_Code.c:271: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #77	@ tmp153,
@ C_Code.c:271: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	ldrb	r0, [r4, r3]	@ tmp154,
	ldr	r3, .L361+24	@ tmp155,
	bl	.L85		@
@ C_Code.c:271: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	cmp	r0, #0	@ tmp182,
	beq	.L344		@,
@ C_Code.c:271: 	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	movs	r3, #0	@ tmp159,
	strb	r3, [r4, r5]	@ tmp159, proc_25(D)->EkrEfxIsUnitHittedNowFrames
	b	.L344		@
.L362:
	.align	2
.L361:
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
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r5, [r0, #60]	@ _1, proc_7(D)->currentRound
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	ldr	r4, [r5]	@ *_1, *_1
@ C_Code.c:605: void AdjustDamageByPercent(TimedHitsProc* proc, struct NewProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	sub	sp, sp, #12	@,,
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	lsls	r4, r4, #30	@ tmp135, *_1,
	bmi	.L363		@,
@ C_Code.c:607: 	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	movs	r4, #3	@ tmp130,
	ldrsb	r4, [r5, r4]	@ tmp130,
	cmp	r4, #0	@ tmp130,
	bne	.L369		@,
.L363:
@ C_Code.c:710: } 
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L369:
	ldr	r4, [sp, #28]	@ tmp137, percent
	str	r4, [sp, #4]	@ tmp137,
	ldr	r4, [sp, #24]	@ tmp138, round
	str	r4, [sp]	@ tmp138,
	bl	AdjustDamageByPercent.part.0		@
	b	.L363		@
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
@ C_Code.c:721: 	int result = gPlaySt.config.animationType; 
	movs	r2, #66	@ tmp130,
@ C_Code.c:720: int GetBattleAnimPreconfType(void) {
	push	{r4, lr}	@
@ C_Code.c:721: 	int result = gPlaySt.config.animationType; 
	ldr	r3, .L382	@ tmp164,
	ldrb	r0, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:722: 	if (!CheatCodeOn()) { 
	ldrb	r2, [r3, #31]	@ tmp139,
@ C_Code.c:721: 	int result = gPlaySt.config.animationType; 
	lsls	r0, r0, #29	@ tmp134, gPlaySt,
@ C_Code.c:721: 	int result = gPlaySt.config.animationType; 
	lsrs	r0, r0, #30	@ <retval>, tmp134,
@ C_Code.c:722: 	if (!CheatCodeOn()) { 
	cmp	r2, #127	@ tmp139,
	bhi	.L371		@,
@ C_Code.c:723: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, .L382+4	@ tmp140,
@ C_Code.c:723: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	ldr	r2, [r2]	@ ForceAnimsOn, ForceAnimsOn
	cmp	r2, #0	@ ForceAnimsOn,
	beq	.L371		@,
@ C_Code.c:723: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	cmp	r0, #2	@ <retval>,
	beq	.L370		@,
.L374:
@ C_Code.c:723: 		if (ForceAnimsOn) { if (result == 2) { return 2; } else { return 1; } } 
	movs	r0, #1	@ <retval>,
.L370:
@ C_Code.c:744: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L371:
@ C_Code.c:726:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r2, #66	@ tmp143,
	ldrb	r2, [r3, r2]	@ gPlaySt, gPlaySt
@ C_Code.c:726:     if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
	movs	r3, #6	@ tmp149,
	ands	r3, r2	@ tmp150, gPlaySt
	cmp	r3, #4	@ tmp150,
	bne	.L370		@,
@ C_Code.c:730:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	movs	r1, #11	@ tmp154,
@ C_Code.c:731:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	movs	r4, #11	@ pretmp_25,
@ C_Code.c:730:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldr	r0, .L382+8	@ tmp153,
@ C_Code.c:731:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldr	r2, .L382+12	@ tmp152,
@ C_Code.c:730:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	ldrsb	r1, [r0, r1]	@ tmp154,
	adds	r3, r3, #188	@ tmp155,
@ C_Code.c:731:         if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
	ldrsb	r4, [r2, r4]	@ pretmp_25,* pretmp_25
@ C_Code.c:730:     if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
	tst	r3, r1	@ tmp155, tmp154
	beq	.L381		@,
@ C_Code.c:736:         if (UNIT_FACTION(&gBattleTarget.unit) != FACTION_BLUE)
	tst	r3, r4	@ tmp155, pretmp_25
	bne	.L374		@,
@ C_Code.c:743:         return GetSoloAnimPreconfType(&gBattleTarget.unit);
	movs	r0, r2	@, tmp152
.L381:
	ldr	r3, .L382+16	@ tmp162,
	bl	.L85		@
	b	.L370		@
.L383:
	.align	2
.L382:
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
.LC97:
	.ascii	"TimedHitsProcName\000"
	.global	gEkrBg2QuakeVec
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
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
	.type	TimedHitsProcCmd, %object
	.size	TimedHitsProcCmd, 32
TimedHitsProcCmd:
@ opcode:
	.short	1
@ dataImm:
	.short	0
@ dataPtr:
	.word	.LC97
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
.L85:
	bx	r3
.L172:
	bx	r4
.L104:
	bx	r5
.L80:
	bx	r7
.L23:
	bx	r9
.L81:
	bx	r10
