
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











