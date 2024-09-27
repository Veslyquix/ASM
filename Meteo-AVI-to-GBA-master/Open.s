.gba
.open "FE8_Clean.gba","Patched.gba",0x8000000

;该asm用于和Meteocn配套使用，具体效果是为游戏ROM增加视频片头

.definelabel HijackPos,0x8FF0000;可以是88~8F

.org 0x8000000
.arm
b Video
.org HijackPos
Video:
.import "video.gba";视频rom
.arm 
.align 
CR:
ldr r0,=CartRom
bx r0;执行后切换为thumb模式
.pool
Skip:;加入按Start键直接跳过视频
push r0-r2
;mov r11, r11 
ldr r0, =ThumbCode|1
bx r0 
ArmReturn: 
mov r8, r8 
tst r2, r1 
;beq CR @ swap between thumb and arm or something ? 
;.word 0AFFFFF5h;即beq CR
.word  1AFFFFF5h;即beq CR
;b CartRom
;ldr r0,=CartRom
;bx r0;执行后切换为thumb模式
pop r0-r2
ldr r0,[r6,4h]
.db 59h,0F8h,0FFh,0EAh;???
.pool 
CartRom:
.thumb
mov r0,r0;对齐
bx r15;切换为arm模式

.pool 
;.thumb 
.arm 
Normal:
mov r8, r8 
ldr r0, =ClearRam|1 
bx r0 
mov r0,12h
ldr r1, =0x80000c0 
bx r1 
;b 80000C0h;返回正常游戏
.arm 
Back:
mov r7,r14
push r4-r7
ldr r0,=3003000h
ldr r1,=CR
ldmia [r1]!,r2-r4
stmia [r0]!,r2-r4;将"CR"部分到3003000h
ldr r0,=3003010h
ldr r1,=Skip
ldmia [r1]!,r2-r7
stmia [r0]!,r2-r7
ldmia [r1]!,r2-r6
stmia [r0]!,r2-r6;将"Skip"部分到3003010h
pop r4-r7
b HijackPos + 0x25C
.pool
.thumb
ThumbCode: 
ldr r0,=4000130h;按键输入
ldr r1,=3FFh; all!! 
;ldr r1,=3Feh;Start键
ldrh r2,[r0]
mvn r2, r2 
and r2, r1 
mov r1, #9 ; A button 
;cmp r2, r1 
ldr r0, =0x3003020 ; ArmReturn 
bx r0 
.align 
ClearRam:
sub sp, #4
mov r0, sp 
mov r1, #0 
str r1, [r0] 
ldr r1, =0x2000000 
ldr r2, =0x1010000
 
swi 0xC
mov r0, sp 
mov r1, #0 
str r1, [r0] 
ldr r1, =0x3000000 
ldr r2, =0x1001C00
swi 0xC 

add sp, #4 
mov r0,12h


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

ldr r1, =0x80000c0 
bx r1 

ldr r0, =0x3003004 
bx r0 
.pool 
.arm 
.org HijackPos + 0x258
b Back;设置返回程序
.org HijackPos + 0xAE30 ;8FFAE30
.db 7Dh,07h,00h,0EAh;即b 3003000h
.org HijackPos + 0xADC4
.db 9Ch,07h,00h,0EAh;即b 3001310h
;以下为指针校正
.org HijackPos + 0x306
.db (HijackPos - 0x8000000) / 0x10000
.org HijackPos + 0x146
.db (HijackPos - 0x8000000) / 0x10000
.org HijackPos + 0x222
.db (HijackPos - 0x8000000) / 0x10000
.org HijackPos + 0x166
.db (HijackPos - 0x8000000) / 0x10000
.org HijackPos + 0x9CF6
.db (HijackPos - 0x8000000) / 0x10000
.close