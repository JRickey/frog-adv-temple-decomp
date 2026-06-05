#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayoutPtrs_312D60[8];

void sub_08023F68(void)
{
    u8 i;

    for (i = 0; i <= 7; i++) {
        sub_080210A0(i + 2, (const void *)sLevelLayoutPtrs_312D60[i], 16, 7, (u16)(((i & 3) << 4) + 0x41), 1, 3, 3);
    }
}
