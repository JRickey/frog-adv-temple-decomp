#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u32 sub_08009C14(u8 *state);
extern void sub_0800B7B0(u32 a, u32 b, u8 c);
extern void sub_080066C4(u32 base, u32 idx, u32 val);

/* Sibling of sub_08000D2C: when sub_08009C14 fails the predicate, force
 * state=7 onto the caller's byte pointer, then forward to sub_0800B7B0
 * (mode=5). Afterwards, branch on the signed sub-state byte at
 * gGameStuff_35E0[5]:
 *   <= 1 : clear flags 8 and 9 on the 0x03006110 cluster
 *   == 2 : set flags 8 and 9
 *   == 3 : set flags 8 and 9 (same as 2)
 * The two cmp #2 / cmp #3 arms reload the sub-state byte each time,
 * matching the baserom's three-arm cmp chain rather than a switch. */
void sub_08001D94(u8 *state, u32 a, u32 b)
{
    if (sub_08009C14(state) == 0) {
        *state = 7;
    }
    sub_0800B7B0(a, b, 5);
    if (gIwram_35E0._field_5 <= 1) {
        sub_080066C4(0x03006110, 8, 0);
        sub_080066C4(0x03006110, 9, 0);
    }
    if ((u8)gIwram_35E0._field_5 == 2) {
        sub_080066C4(0x03006110, 8, 1);
        sub_080066C4(0x03006110, 9, 1);
    }
    {
        u8 lastState = (u8)gIwram_35E0._field_5;
        if (lastState == 3) {
            sub_080066C4(0x03006110, 8, 1);
            sub_080066C4(0x03006110, 9, 1);
        }
    }
}
