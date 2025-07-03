#include "c_code.h"

#define brk asm("mov r11, r11");
extern u8 DangerLinesBuffer[];
#define DangerLinesBufferSize 0x3000

extern int ShakeIt;
extern int Pal_4th;

int IsUnitInvalid(struct Unit * unit)
{
    if (!UNIT_IS_VALID(unit))
    {
        return true; // not a unit
    }
    if (gPlaySt.chapterVisionRange)
    {
        if (gBmMapFog[unit->yPos][unit->xPos] != 0)
        {
            return true; // in the fog
        }
    }

    if (unit->state & US_UNDER_A_ROOF)
    {
        return true; // under a roof
    }
    return false;
}

#define enemySize (50 + 7) >> 3
#define US_BIT_SHAKE (1 << 24)
#define US_BIT_PAL (1 << 27)

void RemoveEnemyShaking(void)
{
    struct Unit * unit;
    int unitState = 0;
    if (ShakeIt)
    {
        unitState |= US_BIT_SHAKE;
    }
    if (Pal_4th)
    {
        unitState |= US_BIT_PAL;
    }

    for (int i = 0x80; i < 0xC0; ++i)
    {
        unit = GetUnit(i);
        if (IsUnitInvalid(unit))
        {
            continue;
        }

        unit->state &= ~unitState;
    }
    RefreshUnitSprites();
}

// set break points on the buffers ?
// [0x201c8d0..0x201c8d0+0x3000]!!

void UpdateIconsOnEnemiesWhoCanAttackTile(void)
{
    int x = gBmSt.playerCursor.x;
    int y = gBmSt.playerCursor.y;
    SetLastCoords(x, y);             // vanilla
    SetWorkingBmMap(gBmMapMovement); // vanilla
    u8 savedUnitId = gBmMapUnit[y][x];
    gBmMapUnit[y][x] = 0;

    int unitState = 0;
    if (ShakeIt)
    {
        unitState |= US_BIT_SHAKE;
    }
    if (Pal_4th)
    {
        unitState |= US_BIT_PAL;
    }

    struct Unit * unit;
    RemoveEnemyShaking();

    int deploymentID;
    u8 * row = &DangerLinesBuffer[y * gBmMapSize.x * enemySize];

    for (int i = 0; i < enemySize; i++) // Loop over bytes
    {
        u8 byte = row[(x * enemySize) + i];
        for (int bit = 0; bit < 8; bit++)
        {
            if (!(byte & (1 << bit)))
            {
                continue;
            }
            deploymentID = 0x80 + ((i << 3) + bit); // i*8 + bit

            unit = GetUnit(deploymentID);
            if (IsUnitInvalid(unit))
            {
                continue; // not a unit
            }

            unit->state |= unitState;
        }
    }

    gBmMapUnit[y][x] = savedUnitId;
    RefreshUnitSprites();
}

void CopyAttackRangeIntoBuffer(int i, int xSize, int ySize)
{
    // register int dummy_r12 __asm__("r12");
    // int deploymentID = 0x80 + i;
    i &= 0x3F;
    int byteID = i >> 3; // Which byte of the buffer to write to
    i &= 7;
    i = 1 << i; // Deployment ID - Bit to set at that byte
    u8 * buf;
    // u8 * rangeMapY;

    for (int y = 0; y < ySize; y++)
    {
        // rangeMapY = gBmMapRange[y];
        buf = &DangerLinesBuffer[y * xSize * enemySize];
        for (int x = 0; x < xSize; x++)
        {
            if (!gBmMapRange[y][x])
            {
                continue;
            }

            buf[(x * enemySize) + byteID] |= i;
        }
    }
}

void GenerateDangerLineRange(void)
{
    brk;
    // register int dummy_r12 __asm__("r12");
    u8 savedUnitId;
    int xSize = gBmMapSize.x; //- 1;
    int ySize = gBmMapSize.y; //- 1;
    CpuFill16(0, DangerLinesBuffer, DangerLinesBufferSize);

    for (int i = 0x80; i < 0xC0; ++i) // Enemy only
    {
        struct Unit * unit = GetUnit(i);

        if (IsUnitInvalid(unit))
        {
            continue;
        }

        BmMapFill(gBmMapRange, 0);
        // Fill movement map for unit
        GenerateUnitMovementMap(unit);

        savedUnitId = gBmMapUnit[unit->yPos][unit->xPos];
        gBmMapUnit[unit->yPos][unit->xPos] = 0;

        SetWorkingBmMap(gBmMapRange);
        GenerateUnitCompleteAttackRange(unit);
        CopyAttackRangeIntoBuffer(i & 0x3F, xSize, ySize);

        gBmMapUnit[unit->yPos][unit->xPos] = savedUnitId;
    }
    BmMapFill(gBmMapRange, 0);
    BmMapFill(gBmMapMovement, 0);
    brk;
}
