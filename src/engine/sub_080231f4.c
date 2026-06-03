#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const u8 sLevelLayout_311498[];

void sub_080231F4(void)
{
    sub_08021140(2, sLevelLayout_311498, 0x10, 0x11, 0x41, 1, 0);
}
