#include "game.h"
#include "iwram.h"
#include "types.h"

extern u32 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_080066C4(u8 *base, u32 selector, u32 bit);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_0802C200(u32 sound);

/* Mode-2 sibling of sub_0802C7EC (dispatched from sub_0800D8A0). When the
 * room's "start" flag (selector 3, bit 5) is set, snapshot the global timer
 * into the entity pool and arm the timeout; once more than 400 ticks elapse,
 * advance the gate counter and either re-arm (3,5) or trip it (3,6). */
void sub_0802BF58(void)
{
    u8 *base6110 = (u8 *)&gIwram_6110;
    u32 *startTime;
    u8 *base3720;

    if ((u8)sub_0800679C(base6110, 3, 5)) {
        u8 *p = (u8 *)gEntities;
        *(u32 *)(p + 0xb1c) = gGameStuff._unk00;
        *(u8 *)(p + 0x4ea) = 0;
        *(u16 *)(p + 0x504) |= 2;
        sub_080066C4(base6110, 3, 5);
    }

    /* startTime caches the gGameStuff pointer so its load is sequenced before
     * the entity base, matching the baserom's register order in the timer
     * subtraction (minuend loaded first). */
    startTime = &gGameStuff._unk00;
    base3720 = (u8 *)gEntities;
    if (*startTime - *(u32 *)(base3720 + 0xb1c) > 400) {
        if (++gIwram_6110.gateByte > 2) {
            gIwram_6110.gateByte = 0;
            sub_08006600(base6110, 3, 6);
        } else {
            sub_08006600(base6110, 3, 5);
        }
    }

    sub_0802C200(0x5c);
}
