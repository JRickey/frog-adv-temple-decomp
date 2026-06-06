#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);

extern const u32 sLevelLayout_312138[];

void sub_08024444(void)
{
    sub_08021140(0x77, sLevelLayout_312138, 0, 0x4c, 0x351, 14, 0);
}
