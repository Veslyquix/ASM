.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ gChapterData, 0x202BCF0
.equ GetUnit, 0x8019430
.equ MakeItemShort,  0x08016540  @ given r0 = item ID, return item with full durability 
.equ UnitAutolevelWExp, 0x8017F20 @ r0 = unit, r1 = unitDef 
.type ReplaceWeaponsByDifficulty, %function 
.global ReplaceWeaponsByDifficulty
ReplaceWeaponsByDifficulty: 
push {r4-r7, lr} 
bl GetDifficulty 
add r0, #1 @ for the offset of the list 
mov r7, r0 
mov r4, #0x7F 
Loop:
add r4, #1 
cmp r4, #0xBF 
bge Exit
mov r0, r4 
blh GetUnit 
mov r5, r0 
bl IsUnitFielded 
cmp r0, #0 
beq Loop 
mov r6, #0x1c 
InvLoop: 
add r6, #2 
cmp r6, #0x28 
bge Loop 
ldrh r0, [r5, r6] 
cmp r0, #0 
beq Loop
bl ReplaceWepByDifficulty
b InvLoop 
Exit: 
pop {r4-r7} 
pop {r0} 
bx r0
.ltorg 

ReplaceWepByDifficulty: 
push {lr} 
@ r0 = wep
ldr r3, =ReplaceWepList 
mov r1, #0xFF 
and r0, r1 
sub r3, #4
WepLoop: 
add r3, #4 
ldr r2, [r3] 
mov r1, #0 
sub r1, #1 @ 0xFFFFFFFF 
cmp r2, r1
beq Break 
ldrb r2, [r3] 
cmp r0, r2 
bne WepLoop 
mov r1, r7 @ difficulty 2 = hard, 1 = normal, 0 = easy 
ldrb r0, [r3, r1] @ new wep 
blh MakeItemShort 
strh r0, [r5, r6] @ parent always has r5 unit and r6 offset 
mov r0, r5 @ unit 
ldr r1, =ReplaceWepsUnitDef
@ this function does not care about the unit def *except* for the "autolevel: true" part 
@ the unitDef can be anything 
blh UnitAutolevelWExp @ ensure they can use this weapon 
Break: 
pop {r0} 
bx r0 

IsUnitFielded: 
cmp r0, #0 
beq RetFalse
ldr r1, [r0] 
cmp r1, #0 
beq RetFalse 
ldr r1, [r0, #0x0C] 
ldr r2, =0x1000C 
tst r1, r2 
bne RetFalse 
mov r0, #1 
b ExitFielded

RetFalse: 
mov r0, #0 

ExitFielded: 
bx lr 
.ltorg


GetDifficulty:
@ see $34704
ldr r2, =gChapterData
ldrb r0, [r2, #0x14] 
mov r1, #0x40 
and r1, r0 
neg r1, r1 
lsr r1, #0x1F 
@ 1 in r1 for difficult 

@ see $800E10A from CHECK_TUTORIAL? I do it differently here because it branches for some reason 
@ldr r2, =gChapterData
mov r0, r2
add r0, #0x42 
ldrb r0, [r0] 
mov r2, #0x20 
and r0, r2 
lsr r0, #5 
add r0, r1 @ 0 = easy, 1 = normal, 2 = hard  
bx lr 
.ltorg 


