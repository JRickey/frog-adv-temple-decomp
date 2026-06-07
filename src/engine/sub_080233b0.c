#include "iwram.h"
#include "entity.h"
#include "types.h"

extern const u32 sLevelLayout_311D38[8];

void EntityGroup_CheckPickups_Slot0x4E(void)
{
    Entity_WalkCompactRecords(0x4e, sLevelLayout_311D38, 0xb, &gIwram_6110, 0);
}
