
.arm 
.align 
CR:
ldr r0,=CartRom
bx r0 @ 执行后切换为thumb模式
.pool
Skip: @ 加入按Start键直接跳过视频
push r0-r2
ldr r0, =ThumbCode|1
bx r0 
ArmReturn: 
mov r8, r8 
tst r2, r1 
pop r0-r2
 @ beq CR @ swap between thumb and arm or something ? 
 @ .word 0AFFFFF5h @ 即beq CR
.word  1AFFFFF4h @ 即beq CR
ldr r0,[r6,4h]
.db 59h,0F8h,0FFh,0EAh @ ??? a branch 
.pool 
CartRom:
.thumb
mov r0,r0 @ 对齐
bx r15 @ 切换为arm模式

.pool 
 @ .thumb 
.arm 
Normal:
mov r8, r8 
ldr r0, =ClearRam|1 
bx r0 
.arm 
Back:
mov r7,r14
push r4-r7
ldr r0,=3003000h
ldr r1,=CR
ldmia [r1]!,r2-r4
stmia [r0]!,r2-r4 @ 将"CR"部分到3003000h
ldr r0,=3003010h
ldr r1,=Skip
ldmia [r1]!,r2-r7
stmia [r0]!,r2-r7
ldmia [r1]!,r2-r6
stmia [r0]!,r2-r6 @ 将"Skip"部分到3003010h
pop r4-r7
b HijackPos + 0x25C
.pool
.thumb
ThumbCode: 
ldr r0,=4000130h @ 按键输入
ldr r1,=3FFh @  all!! 
 @ ldr r1,=3Feh @ Start键
ldrh r2,[r0]
mvn r2, r2 
and r2, r1 
mov r1, #9  @  A/Start button 
 @ cmp r2, r1 
ldr r0, =0x3003020  @  ArmReturn 
bx r0 
.align 
ClearRam:

 @  https://rust-console.github.io/gbatek-gbaonly/#--gba-memory-map
sub sp, #4
mov r0, sp 
mov r1, #0 
str r1, [r0] 
ldr r1, =0x2000000 
ldr r2, =((0x2040000-0x2000000) >> 2) | 0x1000000
swi 0xC

mov r0, sp 
mov r1, #0 
str r1, [r0] 
ldr r1, =0x3000000  @  03000000-03007FFF
ldr r2, =((0x3007c00-0x3000000) >> 2) | 0x1000000
swi 0xC 

 @  this makes audio worse fsr 
 @ mov r0, sp 
 @ mov r1, #0 
 @ str r1, [r0] 
 @ ldr r1, =0x4000000  @ 4000000-040003FE
 @ ldr r2, =((0x4000400-0x4000000) >> 2) | 0x1000000
 @ swi 0xC 

 @ mov r0, sp 
 @ mov r1, #0 
 @ str r1, [r0] 
 @ ldr r1, =0x5000000  @ 05000000-050003FF   BG/OBJ Palette RAM        (1 Kbyte)
 @ ldr r2, =((0x5000400-0x5000000) >> 2) | 0x1000000
 @ swi 0xC 
 @ 
 @ mov r0, sp 
 @ mov r1, #0 
 @ str r1, [r0] 
 @ ldr r1, =0x6000000  @ 06000000-06017FFF   VRAM - Video RAM          (96 KBytes)
 @ ldr r2, =((0x6018000-0x6000000) >> 2) | 0x1000000
 @ swi 0xC 
 @ 
 @ mov r0, sp 
 @ mov r1, #0 
 @ str r1, [r0] 
 @ ldr r1, =0x7000000  @ 07000000-070003FF   OAM - OBJ Attributes      (1 Kbyte)
 @ ldr r2, =((0x7000400-0x7000000) >> 2) | 0x1000000
 @ swi 0xC 


add sp, #4 
mov r0,12h

 @ mov r11, r11 

ldr r0, =0x3007F00 
mov sp, r0 
ldr r0, =0x8000000 
mov lr, r0 
mov r0, #0 
mov r1, r0 
mov r2, r0 
mov r3, r0 
mov r4, r0 
mov r5, r0 
mov r6, r0 
mov r7, r0 
mov r8, r0 
mov r9, r0 
mov r10, r0 
mov r11, r0 
mov r12, r0 
ldr r1, =0x4000208 
str r0, [r1] 
 @ mov r11, r11 
ldr r1, =ReturnAddress
bx r1 
.pool 
.arm 
ORG HijackPos + 0x258
b Back // 设置返回程序
.ltorg 



