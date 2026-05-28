#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Resets the first N collision slots of the per-entity array at `slots`
 * (8-byte records) and re-registers each as a collision point.
 *
 * N is the point count of sEntityHitboxTable[type] (the signed low byte
 * at +0). For each slot i: clears the u32 at +0 and the three bytes at
 * +4..+6, reads the (x, y) pair from sEntityHitboxTable[type].points[i],
 * loads the table entry's flag byte (+8), and calls
 *   sub_0800CB80(gIwram_35E0._field_18, 0, x, y, flags)
 * to register the point. `out` (arg1) is finally zeroed (two u32 writes).
 *
 * Shipped NAKED. Class-1 high-register-pin: the baserom keeps the slot
 * base (arg0), the sign-extended `type` (arg2), and the hitbox-table base
 * pinned in sl/r9/r8 across the inner sub_0800CB80 call. agbcc 2.x will
 * not pin loop-invariant state in the high banked registers from pure C —
 * it recomputes or spills to the stack instead — so the high-reg
 * prologue/epilogue save and the cross-call survivors are unmatchable.
 * See docs/codegen-notes.md "High registers".
 */

#ifdef NON_MATCHING
extern int sub_0800CB80(int xTile, int unused, int x, int y, int flags);

void sub_0800BE18(u8 *slots, u32 *out, s8 type)
{
    s32 i;
    const EntityHitbox *entry = &sEntityHitboxTable[type];

    for (i = 0; i < (s8)entry->count; i++) {
        u8 *slot = &slots[i * 8];
        const s16 *pt = (const s16 *)entry->points + i * 2;

        slot[4] = 0;
        slot[5] = 0;
        slot[6] = 0;
        *(u32 *)slot = 0;

        sub_0800CB80(gIwram_35E0._field_18, 0, pt[0], pt[1], (u8)entry->flags);
    }

    out[0] = 0;
    out[1] = 0;
}
#else
NAKED void sub_0800BE18(u8 *slots, u32 *out, s8 type)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    sub     sp, #8\n"
        "    mov     sl, r0\n"
        "    str     r1, [sp, #4]\n"
        "    movs    r3, #0\n"
        "    ldr     r4, _pool_hitbox\n"
        "    lsls    r2, r2, #24\n"
        "    mov     r9, r2\n"
        "    asrs    r0, r2, #24\n"
        "    lsls    r1, r0, #1\n"
        "    adds    r1, r1, r0\n"
        "    lsls    r1, r1, #2\n"
        "    adds    r1, r1, r4\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r1, r0]\n"
        "    cmp     r3, r0\n"
        "    bge     _sub_0800BE18_done\n"
        "    movs    r7, #0\n"
        "    mov     r8, r4\n"
        "_sub_0800BE18_loop:\n"
        "    lsls    r3, r3, #24\n"
        "    asrs    r5, r3, #24\n"
        "    lsls    r0, r5, #3\n"
        "    add     r0, sl\n"
        "    strb    r7, [r0, #4]\n"
        "    strb    r7, [r0, #5]\n"
        "    strb    r7, [r0, #6]\n"
        "    str     r7, [r0, #0]\n"
        "    mov     r0, r9\n"
        "    asrs    r6, r0, #24\n"
        "    ldr     r0, _pool_iwram_35E0\n"
        "    ldrb    r0, [r0, #24]\n"
        "    lsls    r4, r6, #1\n"
        "    adds    r4, r4, r6\n"
        "    lsls    r4, r4, #2\n"
        "    mov     r1, r8\n"
        "    adds    r1, #4\n"
        "    adds    r1, r4, r1\n"
        "    ldr     r1, [r1, #0]\n"
        "    lsrs    r3, r3, #22\n"
        "    adds    r3, r3, r1\n"
        "    movs    r1, #0\n"
        "    ldrsh   r2, [r3, r1]\n"
        "    movs    r1, #2\n"
        "    ldrsh   r3, [r3, r1]\n"
        "    add     r4, r8\n"
        "    ldrb    r1, [r4, #8]\n"
        "    str     r1, [sp, #0]\n"
        "    movs    r1, #0\n"
        "    bl      sub_0800CB80\n"
        "    adds    r5, #1\n"
        "    lsls    r5, r5, #24\n"
        "    lsls    r0, r6, #1\n"
        "    adds    r0, r0, r6\n"
        "    lsls    r0, r0, #2\n"
        "    add     r0, r8\n"
        "    lsrs    r3, r5, #24\n"
        "    ldrb    r0, [r0, #0]\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r5, r0\n"
        "    blt     _sub_0800BE18_loop\n"
        "_sub_0800BE18_done:\n"
        "    movs    r0, #0\n"
        "    movs    r1, #0\n"
        "    ldr     r2, [sp, #4]\n"
        "    str     r0, [r2, #0]\n"
        "    str     r1, [r2, #4]\n"
        "    add     sp, #8\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_pool_hitbox: .4byte sEntityHitboxTable\n"
        "_pool_iwram_35E0: .4byte gIwram_35E0\n"
        "    .syntax divided\n");
}
#endif
