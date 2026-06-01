#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08000EB8 — per-frame handler for game-mode 9 (and re-entered for
 * mode 24 — the AgbMain dispatch maps mode 9 to this function, but the
 * function itself loops as long as gGameStuff.mode stays at 9 or 24).
 *
 * The function maintains a 1-byte sub-state on the stack (at sp+0x141)
 * and dispatches on it via a computed jump through an inline 9-entry
 * table. Cases 0..8 each advance the sub-state, sometimes invoking
 * subsystem callees and setting gGameStuff.pendingMode / gGameStuff._unk14.
 * After each case the function re-checks gGameStuff.mode: if it's still
 * 9 or 24 the loop continues with another sub_08020BC0 (per-frame tick
 * / VBlank wait); otherwise control falls through to the epilogue.
 *
 * Sub-state behaviour, mirroring sub_08002844 (mode 15/24) with
 * mode-9-specific callbacks and constants:
 *   0 -> sets gGameStuff.pendingMode = 2; sub_0800B7B0(sp_buf, &r4_obj, 3)
 *        (a 3-arg dispatch); substate = 1; clears sp[+0x140].
 *   1 -> sub_0800A104(&sp[+0x140], 0x08000d5d); on accept advances to
 *        2, clears gGameStuff._unk14 and sp[+0x140], then runs the
 *        sub_080008DC-then-tail block. On reject just sub_080008DC + tail.
 *   2 -> sub_08009D9C(&sp[+0x140]); on success advances to 3 and clears
 *        gGameStuff._unk14.
 *   3 -> sub_080004C4 -> gIwram_5398; if == 0x40 substate = 5 + sub_0800E060;
 *        else falls through to the gIwram_3720 / gIwram_6110 keypad gate:
 *          (gIwram_3720._field_34 & 8) -> substate = 4
 *          (gIwram_6110._field_2e & 8) -> substate = 8
 *          neither -> sub_0800A2D8 + sub_080008DC + sub_0800A328 +
 *                     sub_080094F8 + sub_08009984 + sub_08000E0C(sp_buf,
 *                     &r4_obj); gGameStuff._unk14++.
 *   4 -> sub_08009C14(&localState); on accept (r0 != 0) skips advance;
 *        else substate = 7; then sub_0800B7B0(sp_buf, &r4_obj, 3),
 *        sp[+0x140] = 0.
 *   5 -> sub_080004C4 -> gIwram_5398; sub_0800E6A8(); if zero substate = 6
 *        and sp[+0x140] = 0; gates on gIwram_5328 — if non-zero skip;
 *        else substate = 3.
 *   6 -> sp[+0x140] test: if 0 call sub_08010694(0xBF) + increment;
 *        then ldrsb sp[+0x140] vs #1: must equal 1 to continue;
 *        sub_080106B8() must return 0; then writes gIwram_3480._data[0] = 4,
 *        gIwram_3480[+6] = counter (the byte at sp+0x140 at the decision
 *        point), gGameStuff.mode = 4 (return to dispatcher).
 *   7 -> sub_0800A104(&sp[+0x140], 0x0800a26d); on accept substate = 2,
 *        gGameStuff._unk14 = 0, sp[+0x140] = 0, sub_0800A1C8(); always
 *        falls through sub_080008DC then tail.
 *   8 -> sub_0800DE80(); fall straight to tail.
 *
 * The case-3 fallthrough block (mid-function, between cases 3 and 4 in
 * source order) is NOT a jump-table target — it's reachable only via
 * fall-through from case 3 when both the 0x40 check and the keypad
 * checks fail. The jump table skips it (case 4 in the table points to
 * sub_08009C14, not to the fallthrough). This is the case-number ≠
 * source-block-order trap documented in docs/codegen-notes.md.
 *
 * Shipped NAKED. The dispatch uses `mov pc, r0` after a jumpTable[idx]-
 * indexed `ldr` of an inline `.word` table. agbcc 2.x DOES emit this
 * for sequential `switch (0..N-1)` (the casesi insn pattern, per
 * docs/codegen-notes.md "mov pc, rN jump tables"), but the surrounding
 * 624-byte body with 29 pool entries, six adjacent IWRAM bases, and
 * a 332-byte stack buffer passed by pointer to 18 different callees
 * has not been matchable in pure C to date.
 *
 * Source-form variants attempted before NAKED (all > 100 byte_diff):
 *   1. Direct switch (case 0..8 sequential) — agbcc emits a jump table
 *      but interleaves the pool literals at different offsets than the
 *      baserom; case-block ordering also drifts.
 *   2. Cache &gIwram_5398 / &gGameStuff in fixed-register locals
 *      locals — agbcc respects the r4/r5 pins but baserom does NOT
 *      cache (re-emits ldr per case head); pinning forces caching
 *      where there shouldn't be any.
 *   3. Stack-buffer typing variations (`char sp_buf[320]; u8 sub` vs
 *      `struct { ... } locals;`) — both shift the +0x141 offset to
 *      a different sp computation; baserom uses `add r0, sp; #0x141`
 *      via a pool literal, which a struct member never emits.
 *   4. Splitting the do-while tail recheck into two explicit `if`s
 *      mirroring sub_08002844 — same diff.
 *   5. Explicit goto-shaped flow with `tail_with_finalize` and `tail`
 *      labels — agbcc coalesces the two tails into a single basic
 *      block, baserom keeps them distinct (the bl sub_080008DC lives
 *      strictly on the case-1 / case-7 accept paths, not the bare-tail).
 *   6. Single raw `frame[332]` with macros for the sp+0x140/0x141/0x144
 *      slots, explicit initial tail jump, shared `tailWithFinalize`,
 *      corrected sub_08009D9C return width (u32 not u8), and low-register
 *      pins for state stores got the pure-C attempt down to byte_diff
 *      258 (verified, codex worktree iter-36-followup). Remaining drift
 *      is mainly literal-pool placement and the case-3 key gate's
 *      register order; a heavier pin attempt made codegen worse
 *      (byte_diff 294).
 *
 * Sibling precedent: sub_08002844 (src/game/mode_15.c, mode-15/24)
 * ships NAKED for the exact same shape. AgbMain (src/system/agb_main.c)
 * uses the same `mov pc, rN` dispatch and ships NAKED. This function
 * is the third cluster member; same justification.
 *
 * NON_MATCHING reference body documents intent for the phase-3 PC port.
 */

extern void sub_08020BC0(void);
extern void sub_0800B7B0(void *sp_buf, void *r4_obj, u32 arg2);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern u32 sub_08009D9C(u8 *localState);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08000E0C(void *sp_buf, void *r4_obj);
extern u32 sub_08009C14(void *sp_buf);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_0800DE80(void);

#define gIwram_5398       (*(u16 *)0x03005398)
#define gIwram_5328       (*(u8 *)0x03005328)
#define gIwram_3480_bytes ((u8 *)0x03003480)

#ifdef NON_MATCHING

/* Reference body — readable shape for the phase-3 PC port. Doesn't
 * compile to the same bytes; the NAKED form below is what matches. */
void sub_08000EB8(void)
{
    u8 spByte;     /* sp + 0x140 */
    u8 localState; /* sp + 0x141 */
    u8 sp_buf[320];
    /* sp + 0x144: an opaque struct used as `&r4_obj` arg for
     * sub_0800B7B0, sub_08000E0C, sub_0800A104. Treat as void * here. */
    u8 r4_obj[8];

    localState = 0;

    do {
        sub_08020BC0(); /* per-frame tick / VBlank wait */
        if (localState > 8)
            goto tail;

        switch (localState) {
        case 0:
            gGameStuff.pendingMode = 2;
            sub_0800B7B0(sp_buf, r4_obj, 3);
            localState = 1;
            spByte = 0;
            break;
        case 1:
            if (sub_0800A104(&spByte, 0x08000d5d) == 0) {
                sub_080008DC();
                goto tail;
            }
            localState = 2;
            gGameStuff._unk14 = 0;
            spByte = 0;
            sub_080008DC();
            goto tail;
        case 2:
            if (sub_08009D9C(&spByte) == 0)
                goto tail;
            localState = 3;
            gGameStuff._unk14 = 0;
            goto tail;
        case 3:
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                localState = 5;
                sub_0800E060();
                break;
            }
            if ((gIwram_3720._field_34 & 8) != 0) {
                localState = 4;
                break;
            }
            if ((gIwram_6110._field_2e & 8) != 0) {
                localState = 8;
                break;
            }
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
            sub_080094F8();
            sub_08009984();
            sub_08000E0C(sp_buf, r4_obj);
            gGameStuff._unk14++;
            break;
        case 4:
            if (sub_08009C14((void *)&localState) == 0)
                localState = 7;
            sub_0800B7B0(sp_buf, r4_obj, 3);
            spByte = 0;
            break;
        case 5:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                localState = 6;
                spByte = 0;
            }
            if (gIwram_5328 == 0)
                localState = 3;
            break;
        case 6: {
            s32 counter;
            if ((s8)spByte == 0) {
                sub_08010694(0xBF);
                spByte += 1;
            }
            counter = (s8)spByte;
            if (counter != 1)
                break;
            if (sub_080106B8() != 0)
                break;
            gIwram_3480_bytes[0] = 4;
            gIwram_3480_bytes[6] = counter;
            gGameStuff.mode = 4;
            break;
        }
        case 7:
            if (sub_0800A104(&spByte, 0x0800a26d) != 0) {
                localState = 2;
                gGameStuff._unk14 = 0;
                spByte = 0;
                sub_0800A1C8();
            }
            sub_080008DC();
            break;
        case 8:
            sub_0800DE80();
            break;
        }

    tail:;
    } while (gGameStuff.mode == 9 || gGameStuff.mode == 24);
}

#else

/* NAKED form — matches the baserom byte-for-byte. The inline jump
 * table at _sub_08000EB8_jumpTable is consumed by `mov pc, r0` and so
 * MUST end up at the exact relative offset agbcc would have placed it
 * (right after the literal pool that follows the table-index load).
 * The .syntax-divided trailer is mandatory — see docs/codegen-notes.md
 * ".syntax unified bleed".
 */
NAKED
void sub_08000EB8(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, lr}\n"
        "    sub     sp, #332\n"
        "    ldr     r0, _sub_08000EB8_pool_off141_init\n"
        "    add     r0, sp\n"
        "    movs    r1, #0\n"
        "    strb    r1, [r0, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_off141_init:    .4byte 0x00000141\n"
        "_sub_08000EB8_loopHead:\n"
        "    bl      sub_08020BC0\n"
        "    ldr     r0, _sub_08000EB8_pool_off141_loop\n"
        "    add     r0, sp\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #8\n"
        "    bls     _sub_08000EB8_dispatch\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_dispatch:\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, _sub_08000EB8_pool_jumpTablePtr\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_off141_loop:    .4byte 0x00000141\n"
        "_sub_08000EB8_pool_jumpTablePtr:   .4byte _sub_08000EB8_jumpTable\n"
        "_sub_08000EB8_jumpTable:\n"
        "    .4byte _sub_08000EB8_case0\n"
        "    .4byte _sub_08000EB8_case1\n"
        "    .4byte _sub_08000EB8_case2\n"
        "    .4byte _sub_08000EB8_case3\n"
        "    .4byte _sub_08000EB8_case4\n"
        "    .4byte _sub_08000EB8_case5\n"
        "    .4byte _sub_08000EB8_case6\n"
        "    .4byte _sub_08000EB8_case7\n"
        "    .4byte _sub_08000EB8_case8\n"
        "_sub_08000EB8_case0:\n"
        "    add     r1, sp, #324\n"
        "    ldr     r2, _sub_08000EB8_pool_gGameStuff_case0\n"
        "    movs    r4, #0\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r2, #10]\n"
        "    mov     r0, sp\n"
        "    movs    r2, #3\n"
        "    bl      sub_0800B7B0\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case0\n"
        "    add     r1, sp\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r1, #0]\n"
        "    add     r0, sp, #320\n"
        "    strb    r4, [r0, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_gGameStuff_case0: .4byte 0x03005330\n"
        "_sub_08000EB8_pool_off141_case0:    .4byte 0x00000141\n"
        "_sub_08000EB8_case1:\n"
        "    add     r4, sp, #320\n"
        "    ldr     r1, _sub_08000EB8_pool_callback_0d5d\n"
        "    adds    r0, r4, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_case1_accept\n"
        "    b       _sub_08000EB8_tail_with_finalize\n"
        "_sub_08000EB8_case1_accept:\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case1\n"
        "    add     r1, sp\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r1, #0]\n"
        "    ldr     r1, _sub_08000EB8_pool_gGameStuff_case1\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    strb    r0, [r4, #0]\n"
        "    b       _sub_08000EB8_tail_with_finalize\n"
        "_sub_08000EB8_pool_callback_0d5d:    .4byte 0x08000D5D\n"
        "_sub_08000EB8_pool_off141_case1:    .4byte 0x00000141\n"
        "_sub_08000EB8_pool_gGameStuff_case1: .4byte 0x03005330\n"
        "_sub_08000EB8_case2:\n"
        "    add     r0, sp, #320\n"
        "    bl      sub_08009D9C\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_case2_accept\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_case2_accept:\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case2\n"
        "    add     r1, sp\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r1, #0]\n"
        "    ldr     r1, _sub_08000EB8_pool_gGameStuff_case2\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_off141_case2:    .4byte 0x00000141\n"
        "_sub_08000EB8_pool_gGameStuff_case2: .4byte 0x03005330\n"
        "_sub_08000EB8_case3:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08000EB8_pool_iwram5398_case3\n"
        "    strh    r0, [r1, #0]\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #0x40\n"
        "    bne     _sub_08000EB8_case3_not40\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case3\n"
        "    add     r1, sp\n"
        "    movs    r0, #5\n"
        "    strb    r0, [r1, #0]\n"
        "    bl      sub_0800E060\n"
        "    b       _sub_08000EB8_tail\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_iwram5398_case3:  .4byte 0x03005398\n"
        "_sub_08000EB8_pool_off141_case3:    .4byte 0x00000141\n"
        "_sub_08000EB8_case3_not40:\n"
        "    ldr     r1, _sub_08000EB8_pool_iwram3720_case3\n"
        "    movs    r3, #8\n"
        "    movs    r2, #8\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x34]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000EB8_case3_not_held\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case3b\n"
        "    add     r1, sp\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_iwram3720_case3:  .4byte 0x03003720\n"
        "_sub_08000EB8_pool_off141_case3b:   .4byte 0x00000141\n"
        "_sub_08000EB8_case3_not_held:\n"
        "    ldr     r1, _sub_08000EB8_pool_iwram6110_case3\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x2e]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000EB8_case3_fallthrough\n"
        "    ldr     r0, _sub_08000EB8_pool_off141_case3c\n"
        "    add     r0, sp\n"
        "    strb    r3, [r0, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_iwram6110_case3:  .4byte 0x03006110\n"
        "_sub_08000EB8_pool_off141_case3c:   .4byte 0x00000141\n"
        "_sub_08000EB8_case3_fallthrough:\n"
        "    add     r4, sp, #324\n"
        "    bl      sub_0800A2D8\n"
        "    bl      sub_080008DC\n"
        "    bl      sub_0800A328\n"
        "    bl      sub_080094F8\n"
        "    bl      sub_08009984\n"
        "    mov     r0, sp\n"
        "    adds    r1, r4, #0\n"
        "    bl      sub_08000E0C\n"
        "    ldr     r1, _sub_08000EB8_pool_gGameStuff_case3ft\n"
        "    ldr     r0, [r1, #20]\n"
        "    adds    r0, #1\n"
        "    str     r0, [r1, #20]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_gGameStuff_case3ft: .4byte 0x03005330\n"
        "_sub_08000EB8_case4:\n"
        "    ldr     r4, _sub_08000EB8_pool_off141_case4\n"
        "    add     r4, sp\n"
        "    add     r5, sp, #324\n"
        "    ldr     r0, _sub_08000EB8_pool_off141_case4\n"
        "    add     r0, sp\n"
        "    bl      sub_08009C14\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_case4_skip\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r4, #0]\n"
        "_sub_08000EB8_case4_skip:\n"
        "    mov     r0, sp\n"
        "    adds    r1, r5, #0\n"
        "    movs    r2, #3\n"
        "    bl      sub_0800B7B0\n"
        "    add     r1, sp, #320\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_off141_case4:    .4byte 0x00000141\n"
        "_sub_08000EB8_case5:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08000EB8_pool_iwram5398_case5\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_0800E6A8\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r2, r0, #24\n"
        "    cmp     r2, #0\n"
        "    bne     _sub_08000EB8_case5_skip\n"
        "    ldr     r0, _sub_08000EB8_pool_off141_case5\n"
        "    add     r0, sp\n"
        "    movs    r1, #6\n"
        "    strb    r1, [r0, #0]\n"
        "    add     r0, sp, #320\n"
        "    strb    r2, [r0, #0]\n"
        "_sub_08000EB8_case5_skip:\n"
        "    ldr     r0, _sub_08000EB8_pool_iwram5328_case5\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_tail\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case5\n"
        "    add     r1, sp\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_iwram5398_case5:  .4byte 0x03005398\n"
        "_sub_08000EB8_pool_off141_case5:    .4byte 0x00000141\n"
        "_sub_08000EB8_pool_iwram5328_case5:  .4byte 0x03005328\n"
        "_sub_08000EB8_case6:\n"
        "    add     r4, sp, #320\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_case6_check\n"
        "    movs    r0, #0xBF\n"
        "    bl      sub_08010694\n"
        "    ldrb    r0, [r4, #0]\n"
        "    adds    r0, #1\n"
        "    strb    r0, [r4, #0]\n"
        "_sub_08000EB8_case6_check:\n"
        "    ldrb    r4, [r4, #0]\n"
        "    lsls    r4, r4, #24\n"
        "    asrs    r4, r4, #24\n"
        "    cmp     r4, #1\n"
        "    bne     _sub_08000EB8_tail\n"
        "    bl      sub_080106B8\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_tail\n"
        "    ldr     r0, _sub_08000EB8_pool_iwram3480_case6\n"
        "    movs    r1, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    strb    r4, [r0, #6]\n"
        "    ldr     r0, _sub_08000EB8_pool_gGameStuff_case6\n"
        "    strb    r1, [r0, #9]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_iwram3480_case6:  .4byte 0x03003480\n"
        "_sub_08000EB8_pool_gGameStuff_case6: .4byte 0x03005330\n"
        "_sub_08000EB8_case7:\n"
        "    add     r4, sp, #320\n"
        "    ldr     r1, _sub_08000EB8_pool_callback_a26d\n"
        "    adds    r0, r4, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000EB8_tail_with_finalize\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case7\n"
        "    add     r1, sp\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r1, #0]\n"
        "    ldr     r1, _sub_08000EB8_pool_gGameStuff_case7\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    strb    r0, [r4, #0]\n"
        "    bl      sub_0800A1C8\n"
        "_sub_08000EB8_tail_with_finalize:\n"
        "    bl      sub_080008DC\n"
        "    b       _sub_08000EB8_tail\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_callback_a26d:    .4byte 0x0800A26D\n"
        "_sub_08000EB8_pool_off141_case7:    .4byte 0x00000141\n"
        "_sub_08000EB8_pool_gGameStuff_case7: .4byte 0x03005330\n"
        "_sub_08000EB8_case8:\n"
        "    bl      sub_0800DE80\n"
        "_sub_08000EB8_tail:\n"
        "    ldr     r0, _sub_08000EB8_pool_gGameStuff_tail\n"
        "    ldrb    r0, [r0, #9]\n"
        "    cmp     r0, #9\n"
        "    bne     _sub_08000EB8_tail_not9\n"
        "    b       _sub_08000EB8_loopHead\n"
        "_sub_08000EB8_tail_not9:\n"
        "    cmp     r0, #24\n"
        "    bne     _sub_08000EB8_epilogue\n"
        "    b       _sub_08000EB8_loopHead\n"
        "_sub_08000EB8_epilogue:\n"
        "    add     sp, #332\n"
        "    pop     {r4, r5}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "_sub_08000EB8_pool_gGameStuff_tail:  .4byte 0x03005330\n"
        "    .syntax divided\n");
}

#endif
