#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Rebuilds the gIwram_6110._field_33 spawn-record selector mask: for each of
 * the four selector-5 flag bits (sub_0800679C selector 5 reads the +0x26 flag
 * halfword), OR (1 << i) into _field_33 when the queried bit is set.
 *
 * Matching notes (agbcc 2.x):
 *   - The counter is initialised (`i = 0`) before the base-pointer load so the
 *     prologue emits `movs r1, #0` ahead of the `ldr r6, =0x03006110`, matching
 *     baserom's counter-init-first ordering.
 *   - base6110 as a local u8 * anchors 0x03006110 in a callee-saved register
 *     across the BL to sub_0800679C, so the post-call store reuses that base.
 *   - The shift amount is pinned to r1 (`register s32 sh asm("r1")`); without
 *     the pin agbcc colours the sign-extended counter into r2 and emits
 *     `asrs r2 / lsls r0, r2` instead of baserom's `asrs r1 / lsls r0, r1`. */

extern u32 sub_0800679C(u8 *base, u32 selector, u32 bit);

void sub_0800C4A0(void)
{
    s8 i;
    u8 *base6110;

    i = 0;
    base6110 = (u8 *)0x03006110;
    for (; i <= 3; i++) {
        u32 bit = (u8)i;
        if ((u8)sub_0800679C(base6110, 5, bit) != 0) {
            register s32 sh asm("r1") = i;
            base6110[0x33] |= 1 << sh;
        }
    }
}

/* Two empty dispatch stubs kept as separate symbols (sub_0800C4E4 is the
 * "dispatch stub" referenced from the entity-frame-descriptor cluster) so the
 * surrounding layout stays byte-identical: each compiles to `bx lr` plus a
 * 2-byte align-to-4 pad, packing the pair into the original 8-byte slice. */
void sub_0800C4E0(void)
{}

void sub_0800C4E4(void)
{}
