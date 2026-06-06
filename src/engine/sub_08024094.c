#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayoutPtrs_312DA8[11];

void LevelLayout_LoadEntities28(void)
{
    u8 i;

    i = 0;
    do {
        sub_080210A0(i + 0x28, (const void *)sLevelLayoutPtrs_312DA8[i], 0, 27, (u16)(((i & 3) << 4) + 0xb1), 4, 3, 3);
        i++;
    } while (i <= 10);
}
