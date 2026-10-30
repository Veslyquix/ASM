#include "C_Code.h"

// Runs MapFloodCoreSafe. If it overflows, then run safely here instead. It's slower this way, but only when it would've crashed. A few frames lost is better than inf frames from a crash lol 

#define FLOOD_RESEED_COUNT 0x10

#define FLOOD_END 4
#define FLOOD_START 5

void CallARM_FillMovementMap(void)
{
    struct MovMapFillStateExt * seed;
    u8 * row;
    int ix, iy, dropped;

    if (!gMapFloodCoreRam())
        return;

    do
    {
        dropped = FALSE;
        seed = gMovMapFillStPool1;

        for (iy = 0; iy < gBmMapSize.y; ++iy)
        {
            row = gWorkingBmMap[iy];

            for (ix = 0; ix < gBmMapSize.x; ++ix)
            {
                if (row[ix] == 0xFF)
                    continue;

                seed->xPos = ix;
                seed->yPos = iy;
                seed->connexion = FLOOD_START;

                if (++seed == gMovMapFillStPool1 + FLOOD_RESEED_COUNT)
                {
                    seed->connexion = FLOOD_END;
                    dropped |= gMapFloodCoreRam();
                    seed = gMovMapFillStPool1;
                }
            }
        }

        seed->connexion = FLOOD_END;
        dropped |= gMapFloodCoreRam();
    } while (dropped);
}
