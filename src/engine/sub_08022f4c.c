#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern u32 __umodsi3(u32 dividend, u32 divisor);

extern const u32 sLevelLayoutPtrs_311EC0[10];

void sub_08022F4C(void)
{
    u8 i;
    const u32 *tbl; /* r8 holds table base across BL calls */

    i = 0;
    tbl = sLevelLayoutPtrs_311EC0;
    do {
        if (i <= 3) {
            register u32 idx asm("r5"); /* pin forces ptr->r4, counter->r6 */
            const void *ptr;
            u32 mod;
            u16 field14;
            idx = i + 0x51;
            ptr = (const void *)tbl[i];
            mod = __umodsi3(i, 6);
            /* two-shift form needed to match agbcc output */
            field14 = (((mod << 24) >> 4) + 0x01710000) >> 16;
            sub_080210A0(idx, ptr, 16, 13, field14, 11, 2, 3);
        } else {
            register u32 idx asm("r5");
            const void *ptr;
            u32 mod;
            u16 field14;
            idx = i + 0x51;
            ptr = (const void *)tbl[i];
            mod = __umodsi3(i, 6);
            field14 = (((mod << 24) >> 4) + 0x01710000) >> 16;
            sub_080210A0(idx, ptr, 16, 13, field14, 11, 3, 3);
        }
        i++;
    } while (i <= 9);
}
