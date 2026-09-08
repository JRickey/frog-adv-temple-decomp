#include "types.h"
#include "level_layout.h"

extern u8 GetHighestUnlockedWorld(void);
extern const void *sLevelLayoutPtrs_308698[];

void LoadWorldLevelLayoutAlt(void)
{
    u8 idx = GetHighestUnlockedWorld();
    const void *layout;

    if (idx == 16)
        idx = 15;

    layout = sLevelLayoutPtrs_308698[idx];
    LevelLayout_WalkRecords(4, layout, 0, 0x33, 100, 3, 0);
}

void Level_PreLoadHook(void)
{}
