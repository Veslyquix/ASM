#include "c_code.h"

#define brk asm("mov r11, r11");
#define DangerBonesBufferSize 0x2878
#define enemySize (50 + 7) >> 3
#define MaxTiles DangerBonesBufferSize / enemySize
// x*y = 1480 or smaller eg. up to around a 38x38 map

extern u8 DangerBonesBuffer[DangerBonesBufferSize];

#define US_BIT_SHAKE (1 << 24)
#define US_BIT_PAL (1 << 27)

// #define EMPTY_BmUnit

// break point on buffer
// [0x201c8d0..0x201c8d0+0x3000]!!

extern int ShakeIt;
extern int Pal_4th;
extern int DangerBonesDisabledFlag;

int ShouldDangerBonesNotRun(void)
{
    if (gPlaySt.faction)
    {
        return true;
    }
    if (CheckFlag(DangerBonesDisabledFlag))
    {
        return true;
    }
    return false;
}

int IsUnitInvalid(struct Unit * unit)
{
    if (!UNIT_IS_VALID(unit))
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

void RemoveEnemyShaking(void)
{
    if (ShouldDangerBonesNotRun())
    {
        return;
    }
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

void UpdateVisualsForEnemiesWhoCanAttackTile(void)
{
    int x = gBmSt.playerCursor.x;
    int y = gBmSt.playerCursor.y;
    SetLastCoords(x, y);             // vanilla
    SetWorkingBmMap(gBmMapMovement); // vanilla
    if (ShouldDangerBonesNotRun())
    {
        return;
    }
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

    int mightExceedBuffer = gBmMapSize.x * gBmMapSize.y > MaxTiles;

    int deploymentID;
    u8 * row = &DangerBonesBuffer[y * gBmMapSize.x * enemySize];

    for (int i = 0; i < enemySize; i++) // Loop over bytes
    {
        if (mightExceedBuffer)
        {
            if (((y * gBmMapSize.x * enemySize) + (x * enemySize) + i) > DangerBonesBufferSize)
            {
                continue;
            }
        }
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
    int mightExceedBuffer = xSize * ySize > MaxTiles;
    i &= 0x3F;
    int byteID = i >> 3; // Which byte of the buffer to write to
    i &= 7;
    i = 1 << i; // Deployment ID - Bit to set at that byte
    u8 * buf;
    u8 * rangeMapY;

    for (int y = 0; y < ySize; y++)
    {
        rangeMapY = gBmMapRange[y];
        buf = &DangerBonesBuffer[y * xSize * enemySize];
        for (int x = 0; x < xSize; x++)
        {
            if (!rangeMapY[x])
            {
                continue;
            }
            if (mightExceedBuffer)
            {
                if (((y * xSize * enemySize) + (x * enemySize) + byteID) > DangerBonesBufferSize)
                {
                    continue;
                }
            }
            buf[(x * enemySize) + byteID] |= i;
        }
    }
}

typedef struct
{
    /* 00 */ PROC_HEADER;
    /* 2c */ u8 id;
} DangerBonesProc;

extern void RefreshUnitsOnBmMap(void);
void GenerateDangerBones(DangerBonesProc * proc) // do 1 valid unit per frame to spread out the lag
{
    u8 savedUnitId;

    int xSize = gBmMapSize.x;
    int ySize = gBmMapSize.y;

    int counter = 0;
    if (proc->id >= 0xC0)
    {
        return;
    }

    for (int i = proc->id; i < 0xC0; ++i) // Enemy only
    {
        if (counter)
        {
            break;
        }
        struct Unit * unit = GetUnit(i);
        if (proc->id == 0xBF)
        {
            BmMapFill(gBmMapRange, 0);
            BmMapFill(gBmMapMovement, 0);
            RefreshUnitSprites();
        }
        proc->id = i + 1;

        if (IsUnitInvalid(unit))
        {
            continue;
        }
#ifdef EMPTY_BmUnit
        BmMapFill(gBmMapUnit, 0);
#endif
        counter++;

        BmMapFill(gBmMapRange, 0);
        GenerateUnitMovementMap(unit);

        savedUnitId = gBmMapUnit[unit->yPos][unit->xPos];
        gBmMapUnit[unit->yPos][unit->xPos] = 0;

        SetWorkingBmMap(gBmMapRange);
        GenerateUnitCompleteAttackRange(unit);
        CopyAttackRangeIntoBuffer(i & 0x3F, xSize, ySize);

        gBmMapUnit[unit->yPos][unit->xPos] = savedUnitId;
    }
#ifdef EMPTY_BmUnit
    RefreshUnitsOnBmMap();
#endif
}

const struct ProcCmd DangerBonesProcCmd[] = {
    PROC_YIELD,
    PROC_LABEL(0),
    PROC_REPEAT(GenerateDangerBones),
    PROC_END,
};

void GenerateDangerBonesRangeAll(int i) // Causes noticable lag if done for 0x80 - 0xBF at once
{
    // brk;
    u8 savedUnitId;
    int xSize = gBmMapSize.x;
    int ySize = gBmMapSize.y;
#ifdef EMPTY_BmUnit
    BmMapFill(gBmMapUnit, 0);
#endif

    for (; i < 0xC0; ++i) // Enemy only
    {
        struct Unit * unit = GetUnit(i);

        if (IsUnitInvalid(unit))
        {
            continue;
        }

        BmMapFill(gBmMapRange, 0);
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
#ifdef EMPTY_BmUnit
    RefreshUnitsOnBmMap();
#endif
    // brk;
}

void StartDangerBonesRange(void)
{
    if (ShouldDangerBonesNotRun())
    {
        return;
    }
    CpuFill16(0, DangerBonesBuffer, DangerBonesBufferSize);
#ifdef EMPTY_BmUnit
    BmMapFill(gBmMapUnit, 0);
#endif

    DangerBonesProc * proc = Proc_Find((ProcPtr)&DangerBonesProcCmd);
    if (proc)
    {
        proc->id = 0x80;
    }
    else
    {
        proc = Proc_Start((ProcPtr)&DangerBonesProcCmd, PROC_TREE_3);
        proc->id = 0x80;
    }
    // GenerateDangerBonesRange();
}

void FinishDangerBonesRange(void) // if proc didn't finish yet, calc the rest now
{
    if (ShouldDangerBonesNotRun())
    {
        return;
    }
    DangerBonesProc * proc = Proc_Find((ProcPtr)&DangerBonesProcCmd);
    int id = 0x80;
    if (proc)
    {
        id = proc->id;
        proc->id = 0xC0; // stop proc from continuing
    }
    else
    {
        CpuFill16(0, DangerBonesBuffer, DangerBonesBufferSize);
    }
    GenerateDangerBonesRangeAll(id);
}
