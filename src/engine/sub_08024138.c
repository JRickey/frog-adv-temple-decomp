#include "iwram.h"
#include "types.h"

extern void Entity_InitSlotFromRecord(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void Entity_DmaLoadSprite(u8 idx);

extern const u32 sLevelLayoutPtrs_312DD4[38];

void LevelLayout_LoadEntities33(void)
{
    u8 i;

    i = 0;
    do {
        Entity_InitSlotFromRecord(i + 0x33, (const void *)sLevelLayoutPtrs_312DD4[i], 0x400, 0x1a, 0xf1, 5, 3, 3);
        i++;
    } while (i <= 0x25);

    Entity_DmaLoadSprite(0x33);
}
