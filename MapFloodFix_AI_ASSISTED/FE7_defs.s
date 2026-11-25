@ FE7 (US) addresses. Names match FE8's so the same C builds for both.

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

SET_FUNC MapFloodCoreStep, 0x08000760         @ ARM
SET_FUNC CallARM_FillMovementMap, 0x08004409  @ calls the IWRAM copy of MapFloodCore

SET_DATA gMapFloodCoreRam, 0x03002918
SET_DATA gMovMapFillState, 0x030046A0
SET_DATA gMovMapFillStPool1, 0x030041F0
SET_DATA gMovMapFillStPool2, 0x03004490
SET_DATA gBmMapSize, 0x0202E3D8
SET_DATA gWorkingBmMap, 0x030041E0
