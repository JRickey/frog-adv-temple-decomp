#include "iwram.h"
#include "level_layout.h"
#include "types.h"

extern const u32 sLevelLayout_312248[];

void LoadEntitySlot61(void)
{
    LevelLayout_WalkRecords(0x61, sLevelLayout_312248, 0x10, 0x11, 0x1c1, 8, 0);
}
