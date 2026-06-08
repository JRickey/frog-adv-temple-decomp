#include "types.h"

extern u8 GetHighestUnlockedWorld(void);
extern void LevelLayout_WalkRecords(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
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
