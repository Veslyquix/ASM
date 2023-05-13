@send to storage:

.thumb

@item data in r0
push {r5-r6, lr}

mov r6, r1 @ current unit +0x1E or so 
mov r5, r2 @ something to store 

@check uses
mov r1, #0x80
lsl r1, #8    @0x8000, aka top bit set
cmp r0,r1
bge NoTrade 


ldrb r0,[r6] @get item data

mov r2, #0 @Counter 
ldr r3, =PreventTradingList 
PreventTradingLoopA:
ldrb r1, [r3, r2] 
cmp r1, #0x0 
beq ContinueA
add r2, #1 
cmp r0, r1 @
beq NoTrade
b PreventTradingLoopA
ContinueA:
ldrb r0,[r6]

mov r2, #0 @Counter 
ldr r3, =PreventTradingList 
PreventTradingLoopB:
ldrb r1, [r3, r2] 
cmp r1, #0x0 
beq ContinueB
add r2, #1 
cmp r0, r1 @
beq NoTrade
b PreventTradingLoopB
ContinueB: 

b End
NoTrade:
ldr r0, MuteCheck
ldrb r0,[r0]
lsl r0,r0,#0x1e
cmp r0,#0
blt MuteCheck
mov r0,#0x6c
ldr r1, PlaySound
mov lr,r1
.short 0xF800
pop {r5-r6} 
pop {r1} 
mov r0, #0 
ldr r1, =0x801E23D 
bx r1 
.ltorg 

End: 

ldrh r0, [r6] 
strh r0, [r5, #6] 
mov r0, #0
ldsb r0, [r4, r0] 
strh r0, [r5, #8] 
pop {r5-r6}  
pop {r1}
bx r1
.ltorg 

.align
PlaySound:
.long 0x080d01fc
MuteCheck:
.long 0x0202bc31

