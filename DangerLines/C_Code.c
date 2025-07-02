#include "c_code.h"

#define brk asm("mov r11, r11");
extern u8 DangerLinesBuffer[];
#define DangerLinesBufferSize 0x3A00

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

int _log2(int n)
{
    int result = 0;
    while (n >>= 1)
        result++;
    return result;
}

#define enemySize (50 + 7) >> 3
#define US_BIT_SHAKE (1 << 24)

void RemoveEnemyShaking(void)
{
    struct Unit * unit;
    for (int i = 0x80; i < 0xC0; ++i)
    {
        unit = GetUnit(i);
        if (IsUnitInvalid(unit))
        {
            continue;
        }
        unit->state &= ~US_BIT_SHAKE;
    }
    RefreshUnitSprites();
}

void UpdateIconsOnEnemiesWhoCanAttackTile(void)
{
    int x = gBmSt.playerCursor.x;
    int y = gBmSt.playerCursor.y;
    SetLastCoords(x, y);               // vanilla
    SetWorkingBmMap(gBmMapMovement);   // vanilla
    u8 savedUnitId = gBmMapUnit[y][x]; // when hovering over friendly units, it doesn't update properly ?
    gBmMapUnit[y][x] = 0;              // also sometimes ram gets wiped or fails atm

    struct Unit * unit;
    RemoveEnemyShaking();

    int deploymentID;
    u8 * buf = &DangerLinesBuffer[y * (gBmMapSize.y - 1) * enemySize];
    for (int i = 0; i < enemySize; i++) // i is the current byte
    {
        for (int bit = 0; bit < 8; bit++)
        {

            deploymentID = buf[(x * enemySize) + i] & (1 << bit);
            if (!deploymentID)
            {
                continue;
            }

            unit = GetUnit(_log2(deploymentID) + 0x80 + (i << 3)); // deployment id per byte, so add (8 * i)
            // if ((_log2(deploymentID) + 0x80 + (i << 3)) == 0x97)
            // {
            // brk;
            // }
            if (IsUnitInvalid(unit))
            {
                continue; // not a unit
            }

            unit->state |= US_BIT_SHAKE;
        }
    }
    gBmMapUnit[y][x] = savedUnitId;
    RefreshUnitSprites();
}

void CopyAttackRangeIntoBuffer(int i, int xSize, int ySize)
{
    int deploymentID = 0x80 + i;
    i &= 0x3F;
    int byteID = i >> 3; // Which byte of the buffer to write to
    i &= 7;
    i = 1 << i; // Deployment ID - Bit to set at that byte
    u8 * buf;
    u8 * rangeMapY;

    for (int y = 0; y < ySize; y++)
    {
        rangeMapY = gBmMapRange[y];
        buf = &DangerLinesBuffer[y * ySize * enemySize];
        for (int x = 0; x < xSize; x++)
        {
            // if (x == 2 && y == 15 && deploymentID == 0x97)
            // {
            // brk;
            // }
            if (!rangeMapY[x])
            {
                buf[(x * enemySize) + byteID] &= ~i; // dunno why needed atm
                continue;
            }
            buf[(x * enemySize) + byteID] |= i;
        }
    }
}

void ClearDangerLineBuffer(void)
{
    CpuFill16(0, DangerLinesBuffer, DangerLinesBufferSize);
}

void GenerateDangerLineRange(void)
{
    brk;
    u8 savedUnitId;
    int xSize = gBmMapSize.x - 1;
    int ySize = gBmMapSize.y - 1;
    ClearDangerLineBuffer();
    // BmMapFill(gBmMapRange, 0);

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

        // Apply unit's range to range map
        // if (i == 0x97)
        // {
        // brk;
        // }
        GenerateUnitCompleteAttackRange(unit);
        CopyAttackRangeIntoBuffer(i & 0x3F, xSize, ySize);

        gBmMapUnit[unit->yPos][unit->xPos] = savedUnitId;
    }
    BmMapFill(gBmMapRange, 0);
    BmMapFill(gBmMapMovement, 0);
    brk;
}