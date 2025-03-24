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

GetFaceDisplayBits_New:
push {r4, lr} 
mov r4, r0 
bl ShouldDisplayOnlyBG
lsl r1, r0, #10 @ blend  
ldr r1, =0x400
ldr r0, [r4, #0x30] 
orr r0, r1 
pop {r4} 
pop {r3} 
bx r3 
.ltorg 

.global HookGetFaceDisplayBits
.type HookGetFaceDisplayBits, %function 
HookGetFaceDisplayBits: 
push {lr} 
bl GetFaceDisplayBits_New
pop {r3} 
bx r3 
.ltorg 


.global HookGetFaceDisplayBitsById
.type HookGetFaceDisplayBitsById, %function 
HookGetFaceDisplayBitsById: 
push {lr} 
ldr r1, =0x80057BC 
ldr r1, [r1] 
lsl r0, #2 
add r0, r1 
ldr r0, [r0] 
bl GetFaceDisplayBits_New
pop {r3} 
bx r3 
.ltorg 





