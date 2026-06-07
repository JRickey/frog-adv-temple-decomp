#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Bit-set leaf on a u16 field at offset 16. Companion to the bit-clear
 * EntityRec_ClearKeyFlags (offset 0x2e in src/game/EntityRec_ClearKeyFlags.c), called from
 * Player_UpdateTileCache when the entity's tile-cache key changes (raises bit 0x40
 * on the dirty-flags halfword at gIwram_35E0+0x10). */

void PlayerFlags_Set(void *p, u16 mask)
{
    *(u16 *)((u8 *)p + 16) |= mask;
}

/* Bit-clear companion to PlayerFlags_Set - same u16 field at offset 16. Like the
 * matched sibling EntityRec_ClearKeyFlags (offset 0x2e), this whole TU is built with
 * OLD_AGBCC_BIN (see the Makefile per-TU override): old_agbcc keeps the
 * redundant `adds r1, r2, #0` move that recolours the BIC result into r1
 * before `strh r1` (newer agbcc coalesces it away to the 2-byte-shorter
 * `strh r2`). */

void IwramFlags_Clear(void *p, u16 mask)
{
    *(u16 *)((u8 *)p + 16) &= ~mask;
}

/* Bool predicate companion: tests the same u16 dirty-flags field as
 * PlayerFlags_Set/IwramFlags_Clear (offset 16) against mask. Must test the nonzero
 * case first (`!= 0 -> return 1`) so old_agbcc emits the baserom's `bne`
 * fall-through with the return-1 block trailing the return-0 block; phrasing
 * it as `== 0 -> return 0` flips the branch to `beq` and reorders the blocks. */

u8 IsFlagMaskSet(void *p, u16 mask)
{
    if ((*(u16 *)((u8 *)p + 16) & mask) != 0)
        return 1;
    return 0;
}

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
 * The NON_MATCHING branch is the current regular-C candidate. It has the right
 * stack-frame family and several key register-coloring fixes, but the asm
 * fallback stays active until the remaining low-register allocation drift is
 * matched.
 */

#ifdef NON_MATCHING

struct BB4Frame {
    struct SrcRec s;
    s32 i;
};

#define gPartTable_080C0AB0 ((const struct PartEntry *)0x080C0AB0)

void EntityScript_BuildSlotData(u8 partId, u8 *out)
{
    register u8 *outCopy asm("r2");
    u8 *dst;
    register u8 partTmp asm("r3");
    register s32 iCheck asm("r4");
    register struct SrcRec *scratch asm("r5");
    register const u8 *recordPtrsTmp asm("r7");
    register const struct PartEntry *table asm("r8");
    register const struct PartEntry *tableBase asm("r9");
    register const u8 *recordPtrs asm("sl");
    register u32 part asm("ip");
    register s32 partShift asm("r1");
    struct BB4Frame frame;
    s32 count;
    u8 countByte;

    outCopy = out;
    part = (u8)partId;
    frame.i = 0;
    table = gPartTable_080C0AB0;
    partTmp = part;
    partShift = partTmp << 24;
    countByte = *(u8 *)((partShift >> 21) + (u32)table);
    count = (s8)countByte;
    iCheck = *(volatile s32 *)((u8 *)&frame.s + sizeof(struct SrcRec));
    if (iCheck < count) {

        tableBase = table;
        recordPtrsTmp = (const u8 *)4;
        recordPtrsTmp += (u32)table;
        recordPtrs = recordPtrsTmp;
        scratch = &frame.s;
        dst = outCopy;

        do {
            const struct PartEntry *entry;
            const struct SrcRec *records = *(const struct SrcRec **)(recordPtrs + (partShift >> 21));
            *scratch = records[frame.i];

            *(s16 *)(dst + 0) = scratch->_h0;
            *(s16 *)(dst + 2) = scratch->_h2;

            if (scratch->_b6 <= 1) {
                *(s16 *)(dst + 4) = scratch->_b4 * 24 - 12;
                *(s16 *)(dst + 6) = scratch->_b5 * 24 + 12;
            } else {
                *(s16 *)(dst + 4) = scratch->_b4 * 24 + 12;
                *(s16 *)(dst + 6) = scratch->_b5 * 24 - 12;
            }

            dst[18] = scratch->_b8;
            dst[24] = scratch->_b9;
            dst[26] = 0;
            dst[28] = (u8)(scratch->_b4 * scratch->_b5);
            *(u32 *)(dst + 32) = scratch->_w12;
            entry = (const struct PartEntry *)((partShift >> 21) + (u32)tableBase);
            dst[8] = entry->_b1;

            switch (scratch->_b6) {
            case 0:
                dst[25] = (entry->count > 1) ? scratch->_b6 : 18;
                dst[16] = 0;
                dst[17] = (u8)(-scratch->_b7);
                break;
            case 1:
                dst[25] = (entry->count > 1) ? 12 : 20;
                dst[16] = 0;
                dst[17] = scratch->_b7;
                break;
            case 2:
                dst[25] = (entry->count > 1) ? 24 : 21;
                dst[17] = 0;
                dst[16] = (u8)(-scratch->_b7);
                break;
            case 3:
                dst[25] = (entry->count > 1) ? 36 : 23;
                dst[17] = 0;
                dst[16] = scratch->_b7;
                break;
            default:
                break;
            }

            dst += 0x24;
            frame.i++;
        } while (frame.i < *(s8 *)((partShift >> 21) + (u32)table));
    }
}
#else
NAKED void EntityScript_BuildSlotData(u8 partId, u8 *out)
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
 * the pointer stored at +32 — classifying every tile via Tilemap_GetTileClass and,
 * for class 8 with the cell's flag byte at +17 clear, enqueueing it through
 * BlitFrameCell (kinds 4/3 keyed on which tri-step encoding the sub-record
 * uses). The cell's last-stamp is refreshed to the current tick afterward.
 *
 * The NON_MATCHING branch is the current regular-C candidate. It matches the
 * 44-byte frame and most high-register state, but the asm fallback stays active
 * until the remaining scheduling and register-allocation drift is resolved. */

extern u8 Tilemap_GetTileClass(u8 col, u8 row, s32 tileX, s32 tileY);
extern void BlitFrameCell(u32 frameArg, u32 rowsArg, u32 colsArg, u32 dstXArg, u32 dstYArg, u32 bankArg, u32 cellArg);

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

struct D24Frame {
    s32 last;
    u32 counter;
    u32 tick;
    s32 cellOff;
    u32 flag;
    s32 next;
    s32 iTimes8;
    s32 rowByte;
};

void Entity_TickCells(struct Cell *cells, s32 first, s32 last, u8 arg3)
{
    register struct Cell *base asm("sl");
    register s32 i asm("r9");
    volatile struct D24Frame frame;
    u32 flagArg;
    s32 iTimes8;
    s32 off;
    u32 rowLocal;

    base = cells;
    frame.last = last;
    flagArg = (u8)arg3;
    frame.tick = gGameStuff._unk00;
    i = first;
    if (i > last)
        return;
    frame.flag = flagArg;

    do {
        struct Cell *cell;
        s32 j;
        u32 delta;

        iTimes8 = i << 3;
        off = (iTimes8 + i) << 2;
        cell = (struct Cell *)(off + (u32)base);
        delta = frame.tick - cell->lastStamp;
        frame.iTimes8 = iTimes8;
        frame.next = i + 1;

        if (delta <= cell->threshold)
            goto next_cell;

        frame.counter = cell->counter;
        cell->counter++;
        if ((cell->counter & 3) == 0)
            cell->counter -= 4;

        j = 0;
        if (j >= cell->count)
            goto stamp_cell;
        frame.cellOff = off;

        {
            register struct Cell *cellReg asm("r6") = cell;
            register s32 recOff asm("r8") = 0;

            do {
                const s16 *rec;
                s32 sub = frame.counter;
                s32 col;
                s32 row;

                if (cellReg->count > 1) {
                    if (j == cellReg->count - 1) {
                        sub = (u8)(frame.counter + 8);
                    } else if (j > 0) {
                        sub = (u8)(frame.counter + 4);
                    }
                }

                cell = (struct Cell *)(frame.cellOff + (u32)base);
                rec = (const s16 *)((u32)cell->records + recOff);
                col = rec[0];
                row = (s16)(rec[1] + 1);
                rowLocal = gIwram_35E0._field_19;
                frame.rowByte = rowLocal;
                if ((u8)Tilemap_GetTileClass(gIwram_35E0._field_18, rowLocal, col, row) == 8 &&
                    *(s8 *)((u8 *)cell + 0x11) == 0) {
                    rec = (const s16 *)((u32)cell->records + recOff);
                    BlitFrameCell(1, 4, 3, (u16)(rec[0] * 3), (u16)(rec[1] * 3), frame.flag, sub);
                } else {
                    rec = (const s16 *)((u32)cellReg->records + recOff);
                    BlitFrameCell(1, 3, 3, (u16)(rec[0] * 3), (u16)(rec[1] * 3), frame.flag, sub);
                }

                recOff += 4;
                j++;
            } while (j < cellReg->count);
        }

    stamp_cell:
        cell = (struct Cell *)(((frame.iTimes8 + i) << 2) + (u32)base);
        cell->lastStamp = frame.tick;
    next_cell:
        i = frame.next;
    } while (i <= frame.last);
}
#else
NAKED void Entity_TickCells(void *cells, s32 first, s32 last, u8 arg3)
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
        "    bl      Tilemap_GetTileClass\n"
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
        "    bl      BlitFrameCell\n"
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
        "    bl      BlitFrameCell\n"
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
 * divided by 24 (the sub-pixel-per-tile factor). Tilemap_GetTileClass classifies that
 * tile against the gIwram_35E0 entity coords (+0x18/+0x19); class 2 (blocked)
 * aborts the step for this entry, leaving only the stamp refreshed. Otherwise
 * the cursor sub-coords advance by the raw delta and each axis is clamped to
 * within +/-1 of entry.limit, then the stamp is refreshed.
 *
 * This regular-C body matches. The explicit byte-offset entry expression keeps
 * the same pointer arithmetic as the baserom, and the deltaY clamp intentionally
 * uses the entry's +0 halfword limit. */

extern int __divsi3(int num, int den);

#if 1
struct GridEntry {
    s16 limitX; /* +0 */
    s16 limit;  /* +2 */
    u8 _pad04[8];
    u32 stamp; /* +12 */
    s8 deltaX; /* +16 */
    s8 deltaY; /* +17 */
    u8 ageMax; /* +18 */
    u8 _pad13[7];
    u8 flags; /* +26 */
    u8 _pad1B[9];
};

void Entity_ApplyGridMovement(struct GridEntry *entries, s8 first, s8 last)
{
    u32 tick = gGameStuff._unk00;
    s8 i;

    for (i = first; i <= last; i++) {
        struct GridEntry *e = (struct GridEntry *)((i * sizeof(struct GridEntry)) + (u32)entries);

        if (tick - e->stamp <= e->ageMax)
            continue;

        if ((gIwram_35E0._field_10 & 2) != 0 && (e->flags & 2) != 0) {
            s16 tileX = __divsi3(gEntities[0].x + e->deltaX * 4, 24);
            s16 tileY = __divsi3(gEntities[0].y + e->deltaY * 4, 24);

            if ((u8)Tilemap_GetTileClass(gIwram_35E0._field_18, gIwram_35E0._field_19, tileX, tileY) != 2) {
                gEntities[0].x += e->deltaX;
                gEntities[0].y += e->deltaY;

                if (e->deltaX != 0) {
                    if ((s16)gEntities[0].y > e->limit)
                        gEntities[0].y--;
                    if ((s16)gEntities[0].y < e->limit)
                        gEntities[0].y++;
                }

                if (entries[i].deltaY != 0) {
                    if (gEntities[0].x > entries[i].limitX)
                        gEntities[0].x--;
                    if (gEntities[0].x < entries[i].limitX)
                        gEntities[0].x++;
                }
            }
        }

        entries[i].stamp = tick;
    }
}
#else
NAKED void Entity_ApplyGridMovement(void *entries, s8 first, s8 last)
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
        "    bl      Tilemap_GetTileClass\n"
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

/* Sweeps the same 36-byte (0x24) entry array as the Entity_TickCells/Entity_ApplyGridMovement
 * neighbours over the index range [0, count), looking for an entry that matches
 * the active actor and, when found, raises its "engaged" bit.
 *
 * Bails out immediately (returns 0) if the gIwram_3720 dispatch halfword at
 * +0x34 has bit 0x04 set. Otherwise each entry's transient bit 0x02 at +26 is
 * cleared up front; entries whose bit 0x01 (at +26) is set are skipped. A
 * candidate must also match the active id (gIwram_3720+6 == entry+8) and pass
 * Rect_PointInCenterRect(gEntities, entry). A passing entry additionally requires, when
 * the gIwram_3720 dispatch state at +0x1A is > 3, that the gIwram_35E0 flags
 * halfword at +0x10 have bit 0x10 set. Every fully-qualifying entry gets bit
 * 0x02 raised on both its +26 byte and the gIwram_35E0 +0x10 halfword, and the
 * routine records a hit (return value becomes 1) while scanning the rest. */

extern s32 Rect_PointInCenterRect(struct Entity *actor, void *entry);

struct EngageEntry {
    u8 _pad00[8];
    u8 matchId; /* +8 */
    u8 _pad09[0x11];
    u8 state;       /* +26: bit 0x01 = skip, bit 0x02 = engaged (raised here) */
    u8 _pad1B[0x9]; /* +27..+0x23: pad to 36-byte (0x24) stride */
};

u8 Entity_CheckEngage(struct EngageEntry *entries, s8 count)
{
    u8 hit = 0;
    s8 i;

    if ((gEntities[0].status & 4) != 0)
        return 0;

    for (i = 0; i < count; i++) {
        /* index-first cast (offset + (s32)base, not &entries[i]) forces the
         * baserom's `adds r4, r0, r1` operand order; the pointer-arithmetic
         * form canonicalises to `adds r4, r1, r0` and is the only byte off. */
        struct EngageEntry *e = (struct EngageEntry *)(i * sizeof(struct EngageEntry) + (s32)entries);

        e->state &= ~2;
        if ((e->state & 1) != 0)
            continue;

        if (gEntities[0].actorId != e->matchId)
            continue;

        if (!Rect_PointInCenterRect(gEntities, e))
            continue;

        if (gEntities[0].state > 3 && (gIwram_35E0._field_10 & 0x10) == 0)
            continue;

        e->state |= 2;
        gIwram_35E0._field_10 |= 2;
        hit = 1;
    }

    return hit;
}

/* --- Entity_ApplyScrollStep: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
struct ScrollStepEntry {
    u16 subX; /* +0x00 */
    u16 subY; /* +0x02 */
    u8 _pad04[8];
    u32 stamp; /* +0x0C */
    s8 deltaX; /* +0x10 */
    s8 deltaY; /* +0x11 */
    u8 ageMax; /* +0x12 */
    u8 _pad13[7];
    u8 flags; /* +0x1A */
    u8 _pad1B[9];
};

void Entity_ApplyScrollStep(struct ScrollStepEntry *entries, s32 first, s32 last)
{
    register GameStuff *game asm("r8");
    struct ScrollStepEntry *entry;
    u16 active;
    s32 i;
    register s32 mask asm("r9");

    if (gGameStuff._unk00 - entries[first].stamp < entries[first].ageMax)
        return;

    game = &gGameStuff;

    i = first;
    if (i > last)
        return;

    active = (u16)(gIwram_35E0._field_10 & 2); /* literal &2 keeps base in r2 */
    mask = 2;                                  /* assigned AFTER active, pinned r9 */

    entry = &entries[first];
    do {
        s8 dy = entry->deltaY; /* TAIL A: this lowers to ldrb+sext, not indexed ldrsb */
        s8 dx = entry->deltaX;

        entry->subX += dx;
        entry->subY += dy;

        if (active != 0 && (entry->flags & mask) != 0) {
            gEntities[0].x += dx;
            gEntities[0].y += dy;
        }

        entry->stamp = game->_unk00;
        entry++;
        i++;
    } while (i <= last);
}
#endif /* NON_MATCHING */
