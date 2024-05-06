.thumb
.global Arm_DecompText
.type Arm_DecompText, %function 
Arm_DecompText:
push {lr} 
ldr r2, [r2] 
bl CallViaR2 
pop {r0} 
bx r0 
CallViaR2:
bx r2 
.ltorg 
