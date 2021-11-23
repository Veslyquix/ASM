.thumb 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.equ gActionData, 0x203A958
.equ CurrentUnit, 0x3004E50
.equ CheckEventId,0x8083da8

.global ItemSpecialEffectUsability
.type ItemSpecialEffectUsability, %function
ItemSpecialEffectUsability:
push {r4-r6, lr} 


ldr r5, =CurrentUnit 
ldr r5, [r5]
ldr r3, =gActionData 
ldrb r4, [r3, #0x12] @ inventory slot # 
lsl r4, #1 @ 2 bytes per inv slot 
add r4, #0x1E 
add r4, r5 @ unit ram address of actual item to load 
ldrh r1, [r4] 
mov r4, #0xFF 
and r4, r1 @ item id 


ldr r6, ItemSpecialEffectTable
sub r6, #12
FindValidItemLoop:
add r6, #12
ldr r0, [r6] 
cmp r0, #0 
beq RetFalse 
ldrb r0, [r6] @ item id 
cmp r0, r4 @ if they match, return true 
bne FindValidItemLoop 
ldrh r0, [r6, #4] @ flag 
cmp r0, #0 
beq RetTrue @ Always true if flag is 0 
blh CheckEventId
cmp r0, #1 
bne FindValidItemLoop 

RetTrue: 
mov r0, #1
b ExitUsability 

RetFalse: 
mov r0, #3 @ 3 is false lol 
b ExitUsability
@ if hover item = our item, return true 

ExitUsability:
mov r1, r6 @ Table entry to use 
pop {r4-r6} 
pop {r2} 
bx r2


.align
.ltorg

ItemSpecialEffectTable:

