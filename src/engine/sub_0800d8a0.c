#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u32 ModeControl_GetFlag(void *base, u32 selector, u32 bit);
extern void EnemySpawn_Tick(void);
extern void EntityPool_UpdateOwner58(void);
extern void EnemyWave_Update(void);
extern void EnemyWave_TickGateTimer(void);
extern void EntityPool_UpdateOwner5B(void);
extern u32 *PadGrid_StepPackedCoord(u32 *out, s8 delta);
extern u32 GenRandomTileMask(void);
extern u32 FilterValidBits(u32 mask);

void SpawnControl_Dispatch(void)
{
    s8 i;

    if ((u8)ModeControl_GetFlag(&gIwram_6110, 3, 0)) {
        for (i = 0; i <= 4; i++) {
            gEntities[i + 3].status |= 8;
        }

        switch (gIwram_6110.spawnMask) {
        case 0:
            EntityPool_UpdateOwner58();
            break;
        case 1:
            EnemyWave_Update();
            break;
        case 2:
            EnemyWave_TickGateTimer();
            break;
        case 3:
            EntityPool_UpdateOwner5B();
            break;
        }
        return;
    }
    EnemySpawn_Tick();
}

/* Packed tile coordinate: x in the low halfword, y in the high one. Kept as a
 * struct so the (-3, -3) miss value is built with halfword field stores in a
 * register (and/or pairs) instead of a pooled constant. */
struct PackedCoord {
    s16 x;
    s16 y;
};

/* Scans `mask` for its (limit + 1)-th set bit among bits 0..24 and steps the
 * pad-grid coordinate by that bit index; (-3, -3) when there is no such bit.
 * The loop condition is a bitwise `&` of the two tests (no short-circuit),
 * which is what the baserom's flag-and-compare sequence encodes. */
u32 *PadGrid_ScanMaskToCoord(u32 *out, u32 mask, s8 limit)
{
    s8 found = -1;
    s8 i = 0;
    struct PackedCoord coord;
    struct PackedCoord result;

    while ((i <= 24) & (found < limit)) {
        if (mask & 1) {
            found++;
        }
        mask >>= 1;
        i++;
    }

    if (found == limit) {
        PadGrid_StepPackedCoord((u32 *)&coord, i - 1);
        result = coord;
    } else {
        result.x = -3;
        result.y = -3;
    }
    *(struct PackedCoord *)out = result;
    return out;
}

u32 PadGrid_RandomizeAndSyncEntityCoords(void)
{
    u32 mask = GenRandomTileMask();

    gEntities[30].x = gIwram_35E0._field_8;
    gEntities[30].y = gIwram_35E0._field_A;
    return FilterValidBits(mask);
}
