#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08001508 — per-frame handler for game-mode 11 (and re-entered for
 * mode 24 — the AgbMain dispatch maps mode 11 to this function, but the
 * function itself loops as long as gGameStuff.mode stays at 11 or 24).
 *
 * Class-sibling of sub_08000EB8 (mode 9) and sub_08002844 (mode 15).
 * Stack frame is 84 bytes here vs 332 in sub_08000EB8: localState lives
 * at sp+0x49 (cached into r6 in the prologue), spByte at sp+0x48, and
 * the r4_obj area passed to sub_0800B7B0 / sub_0800B918 / sub_0800B8A8
 * sits at sp+0x4c. The prologue saves {r4-r7, lr} (five regs).
 *
 * Sub-state behaviour, mirroring sub_08000EB8 with mode-11-specific
 * callbacks and constants:
 *   0 -> gGameStuff.pendingMode = 4; sub_0800B7B0(sp_buf, &r4_obj, 4);
 *        substate = 1; clears sp[+0x48].
 *   1 -> sub_0800A104(&sp[+0x48], 0x080017a9); on accept advances to 2,
 *        clears gGameStuff._unk14 and sp[+0x48], then runs the
 *        sub_080008DC-then-tail block. On reject just sub_080008DC + tail.
 *   2 -> sub_08009D9C(&sp[+0x48]); on success advances to 3 and clears
 *        gGameStuff._unk14.
 *   3 -> sub_080004C4 -> gIwram_5398; if == 0x40 substate = 5 + sub_0800E060;
 *        else falls through to the gIwram_3720 / gIwram_6110 keypad gate:
 *          (gIwram_3720._field_34 & 8) -> substate = 4
 *          (gIwram_6110._keysJust & 8) -> substate = 8
 *          neither -> sub_0800A2D8 + sub_080008DC + sub_0800A328 +
 *                     sub_080094F8 + sub_08009984 + inline-probe-block
 *                     (sub_0800B918 + tile-probe + optional sub_0800B8A8);
 *                     gGameStuff._unk14++.
 *   4 -> sub_08009C14(&sp[+0x49]); on reject (r0 == 0) substate = 7;
 *        sub_0800B7B0(sp_buf, &r4_obj, 4); sp[+0x48] = 0.
 *   5 -> sub_080004C4 -> gIwram_5398; sub_0800E6A8(); if zero substate = 6
 *        and sp[+0x48] = 0; gates on gIwram_5328 — if non-zero skip;
 *        else substate = 3.
 *   6 -> sp[+0x48] test: if 0 call sub_08010694(0xBF) + increment;
 *        then ldrsb sp[+0x48] vs #1: must equal 1 to continue;
 *        sub_080106B8() must return 0; then gIwram_3480._data[0] = 4,
 *        gIwram_3480[+6] = 0 (counter at decision point), and an extra
 *        case-5-trailing pair: a bgt-#1 on (s8)gIwram_35E0._field_5
 *        clears gIwram_6110+{16,38} (when <=1) or sets gIwram_6110+16=5
 *        (when >1); both paths land at gGameStuff.mode = 4 via
 *        sub_08009C14's natural state machine. (See case-6 disasm at
 *        0x080016a8..0x080016c8 — distinct from sub_08000EB8's case 6.)
 *   7 -> sub_0800A104(&sp[+0x48], 0x0800a26d); on accept substate = 2,
 *        gGameStuff._unk14 = 0, sp[+0x48] = 0, sub_0800A1C8(); always
 *        falls through sub_080008DC then tail.
 *   8 -> sub_0800DE80(); fall straight to tail.
 *
 * NB: case 4 here passes `&localState` (r6 = sp+0x49) to sub_08009C14,
 * not sp_buf. The sub_0800B7B0 calls in case 0 and case 4 both use
 * arg2 = 4 (sub_08000EB8 used 3). Case 3's fallthrough inlines a probe
 * block similar in shape to sub_08000E0C but trimmed: no sub_0800C358
 * call, no sub_08006BA4 four-way coord-compare — just B918, the
 * gIwram_3720._field_34 & 4 gate, the tile probe, and a conditional
 * sub_0800B8A8 if (gIwram_35E0._field_10 & 0x10).
 *
 * Case-6 trailing block (0x080016a8..0x080016c8) is unique to this
 * function: reads gIwram_35E0._field_5 (s8) and clears or sets fields
 * at gIwram_6110+{16,38} based on (s8) comparison to 1. The fallthrough
 * also sets gIwram_3480._data[0] = 4 and a separate strb at +6.
 *
 * Shipped NAKED. Same class-edge as sub_08000EB8: `mov pc, r0` after an
 * indexed `ldr` of a 9-entry inline `.4byte` jump table. The 652-byte
 * body's pool literal layout (21 distinct entries, six adjacent IWRAM
 * bases, recurring `0x141`/`0x49`-like sp-offset constants) has never
 * been pure-C matchable in the corpus for this idiom.
 *
 * Sibling precedent shipped NAKED:
 *   - src/system/agb_main.c (AgbMain) — top-level `mov pc, rN` dispatch
 *   - src/system/sub_08000eb8.c (sub_08000EB8, mode 9) — the same 9-case
 *     stateful inner loop, slightly different mode constants and frame
 *   - src/game/mode_15.c (sub_08002844, mode 15/24) — first member of
 *     the cluster
 *
 * NON_MATCHING reference body documents intent for the phase-3 PC port. */

extern void sub_08020BC0(void);
extern void sub_0800B7B0(void *sp_buf, void *r4_obj, u32 arg2);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern u8 sub_08009D9C(u8 *localState);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_0800B918(void *ent, u32 arg1, u32 kind);
extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_0800B8A8(void *ent, u32 arg1, u32 kind, u32 tile);
extern u32 sub_08009C14(void *p);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

#ifdef NON_MATCHING

/* Reference body — readable shape for the phase-3 PC port. Doesn't
 * compile to the same bytes; the NAKED form below is what matches. */
void sub_08001508(void)
{
    u8 spByte;     /* sp + 0x48 */
    u8 localState; /* sp + 0x49 */
    u8 sp_buf[72]; /* sp..sp+0x48 */
    u8 r4_obj[8];  /* sp + 0x4c..sp + 0x54 */

    localState = 0;

    if (gGameStuff.mode != 11 && gGameStuff.mode != 24)
        return;

    do {
        sub_08020BC0(); /* per-frame tick / VBlank wait */
        if (localState > 8)
            goto tail;

        switch (localState) {
        case 0:
            gGameStuff.pendingMode = 4;
            sub_0800B7B0(sp_buf, r4_obj, 4);
            localState = 1;
            spByte = 0;
            break;
        case 1:
            if (sub_0800A104(&spByte, 0x080017a9) == 0) {
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
            if ((*(u16 *)((u8 *)&gIwram_6110 + 0x2e) & 8) != 0) {
                localState = 8;
                break;
            }
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
            sub_080094F8();
            sub_08009984();
            sub_0800B918(sp_buf, r4_obj, 4);
            if ((gIwram_3720._field_34 & 4) == 0) {
                u8 tile = (u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                           gIwram_35E0._field_A);
                if ((gIwram_35E0._field_10 & 0x10) != 0)
                    sub_0800B8A8(sp_buf, r4_obj, 4, tile);
            }
            gGameStuff._unk14++;
            break;
        case 4:
            if (sub_08009C14(&localState) == 0)
                localState = 7;
            sub_0800B7B0(sp_buf, r4_obj, 4);
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
            gIwram_3480._data[0] = 4;
            /* gIwram_3480[+6] = 0 (counter at the decision point) */
            /* trailing case-6 bgt block on (s8)gIwram_35E0._field_5 — see
             * function-level comment for details */
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
    } while (gGameStuff.mode == 11 || gGameStuff.mode == 24);
}

#else

/* NAKED form — matches the baserom byte-for-byte. The inline jump table
 * at _sub_08001508_jumpTable is consumed by `mov pc, r0` and MUST end
 * up at the exact relative offset agbcc would have placed it (right
 * after the literal pool that follows the table-index load). The
 * .syntax-divided trailer is mandatory — see docs/codegen-notes.md
 * ".syntax unified bleed". */
NAKED
void sub_08001508(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    sub     sp, #84\n"
        "    mov     r0, sp\n"
        "    adds    r0, #73\n"
        "    movs    r1, #0\n"
        "    strb    r1, [r0, #0]\n"
        "    ldr     r1, _sub_08001508_pool_gGameStuff_entry\n"
        "    ldrb    r1, [r1, #9]\n"
        "    adds    r6, r0, #0\n"
        "    cmp     r1, #11\n"
        "    beq     _sub_08001508_loopHead\n"
        "    cmp     r1, #24\n"
        "    beq     _sub_08001508_loopHead\n"
        "    b       _sub_08001508_epilogue\n"
        "_sub_08001508_loopHead:\n"
        "    bl      sub_08020BC0\n"
        "    ldrb    r0, [r6, #0]\n"
        "    cmp     r0, #8\n"
        "    bls     _sub_08001508_dispatch\n"
        "    b       _sub_08001508_tail\n"
        "_sub_08001508_dispatch:\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, _sub_08001508_pool_jumpTablePtr\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .hword  0\n"
        "_sub_08001508_pool_gGameStuff_entry: .4byte 0x03005330\n"
        "_sub_08001508_pool_jumpTablePtr:   .4byte _sub_08001508_jumpTable\n"
        "_sub_08001508_jumpTable:\n"
        "    .4byte _sub_08001508_case0\n"
        "    .4byte _sub_08001508_case1\n"
        "    .4byte _sub_08001508_case2\n"
        "    .4byte _sub_08001508_case3\n"
        "    .4byte _sub_08001508_case4\n"
        "    .4byte _sub_08001508_case5\n"
        "    .4byte _sub_08001508_case6\n"
        "    .4byte _sub_08001508_case7\n"
        "    .4byte _sub_08001508_case8\n"
        "_sub_08001508_case0:\n"
        "    add     r1, sp, #76\n"
        "    ldr     r2, _sub_08001508_pool_gGameStuff_case0\n"
        "    movs    r4, #0\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r2, #10]\n"
        "    mov     r0, sp\n"
        "    movs    r2, #4\n"
        "    bl      sub_0800B7B0\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r6, #0]\n"
        "    add     r0, sp, #72\n"
        "    strb    r4, [r0, #0]\n"
        "    b       _sub_08001508_tail\n"
        "_sub_08001508_pool_gGameStuff_case0: .4byte 0x03005330\n"
        "_sub_08001508_case1:\n"
        "    add     r4, sp, #72\n"
        "    ldr     r1, _sub_08001508_pool_callback_17a9\n"
        "    adds    r0, r4, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001508_case1_accept\n"
        "    b       _sub_08001508_tail_with_finalize\n"
        "_sub_08001508_case1_accept:\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r1, _sub_08001508_pool_gGameStuff_case1\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    strb    r0, [r4, #0]\n"
        "    b       _sub_08001508_tail_with_finalize\n"
        "_sub_08001508_pool_callback_17a9:    .4byte 0x080017a9\n"
        "_sub_08001508_pool_gGameStuff_case1: .4byte 0x03005330\n"
        "_sub_08001508_case2:\n"
        "    add     r0, sp, #72\n"
        "    bl      sub_08009D9C\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001508_case2_accept\n"
        "    b       _sub_08001508_tail\n"
        "_sub_08001508_case2_accept:\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r1, _sub_08001508_pool_gGameStuff_case2\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    b       _sub_08001508_tail\n"
        "_sub_08001508_pool_gGameStuff_case2: .4byte 0x03005330\n"
        "_sub_08001508_case3:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08001508_pool_iwram5398_case3\n"
        "    strh    r0, [r1, #0]\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #0x40\n"
        "    bne     _sub_08001508_case3_not40\n"
        "    movs    r0, #5\n"
        "    strb    r0, [r6, #0]\n"
        "    bl      sub_0800E060\n"
        "    b       _sub_08001508_tail\n"
        "    .hword  0\n"
        "_sub_08001508_pool_iwram5398_case3:  .4byte 0x03005398\n"
        "_sub_08001508_case3_not40:\n"
        "    ldr     r4, _sub_08001508_pool_iwram3720_case3\n"
        "    movs    r3, #8\n"
        "    movs    r2, #8\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r4, #0x34]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08001508_case3_not_held\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08001508_tail\n"
        "    .hword  0\n"
        "_sub_08001508_pool_iwram3720_case3:  .4byte 0x03003720\n"
        "_sub_08001508_case3_not_held:\n"
        "    ldr     r1, _sub_08001508_pool_iwram6110_case3\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x2e]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08001508_case3_fallthrough\n"
        "    strb    r3, [r6, #0]\n"
        "    b       _sub_08001508_tail\n"
        "_sub_08001508_pool_iwram6110_case3:  .4byte 0x03006110\n"
        "_sub_08001508_case3_fallthrough:\n"
        "    add     r5, sp, #76\n"
        "    bl      sub_0800A2D8\n"
        "    bl      sub_080008DC\n"
        "    bl      sub_0800A328\n"
        "    bl      sub_080094F8\n"
        "    bl      sub_08009984\n"
        "    mov     r0, sp\n"
        "    adds    r1, r5, #0\n"
        "    movs    r2, #4\n"
        "    bl      sub_0800B918\n"
        "    movs    r0, #4\n"
        "    ldrh    r4, [r4, #0x34]\n"
        "    ands    r0, r4\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001508_case3_post\n"
        "    ldr     r4, _sub_08001508_pool_iwram35e0_case3\n"
        "    ldrb    r0, [r4, #24]\n"
        "    ldrb    r1, [r4, #25]\n"
        "    movs    r3, #8\n"
        "    ldrsh   r2, [r4, r3]\n"
        "    movs    r7, #10\n"
        "    ldrsh   r3, [r4, r7]\n"
        "    bl      sub_0800CD88\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r3, r0, #24\n"
        "    movs    r0, #16\n"
        "    ldrh    r4, [r4, #16]\n"
        "    ands    r0, r4\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08001508_case3_post\n"
        "    mov     r0, sp\n"
        "    adds    r1, r5, #0\n"
        "    movs    r2, #4\n"
        "    bl      sub_0800B8A8\n"
        "_sub_08001508_case3_post:\n"
        "    ldr     r1, _sub_08001508_pool_gGameStuff_case3\n"
        "    ldr     r0, [r1, #20]\n"
        "    adds    r0, #1\n"
        "    str     r0, [r1, #20]\n"
        "    b       _sub_08001508_tail\n"
        "    .hword  0\n"
        "_sub_08001508_pool_iwram35e0_case3:  .4byte 0x030035e0\n"
        "_sub_08001508_pool_gGameStuff_case3: .4byte 0x03005330\n"
        "_sub_08001508_case4:\n"
        "    add     r4, sp, #76\n"
        "    adds    r0, r6, #0\n"
        "    bl      sub_08009C14\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001508_case4_skip\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r6, #0]\n"
        "_sub_08001508_case4_skip:\n"
        "    mov     r0, sp\n"
        "    adds    r1, r4, #0\n"
        "    movs    r2, #4\n"
        "    bl      sub_0800B7B0\n"
        "    ldr     r0, _sub_08001508_pool_iwram35e0_case4\n"
        "    ldrb    r0, [r0, #5]\n"
        "    lsls    r0, r0, #24\n"
        "    asrs    r0, r0, #24\n"
        "    cmp     r0, #1\n"
        "    bgt     _sub_08001508_case4_gt1\n"
        "    ldr     r1, _sub_08001508_pool_iwram6110_case4a\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #16]\n"
        "    strh    r0, [r1, #0x26]\n"
        "    b       _sub_08001508_case4_post\n"
        "_sub_08001508_pool_iwram35e0_case4:  .4byte 0x030035e0\n"
        "_sub_08001508_pool_iwram6110_case4a: .4byte 0x03006110\n"
        "_sub_08001508_case4_gt1:\n"
        "    ldr     r1, _sub_08001508_pool_iwram6110_case4b\n"
        "    movs    r0, #5\n"
        "    str     r0, [r1, #16]\n"
        "_sub_08001508_case4_post:\n"
        "    add     r1, sp, #72\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08001508_tail\n"
        "    .hword  0\n"
        "_sub_08001508_pool_iwram6110_case4b: .4byte 0x03006110\n"
        "_sub_08001508_case5:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08001508_pool_iwram5398_case5\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_0800E6A8\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r1, r0, #24\n"
        "    cmp     r1, #0\n"
        "    bne     _sub_08001508_case5_skip\n"
        "    movs    r0, #6\n"
        "    strb    r0, [r6, #0]\n"
        "    add     r0, sp, #72\n"
        "    strb    r1, [r0, #0]\n"
        "_sub_08001508_case5_skip:\n"
        "    ldr     r0, _sub_08001508_pool_iwram5328_case5\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001508_tail\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08001508_tail\n"
        "    .hword  0\n"
        "_sub_08001508_pool_iwram5398_case5:  .4byte 0x03005398\n"
        "_sub_08001508_pool_iwram5328_case5:  .4byte 0x03005328\n"
        "_sub_08001508_case6:\n"
        "    add     r4, sp, #72\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001508_case6_check\n"
        "    movs    r0, #0xBF\n"
        "    bl      sub_08010694\n"
        "    ldrb    r0, [r4, #0]\n"
        "    adds    r0, #1\n"
        "    strb    r0, [r4, #0]\n"
        "_sub_08001508_case6_check:\n"
        "    ldrb    r4, [r4, #0]\n"
        "    lsls    r4, r4, #24\n"
        "    asrs    r4, r4, #24\n"
        "    cmp     r4, #1\n"
        "    bne     _sub_08001508_tail\n"
        "    bl      sub_080106B8\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08001508_tail\n"
        "    ldr     r0, _sub_08001508_pool_iwram3480_case6\n"
        "    movs    r1, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    strb    r4, [r0, #6]\n"
        "    ldr     r0, _sub_08001508_pool_gGameStuff_case6\n"
        "    strb    r1, [r0, #9]\n"
        "    b       _sub_08001508_tail\n"
        "_sub_08001508_pool_iwram3480_case6:  .4byte 0x03003480\n"
        "_sub_08001508_pool_gGameStuff_case6: .4byte 0x03005330\n"
        "_sub_08001508_case7:\n"
        "    add     r4, sp, #72\n"
        "    ldr     r1, _sub_08001508_pool_callback_a26d\n"
        "    adds    r0, r4, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08001508_tail_with_finalize\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r1, _sub_08001508_pool_gGameStuff_case7\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    strb    r0, [r4, #0]\n"
        "    bl      sub_0800A1C8\n"
        "_sub_08001508_tail_with_finalize:\n"
        "    bl      sub_080008DC\n"
        "    b       _sub_08001508_tail\n"
        "    .hword  0\n"
        "_sub_08001508_pool_callback_a26d:    .4byte 0x0800a26d\n"
        "_sub_08001508_pool_gGameStuff_case7: .4byte 0x03005330\n"
        "_sub_08001508_case8:\n"
        "    bl      sub_0800DE80\n"
        "_sub_08001508_tail:\n"
        "    ldr     r0, _sub_08001508_pool_gGameStuff_tail\n"
        "    ldrb    r0, [r0, #9]\n"
        "    cmp     r0, #11\n"
        "    bne     _sub_08001508_tail_not11\n"
        "    b       _sub_08001508_loopHead\n"
        "_sub_08001508_tail_not11:\n"
        "    cmp     r0, #24\n"
        "    bne     _sub_08001508_epilogue\n"
        "    b       _sub_08001508_loopHead\n"
        "_sub_08001508_epilogue:\n"
        "    add     sp, #84\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "_sub_08001508_pool_gGameStuff_tail:  .4byte 0x03005330\n"
        "    .syntax divided\n");
}

#endif
