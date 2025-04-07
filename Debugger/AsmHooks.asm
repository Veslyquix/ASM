
.thumb


.global CallDebuggerProc
.type CallDebuggerProc, %function 
CallDebuggerProc: 
push  {r14}
bl StartKeyListenerProc


ldr r0, =0x858791c 
ldr r0, [r0] @ 0x2024cc0
ldrh r1, [r0, #8] @ new button 
mov r0, #2 
tst r0, r1 
bne PressedB
mov r0, #1 
and r0, r1 
cmp r0, #0 
pop {r3} 
bx r3 
.ltorg 

PressedB: 


mov r0, r6 @ parent 
bl StartDebuggerProc
pop {r3} 
ldr r3, =0x801Cb65 
bx r3 
.ltorg 

.global CallDebuggerProc_FE6
.type CallDebuggerProc_FE6, %function 
CallDebuggerProc_FE6: 
push  {r14}
@bl StartKeyListenerProc


ldr r0, =gKeyStatusPtr 
ldr r0, [r0] 
ldrh r1, [r0, #8] @ new button 
mov r0, #2 
tst r0, r1 
bne PressedB_FE6
mov r0, #1 
and r0, r1 
cmp r0, #0 
pop {r3} 
bx r3 
.ltorg 

PressedB_FE6: 


mov r0, r6 @ parent 
bl StartDebuggerProc
pop {r3} 
ldr r3, =0x801B35D @ end of function 
bx r3 
.ltorg 

.global CallDebuggerProc_FE7
.type CallDebuggerProc_FE7, %function 
CallDebuggerProc_FE7: 
push  {r14}
@bl StartKeyListenerProc


ldr r0, =gKeyStatusPtr 
ldr r0, [r0] 
ldrh r1, [r0, #8] @ new button 
mov r0, #2 
tst r0, r1 
bne PressedB_FE7
mov r0, #1 
and r0, r1 
cmp r0, #0 
pop {r3} 
bx r3 
.ltorg 

PressedB_FE7: 


mov r0, r6 @ parent 
bl StartDebuggerProc
pop {r3} 
ldr r3, =0x801C4c5 @ end of function 
bx r3 
.ltorg 



.global memmove 
.type memmove, %function 
memmove: 
PUSH {r4,r5,lr}   //memmove
MOV r5 ,r0
MOV r4 ,r5
MOV r3 ,r1
CMP r3 ,r5
BCS label1
ADD r0 ,r3, R2
CMP r5 ,r0
BCS label1
MOV r3 ,r0
ADD r4 ,r5, R2
SUB r2, #0x1
MOV r0, #0x1
NEG r0 ,r0
CMP r2 ,r0
BEQ memmove_end
MOV r1 ,r0
memmove_loop:
SUB r4, #0x1
SUB r3, #0x1
LDRB r0, [r3, #0x0]
STRB r0, [r4, #0x0]
SUB r2, #0x1
CMP r2 ,r1
BNE memmove_loop
B memmove_end
label1:
CMP r2, #0xF
BLS label2
MOV r0 ,r3
ORR r0 ,r4
MOV r1, #0x3
AND r0 ,r1
CMP r0, #0x0
BNE label4
MOV r1 ,r3
label2:
LDMIA r1!,{r0}
STMIA r4!,{r0}
LDMIA r1!,{r0}
STMIA r4!,{r0}
LDMIA r1!,{r0}
STMIA r4!,{r0}
LDMIA r1!,{r0}
STMIA r4!,{r0}
SUB r2, #0x10
CMP r2, #0xF
BHI label2
CMP r2, #0x3
BLS label3
memmove_loop2:
LDMIA r1!,{r0}
STMIA r4!,{r0}
SUB r2, #0x4
CMP r2, #0x3
BHI memmove_loop2 
label3:
MOV r3 ,r1
label4:
SUB r2, #0x1
MOV r0, #0x1
NEG r0 ,r0
CMP r2 ,r0
BEQ memmove_end
MOV r1 ,r0
memmove_loop3: 
LDRB r0, [r3, #0x0]
STRB r0, [r4, #0x0]
ADD r3, #0x1
ADD r4, #0x1
SUB r2, #0x1
CMP r2 ,r1
BNE memmove_loop3
memmove_end: 
MOV r0 ,r5
POP {r4,r5}
pop {r3} 
BX r3

.ltorg 
.global Mod
.type Mod, %function 
__aeabi_idivmod:
Mod: 
cmp r1, #0 
bne ContinueMod 
mov r0, #0 
bx lr 
ContinueMod: 
swi 6
mov r0, r1
bx lr
.ltorg 

@.global __aeabi_idiv
@.type __aeabi_idiv, %function 
.global Div1
.type Div1, %function 
__aeabi_idiv: 
Div1: 
cmp r1, #0 
bne ContinueDiv 
mov r0, #0 
bx lr 
ContinueDiv: 
swi 6
bx lr 
.ltorg 

