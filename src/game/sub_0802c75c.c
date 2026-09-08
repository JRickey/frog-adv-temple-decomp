#include "game.h"
#include "level_layout.h"
#include "iwram.h"
#include "types.h"

extern const u32 sLevelLayout_31807C[12];
extern const u32 sLevelLayout_3180AC[12];
extern const u32 sLevelLayout_3180DC[12];
extern const u32 sLevelLayout_31810C[12];

void EnemyLayout_Reset(void)
{
    u8 spawnMask;

    gIwram_6110.flagBank0 = -1LL;
    gIwram_6110.flagBank1 = -1LL;

    spawnMask = gIwram_6110.spawnMask;

    switch (spawnMask) {
    case 0:
        LevelLayout_WalkRecords(3, sLevelLayout_31807C, 16, 4, 0x85, 3, spawnMask);
        break;
    case 1:
        LevelLayout_WalkRecords(3, sLevelLayout_31810C, 16, 4, 0x85, 3, 0);
        break;
    case 2:
        LevelLayout_WalkRecords(3, sLevelLayout_3180DC, 16, 4, 0x85, 3, 0);
        break;
    case 3:
        LevelLayout_WalkRecords(3, sLevelLayout_3180AC, 16, 4, 0x85, spawnMask, 0);
        break;
    }
}
