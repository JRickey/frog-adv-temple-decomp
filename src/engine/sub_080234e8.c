#include "iwram.h"
#include "types.h"

extern void LevelLayout_WalkRecords(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern void Entity_WalkCompactRecords(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const u32 sLevelLayout_311488[4];

void EntityGroup_LoadLayout_Slot0x5F(void)
{
    LevelLayout_WalkRecords(0x5f, sLevelLayout_311488, 0, 0x4c, 0x231, 14, 0);
}

void EntityGroup_CheckPickups_Slot0x5F(void)
{
    Entity_WalkCompactRecords(0x5f, sLevelLayout_311488, 0x4c, &gIwram_6110, 0);
}
