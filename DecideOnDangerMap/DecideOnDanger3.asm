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
@.equ FillAiDangerMap, 0x803E320	@{U}

@ FE8J
.equ AiData, 0x203AA00	@{J}
.equ ClearMapWith, 0x80194BC	@{J}
.equ FillAiDangerMap, 0x803E2B0	@{J}
.equ ai3_address, 0x80DCE54 @ {J} 


push {lr} 
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
beq End  
blh FillAiDangerMap 
End:  
pop {r0} 
bx r0
.ltorg 














