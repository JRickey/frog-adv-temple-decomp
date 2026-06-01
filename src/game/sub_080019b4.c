#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_080019B4 — per-frame handler for game-mode 12 (and re-entered for
 * mode 24; AgbMain dispatches mode 12 here, and the function loops as long
 * as gGameStuff.mode stays at 12 or 24).
 *
 * Class-sibling of sub_08000EB8 (mode 9), sub_08001508 (mode 11) and
 * sub_08002844 (mode 15) — the same 9-case jump-table state machine
 * (`mov pc, r0` over a 9-entry inline `.4byte` table) wrapped in a
 * gGameStuff.mode-gated do/while. Stack frame is 0x4D4 (1236) bytes here:
 * the per-frame object handed to sub_0800B7B0/sub_080018F8 lives at
 * sp+0x4cc, the dispatch state byte at sp+0x4c9, plus larger scratch
 * regions at sp+0x438 and sp+0x4c8.
 *
 * Sub-state behaviour (dispatch byte at sp+0x4c9):
 *   0 -> gGameStuff.pendingMode = 5; sub_08006BB4(0, sp_obj);
 *        sub_0800B7B0(sp+0x438, &r4_obj, 5); spByte = 1; sp[+0x4c8] = 0.
 *   1 -> sub_0800A104(&sp[+0x4c8], 0x08001d19); on accept -> spByte = 2,
 *        gGameStuff._unk14 = 0, sp[+0x4c8] = 0; both paths join the shared
 *        finalize (sub_080008DC) and tail.
 *   2 -> sub_08009D9C(&sp[+0x4c8]); on success spByte = 3,
 *        gGameStuff._unk14 = 0; then sub_08007660(0, sp_obj); tail.
 *   3 -> gIwram_5398 = sub_080004C4(); if == 0x40 -> spByte = 5 +
 *        sub_0800E060; else if (gIwram_3720._field_34 & 8) -> spByte = 4 +
 *        sub_0800EF90; else if (gIwram_6110.inputFlags & 8) -> spByte = 8;
 *        else the fallthrough: sub_08007660, sub_0800A2D8, sub_080008DC,
 *        sub_0800A328, sub_080094F8, sub_08009984, sub_080018F8(sp+0x438,
 *        &r4_obj), gGameStuff._unk14++.
 *   4 -> sub_08009C14(&sp[+0x4c8]); on reject sp[+0x4c9] = 7;
 *        sub_0800B7B0(sp+0x438, &r4_obj, 5); then keys off
 *        (s8)gIwram_35E0._field_5: <= 1 sets gIwram_6110 idx {8,9}=0;
 *        == 2 sets {8,9}=1; == 3 sets {8,9}=1; sp[+0x4c8] = 0; tail.
 *   5 -> gIwram_5398 = sub_080004C4(); sub_0800E6A8(); if zero spByte = 6,
 *        sp[+0x4c8] = 0; gates on gIwram_5328 — if non-zero tail, else
 *        spByte = 3.
 *   6 -> sp[+0x4c8] (s8): if 0 sub_08010694(0xBF) + increment; require
 *        (s8) == 1; sub_080106B8() must return 0; gIwram_3480._data[0] = 4,
 *        gIwram_3480[+6] = 0; gGameStuff.mode = 4.
 *   7 -> sub_0800A104(&sp[+0x4c8], 0x0800a26d); on accept spByte = 2,
 *        gGameStuff._unk14 = 0, sp[+0x4c8] = 0, sub_0800A1C8(); both paths
 *        join the shared finalize (sub_080008DC) and tail.
 *   8 -> sub_0800DE80(); tail.
 *
 * Shipped NAKED + NON_MATCHING. This is the mode-X dispatcher cluster
 * documented in docs/codegen-notes.md "mov pc, rN jump tables" and the
 * iter-38 research interlude: the cluster (sub_08000918, sub_08000EB8,
 * sub_08001508, sub_08002844, AgbMain) is corpus-validated unmatchable in
 * pure C — not because of the dispatcher core (agbcc *can* lower a dense
 * u8 switch to mov-pc-rN), but because of three downstream structural
 * choices it carries: a cross-call register pin (r4/r5 hold sp+offset
 * bases kept live across the inner BLs), per-context pool-literal
 * placement, and a fallthrough-into-case-0 loop entry. 58 `mov pc, rN`
 * hits across 17+ agbcc decomps, 100% inside NAKED, ZERO matched as a
 * pure-C switch. sub_080019B4 carries the same r4/r5 cross-call pin
 * (sp+0x438 / sp+0x4cc) plus the negative `add sp, r4` frame setup, so it
 * is the same class.
 *
 * The reference summary above documents intent for the phase-3 PC port;
 * the NAKED form below is what compiles byte-identical to baserom. */

extern void sub_08020BC0(void);
extern void sub_08006BB4(u32 arg0, void *obj);
extern void sub_0800B7B0(void *buf, void *r4_obj, u32 kind);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern u8 sub_08009D9C(u8 *localState);
extern void sub_08007660(u32 arg0, void *obj);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800EF90(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_080018F8(void *buf, void *r4_obj);
extern u32 sub_08009C14(void *p);
extern void sub_080066C4(u32 base, u32 idx, u32 val);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_0800DE80(void);

/* NAKED form — matches the baserom byte-for-byte. The inline jump table at
 * _sub_080019B4_jumpTable is consumed by `mov pc, r0` and MUST land at the
 * exact relative offset agbcc placed it (immediately after the literal
 * pool that follows the table-index load). The .syntax-divided trailer is
 * mandatory — see docs/codegen-notes.md ".syntax unified bleed". */
NAKED
void sub_080019B4(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, lr}\n"
        "    ldr     r4, _sub_080019B4_pool_frame\n"
        "    add     sp, r4\n"
        "    ldr     r0, _sub_080019B4_pool_off4c9_a\n"
        "    add     r0, sp\n"
        "    movs    r1, #0\n"
        "    strb    r1, [r0, #0]\n"
        "    b       _sub_080019B4_tail\n"
        "_sub_080019B4_pool_frame:    .4byte 0xfffffb2c\n"
        "_sub_080019B4_pool_off4c9_a: .4byte 0x000004c9\n"
        "_sub_080019B4_loopHead:\n"
        "    bl      sub_08020BC0\n"
        "    ldr     r0, _sub_080019B4_pool_off4c9_b\n"
        "    add     r0, sp\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #8\n"
        "    bls     _sub_080019B4_dispatch\n"
        "    b       _sub_080019B4_tail\n"
        "_sub_080019B4_dispatch:\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, _sub_080019B4_pool_jumpTablePtr\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .hword  0\n"
        "_sub_080019B4_pool_off4c9_b:     .4byte 0x000004c9\n"
        "_sub_080019B4_pool_jumpTablePtr: .4byte _sub_080019B4_jumpTable\n"
        "_sub_080019B4_jumpTable:\n"
        "    .4byte _sub_080019B4_case0\n"
        "    .4byte _sub_080019B4_case1\n"
        "    .4byte _sub_080019B4_case2\n"
        "    .4byte _sub_080019B4_case3\n"
        "    .4byte _sub_080019B4_case4\n"
        "    .4byte _sub_080019B4_case5\n"
        "    .4byte _sub_080019B4_case6\n"
        "    .4byte _sub_080019B4_case7\n"
        "    .4byte _sub_080019B4_case8\n"
        "_sub_080019B4_case0:\n"
        "    ldr     r4, _sub_080019B4_pool_off4cc_a\n"
        "    add     r4, sp\n"
        "    ldr     r1, _sub_080019B4_pool_gGameStuff_case0\n"
        "    movs    r5, #0\n"
        "    movs    r0, #5\n"
        "    strb    r0, [r1, #10]\n"
        "    movs    r0, #0\n"
        "    mov     r1, sp\n"
        "    bl      sub_08006BB4\n"
        "    movs    r0, #0x87\n"
        "    lsls    r0, r0, #3\n"
        "    add     r0, sp\n"
        "    adds    r1, r4, #0\n"
        "    movs    r2, #5\n"
        "    bl      sub_0800B7B0\n"
        "    ldr     r1, _sub_080019B4_pool_off4c9_case0\n"
        "    add     r1, sp\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r1, #0]\n"
        "    movs    r0, #0x99\n"
        "    lsls    r0, r0, #3\n"
        "    add     r0, sp\n"
        "    strb    r5, [r0, #0]\n"
        "    b       _sub_080019B4_tail\n"
        "_sub_080019B4_pool_off4cc_a:         .4byte 0x000004cc\n"
        "_sub_080019B4_pool_gGameStuff_case0: .4byte 0x03005330\n"
        "_sub_080019B4_pool_off4c9_case0:     .4byte 0x000004c9\n"
        "_sub_080019B4_case1:\n"
        "    movs    r4, #0x99\n"
        "    lsls    r4, r4, #3\n"
        "    add     r4, sp\n"
        "    ldr     r1, _sub_080019B4_pool_callback_1d19\n"
        "    adds    r0, r4, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_080019B4_case1_accept\n"
        "    b       _sub_080019B4_finalize\n"
        "_sub_080019B4_case1_accept:\n"
        "    ldr     r1, _sub_080019B4_pool_off4c9_case1\n"
        "    add     r1, sp\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r1, #0]\n"
        "    ldr     r1, _sub_080019B4_pool_gGameStuff_case1\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    strb    r0, [r4, #0]\n"
        "    b       _sub_080019B4_finalize\n"
        "_sub_080019B4_pool_callback_1d19:    .4byte 0x08001d19\n"
        "_sub_080019B4_pool_off4c9_case1:     .4byte 0x000004c9\n"
        "_sub_080019B4_pool_gGameStuff_case1: .4byte 0x03005330\n"
        "_sub_080019B4_case2:\n"
        "    movs    r0, #0x99\n"
        "    lsls    r0, r0, #3\n"
        "    add     r0, sp\n"
        "    bl      sub_08009D9C\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_080019B4_case2_join\n"
        "    ldr     r1, _sub_080019B4_pool_off4c9_case2\n"
        "    add     r1, sp\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r1, #0]\n"
        "    ldr     r1, _sub_080019B4_pool_gGameStuff_case2\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "_sub_080019B4_case2_join:\n"
        "    movs    r0, #0\n"
        "    mov     r1, sp\n"
        "    bl      sub_08007660\n"
        "    b       _sub_080019B4_tail\n"
        "    .hword  0\n"
        "_sub_080019B4_pool_off4c9_case2:     .4byte 0x000004c9\n"
        "_sub_080019B4_pool_gGameStuff_case2: .4byte 0x03005330\n"
        "_sub_080019B4_case3:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_080019B4_pool_iwram5398_case3\n"
        "    strh    r0, [r1, #0]\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #0x40\n"
        "    bne     _sub_080019B4_case3_not40\n"
        "    ldr     r1, _sub_080019B4_pool_off4c9_case3a\n"
        "    add     r1, sp\n"
        "    movs    r0, #5\n"
        "    strb    r0, [r1, #0]\n"
        "    bl      sub_0800E060\n"
        "    b       _sub_080019B4_tail\n"
        "    .hword  0\n"
        "_sub_080019B4_pool_iwram5398_case3: .4byte 0x03005398\n"
        "_sub_080019B4_pool_off4c9_case3a:   .4byte 0x000004c9\n"
        "_sub_080019B4_case3_not40:\n"
        "    ldr     r1, _sub_080019B4_pool_iwram3720_case3\n"
        "    movs    r3, #8\n"
        "    movs    r2, #8\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x34]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_080019B4_case3_not_held\n"
        "    ldr     r1, _sub_080019B4_pool_off4c9_case3b\n"
        "    add     r1, sp\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r1, #0]\n"
        "    bl      sub_0800EF90\n"
        "    b       _sub_080019B4_tail\n"
        "    .hword  0\n"
        "_sub_080019B4_pool_iwram3720_case3: .4byte 0x03003720\n"
        "_sub_080019B4_pool_off4c9_case3b:   .4byte 0x000004c9\n"
        "_sub_080019B4_case3_not_held:\n"
        "    ldr     r1, _sub_080019B4_pool_iwram6110_case3\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x2e]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_080019B4_case3_fallthrough\n"
        "    ldr     r0, _sub_080019B4_pool_off4c9_case3c\n"
        "    add     r0, sp\n"
        "    strb    r3, [r0, #0]\n"
        "    b       _sub_080019B4_tail\n"
        "_sub_080019B4_pool_iwram6110_case3: .4byte 0x03006110\n"
        "_sub_080019B4_pool_off4c9_case3c:   .4byte 0x000004c9\n"
        "_sub_080019B4_case3_fallthrough:\n"
        "    ldr     r4, _sub_080019B4_pool_off4cc_case3\n"
        "    add     r4, sp\n"
        "    movs    r0, #0\n"
        "    mov     r1, sp\n"
        "    bl      sub_08007660\n"
        "    bl      sub_0800A2D8\n"
        "    bl      sub_080008DC\n"
        "    bl      sub_0800A328\n"
        "    bl      sub_080094F8\n"
        "    bl      sub_08009984\n"
        "    movs    r0, #0x87\n"
        "    lsls    r0, r0, #3\n"
        "    add     r0, sp\n"
        "    adds    r1, r4, #0\n"
        "    bl      sub_080018F8\n"
        "    ldr     r1, _sub_080019B4_pool_gGameStuff_case3\n"
        "    ldr     r0, [r1, #20]\n"
        "    adds    r0, #1\n"
        "    str     r0, [r1, #20]\n"
        "    b       _sub_080019B4_tail\n"
        "    .hword  0\n"
        "_sub_080019B4_pool_off4cc_case3:     .4byte 0x000004cc\n"
        "_sub_080019B4_pool_gGameStuff_case3: .4byte 0x03005330\n"
        "_sub_080019B4_case4:\n"
        "    ldr     r4, _sub_080019B4_pool_off4c9_case4\n"
        "    add     r4, sp\n"
        "    ldr     r5, _sub_080019B4_pool_off4cc_case4\n"
        "    add     r5, sp\n"
        "    ldr     r0, _sub_080019B4_pool_off4c9_case4\n"
        "    add     r0, sp\n"
        "    bl      sub_08009C14\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_080019B4_case4_skip\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r4, #0]\n"
        "_sub_080019B4_case4_skip:\n"
        "    movs    r0, #0x87\n"
        "    lsls    r0, r0, #3\n"
        "    add     r0, sp\n"
        "    adds    r1, r5, #0\n"
        "    movs    r2, #5\n"
        "    bl      sub_0800B7B0\n"
        "    ldr     r5, _sub_080019B4_pool_iwram35e0_case4\n"
        "    movs    r0, #5\n"
        "    ldrsb   r0, [r5, r0]\n"
        "    cmp     r0, #1\n"
        "    bgt     _sub_080019B4_case4_gt1\n"
        "    ldr     r4, _sub_080019B4_pool_iwram6110_case4\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #8\n"
        "    movs    r2, #0\n"
        "    bl      sub_080066C4\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #9\n"
        "    movs    r2, #0\n"
        "    bl      sub_080066C4\n"
        "_sub_080019B4_case4_gt1:\n"
        "    ldrb    r0, [r5, #5]\n"
        "    cmp     r0, #2\n"
        "    bne     _sub_080019B4_case4_not2\n"
        "    ldr     r4, _sub_080019B4_pool_iwram6110_case4\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #8\n"
        "    movs    r2, #1\n"
        "    bl      sub_080066C4\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #9\n"
        "    movs    r2, #1\n"
        "    bl      sub_080066C4\n"
        "_sub_080019B4_case4_not2:\n"
        "    ldrb    r5, [r5, #5]\n"
        "    cmp     r5, #3\n"
        "    bne     _sub_080019B4_case4_not3\n"
        "    ldr     r4, _sub_080019B4_pool_iwram6110_case4\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #8\n"
        "    movs    r2, #1\n"
        "    bl      sub_080066C4\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #9\n"
        "    movs    r2, #1\n"
        "    bl      sub_080066C4\n"
        "_sub_080019B4_case4_not3:\n"
        "    movs    r1, #0x99\n"
        "    lsls    r1, r1, #3\n"
        "    add     r1, sp\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_080019B4_tail\n"
        "    .hword  0\n"
        "_sub_080019B4_pool_off4c9_case4:    .4byte 0x000004c9\n"
        "_sub_080019B4_pool_off4cc_case4:    .4byte 0x000004cc\n"
        "_sub_080019B4_pool_iwram35e0_case4: .4byte 0x030035e0\n"
        "_sub_080019B4_pool_iwram6110_case4: .4byte 0x03006110\n"
        "_sub_080019B4_case5:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_080019B4_pool_iwram5398_case5\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_0800E6A8\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r2, r0, #24\n"
        "    cmp     r2, #0\n"
        "    bne     _sub_080019B4_case5_skip\n"
        "    ldr     r0, _sub_080019B4_pool_off4c9_case5\n"
        "    add     r0, sp\n"
        "    movs    r1, #6\n"
        "    strb    r1, [r0, #0]\n"
        "    movs    r0, #0x99\n"
        "    lsls    r0, r0, #3\n"
        "    add     r0, sp\n"
        "    strb    r2, [r0, #0]\n"
        "_sub_080019B4_case5_skip:\n"
        "    ldr     r0, _sub_080019B4_pool_iwram5328_case5\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_080019B4_tail\n"
        "    ldr     r1, _sub_080019B4_pool_off4c9_case5\n"
        "    add     r1, sp\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_080019B4_tail\n"
        "    .hword  0\n"
        "_sub_080019B4_pool_iwram5398_case5: .4byte 0x03005398\n"
        "_sub_080019B4_pool_off4c9_case5:    .4byte 0x000004c9\n"
        "_sub_080019B4_pool_iwram5328_case5: .4byte 0x03005328\n"
        "_sub_080019B4_case6:\n"
        "    movs    r4, #0x99\n"
        "    lsls    r4, r4, #3\n"
        "    add     r4, sp\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_080019B4_case6_check\n"
        "    movs    r0, #0xBF\n"
        "    bl      sub_08010694\n"
        "    ldrb    r0, [r4, #0]\n"
        "    adds    r0, #1\n"
        "    strb    r0, [r4, #0]\n"
        "_sub_080019B4_case6_check:\n"
        "    ldrb    r4, [r4, #0]\n"
        "    lsls    r4, r4, #24\n"
        "    asrs    r4, r4, #24\n"
        "    cmp     r4, #1\n"
        "    bne     _sub_080019B4_tail\n"
        "    bl      sub_080106B8\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_080019B4_tail\n"
        "    ldr     r0, _sub_080019B4_pool_iwram3480_case6\n"
        "    movs    r1, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    strb    r4, [r0, #6]\n"
        "    ldr     r0, _sub_080019B4_pool_gGameStuff_case6\n"
        "    strb    r1, [r0, #9]\n"
        "    b       _sub_080019B4_tail\n"
        "_sub_080019B4_pool_iwram3480_case6:  .4byte 0x03003480\n"
        "_sub_080019B4_pool_gGameStuff_case6: .4byte 0x03005330\n"
        "_sub_080019B4_case7:\n"
        "    movs    r4, #0x99\n"
        "    lsls    r4, r4, #3\n"
        "    add     r4, sp\n"
        "    ldr     r1, _sub_080019B4_pool_callback_a26d\n"
        "    adds    r0, r4, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_080019B4_finalize\n"
        "    ldr     r1, _sub_080019B4_pool_off4c9_case7\n"
        "    add     r1, sp\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r1, #0]\n"
        "    ldr     r1, _sub_080019B4_pool_gGameStuff_case7\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    strb    r0, [r4, #0]\n"
        "    bl      sub_0800A1C8\n"
        "_sub_080019B4_finalize:\n"
        "    bl      sub_080008DC\n"
        "    b       _sub_080019B4_tail\n"
        "    .hword  0\n"
        "_sub_080019B4_pool_callback_a26d:    .4byte 0x0800a26d\n"
        "_sub_080019B4_pool_off4c9_case7:     .4byte 0x000004c9\n"
        "_sub_080019B4_pool_gGameStuff_case7: .4byte 0x03005330\n"
        "_sub_080019B4_case8:\n"
        "    bl      sub_0800DE80\n"
        "_sub_080019B4_tail:\n"
        "    ldr     r0, _sub_080019B4_pool_gGameStuff_tail\n"
        "    ldrb    r0, [r0, #9]\n"
        "    cmp     r0, #12\n"
        "    bne     _sub_080019B4_tail_not12\n"
        "    b       _sub_080019B4_loopHead\n"
        "_sub_080019B4_tail_not12:\n"
        "    cmp     r0, #24\n"
        "    bne     _sub_080019B4_epilogue\n"
        "    b       _sub_080019B4_loopHead\n"
        "_sub_080019B4_epilogue:\n"
        "    ldr     r3, _sub_080019B4_pool_frame_restore\n"
        "    add     sp, r3\n"
        "    pop     {r4, r5}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .hword  0\n"
        "_sub_080019B4_pool_gGameStuff_tail:  .4byte 0x03005330\n"
        "_sub_080019B4_pool_frame_restore:    .4byte 0x000004d4\n"
        "    .syntax divided\n");
}

/* Trailing init helper at 0x08001cec — an out-of-line copy of the case-0
 * init (gGameStuff.pendingMode = 5; sub_08006BB4; sub_0800B7B0(...,5)) that
 * takes the per-frame object pointers as arguments. Lives inside the same
 * compilation slice as sub_080019B4 (nothing in the ROM BLs to it; kept as
 * a separate symbol so the surrounding layout stays byte-identical). */
void sub_08001CEC(void *buf, void *r4_obj, u32 kind)
{
    gGameStuff.pendingMode = 5;
    sub_08006BB4(0, buf);
    sub_0800B7B0(r4_obj, (void *)kind, 5);
}
