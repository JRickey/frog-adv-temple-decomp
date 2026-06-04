#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);
extern const u32 sLevelLayout_311CB0[12];
extern const u32 sLevelLayoutPtrs_311EC0[10];

void sub_080233D4(void)
{
    sub_08021140(0x3e, sLevelLayout_311CB0, 0, 4, 0x141, 8, 0);
}

void sub_08023400(void)
{
    sub_08021510(0x3e, sLevelLayout_311CB0, 4, &gIwram_6110, 0);
}

void sub_08023424(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_311EC0[i], i + 0x51);
        i++;
    } while (i <= 9);

    sub_08020FE4(0x51, 0x53);
    sub_08005D10(0x51, 0x53);
    sub_08020FE4(0x54, 0x54);
    sub_08005D10(0x54, 0x54);
    sub_08020FE4(0x55, 0x56);
    sub_08005D10(0x55, 0x56);
    sub_08020FE4(0x57, 0x58);
    sub_08005D10(0x57, 0x58);
    sub_08020FE4(0x59, 0x5a);
    sub_08005D10(0x59, 0x5a);
}
