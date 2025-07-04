
.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@ in 1CC1C
.global Hook_PlayerPhase_InitUnitMovementSelect
.type Hook_PlayerPhase_InitUnitMovementSelect, %function 
Hook_PlayerPhase_InitUnitMovementSelect:
push {lr} 
ldrb r1, [r5, #4] 
mov r0, #2 
orr r0, r1 
strb r0, [r5, #4] 

bl FinishDangerBonesRange

ldr r4, =0x3004e50 @gActiveUnit 
ldr r0, [r4] 
pop {r3} 
bx r3 
.ltorg 


.global Hook_PlayerPhase_Suspend
.type Hook_PlayerPhase_Suspend, %function 
Hook_PlayerPhase_Suspend:
push {lr} 
bl StartDangerBonesRange
ldr r1, =0x203a958 
mov r0, #0
strb r0, [r1, #0x16]
mov r0, #3 
ldr r3, =0x801C89F 
bx r3 
.ltorg 

.global Hook_HandlePostActionTraps
.type Hook_HandlePostActionTraps, %function 
Hook_HandlePostActionTraps:
push {lr} 
push {r0}

bl StartDangerBonesRange

pop {r0}
cmp r0, #0 
ble Exit2

ldr r2, [r4]
ldr r0, [r2]
ldr r1, [r2, #4] 
ldr r0, [r0, #0x28]




pop {r3} 
bx r3 
.ltorg 

Exit2:
pop {r3} 
ldr r3, =0x803775d 
bx r3 
.ltorg 


.global Hook_EnsureCameraOntoPosition
.type Hook_EnsureCameraOntoPosition, %function 
Hook_EnsureCameraOntoPosition: 
push {lr} 
lsl r0, #0x10 
lsr r6, r0, #0x10 
bl RemoveEnemyShaking
ldr r1, =0x202BCb0 @ gGameState 
mov r2, #0xC 
ldsh r0, [r1, r2] 
cmp r7, r0 

pop {r3} 
bx r3 
.ltorg 

.global Hook_RefreshUnitSprites
.type Hook_RefreshUnitSprites, %function 
Hook_RefreshUnitSprites: 
push {lr} 
lsl r2, r0, #16 
lsr r2, #24 
cmp r2, #0xC0 
bge DoNothing 
mov r2, #0x10 
lsl r2, #8 
add r0, r2 
DoNothing: 
strh r0, [r5, #8] 
mov r2, r9 
ldrh r0, [r2] 
strb r0, [r5, #0xB] 
add r4, #8 
ldrb r0, [r4, #2] 
pop {r3} 
bx r3 
.ltorg 



.global Hook_PutUnitSpritesOam
.type Hook_PutUnitSpritesOam, %function 
Hook_PutUnitSpritesOam: 
push {lr} 
mov r3, #0 
cmp r0, #0 
beq Exit_PutUnitSpritesOam 
blh 0x8000D28 @ GetGameClock 
mov r3, r0 
mov r0, #0x1
ldr r1, =ShakeSpeed_Link 
ldr r1, [r1] 
lsl r0, r1 

and r3, r0 
lsr r3, r1 
Exit_PutUnitSpritesOam: 

pop {r2} 
bx r2 
.ltorg 






