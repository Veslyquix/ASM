.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global MakeStolenItemDroppable_FE6
.type MakeStolenItemDroppable_FE6, %function 
MakeStolenItemDroppable_FE6:
push {lr} 
blh 0x8018658 @ remove item 
mov r0, r5 
mov r1, r8 
blh 0x8012178 
ldr r3, =0x30044B0 @gActiveUnit 
ldr r3, [r3] 
ldrh r2, [r3, #0xC] @ state 
mov r1, #0x10 
lsl r1, #8 
orr r2, r1 
strh r2, [r3, #0xC] 
pop {r3} 
bx r3 
.ltorg 

.global MakeStolenItemDroppable_FE7
.type MakeStolenItemDroppable_FE7, %function 
MakeStolenItemDroppable_FE7:
push {lr} 
blh 0x8018D50 @ remove item 
mov r0, r5 
mov r1, r8 
blh 0x800EEF4 
ldr r3, =0x3004690 @ gActiveUnit 
ldr r3, [r3] 
ldr r2, [r3, #0xC] @ state 
mov r1, #0x10 
lsl r1, #8 
orr r2, r1 
str r2, [r3, #0xC] 
pop {r3} 
bx r3 
.ltorg 

.global MakeStolenItemDroppable_FE8
.type MakeStolenItemDroppable_FE8, %function 
MakeStolenItemDroppable_FE8:
push {lr} 
mov r0, r6 
blh 0x8019484 @ remove item 
mov r0, r5 
mov r1, r8 
blh 0x8011694 
ldr r3, =0x3004E50 @gActiveUnit 
ldr r3, [r3] 
ldr r2, [r3, #0xC] @ state 
mov r1, #0x10 
lsl r1, #8 
orr r2, r1 
str r2, [r3, #0xC] 
pop {r3} 
bx r3 
.ltorg 
