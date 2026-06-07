#include "iwram.h"
#include "entity.h"
#include "types.h"

extern const u32 sLevelLayout_312148[];

void LevelLayout_312148_ProcessEntities(void)
{
    Entity_WalkCompactRecords(20, sLevelLayout_312148, 2, &gIwram_6110, 0);
}
