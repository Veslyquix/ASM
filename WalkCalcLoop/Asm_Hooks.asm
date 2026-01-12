
.thumb

.global WalkCalcLoop_Hook
.type WalkCalcLoop_Hook, %function 
WalkCalcLoop_Hook: 
push  {r14}
mov r1, r12 
push {r1-r3} 
cmp r0, #0 
bne InterruptMovement 
mov r0, r7 @ unit 
mov r1, r3 @ current x 
mov r2, r4 @ current y 
bl WalkCalcLoop
cmp r0, #0 
bne InterruptMovement 
b DontInterruptMovement

InterruptMovement: 
mov r0, #4 
strb r0, [r5, #1] 
mov r0, #0x1e 
strb r0, [r6, #0x11] 
pop {r1-r3} @ r2 & r3 need to be preserved after returning 
strb r3, [r6, #0xE] 
strb r4, [r6, #0xF] 
mov r12, r1 
pop {r1} 
ldr r1, =0x801A8DD 
bx r1 




DontInterruptMovement: 
pop {r1-r3}
mov r12, r1  
pop {r1} 
ldr r1, =0x801A8B5
bx r1 
.ltorg 




