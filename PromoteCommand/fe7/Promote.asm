

.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ FE7, 1 
.equ true, 1 

.if FE6 == true 
.equ gActiveUnit, 0x30044B0 
.equ gPlaySt, 0x202AA48
.equ gActionData, 0x203956C
.equ Attacker, 0x2039214 
.equ Defender, 0x2039290 
.equ CallEvent, 0x800D978
.equ GetClassData, 0x8018620
@ [0203957E]? break on reading the itemSlotIndex in ActionData 
.equ StartBmPromotion, 0x08027ccc @//NewPromotion
.equ EndMMS, 0x8067AF0 @EndManimLevelUpStatGainLabels
.equ GetUnitEquippedWeapon, 0x8016958
.equ CheckEventId, 0x806BA5C


.endif 

.if FE7 == true 
.equ gActiveUnit, 0x3004690
.equ gPlaySt, 0x202BBF8
.equ gActionData, 0x203A85C
.equ Attacker, 0x203A3F0
.equ Defender, 0x203A470
.equ CallEvent, 0x800AF5C
.equ GetClassData, 0x8018D20
@ [0203A86E]? break on reading the itemSlotIndex in ActionData 
@ in 22624 at 22688, call three functions 
.equ StartBmPromotion, 0x0802cc68 @maybe //NewPromotion from 2d00c 
.equ EndMMS, 0x806CCB8 @EndManimLevelUpStatGainLabels
.equ GetUnitEquippedWeapon, 0x8016764 
.equ CheckEventId, 0x80798F8
.endif 

.if FE8 == true 
.equ gActiveUnit, 0x3004E50
.equ gPlaySt, 0x202BCF0
.equ gActionData, 0x203A958 
.equ Attacker, 0x203A4EC 
.equ Defender, 0x203A56C 
.equ CallEvent, 0x800D07C
.equ StartBmPromotion, 0x080CCA14 @//NewPromotion
.equ EndMMS, 0x80790a4 @EndManimLevelUpStatGainLabels
.equ GetUnitEquippedWeapon, 0x8016B28 
.equ CheckEventId, 0x8083da8

.endif 

.global PromoteEffect
.type PromoteEffect, %function
PromoteEffect: 
push {lr}

ldr r0, =PromotionMenuEvent 
mov r1, #1 
blh CallEvent 

mov r0, #0x17 


pop {r1}
bx r1 


.ltorg

.if FE6 == true 
.equ HideMenuOption, 2 @ False. Default - Menu false usability is 2 in fe6 
.equ ShowMenuOption, 0 
.else 
.equ HideMenuOption, 3 
.equ ShowMenuOption, 1 
.endif 



.global PromoteUsability
.type PromoteUsability, %function
PromoteUsability: 
push {r4-r6, lr}

mov r6, #HideMenuOption 

ldr r4, =gActiveUnit 
ldr r4, [r4] 
cmp r4, #0 
beq ReturnValue

ldr r0, [r4, #4] @ Class pointer 


.if FE8 == true 
ldrb r0, [r0, #4] @ ClassID 
lsl r0, #1 @ 2 bytes / choices per class 
ldr r2, =0x80CC7D0 @ POIN PromotionTable
ldr r2, [r2] @ PromotionTable (Vanilla: 0x895DFA4)
ldrh r0, [r2, r0] @ Are both choices 0? 
cmp r0, #0 
beq ReturnValue @ If no possible class to promote into, then return false. 
.else 
mov r1, #0x24 
.if FE7 == true 
add r1, #4 @ 0x28 offset in fe7 
.endif 
ldr r1, [r0, r1] @ word ability 
mov r2, #1 
lsl r2, #8 
tst r1, r2 
bne AlreadyInPromotedClass 
ldrb r1, [r0, #5] 
cmp r1, #0 
beq ReturnValue @ nothing to promote into 
b HasAPromotion 

AlreadyInPromotedClass: 
b ReturnValue 


.endif 
HasAPromotion: 



ldr r5, =PromotionMenuList
sub r5, #8 

UsabilityLoop:
ldr r3, =0xFFFFFFFF 
add r5, #8
ldr r0, [r5] 
cmp r0, r3 
bne DoNotTerminate
ldr r0, [r5, #4]
cmp r0, r3  
beq ReturnValue

DoNotTerminate:

ldrb r0, [r5, #0] @ UnitID 
cmp r0, #0 
beq SkipUnitCheck 
ldr r1, [r4] @ unit pointer 
ldrb r1, [r1, #4] 
cmp r0, r1 
bne UsabilityLoop 
SkipUnitCheck: 

ldrb r0, [r5, #1] @ ClassID 
cmp r0, #0 
beq SkipClassCheck 
ldr r1, [r4, #4] @ class pointer 
ldrb r1, [r1, #4] 
cmp r0, r1 
bne UsabilityLoop 
SkipClassCheck: 

ldrb r0, [r5, #2] @ Required Level 
cmp r0, #0 
beq SkipLevelCheck
ldrb r1, [r4, #8] @ Current Level 
cmp r0, r1 
bgt UsabilityLoop 
SkipLevelCheck:

ldr r2, =gPlaySt @gPlaySt 
ldrb r1, [r2, #0xE] 
ldrb r0, [r5, #3] @ Lowest chapter 
ldrb r2, [r5, #4] @ Highest chapter 
cmp r0, #0xFF 
beq SkipChCheck 
cmp r1, r0 @ Current chapter vs lowest allowed chapter 
blt UsabilityLoop
cmp r1, r2 @ current chapter vs highest allowed chapter 
bgt UsabilityLoop 
SkipChCheck: 

ldrh r0, [r5, #6] @ Required Flag 
cmp r0, #0 
beq SkipFlagCheck
blh CheckEventId
cmp r0, #1
bne UsabilityLoop
SkipFlagCheck:

mov r6, #ShowMenuOption @ True 

ldrb r2, [r5, #5] 
mov r1, #1 
and r2, r1 @ Boolean: Exception to usability if true. Requirement if false. 

cmp r2, #1 @ If exception to the rule, make this case false instead of true. 
bne UsabilityLoop 
mov r6, #HideMenuOption @ Exception to the rule 
b UsabilityLoop

ReturnValue:
mov r0, r6  

End: 

pop {r4-r6}
pop {r1}
bx r1 






.global PromoteStart 
.type PromoteStart, %function 
PromoteStart: 
push {r4, lr}
mov r4, r0 
ldr r3, =gActiveUnit
ldr r3, [r3] 
cmp r3,  #0 
beq Exit 


ldr r1, =gActionData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0xFF 
strb r0, [r1, #0x12] @ Inventory slot -1  

mov r0, r4 
blh StartBmPromotion

ldr r0, =gActiveUnit 
ldr r0, [r0] 
blh GetUnitEquippedWeapon 
@ldr r3, =Defender  
@add r3, #0x48 
@strh r0, [r3, #2] 

blh EndMMS 




Exit: 
mov r0, #0xB7
pop {r4} 
pop {r1}
bx r1 
.ltorg 

