.thumb 
.global ContagiousStatus
.type ContagiousStatus, %function 
ContagiousStatus: 
push {lr} 
ldr r6, =0x802b640 
ldr r6, [r6] @ usually 0x203a608 
ldr r0, [r6] 
ldr r0, [r0] 
lsl r0, #0xD 
lsr r0, #0xD 
mov r1, #2  
tst r0, r1 
bne OnlySuperContagious
push {r0-r1} 
mov r1, r4 
mov r0, r5 
bl ApplyStatus
pop {r0-r1} 
OnlySuperContagious: 
push {r0-r1} 
mov r1, r4 
mov r0, r5 
bl ApplySuperContagiousStatus
pop {r0-r1} 
pop {r3} 
bx r3 
.ltorg 

ApplyStatus: 
mov r2, #0x30 @ status 
ldrb r2, [r0, r2] @ atkr status 
mov r3, #0xF 
and r2, r3 
ldr r3, =ContagiousStatusTable
ldrb r3, [r3, r2] @ is this status contagious? 
cmp r3, #0 
beq NoApply 
ldr r3, =0x80178EA
ldrb r3, [r3] @ number of turns it applies for 
lsl r3, #4 @ turns<<4 | status id 
orr r2, r3 
mov r3, #0x6F 
strb r2, [r1, r3] @ opposing unit gets this status written to 
NoApply: 
bx lr 
.ltorg 

ApplySuperContagiousStatus: 
mov r2, #0x30 @ status 
ldrb r2, [r1, r2] @ dfdr status 
mov r3, #0xF 
and r2, r3 
ldr r3, =SuperContagiousStatusTable
ldrb r3, [r3, r2] @ is this status contagious? 
cmp r3, #0 
beq NoApply2 
ldr r3, =0x80178EA
ldrb r3, [r3] @ number of turns it applies for 
@lsl r3, #4 @ turns<<4 | status id 
orr r2, r3 
mov r3, #0x6F 
strb r2, [r0, r3] @ opposing unit gets this status written to 
NoApply2: 
bx lr 
.ltorg 











