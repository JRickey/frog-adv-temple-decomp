#include "iwram.h"
#include "level_layout.h"
#include "types.h"

extern const u32 sLevelLayout_310B64[];

void SpawnEntitySlot2(void)
{
    LevelLayout_WalkRecords(2, sLevelLayout_310B64, 0, 4, 0x41, 1, 0);
}
