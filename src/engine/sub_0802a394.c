#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_0802A2F0(void);
extern u32 sub_08000900(void);
extern void sub_08021510(u32 a0, const void *a1, u32 a2, void *a3, u8 a4);

void sub_0802A394(void)
{
    u32 *gs;
    u8 *base3720;
    u32 buf[2];
    u32 tick;
    u32 i;

    gs = &gGameStuff._unk00;
    base3720 = (u8 *)gEntities;

    if (*gs - *(u32 *)(base3720 + 0xb54) > 0x258) {
        sub_0802A2F0();
        *(u32 *)(base3720 + 0xb54) = *gs;
    }

    buf[0] = (buf[0] & 0xffff0000u) | 2u;

    tick = sub_08000900();
    if (tick - *(u32 *)(base3720 + 0xcf * 4) <= 0x12b) {
        sub_08021510(14, buf, 3, &gIwram_6110, 0);
    } else {
        i = 0;
        do {
            gEntities[i + 14].status |= 8;
            i = (u8)(i + 1);
        } while (i <= 1);
    }
}
