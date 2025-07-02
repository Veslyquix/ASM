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

SET_DATA classTablePoin, 0x8017AB8 
@SET_DATA DangerLinesBuffer, 0x2026E30 @ size: 0x2028	- normally used by debug printing, also used by Scraiza's shop expansion 
SET_DATA DangerLinesBuffer, 0x2026Ec0	// size: 0x1f98
