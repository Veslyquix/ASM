#include "c_code.h"

#define brk asm("mov r11, r11");
extern u8 * DangerLinesBuffer;
#define DangerLinesBufferSize 0x1f98

int IsUnitInvalid(struct Unit * unit)
{
    if (UNIT_IS_VALID(unit))
    {
        return true; // not a unit
    }
    if (gPlaySt.chapterVisionRange)
    {
        if (gBmMapFog[unit->yPos][unit->xPos] == 0)
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
void UpdateIconsOnEnemiesWhoCanAttackTile(void)
{
    int x = gBmSt.playerCursor.x;
    int y = gBmSt.playerCursor.y;
    SetLastCoords(x, y);             // vanilla
    SetWorkingBmMap(gBmMapMovement); // vanilla
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

    int deploymentID;

    u8 * buf = &DangerLinesBuffer[y * (gBmMapSize.y - 1) * enemySize];
    for (int i = 0; i < enemySize; i++)
    {
        for (int bit = 0; bit < 8; bit++)
        {
            deploymentID = buf[(x * enemySize) + i] & (1 << bit);
            if (!deploymentID)
            {
                continue;
            }
            unit = GetUnit(deploymentID + 0x80);
            if (IsUnitInvalid(unit))
            {
                continue; // not a unit
            }

            unit->state |= US_BIT_SHAKE;
        }
    }
    // refresh sms?
}

void CopyAttackRangeIntoBuffer(int i, int xSize, int ySize)
{
    i &= 0x3F;
    int byteID = i >> 3; // Which byte of the buffer to write to
    i &= 7;
    i = 1 << i; // Deployment ID - Bit to set at that byte
    u8 * buf;
    u8 * rangeMapY;

    for (int y = 0; y < ySize; y++)
    {
        rangeMapY = gWorkingBmMap[y];
        buf = &DangerLinesBuffer[y * ySize * enemySize];
        for (int x = 0; x < xSize; x++)
        {
            if (!rangeMapY[x])
            {
                continue;
            }
            buf[(x * enemySize) + byteID] |= i;
        }
    }
}

void ClearDangerLineBuffer(void)
{
    CpuFill16(0, DangerLinesBuffer, DangerLinesBufferSize);

    return;
    int xSize = gBmMapSize.x - 1;
    int ySize = gBmMapSize.y - 1;
    u8 * buf;
    for (int y = 0; y < ySize; ++y)
    {
        buf = &DangerLinesBuffer[y * ySize * enemySize];
        for (int x = 0; x < xSize; x++)
        {
            for (int byteID = 0; byteID < enemySize; ++byteID)
            {
                buf[(x * enemySize) + byteID] = 0;
            }
        }
    }
}

void GenerateDangerLineRange(void)
{
    brk;
    u8 savedUnitId;
    int xSize = gBmMapSize.x - 1;
    int ySize = gBmMapSize.y - 1;
    ClearDangerLineBuffer();
    BmMapFill(gBmMapRange, 0);

    for (int i = 0x80; i < 0xC0; ++i) // Enemy only
    {
        struct Unit * unit = GetUnit(i);

        if (IsUnitInvalid(unit))
        {
            continue;
        }

        // Fill movement map for unit
        GenerateUnitMovementMap(unit);

        savedUnitId = gBmMapUnit[unit->yPos][unit->xPos];
        gBmMapUnit[unit->yPos][unit->xPos] = 0;

        SetWorkingBmMap(gBmMapRange);

        // Apply unit's range to range map
        BmMapFill(gBmMapRange, 0);
        GenerateUnitCompleteAttackRange(unit);
        CopyAttackRangeIntoBuffer(i & 0x3F, xSize, ySize);

        gBmMapUnit[unit->yPos][unit->xPos] = savedUnitId;
    }
    BmMapFill(gBmMapRange, 0);
    BmMapFill(gBmMapMovement, 0);
    brk;
}