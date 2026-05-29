#include "iwram.h"
#include "types.h"

/* sub_080031D4 — nudge the active entity (and the player header record) along
 * the X sub-coordinate in response to the held button bits in gIwram_5398.
 *
 * Element 0 of the 56-byte entity array at 0x03003720 doubles as the player
 * header (gIwram_3720). gIwram_35E0[+0xE] selects the active entity record.
 *   - bit 0x1000 held & header X > 3   -> step both records left  by 3.
 *   - bit 0x2000 held & header X <= 236 -> step both records right by 3.
 * Skips entirely while bit 4 of the header's flag halfword (+0x34) is set.
 *
 * Called from sub_08003254 with an (ignored) argument.
 *
 * Matching notes (old_agbcc):
 *   - `register u32 mask asm("r0")` + `mask = K; mask &= field; if (mask)`
 *     emits the `movs #K; ldrh; ands; cmp; bne` test idiom in r0.
 *   - The base is pinned in r1 (`register struct Entity *p asm("r1")`) so the
 *     `_field_34` test loads through r1; aliasing it into a plain `e` between
 *     the `&=` and the early return schedules the `adds r2, r1, #0` copy right
 *     after `ands` (matching the baserom), and runs the body off r2 (r1 is
 *     then free for the gIwram_5398 pool literal).
 *   - The signed compare value is pulled into a plain `int x` before the test
 *     so it does not CSE-merge with the unsigned `_field_2` read the store
 *     side needs — that separation makes the compare emit register-offset
 *     ldrsh (`movs rN, #2; ldrsh r0, [r2, rN]`) instead of `ldrh; lsls; asrs`.
 *     ldrsh has no immediate form in Thumb-1, so offset 2 sits in a register.
 *   - Anchoring gIwram_5398's address in the `btn` local for the first probe
 *     only (the second reads it directly) schedules the pool `ldr` ahead of
 *     the `movs #0x80; lsls #5` mask setup, while CSE still copies the base
 *     into r3 for the second `& 0x2000` re-test. */

struct Entity {
    u8 _pad00[2];
    s16 _field_2; /* +2: X sub-coordinate */
    u8 _pad04[0x30];
    u16 _field_34; /* +0x34: flag halfword; bit 4 = inactive */
    u8 _pad36[2];
};

extern u16 gIwram_5398;

#define gEntities_03003720 ((struct Entity *)0x03003720)

void sub_080031D4(void)
{
    register u32 mask asm("r0");
    register struct Entity *p asm("r1") = gEntities_03003720;
    struct Entity *e;
    u16 *btn;
    int x;

    mask = 4;
    mask &= p->_field_34;
    e = p;
    if (mask != 0)
        return;

    btn = &gIwram_5398;
    mask = 0x1000;
    mask &= *btn;
    if (mask != 0) {
        x = (s16)e->_field_2;
        if (x > 3) {
            e[gIwram_35E0._field_E]._field_2 -= 3;
            e->_field_2 -= 3;
        }
    }

    mask = 0x2000;
    mask &= gIwram_5398;
    if (mask != 0) {
        x = (s16)e->_field_2;
        if (x <= 236) {
            e[gIwram_35E0._field_E]._field_2 += 3;
            e->_field_2 += 3;
        }
    }
}
