#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayoutPtrs_311074[14];

void LevelLayout_LoadSlots311074(void)
{
    u8 i;

    for (i = 0; i < 14; i++) {
        if ((i & 1) == 0)
            sub_080210A0(i + 25, (const void *)sLevelLayoutPtrs_311074[i], 0, 5, 0x61, 4, 3, 3);
        else
            sub_080210A0(i + 25, (const void *)sLevelLayoutPtrs_311074[i], 0, 6, 0x71, 4, 3, 3);
    }
}
