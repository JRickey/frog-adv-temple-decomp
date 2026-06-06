#include "iwram.h"
#include "types.h"

extern const u32 sLevelLayout_310B64[8];
extern void Entity_WalkCompactRecords(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);

void SpawnZone_Slot02(void)
{
    Entity_WalkCompactRecords(2, sLevelLayout_310B64, 4, &gIwram_6110, 0);
}
