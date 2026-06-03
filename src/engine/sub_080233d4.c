#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const u32 sLevelLayout_311CB0[12];

void sub_080233D4(void)
{
    sub_08021140(0x3e, sLevelLayout_311CB0, 0, 4, 0x141, 8, 0);
}
