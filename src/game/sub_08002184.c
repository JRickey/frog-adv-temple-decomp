#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08002184 — per-frame handler for game-mode 13. AgbMain dispatches
 * mode 13 here; the function loops as long as gGameStuff.mode stays 13.
 *
 * Class-sibling of sub_08002844 (mode 15, src/game/mode_15.c),
 * sub_080019B4 (mode 12), sub_08001214, sub_08001508 and sub_08000EB8 —
 * the same dense 10-case state machine dispatched through a computed
 * `mov pc, r0` over an inline 10-entry `.4byte` table, wrapped in a
 * gGameStuff.mode-gated do/while. Stack frame is 0xCC (204) bytes: the
 * per-frame object handed to sub_08001E24 / sub_0800B7B0 lives at sp+0
 * (0xC0 bytes), an accept-counter byte at sp+0xC0, the dispatch state
 * byte at sp+0xC1 (kept addressed via r6 across the whole loop), and a
 * 28-byte scratch record at sp+0xC4.
 *
 * Sub-state behaviour (dispatch byte at sp+0xC1):
 *   0 -> gGameStuff.pendingMode = 6; r7 = sub_0800A214(); state = 1;
 *        sp[0xC0] = 0; -> tail.
 *   1 -> sub_0800A104(&sp[0xC0], 0x08002451); on accept state = 2,
 *        gGameStuff._unk14 = 0, sp[0xC0] = 0, gIwram_6110[+43] = 0; both
 *        paths join the shared finalize (sub_080008DC) and tail.
 *   2 -> sub_0801B514(6); sub_0800A258(r7); state = 3; tail.
 *   3 -> sub_08009D9C(&sp[0xC0]); on success state = 4,
 *        gGameStuff._unk14 = 0, sub_08006600(gIwram_6110, 8, 0), and
 *        copies gGameStuff._unk00 to gIwram_3720[+0xB54] and [+0xB48].
 *   4 -> gIwram_5398 = sub_080004C4(); if == 0x40 -> state = 5 +
 *        sub_0800E060; else if (gIwram_3720[+0x34] & 8) -> state = 5
 *        (sic, both 0x40 and held-bit paths set 5 here); else if
 *        (gIwram_6110[+0x2E] & 8) -> state = 9; else the fallthrough:
 *        sub_0800A520; two function-pointer calls through
 *        gUnk_080C0CB8[pendingMode] / gUnk_080C0D40[pendingMode] (agbcc
 *        `bl _call_via_r0`); sub_08009A58, sub_08009188, sub_080008DC,
 *        sub_0800A328, sub_080094F8, sub_08009984, sub_08001E24(sp,
 *        sp+0xC4), gGameStuff._unk14++.
 *   5 -> sub_08009C14(&state); on reject state = 8; gIwram_6110[+42] = 0,
 *        gIwram_6110[+12](h) = 0; if gIwram_6110[+43] == 1 sub_0802AB64();
 *        sp[0xC0] = 0; tail.
 *   6 -> gIwram_5398 = sub_080004C4(); sub_0800E6A8(); if zero state = 7,
 *        sp[0xC0] = 0; gates on gIwram_5328 — if non-zero tail, else
 *        state = 4.
 *   7 -> sp[0xC0] (s8): if 0 sub_08010694(0xBF) + increment; require
 *        (s8) == 1; sub_080106B8() must return 0; gIwram_3480[0] = 4,
 *        gIwram_3480[+6] = 1; gGameStuff.mode = 4.
 *   8 -> sub_0800A104(&sp[0xC0], 0x0800A26D); on accept, if
 *        gIwram_6110[+43] == 2 sub_0800B7B0(sp, sp+0xC4, 28) +
 *        sub_08012B38(); then state = 3, sp[0xC0] = 0,
 *        gGameStuff._unk14 = 0, sub_0800A258(r7); both paths join the
 *        shared finalize (sub_080008DC) and tail.
 *   9 -> sub_0800DE80(); tail.
 *
 * Shipped NAKED + NON_MATCHING. This is the mode-X dispatcher cluster
 * documented in docs/codegen-notes.md "mov pc, rN jump tables". agbcc
 * 2.x CAN lower a dense u8 switch to the `mov pc, rN` core (confirmed:
 * the NON_MATCHING body below reproduces the jump table and all ten
 * case bodies in the right order), but it cannot reproduce the two
 * cross-call register pins this function carries: r6 holds &state
 * (sp+0xC1) live across the whole loop and every inner BL, and r7 holds
 * the sub_0800A214() result from case 0 live across loop iterations
 * until case 2 / case 8 consume it via sub_0800A258(r7). agbcc spills
 * those instead, which forces a different prologue (`push {r4-r6, lr}`
 * vs baserom `push {r4-r7, lr}`) and a different stack-frame size
 * (sub sp #224 vs #204). A fixed-register pin cannot help: a
 * stack-address (&state) cannot be a register variable, and pinning r7
 * alone (tried) made the prologue worse (drops to `push {r4, r5, lr}`).
 * Best pure-C byte_diff: 542. Corpus: 2037 `mov pc, rN` hits across the
 * curated agbcc decomps, all inside hand-asm/NAKED, zero matched as a
 * pure-C switch; six in-repo sibling dispatchers all ship NAKED, and
 * this one carries strictly more pins than any of them.
 *
 * The reference summary above documents intent for the phase-3 PC port;
 * the NAKED form below is what compiles byte-identical to baserom. */

extern void sub_08020BC0(void);
extern u32 sub_0800A214(void);
extern u8 sub_0800A104(u8 *state, u32 callbackTable);
extern void sub_0801B514(u32 arg);
extern void sub_0800A258(u32 arg);
extern u8 sub_08009D9C(void *obj);
extern void sub_08006600(void *base, u32 a, u32 b);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800A520(void);
extern void sub_08009A58(void);
extern void sub_08009188(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08001E24(void *obj, void *r4_obj);
extern u32 sub_08009C14(u8 *state);
extern void sub_0802AB64(void);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800B7B0(void *obj, void *r4_obj, u32 size);
extern void sub_08012B38(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

#ifdef NON_MATCHING

/* Reference body — readable shape for the phase-3 PC port. Doesn't
 * compile to the same bytes (see header); the NAKED form below matches. */
void sub_08002184(void)
{
    u8 obj[0xc0];
    u8 subState;
    u8 state;
    u8 frame[28];
    u32 r7;

    state = 0;
    if (gGameStuff.mode != 13)
        return;

    do {
        sub_08020BC0();
        if (state > 9)
            goto tail;

        switch (state) {
        case 0:
            gGameStuff.pendingMode = 6;
            r7 = sub_0800A214();
            state = 1;
            subState = 0;
            break;
        case 1:
            if (sub_0800A104(&subState, 0x08002451)) {
                state = 2;
                gGameStuff._unk14 = 0;
                subState = 0;
                *((u8 *)&gIwram_6110 + 43) = 0;
            }
            sub_080008DC();
            break;
        case 2:
            sub_0801B514(6);
            sub_0800A258(r7);
            state = 3;
            break;
        case 3:
            if (sub_08009D9C(&subState)) {
                state = 4;
                gGameStuff._unk14 = 0;
                sub_08006600(&gIwram_6110, 8, 0);
                *(u32 *)((u8 *)&gIwram_3720 + 0xb54) = gGameStuff._unk00;
                *(u32 *)((u8 *)&gIwram_3720 + 0xb48) = gGameStuff._unk00;
            }
            break;
        case 4:
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                state = 6;
                sub_0800E060();
                break;
            }
            if (gIwram_3720._field_34 & 8) {
                state = 5;
                break;
            }
            if (gIwram_6110.inputFlags & 8) {
                state = 9;
                break;
            }
            sub_0800A520();
            ((void (**)(void))0x080C0CB8)[gGameStuff.pendingMode]();
            ((void (**)(void))0x080C0D40)[gGameStuff.pendingMode]();
            sub_08009A58();
            sub_08009188();
            sub_080008DC();
            sub_0800A328();
            sub_080094F8();
            sub_08009984();
            sub_08001E24(obj, frame);
            gGameStuff._unk14++;
            break;
        case 5:
            if (sub_08009C14(&state) == 0)
                state = 8;
            *((u8 *)&gIwram_6110 + 42) = 0;
            *(u16 *)((u8 *)&gIwram_6110 + 12) = 0;
            if (*((u8 *)&gIwram_6110 + 43) == 1)
                sub_0802AB64();
            subState = 0;
            break;
        case 6:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                state = 7;
                subState = 0;
            }
            if (gIwram_5328 != 0)
                break;
            state = 4;
            break;
        case 7:
            if ((s8)subState == 0) {
                sub_08010694(0xBF);
                subState++;
            }
            if ((s8)subState != 1)
                break;
            if (sub_080106B8())
                break;
            gIwram_3480._data[0] = 4;
            *((u8 *)&gIwram_3480 + 6) = 1;
            gGameStuff.mode = 4;
            break;
        case 8:
            if (sub_0800A104(&subState, 0x0800A26D)) {
                if (*((u8 *)&gIwram_6110 + 43) == 2) {
                    sub_0800B7B0(obj, frame, 28);
                    sub_08012B38();
                }
                state = 3;
                subState = 0;
                gGameStuff._unk14 = 0;
                sub_0800A258(r7);
            }
            sub_080008DC();
            break;
        case 9:
            sub_0800DE80();
            break;
        }

    tail:;
    } while (gGameStuff.mode == 13);
}

#else

/* NAKED form — matches the baserom byte-for-byte. The inline jump table
 * at _sub_08002184_jumpTable is consumed by `mov pc, r0` and MUST land
 * at the exact relative offset agbcc placed it (right after the literal
 * pool that follows the table-index load). The .syntax-divided trailer
 * is mandatory — see docs/codegen-notes.md ".syntax unified bleed". */
NAKED
void sub_08002184(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    sub     sp, #204\n"
        "    mov     r0, sp\n"
        "    adds    r0, #193\n"
        "    movs    r1, #0\n"
        "    strb    r1, [r0, #0]\n"
        "    ldr     r1, _sub_08002184_pool_gGameStuff_1\n"
        "    adds    r6, r0, #0\n"
        "    ldrb    r1, [r1, #9]\n"
        "    cmp     r1, #13\n"
        "    beq     _sub_08002184_loopHead\n"
        "    b       _sub_08002184_epilogue\n"
        "_sub_08002184_loopHead:\n"
        "    bl      sub_08020BC0\n"
        "    ldrb    r0, [r6, #0]\n"
        "    cmp     r0, #9\n"
        "    bls     _sub_08002184_dispatch\n"
        "    b       _sub_08002184_tail\n"
        "_sub_08002184_dispatch:\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, _sub_08002184_pool_jumpTablePtr\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .hword  0\n"
        "_sub_08002184_pool_gGameStuff_1: .4byte 0x03005330\n"
        "_sub_08002184_pool_jumpTablePtr: .4byte _sub_08002184_jumpTable\n"
        "_sub_08002184_jumpTable:\n"
        "    .4byte _sub_08002184_case0\n"
        "    .4byte _sub_08002184_case1\n"
        "    .4byte _sub_08002184_case2\n"
        "    .4byte _sub_08002184_case3\n"
        "    .4byte _sub_08002184_case4\n"
        "    .4byte _sub_08002184_case5\n"
        "    .4byte _sub_08002184_case6\n"
        "    .4byte _sub_08002184_case7\n"
        "    .4byte _sub_08002184_case8\n"
        "    .4byte _sub_08002184_case9\n"
        "_sub_08002184_case0:\n"
        "    ldr     r1, _sub_08002184_pool_gGameStuff_case0\n"
        "    movs    r4, #0\n"
        "    movs    r0, #6\n"
        "    strb    r0, [r1, #10]\n"
        "    bl      sub_0800A214\n"
        "    adds    r7, r0, #0\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08002184_case5_storeC0\n"
        "_sub_08002184_pool_gGameStuff_case0: .4byte 0x03005330\n"
        "_sub_08002184_case1:\n"
        "    add     r4, sp, #192\n"
        "    ldr     r1, _sub_08002184_pool_callback_2451\n"
        "    adds    r0, r4, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002184_case1_accept\n"
        "    b       _sub_08002184_finalize\n"
        "_sub_08002184_case1_accept:\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r0, _sub_08002184_pool_gGameStuff_case1\n"
        "    movs    r1, #0\n"
        "    str     r1, [r0, #20]\n"
        "    strb    r1, [r4, #0]\n"
        "    ldr     r0, _sub_08002184_pool_iwram6110_case1\n"
        "    adds    r0, #43\n"
        "    strb    r1, [r0, #0]\n"
        "    b       _sub_08002184_finalize\n"
        "    .hword  0\n"
        "_sub_08002184_pool_callback_2451:    .4byte 0x08002451\n"
        "_sub_08002184_pool_gGameStuff_case1: .4byte 0x03005330\n"
        "_sub_08002184_pool_iwram6110_case1:  .4byte 0x03006110\n"
        "_sub_08002184_case2:\n"
        "    movs    r0, #6\n"
        "    bl      sub_0801B514\n"
        "    adds    r0, r7, #0\n"
        "    bl      sub_0800A258\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08002184_tail\n"
        "_sub_08002184_case3:\n"
        "    add     r0, sp, #192\n"
        "    bl      sub_08009D9C\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002184_case3_accept\n"
        "    b       _sub_08002184_tail\n"
        "_sub_08002184_case3_accept:\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r4, _sub_08002184_pool_gGameStuff_case3\n"
        "    movs    r0, #0\n"
        "    str     r0, [r4, #20]\n"
        "    ldr     r0, _sub_08002184_pool_iwram6110_case3\n"
        "    movs    r1, #8\n"
        "    movs    r2, #0\n"
        "    bl      sub_08006600\n"
        "    ldr     r0, _sub_08002184_pool_iwram3720_case3\n"
        "    ldr     r2, _sub_08002184_pool_offb54_case3\n"
        "    adds    r1, r0, r2\n"
        "    ldr     r2, [r4, #0]\n"
        "    str     r2, [r1, #0]\n"
        "    ldr     r1, _sub_08002184_pool_offb48_case3\n"
        "    adds    r0, r0, r1\n"
        "    str     r2, [r0, #0]\n"
        "    b       _sub_08002184_tail\n"
        "_sub_08002184_pool_gGameStuff_case3: .4byte 0x03005330\n"
        "_sub_08002184_pool_iwram6110_case3:  .4byte 0x03006110\n"
        "_sub_08002184_pool_iwram3720_case3:  .4byte 0x03003720\n"
        "_sub_08002184_pool_offb54_case3:     .4byte 0x00000b54\n"
        "_sub_08002184_pool_offb48_case3:     .4byte 0x00000b48\n"
        "_sub_08002184_case4:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08002184_pool_iwram5398_case4\n"
        "    strh    r0, [r1, #0]\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #0x40\n"
        "    bne     _sub_08002184_case4_not40\n"
        "    movs    r0, #6\n"
        "    strb    r0, [r6, #0]\n"
        "    bl      sub_0800E060\n"
        "    b       _sub_08002184_tail\n"
        "    .hword  0\n"
        "_sub_08002184_pool_iwram5398_case4:  .4byte 0x03005398\n"
        "_sub_08002184_case4_not40:\n"
        "    ldr     r1, _sub_08002184_pool_iwram3720_case4\n"
        "    movs    r2, #8\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x34]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08002184_case4_not_held\n"
        "    movs    r0, #5\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08002184_tail\n"
        "_sub_08002184_pool_iwram3720_case4:  .4byte 0x03003720\n"
        "_sub_08002184_case4_not_held:\n"
        "    ldr     r1, _sub_08002184_pool_iwram6110_case4\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x2e]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08002184_case4_fallthrough\n"
        "    movs    r0, #9\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08002184_tail\n"
        "    .hword  0\n"
        "_sub_08002184_pool_iwram6110_case4:  .4byte 0x03006110\n"
        "_sub_08002184_case4_fallthrough:\n"
        "    add     r5, sp, #196\n"
        "    bl      sub_0800A520\n"
        "    ldr     r1, _sub_08002184_pool_procA_case4\n"
        "    ldr     r4, _sub_08002184_pool_gGameStuff_case4\n"
        "    ldrb    r2, [r4, #10]\n"
        "    lsls    r0, r2, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    bl      _call_via_r0\n"
        "    ldr     r1, _sub_08002184_pool_procB_case4\n"
        "    ldrb    r2, [r4, #10]\n"
        "    lsls    r0, r2, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    bl      _call_via_r0\n"
        "    bl      sub_08009A58\n"
        "    bl      sub_08009188\n"
        "    bl      sub_080008DC\n"
        "    bl      sub_0800A328\n"
        "    bl      sub_080094F8\n"
        "    bl      sub_08009984\n"
        "    mov     r0, sp\n"
        "    adds    r1, r5, #0\n"
        "    bl      sub_08001E24\n"
        "    ldr     r0, [r4, #20]\n"
        "    adds    r0, #1\n"
        "    str     r0, [r4, #20]\n"
        "    b       _sub_08002184_tail\n"
        "_sub_08002184_pool_procA_case4:      .4byte 0x080c0cb8\n"
        "_sub_08002184_pool_gGameStuff_case4: .4byte 0x03005330\n"
        "_sub_08002184_pool_procB_case4:      .4byte 0x080c0d40\n"
        "_sub_08002184_case5:\n"
        "    adds    r0, r6, #0\n"
        "    bl      sub_08009C14\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002184_case5_no8\n"
        "    movs    r0, #8\n"
        "    strb    r0, [r6, #0]\n"
        "_sub_08002184_case5_no8:\n"
        "    ldr     r0, _sub_08002184_pool_iwram6110_case5\n"
        "    adds    r2, r0, #0\n"
        "    adds    r2, #42\n"
        "    movs    r1, #0\n"
        "    strb    r1, [r2, #0]\n"
        "    movs    r4, #0\n"
        "    strh    r1, [r0, #12]\n"
        "    adds    r0, #43\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #1\n"
        "    bne     _sub_08002184_case5_storeC0\n"
        "    bl      sub_0802AB64\n"
        "_sub_08002184_case5_storeC0:\n"
        "    add     r0, sp, #192\n"
        "    strb    r4, [r0, #0]\n"
        "    b       _sub_08002184_tail\n"
        "    .hword  0\n"
        "_sub_08002184_pool_iwram6110_case5:  .4byte 0x03006110\n"
        "_sub_08002184_case6:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08002184_pool_iwram5398_case6\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_0800E6A8\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r1, r0, #24\n"
        "    cmp     r1, #0\n"
        "    bne     _sub_08002184_case6_check5328\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r6, #0]\n"
        "    add     r0, sp, #192\n"
        "    strb    r1, [r0, #0]\n"
        "_sub_08002184_case6_check5328:\n"
        "    ldr     r0, _sub_08002184_pool_iwram5328_case6\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002184_tail\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08002184_tail\n"
        "    .hword  0\n"
        "_sub_08002184_pool_iwram5398_case6:  .4byte 0x03005398\n"
        "_sub_08002184_pool_iwram5328_case6:  .4byte 0x03005328\n"
        "_sub_08002184_case7:\n"
        "    add     r4, sp, #192\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002184_case7_have\n"
        "    movs    r0, #0xBF\n"
        "    bl      sub_08010694\n"
        "    ldrb    r0, [r4, #0]\n"
        "    adds    r0, #1\n"
        "    strb    r0, [r4, #0]\n"
        "_sub_08002184_case7_have:\n"
        "    ldrb    r4, [r4, #0]\n"
        "    lsls    r4, r4, #24\n"
        "    asrs    r4, r4, #24\n"
        "    cmp     r4, #1\n"
        "    bne     _sub_08002184_tail\n"
        "    bl      sub_080106B8\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08002184_tail\n"
        "    ldr     r0, _sub_08002184_pool_iwram3480_case7\n"
        "    movs    r1, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    strb    r4, [r0, #6]\n"
        "    ldr     r0, _sub_08002184_pool_gGameStuff_case7\n"
        "    strb    r1, [r0, #9]\n"
        "    b       _sub_08002184_tail\n"
        "_sub_08002184_pool_iwram3480_case7:  .4byte 0x03003480\n"
        "_sub_08002184_pool_gGameStuff_case7: .4byte 0x03005330\n"
        "_sub_08002184_case8:\n"
        "    add     r4, sp, #192\n"
        "    ldr     r1, _sub_08002184_pool_callback_a26d\n"
        "    adds    r0, r4, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08002184_finalize\n"
        "    ldr     r0, _sub_08002184_pool_iwram6110_case8\n"
        "    adds    r0, #43\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #2\n"
        "    bne     _sub_08002184_case8_advance\n"
        "    add     r1, sp, #196\n"
        "    mov     r0, sp\n"
        "    movs    r2, #28\n"
        "    bl      sub_0800B7B0\n"
        "    bl      sub_08012B38\n"
        "_sub_08002184_case8_advance:\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r4, #0]\n"
        "    ldr     r1, _sub_08002184_pool_gGameStuff_case8\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    adds    r0, r7, #0\n"
        "    bl      sub_0800A258\n"
        "_sub_08002184_finalize:\n"
        "    bl      sub_080008DC\n"
        "    b       _sub_08002184_tail\n"
        "    .hword  0\n"
        "_sub_08002184_pool_callback_a26d:    .4byte 0x0800a26d\n"
        "_sub_08002184_pool_iwram6110_case8:  .4byte 0x03006110\n"
        "_sub_08002184_pool_gGameStuff_case8: .4byte 0x03005330\n"
        "_sub_08002184_case9:\n"
        "    bl      sub_0800DE80\n"
        "_sub_08002184_tail:\n"
        "    ldr     r0, _sub_08002184_pool_gGameStuff_tail\n"
        "    ldrb    r0, [r0, #9]\n"
        "    cmp     r0, #13\n"
        "    bne     _sub_08002184_epilogue\n"
        "    b       _sub_08002184_loopHead\n"
        "_sub_08002184_epilogue:\n"
        "    add     sp, #204\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .hword  0\n"
        "_sub_08002184_pool_gGameStuff_tail:  .4byte 0x03005330\n"
        "    .syntax divided\n");
}

#endif
