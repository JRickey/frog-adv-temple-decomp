#include "iwram.h"
#include "types.h"

extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);
extern const u32 sLevelLayoutPtrs_3116B8[14];

void sub_08023244(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_3116B8[i], i + 12);
        i++;
    } while (i <= 13);

    sub_08020FE4(12, 14);
    sub_08005D10(12, 14);
    sub_08020FE4(15, 17);
    sub_08005D10(15, 17);
    sub_08020FE4(18, 18);
    sub_08005D10(18, 18);
    sub_08020FE4(19, 22);
    sub_08005D10(19, 22);
    sub_08020FE4(23, 24);
    sub_08005D10(23, 24);
    sub_08020FE4(25, 25);
    sub_08005D10(25, 25);
}
