.thumb 
.equ gFaceGfxData, 0x202A68C 
push {lr} 
ldr r2, [r1] 
cmp r2, #0 
bne Vanilla
mov r11, r11 
ldr r2, [r1, #0x10] @ class portrait 
cmp r2, #0 
bne Vanilla 
@ no options work so idk 

Vanilla: 
ldr r1, =gFaceGfxData 
add r0, #0x40 
ldrb r0, [r0] 
lsl r0, #3 
add r0, r1 
pop {r3} 
bx r3 
.ltorg 








