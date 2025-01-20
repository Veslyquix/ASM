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

SET_DATA sUiFrameImage, 0x085B6470
SET_DATA Img_ShopGoldBox, 0x089ad9f8
SET_DATA gBanimFactionPal, 0x203e114
SET_DATA gBanimFont, 0x02017648
SET_DATA gBanimText, 0x02017660
SET_DATA gBanimValid, 0x203e104
SET_DATA Img_08801C14, 0x8801C14
SET_DATA gUnknown_08802598, 0x8802598
SET_FUNC ApplyUnitSpritePalettes, 0x8026629 


@ division & other libgcc functions
SET_FUNC __aeabi_idiv,    __divsi3
SET_FUNC __aeabi_idivmod, __modsi3
SET_FUNC Div, __divsi3
SET_FUNC Mod, __modsi3

