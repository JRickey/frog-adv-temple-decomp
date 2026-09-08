#include "iwram.h"
#include "level_layout.h"
#include "types.h"

extern const u32 sLevelLayout_311D38[8];

void StreamInit_Slot4E(void)
{
    LevelLayout_WalkRecords(0x4e, sLevelLayout_311D38, 0, 11, 0x161, 10, 0);
}
