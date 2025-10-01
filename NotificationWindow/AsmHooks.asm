
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




