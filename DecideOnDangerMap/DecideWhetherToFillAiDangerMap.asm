.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ AiData, 0x203AA00	@{J}
.equ ClearMapWith, 0x80194BC	@{J}
.equ gMapMove2, 0x202E4EC	@{J} @ [2030455..2030711]?
.equ FillAiDangerMap, 0x803E2B0	@{J}
.equ gpAiBattleWeightFactorTable, 0x30017D0	@{J}
.equ Attacker, 0x203A4E8	@{J}

push {lr} 

ldr r0, =gMapMove2 
ldr r0, [r0] 
mov r1, #0 
blh ClearMapWith 

pop {r0} 
bx r0 
