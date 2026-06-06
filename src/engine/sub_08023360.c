#include "iwram.h"
#include "types.h"

extern void Entity_WalkCompactRecords(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const u32 sLevelLayout_311CE0[22];

void EntityGroup_CheckPickups_Slot0x43(void)
{
    Entity_WalkCompactRecords(0x43, sLevelLayout_311CE0, 2, &gIwram_6110, 0);
}
