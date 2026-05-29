#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08002524 — per-frame handler for game-mode 14 (also runs while
 * gGameStuff.mode == 24, the attract path). AgbMain dispatches mode 14
 * here; the function loops as long as mode stays 14 or 24.
 *
 * Class-sibling of sub_08002844 (mode 15, src/game/mode_15.c),
 * sub_08002184 (mode 13), sub_080019B4 (mode 12), sub_08001214 and
 * sub_08000EB8: the same dense 9-case state machine dispatched through a
 * computed `mov pc, r0` over an inline 9-entry `.4byte` table, wrapped
 * in a mode-gated loop. Two stack bytes drive it: `state` (the dispatch
 * sub-state, at sp+1) and a scratch `accept` byte at sp+0 handed to
 * sub_0800A104 / sub_08009D9C. The address of `state` is held in r5
 * across the entire loop and every inner BL.
 *
 * Shipped NAKED + NON_MATCHING, exactly as its three in-repo dispatcher
 * siblings (sub_08002184, sub_08002844, sub_08002B58) did. agbcc 2.x CAN
 * lower a dense u8 switch to the `mov pc, r0` core (the NON_MATCHING body
 * below reproduces the jump table and all nine case bodies in order),
 * but it cannot reproduce the single cross-call register pin this
 * function carries: r5 holds &state (the sp+1 stack byte) live across the
 * whole loop and every inner call. A `register u8 *p asm("r5")` pin does
 * not reach — a stack address cannot be a register variable, so agbcc
 * spills it and recomputes sp+offset, which (a) flips the prologue r0/r1
 * roles (baserom computes &state into r0 → r5 and the zero const into r1;
 * agbcc does the reverse) and (b) lets the cross-jumper fold the entry
 * mode-test into the loop-tail mode-test (`b .L34`) — the baserom keeps
 * them in different registers (r1 at entry vs r0 at the tail) precisely
 * because r0 is busy holding &state at entry. Pinning r5 was tried and
 * made it worse (best pure-C byte_diff: 489 under old_agbcc, 494 under
 * agbcc; the r5-pin variant regressed to a larger diff). This is the same
 * wall documented for sub_08002184 in docs/codegen-notes.md "mov pc, rN
 * jump tables" / the mode-X cluster: matchable dispatcher core, but the
 * &state-in-r5 pin + asymmetric loop entry are not reachable from C.
 *
 * Corpus: across the curated agbcc decomps, 58 `mov pc, rN` hits in .c
 * files are ALL inside inline-asm/NAKED blocks (e.g. mmzret/rmz3
 * result.c's NAKED handlers), 1814 more live in hand-asm slices, and
 * ZERO are emitted by agbcc from a pure-C switch.
 *
 * The reference summary above documents intent for the phase-3 PC port;
 * the NAKED form below is what compiles byte-identical to baserom. */

extern void sub_08020BC0(void);
extern u8 sub_0800A104(u8 *accept, u32 callbackTable);
extern u8 sub_08009D9C(u8 *accept);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800EF90(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern u8 sub_0800CD88(u8 a, u8 b, s16 c, s16 d);
extern void sub_0800C3E4(u8 a);
extern u32 sub_08009C14(u8 *state);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

#ifdef NON_MATCHING

/* Reference body — readable shape for the phase-3 PC port. Doesn't
 * compile to the same bytes (see header); the NAKED form below matches. */
void sub_08002524(void)
{
    u8 state;
    u8 accept;

    state = 0;
    if (gGameStuff.mode != 14 && gGameStuff.mode != 24)
        return;

loop:
    sub_08020BC0();
    if (state > 8)
        goto tail;

    switch (state) {
    case 0:
        gGameStuff.pendingMode = 7;
        state = 1;
        accept = 0;
        break;
    case 1:
        if (sub_0800A104(&accept, 0x0800276D) == 0) {
            sub_080008DC();
            goto tail;
        }
        state = 2;
        gGameStuff._unk14 = 0;
        accept = 0;
        sub_080008DC();
        goto tail;
    case 2:
        if (sub_08009D9C(&accept) == 0)
            goto tail;
        state = 3;
        gGameStuff._unk14 = 0;
        break;
    case 3:
        gIwram_5398 = sub_080004C4();
        if (gIwram_5398 == 0x40) {
            state = 5;
            sub_0800E060();
            goto tail;
        }
        if (gIwram_3720._field_34 & 8) {
            state = 4;
            sub_0800EF90();
            goto tail;
        }
        if (gIwram_6110._field_2e & 8) {
            state = 8;
            goto tail;
        }
        sub_0800A2D8();
        sub_080008DC();
        sub_0800A328();
        sub_080094F8();
        sub_08009984();
        if (gIwram_35E0._field_10 & 0x10) {
            u8 result =
                sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);
            sub_0800C3E4(result);
        }
        gGameStuff._unk14++;
        break;
    case 4:
        if (sub_08009C14(&state) == 0)
            state = 7;
        accept = 0;
        break;
    case 5:
        gIwram_5398 = sub_080004C4();
        if (sub_0800E6A8() == 0) {
            state = 6;
            accept = 0;
        }
        if (gIwram_5328 != 0)
            goto tail;
        state = 3;
        break;
    case 6:
        if ((s8)accept == 0) {
            sub_08010694(0xBF);
            accept++;
        }
        if ((s8)accept != 1)
            goto tail;
        if (sub_080106B8() != 0)
            goto tail;
        gIwram_3480._data[0] = 4;
        *((u8 *)&gIwram_3480 + 6) = (s8)accept;
        gGameStuff.mode = 4;
        break;
    case 7:
        if (sub_0800A104(&accept, 0x0800A26D) != 0) {
            state = 2;
            gGameStuff._unk14 = 0;
            accept = 0;
            sub_0800A1C8();
        }
        sub_080008DC();
        break;
    case 8:
        sub_0800DE80();
        break;
    }

tail:
    if (gGameStuff.mode == 14 || gGameStuff.mode == 24)
        goto loop;
}

#else

/* NAKED form — matches the baserom byte-for-byte. The inline jump table
 * at _sub_08002524_jumpTable is consumed by `mov pc, r0` and MUST land at
 * the exact relative offset agbcc would have placed it (right after the
 * literal pool that follows the table-index load), so each pool word is
 * emitted at its original site. The .syntax-divided trailer is mandatory
 * — see docs/codegen-notes.md ".syntax unified bleed". */
NAKED
void sub_08002524(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, lr}\n"
        "    sub     sp, #4\n"
        "    mov     r0, sp\n"
        "    adds    r0, #1\n"
        "    movs    r1, #0\n"
        "    strb    r1, [r0, #0]\n"
        "    ldr     r1, _sub_08002524_pool_gGameStuff_entry\n"
        "    ldrb    r1, [r1, #9]\n"
        "    adds    r5, r0, #0\n"
        "    cmp     r1, #14\n"
        "    beq     _sub_08002524_loopHead\n"
        "    cmp     r1, #24\n"
        "    beq     _sub_08002524_loopHead\n"
        "    b       _sub_08002524_epilogue\n"
        "_sub_08002524_loopHead:\n"
        "    bl      sub_08020BC0\n"
        "    ldrb    r0, [r5, #0]\n"
        "    cmp     r0, #8\n"
        "    bls     _sub_08002524_dispatch\n"
        "    b       _sub_08002524_tail\n"
        "_sub_08002524_dispatch:\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, _sub_08002524_pool_jumpTablePtr\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .hword  0\n"
        "_sub_08002524_pool_gGameStuff_entry: .4byte 0x03005330\n"
        "_sub_08002524_pool_jumpTablePtr:     .4byte _sub_08002524_jumpTable\n"
        "_sub_08002524_jumpTable:\n"
        "    .4byte _sub_08002524_case0\n"
        "    .4byte _sub_08002524_case1\n"
        "    .4byte _sub_08002524_case2\n"
        "    .4byte _sub_08002524_case3\n"
        "    .4byte _sub_08002524_case4\n"
        "    .4byte _sub_08002524_case5\n"
        "    .4byte _sub_08002524_case6\n"
        "    .4byte _sub_08002524_case7\n"
        "    .4byte _sub_08002524_case8\n"
        "_sub_08002524_case0:\n"
        "    ldr     r1, _sub_08002524_pool_gGameStuff_case0\n"
        "    movs    r2, #0\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r1, #0xa]\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r5, #0]\n"
        "    mov     r0, sp\n"
        "    strb    r2, [r0, #0]\n"
        "    b       _sub_08002524_tail\n"
        "    .hword  0\n"
        "_sub_08002524_pool_gGameStuff_case0: .4byte 0x03005330\n"
        "_sub_08002524_case1:\n"
        "    ldr     r1, _sub_08002524_pool_callback_276d\n"
        "    mov     r0, sp\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002524_case1_accept\n"
        "    b       _sub_08002524_tail_finalize\n"
        "_sub_08002524_case1_accept:\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r5, #0]\n"
        "    ldr     r0, _sub_08002524_pool_gGameStuff_case1\n"
        "    movs    r1, #0\n"
        "    str     r1, [r0, #0x14]\n"
        "    mov     r0, sp\n"
        "    strb    r1, [r0, #0]\n"
        "    b       _sub_08002524_tail_finalize\n"
        "_sub_08002524_pool_callback_276d:    .4byte 0x0800276D\n"
        "_sub_08002524_pool_gGameStuff_case1: .4byte 0x03005330\n"
        "_sub_08002524_case2:\n"
        "    mov     r0, sp\n"
        "    bl      sub_08009D9C\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002524_case2_accept\n"
        "    b       _sub_08002524_tail\n"
        "_sub_08002524_case2_accept:\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r5, #0]\n"
        "    ldr     r1, _sub_08002524_pool_gGameStuff_case2\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #0x14]\n"
        "    b       _sub_08002524_tail\n"
        "_sub_08002524_pool_gGameStuff_case2: .4byte 0x03005330\n"
        "_sub_08002524_case3:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08002524_pool_iwram5398_case3\n"
        "    strh    r0, [r1, #0]\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #0x40\n"
        "    bne     _sub_08002524_case3_not40\n"
        "    movs    r0, #5\n"
        "    strb    r0, [r5, #0]\n"
        "    bl      sub_0800E060\n"
        "    b       _sub_08002524_tail\n"
        "    .hword  0\n"
        "_sub_08002524_pool_iwram5398_case3:  .4byte 0x03005398\n"
        "_sub_08002524_case3_not40:\n"
        "    ldr     r1, _sub_08002524_pool_iwram3720_case3\n"
        "    movs    r3, #8\n"
        "    movs    r2, #8\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x34]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08002524_case3_not_held\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r5, #0]\n"
        "    bl      sub_0800EF90\n"
        "    b       _sub_08002524_tail\n"
        "    .hword  0\n"
        "_sub_08002524_pool_iwram3720_case3:  .4byte 0x03003720\n"
        "_sub_08002524_case3_not_held:\n"
        "    ldr     r1, _sub_08002524_pool_iwram6110_case3\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x2e]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08002524_case3_dispatch\n"
        "    strb    r3, [r5, #0]\n"
        "    b       _sub_08002524_tail\n"
        "_sub_08002524_pool_iwram6110_case3:  .4byte 0x03006110\n"
        "_sub_08002524_case3_dispatch:\n"
        "    bl      sub_0800A2D8\n"
        "    bl      sub_080008DC\n"
        "    bl      sub_0800A328\n"
        "    bl      sub_080094F8\n"
        "    bl      sub_08009984\n"
        "    ldr     r3, _sub_08002524_pool_iwram35e0_case3\n"
        "    movs    r0, #0x10\n"
        "    ldrh    r1, [r3, #0x10]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08002524_case3_count\n"
        "    ldrb    r0, [r3, #0x18]\n"
        "    ldrb    r1, [r3, #0x19]\n"
        "    movs    r4, #8\n"
        "    ldrsh   r2, [r3, r4]\n"
        "    movs    r4, #0xa\n"
        "    ldrsh   r3, [r3, r4]\n"
        "    bl      sub_0800CD88\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    bl      sub_0800C3E4\n"
        "_sub_08002524_case3_count:\n"
        "    ldr     r1, _sub_08002524_pool_gGameStuff_case3\n"
        "    ldr     r0, [r1, #0x14]\n"
        "    adds    r0, #1\n"
        "    str     r0, [r1, #0x14]\n"
        "    b       _sub_08002524_tail\n"
        "    .hword  0\n"
        "_sub_08002524_pool_iwram35e0_case3:  .4byte 0x030035E0\n"
        "_sub_08002524_pool_gGameStuff_case3: .4byte 0x03005330\n"
        "_sub_08002524_case4:\n"
        "    adds    r0, r5, #0\n"
        "    bl      sub_08009C14\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002524_case4_clear\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r5, #0]\n"
        "_sub_08002524_case4_clear:\n"
        "    mov     r1, sp\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08002524_tail\n"
        "_sub_08002524_case5:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08002524_pool_iwram5398_case5\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_0800E6A8\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r1, r0, #24\n"
        "    cmp     r1, #0\n"
        "    bne     _sub_08002524_case5_gate\n"
        "    movs    r0, #6\n"
        "    strb    r0, [r5, #0]\n"
        "    mov     r0, sp\n"
        "    strb    r1, [r0, #0]\n"
        "_sub_08002524_case5_gate:\n"
        "    ldr     r0, _sub_08002524_pool_iwram5328_case5\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002524_tail\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r5, #0]\n"
        "    b       _sub_08002524_tail\n"
        "_sub_08002524_pool_iwram5398_case5:  .4byte 0x03005398\n"
        "_sub_08002524_pool_iwram5328_case5:  .4byte 0x03005328\n"
        "_sub_08002524_case6:\n"
        "    mov     r0, sp\n"
        "    ldrb    r0, [r0, #0]\n"
        "    lsls    r0, r0, #24\n"
        "    asrs    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002524_case6_check1\n"
        "    movs    r0, #0xbf\n"
        "    bl      sub_08010694\n"
        "    mov     r0, sp\n"
        "    mov     r1, sp\n"
        "    ldrb    r1, [r1, #0]\n"
        "    adds    r1, #1\n"
        "    strb    r1, [r0, #0]\n"
        "_sub_08002524_case6_check1:\n"
        "    mov     r0, sp\n"
        "    movs    r4, #0\n"
        "    ldrsb   r4, [r0, r4]\n"
        "    cmp     r4, #1\n"
        "    bne     _sub_08002524_tail\n"
        "    bl      sub_080106B8\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002524_tail\n"
        "    ldr     r0, _sub_08002524_pool_iwram3480_case6\n"
        "    movs    r1, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    strb    r4, [r0, #6]\n"
        "    ldr     r0, _sub_08002524_pool_gGameStuff_case6\n"
        "    strb    r1, [r0, #9]\n"
        "    b       _sub_08002524_tail\n"
        "    .hword  0\n"
        "_sub_08002524_pool_iwram3480_case6:  .4byte 0x03003480\n"
        "_sub_08002524_pool_gGameStuff_case6: .4byte 0x03005330\n"
        "_sub_08002524_case7:\n"
        "    ldr     r1, _sub_08002524_pool_callback_a26d\n"
        "    mov     r0, sp\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08002524_tail_finalize\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r5, #0]\n"
        "    ldr     r0, _sub_08002524_pool_gGameStuff_case7\n"
        "    movs    r1, #0\n"
        "    str     r1, [r0, #0x14]\n"
        "    mov     r0, sp\n"
        "    strb    r1, [r0, #0]\n"
        "    bl      sub_0800A1C8\n"
        "_sub_08002524_tail_finalize:\n"
        "    bl      sub_080008DC\n"
        "    b       _sub_08002524_tail\n"
        "    .hword  0\n"
        "_sub_08002524_pool_callback_a26d:    .4byte 0x0800A26D\n"
        "_sub_08002524_pool_gGameStuff_case7: .4byte 0x03005330\n"
        "_sub_08002524_case8:\n"
        "    bl      sub_0800DE80\n"
        "_sub_08002524_tail:\n"
        "    ldr     r0, _sub_08002524_pool_gGameStuff_tail\n"
        "    ldrb    r0, [r0, #9]\n"
        "    cmp     r0, #14\n"
        "    bne     _sub_08002524_tail_not14\n"
        "    b       _sub_08002524_loopHead\n"
        "_sub_08002524_tail_not14:\n"
        "    cmp     r0, #24\n"
        "    bne     _sub_08002524_epilogue\n"
        "    b       _sub_08002524_loopHead\n"
        "_sub_08002524_epilogue:\n"
        "    add     sp, #4\n"
        "    pop     {r4, r5}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_sub_08002524_pool_gGameStuff_tail:  .4byte 0x03005330\n"
        "    .syntax divided\n");
}

#endif
