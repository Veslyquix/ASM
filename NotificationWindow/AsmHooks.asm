
.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.global HookSetLocalFlag_NotificationWindow
.type HookSetLocalFlag_NotificationWindow, %function 
HookSetLocalFlag_NotificationWindow: 
push {r4, lr} 
mov r4, r0 
bl DoNotificationsForFlag 
mov r3, r4 
sub r3, #1 
ldr r1, =gChapterFlagBits @ 3005270 
mov r0, r3 
cmp r3, #0 
bge NoAdd 
add r0, r3, #7 
NoAdd: 
pop {r4} 
pop {r2} 
bx r2 
.ltorg 

.global HookSetGlobalFlag_NotificationWindow
.type HookSetGlobalFlag_NotificationWindow, %function 
HookSetGlobalFlag_NotificationWindow: 
push {r4, lr} 
mov r4, r0 
bl DoNotificationsForFlag 
mov r3, r4 
sub r3, #0x65 
ldr r1, =gPermanentFlagBits @ 3005250 
mov r0, r3 
cmp r3, #0 
bge NoAdd2 
add r0, r3, #7 
NoAdd2:
pop {r4} 
pop {r2} 
bx r2 
.ltorg 

.global Hook_ExecUnitPromotion 
.type Hook_ExecUnitPromotion, %function 
Hook_ExecUnitPromotion: 
push {lr} 

mov r0, r8 
bl UnlockAchievementByPromo

mov r0, #1 
neg r0, r0 
mov r10, r0 
pop {r3} 
bx r3 
.ltorg 


.global Hook_CallEndEvent
.type Hook_CallEndEvent, %function 
Hook_CallEndEvent: 
push {lr} 
asr r0, #24 
blh 0x80346B0 
mov r4, r0 
blh 0x80BD068 
push {r0} 

cmp r0, #2 
beq NoAchievementForSkirmishes 

bl UnlockAchievementByTurnCount
bl UnlockAchievementByChapterTime




NoAchievementForSkirmishes: 
pop {r0} @ skirmish or not 
pop {r3} 
bx r3 
.ltorg 


.global Hook_RegisterChapterTimeAndTurnCount
.type Hook_RegisterChapterTimeAndTurnCount, %function 
Hook_RegisterChapterTimeAndTurnCount: 
push {r4-r7, lr} 

mov r4, r0 @ chapter index 
@ mov r5, r5 @ struct ChapterStat 
@ mov r6, r6 @ time 
mov r7, r3 @ turn count 

orr r0, r1 
strb r0, [r5] 
lsl r2, r3, #7 
ldrh r1, [r5] 
mov r0, #0x7F 
and r0, r1 
orr r0, r2 
mov r5, r0 @ bitpacked turn count/ch index 


mov r0, r7 @ turn count 
mov r1, r4 @ ch index 
bl UnlockAchievementByTurnCount
mov r0, r6 @ chapter time 
mov r1, r4 @ ch index 
bl UnlockAchievementByChapterTime


mov r0, r5 @ vanilla will store bitpacked turn count/ch index next 

pop {r4-r7}
pop {r3} 
bx r3 
.ltorg 



