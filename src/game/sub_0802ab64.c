#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const void *const sLevelLayoutPtrs_317E6C[2];

void sub_0802AB64(void)
{
    u8 i;

    for (i = 0; i < 2; i++) {
        sub_080210A0(i + 17, sLevelLayoutPtrs_317E6C[i], 0, 27, ((i & 1) << 4) | 0x161, 6, 3, 3);
    }
}
