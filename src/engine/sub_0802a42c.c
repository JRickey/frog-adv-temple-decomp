#include "iwram.h"
#include "level_layout.h"
#include "game.h"
#include "types.h"

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
