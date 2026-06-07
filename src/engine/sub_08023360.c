#include "iwram.h"
#include "entity.h"
#include "types.h"

extern const u32 sLevelLayout_311CE0[22];

void EntityGroup_CheckPickups_Slot0x43(void)
{
    Entity_WalkCompactRecords(0x43, sLevelLayout_311CE0, 2, &gIwram_6110, 0);
}
