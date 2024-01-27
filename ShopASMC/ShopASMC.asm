.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ MemorySlot,0x30004B8
.equ MakeShop,0x80b4240 @r0 = visiting unit, r1 = shop list(?), r2 = shop type, r3 = proc
.equ CurrentUnit, 0x3004E50
.global CallShopASMC
.type CallShopASMC, %function
CallShopASMC: 
push {r4, lr} 
ldr r4, =MemorySlot
mov r3, r0 @ event proc 
ldr r2, [r4, #4*1] @ slot 1 as shop type 
cmp r2, #2
bgt SetShopType 
cmp r2, #0 
blt SetShopType
b HaveShopType 
SetShopType: 
mov r2, #0 @ default type 
HaveShopType: 
ldr r0, =CurrentUnit
ldr r0, [r0] 
mov r1, #4*0xE 
add r1, r4 @ memory slot E is start of event queue slots 
blh MakeShop, r4 
bl EmptyMemorySlotQueue 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 


EmptyMemorySlotQueue:
push {lr} 
ldr r3, =0x30004f0 
ldr r2, =0x300050e 
mov r0, #0 
EmptyMemorySlotQueueLoop:
str r0, [r3] 
add r3, #4 
cmp r3, r2 
ble EmptyMemorySlotQueueLoop
ldr r3, =MemorySlot
str r0, [r3, #4*0x0D] 
EmptyMemorySlotQueueEnd:
pop {r0}
bx r0 
.ltorg 
