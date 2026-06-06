#include "iwram.h"
#include "types.h"

extern void LevelLayout_WalkRecords(u32 a0, const void *a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);

extern const u32 sLevelLayout_312248[];

void LoadEntitySlot61(void)
{
    LevelLayout_WalkRecords(0x61, sLevelLayout_312248, 0x10, 0x11, 0x1c1, 8, 0);
}
