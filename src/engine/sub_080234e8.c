#include "iwram.h"
#include "level_layout.h"
#include "entity.h"
#include "types.h"

extern const u32 sLevelLayout_311488[4];

void EntityGroup_LoadLayout_Slot0x5F(void)
{
    LevelLayout_WalkRecords(0x5f, sLevelLayout_311488, 0, 0x4c, 0x231, 14, 0);
}

void EntityGroup_CheckPickups_Slot0x5F(void)
{
    Entity_WalkCompactRecords(0x5f, sLevelLayout_311488, 0x4c, &gIwram_6110, 0);
}
