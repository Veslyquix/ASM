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

SET_FUNC __aeabi_idiv,    __divsi3
SET_FUNC Div, __divsi3
SET_FUNC Mod, __modsi3
SET_DATA gEfxHpLutOff, 0x203e152


SET_DATA classTablePoin, 0x8017AB8 
