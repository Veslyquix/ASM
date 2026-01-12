
.thumb

.global WalkCalcLoop_Hook
.type WalkCalcLoop_Hook, %function 
WalkCalcLoop_Hook: 
push  {r14}
push {r2-r3} 
cmp r0, #0 
bne InterruptMovement 
bl WalkCalcLoop
cmp r0, #0 
bne InterruptMovement 
b DontInterruptMovement

InterruptMovement: 
mov r0, #4 
strb r0, [r5, #1] 
mov r0, #0x1e 
strb r0, [r6, #0x11] 
pop {r2-r3} @ r2 & r3 need to be preserved after returning 
strb r3, [r6, #0xE] 
strb r4, [r6, #0xF] 

pop {r1} 
ldr r1, =0x801A8DD 
bx r1 




DontInterruptMovement: 
pop {r2-r3} 
pop {r1} 
ldr r1, =0x801A8B5
bx r1 
.ltorg 




