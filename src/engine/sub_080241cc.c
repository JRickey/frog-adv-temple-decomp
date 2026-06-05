#include "iwram.h"
#include "types.h"

extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_312E6C[6];

void sub_080241CC(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_312E6C[i], i + 0x59);
        i++;
    } while (i <= 5);

    sub_08020FE4(0x59, 0x5a);
    sub_08005D10(0x59, 0x5a);
    sub_08020FE4(0x5b, 0x5b);
    sub_08005D10(0x5b, 0x5b);
    sub_08020FE4(0x5c, 0x5d);
    sub_08005D10(0x5c, 0x5d);
    sub_08020FE4(0x5e, 0x5e);
    sub_08005D10(0x5e, 0x5e);
}
