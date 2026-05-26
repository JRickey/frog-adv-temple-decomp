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
 * Shipped NAKED. The pure-C body in the NON_MATCHING block compiles to
 * byte_diff=6 — same class of register-coloring drift seen in
 * sub_0800A2D8 / sub_0800A328 (dispatch_helpers.c). agbcc 2.x picks
 * `lsrs r1, r0, #16` for the second divide's u16-mask (then loads cached
 * X/Y into r0) while the baserom keeps the result in r0 across the load
 * destination choice (loads land in r1, comparisons swap accordingly).
 * decomp-permuter run (2100+ iterations) found no better variant —
 * matches the docs/codegen-notes.md "register-coloring drift" class.
 */

extern u16 sub_08006B88(void *p, u16 v); /* OR-into-u16-at-offset-16 */

#ifdef NON_MATCHING
void sub_080090B0(void)
{
    u16 newX = (u16)(gIwram_3720._field_2 / 24);
    u16 newY = (u16)(gIwram_3720._field_4 / 24);

    if (gIwram_35E0._field_8 == newX && gIwram_35E0._field_A == newY)
        return;

    sub_08006B88(&gIwram_35E0, 64);
    gIwram_35E0._field_8 = newX;
    gIwram_35E0._field_A = newY;
}
#else
NAKED void sub_080090B0(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, lr}\n"
        "    ldr     r4, _pool_iwram_3720\n"
        "    movs    r1, #2\n"
        "    ldrsh   r0, [r4, r1]\n"
        "    movs    r1, #24\n"
        "    bl      __divsi3\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    adds    r5, r0, #0\n"
        "    movs    r1, #4\n"
        "    ldrsh   r0, [r4, r1]\n"
        "    movs    r1, #24\n"
        "    bl      __divsi3\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    adds    r6, r0, #0\n"
        "    ldr     r4, _pool_iwram_35E0\n"
        "    ldrh    r1, [r4, #8]\n"
        "    cmp     r1, r5\n"
        "    bne     _sub_080090B0_call\n"
        "    ldrh    r1, [r4, #10]\n"
        "    cmp     r1, r0\n"
        "    beq     _sub_080090B0_ret\n"
        "_sub_080090B0_call:\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #0x40\n"
        "    bl      sub_08006B88\n"
        "    strh    r5, [r4, #8]\n"
        "    strh    r6, [r4, #10]\n"
        "_sub_080090B0_ret:\n"
        "    pop     {r4, r5, r6}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_pool_iwram_3720: .4byte gIwram_3720\n"
        "_pool_iwram_35E0: .4byte gIwram_35E0\n"
        "    .syntax divided\n");
}
#endif
