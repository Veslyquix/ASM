
.thumb

.global CallStartEndBrokenBattleProc
.type CallStartEndBrokenBattleProc, %function 
CallStartEndBrokenBattleProc: 
push  {r14}

bl StartEndBrokenBattleProc
ldr r0, =0x8059BE0 
ldr r0, [r0] @ 0x203e104 
mov r1, #0 
ldsh r0, [r0, r1] 
cmp r0, #1 

pop {r3} 
ldr r3, =0x8059a09 
bx r3 
.ltorg 

.global GetAnimRoundData
.type GetAnimRoundData, %function 
GetAnimRoundData: 
ldr r0, =0x8058248
ldr r0, [r0] 
bx lr 
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



