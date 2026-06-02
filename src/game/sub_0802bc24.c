#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);

extern const u32 sLevelLayout_317FD0[];

void sub_0802BC24(void)
{
    sub_08021140(0x17, sLevelLayout_317FD0, 0x10, 0x57, 0x89, 3, 0);
}
