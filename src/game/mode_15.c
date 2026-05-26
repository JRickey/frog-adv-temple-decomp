#include "game.h"
#include "macros.h"
#include "types.h"

/* sub_08002844 — per-frame handler for game-mode 15 (and re-entered for
 * mode 24 — the AgbMain dispatch maps mode 15 to this function, but the
 * function itself loops as long as gGameStuff.mode stays at 15 or 24).
 *
 * The function maintains a 1-byte sub-state on the stack (stored at
 * sp+1, here referred to as `localState`) and dispatches on it via a
 * computed jump through an inline 9-entry table. Cases 0..8 each
 * advance the sub-state, sometimes invoking subsystem callees and
 * setting gGameStuff.pendingMode / gGameStuff._unk14. After each case
 * the function re-checks gGameStuff.mode: if it's still 15 or 24 the
 * loop continues with another sub_08020BC0 (per-frame tick / VBlank
 * wait); otherwise control falls through to the epilogue.
 *
 * Sub-state purpose is not yet known. Hypothesis from the call pattern:
 *   0 -> initial entry; reads from `gIwram_5358`-ish keypad bits via
 *        sub_0800A104, decides if input was made, advances to 1.
 *   1 -> waiting for a confirmation gesture (sub_0800A104 with the
 *        0x08002A69-tagged callback table); on accept clears
 *        gGameStuff._unk14 and advances to 2.
 *   2 -> sub_08009D9C scan; on success advances to 3.
 *   3 -> calls sub_080004C4 (the boot-mode prober) and stashes its
 *        u16 in gIwram_5398; if the result is 0x40 advances to 5,
 *        else queries gIwram_3720 (key state) and either advances
 *        to 4 (sub_0800EF90) or 8 (sub_0800DE80) based on which
 *        bits are set.
 *   4 -> sub_08009C14 scan around the local state; on success advances
 *        to 7, then writes 0 to *(u8*)sp.
 *   5 -> re-runs sub_080004C4 + sub_0800E6A8; on the latter returning
 *        0 advances to 6 (with the byte at sp updated to 0). Then
 *        consults gIwram_5328 — if set, breaks out; else snaps the
 *        sub-state back to 3.
 *   6 -> consumes the sp-byte counter via sub_08010694 / sub_080106B8,
 *        and on a specific (1, 0) outcome programs gIwram_3480 = 4 and
 *        gGameStuff.mode = 4 (return to the boot dispatcher).
 *   7 -> alternative path through sub_0800A104 (with the
 *        0x0800A26D-tagged callback table) and sub_0800A1C8.
 *   8 -> sub_0800DE80 cleanup.
 *
 * Shipped as NAKED inline asm + NON_MATCHING reference C. The dispatch
 * uses `mov pc, r0` after a jumpTable[idx]-indexed `ldr`, which agbcc
 * cannot emit from a C switch — same class as AgbMain's mode
 * dispatcher (see src/system/agb_main.c and docs/codegen-notes.md). The
 * NON_MATCHING body documents structure for the phase-3 PC port.
 */

extern void sub_08020BC0(void);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern u8 sub_08009D9C(u8 *localState);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800EF90(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern u32 sub_08009C14(u8 *localState);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u16 gIwram_3720_keysHeld; /* halfword at gIwram_3720+0x34 */
extern u16 gIwram_6110_keysJust; /* halfword at gIwram_6110+0x2e */
extern u8 gIwram_5328;
extern u8 gIwram_3480_data0;

#ifdef NON_MATCHING

/* Reference body — readable shape for the phase-3 PC port. Doesn't
 * compile to the same bytes; the NAKED form below is what matches. */
void sub_08002844(void)
{
    u8 localState;

    localState = 0;
    if (gGameStuff.mode != 15 && gGameStuff.mode != 24)
        return;

    do {
        sub_08020BC0(); /* per-frame tick / VBlank wait */
        if (localState > 8)
            goto tail;

        switch (localState) {
        case 0:
            gGameStuff.pendingMode = 8;
            localState = 1;
            /* clears sp-byte to 0 (already 0) */
            break;
        case 1:
            if (sub_0800A104(&localState, 0x08002A69) == 0) {
                sub_080008DC();
                goto tail;
            }
            localState = 2;
            gGameStuff._unk14 = 0;
            /* clears sp-byte */
            sub_080008DC();
            goto tail;
        case 2:
            if (sub_08009D9C(&localState) == 0)
                goto tail;
            localState = 3;
            gGameStuff._unk14 = 0;
            /* clears sp-byte */
            break;
        case 3:
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                localState = 5;
                sub_0800E060();
                break;
            }
            if ((gIwram_3720_keysHeld & 8) != 0) {
                localState = 4;
                sub_0800EF90();
                break;
            }
            if ((gIwram_6110_keysJust & 8) != 0) {
                localState = 8;
                break;
            }
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
            sub_080094F8();
            sub_08009984();
            gGameStuff._unk14++;
            break;
        case 4:
            if (sub_08009C14(&localState) != 0)
                localState = 7;
            /* clears sp-byte */
            break;
        case 5:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                localState = 6;
                /* sets sp-byte to 0 */
            }
            if (gIwram_5328 == 0)
                localState = 3;
            break;
        case 6: {
            s32 spCounter;
            if ((s8) * (u8 *)&localState != 0) {
                /* The sp-byte tracks something the prior case set up;
                 * bump it through sub_08010694(0xBF) on first entry. */
                sub_08010694(0xBF);
                /* increment sp-byte */
            }
            spCounter = *(s8 *)&localState;
            if (spCounter != 1)
                break;
            if (sub_080106B8() != 0)
                break;
            gIwram_3480_data0 = 4;
            /* gIwram_3480+6 = 0 (the spCounter at the moment of decision) */
            gGameStuff.mode = 4;
            break;
        }
        case 7:
            if (sub_0800A104(&localState, 0x0800A26D) != 0) {
                localState = 2;
                gGameStuff._unk14 = 0;
                /* clears sp-byte */
                sub_0800A1C8();
            }
            sub_080008DC();
            break;
        case 8:
            sub_0800DE80();
            break;
        }

    tail:;
    } while (gGameStuff.mode == 15 || gGameStuff.mode == 24);
}

#else

/* NAKED form — matches the baserom byte-for-byte. The inline jump
 * table at _sub_08002844_jumpTable is consumed by `mov pc, r0` and so
 * MUST end up at the exact relative offset agbcc would have placed it
 * (right after the literal pool that follows the table-index load).
 * The .syntax-divided trailer is mandatory — see docs/codegen-notes.md
 * ".syntax unified bleed".
 */
NAKED
void sub_08002844(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, lr}\n"
        "    sub     sp, #4\n"
        "    mov     r0, sp\n"
        "    adds    r0, #1\n"
        "    movs    r1, #0\n"
        "    strb    r1, [r0, #0]\n"
        "    ldr     r1, _sub_08002844_pool_gGameStuff_1\n"
        "    ldrb    r1, [r1, #9]\n"
        "    adds    r5, r0, #0\n"
        "    cmp     r1, #15\n"
        "    beq     _sub_08002844_loopHead\n"
        "    cmp     r1, #24\n"
        "    beq     _sub_08002844_loopHead\n"
        "    b       _sub_08002844_epilogue\n"
        "_sub_08002844_loopHead:\n"
        "    bl      sub_08020BC0\n"
        "    ldrb    r0, [r5, #0]\n"
        "    cmp     r0, #8\n"
        "    bls     _sub_08002844_dispatch\n"
        "    b       _sub_08002844_tail\n"
        "_sub_08002844_dispatch:\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, _sub_08002844_pool_jumpTablePtr\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .hword  0\n"
        "_sub_08002844_pool_gGameStuff_1:   .4byte 0x03005330\n"
        "_sub_08002844_pool_jumpTablePtr:   .4byte _sub_08002844_jumpTable\n"
        "_sub_08002844_jumpTable:\n"
        "    .4byte _sub_08002844_case0\n"
        "    .4byte _sub_08002844_case1\n"
        "    .4byte _sub_08002844_case2\n"
        "    .4byte _sub_08002844_case3\n"
        "    .4byte _sub_08002844_case4\n"
        "    .4byte _sub_08002844_case5\n"
        "    .4byte _sub_08002844_case6\n"
        "    .4byte _sub_08002844_case7\n"
        "    .4byte _sub_08002844_case8\n"
        "_sub_08002844_case0:\n"
        "    ldr     r1, _sub_08002844_pool_gGameStuff_case0\n"
        "    movs    r2, #0\n"
        "    movs    r0, #8\n"
        "    strb    r0, [r1, #10]\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r5, #0]\n"
        "    mov     r0, sp\n"
        "    strb    r2, [r0, #0]\n"
        "    b       _sub_08002844_tail\n"
        "    .hword  0\n"
        "_sub_08002844_pool_gGameStuff_case0: .4byte 0x03005330\n"
        "_sub_08002844_case1:\n"
        "    ldr     r1, _sub_08002844_pool_callback_2a69\n"
        "    mov     r0, sp\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002844_case1_accept\n"
        "    b       _sub_08002844_tail_with_finalize\n"
        "_sub_08002844_case1_accept:\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r5, #0]\n"
        "    ldr     r0, _sub_08002844_pool_gGameStuff_case1\n"
        "    movs    r1, #0\n"
        "    str     r1, [r0, #20]\n"
        "    mov     r0, sp\n"
        "    strb    r1, [r0, #0]\n"
        "    b       _sub_08002844_tail_with_finalize\n"
        "_sub_08002844_pool_callback_2a69:    .4byte 0x08002A69\n"
        "_sub_08002844_pool_gGameStuff_case1: .4byte 0x03005330\n"
        "_sub_08002844_case2:\n"
        "    mov     r0, sp\n"
        "    bl      sub_08009D9C\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002844_case2_accept\n"
        "    b       _sub_08002844_tail\n"
        "_sub_08002844_case2_accept:\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r5, #0]\n"
        "    ldr     r0, _sub_08002844_pool_gGameStuff_case2\n"
        "    movs    r1, #0\n"
        "    str     r1, [r0, #20]\n"
        "    mov     r0, sp\n"
        "    strb    r1, [r0, #0]\n"
        "    b       _sub_08002844_tail\n"
        "_sub_08002844_pool_gGameStuff_case2: .4byte 0x03005330\n"
        "_sub_08002844_case3:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08002844_pool_iwram5398_case3\n"
        "    strh    r0, [r1, #0]\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #0x40\n"
        "    bne     _sub_08002844_case3_not40\n"
        "    movs    r0, #5\n"
        "    strb    r0, [r5, #0]\n"
        "    bl      sub_0800E060\n"
        "    b       _sub_08002844_tail\n"
        "    .hword  0\n"
        "_sub_08002844_pool_iwram5398_case3:  .4byte 0x03005398\n"
        "_sub_08002844_case3_not40:\n"
        "    ldr     r1, _sub_08002844_pool_iwram3720_case3\n"
        "    movs    r3, #8\n"
        "    movs    r2, #8\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x34]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08002844_case3_not_held\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r5, #0]\n"
        "    bl      sub_0800EF90\n"
        "    b       _sub_08002844_tail\n"
        "    .hword  0\n"
        "_sub_08002844_pool_iwram3720_case3:  .4byte 0x03003720\n"
        "_sub_08002844_case3_not_held:\n"
        "    ldr     r1, _sub_08002844_pool_iwram6110_case3\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x2e]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08002844_case3_fallthrough\n"
        "    strb    r3, [r5, #0]\n"
        "    b       _sub_08002844_tail\n"
        "_sub_08002844_pool_iwram6110_case3:  .4byte 0x03006110\n"
        "_sub_08002844_case3_fallthrough:\n"
        "    bl      sub_0800A2D8\n"
        "    bl      sub_080008DC\n"
        "    bl      sub_0800A328\n"
        "    bl      sub_080094F8\n"
        "    bl      sub_08009984\n"
        "    ldr     r1, _sub_08002844_pool_gGameStuff_case3\n"
        "    ldr     r0, [r1, #20]\n"
        "    adds    r0, #1\n"
        "    str     r0, [r1, #20]\n"
        "    b       _sub_08002844_tail\n"
        "    .hword  0\n"
        "_sub_08002844_pool_gGameStuff_case3: .4byte 0x03005330\n"
        "_sub_08002844_case4:\n"
        "    adds    r0, r5, #0\n"
        "    bl      sub_08009C14\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002844_case4_advance\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r5, #0]\n"
        "_sub_08002844_case4_advance:\n"
        "    mov     r1, sp\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08002844_tail\n"
        "_sub_08002844_case5:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08002844_pool_iwram5398_case5\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_0800E6A8\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r1, r0, #24\n"
        "    cmp     r1, #0\n"
        "    bne     _sub_08002844_case5_no_advance\n"
        "    movs    r0, #6\n"
        "    strb    r0, [r5, #0]\n"
        "    mov     r0, sp\n"
        "    strb    r1, [r0, #0]\n"
        "_sub_08002844_case5_no_advance:\n"
        "    ldr     r0, _sub_08002844_pool_iwram5328_case5\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002844_tail\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r5, #0]\n"
        "    b       _sub_08002844_tail\n"
        "_sub_08002844_pool_iwram5398_case5:  .4byte 0x03005398\n"
        "_sub_08002844_pool_iwram5328_case5:  .4byte 0x03005328\n"
        "_sub_08002844_case6:\n"
        "    mov     r0, sp\n"
        "    ldrb    r0, [r0, #0]\n"
        "    lsls    r0, r0, #24\n"
        "    asrs    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002844_case6_check\n"
        "    movs    r0, #0xBF\n"
        "    bl      sub_08010694\n"
        "    mov     r0, sp\n"
        "    mov     r1, sp\n"
        "    ldrb    r1, [r1, #0]\n"
        "    adds    r1, #1\n"
        "    strb    r1, [r0, #0]\n"
        "_sub_08002844_case6_check:\n"
        "    mov     r0, sp\n"
        "    movs    r4, #0\n"
        "    ldrsb   r4, [r0, r4]\n"
        "    cmp     r4, #1\n"
        "    bne     _sub_08002844_tail\n"
        "    bl      sub_080106B8\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002844_tail\n"
        "    ldr     r0, _sub_08002844_pool_iwram3480_case6\n"
        "    movs    r1, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    strb    r4, [r0, #6]\n"
        "    ldr     r0, _sub_08002844_pool_gGameStuff_case6\n"
        "    strb    r1, [r0, #9]\n"
        "    b       _sub_08002844_tail\n"
        "    .hword  0\n"
        "_sub_08002844_pool_iwram3480_case6:  .4byte 0x03003480\n"
        "_sub_08002844_pool_gGameStuff_case6: .4byte 0x03005330\n"
        "_sub_08002844_case7:\n"
        "    ldr     r1, _sub_08002844_pool_callback_a26d\n"
        "    mov     r0, sp\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08002844_tail_with_finalize\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r5, #0]\n"
        "    ldr     r0, _sub_08002844_pool_gGameStuff_case7\n"
        "    movs    r1, #0\n"
        "    str     r1, [r0, #20]\n"
        "    mov     r0, sp\n"
        "    strb    r1, [r0, #0]\n"
        "    bl      sub_0800A1C8\n"
        "_sub_08002844_tail_with_finalize:\n"
        "    bl      sub_080008DC\n"
        "    b       _sub_08002844_tail\n"
        "    .hword  0\n"
        "_sub_08002844_pool_callback_a26d:    .4byte 0x0800A26D\n"
        "_sub_08002844_pool_gGameStuff_case7: .4byte 0x03005330\n"
        "_sub_08002844_case8:\n"
        "    bl      sub_0800DE80\n"
        "_sub_08002844_tail:\n"
        "    ldr     r0, _sub_08002844_pool_gGameStuff_tail\n"
        "    ldrb    r0, [r0, #9]\n"
        "    cmp     r0, #15\n"
        "    bne     _sub_08002844_tail_not15\n"
        "    b       _sub_08002844_loopHead\n"
        "_sub_08002844_tail_not15:\n"
        "    cmp     r0, #24\n"
        "    bne     _sub_08002844_epilogue\n"
        "    b       _sub_08002844_loopHead\n"
        "_sub_08002844_epilogue:\n"
        "    add     sp, #4\n"
        "    pop     {r4, r5}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "_sub_08002844_pool_gGameStuff_tail:  .4byte 0x03005330\n"
        "    .syntax divided\n");
}

#endif
