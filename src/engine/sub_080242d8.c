#include "iwram.h"
#include "level_layout.h"
#include "types.h"

extern const u32 sLevelLayout_312270[];

void LoadEntitySlot65(void)
{
    LevelLayout_WalkRecords(0x65, sLevelLayout_312270, 16, 11, 0x1e1, 9, 0);
}
