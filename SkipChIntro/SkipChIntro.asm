.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ gChapterData, 0x202BCF0 
.equ CleanCommand, 0x800F0C8 
.equ StartBlockingFadeOutBlack, 0x8013d20 
.equ POIN_ChapterData, 0x803462C @POIN ChapterDataTable
.equ ChapterDataSize, 148 
.equ DoChIntroReturn, 0x8015518|1 
.equ SkipIntroReturn, 0x8015534|1

ldr r0, =gChapterData 
ldrb r0, [r0, #0xE] @ Ch ID 

ldr r3, SkipChIntroList
sub r3, #1 
Loop: 
add r3, #1 
ldrb r1, [r3] 
cmp r1, #0xFF 
beq False @ Do not skip intro  
cmp r0, r1 
beq True 
b Loop 

False: 
ldr r3, =DoChIntroReturn 
bx r3 

True: @ skip intro

ldr r0, =gChapterData 
ldrb r0, [r0, #0xE] @ Ch ID 

mov r1, #ChapterDataSize @ chapter data size 
mul r0, r1 @ offset to our chapter 
ldr r3, =POIN_ChapterData @POIN ChapterDataTable
ldr r3, [r3] 
add r3, r0 @ specific chapter 
add r3, #0x87 @ Fade to black bool 
ldrb r0, [r3] 
cmp r0, #1 
beq NoFadeFromBlack


blh CleanCommand @ CLEAN 

mov r0, #4 @ Speed 
mov r1, r4 @ parent proc 
blh StartBlockingFadeOutBlack

NoFadeFromBlack: 
ldr r3, =SkipIntroReturn 
bx r3 


.ltorg 
SkipChIntroList: 

