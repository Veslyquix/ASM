
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




