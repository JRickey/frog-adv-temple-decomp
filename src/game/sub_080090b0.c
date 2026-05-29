#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Cache-invalidation helper.
 *
 * Converts a pair of signed sub-pixel coordinates at gIwram_3720+{2,4} to
 * tile/cell coordinates by dividing each by 24 (signed). If the resulting
 * (X, Y) differs from the previously-cached pair at gIwram_35E0+{8,0xA},
 * raises bit 0x40 in the flags halfword at gIwram_35E0+0x10 (via
 * sub_08006B88) and stores the new pair as the cache key.
 *
 * sub_08006B88(p, v) is a 3-instruction leaf: `(u16*)(p+16) |= (u16)v;`.
 *
 * `cached` is pinned to r1: the baserom reuses one register (r1) for both
 * cached-coord loads and emits `cmp cached, new` (cached operand first).
 * Without the pin agbcc lands the cached load in r0 and flips the cmp
 * operand order. The pin reproduces the baserom's single-register reuse
 * and compare ordering exactly.
 */

extern u16 sub_08006B88(void *p, u16 v); /* OR-into-u16-at-offset-16 */

void sub_080090B0(void)
{
    register u16 cached asm("r1");
    u16 newX = (u16)(gIwram_3720._field_2 / 24);
    u16 newY = (u16)(gIwram_3720._field_4 / 24);

    cached = (u16)gIwram_35E0._field_8;
    if (cached == newX) {
        cached = (u16)gIwram_35E0._field_A;
        if (cached == newY)
            return;
    }

    sub_08006B88(&gIwram_35E0, 64);
    gIwram_35E0._field_8 = newX;
    gIwram_35E0._field_A = newY;
}
