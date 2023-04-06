.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ GetUnit, 0x8019430

.equ RefreshFogAndUnitMaps, 0x0801a1f4
.equ SMS_UpdateFromGameData, 0x080271a0
.equ UpdateGameTilesGraphics, 0x08019c3c
.equ ChangeFogSomething, 0x800BAA8 

push {r4-r5, lr} 
lsl r0, r4, #0x10 
asr r0, #0x10 
mov r1, r3 
mov r4, r3 @ for us 
blh ChangeFogSomething @ change fog to whatever value is in r0 / r1 ? 

cmp r4, #0 
bne SkipUnitLoop 
mov r5, #2 
lsl r5, #8 @ 0x200 
mov r4, #0 @ unit deployment byte 
Loop: // if we remove fog, also remove 0x200 "HideLinkArena" bitflag from all units 
add r4, #1 
cmp r4, #0xC0 
bge SkipUnitLoop 
mov r0, r4 
blh GetUnit
cmp r0, #0 
beq Loop  
ldr r1, [r0] 
cmp r1, #0 
beq Loop 
ldr r1, [r0, #0x0C] @ state 
bic r1, r5 
str r1, [r0, #0x0C] 
b Loop 


SkipUnitLoop: 
blh RefreshFogAndUnitMaps 
blh SMS_UpdateFromGameData 
blh UpdateGameTilesGraphics 



mov r0, #2 
pop {r4-r5} 
pop {r1} 
bx r1 
.ltorg 







