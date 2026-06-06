#include "types.h"

extern u8 GetHighestUnlockedWorld(void);
extern void Entity_WalkCompactRecords(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const void *sLevelLayoutPtrs_308698[];

void LoadWorldLevelLayout(void)
{
    u8 idx = GetHighestUnlockedWorld();
    const void *layout;

    if (idx == 16)
        idx = 15;

    layout = sLevelLayoutPtrs_308698[idx];
    Entity_WalkCompactRecords(4, layout, 0x33, (void *)0x03006110, 0);
}
