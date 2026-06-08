#include "iwram.h"
#include "entity.h"
#include "types.h"

extern void Entity_InitSlotFromRecord(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayout_312270[];
extern const u32 sLevelLayoutPtrs_312C98[5];

void InitEntitySlot65(void)
{
    Entity_WalkCompactRecords(0x65, sLevelLayout_312270, 0x0b, &gIwram_6110, 0);
}

void InitEntitySlots67_6B(void)
{
    Entity_InitSlotFromRecord(0x67, (const void *)sLevelLayoutPtrs_312C98[0], 16, 28, 0x1f1, 10, 3, 2);
    Entity_InitSlotFromRecord(0x6a, (const void *)sLevelLayoutPtrs_312C98[3], 16, 28, 0x251, 10, 3, 3);
    Entity_InitSlotFromRecord(0x6b, (const void *)sLevelLayoutPtrs_312C98[4], 16, 28, 0x271, 10, 3, 3);
}

extern const u32 sLevelLayoutPtrs_312D80[10];

void InitEntitySlots0A_13(void)
{
    u8 i;

    for (i = 0; i <= 9; i++) {
        Entity_InitSlotFromRecord(i + 10, (const void *)sLevelLayoutPtrs_312D80[i], 16, 30,
                                  (u16)(((i & 1) << 4) + 0x81), 2, 3, 3);
    }
}
