#include "C_Code.h"

extern u8 TerrainThatCallsRangeEvent[];
extern u8 TrapsThatCallRangeEvent[];
extern u8 TerrainThatInterruptsMovement[];
extern u8 TrapsThatInterruptMovement[];

void RunRangeEventAt(struct Unit * unit, int x, int y);
int WalkCalcLoop(struct Unit * unit, int x, int y)
{

    int terrain = gBmMapTerrain[y][x];
    u8 * data;
    for (data = TerrainThatCallsRangeEvent; *data; ++data)
    {
        if (terrain == *data)
        {
            RunRangeEventAt(unit, x, y);
            break;
        }
    }

    int trap = GetTrapAt(x, y)->type;
    for (data = TrapsThatCallRangeEvent; *data; ++data)
    {
        if (trap == *data)
        {
            RunRangeEventAt(unit, x, y);
            break;
        }
    }

    if (gBmMapUnit[y][x])
    {
        return false; // unit there, so don't interrupt movement
    }
    for (data = TerrainThatInterruptsMovement; *data; ++data)
    {
        if (terrain == *data)
        {
            return true;
        }
    }
    for (data = TrapsThatInterruptMovement; *data; ++data)
    {
        if (trap == *data)
        {
            return true;
        }
    }
    return false;
}

void RunRangeEventAt(struct Unit * unit, int x, int y)
{
    int xCur = unit->xPos;
    int yCur = unit->yPos;
    int actX = gActionData.xMove;
    int actY = gActionData.yMove;
    gActionData.xMove = x;
    gActionData.yMove = y;
    unit->xPos = x;
    unit->yPos = y;
    // if (StartAfterUnitMovedEvent())
    if (CheckForWaitEvents())
    {
        // brk;
        RunWaitEvents();
    }

    unit->xPos = xCur;
    unit->yPos = yCur;
    gActionData.xMove = actX;
    gActionData.yMove = actY;
}
