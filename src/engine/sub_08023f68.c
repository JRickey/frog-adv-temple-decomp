#include "iwram.h"
#include "types.h"

extern void Entity_InitSlotFromRecord(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayoutPtrs_312D60[8];

void LevelLayout_312D60_SpawnEntities(void)
{
    u8 i;

    for (i = 0; i <= 7; i++) {
        Entity_InitSlotFromRecord(i + 2, (const void *)sLevelLayoutPtrs_312D60[i], 16, 7, (u16)(((i & 3) << 4) + 0x41),
                                  1, 3, 3);
    }
}
