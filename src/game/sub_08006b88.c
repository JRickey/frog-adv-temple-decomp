#include "macros.h"
#include "types.h"

/* Bit-set leaf on a u16 field at offset 16. Companion to the bit-clear
 * sub_08006948 (offset 0x2e in src/game/sub_08006948.c), called from
 * sub_080090B0 when the entity's tile-cache key changes (raises bit 0x40
 * on the dirty-flags halfword at gIwram_35E0+0x10). */

void sub_08006B88(void *p, u16 mask)
{
    *(u16 *)((u8 *)p + 16) |= mask;
}

/* Bit-clear companion to sub_08006B88 — same u16 field at offset 16. Same
 * unmatchable class as the sibling sub_08006948 (offset 0x2e): baserom emits
 * `bics r2, r1; adds r1, r2, #0; strh r1, [r0, #16]` (round-tripping the
 * masked value through r1 before the store), while agbcc 2.x folds the move
 * out and emits `bics r2, r1; strh r2, [r0, #16]` directly. Permuter 1761
 * iter run (nonmatchings/sub_08006B94/) plateaued at base score 205 with
 * zero matches; 11 pure-C source-form variants all hit byte_diff >= 4.
 * NON_MATCHING reference body below documents intent for the phase-3
 * PC port. */

#ifdef NON_MATCHING
void sub_08006B94(void *p, u16 mask)
{
    *(u16 *)((u8 *)p + 16) &= ~mask;
}
#else
NAKED void sub_08006B94(void *p, u16 mask)
{
    asm(".syntax unified\n"
        "    lsls    r1, r1, #16\n"
        "    lsrs    r1, r1, #16\n"
        "    ldrh    r2, [r0, #16]\n"
        "    bics    r2, r1\n"
        "    adds    r1, r2, #0\n"
        "    strh    r1, [r0, #16]\n"
        "    bx      lr\n"
        "    .align  2, 0\n"
        ".syntax divided\n");
}
#endif
