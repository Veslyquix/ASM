.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
@ 3E1B0 is Bl AiGetPositionUnitSafetyWeight 
@.equ AiGetPositionUnitSafetyWeight, 0x803E114 
@ .equ AiGetTileWeightForAttack, 0x803DE5C called by AiTrySimulateBattle 

@ FE8U
@.equ AiData, 0x203AA04	@{U}
@.equ ClearMapWith, 0x80197E4	@{U}
@.equ gMapMove2, 0x202E4F0	@{U}
@.equ FillAiDangerMap, 0x803E320	@{U}
@.equ gpAiBattleWeightFactorTable, 0x30017D8	@{U}
@.equ Attacker, 0x203A4EC	@{U}

@ FE8J
.equ AiData, 0x203AA00	@{J}
.equ ClearMapWith, 0x80194BC	@{J}
.equ gMapMove2, 0x202E4EC	@{J} @ [2030455..2030711]?
.equ FillAiDangerMap, 0x803E2B0	@{J}
.equ gpAiBattleWeightFactorTable, 0x30017D0	@{J}
.equ Attacker, 0x203A4E8	@{J}
.equ ai3_address, 0x80DCE54 @ {J} 

@.equ ActionStruct, 0x203A958
@.equ gActiveUnit, 0x03004E50	@{U}
@
@.equ AiDecision, 0x203AA94 @ [203AA96..203AA97]!!
mov r11, r11 
ldr r0, =gMapMove2 
ldr r0, [r0] 
add r5, r0 
ldr r0, [r5] 
add r0, r6 
@ ldrb r0, [r0] 


ldr r2, =AiData+0x7A 
ldrb r1, [r2] 
cmp r1, #0 
beq Start @ version that calls 


@ excerpt from ComputeAiAttackWeight (start of function) 
ldr r1, =AiData+0x7D @ this is how vanilla stores ai3 pointer to gpAiBattleWeightFactorTable 
ldrb r2, [r1] 
lsl r1, r2, #2 
add r1, r2 
lsl r1, #2 
ldr r2, =ai3_address @ ai3_address 
add r1, r2 @ end of vanilla excerpt from ComputeAiAttackWeight
@ldr r3, =gpAiBattleWeightFactorTable 
@str r1, [r3] 
@ldrb r3, [r1, #7]  @ Penalty: attacker's remaining hp 
ldrb r1, [r1, #6] @ Penalty: range and attack power of opponents 
@orr r1, r3 
cmp r1, #0 
beq RetZero 
ldrb r0, [r0] 
b QuickExit 
RetZero: 
mov r0, #0 
QuickExit: 
bx lr 

Start: 
push {r4, lr} 
@ [20304A0..2030800]?!!

mov r4, r0 @ coordinate of gMapMove2, which we may put damage taken into 
mov r0, #1 
ldr r2, =AiData+0x7A 
strb r0, [r2] @ aiData+0x7A still 
ldr r0, =gMapMove2 
ldr r0, [r0] 
mov r1, #0 
blh ClearMapWith 

@ excerpt from ComputeAiAttackWeight (start of function) 
ldr r1, =AiData+0x7D @ this is how vanilla stores ai3 pointer to gpAiBattleWeightFactorTable 
ldrb r2, [r1] 
lsl r1, r2, #2 
add r1, r2 
lsl r1, #2 
ldr r2, =ai3_address @ ai3_address 
add r1, r2 @ end of vanilla excerpt from ComputeAiAttackWeight
@ldr r3, =gpAiBattleWeightFactorTable 
@str r1, [r3] 
@ldrb r3, [r1, #7]  @ Penalty: attacker's remaining hp 
ldrb r1, [r1, #6] @ Penalty: range and attack power of opponents 
@orr r1, r3 
cmp r1, #0 
bne VanillaBehaviour 
mov r4, #0 
b End 

VanillaBehaviour: 
blh FillAiDangerMap 
ldrb r4, [r4] 
End: 
mov r0, r4 


pop {r4} 
pop {r1} 
bx r1
@ returns value in r1 
.ltorg 














