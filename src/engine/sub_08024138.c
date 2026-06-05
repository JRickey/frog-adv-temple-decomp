#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void sub_080063EC(u8 idx);

extern const u32 sLevelLayoutPtrs_312DD4[38];

void sub_08024138(void)
{
    u8 i;

    i = 0;
    do {
        sub_080210A0(i + 0x33, (const void *)sLevelLayoutPtrs_312DD4[i], 0x400, 0x1a, 0xf1, 5, 3, 3);
        i++;
    } while (i <= 0x25);

    sub_080063EC(0x33);
}
