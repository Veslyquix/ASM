.thumb 
.global ToggleSpritesWithSelect
.type ToggleSpritesWithSelect, %function 
ToggleSpritesWithSelect: 
push {lr} 
bl ToggleSpritesWithSelectKey
ldr r0, =0x8007CD0 
ldr r0, [r0] 
ldr r0, [r0] 
ldr r1, [r0, #8] 
mov r0, #0xF3 
and r0, r1 
cmp r0, #0 
pop {r3} 
bx r3 
.ltorg 

.global MaybeDisplayBlueArrowInConvo
.type MaybeDisplayBlueArrowInConvo, %function 
MaybeDisplayBlueArrowInConvo:
push {lr} 
mov r5, r0 
ldr r3, =0x8000D28 @ GetGameClock 
mov lr, r3 
.short 0xF800 
lsr r4, r0, #1 
bl ShouldDisplayOnlyBG
cmp r0, #0 
bne AltExit 
pop {r3} 
ldr r3, =0x8007C59
bx r3 
AltExit: 
pop {r3} 
ldr r3, =0x8007CAD
bx r3 
.ltorg 



