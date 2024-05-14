
@ copied Huichelaar's HookAttack from battle anim numbers as a base for this test 

@ Hooked at 0x52304. Displays numbers for most attacks. Args:
@   r0: Recipient's AIS. Can be initiator if devil effect.
.thumb

.global TestFunc
.type TestFunc, %function 
TestFunc: 
push  {r4-r6, r14}
mov   r4, r0


bl SomeC_Code





@ Vanilla. Overwritten by hook.
mov   r0, r4
ldr   r3, =GetAnimPosition
bl    GOTO_R3
ldr   r3, =0x805230D
GOTO_R3:
bx    r3
.ltorg 

