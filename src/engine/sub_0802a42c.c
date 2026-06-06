#include "iwram.h"
#include "types.h"

extern s32 RandRange(s32 range);
extern void LevelLayout_WalkRecords(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern u32 GetFrameTick(void);

extern u32 gEntities_03003720[];

void SpawnGrid_SpawnWave1(void)
{
    u16 buf[7];

    buf[0] = 1;
    buf[1] = 0;
    buf[2] = 0;
    buf[4] = (RandRange(8) + 1) * 24 + 11;
    buf[5] = (RandRange(5) + 2) * 24 + 11;
    buf[6] = 0x303;
    LevelLayout_WalkRecords(0x10, buf, 0x10, 0x0c, 0x151, 5, 0);
    gEntities_03003720[0xEB] = GetFrameTick();
}
