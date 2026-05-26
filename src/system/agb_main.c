#include "game.h"
#include "gba/io.h"
#include "macros.h"
#include "types.h"

/* AgbMain — the master game-loop dispatcher. Entered from _start at
 * 0x080000ec via the Thumb pointer stored at 0x08000230.
 *
 * Structure:
 *   prologue:  REG_WAITCNT = 0x4014, bl Init1 (sub_08000430),
 *              gGameStuff.mode = 4, then fall into the loop.
 *   loopHead:  bl Init2 (sub_08020BC0)  -- per-frame tick / VBlank wait.
 *              Reload gGameStuff.mode, compute idx = mode - 4.
 *              If idx > 25 -> tail. Else mov pc, jumpTable[idx].
 *   case bodies (modes 4..29):
 *     - Mode 4 is substantial: runs sub_080004C4 (storing its u16 result at
 *       0x03005398 / gIwram_5398), then sub_08019500, then dispatches on
 *       gIwram_3480._data[5] to set gGameStuff.mode = {5, 6, 7, 24}.
 *     - Modes 5..27 each call one mode-specific handler then jump to the
 *       shared tail.
 *     - Mode 29 is unique: reads gIwram_3540._data[0] as an arg for
 *       sub_0801A268, then falls into the shared tail.
 *     - Mode 28 *is* the shared tail (bl sub_080008DC; b.n loopHead).
 *
 * Shipped as NAKED inline asm + NON_MATCHING reference C.
 *
 * The computed jump (`mov pc, r0` after table lookup) cannot be expressed
 * in agbcc-emitted C; the only way to match the dispatcher shape exactly
 * is to ship the asm directly. The NON_MATCHING reference body documents
 * the dispatch table for the phase-3 PC port, where the computed jump
 * becomes a normal `switch` statement.
 *
 * The case-body branch-back-to-loopHead arrangement is unusual:
 * every body — including mode 28 / shared tail — branches to the BL Init2
 * at the loop head, NOT to the mode read. That means Init2 runs once per
 * frame for every dispatched mode, consistent with it being a VBlank-wait
 * or per-frame tick.
 */

/* All 29 callees. The bodies all live as peeled .s slices today (auto-peeled
 * before this file landed). Declared `extern` rather than via a header
 * because none of them are subsystem-classified yet — they get headers when
 * they get C decomps. */
extern void sub_08000430(void);   /* Init1 */
extern u16 sub_080004C4(void);    /* boot helper — returns u16 stored at gIwram_5398 */
extern void sub_08000918(void);   /* mode 8 handler */
extern void sub_080008DC(void);   /* shared per-frame finalize (tail) */
extern void sub_08000EB8(void);   /* mode 9 */
extern void sub_08001214(void);   /* mode 10 */
extern void sub_08001508(void);   /* mode 11 */
extern void sub_080019B4(void);   /* mode 12 */
extern void sub_08002184(void);   /* mode 13 */
extern void sub_08002524(void);   /* mode 14 */
extern void sub_08002844(void);   /* mode 15 */
extern void sub_08002B58(void);   /* mode 16 */
extern void sub_0800336C(void);   /* mode 17 */
extern void sub_08003864(void);   /* mode 18 */
extern void sub_08003CA8(void);   /* mode 19 */
extern void sub_0800411C(void);   /* mode 20 */
extern void sub_08004938(void);   /* mode 21 */
extern void sub_08004FAC(void);   /* mode 22 */
extern void sub_080054A8(void);   /* mode 23 */
extern void sub_0801793C(void);   /* mode 24 */
extern void sub_08019500(void);   /* boot helper, second call */
extern void sub_08019540(void);   /* mode 26 */
extern void sub_08019560(void);   /* mode 25 */
extern void sub_0801A268(u8 arg); /* mode 29 */
extern void sub_080201A8(void);   /* mode 6 */
extern void sub_080201C8(void);   /* mode 7 */
extern void sub_080201E8(void);   /* mode 27 */
extern void sub_080202A8(void);   /* mode 5 */
extern void sub_08020BC0(void);   /* Init2 / per-frame tick */

/* The two IWRAM bases AgbMain itself touches that aren't already declared
 * in include/iwram.h:
 *   0x03005398 — stash slot for sub_080004C4's u16 return value (boot only)
 *   0x03003540 — single-byte arg passed to sub_0801A268 in mode 29
 *
 * Declared inline rather than promoted to iwram.h until their owners are
 * named. */
extern u16 gIwram_5398;
extern u8 gIwram_3540;

#ifdef NON_MATCHING

/* Reference body — readable shape for the phase-3 PC port. Doesn't compile
 * to the same bytes; the NAKED form below is what matters at link time. */
void AgbMain(void)
{
    REG_WAITCNT = 0x4014;
    sub_08000430(); /* Init1 */
    gGameStuff.mode = 4;

    for (;;) {
        sub_08020BC0(); /* per-frame tick / VBlank wait */
        switch (gGameStuff.mode) {
        case 4: {
            gIwram_5398 = sub_080004C4();
            sub_08019500();
            /* Read gIwram_3480._data[5] twice in baserom — the second load
             * is used for the {3, 2, 4} compares. */
            if (gIwram_3480._data[5] == 1)
                gGameStuff.mode = 5;
            if (gIwram_3480._data[5] == 3)
                gGameStuff.mode = 7;
            if (gIwram_3480._data[5] == 2)
                gGameStuff.mode = 6;
            if (gIwram_3480._data[5] == 4)
                gGameStuff.mode = 24;
            break;
        }
        case 5:
            sub_080202A8();
            break;
        case 6:
            sub_080201A8();
            break;
        case 7:
            sub_080201C8();
            break;
        case 8:
            sub_08000918();
            break;
        case 9:
            sub_08000EB8();
            break;
        case 10:
            sub_08001214();
            break;
        case 11:
            sub_08001508();
            break;
        case 12:
            sub_080019B4();
            break;
        case 13:
            sub_08002184();
            break;
        case 14:
            sub_08002524();
            break;
        case 15:
            sub_08002844();
            break;
        case 16:
            sub_08002B58();
            break;
        case 17:
            sub_0800336C();
            break;
        case 18:
            sub_08003864();
            break;
        case 19:
            sub_08003CA8();
            break;
        case 20:
            sub_0800411C();
            break;
        case 21:
            sub_08004938();
            break;
        case 22:
            sub_08004FAC();
            break;
        case 23:
            sub_080054A8();
            break;
        case 24:
            sub_0801793C();
            break;
        case 25:
            sub_08019560();
            break;
        case 26:
            sub_08019540();
            break;
        case 27:
            sub_080201E8();
            break;
        case 28: /* shared-tail fallthrough — no per-mode handler */
            break;
        case 29:
            sub_0801A268(gIwram_3540);
            break;
        default:
            break; /* mode out of range -> straight to tail */
        }
        sub_080008DC(); /* per-frame finalize */
    }
}

#else

/* NAKED form — matches the baserom byte-for-byte. The jump table at
 * _AgbMain_jumpTable is consumed by `mov pc, r0` and so MUST end up at the
 * exact relative offset agbcc would have placed it (between the literal
 * pool and the case bodies). The .syntax-divided trailer is mandatory —
 * see docs/codegen-notes.md ".syntax unified bleed". */
NAKED
void AgbMain(void)
{
    asm(".syntax unified\n"
        "    push    {lr}\n"
        "    ldr     r1, _AgbMain_reg204\n"
        "    ldr     r2, _AgbMain_const4014\n"
        "    adds    r0, r2, #0\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_08000430\n"
        "    ldr     r1, _AgbMain_gGameStuff\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r1, #9]\n"
        "_AgbMain_loopHead:\n"
        "    bl      sub_08020BC0\n"
        "    ldr     r0, _AgbMain_gGameStuff\n"
        "    ldrb    r0, [r0, #9]\n"
        "    subs    r0, #4\n"
        "    cmp     r0, #25\n"
        "    bls     _AgbMain_dispatch\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_dispatch:\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, _AgbMain_jumpTablePtr\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .hword  0\n"
        "_AgbMain_reg204:     .4byte 0x04000204\n"
        "_AgbMain_const4014:  .4byte 0x00004014\n"
        "_AgbMain_gGameStuff: .4byte 0x03005330\n"
        "_AgbMain_jumpTablePtr: .4byte _AgbMain_jumpTable\n"
        "_AgbMain_jumpTable:\n"
        "    .4byte _AgbMain_case_mode04\n"
        "    .4byte _AgbMain_case_mode05\n"
        "    .4byte _AgbMain_case_mode06\n"
        "    .4byte _AgbMain_case_mode07\n"
        "    .4byte _AgbMain_case_mode08\n"
        "    .4byte _AgbMain_case_mode09\n"
        "    .4byte _AgbMain_case_mode10\n"
        "    .4byte _AgbMain_case_mode11\n"
        "    .4byte _AgbMain_case_mode12\n"
        "    .4byte _AgbMain_case_mode13\n"
        "    .4byte _AgbMain_case_mode14\n"
        "    .4byte _AgbMain_case_mode15\n"
        "    .4byte _AgbMain_case_mode16\n"
        "    .4byte _AgbMain_case_mode17\n"
        "    .4byte _AgbMain_case_mode18\n"
        "    .4byte _AgbMain_case_mode19\n"
        "    .4byte _AgbMain_case_mode20\n"
        "    .4byte _AgbMain_case_mode21\n"
        "    .4byte _AgbMain_case_mode22\n"
        "    .4byte _AgbMain_case_mode23\n"
        "    .4byte _AgbMain_case_mode24\n"
        "    .4byte _AgbMain_case_mode25\n"
        "    .4byte _AgbMain_case_mode26\n"
        "    .4byte _AgbMain_case_mode27\n"
        "    .4byte _AgbMain_case_mode28\n"
        "    .4byte _AgbMain_case_mode29\n"
        "_AgbMain_case_mode04:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _AgbMain_iwram5398\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_08019500\n"
        "    ldr     r2, _AgbMain_iwram3480\n"
        "    ldrb    r0, [r2, #5]\n"
        "    cmp     r0, #1\n"
        "    bne     _AgbMain_mode04_not1\n"
        "    ldr     r1, _AgbMain_gGameStuff_mode04\n"
        "    movs    r0, #5\n"
        "    strb    r0, [r1, #9]\n"
        "_AgbMain_mode04_not1:\n"
        "    ldrb    r2, [r2, #5]\n"
        "    cmp     r2, #3\n"
        "    bne     _AgbMain_mode04_not3\n"
        "    ldr     r1, _AgbMain_gGameStuff_mode04\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r1, #9]\n"
        "_AgbMain_mode04_not3:\n"
        "    cmp     r2, #2\n"
        "    bne     _AgbMain_mode04_not2\n"
        "    ldr     r1, _AgbMain_gGameStuff_mode04\n"
        "    movs    r0, #6\n"
        "    strb    r0, [r1, #9]\n"
        "_AgbMain_mode04_not2:\n"
        "    cmp     r2, #4\n"
        "    bne     _AgbMain_tail\n"
        "    ldr     r1, _AgbMain_gGameStuff_mode04\n"
        "    movs    r0, #24\n"
        "    strb    r0, [r1, #9]\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_iwram5398:        .4byte 0x03005398\n"
        "_AgbMain_iwram3480:        .4byte 0x03003480\n"
        "_AgbMain_gGameStuff_mode04: .4byte 0x03005330\n"
        "_AgbMain_case_mode24:\n"
        "    bl      sub_0801793C\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode08:\n"
        "    bl      sub_08000918\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode09:\n"
        "    bl      sub_08000EB8\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode10:\n"
        "    bl      sub_08001214\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode11:\n"
        "    bl      sub_08001508\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode12:\n"
        "    bl      sub_080019B4\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode13:\n"
        "    bl      sub_08002184\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode14:\n"
        "    bl      sub_08002524\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode15:\n"
        "    bl      sub_08002844\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode16:\n"
        "    bl      sub_08002B58\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode17:\n"
        "    bl      sub_0800336C\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode18:\n"
        "    bl      sub_08003864\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode19:\n"
        "    bl      sub_08003CA8\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode20:\n"
        "    bl      sub_0800411C\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode21:\n"
        "    bl      sub_08004938\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode22:\n"
        "    bl      sub_08004FAC\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode23:\n"
        "    bl      sub_080054A8\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode25:\n"
        "    bl      sub_08019560\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode07:\n"
        "    bl      sub_080201C8\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode06:\n"
        "    bl      sub_080201A8\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode26:\n"
        "    bl      sub_08019540\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode27:\n"
        "    bl      sub_080201E8\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode05:\n"
        "    bl      sub_080202A8\n"
        "    b       _AgbMain_tail\n"
        "_AgbMain_case_mode29:\n"
        "    ldr     r0, _AgbMain_iwram3540\n"
        "    ldrb    r0, [r0, #0]\n"
        "    bl      sub_0801A268\n"
        "_AgbMain_case_mode28:\n"
        "_AgbMain_tail:\n"
        "    bl      sub_080008DC\n"
        "    b       _AgbMain_loopHead\n"
        "_AgbMain_iwram3540: .4byte 0x03003540\n"
        "    .syntax divided\n");
}

#endif
