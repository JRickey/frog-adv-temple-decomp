#include "iwram.h"
#include "types.h"

extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const u32 sLevelLayout_310C44[12];

void sub_080228FC(void)
{
    sub_08021510(0x47, sLevelLayout_310C44, 16, &gIwram_6110, 0);
}

extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);
extern const u32 sLevelLayoutPtrs_3113C8[8];

void sub_08022920(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_3113C8[i], i + 0x4c);
        i++;
    } while (i <= 7);

    sub_08020FE4(0x4c, 0x53);
    sub_08005D10(0x4c, 0x53);
}

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const u32 sLevelLayout_311418[10];
extern const u32 sLevelLayout_311440[4];

void sub_08022958(void)
{
    sub_08021140(2, sLevelLayout_311418, 0x10, 2, 0x51, 2, 0x14);
}

void sub_08022980(void)
{
    sub_08021510(2, sLevelLayout_311418, 2, &gIwram_6110, 0x14);
}

void sub_080229A4(void)
{
    sub_08021140(6, sLevelLayout_311440, 0, 0xb, 0xd1, 7, 10);
}
