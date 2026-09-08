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

u32 *PadGrid_ScanMaskToCoord(u32 *out, u32 mask, u32 limit)
{
    u32 *outp = out;
    u32 bits = mask;
    register u32 found asm("sl");
    register u8 ulimit asm("r8");
    u32 scratch;
    s32 slimit;
    s32 sf;
    s32 i;
    u32 loopValue;
    register u32 inRange asm("r3");
    register u32 belowLimit asm("r2");
    u32 limitShifted;
    u32 local;
    u32 result;

    limitShifted = limit << 24;
    found = 0xff;
    loopValue = 0;
    ulimit = limitShifted >> 24;
    slimit = (s32)limitShifted >> 24;
    goto test;

body:
    if ((bits & 1) != 0) {
        loopValue = sf + 1;
        loopValue <<= 24;
        loopValue >>= 24;
        found = loopValue;
    }
    bits >>= 1;
    loopValue = (u8)(i + 1);

test:
    inRange = 0;
    loopValue <<= 24;
    i = (s32)loopValue >> 24;
    if (i <= 24) {
        inRange = 1;
    }

    belowLimit = 0;
    scratch = found;
    loopValue = scratch << 24;
    sf = (s32)loopValue >> 24;
    scratch = ulimit;
    loopValue = scratch << 24;
    if (sf < slimit) {
        belowLimit = 1;
    }

    inRange &= belowLimit;
    if (inRange != 0) {
        goto body;
    }

    if (sf == (s32)loopValue >> 24) {
        PadGrid_StepPackedCoord(&local, (s8)(i - 1));
        result = local;
    } else {
        result &= 0xffff0000;
        result |= (u16)-3;
        result &= (u16)-1;
        result |= (u32)((u16)-3) << 16;
    }

    *outp = result;
    return outp;
}

u32 PadGrid_RandomizeAndSyncEntityCoords(void)
{
    u32 mask = GenRandomTileMask();

    gEntities[30].x = gIwram_35E0._field_8;
    gEntities[30].y = gIwram_35E0._field_A;
    return FilterValidBits(mask);
}
