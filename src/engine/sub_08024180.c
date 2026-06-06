#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayoutPtrs_312E6C[6];

void LevelLayout_LoadEntities59(void)
{
    u8 i;

    i = 0;
    do {
        sub_080210A0(i + 0x59, (const void *)sLevelLayoutPtrs_312E6C[i], 16, 13, ((i & 3) << 4) | 0x101, 6, 3, 3);
        i++;
    } while (i <= 5);
}
