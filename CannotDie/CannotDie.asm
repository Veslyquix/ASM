.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ SecondRound, 0x203E152 @ for doubling? 
	.equ CheckEventId,0x8083da8
	.equ SetEventId, 0x8083D80
	.equ EventEngine, 0x800D07C 
	.equ MemorySlot, 0x30004B8 
	.equ CurrentRound_ComputeWeaponEffect, 0x802B600 
@.global CannotDieEffect 
@.type CannotDieEffect, %function 
@CannotDieEffect: 
mov r1, r5 @ vanilla 
push {r4-r7, lr} 
mov r5, r1 @ defender 

ldr     r0,=0x802b444    @pointer to the current round
ldr     r0, [r0]          @current round pointer (usually 203a608)
ldr     r6, [r0]         @current round (originally starting at 203a5ec), increment by 4 bytes to get the next round

ldr     r0,=0x203A4D4    @Battle Stats Data?                @ 0802B3FA 4C11   
mov     r7, r0


ldr r0, =CannotDieProc 
blh ProcFind 
cmp r0, #0 
beq Normal
ldr r1, [r0, #0x30] @ the round it calculated for 
cmp r6, r1 
ble Normal 
@ last round couldn't die, so end immediately 
ldr r2, [r6] @ current round flags 
mov r1, #0x80 @ end battle 
lsl r1, #16 
orr r2, r1 
str r2, [r6] @ end battle 
@b Break 


Normal: 
@mov r6, r2 @battle buffer
@mov r7, r3 @battle data

ldr r4, CannotDieList 
sub r4, #8 

Loop: 
add r4, #8
ldr r0, [r4] 
mov r1, #0 
sub r1, #1 @ 0xFFFFFFFF terminator 
cmp r0, r1
beq Break 
ldr r2, [r5] @ char pointer 
ldrb r2, [r2, #4] @ char id 
ldrb r0, [r4] @ matching char ID 
cmp r0, #0 
beq AnyChar 
cmp r0, r2 
bne Loop 

AnyChar: 
ldr r3, [r5, #4] @ class pointer 
ldrb r3, [r3, #4] @ class ID 
ldrb r0, [r4, #1] 
cmp r0, #0 
beq AnyClass 
ldrb r1, [r4, #1] 
cmp r1, r3 
bne Loop 
AnyClass: 

ldrh r0, [r4, #2] @ flag 
cmp r0, #0 
beq AnyFlag
blh CheckEventId 
cmp r0, #1 
beq Loop 
AnyFlag: 

ldr r2, [r6] 
mov r0, #1 @ critical 
tst r0, r2 
beq NoReduceDmg 
bic r2, r0 @ remove crit 
str r2, [r6] 
ldrb r0, [r7, #0x04] @ dmg 
mov r1, #3 @ div by 3 
swi 6 
strb r0, [r7, #4] @ dmg 



NoReduceDmg: 
@only activate if damage > current enemy hp-1
ldrb	r1,[r5,#0x13]
@mov	r0,#0x01
@sub	r5,r0 @ current hp - 1 
ldrb    r0,[r7,#0x04] @ damage 
cmp	r1,r0
bgt Break @ if health > damage, exit 
@ copied bane 
@ no clue really what this does 

@set offensive skill flag and miss flag 
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0,#0x2          @miss flag     @ 0802B430 2002  

ldrh r3, [r4, #4] @ death quote? 
cmp r3, #0 
bne NoMiss 
orr r1, r0 @ set miss flag 
mov     r0, #0x40
lsl     r0, #8           @0x4000, attacker skill activated
orr     r1, r0
NoMiss: 
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     

mov r1, #1 
lsl r1, #21 
bic r0, r1 @ 	BATTLE_HIT_INFO_KILLS_TARGET = (1 << 2),
str     r0,[r6]                @ 0802B43A 6018   


ldrh r3, [r4, #4] @ death quote? 
cmp r3, #0 
beq ZeroDmg
ldrb	r0,[r5,#0x13]
sub r0, #1 @ current hp - 1 as dmg (so we survive at 1 hp) 
b StoreDmg 
ZeroDmg: 
mov r0, #0
StoreDmg:  
strb r0, [r7, #0x04] @ no damage 

ldr r0, =CannotDieProc 
blh ProcFind 
cmp r0, #0 
beq DontEnd 
blh EndProc 

DontEnd: 
ldr r0, =CannotDieProc 
mov r1, #3 @ root 3 
blh New6C 
ldrh r3, [r4, #4] @ quote
strh r3, [r0, #0x2c] @ 
str r6, [r0, #0x30] @ current round pointer 
ldrh r1, [r4, #6] @ flag to set 
strh r1, [r0, #0x2e] @ flag to set 


Break: 
pop {r4-r7}
mov r0, r4 @ atkr 
mov r1, r5 @ dfdr 
blh CurrentRound_ComputeWeaponEffect
mov r0, #0x13 
ldsb r0, [r4, r0] 
cmp r0, #0 
 
pop {r1} 
bx r1 
.ltorg 


.equ EndProc, 0x8002D6C 
.equ BreakProcLoop, 0x08002E94
.equ ProcFind, 0x08002E9C
.set New6C,   0x08002C7C 

.global WaitUntilBattleEnds
.type WaitUntilBattleEnds, %function
WaitUntilBattleEnds:
bx lr 
.ltorg 
.global new_8052F24 
.type new_8052F24, %function 
new_8052F24:
push {r4-r5, lr} 
mov r4, r0 
blh 0x0800D1B0	@BattleEventEngineExists	{U}
mov r5, r0 
cmp r5, #0 
bne ContinueLoop 
blh 0x0805B07C   //PlayBattleCroudSfxIfArena
LDR r0, [r4, #0x5C]
LDR r1, [r4, #0x60]
@blh 0x08052FAC   //StartEfxDead
blh 0x08051F1C
LDR r0, [r4, #0x5C]
blh 0x0805A16C   //GetAISSubjectId r0=@AnimationInterpreter
LDR r1, =0x203E104 @# pointer:08052F80 -> 0203E104 (gBattleAnimUnitEnabledLookup )
LSL r0 ,r0 ,#0x1
ADD r0 ,r0, R1
STRH r5, [r0, #0x0]   //gBattleAnimUnitEnabledLookup
MOV r0, #0x1
blh 0x08001FAC   //BG_EnableSyncByMask
MOV r0, #0x0
MOV r1, #0x7
blh 0x08056D24   //NewEkrWindowAppear
MOV r0, #0x0
MOV r1, #0x7
MOV r2, #0x0
blh 0x08056E10   //NewEkrNamewinAppear
blh 0x08051228   //EkrGauge_8051228
blh 0x08051BA0
blh 0x08051180   //EkrGauge_8051180

LDR r0, [r4, #0x5C]
blh 0x0805A16C   @//GetAISSubjectId r0=@AnimationInterpreter
ldr r1, =0x203E188 @ ToLeftPointer 
lsl r2, r0, #2 @ 4 bytes per 
add r2, r1 @ poin attacker or defender 
ldr r2, [r2] 
ldrb r3, [r2, #0x12] @ max hp 
strb r3, [r2, #0x13] @ current hp 

ldr r1, =0x8052494 
ldr r1, [r1]  @ 203E1AC (gBattleHpDisplayedValue )
lsl r0, #1 
add r0, r1 
strh r3, [r0] @ new hp 


mov r0, r4 
blh BreakProcLoop 

ContinueLoop: 
pop {r4-r5} 
pop {r0} 
bx r0 
.ltorg 

.equ GetAISSubjectId, 0x805A16C 
.equ TryBattleQuote, 0x8050000
.equ ShouldDisplayDeathQuoteForChar, 0x80835A8

.global ShouldDisplayNearDeathQuote_MapAnim 
.type ShouldDisplayNearDeathQuote_MapAnim, %function 
ShouldDisplayNearDeathQuote_MapAnim:
push {r4-r7, lr} 
mov r4, r1 
mov r5, r2 

ldr r0, =CannotDieProc 
blh ProcFind 
cmp r0, #0 
beq ContinueAsNormal 
mov r7, r0 @ proc 
@ldr     r0,=0x802b444    @pointer to the current round
@ldr     r0, [r0]          @current round pointer (usually 203a608)
@ldr     r0, [r0]         @current round (originally starting at 203a5ec), increment by 4 bytes to get the next round
@ldr r1, [r7, #0x30] @ pointer to the relevant round 
@cmp r0, r1 
@bne ContinueAsNormal 
ldrh r0, [r7, #0x2e] @ flag to set 
blh SetEventId 



mov r0, #1 
ldr r3, =0x203E211 
ldrb r2, [r3] 
cmp r2, #1 
beq WeFoundSomeoneAt1Hp 
mov r0, #0 
ldr r3, =0x203E1FD 
ldrb r2, [r3] 
cmp r2, #1 
bne ContinueAsNormal
WeFoundSomeoneAt1Hp: 
mov r6, r0 


ldrh r0, [r7, #0x2c] @ text to display 
cmp r0, #0 
beq MapAnim_Vanilla
mov r5, r6 

lsl r0, r5, #2 
add r0, r5 
lsl r0, #2 
add r0, r4 
ldr r0, [r0] @ relevant battle struct 

ldrb r1, [r0, #0x12] @ 
strb r1, [r0, #0x13] @ curr hp 
strb r1, [r3] @ 

@ based on 7A984 MapAnimProc_DisplayDeathQuote
blh 0x0807BBB8  @ //DeleteBattleAnimInfoThing
bl TryDisplayCannotDieQuote 

b MapAnim_Vanilla 

ContinueAsNormal: 
mov r0, #1 
neg r0, r0 @ 0xFFFFFFFF 
cmp r5, r0 
beq MapAnim_Vanilla 

Exit_MapAnim: 
lsl r0, r5, #2 
add r0, r5 
lsl r0, #2 

mov r3, r4 
mov r2, r5 
pop {r4-r7} 

pop {r1} 
bx r1 
.ltorg 

MapAnim_Vanilla:

mov r3, r4 
mov r2, r5 
pop {r4-r5} 
pop {r1} 
ldr r1, =0x807A9F5 
bx r1 
.ltorg 


.global ShouldDisplayNearDeathQuote 
.type ShouldDisplayNearDeathQuote, %function 
ShouldDisplayNearDeathQuote:
push {r4, lr} 

ldr r0, =CannotDieProc 
blh ProcFind 
cmp r0, #0 
beq DontSetFlag 
@ldr     r0,=0x802b444    @pointer to the current round
@ldr     r0, [r0]          @current round pointer (usually 203a608)
@ldr     r0, [r0]         @current round (originally starting at 203a5ec), increment by 4 bytes to get the next round
@ldr r1, [r7, #0x30] @ pointer to the relevant round 
@cmp r0, r1 
@bne ContinueAsNormal 
ldrh r0, [r0, #0x2e] @ flag to set 
blh SetEventId 
DontSetFlag: 

ldr r0, [r5, #0x50] 
cmp r0, #1 
bgt ContinueBattle 
cmp r0, #0 
beq VanillaBehaviour 
cmp r0, #1 
bne ContinueBattle 
@ we have 1 hp, so check if CannotDieProc is running
ldr r0, =CannotDieProc 
blh ProcFind 
cmp r0, #0 
beq ContinueBattle 
mov r4, r0 @ proc 
ldrh r0, [r4, #0x2c] @ text to display 
cmp r0, #0 
beq ContinueBattle 


ldr r0, =efxNearDeathEVTENT @ new version without death fade 
mov r1, #3 
blh New6C 
str r6, [r0, #0x5C] @ based on StartEfxDeadEVTENT at 52DD4
str r7, [r0, #0x60] 
ldr r1, =0x8052DF8 @ poin 2017738 
ldr r1, [r1] 
mov r0, #1 
str r0, [r1] @ end of vanilla 




b ContinueBattle 

VanillaBehaviour: 
@ vanilla - if link battle, don't show death quote 
ldr r0, =0x804FD5C @ POIN 203E0F0
ldr r0, [r0] @ gBoolBattleIsLinkArena
cmp r0, #1
pop {r4} 
pop {r3} 
bx r3 
.ltorg 

ContinueBattle: 
pop {r4} 
pop {r3} 
ldr r3, =0x80524E5 
bx r3 
.ltorg 
.global new_8052DFC
.type new_8052DFC, %function 
new_8052DFC: 
push {r4-r5, lr} 
mov r5, r0 
LDR r0, [r5, #0x5C]
blh 0x0805A16C   @//GetAISSubjectId r0=@AnimationInterpreter
ldr r1, =0x8052494 
ldr r1, [r1]  @ 203E1AC (gBattleHpDisplayedValue )
lsl r0, #1 
add r0, r1 
mov r1, #120
strh r1, [r0] @ new hp 
mov r0, r5 @ proc 
blh 0x8052DFC
pop {r4-r5} 
pop {r0} 
bx r0 
.ltorg 


.global new_8052EAC
.type new_8052EAC, %function 
new_8052EAC:
PUSH {r4,r5,lr}   @//Procs efxDeadEVTENT CallASM
SUB SP, #0x4
MOV r5 ,r0
blh 0x08056D74
LSL r0 ,r0 ,#0x18
ASR r0 ,r0 ,#0x18
CMP r0, #0x1
BNE exit_new_8052EAC
blh 0x08051218   @//EkrGauge_8051218
blh 0x08051B90
MOV r0, #0x0
STR r0,[SP, #0x0]
LDR r1, =0x2022ca8 @ # pointer:08052F14 -> 02022CA8 (BG0 Map Buffer )
LDR r2, =0x1000200  @# pointer:08052F18 -> 01000200
MOV r0, SP
blh 0x080D1674   @//CPUFastSet
LDR r0, =0x2000038 @ # pointer:08052F1C -> 02000038
LDRH r1, [r0, #0x0] @ # pointer:02000038
LDRH r2, [r0, #0x2] @ # pointer:0200003A
MOV r0, #0x0
blh 0x0800148C   @//BG_SetPosition
MOV r0, #0x1
MOV r1, #0x0
MOV r2, #0x0
blh 0x0800148C   @//BG_SetPosition
MOV r0, #0x1
blh 0x08001FAC   @//BG_EnableSyncByMask
blh 0x08051190   @//EkrGauge_8051190
LDR r4, =0x203E190 @# pointer:08052F20 -> 0203E190 (gBatttleUnitID1 )


bl TryDisplayCannotDieQuote




MOV r0 ,r5
blh 0x08002E94   @//Break6CLoop
exit_new_8052EAC: 
ADD SP, #0x4
POP {r4,r5}
POP {r0}
BX r0
.ltorg 

TryDisplayCannotDieQuote: 
push {r4, lr} 
ldr r0, =CannotDieProc @ our stuff 
blh ProcFind 
cmp r0, #0 
beq exit_DisplayCannotDieQuote
ldrh r1, [r0, #0x2c] 
push {r1} 
blh EndProc @ so multiple don't spawn 
pop {r0} 
blh 0x800D284 @ CallBattleQuoteTextEvents 
@blh 0x080835DC   @//DisplayDeathQuoteForChar
exit_DisplayCannotDieQuote: 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 

CannotDieList: 


