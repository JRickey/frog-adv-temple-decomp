#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);

extern const u32 sLevelLayout_312270[];

void sub_080242D8(void)
{
    sub_08021140(0x65, sLevelLayout_312270, 16, 11, 0x1e1, 9, 0);
}
