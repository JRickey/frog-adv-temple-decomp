#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void Entity_DmaLoadSprite(u8 idx);

extern const u32 sLevelLayoutPtrs_3113C8[8];

void LevelLayout_LoadSlots3113C8(void)
{
    sub_080210A0(0x4C, (const void *)sLevelLayoutPtrs_3113C8[0], 0x400, 19, 0x1A5, 7, 2, 3);
    sub_080210A0(0x4D, (const void *)sLevelLayoutPtrs_3113C8[1], 0x400, 19, 0x1A5, 7, 2, 3);
    sub_080210A0(0x4E, (const void *)sLevelLayoutPtrs_3113C8[2], 0x400, 19, 0x1A5, 7, 2, 3);
    sub_080210A0(0x4F, (const void *)sLevelLayoutPtrs_3113C8[3], 0x400, 19, 0x1A5, 7, 2, 3);
    sub_080210A0(0x50, (const void *)sLevelLayoutPtrs_3113C8[4], 0x400, 19, 0x1A5, 7, 2, 3);
    sub_080210A0(0x51, (const void *)sLevelLayoutPtrs_3113C8[5], 0x400, 19, 0x1A5, 7, 2, 3);
    sub_080210A0(0x52, (const void *)sLevelLayoutPtrs_3113C8[6], 0x400, 19, 0x1A5, 7, 2, 2);
    sub_080210A0(0x53, (const void *)sLevelLayoutPtrs_3113C8[7], 0x400, 19, 0x1A5, 7, 2, 2);
    Entity_DmaLoadSprite(0x4C);
}
