.thumb
.global Arm_DecompText
.type Arm_DecompText, %function 
Arm_DecompText:
push {lr} 
ldr r2, [r2] 
bl CallViaR2 
mov r0, r1 @ huffman decoding happens to have the text buffer offset in r1 afterwards 
ldr r1, =sMsgString
sub r0, r1 @ bytes used 
pop {r1} 
bx r1 
CallViaR2:
bx r2 
.ltorg 
