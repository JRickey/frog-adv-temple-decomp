#include "iwram.h"
#include "macros.h"
#include "types.h"

extern int __divsi3(int num, int den);

/* Re-centres the active entity's screen scroll toward a target cell.
 *
 * gIwram_35E0+0x1a selects an entity index into the stride-0x38 array at
 * gIwram_3720; when nonzero the target comes from that entity's centre
 * (offsets 4/0x26/0x29 for Y, 2/0x24/0x28 for X), otherwise from the cached
 * tile coords gIwram_35E0+{0x1e,0x1c} scaled by 24. The delta is divided by
 * the entity height span (gIwram_3720[0x1c] - [0x1b]) and added to the
 * current scroll halfwords gIwram_3720+{4,2}.
 *
 * Shipped NAKED. The pure-C body below compiles to byte_diff ~150 with the
 * SAME instructions and constants but a stable register-coloring flip: the
 * baserom carries the strength-reduced entity-pointer (`(idx*8-idx)*8 + gA`)
 * and the offset-constant in r1/r2/r7, while agbcc 2.x keeps idx live in r1
 * and accumulates the product in r0/r2 — the same register-coloring drift
 * class documented in sub_080090b0.c (the sister `/24` scroll helper).
 * decomp-permuter is the only lever for this flip; the NON_MATCHING body
 * documents intent for the phase-3 PC port. */

#ifdef NON_MATCHING
void sub_080087B4(void)
{
    u8 *gA = (u8 *)&gIwram_3720;
    u8 *gB = (u8 *)&gIwram_35E0;
    s32 hi = gA[0x1c];
    s32 lo = gA[0x1b];
    u8 *e;
    s32 num;
    s32 ref;

    if (gB[0x1a] != 0) {
        e = gA + gB[0x1a] * 0x38;
        num = *(s16 *)(e + 4) + *(s16 *)(e + 0x26);
        num -= e[0x29] >> 1;
        ref = *(s16 *)(gA + 4);
    } else {
        num = *(s16 *)(gB + 0x1e) * 24;
        ref = *(s16 *)(gA + 4) - 11;
    }
    *(u16 *)(gA + 4) += __divsi3(num - ref, hi - lo);

    if (gB[0x1a] != 0) {
        e = gA + gB[0x1a] * 0x38;
        num = *(s16 *)(e + 2) + *(s16 *)(e + 0x24);
        ref = *(s16 *)(gA + 2);
    } else {
        num = *(s16 *)(gB + 0x1c) * 24;
        ref = *(s16 *)(gA + 2) - 11;
    }
    *(u16 *)(gA + 2) += __divsi3(num - ref, hi - lo);
}
#else
NAKED void sub_080087B4(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    ldr     r0, _sub_080087B4_pool_3720\n"
        "    ldrb    r3, [r0, #28]\n"
        "    ldrb    r4, [r0, #27]\n"
        "    ldr     r1, _sub_080087B4_pool_35E0\n"
        "    ldrb    r2, [r1, #26]\n"
        "    adds    r5, r0, #0\n"
        "    adds    r6, r1, #0\n"
        "    cmp     r2, #0\n"
        "    beq     _sub_080087B4_else1\n"
        "    ldrb    r0, [r6, #26]\n"
        "    lsls    r1, r0, #3\n"
        "    subs    r1, r1, r0\n"
        "    lsls    r1, r1, #3\n"
        "    adds    r1, r1, r5\n"
        "    movs    r2, #4\n"
        "    ldrsh   r0, [r1, r2]\n"
        "    movs    r7, #38\n"
        "    ldrsh   r2, [r1, r7]\n"
        "    adds    r0, r0, r2\n"
        "    adds    r1, #41\n"
        "    ldrb    r1, [r1, #0]\n"
        "    lsrs    r1, r1, #1\n"
        "    subs    r0, r0, r1\n"
        "    movs    r2, #4\n"
        "    ldrsh   r1, [r5, r2]\n"
        "    b       _sub_080087B4_join1\n"
        "    .align  2, 0\n"
        "_sub_080087B4_pool_3720: .4byte gIwram_3720\n"
        "_sub_080087B4_pool_35E0: .4byte gIwram_35E0\n"
        "_sub_080087B4_else1:\n"
        "    movs    r0, #30\n"
        "    ldrsh   r1, [r6, r0]\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #3\n"
        "    movs    r2, #4\n"
        "    ldrsh   r1, [r5, r2]\n"
        "    subs    r1, #11\n"
        "_sub_080087B4_join1:\n"
        "    subs    r0, r0, r1\n"
        "    subs    r4, r3, r4\n"
        "    adds    r1, r4, #0\n"
        "    bl      __divsi3\n"
        "    ldrh    r7, [r5, #4]\n"
        "    adds    r0, r7, r0\n"
        "    strh    r0, [r5, #4]\n"
        "    adds    r2, r6, #0\n"
        "    ldrb    r0, [r2, #26]\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_080087B4_else2\n"
        "    ldrb    r0, [r2, #26]\n"
        "    lsls    r1, r0, #3\n"
        "    subs    r1, r1, r0\n"
        "    lsls    r1, r1, #3\n"
        "    adds    r1, r1, r5\n"
        "    movs    r2, #2\n"
        "    ldrsh   r0, [r1, r2]\n"
        "    movs    r7, #36\n"
        "    ldrsh   r1, [r1, r7]\n"
        "    adds    r0, r0, r1\n"
        "    movs    r2, #2\n"
        "    ldrsh   r1, [r5, r2]\n"
        "    b       _sub_080087B4_join2\n"
        "_sub_080087B4_else2:\n"
        "    movs    r0, #28\n"
        "    ldrsh   r1, [r6, r0]\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #3\n"
        "    movs    r2, #2\n"
        "    ldrsh   r1, [r5, r2]\n"
        "    subs    r1, #11\n"
        "_sub_080087B4_join2:\n"
        "    subs    r0, r0, r1\n"
        "    adds    r1, r4, #0\n"
        "    bl      __divsi3\n"
        "    ldrh    r7, [r5, #2]\n"
        "    adds    r0, r7, r0\n"
        "    strh    r0, [r5, #2]\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .syntax divided\n");
}
#endif
