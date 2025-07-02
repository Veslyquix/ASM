
.thumb 
@ in 1CC1C
.global Hook_PlayerPhase_InitUnitMovementSelect
.type Hook_PlayerPhase_InitUnitMovementSelect, %function 
Hook_PlayerPhase_InitUnitMovementSelect:
push {lr} 
ldrb r1, [r5, #4] 
mov r0, #2 
orr r0, r1 
strb r0, [r5, #4] 

bl GenerateDangerLineRange

ldr r4, =0x3004e50 @gActiveUnit 
ldr r0, [r4] 
pop {r3} 
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







