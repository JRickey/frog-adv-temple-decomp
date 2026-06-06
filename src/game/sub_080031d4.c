#include "iwram.h"
#include "types.h"

/* Player_UpdateHorizontalInput — nudge the active entity (and the player header record) along
 * the X sub-coordinate in response to the held button bits in gIwram_5398.
 *
 * Element 0 of the 56-byte entity array at 0x03003720 doubles as the player
 * header (gIwram_3720). gIwram_35E0[+0xE] selects the active entity record.
 *   - bit 0x1000 held & header X > 3   -> step both records left  by 3.
 *   - bit 0x2000 held & header X <= 236 -> step both records right by 3.
 * Skips entirely while bit 4 of the header's flag halfword (+0x34) is set.
 *
 * Called from GameMode_SceneTick with an (ignored) argument.
 *
 * Matching notes (old_agbcc):
 *   - Keeping `mask` in r0 plus `mask = K; mask &= field; if (mask)`
 *     emits the `movs #K; ldrh; ands; cmp; bne` test idiom in r0.
 *   - The base is pinned in r1 so the
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

extern u16 gIwram_5398;

void Player_UpdateHorizontalInput(void)
{
    register u32 mask asm("r0");
    struct Entity *p = gEntities;
    struct Entity *e;
    u16 *btn;
    int x;

    mask = 4;
    mask &= p->status;
    e = p;
    if (mask != 0)
        return;

    btn = &gIwram_5398;
    mask = 0x1000;
    mask &= *btn;
    if (mask != 0) {
        x = (s16)e->x;
        if (x > 3) {
            e[gIwram_35E0._field_E].x -= 3;
            e->x -= 3;
        }
    }

    mask = 0x2000;
    mask &= gIwram_5398;
    if (mask != 0) {
        x = (s16)e->x;
        if (x <= 236) {
            e[gIwram_35E0._field_E].x += 3;
            e->x += 3;
        }
    }
}
