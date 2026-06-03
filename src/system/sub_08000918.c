#include "game.h"
#include "macros.h"
#include "types.h"

/* sub_08000918 — per-frame handler for game-mode 8 (and re-entered for
 * mode 24 — the AgbMain dispatch maps mode 8 to this function, but the
 * function itself loops as long as gGameStuff.mode stays at 8 or 24).
 *
 * Sibling of sub_08002844 (mode 15) and the rest of the mode-X cluster
 * (sub_08000EB8, sub_08001508, AgbMain). Maintains a 1-byte sub-state on
 * the stack (here `localState`, at sp+0x29) plus a second scratch byte at
 * sp+0x28, and dispatches on the sub-state through an inline 14-entry
 * `.word` jump table consumed by `mov pc, r0`. Cases 0..8 each advance the
 * sub-state, invoking subsystem callees and setting gGameStuff fields;
 * cases 9..12 are no-ops (fall straight to the tail) and case 13 runs the
 * sub_08000D50 cleanup. After each case the function re-checks
 * gGameStuff.mode: if it's still 8 or 24 it loops back through
 * sub_08020BC0 (per-frame tick / VBlank wait); otherwise it returns.
 *
 * Shipped as NAKED inline asm + NON_MATCHING reference C. This is the
 * corpus-validated "mode-X cluster" unmatchable class (docs/codegen-notes.md
 * "mov pc, rN jump tables" / "Iter-38 research interlude"): cross-corpus
 * search of 17+ agbcc decomps found 58 `mov pc, rN` sites, 100% inside NAKED
 * functions, ZERO matched from a pure-C switch. The block here additionally
 * pins &localState in a callee-saved register (r6) across every inner BL and
 * enters the loop via fallthrough-into-case-0 — both unreachable from agbcc
 * 2.x C source. The NON_MATCHING body documents structure for the phase-3
 * PC port. The .syntax-divided trailer is mandatory (docs/codegen-notes.md
 * ".syntax unified bleed").
 */

extern void sub_08020BC0(void);
extern void sub_08000C98(u32 a, u32 b);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern u8 sub_08009D9C(u8 *localState);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_08006948(u8 *rec, u16 mask);
extern u8 sub_08009BA0(void);
extern void sub_0800E600(u8 arg);
extern void sub_08000CEC(u32 a, u32 b);
extern void sub_0800EF90(void);
extern void sub_08000D2C(u8 *state, u32 a, u32 b);
extern u8 sub_0800FD50(void);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_080008DC(void);
extern void sub_08000D50(void);

extern u16 gIwram_5398;
extern u16 gIwram_3720_keysHeld; /* halfword at gIwram_3720+0x34 */
extern u16 gIwram_6110_keysJust; /* halfword at gIwram_6110+0x2e */
extern u8 gIwram_5328;
extern u8 gIwram_3480_data0;

#ifdef NON_MATCHING

/* Reference body — readable shape for the phase-3 PC port. Doesn't
 * compile to the same bytes; the NAKED form below is what matches. */
void sub_08000918(void)
{
    u8 localState;
    u8 spByte;

    spByte = 0;
    localState = 0;
    if (gGameStuff.mode != GAME_MODE_SCENE_08 && gGameStuff.mode != GAME_MODE_ATTRACT)
        return;

    do {
        sub_08020BC0(); /* per-frame tick / VBlank wait */
        if (localState > 13)
            goto tail;

        switch (localState) {
        case 0:
            sub_08000C98((u32)&spByte, 0x08000CB1);
            localState = 1;
            spByte = 0;
            goto tail;
        case 1:
            if (sub_0800A104(&spByte, 0x08000CB1) == 0)
                goto finalize;
            localState = 2;
            gGameStuff._unk14 = 0;
            spByte = 0;
            goto finalize;
        case 2:
            if (sub_08009D9C(&spByte) == 0)
                goto tail;
            localState = 3;
            gGameStuff._unk14 = 0;
            goto tail;
        case 3:
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                localState = 6;
                sub_0800E060();
                goto tail;
            }
            if ((gIwram_3720_keysHeld & 8) != 0) {
                localState = 4;
                goto tail;
            }
            if ((gIwram_6110_keysJust & 2) != 0) {
                sub_08006948(&gIwram_6110_keysJust, 2);
                sub_0800E600((u8)(sub_08009BA0() - 1));
                localState = 5;
                goto tail;
            }
            if ((gIwram_6110_keysJust & 8) != 0) {
                sub_08006948(&gIwram_6110_keysJust, 8);
                localState = 13;
                goto tail;
            }
            sub_08000CEC((u32)&spByte, 0x08000CB1);
            goto tail;
        case 4:
            sub_0800EF90();
            sub_08000D2C(&localState, (u32)&spByte, 0x08000CB1);
            spByte = 0;
            goto tail;
        case 5:
            gIwram_5398 = sub_080004C4();
            if (sub_0800FD50() != 0)
                goto tail;
            localState = 3;
            sub_08006948(&gIwram_6110_keysJust, 2);
            goto tail;
        case 6:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                sub_0800EF90();
                localState = 7;
                spByte = 0;
            }
            if (gIwram_5328 != 0)
                goto tail;
            localState = 3;
            goto tail;
        case 7:
            if ((s8)spByte == 0) {
                sub_08010694(0xBF);
                spByte++;
            }
            if ((s8)spByte != 1)
                goto tail;
            if (sub_080106B8() != 0)
                goto tail;
            gIwram_3480_data0 = 4;
            (&gIwram_3480_data0)[6] = 0;
            gGameStuff.mode = GAME_MODE_ROUTER;
            goto tail;
        case 8:
            if (sub_0800A104(&spByte, 0x0800A26D) == 0)
                goto finalize;
            localState = 2;
            gGameStuff._unk14 = 0;
            sub_0800A1C8();
            spByte = 0;
        finalize:
            sub_080008DC();
            goto tail;
        case 13:
            sub_08000D50();
            break;
        }

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_08 || gGameStuff.mode == GAME_MODE_ATTRACT);
}

#else

NAKED
void sub_08000918(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, lr}\n"
        "    sub     sp, #0x34\n"
        "    mov     r0, sp\n"
        "    adds    r0, #0x29\n"
        "    movs    r1, #0\n"
        "    strb    r1, [r0, #0]\n"
        "    ldr     r1, _sub_08000918_pool_gGameStuff_1\n"
        "    ldrb    r1, [r1, #9]\n"
        "    adds    r6, r0, #0\n"
        "    cmp     r1, #8\n"
        "    beq     _sub_08000918_loopHead\n"
        "    cmp     r1, #24\n"
        "    beq     _sub_08000918_loopHead\n"
        "    b       _sub_08000918_epilogue\n"
        "_sub_08000918_loopHead:\n"
        "    bl      sub_08020BC0\n"
        "    ldrb    r0, [r6, #0]\n"
        "    cmp     r0, #0xD\n"
        "    bls     _sub_08000918_dispatch\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_dispatch:\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, _sub_08000918_pool_jumpTablePtr\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .hword  0\n"
        "_sub_08000918_pool_gGameStuff_1:    .4byte 0x03005330\n"
        "_sub_08000918_pool_jumpTablePtr:    .4byte _sub_08000918_jumpTable\n"
        "_sub_08000918_jumpTable:\n"
        "    .4byte _sub_08000918_case0\n"
        "    .4byte _sub_08000918_case1\n"
        "    .4byte _sub_08000918_case2\n"
        "    .4byte _sub_08000918_case3\n"
        "    .4byte _sub_08000918_case4\n"
        "    .4byte _sub_08000918_case5\n"
        "    .4byte _sub_08000918_case6\n"
        "    .4byte _sub_08000918_case7\n"
        "    .4byte _sub_08000918_case8\n"
        "    .4byte _sub_08000918_tail\n"
        "    .4byte _sub_08000918_tail\n"
        "    .4byte _sub_08000918_tail\n"
        "    .4byte _sub_08000918_tail\n"
        "    .4byte _sub_08000918_case13\n"
        "_sub_08000918_case0:\n"
        "    add     r1, sp, #0x2C\n"
        "    mov     r0, sp\n"
        "    bl      sub_08000C98\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r6, #0]\n"
        "    add     r1, sp, #0x28\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_case1:\n"
        "    add     r4, sp, #0x28\n"
        "    ldr     r1, _sub_08000918_pool_callback_cb1\n"
        "    adds    r0, r4, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_case1_accept\n"
        "    b       _sub_08000918_case8_finalize\n"
        "_sub_08000918_case1_accept:\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r1, _sub_08000918_pool_gGameStuff_case1\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #0x14]\n"
        "    strb    r0, [r4, #0]\n"
        "    b       _sub_08000918_case8_finalize\n"
        "_sub_08000918_pool_callback_cb1:     .4byte 0x08000CB1\n"
        "_sub_08000918_pool_gGameStuff_case1: .4byte 0x03005330\n"
        "_sub_08000918_case2:\n"
        "    add     r0, sp, #0x28\n"
        "    bl      sub_08009D9C\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_case2_accept\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_case2_accept:\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r1, _sub_08000918_pool_gGameStuff_case2\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #0x14]\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_pool_gGameStuff_case2: .4byte 0x03005330\n"
        "_sub_08000918_case3:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08000918_pool_iwram5398_case3\n"
        "    strh    r0, [r1, #0]\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #0x40\n"
        "    bne     _sub_08000918_case3_not40\n"
        "    movs    r0, #6\n"
        "    strb    r0, [r6, #0]\n"
        "    bl      sub_0800E060\n"
        "    b       _sub_08000918_tail\n"
        "    .hword  0\n"
        "_sub_08000918_pool_iwram5398_case3:  .4byte 0x03005398\n"
        "_sub_08000918_case3_not40:\n"
        "    ldr     r1, _sub_08000918_pool_iwram3720_case3\n"
        "    movs    r3, #8\n"
        "    adds    r0, r3, #0\n"
        "    ldrh    r1, [r1, #0x34]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000918_case3_not_held\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_pool_iwram3720_case3:  .4byte 0x03003720\n"
        "_sub_08000918_case3_not_held:\n"
        "    ldr     r2, _sub_08000918_pool_iwram6110_case3\n"
        "    ldrh    r1, [r2, #0x2e]\n"
        "    movs    r0, #2\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000918_case3_not_just2\n"
        "    adds    r0, r2, #0\n"
        "    movs    r1, #2\n"
        "    bl      sub_08006948\n"
        "    bl      sub_08009BA0\n"
        "    subs    r0, #1\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    bl      sub_0800E600\n"
        "    movs    r0, #5\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_pool_iwram6110_case3:  .4byte 0x03006110\n"
        "_sub_08000918_case3_not_just2:\n"
        "    adds    r0, r3, #0\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000918_case3_fallthrough\n"
        "    adds    r0, r2, #0\n"
        "    movs    r1, #8\n"
        "    bl      sub_08006948\n"
        "    movs    r0, #0xD\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_case3_fallthrough:\n"
        "    add     r1, sp, #0x2C\n"
        "    mov     r0, sp\n"
        "    bl      sub_08000CEC\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_case4:\n"
        "    bl      sub_0800EF90\n"
        "    add     r2, sp, #0x2C\n"
        "    adds    r0, r6, #0\n"
        "    mov     r1, sp\n"
        "    bl      sub_08000D2C\n"
        "    add     r1, sp, #0x28\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_case5:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08000918_pool_iwram5398_case5\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_0800FD50\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_tail\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r0, _sub_08000918_pool_iwram6110_case5\n"
        "    movs    r1, #2\n"
        "    bl      sub_08006948\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_pool_iwram5398_case5:  .4byte 0x03005398\n"
        "_sub_08000918_pool_iwram6110_case5:  .4byte 0x03006110\n"
        "_sub_08000918_case6:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08000918_pool_iwram5398_case6\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_0800E6A8\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r4, r0, #24\n"
        "    cmp     r4, #0\n"
        "    bne     _sub_08000918_case6_check\n"
        "    bl      sub_0800EF90\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r6, #0]\n"
        "    add     r0, sp, #0x28\n"
        "    strb    r4, [r0, #0]\n"
        "_sub_08000918_case6_check:\n"
        "    ldr     r0, _sub_08000918_pool_iwram5328_case6\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_tail\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08000918_tail\n"
        "    .hword  0\n"
        "_sub_08000918_pool_iwram5398_case6:  .4byte 0x03005398\n"
        "_sub_08000918_pool_iwram5328_case6:  .4byte 0x03005328\n"
        "_sub_08000918_case7:\n"
        "    add     r4, sp, #0x28\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_case7_check\n"
        "    movs    r0, #0xBF\n"
        "    bl      sub_08010694\n"
        "    ldrb    r0, [r4, #0]\n"
        "    adds    r0, #1\n"
        "    strb    r0, [r4, #0]\n"
        "_sub_08000918_case7_check:\n"
        "    ldrb    r4, [r4, #0]\n"
        "    lsls    r4, r4, #24\n"
        "    asrs    r4, r4, #24\n"
        "    cmp     r4, #1\n"
        "    bne     _sub_08000918_tail\n"
        "    bl      sub_080106B8\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_tail\n"
        "    ldr     r0, _sub_08000918_pool_iwram3480_case7\n"
        "    movs    r1, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    strb    r4, [r0, #6]\n"
        "    ldr     r0, _sub_08000918_pool_gGameStuff_case7\n"
        "    strb    r1, [r0, #9]\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_pool_iwram3480_case7:  .4byte 0x03003480\n"
        "_sub_08000918_pool_gGameStuff_case7: .4byte 0x03005330\n"
        "_sub_08000918_case8:\n"
        "    add     r5, sp, #0x28\n"
        "    ldr     r1, _sub_08000918_pool_callback_a26d\n"
        "    adds    r0, r5, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000918_case8_finalize\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r0, _sub_08000918_pool_gGameStuff_case8\n"
        "    movs    r4, #0\n"
        "    str     r4, [r0, #0x14]\n"
        "    bl      sub_0800A1C8\n"
        "    strb    r4, [r5, #0]\n"
        "_sub_08000918_case8_finalize:\n"
        "    bl      sub_080008DC\n"
        "    b       _sub_08000918_tail\n"
        "    .hword  0\n"
        "_sub_08000918_pool_callback_a26d:    .4byte 0x0800A26D\n"
        "_sub_08000918_pool_gGameStuff_case8: .4byte 0x03005330\n"
        "_sub_08000918_case13:\n"
        "    bl      sub_08000D50\n"
        "_sub_08000918_tail:\n"
        "    ldr     r0, _sub_08000918_pool_gGameStuff_tail\n"
        "    ldrb    r0, [r0, #9]\n"
        "    cmp     r0, #8\n"
        "    bne     _sub_08000918_tail_not8\n"
        "    b       _sub_08000918_loopHead\n"
        "_sub_08000918_tail_not8:\n"
        "    cmp     r0, #24\n"
        "    bne     _sub_08000918_epilogue\n"
        "    b       _sub_08000918_loopHead\n"
        "_sub_08000918_epilogue:\n"
        "    add     sp, #0x34\n"
        "    pop     {r4, r5, r6}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "_sub_08000918_pool_gGameStuff_tail:  .4byte 0x03005330\n"
        "    .syntax divided\n");
}

#endif
