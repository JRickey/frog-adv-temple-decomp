#include "iwram.h"
#include "types.h"

extern void Entity_WalkCompactRecords(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);

extern const u32 sLevelLayout_312228[];

void LevelLayout_312228_ProcessEntities(void)
{
    Entity_WalkCompactRecords(0x74, sLevelLayout_312228, 4, &gIwram_6110, 0);
}
