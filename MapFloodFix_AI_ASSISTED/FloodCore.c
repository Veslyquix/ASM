#include "C_Code.h"

// Vanilla's flood never checks if the pools are full, so costly terrain can overflow them and crash.
// Built as ARM and installed over vanilla MapFloodCore, so it gets copied to IWRAM with the step.
// Returns whether anything was dropped / whether it overflowed 

#define FLOOD_POOL_SIZE 0x80

#define FLOOD_POOL_QUEUE_LIMIT (FLOOD_POOL_SIZE - 1 - 4 - 4)

#define FLOOD_LEFT 0
#define FLOOD_RIGHT 1
#define FLOOD_DOWN 2
#define FLOOD_UP 3
#define FLOOD_END 4

int MapFloodCoreSafe(void)
{
    struct MovMapFillState * st = &gMovMapFillState;
    struct MovMapFillStateExt * pool;
    struct MovMapFillStateExt * mark;
    int connection;
    int usePool1 = FALSE;
    int dropped = FALSE;

    for (;;)
    {
        usePool1 = !usePool1;

        if (usePool1)
        {
            st->src = gMovMapFillStPool1;
            pool = gMovMapFillStPool2;
        }
        else
        {
            st->src = gMovMapFillStPool2;
            pool = gMovMapFillStPool1;
        }

        st->dst = pool;

        if (st->src->connexion == FLOOD_END)
            return dropped;

        do
        {
            mark = st->dst;

            // step every way except back where this tile came from
            connection = st->src->connexion;

            if (connection != FLOOD_DOWN)
                MapFloodCoreStep(FLOOD_UP, 0, -1);

            if (connection != FLOOD_UP)
                MapFloodCoreStep(FLOOD_DOWN, 0, 1);

            if (connection != FLOOD_RIGHT)
                MapFloodCoreStep(FLOOD_LEFT, -1, 0);

            if (connection != FLOOD_LEFT)
                MapFloodCoreStep(FLOOD_RIGHT, 1, 0);

            if (mark >= pool + FLOOD_POOL_QUEUE_LIMIT)
            {
                // pool's nearly full, so drop these and fix it up afterwards
                st->dst = mark;
                dropped = TRUE;
            }

            st->dst->connexion = FLOOD_END;
            st->src++;
        } while (st->src->connexion != FLOOD_END);
    }
}
