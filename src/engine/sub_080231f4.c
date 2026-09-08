#include "iwram.h"
#include "level_layout.h"
#include "types.h"

extern const u8 sLevelLayout_311498[];

void StreamInit_Slot02_Alt(void)
{
    LevelLayout_WalkRecords(2, sLevelLayout_311498, 0x10, 0x11, 0x41, 1, 0);
}
