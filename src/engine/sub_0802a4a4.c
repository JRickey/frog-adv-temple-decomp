#include "game.h"
#include "entity.h"
#include "iwram.h"
#include "types.h"

extern void SpawnGrid_SpawnWave1(void);
extern u32 GetFrameTick(void);

void EntityGroup16_Tick(void)
{
    u32 *gs;
    u8 *base3720;
    u32 buf[2];
    u32 tick;
    u32 i;

    gs = &gGameStuff._unk00;
    base3720 = (u8 *)gEntities;

    if (*gs - *(u32 *)(base3720 + 0xb48) > 0x5dc) {
        SpawnGrid_SpawnWave1();
        *(u32 *)(base3720 + 0xb48) = *gs;
    }

    buf[0] = (buf[0] & 0xffff0000u) | 1u;

    tick = GetFrameTick();
    if (tick - *(u32 *)(base3720 + 0xeb * 4) <= 0xef) {
        Entity_WalkCompactRecords(16, buf, 12, &gIwram_6110, 0);
    } else {
        i = 0;
        do {
            gEntities[i + 16].status |= 8;
            i = (u8)(i + 1);
        } while (i == 0);
    }
}
