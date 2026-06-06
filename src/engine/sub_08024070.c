#include "iwram.h"
#include "types.h"

extern void Entity_WalkCompactRecords(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const u32 sLevelLayout_312148[];

void LevelLayout_312148_ProcessEntities(void)
{
    Entity_WalkCompactRecords(20, sLevelLayout_312148, 2, &gIwram_6110, 0);
}
