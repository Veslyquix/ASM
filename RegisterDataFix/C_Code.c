#include "C_Code.h"
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