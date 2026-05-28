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

/* Expands one entry of the part-descriptor table at 0x080C0AB0 into a run of
 * 36-byte (0x24) output records.
 *
 * The table is indexed by a signed part-id and each 8-byte entry is
 * { s8 count; u8 pad[3]; const SrcRec *records; }. For each of `count` source
 * records (16 bytes apiece) the routine copies the 16 raw bytes into a stack
 * scratch, then derives an OutRec: the two leading halfwords pass through; the
 * X/Y origin is `byte * 24 +/- 12` keyed on the layout flag at s[6]; a small
 * switch on s[6] (0..3) plus the sign test on records[0] picks a sprite-shape
 * id (offset 0x19) and a y/x bias (offsets 0x10/0x11); and a few bytes/words
 * are forwarded verbatim. `out` advances by 0x24 each iteration.
 *
 * Shipped NAKED. The loop pins the table base in r8, base+4 in sl, and the
 * record array in r9 across the whole body so the per-iteration index math
 * never reloads the pool literal — agbcc 2.x will not hold three high
 * registers live across a loop like this and instead recomputes the bases
 * from low registers, so the prologue/epilogue high-reg save pair and the
 * `add rN, r8/r9/sl` index forms can't be reproduced from pure C. This is the
 * docs/codegen-notes.md "High registers" (Class 1) unmatchable pattern; the
 * NON_MATCHING body documents intent for the phase-3 PC port.
 */

#ifdef NON_MATCHING
struct SrcRec {
    s16 _h0;
    s16 _h2;
    s8 _b4;
    s8 _b5;
    s8 _b6;
    s8 _b7;
    u8 _b8;
    u8 _b9;
    u8 _pad[2];
    u32 _w12;
};

struct PartEntry {
    s8 count;
    u8 _pad[3];
    const struct SrcRec *records;
};

extern const struct PartEntry gPartTable_080C0AB0[];

void sub_08006BB4(u8 partId, u8 *out)
{
    s8 id = (s8)partId;
    const struct PartEntry *entry = &gPartTable_080C0AB0[id];
    const struct SrcRec *records = entry->records;
    s32 i;

    for (i = 0; i < entry->count; i++) {
        struct SrcRec s = records[i];
        s8 firstByte = *(const s8 *)&records[0];

        *(s16 *)(out + 0) = s._h0;
        *(s16 *)(out + 2) = s._h2;

        if (s._b6 > 1) {
            *(s16 *)(out + 4) = s._b4 * 24 + 12;
            *(s16 *)(out + 6) = s._b5 * 24 - 12;
        } else {
            *(s16 *)(out + 4) = s._b4 * 24 - 12;
            *(s16 *)(out + 6) = s._b5 * 24 + 12;
        }

        out[18] = s._b8;
        out[24] = s._b9;
        out[26] = 0;
        out[28] = (u8)(s._b4 * s._b5);
        *(u32 *)(out + 32) = s._w12;
        out[8] = ((const u8 *)&records[0])[1];

        switch (s._b6) {
        case 0:
            out[25] = (firstByte > 1) ? s._b6 : 18;
            out[16] = 0;
            out[17] = (u8)(-s._b7);
            break;
        case 1:
            out[25] = (firstByte > 1) ? 12 : 20;
            out[16] = 0;
            out[17] = s._b7;
            break;
        case 2:
            out[25] = (firstByte > 1) ? 24 : 21;
            out[17] = 0;
            out[16] = (u8)(-s._b7);
            break;
        case 3:
            out[25] = (firstByte > 1) ? 36 : 23;
            out[17] = 0;
            out[16] = s._b7;
            break;
        default:
            break;
        }

        out += 0x24;
    }
}
#else
NAKED void sub_08006BB4(u8 partId, u8 *out)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    sub     sp, #20\n"
        "    adds    r2, r1, #0\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    mov     ip, r0\n"
        "    movs    r0, #0\n"
        "    str     r0, [sp, #16]\n"
        "    ldr     r1, _pool_part_table\n"
        "    mov     r8, r1\n"
        "    mov     r3, ip\n"
        "    lsls    r1, r3, #24\n"
        "    asrs    r0, r1, #21\n"
        "    add     r0, r8\n"
        "    ldrb    r0, [r0, #0]\n"
        "    lsls    r0, r0, #24\n"
        "    asrs    r0, r0, #24\n"
        "    ldr     r4, [sp, #16]\n"
        "    cmp     r4, r0\n"
        "    blt     _loop_setup\n"
        "    b       _epilogue\n"
        "_loop_setup:\n"
        "    mov     r9, r8\n"
        "    movs    r7, #4\n"
        "    add     r7, r8\n"
        "    mov     sl, r7\n"
        "    mov     r5, sp\n"
        "    movs    r6, #0\n"
        "    adds    r3, r2, #0\n"
        "_loop_body:\n"
        "    asrs    r0, r1, #21\n"
        "    add     r0, sl\n"
        "    ldr     r2, [r0, #0]\n"
        "    ldr     r1, [sp, #16]\n"
        "    lsls    r0, r1, #4\n"
        "    mov     r1, sp\n"
        "    adds    r0, r0, r2\n"
        "    ldmia   r0!, {r2, r4, r7}\n"
        "    stmia   r1!, {r2, r4, r7}\n"
        "    ldr     r0, [r0, #0]\n"
        "    str     r0, [r1, #0]\n"
        "    ldrh    r0, [r5, #0]\n"
        "    strh    r0, [r3, #0]\n"
        "    ldrh    r0, [r5, #2]\n"
        "    strh    r0, [r3, #2]\n"
        "    movs    r0, #6\n"
        "    ldrsb   r0, [r5, r0]\n"
        "    cmp     r0, #1\n"
        "    bgt     _layout_b\n"
        "    movs    r1, #4\n"
        "    ldrsb   r1, [r5, r1]\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #3\n"
        "    subs    r0, #12\n"
        "    strh    r0, [r3, #4]\n"
        "    movs    r1, #5\n"
        "    ldrsb   r1, [r5, r1]\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #3\n"
        "    adds    r0, #12\n"
        "    b       _store_h6\n"
        "    .align  2, 0\n"
        "_pool_part_table: .4byte 0x080C0AB0\n"
        "_layout_b:\n"
        "    movs    r1, #4\n"
        "    ldrsb   r1, [r5, r1]\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #3\n"
        "    adds    r0, #12\n"
        "    strh    r0, [r3, #4]\n"
        "    movs    r1, #5\n"
        "    ldrsb   r1, [r5, r1]\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #3\n"
        "    subs    r0, #12\n"
        "_store_h6:\n"
        "    strh    r0, [r3, #6]\n"
        "    ldrb    r0, [r5, #8]\n"
        "    strb    r0, [r3, #18]\n"
        "    ldrb    r0, [r5, #9]\n"
        "    strb    r0, [r3, #24]\n"
        "    strb    r6, [r3, #26]\n"
        "    ldrb    r1, [r5, #4]\n"
        "    ldrb    r2, [r5, #5]\n"
        "    adds    r0, r1, #0\n"
        "    muls    r0, r2\n"
        "    strb    r0, [r3, #28]\n"
        "    ldr     r0, [sp, #12]\n"
        "    str     r0, [r3, #32]\n"
        "    mov     r4, ip\n"
        "    lsls    r1, r4, #24\n"
        "    asrs    r0, r1, #21\n"
        "    mov     r7, r9\n"
        "    adds    r4, r0, r7\n"
        "    ldrb    r0, [r4, #1]\n"
        "    strb    r0, [r3, #8]\n"
        "    movs    r2, #6\n"
        "    ldrsb   r2, [r5, r2]\n"
        "    cmp     r2, #1\n"
        "    beq     _case1\n"
        "    cmp     r2, #1\n"
        "    bgt     _case_gt1\n"
        "    cmp     r2, #0\n"
        "    beq     _case0\n"
        "    b       _next\n"
        "_case_gt1:\n"
        "    cmp     r2, #2\n"
        "    beq     _case2\n"
        "    cmp     r2, #3\n"
        "    beq     _case3\n"
        "    b       _next\n"
        "_case0:\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #1\n"
        "    ble     _case0_lo\n"
        "    strb    r2, [r3, #25]\n"
        "    b       _case0_cont\n"
        "_case0_lo:\n"
        "    movs    r0, #18\n"
        "    strb    r0, [r3, #25]\n"
        "_case0_cont:\n"
        "    strb    r6, [r3, #16]\n"
        "    ldrb    r2, [r5, #7]\n"
        "    negs    r0, r2\n"
        "    strb    r0, [r3, #17]\n"
        "    b       _next\n"
        "_case1:\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #1\n"
        "    ble     _case1_lo\n"
        "    movs    r0, #12\n"
        "    b       _case1_set\n"
        "_case1_lo:\n"
        "    movs    r0, #20\n"
        "_case1_set:\n"
        "    strb    r0, [r3, #25]\n"
        "    strb    r6, [r3, #16]\n"
        "    ldrb    r0, [r5, #7]\n"
        "    strb    r0, [r3, #17]\n"
        "    b       _next\n"
        "_case2:\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #1\n"
        "    ble     _case2_lo\n"
        "    movs    r0, #24\n"
        "    b       _case2_set\n"
        "_case2_lo:\n"
        "    movs    r0, #21\n"
        "_case2_set:\n"
        "    strb    r0, [r3, #25]\n"
        "    strb    r6, [r3, #17]\n"
        "    ldrb    r4, [r5, #7]\n"
        "    negs    r0, r4\n"
        "    b       _case23_store16\n"
        "_case3:\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #1\n"
        "    ble     _case3_lo\n"
        "    movs    r0, #36\n"
        "    b       _case3_set\n"
        "_case3_lo:\n"
        "    movs    r0, #23\n"
        "_case3_set:\n"
        "    strb    r0, [r3, #25]\n"
        "    strb    r6, [r3, #17]\n"
        "    ldrb    r0, [r5, #7]\n"
        "_case23_store16:\n"
        "    strb    r0, [r3, #16]\n"
        "_next:\n"
        "    adds    r3, #36\n"
        "    ldr     r7, [sp, #16]\n"
        "    adds    r7, #1\n"
        "    str     r7, [sp, #16]\n"
        "    asrs    r0, r1, #21\n"
        "    add     r0, r8\n"
        "    ldrb    r0, [r0, #0]\n"
        "    lsls    r0, r0, #24\n"
        "    asrs    r0, r0, #24\n"
        "    cmp     r7, r0\n"
        "    bge     _epilogue\n"
        "    b       _loop_body\n"
        "_epilogue:\n"
        "    add     sp, #20\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .syntax divided\n");
}
#endif
