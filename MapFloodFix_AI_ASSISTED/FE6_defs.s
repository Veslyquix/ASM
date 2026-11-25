@ FE6 (JP) addresses, from the fireemblem6j decomp. Names match FE8's so the same C builds for both.

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

SET_FUNC MapFloodCoreStep, 0x08000784         @ ARM
SET_FUNC CallARM_FillMovementMap, 0x080038F1  @ MapFloodCoreRam

SET_DATA gMapFloodCoreRam, 0x03002758         @ MapFloodCoreRamFunc
SET_DATA gMovMapFillState, 0x030044C0         @ gMapFloodSt
SET_DATA gMovMapFillStPool1, 0x03004020       @ gMapFloodSquareBufB
SET_DATA gMovMapFillStPool2, 0x030042B0       @ gMapFloodSquareBufA
SET_DATA gBmMapSize, 0x0202D200               @ gMapSize
SET_DATA gWorkingBmMap, 0x03004010            @ gWorkingMap
