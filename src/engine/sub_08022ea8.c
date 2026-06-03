#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayoutPtrs_311C80[12];

extern struct Entity gEntities_03003720[];

void sub_08022EA8(void)
{
    u8 i;

    for (i = 0; i <= 11; i++) {
        if ((i & 1) == 0)
            sub_080210A0(i + 0x32, (const void *)sLevelLayoutPtrs_311C80[i], 16, 8, (u16)(((i & 7) << 4) + 0xc1), 7, 3,
                         3);
        else
            sub_080210A0(i + 0x32, (const void *)sLevelLayoutPtrs_311C80[i], 16, 7, (u16)(((i & 7) << 4) + 0xc1), 6, 3,
                         3);

        if (i <= 2)
            gEntities_03003720[i + 0x32].field_06 = 2;
    }
}
