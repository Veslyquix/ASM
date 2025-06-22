.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@ 0xA015C 
.equ SetBgPosition, 0x800148C	@{U}
.equ SetupFaceGfxData, 0x8005544 @{U}
.global WMSell_Hook
.type WMSell_Hook, %function 
WMSell_Hook:
push {lr} 
mov r0, #0 
mov r1, #0 
mov r2, #0 
blh SetBgPosition 
ldr r0, WMSell_FaceVramEntry 
blh SetupFaceGfxData



mov r0, #1 
pop {r1} 
bx r1 
.ltorg 
WMSell_FaceVramEntry: 



