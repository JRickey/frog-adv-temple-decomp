#include "game.h"
#include "iwram.h"
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

/* Bit-clear companion to sub_08006B88 - same u16 field at offset 16. Like the
 * matched sibling sub_08006948 (offset 0x2e), this whole TU is built with
 * OLD_AGBCC_BIN (see the Makefile per-TU override): old_agbcc keeps the
 * redundant `adds r1, r2, #0` move that recolours the BIC result into r1
 * before `strh r1` (newer agbcc coalesces it away to the 2-byte-shorter
 * `strh r2`). */

void sub_08006B94(void *p, u16 mask)
{
    *(u16 *)((u8 *)p + 16) &= ~mask;
}

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

/* Per-cell update sweep over a 36-byte-stride cell array (base = `cells`,
 * inclusive index range [first, last]). For each cell whose age
 * (gGameStuff._unk00 minus the cell's last-stamp at +20) exceeds the cell's
 * threshold at +24, the per-frame counter at +25 is bumped (and snapped down
 * by 4 when it crosses a multiple of 4), then an inner loop walks the cell's
 * `count` (signed byte at +28) sub-records — each a {s16 col, s16 row} pair at
 * the pointer stored at +32 — classifying every tile via sub_0800CD88 and,
 * for class 8 with the cell's flag byte at +17 clear, enqueueing it through
 * sub_080112C0 (kinds 4/3 keyed on which tri-step encoding the sub-record
 * uses). The cell's last-stamp is refreshed to the current tick afterward.
 *
 * Shipped NAKED. The outer index is pinned in r9, the cell base in sl, and
 * the table/record bases shuffle through r8/sl across both the sub_0800CD88
 * and sub_080112C0 calls — agbcc 2.x will not hold these high registers live
 * across the nested call-bearing loops and instead recomputes the bases from
 * low registers, so the high-reg save/restore frame and the `add rN, r8/sl`
 * index forms can't be reproduced from pure C. This is the
 * docs/codegen-notes.md "High registers" (Class 1) unmatchable pattern; the
 * NON_MATCHING body documents intent for the phase-3 PC port. */

extern u8 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_080112C0(s32 kind, s32 a, s32 b, s32 tileX, s32 tileY, s32 sub);

#ifdef NON_MATCHING
struct Cell {
    u8 _pad00[20];
    u32 lastStamp; /* +20 */
    u8 threshold;  /* +24 */
    u8 counter;    /* +25 */
    u8 _pad1A[2];
    s8 count; /* +28 */
    u8 _pad1D[3];
    const s16 *records; /* +32: { s16 col, s16 row } pairs */
};

void sub_08006D24(struct Cell *cells, s32 first, s32 last, u8 arg3)
{
    s32 i;
    u32 tick = gGameStuff._unk00;
    s8 flag = (s8)arg3;

    for (i = first; i <= last; i++) {
        struct Cell *cell = &cells[i];
        s32 j;

        if (tick - cell->lastStamp <= cell->threshold)
            continue;

        cell->counter++;
        if ((cell->counter & 3) == 0)
            cell->counter -= 4;

        for (j = 0; j < cell->count; j++) {
            const s16 *rec = &cell->records[j * 2];
            s32 col = rec[0];
            s32 row = rec[1] + 1;

            if ((u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, col, row) == 8 &&
                cell->_pad1A[0 - 24 + 0x11] == 0) {
                /* flag byte at cell+0x11 */
                s32 a = rec[0] * 3;
                s32 b = rec[1] * 3;
                sub_080112C0(1, 4, 3, b, flag, a);
            } else {
                s32 a = cell->records[j * 2] * 3;
                s32 b = cell->records[j * 2 + 1] * 3;
                sub_080112C0(1, 3, 3, b, flag, a);
            }
        }

        cell->lastStamp = tick;
    }
}
#else
NAKED void sub_08006D24(void *cells, s32 first, s32 last, u8 arg3)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    sub     sp, #44\n"
        "    mov     sl, r0\n"
        "    str     r2, [sp, #12]\n"
        "    lsls    r3, r3, #24\n"
        "    lsrs    r3, r3, #24\n"
        "    ldr     r0, _pool_gGameStuff\n"
        "    ldr     r0, [r0, #0]\n"
        "    str     r0, [sp, #20]\n"
        "    mov     r9, r1\n"
        "    cmp     r9, r2\n"
        "    ble     _06d46\n"
        "    b       _06e7c\n"
        "_06d46:\n"
        "    str     r3, [sp, #28]\n"
        "_06d48:\n"
        "    mov     r1, r9\n"
        "    lsls    r0, r1, #3\n"
        "    adds    r1, r0, r1\n"
        "    lsls    r3, r1, #2\n"
        "    mov     r4, sl\n"
        "    adds    r2, r3, r4\n"
        "    ldr     r1, [r2, #20]\n"
        "    ldr     r4, [sp, #20]\n"
        "    subs    r1, r4, r1\n"
        "    str     r0, [sp, #36]\n"
        "    mov     r0, r9\n"
        "    adds    r0, #1\n"
        "    str     r0, [sp, #32]\n"
        "    ldrb    r4, [r2, #24]\n"
        "    cmp     r1, r4\n"
        "    bhi     _06d6a\n"
        "    b       _06e70\n"
        "_06d6a:\n"
        "    ldrb    r0, [r2, #25]\n"
        "    str     r0, [sp, #16]\n"
        "    adds    r0, #1\n"
        "    strb    r0, [r2, #25]\n"
        "    ldrb    r1, [r2, #25]\n"
        "    movs    r0, #3\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _06d80\n"
        "    subs    r0, r1, #4\n"
        "    strb    r0, [r2, #25]\n"
        "_06d80:\n"
        "    movs    r7, #0\n"
        "    movs    r0, #28\n"
        "    ldrsb   r0, [r2, r0]\n"
        "    cmp     r7, r0\n"
        "    bge     _06e64\n"
        "    str     r3, [sp, #24]\n"
        "    adds    r6, r2, #0\n"
        "    movs    r1, #0\n"
        "    mov     r8, r1\n"
        "_06d92:\n"
        "    ldr     r5, [sp, #16]\n"
        "    movs    r0, #28\n"
        "    ldrsb   r0, [r6, r0]\n"
        "    cmp     r0, #1\n"
        "    ble     _06dbe\n"
        "    subs    r0, #1\n"
        "    cmp     r7, r0\n"
        "    bne     _06db0\n"
        "    lsls    r0, r5, #24\n"
        "    movs    r2, #128\n"
        "    lsls    r2, r2, #20\n"
        "    adds    r0, r0, r2\n"
        "    b       _06dbc\n"
        "    .align  2, 0\n"
        "_pool_gGameStuff: .4byte 0x03005330\n"
        "_06db0:\n"
        "    cmp     r7, #0\n"
        "    ble     _06dbe\n"
        "    lsls    r0, r5, #24\n"
        "    movs    r4, #128\n"
        "    lsls    r4, r4, #19\n"
        "    adds    r0, r0, r4\n"
        "_06dbc:\n"
        "    lsrs    r5, r0, #24\n"
        "_06dbe:\n"
        "    ldr     r1, _pool_gIwram35E0\n"
        "    ldrb    r0, [r1, #24]\n"
        "    ldrb    r1, [r1, #25]\n"
        "    str     r1, [sp, #40]\n"
        "    ldr     r4, [sp, #24]\n"
        "    add     r4, sl\n"
        "    ldr     r3, [r4, #32]\n"
        "    add     r3, r8\n"
        "    movs    r2, #0\n"
        "    ldrsh   r1, [r3, r2]\n"
        "    mov     ip, r1\n"
        "    ldrh    r3, [r3, #2]\n"
        "    adds    r3, #1\n"
        "    lsls    r3, r3, #16\n"
        "    asrs    r3, r3, #16\n"
        "    ldr     r1, [sp, #40]\n"
        "    mov     r2, ip\n"
        "    bl      sub_0800CD88\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    cmp     r0, #8\n"
        "    bne     _06e28\n"
        "    movs    r0, #17\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #0\n"
        "    bne     _06e28\n"
        "    ldr     r1, [r4, #32]\n"
        "    add     r1, r8\n"
        "    movs    r4, #0\n"
        "    ldrsh   r0, [r1, r4]\n"
        "    lsls    r3, r0, #1\n"
        "    adds    r3, r3, r0\n"
        "    lsls    r3, r3, #16\n"
        "    lsrs    r3, r3, #16\n"
        "    movs    r0, #2\n"
        "    ldrsh   r1, [r1, r0]\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    str     r0, [sp, #0]\n"
        "    ldr     r1, [sp, #28]\n"
        "    str     r1, [sp, #4]\n"
        "    str     r5, [sp, #8]\n"
        "    movs    r0, #1\n"
        "    movs    r1, #4\n"
        "    movs    r2, #3\n"
        "    bl      sub_080112C0\n"
        "    b       _06e56\n"
        "    .align  2, 0\n"
        "_pool_gIwram35E0: .4byte 0x030035e0\n"
        "_06e28:\n"
        "    ldr     r1, [r6, #32]\n"
        "    add     r1, r8\n"
        "    movs    r2, #0\n"
        "    ldrsh   r0, [r1, r2]\n"
        "    lsls    r3, r0, #1\n"
        "    adds    r3, r3, r0\n"
        "    lsls    r3, r3, #16\n"
        "    lsrs    r3, r3, #16\n"
        "    movs    r4, #2\n"
        "    ldrsh   r1, [r1, r4]\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    str     r0, [sp, #0]\n"
        "    ldr     r0, [sp, #28]\n"
        "    str     r0, [sp, #4]\n"
        "    str     r5, [sp, #8]\n"
        "    movs    r0, #1\n"
        "    movs    r1, #3\n"
        "    movs    r2, #3\n"
        "    bl      sub_080112C0\n"
        "_06e56:\n"
        "    movs    r1, #4\n"
        "    add     r8, r1\n"
        "    adds    r7, #1\n"
        "    movs    r0, #28\n"
        "    ldrsb   r0, [r6, r0]\n"
        "    cmp     r7, r0\n"
        "    blt     _06d92\n"
        "_06e64:\n"
        "    ldr     r0, [sp, #36]\n"
        "    add     r0, r9\n"
        "    lsls    r0, r0, #2\n"
        "    add     r0, sl\n"
        "    ldr     r2, [sp, #20]\n"
        "    str     r2, [r0, #20]\n"
        "_06e70:\n"
        "    ldr     r4, [sp, #32]\n"
        "    mov     r9, r4\n"
        "    ldr     r0, [sp, #12]\n"
        "    cmp     r9, r0\n"
        "    bgt     _06e7c\n"
        "    b       _06d48\n"
        "_06e7c:\n"
        "    add     sp, #44\n"
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

/* Re-centres the gIwram_3720 scroll cursor toward a target tile by stepping it
 * along a row of 36-byte (0x24) grid entries, inclusive index range
 * [first, last]. The current tick is snapshotted from gGameStuff._unk00; an
 * entry is only revisited once (tick - entry.stamp) exceeds entry.ageMax.
 *
 * For each ripe entry with flags bit 1 set (and the cursor's own dirty bit 1
 * at gIwram_35E0+0x10 set), the candidate tile is computed from the cursor's
 * gIwram_3720 sub-coords plus the entry's per-axis delta scaled by 4 then
 * divided by 24 (the sub-pixel-per-tile factor). sub_0800CD88 classifies that
 * tile against the gIwram_35E0 entity coords (+0x18/+0x19); class 2 (blocked)
 * aborts the step for this entry, leaving only the stamp refreshed. Otherwise
 * the cursor sub-coords advance by the raw delta and each axis is clamped to
 * within +/-1 of entry.limit, then the stamp is refreshed.
 *
 * Shipped NAKED. The outer entry base is pinned in sl and the loop index is
 * carried byte-shifted in r8/r9 across the two __divsi3 calls and the
 * sub_0800CD88 call; agbcc 2.x will not hold these high registers live across
 * the call-bearing loop and instead recomputes the base from low registers,
 * so the high-reg save/restore frame and the `mov rN, sl` / `add r0, sl`
 * index forms can't be reproduced from pure C. This is the
 * docs/codegen-notes.md "High registers" (Class 1) unmatchable pattern; the
 * NON_MATCHING body documents intent for the phase-3 PC port. */

extern int __divsi3(int num, int den);

#ifdef NON_MATCHING
struct GridEntry {
    u8 _pad00[2];
    s16 limit; /* +2 */
    u8 _pad04[8];
    u32 stamp; /* +12 */
    s8 deltaX; /* +16 */
    s8 deltaY; /* +17 */
    u8 ageMax; /* +18 */
    u8 _pad13[7];
    u8 flags; /* +26 */
    u8 _pad1B[9];
};

void sub_08006E8C(struct GridEntry *entries, s8 first, s8 last)
{
    u32 tick = gGameStuff._unk00;
    s8 i;

    for (i = first; i <= last; i++) {
        struct GridEntry *e = &entries[i];

        if (tick - e->stamp <= e->ageMax)
            continue;

        if ((gIwram_35E0._field_10 & 2) != 0 && (e->flags & 2) != 0) {
            s16 tileX = __divsi3(gIwram_3720._field_2 + e->deltaX * 4, 24);
            s16 tileY = __divsi3(gIwram_3720._field_4 + e->deltaY * 4, 24);

            if ((u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, tileX, tileY) != 2) {
                gIwram_3720._field_2 += e->deltaX;
                gIwram_3720._field_4 += e->deltaY;

                if (e->deltaX != 0) {
                    if ((s16)gIwram_3720._field_4 > e->limit)
                        gIwram_3720._field_4--;
                    if ((s16)gIwram_3720._field_4 < e->limit)
                        gIwram_3720._field_4++;
                }

                if (entries[i].deltaY != 0) {
                    if (gIwram_3720._field_2 > entries[i].limit)
                        gIwram_3720._field_2--;
                    if (gIwram_3720._field_2 < entries[i].limit)
                        gIwram_3720._field_2++;
                }
            }
        }

        entries[i].stamp = tick;
    }
}
#else
NAKED void sub_08006E8C(void *entries, s8 first, s8 last)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    sub     sp, #8\n"
        "    mov     sl, r0\n"
        "    lsls    r2, r2, #24\n"
        "    ldr     r0, _pool_gGameStuff_6e8c\n"
        "    ldr     r0, [r0, #0]\n"
        "    str     r0, [sp, #4]\n"
        "    lsls    r1, r1, #24\n"
        "    lsrs    r1, r1, #24\n"
        "    mov     r9, r1\n"
        "    lsls    r1, r1, #24\n"
        "    lsrs    r0, r2, #24\n"
        "    str     r0, [sp, #0]\n"
        "    cmp     r1, r2\n"
        "    ble     _06eb4\n"
        "    b       _06fce\n"
        "_06eb4:\n"
        "    asrs    r0, r1, #24\n"
        "    lsls    r1, r0, #3\n"
        "    adds    r1, r1, r0\n"
        "    lsls    r1, r1, #2\n"
        "    mov     r2, sl\n"
        "    adds    r5, r1, r2\n"
        "    ldr     r0, [r5, #12]\n"
        "    ldr     r3, [sp, #4]\n"
        "    subs    r0, r3, r0\n"
        "    mov     r4, r9\n"
        "    lsls    r4, r4, #24\n"
        "    mov     r8, r4\n"
        "    ldrb    r1, [r5, #18]\n"
        "    cmp     r0, r1\n"
        "    bls     _06fb8\n"
        "    ldr     r7, _pool_gIwram35E0_6e8c\n"
        "    movs    r1, #2\n"
        "    adds    r0, r1, #0\n"
        "    ldrh    r2, [r7, #16]\n"
        "    ands    r0, r2\n"
        "    cmp     r0, #0\n"
        "    beq     _06fa8\n"
        "    adds    r0, r1, #0\n"
        "    ldrb    r3, [r5, #26]\n"
        "    ands    r0, r3\n"
        "    cmp     r0, #0\n"
        "    beq     _06fa8\n"
        "    ldr     r6, _pool_gIwram3720_6e8c\n"
        "    movs    r4, #2\n"
        "    ldrsh   r0, [r6, r4]\n"
        "    movs    r1, #16\n"
        "    ldrsb   r1, [r5, r1]\n"
        "    lsls    r1, r1, #2\n"
        "    adds    r0, r0, r1\n"
        "    movs    r1, #24\n"
        "    bl      __divsi3\n"
        "    adds    r4, r0, #0\n"
        "    lsls    r4, r4, #16\n"
        "    lsrs    r4, r4, #16\n"
        "    movs    r1, #4\n"
        "    ldrsh   r0, [r6, r1]\n"
        "    movs    r1, #17\n"
        "    ldrsb   r1, [r5, r1]\n"
        "    lsls    r1, r1, #2\n"
        "    adds    r0, r0, r1\n"
        "    movs    r1, #24\n"
        "    bl      __divsi3\n"
        "    adds    r3, r0, #0\n"
        "    ldrb    r0, [r7, #24]\n"
        "    ldrb    r1, [r7, #25]\n"
        "    lsls    r4, r4, #16\n"
        "    asrs    r4, r4, #16\n"
        "    lsls    r3, r3, #16\n"
        "    asrs    r3, r3, #16\n"
        "    adds    r2, r4, #0\n"
        "    bl      sub_0800CD88\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    cmp     r0, #2\n"
        "    beq     _06fa8\n"
        "    movs    r0, #16\n"
        "    ldrsb   r0, [r5, r0]\n"
        "    ldrh    r2, [r6, #2]\n"
        "    adds    r0, r2, r0\n"
        "    strh    r0, [r6, #2]\n"
        "    movs    r0, #17\n"
        "    ldrsb   r0, [r5, r0]\n"
        "    ldrh    r3, [r6, #4]\n"
        "    adds    r2, r3, r0\n"
        "    strh    r2, [r6, #4]\n"
        "    movs    r0, #16\n"
        "    ldrsb   r0, [r5, r0]\n"
        "    cmp     r0, #0\n"
        "    beq     _06f6c\n"
        "    lsls    r0, r2, #16\n"
        "    asrs    r0, r0, #16\n"
        "    movs    r4, #2\n"
        "    ldrsh   r1, [r5, r4]\n"
        "    cmp     r0, r1\n"
        "    ble     _06f5e\n"
        "    subs    r0, r2, #1\n"
        "    strh    r0, [r6, #4]\n"
        "_06f5e:\n"
        "    ldrh    r2, [r6, #4]\n"
        "    movs    r3, #4\n"
        "    ldrsh   r0, [r6, r3]\n"
        "    cmp     r0, r1\n"
        "    bge     _06f6c\n"
        "    adds    r0, r2, #1\n"
        "    strh    r0, [r6, #4]\n"
        "_06f6c:\n"
        "    mov     r4, r9\n"
        "    lsls    r2, r4, #24\n"
        "    asrs    r1, r2, #24\n"
        "    lsls    r0, r1, #3\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #2\n"
        "    mov     r3, sl\n"
        "    adds    r1, r0, r3\n"
        "    movs    r0, #17\n"
        "    ldrsb   r0, [r1, r0]\n"
        "    mov     r8, r2\n"
        "    cmp     r0, #0\n"
        "    beq     _06fa8\n"
        "    ldr     r3, _pool_gIwram3720_6e8c\n"
        "    ldrh    r2, [r3, #2]\n"
        "    movs    r4, #2\n"
        "    ldrsh   r0, [r3, r4]\n"
        "    movs    r4, #0\n"
        "    ldrsh   r1, [r1, r4]\n"
        "    cmp     r0, r1\n"
        "    ble     _06f9a\n"
        "    subs    r0, r2, #1\n"
        "    strh    r0, [r3, #2]\n"
        "_06f9a:\n"
        "    ldrh    r2, [r3, #2]\n"
        "    movs    r4, #2\n"
        "    ldrsh   r0, [r3, r4]\n"
        "    cmp     r0, r1\n"
        "    bge     _06fa8\n"
        "    adds    r0, r2, #1\n"
        "    strh    r0, [r3, #2]\n"
        "_06fa8:\n"
        "    mov     r0, r8\n"
        "    asrs    r1, r0, #24\n"
        "    lsls    r0, r1, #3\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #2\n"
        "    add     r0, sl\n"
        "    ldr     r1, [sp, #4]\n"
        "    str     r1, [r0, #12]\n"
        "_06fb8:\n"
        "    movs    r0, #128\n"
        "    lsls    r0, r0, #17\n"
        "    add     r0, r8\n"
        "    lsrs    r0, r0, #24\n"
        "    mov     r9, r0\n"
        "    lsls    r1, r0, #24\n"
        "    ldr     r2, [sp, #0]\n"
        "    lsls    r0, r2, #24\n"
        "    cmp     r1, r0\n"
        "    bgt     _06fce\n"
        "    b       _06eb4\n"
        "_06fce:\n"
        "    add     sp, #8\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_pool_gGameStuff_6e8c: .4byte 0x03005330\n"
        "_pool_gIwram35E0_6e8c: .4byte 0x030035e0\n"
        "_pool_gIwram3720_6e8c: .4byte 0x03003720\n"
        "    .syntax divided\n");
}
#endif

/* Sweeps the same 36-byte (0x24) entry array as the sub_08006D24/sub_08006E8C
 * neighbours over the inclusive index range [0, count), looking for an entry
 * that matches the active actor and, when found, raises its "engaged" bit.
 *
 * Bails out immediately (returns 0) if the gIwram_3720 dispatch halfword at
 * +0x34 has bit 0x04 set. Otherwise each entry's transient bit 0x02 at +26 is
 * cleared up front; entries whose bit 0x01 (at +26) is set are skipped. A
 * candidate must also match the active id (gIwram_3720[6] == entry[8]) and pass
 * sub_080076A4(&gIwram_3720, entry). A passing entry whose own state byte at +26
 * is > 3 additionally requires the gIwram_35E0 flags halfword at +0x10 to have
 * bit 0x10 set. The first fully-qualifying entry gets bit 0x02 raised on both
 * its +26 byte and the gIwram_35E0 +0x10 halfword, and the routine records a
 * hit (return value becomes 1) but keeps scanning the remaining entries.
 *
 * Shipped NAKED. The running hit-flag is pinned in r8 and the loop index is
 * carried byte-shifted in r9 across the sub_080076A4 call; agbcc 2.x will not
 * hold these high registers live across the call-bearing loop and instead
 * recomputes them from low registers, so the high-reg save/restore frame and
 * the `mov rN, r8/r9` index forms can't be reproduced from pure C. This is the
 * docs/codegen-notes.md "High registers" (Class 1) unmatchable pattern; the
 * NON_MATCHING body documents intent for the phase-3 PC port. */

extern u8 sub_080076A4(struct IwramAt3720 *actor, void *entry);

#ifdef NON_MATCHING
struct EngageEntry {
    u8 _pad00[6];
    u8 matchId; /* +8 */
    u8 _pad09[0x11];
    u8 state; /* +26: bit 0x01 = skip, bit 0x02 = engaged (raised here) */
};

u8 sub_08006FEC(struct EngageEntry *entries, s8 count)
{
    u8 hit = 0;
    s8 i;

    if ((gIwram_3720._field_34 & 4) != 0)
        return 0;

    for (i = 0; i < count; i++) {
        struct EngageEntry *e = &entries[i];

        e->state &= ~2;
        if ((e->state & 1) != 0)
            continue;

        if (((u8 *)&gIwram_3720)[6] != e->matchId)
            continue;

        if (!sub_080076A4(&gIwram_3720, e))
            continue;

        if (e->state > 3 && (gIwram_35E0._field_10 & 0x10) == 0)
            continue;

        e->state |= 2;
        gIwram_35E0._field_10 |= 2;
        hit = 1;
    }

    return hit;
}
#else
NAKED u8 sub_08006FEC(void *entries, s8 count)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    mov     sl, r0\n"
        "    lsls    r1, r1, #24\n"
        "    lsrs    r3, r1, #24\n"
        "    movs    r0, #0\n"
        "    mov     r8, r0\n"
        "    ldr     r1, _pool_gIwram3720_6fec\n"
        "    movs    r0, #4\n"
        "    ldrh    r1, [r1, #52]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _07014\n"
        "    movs    r0, #0\n"
        "    b       _0708a\n"
        "    .align  2, 0\n"
        "_pool_gIwram3720_6fec: .4byte 0x03003720\n"
        "_07014:\n"
        "    movs    r2, #0\n"
        "    lsls    r0, r3, #24\n"
        "    asrs    r1, r0, #24\n"
        "    mov     r9, r0\n"
        "    cmp     r8, r1\n"
        "    bge     _07088\n"
        "    ldr     r7, _pool_gIwram35E0_6fec\n"
        "_07022:\n"
        "    lsls    r2, r2, #24\n"
        "    asrs    r1, r2, #24\n"
        "    lsls    r0, r1, #3\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #2\n"
        "    mov     r1, sl\n"
        "    adds    r4, r0, r1\n"
        "    movs    r1, #253\n"
        "    ldrb    r0, [r4, #26]\n"
        "    ands    r1, r0\n"
        "    strb    r1, [r4, #26]\n"
        "    movs    r0, #1\n"
        "    ands    r1, r0\n"
        "    adds    r6, r2, #0\n"
        "    cmp     r1, #0\n"
        "    bne     _0707c\n"
        "    ldr     r5, _pool_gIwram35E0_6fec_b\n"
        "    ldrb    r1, [r5, #6]\n"
        "    ldrb    r0, [r4, #8]\n"
        "    cmp     r1, r0\n"
        "    bne     _0707c\n"
        "    adds    r0, r5, #0\n"
        "    adds    r1, r4, #0\n"
        "    bl      sub_080076A4\n"
        "    cmp     r0, #0\n"
        "    beq     _0707c\n"
        "    ldrb    r5, [r5, #26]\n"
        "    cmp     r5, #3\n"
        "    bls     _07068\n"
        "    movs    r0, #16\n"
        "    ldrh    r1, [r7, #16]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0707c\n"
        "_07068:\n"
        "    movs    r0, #2\n"
        "    ldrb    r1, [r4, #26]\n"
        "    orrs    r0, r1\n"
        "    strb    r0, [r4, #26]\n"
        "    movs    r0, #2\n"
        "    ldrh    r1, [r7, #16]\n"
        "    orrs    r0, r1\n"
        "    strh    r0, [r7, #16]\n"
        "    movs    r0, #1\n"
        "    mov     r8, r0\n"
        "_0707c:\n"
        "    movs    r1, #128\n"
        "    lsls    r1, r1, #17\n"
        "    adds    r0, r6, r1\n"
        "    lsrs    r2, r0, #24\n"
        "    cmp     r0, r9\n"
        "    blt     _07022\n"
        "_07088:\n"
        "    mov     r0, r8\n"
        "_0708a:\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r1}\n"
        "    bx      r1\n"
        "    .align  2, 0\n"
        "_pool_gIwram35E0_6fec: .4byte 0x030035e0\n"
        "_pool_gIwram35E0_6fec_b: .4byte 0x03003720\n"
        "    .syntax divided\n");
}
#endif
