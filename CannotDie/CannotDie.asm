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
.equ IsRightToLeft, 0x805A16C
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

ldr r4, =CannotDieList 
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

@ldr r2, [r6] 
@mov r0, #1 @ critical 
@tst r0, r2 
@beq NoReduceDmg 
@bic r2, r0 @ remove crit 
@str r2, [r6] 
@ldrb r0, [r7, #0x04] @ dmg 
@mov r1, #3 @ div by 3 
@swi 6 
@strb r0, [r7, #4] @ dmg 



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









.global Vesly_efxHPBarRoutine
.type Vesly_efxHPBarRoutine, %function 
Vesly_efxHPBarRoutine:

push    {r4-r7,r14}                @ 080523EC B5F0     
mov     r5,r0                @ 080523EE 1C05     
ldr     r4,=#0x2000000                @ 080523F0 4C27     
ldr     r0,[r5,#0x60]    @0x5c for attacker's AIS           @ 080523F2 6E28     
blh      IsRightToLeft                @ 080523F4 F007FEBA 
lsl     r0,r0,#0x3                @ 080523F8 00C0     
add     r0,r0,r4                @ 080523FA 1900     
ldr     r6,[r0]                @ 080523FC 6806     
ldr     r0,[r5,#0x60]                @ 080523FE 6E28     
blh      IsRightToLeft                @ 08052400 F007FEB4 
lsl     r0,r0,#0x1                @ 08052404 0040     
add     r0,#0x1                @ 08052406 3001     
lsl     r0,r0,#0x2                @ 08052408 0080     
add     r0,r0,r4                @ 0805240A 1900     
ldr     r7,[r0]                @ 0805240C 6807     
ldr     r1,[r5,#0x58]                @ 0805240E 6DA9     
cmp     r1,#0x0                @ 08052410 2900     
bne     loc_0x805244E                @ 08052412 D11C     
  ldrh    r0,[r5,#0x2C]                @ 08052414 8DA8     
  add     r0,#0x1                @ 08052416 3001     
  strh    r0,[r5,#0x2C]                @ 08052418 85A8     
  lsl     r0,r0,#0x10                @ 0805241A 0400     
  asr     r0,r0,#0x10                @ 0805241C 1400     
  cmp     r0,#0x2                @ 0805241E 2802     
  bne     loc_0x805244E                @ 08052420 D115     
    strh    r1,[r5,#0x2C]                @ 08052422 85A9  
    mov r1, #0x48   @change HP delta to signed halfword
    ldrsh     r1,[r5,r1]                @ 08052424 6CA9     
    ldrh    r0,[r5,#0x2E]                @ 08052426 8DE8     
    add     r0,r0,r1                @ 08052428 1840     
    strh    r0,[r5,#0x2E]                @ 0805242A 85E8     
    ldr     r0,[r5,#0x60]                @ 0805242C 6E28     
    blh      IsRightToLeft                @ 0805242E F007FE9D 
    ldr     r1,=#0x203E1AC                @ 08052432 4918     @where hp is stored.
    lsl     r0,r0,#0x1                @ 08052434 0040     
    add     r0,r0,r1                @ 08052436 1840    
    mov r2, #0x48 @same here 
    ldrsh     r2,[r5,r2]                @ 08052438 6CAA     
    ldrh    r1,[r0]                @ 0805243A 8801     
    add     r1,r1,r2                @ 0805243C 1889     
    strh    r1,[r0]                @ 0805243E 8001    @@@HERE WE SAVED THE NEW HP  

      @now we check the other side's HP... I think.
      @check the current HP
      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ make sure HP Draining is checked.
      @now update the attacker   
      ldr     r0,[r5,#0x5c]                @ 08052368 6E30     
      ldrh    r0, [r0, #0xE]            @ Next round index
      sub     r0, #0x1
      ldr     r1, =0x802b90a
      ldrb    r1, [r1] @ battle buffer width.
      mul     r0, r1
      ldr     r1, =0x802aec4
      ldr     r1, [r1] @ r1 is battle buffer 203aac0
      add     r0, r1
      ldr     r0, [r0]
      mov r1, #0x10
      lsl r1, #4 @0x100 is drain hp
      and r1, r0
      cmp r1, #0
      bne NextCheck
        mov r0, #0x4a
        strh r1, [r5, r0] @ No HP drain, so set attacker's hp delta to 0.
        b AttackerDone
      NextCheck:
      mov r2, #0x30 @curr hp
      ldsh r1, [r5,r2]
      mov r2, #0x52 @final hp
      ldrsh r0, [r5,r2]
      cmp r1, r0
      beq AttackerDone
      cmp r0, #0xff
      beq AttackerDone
        mov r1, #0x4a @attacker's hp delta
        ldrsh r1, [r5,r1]
        ldrh r0, [r5, #0x30] @attacker's hp
        add r0, r1
        strh r0, [r5, #0x30]
        ldr r0, [r5, #0x5c]
        blh IsRightToLeft
        ldr     r1,=#0x203E1AC                @ 08052432 4918     @where hp is stored.
        lsl     r0,r0,#0x1                @ 08052434 0040     
        add     r0,r0,r1                @ 08052436 1840    
        mov r2, #0x4a @same here 
        ldrsh     r2,[r5,r2]                @ 08052438 6CAA  
        ldrh r1, [r0]
        add r1, r2
        strh r1, [r0]
    AttackerDone:
    mov     r0,#0x2E                @ 08052440 202E     
    ldsh    r1,[r5,r0]                @ 08052442 5E29 
    mov r2, #0x50    
    ldrsh     r0,[r5,r2]                @ 08052444 6D28     
    cmp     r1,r0                @ 08052446 4281     @@ Current HP = Final HP?
    bne     loc_0x805244E                @ 08052448 D101     
      @ Defender's HP is done. But is the attacker's?
      @ Set defender's delta to 0.
      mov r0, #0x0
      mov r1, #0x48
      strh r0, [r5, r1]
      @ End if both attacker and defender's HP changes have finished.
      mov r2, #0x30 @curr hp
      ldsh r1, [r5,r2]
      mov r2, #0x52 @final hp
      ldsh r0, [r5,r2]
      cmp r1, r0
      beq AttackerAndDefenderDone
        cmp r0, #0xff
        beq AttackerAndDefenderDone
          mov r0, #0x4a
          ldsh r0, [r5, r0]           @ Attacker's delta
          cmp r0, #0x0
          beq AttackerAndDefenderDone
            b loc_0x805244E
      AttackerAndDefenderDone:
      mov     r0,#0x1                @ 0805244A 2001     
      str     r0,[r5,#0x58]                @ 0805244C 65A8     
loc_0x805244E:
ldr     r1,[r5,#0x54]                @ 0805244E 6D69     
cmp     r1,#0x1E                @ 08052450 291E     
bne     loc2_0x80524F0                @ 08052452 D14D     
  ldr     r0,[r5,#0x58]                @ 08052454 6DA8     
  cmp     r0,#0x1                @ 08052456 2801     
  bne     loc2_0x80524F0                @ 08052458 D14A     
    ldr     r4,=#0x203E152                @ 0805245A 4C0F     
    ldr     r0,[r5,#0x60]                @ 0805245C 6E28     
    blh IsRightToLeft                @ 0805245E F007FE85 
    lsl     r0,r0,#0x1                @ 08052462 0040     
    add     r0,r0,r4                @ 08052464 1900     
    ldrh    r1,[r0]                @ 08052466 8801     
    add     r1,#0x1                @ 08052468 3101     
    mov     r4,#0x0                @ 0805246A 2400     
    strh    r1,[r0]                @ 0805246C 8001     
    ldr     r0,[r5,#0x60]                @ 0805246E 6E28     
    blh IsRightToLeft                @ 08052470 F007FE7C 
    ldr     r1,=#0x2017780                @ 08052474 4909     
    lsl     r0,r0,#0x1                @ 08052476 0040     
    add     r0,r0,r1                @ 08052478 1840     
    strh    r4,[r0]                @ 0805247A 8004  
    @mov r0, #0x50   
    @ldrh     r0,[r5,r0]                @ 0805247C 6D28   



ldr r0, =CannotDieProc 
blh ProcFind 
cmp r0, #0 
beq DontSetFlag2 
@ldr     r0,=0x802b444    @pointer to the current round
@ldr     r0, [r0]          @current round pointer (usually 203a608)
@ldr     r0, [r0]         @current round (originally starting at 203a5ec), increment by 4 bytes to get the next round
@ldr r1, [r7, #0x30] @ pointer to the relevant round 
@cmp r0, r1 
@bne ContinueAsNormal 
ldrh r0, [r0, #0x2e] @ flag to set 
blh SetEventId 
DontSetFlag2: 

mov r0, #0x50 
ldrh r0, [r5, r0] 
cmp r0, #1 
bgt loc_0x80524E4
cmp r0, #0 
beq VanillaBehaviour2
cmp r0, #1 
bne loc_0x80524E4
@ we have 1 hp, so check if CannotDieProc is running
ldr r0, =CannotDieProc 
blh ProcFind 
cmp r0, #0 
beq loc_0x80524E4
mov r4, r0 @ proc 
ldrh r0, [r4, #0x2c] @ text to display 
cmp r0, #0 
beq loc_0x80524E4 


ldr r0, =efxNearDeathEVTENT @ new version without death fade 
mov r1, #3 
blh New6C 
str r6, [r0, #0x5C] @ based on StartEfxDeadEVTENT at 52DD4
str r7, [r0, #0x60] 
ldr r1, =0x8052DF8 @ poin 2017738 
ldr r1, [r1] 
mov r0, #1 
str r0, [r1] @ end of vanilla 
b loc_0x80524E4





	
    cmp     r0,#0x0                @ 0805247E 2800     
    bne     loc_0x80524E4                @ 08052480 D130  
VanillaBehaviour2: 	
        blh      0x804FD54                @ 08052482 F7FDFC67 
        cmp     r0,#0x1                @ 08052486 2801     
        bne     loc_0x80524A0                @ 08052488 D10A     
          mov     r0,#0x0                @ 0805248A 2000     
          b       loc_0x80524B4                @ 0805248C E012
          .ltorg 
        loc_0x80524A0:       
        ldr     r4,=#0x203E190                @ 080524A0 4C08     
        mov     r0,r6                @ 080524A2 1C30     
        blh IsRightToLeft                @ 080524A4 F007FE62 
        add     r0,r0,r4                @ 080524A8 1900     
        ldrb    r0,[r0]                @ 080524AA 7800     
        blh      0x80835A8                @ 080524AC F031F87C 
        lsl     r0,r0,#0x18                @ 080524B0 0600     
        asr     r0,r0,#0x18                @ 080524B2 1600  
      loc_0x80524B4:   
      cmp     r0,#0x1                @ 080524B4 2801     
      bne     loc_0x80524C8                @ 080524B6 D107     
      mov     r0,r6                @ 080524B8 1C30     
      mov     r1,r7                @ 080524BA 1C39     
      blh      0x8052DD4                @ 080524BC F000FC8A 
      b       loc_0x80524E4                @ 080524C0 E010   
      .ltorg      
  loc2_0x80524F0:
  b loc_0x80524F0
        loc_0x80524C8:
        blh      0x805B07C                @ 080524C8 F008FDD8 
        mov     r0,r6                @ 080524CC 1C30     
        mov     r1,r7                @ 080524CE 1C39     
        blh      0x8052FAC                @ 080524D0 F000FD6C 
        ldr     r0,[r5,#0x60]                @ 080524D4 6E28     
        blh IsRightToLeft                @ 080524D6 F007FE49 
        ldr     r1,=#0x203E104                @ 080524DA 4904     
        lsl     r0,r0,#0x1                @ 080524DC 0040     
        add     r0,r0,r1                @ 080524DE 1840     
        mov     r1,#0x0                @ 080524E0 2100     
        strh    r1,[r0]                @ 080524E2 8001 
    loc_0x80524E4:    
    mov     r0,r5                @ 080524E4 1C28     
    blh      0x8002E94                @ 080524E6 F7B0FCD5 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    ldr     r0,[r5,#0x5c]                @ 08052368 6E30     
    ldrh    r0, [r0, #0xE]            @ Next round index
    sub     r0, #0x1
    ldr     r1, =0x802b90a
    ldrb    r1, [r1] @ battle buffer width.
    mul     r0, r1
    ldr     r1, =0x802aec4
    ldr     r1, [r1] @ r1 is battle buffer 203aac0
    add     r0, r1
    ldr     r0, [r0]
    mov r1, #0x10
    lsl r1, #4 @0x100 is drain hp
    and r1, r0
    cmp r1, #0
    beq End

    ldr     r4,=#0x203E152                @ 0805245A 4C0F     
    ldr     r0,[r5,#0x5c]                @ 0805245C 6E28     
    blh IsRightToLeft                @ 0805245E F007FE85 
    lsl     r0,r0,#0x1                @ 08052462 0040     
    add     r0,r0,r4                @ 08052464 1900     
    ldrh    r1,[r0]                @ 08052466 8801     
    add     r1,#0x1                @ 08052468 3101     
    mov     r4,#0x0                @ 0805246A 2400     
    strh    r1,[r0]                @ 0805246C 8001     
    ldr     r0,[r5,#0x5c]                @ 0805246E 6E28     
    blh IsRightToLeft                @ 08052470 F007FE7C 
    ldr     r1,=#0x2017780                @ 08052474 4909     
    lsl     r0,r0,#0x1                @ 08052476 0040     
    add     r0,r0,r1                @ 08052478 1840     
    strh    r4,[r0]                @ 0805247A 8004     
    mov r0, #0x52
    ldrh     r0,[r5,r0]                @ 0805247C 6D28     
    cmp     r0,#0x0                @ 0805247E 2800     
    bne     loc2_0x80524E4                @ 08052480 D130     
        blh      0x804FD54                @ 08052482 F7FDFC67 
        cmp     r0,#0x1                @ 08052486 2801     
        bne     loc2_0x80524A0                @ 08052488 D10A     
          mov     r0,#0x0                @ 0805248A 2000     
          b       loc2_0x80524B4                @ 0805248C E012
          .ltorg 
        loc2_0x80524A0:       
        ldr     r4,=#0x203E190                @ 080524A0 4C08     
        mov     r0,r6                @ 080524A2 1C30     
        blh IsRightToLeft                @ 080524A4 F007FE62 
        add     r0,r0,r4                @ 080524A8 1900     
        ldrb    r0,[r0]                @ 080524AA 7800     
        blh      0x80835A8                @ 080524AC F031F87C 
        lsl     r0,r0,#0x18                @ 080524B0 0600     
        asr     r0,r0,#0x18                @ 080524B2 1600  
      loc2_0x80524B4:   
      cmp     r0,#0x1                @ 080524B4 2801     
      bne     loc2_0x80524C8                @ 080524B6 D107     
      mov     r0,r6                @ 080524B8 1C30     
      mov     r1,r7                @ 080524BA 1C39     
      blh      0x8052DD4                @ 080524BC F000FC8A 
      b       loc2_0x80524E4                @ 080524C0 E010   
      .ltorg      
        loc2_0x80524C8:
        blh      0x805B07C                @ 080524C8 F008FDD8 
        mov     r0,r6                @ 080524CC 1C30     
        mov     r1,r7                @ 080524CE 1C39     
        blh      0x8052FAC                @ 080524D0 F000FD6C 
        ldr     r0,[r5,#0x5c]                @ 080524D4 6E28     
        blh IsRightToLeft                @ 080524D6 F007FE49 
        ldr     r1,=#0x203E104                @ 080524DA 4904     
        lsl     r0,r0,#0x1                @ 080524DC 0040     
        add     r0,r0,r1                @ 080524DE 1840     
        mov     r1,#0x0                @ 080524E0 2100     
        strh    r1,[r0]                @ 080524E2 8001 
    loc2_0x80524E4:    
    mov     r0,r5                @ 080524E4 1C28     
    blh      0x8002E94                @ 080524E6 F7B0FCD5 
    b       End                @ 080524EA E007     
    .ltorg
loc_0x80524F0:    
add     r0,r1,#1                @ 080524F0 1C48     
str     r0,[r5,#0x54]                @ 080524F2 6568     
cmp     r0,#0x1D                @ 080524F4 281D     
bls     End                @ 080524F6 D901     
mov     r0,#0x1E                @ 080524F8 201E     
str     r0,[r5,#0x54]                @ 080524FA 6568 
End:    
pop     {r4-r7}                @ 080524FC BCF0     
pop     {r0}                @ 080524FE BC01     
bx      r0                @ 08052500 4700  

.ltorg 


