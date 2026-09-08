#include "iwram.h"
#include "level_layout.h"
#include "types.h"

extern const u32 sLevelLayout_310C44[12];

void SpawnEntitySlot47(void)
{
    LevelLayout_WalkRecords(0x47, sLevelLayout_310C44, 0x10, 0x10, 0x195, 0xb, 0);
}
