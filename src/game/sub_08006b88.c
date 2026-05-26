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

/* Bool predicate companion: `return (*(u16 *)(p + 16) & mask) != 0`. Reads
 * the same u16 dirty-flags field as sub_08006B88/sub_08006B94 (offset 16),
 * AND-tests against `mask`, returns 0/1. Body bytes are identical to the
 * baserom; the unmatchable element is the frame: baserom emits a bare
 * `bx lr` with no `push {lr}`, while agbcc 2.x consistently wraps the
 * predicate in `push {lr} / ... / pop {r1}; bx r1` (4 extra bytes) and
 * also swaps the branch sense (`beq` skip-over vs baserom's `bne`
 * fall-through). Same "Fifth unmatchable class: register-coloring drift"
 * subform as sibling sub_08006958 (offset 0x2e) and sub_08006B94 (also
 * offset 0x10). Permuter run on nonmatchings/sub_08006BA4/ confirms
 * non-convergence; 10+ pure-C source variants attempted in iter 32, all
 * plateaued at byte_diff >= 4. NON_MATCHING reference body documents
 * intent for the phase-3 PC port. */

#ifdef NON_MATCHING
u8 sub_08006BA4(void *p, u16 mask)
{
    if ((*(u16 *)((u8 *)p + 16) & mask) == 0)
        return 0;
    return 1;
}
#else
NAKED u8 sub_08006BA4(void *p, u16 mask)
{
    asm(".syntax unified\n"
        "    ldrh    r0, [r0, #16]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     1f\n"
        "    movs    r0, #0\n"
        "    b       2f\n"
        "1:  movs    r0, #1\n"
        "2:  bx      lr\n"
        ".syntax divided\n");
}
#endif
