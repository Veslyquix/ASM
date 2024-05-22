
@ copied Huichelaar's HookAttack from battle anim numbers as a base for this test 

@ Hooked at 0x52304. Displays numbers for most attacks. Args:
@   r0: Recipient's AIS. Can be initiator if devil effect.
.thumb

.global TestFunc
.type TestFunc, %function 
TestFunc: 
push  {r14}

bl SomeC_Code

ldr r0, =0x8C00008
mov r10, r0 
ldr r1, =0x201fb1c 
mov r0, #0 
str r0, [r1, #4] 
str r0, [r1] 

pop {r3} 
bx r3 
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

