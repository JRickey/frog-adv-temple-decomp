#include "iwram.h"
#include "types.h"

extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);
extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const u32 sLevelLayoutPtrs_310DD4[8];
extern const u32 sLevelLayout_310C2C[6];

void sub_0802277C(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_310DD4[i], i + 0x36);
        i++;
    } while (i <= 7);

    sub_08020FE4(0x36, 0x3d);
    sub_08005D10(0x36, 0x3d);
}

void sub_080227B4(void)
{
    sub_08021140(0x2f, sLevelLayout_310C2C, 0, 0xb, 0xd1, 7, 0);
}

void sub_080227DC(void)
{
    sub_08021510(0x2f, sLevelLayout_310C2C, 0xb, &gIwram_6110, 0);
}
