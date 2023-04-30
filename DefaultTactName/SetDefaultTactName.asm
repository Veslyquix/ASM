.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ gNameSelectNameBoxText, 0x203DD1C 
.equ Text_InitClear, 0x8003D5C
.equ gChapterData, 0x202BCF0 
push {lr} 
mov r0, #0 
mov r1, r8 
strb r0, [r1] 
ldr r0, =gNameSelectNameBoxText 
mov r1, #8 
blh Text_InitClear 

ldr r3, =gChapterData 
add r3, #0x20 @ tact name 
ldrb r0, [r3, #0] @ first character 
strb r0, [r5, #1] @ 1st char 

mov r0, #0x41 @"A" 
strb r0, [r5, #1] @ 1st char 
mov r0, #0x42 @"B"
strb r0, [r5, #2] @ 2nd char 
mov r0, #0x43 @"C"
strb r0, [r5, #3] @ 3rd char 

pop {r0} 
bx r0 
.ltorg 




