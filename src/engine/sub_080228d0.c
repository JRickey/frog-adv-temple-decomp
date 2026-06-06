#include "iwram.h"
#include "types.h"

extern void LevelLayout_WalkRecords(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const u32 sLevelLayout_310C44[12];

void SpawnEntitySlot47(void)
{
    LevelLayout_WalkRecords(0x47, sLevelLayout_310C44, 0x10, 0x10, 0x195, 0xb, 0);
}
