#include "iwram.h"
#include "entity.h"
#include "types.h"

extern const u32 sLevelLayout_310B84[42];

void SpawnZone_Slot05(void)
{
    Entity_WalkCompactRecords(5, sLevelLayout_310B84, 2, &gIwram_6110, 0);
}
