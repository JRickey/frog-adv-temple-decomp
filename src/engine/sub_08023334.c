#include "iwram.h"
#include "level_layout.h"
#include "types.h"

extern const u32 sLevelLayout_311CE0[22];

void StreamInit_Slot43(void)
{
    LevelLayout_WalkRecords(0x43, sLevelLayout_311CE0, 0, 2, 0x151, 9, 0);
}
