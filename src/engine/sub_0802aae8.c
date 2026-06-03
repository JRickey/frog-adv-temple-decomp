#include "iwram.h"
#include "types.h"

typedef struct EntitySlot {
    u8 _pad00[0x34];
    u16 flags;
    u8 _pad36[2];
} EntitySlot;

extern void sub_08021140(u32 a0, const void *a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);
extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);

extern const u32 sLevelLayout_317DC4[6];
extern const void *const sLevelLayoutPtrs_317E6C[2];

void sub_0802AAE8(void)
{}

void sub_0802AAEC(void)
{
    sub_08021140(10, sLevelLayout_317DC4, 16, 90, 0xc1, 2, 0);
}

void sub_0802AB14(void)
{
    u8 i;
    u16 *flags;
    register u32 offset asm("r0");

    offset = 0xfb;
    flags = (u16 *)((u8 *)gEntities + (offset << 2));
    offset = 8;
    if ((*flags & offset) != 0)
        return;

    i = 0;
    do {
        sub_080219BC(sLevelLayoutPtrs_317E6C[i], i + 17);
        i++;
    } while (i <= 1);

    sub_08020FE4(17, 18);
    sub_08005D10(17, 18);
}
