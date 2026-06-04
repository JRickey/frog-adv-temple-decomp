#include "iwram.h"
#include "types.h"

extern s32 sub_08000764(s32 range);
extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern u32 sub_08000900(void);

extern u32 gEntities_03003720[];

void sub_0802A42C(void)
{
    u16 buf[7];

    buf[0] = 1;
    buf[1] = 0;
    buf[2] = 0;
    buf[4] = (sub_08000764(8) + 1) * 24 + 11;
    buf[5] = (sub_08000764(5) + 2) * 24 + 11;
    buf[6] = 0x303;
    sub_08021140(0x10, buf, 0x10, 0x0c, 0x151, 5, 0);
    gEntities_03003720[0xEB] = sub_08000900();
}
