.thumb 
.global AnyTargetWithinRange 
.type AnyTargetWithinRange, %function 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ GetUnit, 0x8019430 
	.equ MemorySlot, 0x30004B8
	.equ GetUnitByEventParameter, 0x0800BC50
@ 0803d450 AiTryDoOffensiveAction
AnyTargetWithinRange:
push {r4-r7, lr} 
mov r7, r8 
push {r7}  
mov r6, r9 
push {r6} 

mov r5, #0 @ We default to False 
ldr r6, =MemorySlot 
ldr r0, [r6, #4] @ Slot 1 as unit 
blh GetUnitByEventParameter 
cmp r0, #0 
beq BreakAnyoneWithinRangeLoop
mov r6, r0 @ actor 
mov r0, #0 
mov r8, r0 @ Searching players, NPCs, or enemies 

@ tried to optimize a little for speed 

@ Enemy will do PlayerRam - Start of EnemyRam 
@ NPC will do EnemyRam-End of EnemyRam 

NextAllegiance: 
mov r1, r8 
add r1, #1 
mov r8, r1 

cmp r1, #1 
beq SetupPlayerRamAddresses
cmp r1, #2 
beq SetupNPCRamAddresses
cmp r1, #3 
beq SetupEnemyRamAddresses
b BreakAnyoneWithinRangeLoop 

SetupPlayerRamAddresses:
mov r4, #0x0 
mov r0, #0x3F
mov r9, r0 
b AnyoneWithinRangeLoop

SetupNPCRamAddresses:
mov r4, #0x40 
mov r0, #0x7F
mov r9, r0 
b AnyoneWithinRangeLoop

SetupEnemyRamAddresses:
mov r4, #0x80 
mov r0, #0xBF
mov r9, r0 
b AnyoneWithinRangeLoop

AnyoneWithinRangeLoop:
add r4, #1 @ Unit we're checking 
cmp r4, r9 
bgt NextAllegiance
mov r0, r4 
blh GetUnit 
cmp r0, #0 
beq AnyoneWithinRangeLoop
ldr r1, [r0] 
cmp r1, #0 
beq AnyoneWithinRangeLoop
ldr r1, [r0, #0x0C] 
ldr r2, =0x1000C @ escaped, dead, undeployed 
and r1, r2 
cmp r1, #0 
bne AnyoneWithinRangeLoop


@ same as AreUnitsAllied at 24D8C 
ldrb r3, [r6, #0x0B] @ CurrentUnit Allegiance 
mov r2, #0x80 
ldrb r1, [r0, #0x0B] @ Target Allegiance 
and r1, r2 
and r2, r3  
cmp r2, r1 
beq NextAllegiance
mov r7, #0x1C @ Weapon index -2
ContinueAnyoneWithinRangeLoop:
add r7, #2 
cmp r7, #0x26 
bgt AnyoneWithinRangeLoop 
mov r1, r0 @ Target 
mov r0, r6 
ldrh r2, [r6, r7]
cmp r2, #0 @ 
beq AnyoneWithinRangeLoop @ No weapon, so move on to next unit 
@ r0 actor, r1 target, r2 weapon 
push {r1-r2} @ target, wep
blh 0x803AC3C @ CouldStationaryUnitBeInRangeHeuristic
pop {r1-r2} 

mov r3, r0
mov r0, r1 @ for loop  
cmp r3, #1 
bne ContinueAnyoneWithinRangeLoop @ try next weapon 
push {r1}
@mov r0, r1 @ target doesn't make sense lol 
mov r0, r6 @ actor 
mov r1, r2 @ wep 
blh 0x803B558 @ FillMovementAndRangeMapForItem
pop {r1} 



ldrb r0, [r1, #0x10] @ X 
ldrb r1, [r1, #0x11] @ Y 

ldr r2, =0x202E4E4	@Range map
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates
cmp r0, #0 
beq AnyoneWithinRangeLoop 

mov r5, #1 @ True 

BreakAnyoneWithinRangeLoop:
mov r0, r5 
ldr r3, =MemorySlot 
add r3, #0x0C*4 
str r0, [r3] 

pop {r6}
mov r9, r6 
pop {r7} 
mov r8, r7 
pop {r4-r7}
pop {r1}
bx r1 
.ltorg 

