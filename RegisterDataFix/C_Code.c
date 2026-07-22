#include "C_Code.h"

// Event2C_LoadUnits
// EventLoadUnitSliently has a for loop @ 2024cd4
// sub_800F8A8 -> if no REDAs, MoveUnit_ -> MoveUnitExt -> RefreshUnitSprites
// each time a unit is loaded while faded to black, it refreshes the unit sprites, which takes up a transfer
void RegisterDataMove(const void * src, void * dst, int size)
{
    struct TileDataTransfer * ptr = &gFrameTmRegister[gFrameTmRegisterConfig.count];

    ptr->src = src;
    ptr->dest = dst;
    ptr->size = size;
    ptr->mode = (size & 0x1F) ? 0 : 1;
    gFrameTmRegisterConfig.size += size;
    gFrameTmRegisterConfig.count++;
    if (gFrameTmRegisterConfig.count > 31)
    {
        FlushTiles();
    }
}

void RegisterFillTile(const void * src, void * dst, int size)
{
    struct TileDataTransfer * ptr = &gFrameTmRegister[gFrameTmRegisterConfig.count];

    ptr->src = src;
    ptr->dest = dst;
    ptr->size = size;
    ptr->mode = 2;
    gFrameTmRegisterConfig.size += size;
    gFrameTmRegisterConfig.count++;
    if (gFrameTmRegisterConfig.count > 31)
    {
        FlushTiles();
    }
}