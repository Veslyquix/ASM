.include "fe8.s" 

.macro SET_FUNC name, value
	.global \name
	.type   \name, function
	.set    \name, \value
.endm

.macro SET_DATA name, value
	.global \name
	.type   \name, object
	.set    \name, \value
.endm

@ division & other libgcc functions
SET_FUNC __aeabi_idiv,    __divsi3
SET_FUNC __aeabi_idivmod, __modsi3
SET_DATA sUnknown_08A30800, 0x80CCC1c @ or 0x80B3A48
SET_DATA sUnknown_08A30978, 0x80CCC28 @ or 0x80B3A50
SET_DATA classTablePoin, 0x8017AB8 
SET_DATA sPortrait_data, 0x8005524
SET_DATA FaceDataRam, 0x2000C60 
SET_DATA FacePalRam, 0x203c624 @ gSioOutgoing 


