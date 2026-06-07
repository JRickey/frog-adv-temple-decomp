#include "iwram.h"
#include "entity.h"
#include "types.h"

extern const u32 sLevelLayout_310B64[8];

void SpawnZone_Slot02(void)
{
    Entity_WalkCompactRecords(2, sLevelLayout_310B64, 4, &gIwram_6110, 0);
}
