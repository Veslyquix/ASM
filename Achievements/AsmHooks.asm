
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
mov r0, r4 
bl UnlockAchievementByFlag
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

.global Hook_RunWaitEvents
.type Hook_RunWaitEvents, %function 
Hook_RunWaitEvents: 
push {lr} 
mov r1, r13 
ldr r0, =gActiveUnit 
ldr r2, [r0] 
ldrb r0, [r2, #0x10] 
strb r0, [r1, #0x18] 
ldrb r0, [r2, #0x11] 
strb r0, [r1, #0x19] 


mov r0, #2 
blh CheckFlag @ defeated boss 
cmp r0, #0 
bne ChDone 
mov r0, #3 
blh CheckFlag 
cmp r0, #0 
bne ChDone 
mov r0, #6 
blh CheckFlag 
cmp r0, #0 
bne ChDone 
b ChNotDone 

ChDone: 
bl UnlockAchievementByTurnCount
bl UnlockAchievementByChapterTime
ChNotDone: 
mov r0, r13 

pop {r3} 
bx r3 
.ltorg 


.global Hook_InitSave
.type Hook_InitSave, %function 
Hook_InitSave: 
push {lr} 
blh 0x8030CF4 
blh 0x80177C4 
blh 0x8031508 
mov r0, r10 @ slot 
bl ClearAchievementsForSlot
pop {r3} 
bx r3 
.ltorg 


.global Hook_DoItemUse 
.type Hook_DoItemUse, %function 
Hook_DoItemUse: 
push {lr} 
mov r4, r1 @ vanilla 
blh ClearBg0Bg1
mov r0, #0 
blh EndFaceById 
mov r0, r4 @ item 
bl UnlockAchievementByItemUse 


pop {r3} 
bx r3 
.ltorg 

.global Hook_MapAnim_DisplayDeathQuote 
.type Hook_MapAnim_DisplayDeathQuote, %function 
Hook_MapAnim_DisplayDeathQuote: 
push {r5, lr} 
add r0, r2 
lsl r0, #2 
add r0, r3 
ldr r0, [r0] @ gManimSt.actor
ldr r5, [r0] @ unit 

ldrb r4, [r5, #4] @ vanilla puts unit ID in r4 
mov r0, r4 
bl UnlockAchievementByCombat
pop {r5} 
pop {r0} 
bx r0 
.ltorg 

.global Hook_sub_8052EAC 
.type Hook_sub_8052EAC, %function 
Hook_sub_8052EAC: 
push {r4, lr}
blh 0x805A16C @ GetAISSubject 
@ if 0, gpEkrBattleUnitLeft, if 1, gpEkrBattleUnitRight 
add r0, r0, r4 
ldrb r0, [r0] 
push {r0} 
bl UnlockAchievementByCombat
pop {r0} 
blh 0x80835DC @ display death quote 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 

.global Hook_EfxHpBar_DeclineToDeath
.type Hook_EfxHpBar_DeclineToDeath, %function 
Hook_EfxHpBar_DeclineToDeath: 
push {r5, lr} 
blh 0x805a16c 
mov r5, r0 @ for Vesly 
ldr r1, =0x805249c 
ldr r1, [r1] 
lsl r0, #1 
add r0, r1 
strh r4, [r0] 

ldrb r0, [r5] 
bl UnlockAchievementByCombat

pop {r5} 
pop {r0} 
bx r0 
.ltorg 

.global Hook_EfxHpBar_MoveCameraOnEnd 
.type Hook_EfxHpBar_MoveCameraOnEnd, %function 
Hook_EfxHpBar_MoveCameraOnEnd: 
push {r4, lr} 
strh r0, [r5, #0x2c] 
mov r0, #1 
strh r0, [r5, #0x2e] 

ldr r0, [r5, #0x60] 
blh 0x805a16c @ GetAISSubject
ldr r1, =gEkrPids 
ldrb r0, [r1, r0] 
bl UnlockAchievementByCombat


ldr r0, [r5, #0x64] 
blh 0x805a2b4 



pop {r4} 
pop {r1} 
bx r1 
.ltorg 


