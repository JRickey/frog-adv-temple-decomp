#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const u32 sLevelLayout_311488[4];

void sub_080234E8(void)
{
    sub_08021140(0x5f, sLevelLayout_311488, 0, 0x4c, 0x231, 14, 0);
}
