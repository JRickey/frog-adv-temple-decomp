#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08001214 — per-frame handler for game-mode 10. The AgbMain
 * dispatch enters this function while gGameStuff.mode stays at 10; it
 * runs one substate per VBlank tick and loops until mode leaves 10.
 *
 * Class-sibling of sub_08000EB8 (mode 9), sub_08001508 (mode 11/24)
 * and sub_08002844 (mode 15) — the same `mov pc, rN` jump-table state
 * machine. Stack frame is only 8 bytes here: the substate index lives
 * at sp+5 (cached into r6 across the whole loop) and a one-byte scratch
 * (an accept/return flag passed by pointer into the sub_0800A104 /
 * sub_08009D9C predicates) at sp+4. The prologue saves {r4-r7, lr}.
 *
 * Substate behaviour (jump table has 10 entries, indexed by sp[+5]):
 *   0 -> gGameStuff.pendingMode = 3; r7 = sub_0800A214(); substate = 1;
 *        sp[+4] = 0.
 *   1 -> sub_0800A104(&sp[+4], 0x08001485); on reject jump to the shared
 *        sub_080008DC finalize; on accept substate = 2, clear
 *        gGameStuff._unk14, sp[+4] = 0, then the finalize.
 *   2 -> sub_0801B514(3); sub_0800A258(r7); substate = 3.
 *   3 -> sub_08009D9C(&sp[+4]); on success substate = 4, clear
 *        gGameStuff._unk14, sub_08006600(0x03006110, 8, 1).
 *   4 -> gIwram_5398 = sub_080004C4(); if == 0x40 substate = 6 +
 *        sub_0800E060(); else falls into the keypad gate:
 *          (gIwram_3720._field_34 & 8) -> substate = 5
 *          (gIwram_6110[+0x2e]  & 8)   -> substate = 9
 *          neither -> sub_0800A2D8 + sub_080008DC + sub_0800A328 +
 *                     sub_080094F8 + sub_08009984 + sub_080011A4;
 *                     gGameStuff._unk14++.
 *   5 -> sub_08009C14(&substate); on reject (r0 == 0) substate = 8;
 *        sp[+4] = 0.
 *   6 -> gIwram_5398 = sub_080004C4(); if sub_0800E6A8() == 0
 *        substate = 7, sp[+4] = 0; gate gIwram_5328 — non-zero skips,
 *        else substate = 4.
 *   7 -> if (s8)sp[+4] == 0 call sub_08010694(0xBF) + increment; then
 *        (s8)sp[+4] must == 1 to continue; sub_080106B8() must return 0;
 *        gIwram_3480._data[0] = 4, gIwram_3480._data[6] = 0,
 *        gGameStuff.mode = 4.
 *   8 -> sub_0800A104(&sp[+4], 0x0800a26d); on accept substate = 3,
 *        clear gGameStuff._unk14, sp[+4] = 0, sub_0800A258(r7); always
 *        falls into the shared sub_080008DC finalize.
 *   9 -> three sub_0800CBE8 tile pokes off gIwram_35E0._field_18/19,
 *        then sub_0800DE80().
 *
 * Shipped NAKED + NON_MATCHING. This is the documented mode-X cluster
 * (sub_08000918, sub_08000EB8, sub_08001508, sub_08002844, AgbMain):
 * a `mov pc, rN` jump table fed by an indexed `.4byte` table. Per the
 * iter-38 corpus triangulation (docs/codegen-notes.md "Iter-38 research
 * interlude"), all 58 `mov pc, rN` hits across the agbcc corpus live
 * inside NAKED functions and ZERO match as a pure-C switch, because the
 * surrounding context here has a cross-call register pin (r6 = &substate
 * kept live across the whole loop) plus the asymmetric loop entry
 * (fallthrough re-entry from the tail at gGameStuff.mode == 10). The
 * NON_MATCHING reference below documents intent for the phase-3 PC
 * port. */

extern void sub_08020BC0(void);
extern u32 sub_0800A214(void);
extern u8 sub_0800A104(u8 *flag, u32 callbackTable);
extern void sub_0801B514(u32 arg);
extern void sub_0800A258(u32 arg);
extern u8 sub_08009D9C(u8 *flag);
extern void sub_08006600(u32 base, u32 idx, u32 val);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_080011A4(void);
extern u32 sub_08009C14(void *p);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800CBE8(u8 col, u8 row, u32 a, u32 b, u32 c);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

#ifdef NON_MATCHING

/* Reference body — readable shape for the phase-3 PC port. Doesn't
 * compile to the same bytes; the NAKED form below is what matches. */
void sub_08001214(void)
{
    u8 spByte4;  /* sp + 4 — accept/return flag scratch */
    u8 substate; /* sp + 5 (r6) */
    u32 r7;

    substate = 0;

    if (gGameStuff.mode != 10)
        return;

    do {
        sub_08020BC0();
        if (substate > 9)
            goto tail;

        switch (substate) {
        case 0:
            gGameStuff.pendingMode = 3;
            r7 = sub_0800A214();
            substate = 1;
            spByte4 = 0;
            break;
        case 1:
            if (sub_0800A104(&spByte4, 0x08001485) == 0)
                goto finalize;
            substate = 2;
            gGameStuff._unk14 = 0;
            spByte4 = 0;
            goto finalize;
        case 2:
            sub_0801B514(3);
            sub_0800A258(r7);
            substate = 3;
            break;
        case 3:
            if (sub_08009D9C(&spByte4) == 0)
                goto tail;
            substate = 4;
            gGameStuff._unk14 = 0;
            sub_08006600(0x03006110, 8, 1);
            goto tail;
        case 4:
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                substate = 6;
                sub_0800E060();
                goto tail;
            }
            if ((gIwram_3720._field_34 & 8) != 0) {
                substate = 5;
                goto tail;
            }
            if ((*(u16 *)((u8 *)&gIwram_6110 + 0x2e) & 8) != 0) {
                substate = 9;
                goto tail;
            }
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
            sub_080094F8();
            sub_08009984();
            sub_080011A4();
            gGameStuff._unk14++;
            goto tail;
        case 5:
            if (sub_08009C14(&substate) == 0)
                substate = 8;
            spByte4 = 0;
            break;
        case 6:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                substate = 7;
                spByte4 = 0;
            }
            if (gIwram_5328 == 0)
                substate = 4;
            break;
        case 7:
            if ((s8)spByte4 == 0) {
                sub_08010694(0xBF);
                spByte4 += 1;
            }
            if ((s8)spByte4 != 1)
                goto tail;
            if (sub_080106B8() != 0)
                goto tail;
            gIwram_3480._data[0] = 4;
            gIwram_3480._data[6] = 0;
            gGameStuff.mode = 4;
            break;
        case 8:
            if (sub_0800A104(&spByte4, 0x0800a26d) != 0) {
                substate = 3;
                gGameStuff._unk14 = 0;
                spByte4 = 0;
                sub_0800A258(r7);
            }
        finalize:
            sub_080008DC();
            goto tail;
        case 9:
            sub_0800CBE8(gIwram_35E0._field_18, gIwram_35E0._field_19, 6, 11, 15);
            sub_0800CBE8(gIwram_35E0._field_18, gIwram_35E0._field_19, 6, 10, 15);
            sub_0800CBE8(gIwram_35E0._field_18, gIwram_35E0._field_19, 7, 11, 7);
            sub_0800DE80();
            break;
        }

    tail:;
    } while (gGameStuff.mode == 10);
}

#else

/* NAKED form — matches the baserom byte-for-byte. The inline jump table
 * at _sub_08001214_jumpTable is consumed by `mov pc, r0` and MUST sit at
 * the exact relative offset agbcc placed it (right after the literal
 * pool following the table-index load). The .syntax-divided trailer is
 * mandatory — see docs/codegen-notes.md ".syntax unified bleed". */
NAKED
void sub_08001214(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    sub     sp, #8\n"
        "    mov     r0, sp\n"
        "    adds    r0, #5\n"
        "    movs    r1, #0\n"
        "    strb    r1, [r0, #0]\n"
        "    ldr     r1, _sub_08001214_pool_gGameStuff_entry\n"
        "    adds    r6, r0, #0\n"
        "    ldrb    r1, [r1, #9]\n"
        "    cmp     r1, #10\n"
        "    beq     _sub_08001214_loopHead\n"
        "    b       _sub_08001214_epilogue\n"
        "_sub_08001214_loopHead:\n"
        "    bl      sub_08020BC0\n"
        "    ldrb    r0, [r6, #0]\n"
        "    cmp     r0, #9\n"
        "    bls     _sub_08001214_dispatch\n"
        "    b       _sub_08001214_tail\n"
        "_sub_08001214_dispatch:\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, _sub_08001214_pool_jumpTablePtr\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .hword  0\n"
        "_sub_08001214_pool_gGameStuff_entry: .4byte 0x03005330\n"
        "_sub_08001214_pool_jumpTablePtr:     .4byte _sub_08001214_jumpTable\n"
        "_sub_08001214_jumpTable:\n"
        "    .4byte _sub_08001214_case0\n"
        "    .4byte _sub_08001214_case1\n"
        "    .4byte _sub_08001214_case2\n"
        "    .4byte _sub_08001214_case3\n"
        "    .4byte _sub_08001214_case4\n"
        "    .4byte _sub_08001214_case5\n"
        "    .4byte _sub_08001214_case6\n"
        "    .4byte _sub_08001214_case7\n"
        "    .4byte _sub_08001214_case8\n"
        "    .4byte _sub_08001214_case9\n"
        "_sub_08001214_case0:\n"
        "    ldr     r1, _sub_08001214_pool_gGameStuff_case0\n"
        "    movs    r4, #0\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r1, #10]\n"
        "    bl      sub_0800A214\n"
        "    adds    r7, r0, #0\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r6, #0]\n"
        "    add     r0, sp, #4\n"
        "    strb    r4, [r0, #0]\n"
        "    b       _sub_08001214_tail\n"
        "_sub_08001214_pool_gGameStuff_case0: .4byte 0x03005330\n"
        "_sub_08001214_case1:\n"
        "    ldr     r1, _sub_08001214_pool_callback_1485\n"
        "    add     r0, sp, #4\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001214_case1_accept\n"
        "    b       _sub_08001214_finalize\n"
        "_sub_08001214_case1_accept:\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r0, _sub_08001214_pool_gGameStuff_case1\n"
        "    movs    r1, #0\n"
        "    str     r1, [r0, #20]\n"
        "    add     r0, sp, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    b       _sub_08001214_finalize\n"
        "_sub_08001214_pool_callback_1485:    .4byte 0x08001485\n"
        "_sub_08001214_pool_gGameStuff_case1: .4byte 0x03005330\n"
        "_sub_08001214_case2:\n"
        "    movs    r0, #3\n"
        "    bl      sub_0801B514\n"
        "    adds    r0, r7, #0\n"
        "    bl      sub_0800A258\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08001214_tail\n"
        "_sub_08001214_case3:\n"
        "    add     r0, sp, #4\n"
        "    bl      sub_08009D9C\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001214_case3_accept\n"
        "    b       _sub_08001214_tail\n"
        "_sub_08001214_case3_accept:\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r1, _sub_08001214_pool_gGameStuff_case3\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    ldr     r0, _sub_08001214_pool_iwram6110_case3\n"
        "    movs    r1, #8\n"
        "    movs    r2, #1\n"
        "    bl      sub_08006600\n"
        "    b       _sub_08001214_tail\n"
        "_sub_08001214_pool_gGameStuff_case3: .4byte 0x03005330\n"
        "_sub_08001214_pool_iwram6110_case3:  .4byte 0x03006110\n"
        "_sub_08001214_case4:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08001214_pool_iwram5398_case4\n"
        "    strh    r0, [r1, #0]\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #0x40\n"
        "    bne     _sub_08001214_case4_not40\n"
        "    movs    r0, #6\n"
        "    strb    r0, [r6, #0]\n"
        "    bl      sub_0800E060\n"
        "    b       _sub_08001214_tail\n"
        "    .hword  0\n"
        "_sub_08001214_pool_iwram5398_case4:  .4byte 0x03005398\n"
        "_sub_08001214_case4_not40:\n"
        "    ldr     r1, _sub_08001214_pool_iwram3720_case4\n"
        "    movs    r2, #8\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x34]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08001214_case4_not_held\n"
        "    movs    r0, #5\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08001214_tail\n"
        "_sub_08001214_pool_iwram3720_case4:  .4byte 0x03003720\n"
        "_sub_08001214_case4_not_held:\n"
        "    ldr     r1, _sub_08001214_pool_iwram6110_case4\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x2e]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08001214_case4_fallthrough\n"
        "    movs    r0, #9\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08001214_tail\n"
        "    .hword  0\n"
        "_sub_08001214_pool_iwram6110_case4:  .4byte 0x03006110\n"
        "_sub_08001214_case4_fallthrough:\n"
        "    bl      sub_0800A2D8\n"
        "    bl      sub_080008DC\n"
        "    bl      sub_0800A328\n"
        "    bl      sub_080094F8\n"
        "    bl      sub_08009984\n"
        "    bl      sub_080011A4\n"
        "    ldr     r1, _sub_08001214_pool_gGameStuff_case4\n"
        "    ldr     r0, [r1, #20]\n"
        "    adds    r0, #1\n"
        "    str     r0, [r1, #20]\n"
        "    b       _sub_08001214_tail\n"
        "    .hword  0\n"
        "_sub_08001214_pool_gGameStuff_case4: .4byte 0x03005330\n"
        "_sub_08001214_case5:\n"
        "    adds    r0, r6, #0\n"
        "    bl      sub_08009C14\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001214_case5_ok\n"
        "    movs    r0, #8\n"
        "    strb    r0, [r6, #0]\n"
        "_sub_08001214_case5_ok:\n"
        "    add     r1, sp, #4\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08001214_tail\n"
        "_sub_08001214_case6:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08001214_pool_iwram5398_case6\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_0800E6A8\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r1, r0, #24\n"
        "    cmp     r1, #0\n"
        "    bne     _sub_08001214_case6_nz\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r6, #0]\n"
        "    add     r0, sp, #4\n"
        "    strb    r1, [r0, #0]\n"
        "_sub_08001214_case6_nz:\n"
        "    ldr     r0, _sub_08001214_pool_iwram5328_case6\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001214_tail\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08001214_tail\n"
        "_sub_08001214_pool_iwram5398_case6:  .4byte 0x03005398\n"
        "_sub_08001214_pool_iwram5328_case6:  .4byte 0x03005328\n"
        "_sub_08001214_case7:\n"
        "    add     r0, sp, #4\n"
        "    ldrb    r0, [r0, #0]\n"
        "    lsls    r0, r0, #24\n"
        "    asrs    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001214_case7_have\n"
        "    movs    r0, #0xbf\n"
        "    bl      sub_08010694\n"
        "    add     r0, sp, #4\n"
        "    adds    r1, r0, #0\n"
        "    ldrb    r1, [r1, #0]\n"
        "    adds    r1, #1\n"
        "    strb    r1, [r0, #0]\n"
        "_sub_08001214_case7_have:\n"
        "    add     r0, sp, #4\n"
        "    movs    r4, #0\n"
        "    ldrsb   r4, [r0, r4]\n"
        "    cmp     r4, #1\n"
        "    bne     _sub_08001214_tail\n"
        "    bl      sub_080106B8\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001214_tail\n"
        "    ldr     r0, _sub_08001214_pool_iwram3480_case7\n"
        "    movs    r1, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    strb    r4, [r0, #6]\n"
        "    ldr     r0, _sub_08001214_pool_gGameStuff_case7\n"
        "    strb    r1, [r0, #9]\n"
        "    b       _sub_08001214_tail\n"
        "    .hword  0\n"
        "_sub_08001214_pool_iwram3480_case7:  .4byte 0x03003480\n"
        "_sub_08001214_pool_gGameStuff_case7: .4byte 0x03005330\n"
        "_sub_08001214_case8:\n"
        "    ldr     r1, _sub_08001214_pool_callback_a26d\n"
        "    add     r0, sp, #4\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08001214_finalize\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r0, _sub_08001214_pool_gGameStuff_case8\n"
        "    movs    r1, #0\n"
        "    str     r1, [r0, #20]\n"
        "    add     r0, sp, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    adds    r0, r7, #0\n"
        "    bl      sub_0800A258\n"
        "_sub_08001214_finalize:\n"
        "    bl      sub_080008DC\n"
        "    b       _sub_08001214_tail\n"
        "_sub_08001214_pool_callback_a26d:    .4byte 0x0800a26d\n"
        "_sub_08001214_pool_gGameStuff_case8: .4byte 0x03005330\n"
        "_sub_08001214_case9:\n"
        "    ldr     r4, _sub_08001214_pool_iwram35e0_case9\n"
        "    ldrb    r0, [r4, #24]\n"
        "    ldrb    r1, [r4, #25]\n"
        "    movs    r5, #15\n"
        "    str     r5, [sp, #0]\n"
        "    movs    r2, #6\n"
        "    movs    r3, #11\n"
        "    bl      sub_0800CBE8\n"
        "    ldrb    r0, [r4, #24]\n"
        "    ldrb    r1, [r4, #25]\n"
        "    str     r5, [sp, #0]\n"
        "    movs    r2, #6\n"
        "    movs    r3, #10\n"
        "    bl      sub_0800CBE8\n"
        "    ldrb    r0, [r4, #24]\n"
        "    ldrb    r1, [r4, #25]\n"
        "    movs    r2, #7\n"
        "    str     r2, [sp, #0]\n"
        "    movs    r3, #11\n"
        "    bl      sub_0800CBE8\n"
        "    bl      sub_0800DE80\n"
        "_sub_08001214_tail:\n"
        "    ldr     r0, _sub_08001214_pool_gGameStuff_tail\n"
        "    ldrb    r0, [r0, #9]\n"
        "    cmp     r0, #10\n"
        "    bne     _sub_08001214_epilogue\n"
        "    b       _sub_08001214_loopHead\n"
        "_sub_08001214_epilogue:\n"
        "    add     sp, #8\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "_sub_08001214_pool_iwram35e0_case9:  .4byte 0x030035e0\n"
        "_sub_08001214_pool_gGameStuff_tail:  .4byte 0x03005330\n"
        "    .syntax divided\n");
}

#endif
