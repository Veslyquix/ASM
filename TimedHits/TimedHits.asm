
.thumb

.global CallStartTimedHitsProc
.type CallStartTimedHitsProc, %function 
CallStartTimedHitsProc: 
push  {r14}

bl StartTimedHitsProc

ldr r0, =0x8C00008
mov r10, r0 
ldr r1, =0x201fb1c 
mov r0, #0 
str r0, [r1, #4] 
str r0, [r1] 

pop {r3} 
bx r3 
.ltorg 

.global InitCurrentAnimForTimedHitsProc
.type InitCurrentAnimForTimedHitsProc, %function 
InitCurrentAnimForTimedHitsProc:
push {lr} 
push {r1} 
mov r0, r7 @ anim 
bl SetCurrentAnimInProc
pop {r1} 
mov r0, #0x40 
and r0, r1 
pop {r3} 
cmp r0, #0 
beq Exit2 
ldr r3, =0x805967d 
bx r3 
Exit2: 
ldr r3, =0x80596cd
.ltorg 

@ skillsys changes the size of rounds, so we use this function instead of gBattleHitArray[]
.global GetCurrentRound
.type GetCurrentRound, %function 
GetCurrentRound: 
ldr   r1, =0x802b90a      @ &BattleBufferWidth.
ldrb  r1, [r1]
mul   r0, r1
ldr   r1, =0x802aec4      @ &Battle buffer.
ldr   r1, [r1]
add   r0, r1          @ Current round in battle buffer.
bx lr 
.ltorg 


.global GetDamage
.type GetDamage, %function 
GetDamage:
ldrb r0, [r0, #3] 
mov r11, r11 
bx lr 
.ltorg 






