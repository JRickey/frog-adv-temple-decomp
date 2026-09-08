#include "iwram.h"
#include "level_layout.h"
#include "entity.h"
#include "types.h"

extern void Entity_FollowPath(const void *a0, s32 slot);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);
extern const u32 sLevelLayout_311CB0[12];
extern const u32 sLevelLayoutPtrs_311EC0[10];

void StreamInit_Slot3E(void)
{
    LevelLayout_WalkRecords(0x3e, sLevelLayout_311CB0, 0, 4, 0x141, 8, 0);
}

void EntityGroup_CheckPickups_Slot0x3E(void)
{
    Entity_WalkCompactRecords(0x3e, sLevelLayout_311CB0, 4, &gIwram_6110, 0);
}

void EntityGroup_LoadAndUpdateMovers_311EC0(void)
{
    u8 i;

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_311EC0[i], i + 0x51);
        i++;
    } while (i <= 9);

    Entity_UpdateMovers(0x51, 0x53);
    Entity_AdvanceAnimFrames(0x51, 0x53);
    Entity_UpdateMovers(0x54, 0x54);
    Entity_AdvanceAnimFrames(0x54, 0x54);
    Entity_UpdateMovers(0x55, 0x56);
    Entity_AdvanceAnimFrames(0x55, 0x56);
    Entity_UpdateMovers(0x57, 0x58);
    Entity_AdvanceAnimFrames(0x57, 0x58);
    Entity_UpdateMovers(0x59, 0x5a);
    Entity_AdvanceAnimFrames(0x59, 0x5a);
}
