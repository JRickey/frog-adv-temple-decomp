#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Per-tick refresh helper for gIwram_3720. Two flag-toggles on the
 * halfword at +0x6c, then hands the sub-struct at +0x38 to sub_080059C4
 * (the frame-setup / palette-refresh routine the entity-dispatch cluster
 * also calls).
 *
 *   - Bail early if (field_6c & 8) is already set.
 *   - If (field_34 & 4) is set, raise bit 8 in field_6c.
 *   - If (field_6c & 0x8000) is set, clear the top bit (mask &= 0x7fff)
 *     and OR bit 8 back in.
 *   - Tail: sub_080059C4(&field_38).
 *
 * Matching notes (agbcc 2.x):
 *   - `flags` (a `u16 *` local to gIwram_3720._field_6c) materialises
 *     the +0x6c offset (too large for Thumb-1 ldrh imm5) once into
 *     `adds r2, r3, #0 ; adds r2, #108`; both conditional stores and
 *     the inter-block re-read share it.
 *   - First conditional store uses `newv = bit8; newv |= t; *flags = newv;`
 *     (not `*flags = bit8 | t`) to defeat agbcc's RMW-on-t fold and
 *     emit baserom's `adds r0, r4, #0 ; orrs r0, r1 ; strh r0, [r2]`.
 *   - Second conditional store walks through `mask`:
 *     `mask = 0x7fff; mask &= t; mask |= bit8; *flags = mask`
 *     emits `ldr r0, =0x7fff ; ands r0, r1 ; orrs r0, r4 ; strh r0`.
 *   - `t` is still pinned to r1. The re-read `t = *flags;` between the two
 *     if-blocks is load-bearing — baserom emits an explicit `ldrh r1, [r2, #0]` at
 *     0x0800a4f4 to refresh; without it agbcc reuses the cached t. */

extern void sub_080059C4(void *p);

void sub_0800A4D0(void)
{
    struct Entity *base = gEntities;
    u16 *flags = (u16 *)((u8 *)base + 0x6c); /* slot 1 status (+0x6c); kept as base+offset to match */
    u32 mask;
    u16 fld;
    u32 bit8;
    register u16 t asm("r1");
    u16 newv;

    t = *flags;
    bit8 = 8;
    mask = 8;
    mask &= t;
    if (mask != 0)
        return;

    mask = 4;
    fld = base->status;
    mask &= fld;
    if (mask != 0) {
        newv = (u16)bit8;
        newv |= t;
        *flags = newv;
    }

    t = *flags;
    mask = 0x8000;
    mask &= t;
    if (mask != 0) {
        mask = 0x7fff;
        mask &= t;
        mask |= bit8;
        *flags = (u16)mask;
    }

    sub_080059C4((u8 *)base + 0x38); /* slot 1 head (+0x38) */
}
