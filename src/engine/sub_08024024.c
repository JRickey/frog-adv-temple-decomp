#include "iwram.h"
#include "entity.h"
#include "types.h"

extern const u32 sLevelLayout_312228[];

void LevelLayout_312228_ProcessEntities(void)
{
    Entity_WalkCompactRecords(0x74, sLevelLayout_312228, 4, &gIwram_6110, 0);
}
