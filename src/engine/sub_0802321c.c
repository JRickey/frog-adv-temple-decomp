#include "iwram.h"
#include "level_layout.h"
#include "types.h"

extern const u32 sLevelLayoutData_3114C0[];

void LevelLayout_InitSlot6(void)
{
    LevelLayout_WalkRecords(6, sLevelLayoutData_3114C0, 0, 0x12, 0x61, 3, 0);
}
