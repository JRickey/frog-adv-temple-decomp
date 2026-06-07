#include "iwram.h"
#include "game.h"
#include "types.h"

extern void LevelLayout_WalkRecords(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern u32 GetFrameTick(void);

extern u32 gEntities_03003720[];

void SpawnGrid_SpawnWave2(void)
{
    u16 buf[12];

    buf[0] = 2;
    buf[1] = 0;
    buf[2] = 0;
    buf[4] = (RandRange(4) + 1) * 24 + 11;
    buf[5] = (RandRange(5) + 2) * 24 + 11;
    buf[6] = 0x303;
    buf[8] = (RandRange(4) + 5) * 24 + 11;
    buf[9] = (RandRange(5) + 2) * 24 + 11;
    buf[10] = 0x303;
    LevelLayout_WalkRecords(14, buf, 0x10, 3, 0x141, 4, 0);
    gEntities_03003720[0xCF] = GetFrameTick();
}
