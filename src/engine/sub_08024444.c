#include "entity.h"
#include "level_layout.h"
#include "iwram.h"
#include "types.h"

extern const u32 sLevelLayout_312138[];

void LoadEntitySlot77(void)
{
    LevelLayout_WalkRecords(0x77, sLevelLayout_312138, 0, 0x4c, 0x351, 14, 0);
}

void sub_08024470(void)
{
    Entity_WalkCompactRecords(0x77, sLevelLayout_312138, 0x4c, &gIwram_6110, 0);
}
