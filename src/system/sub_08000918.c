#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08000918 — mode-2 (gameplay) per-tick state-machine dispatcher.
 *
 * This is the central per-tick driver for mode 2 (in-game) and mode 8
 * (paused / transition variant). AgbMain calls it once per frame while
 * gGameStuff.mode is 2/8/24; the function then runs an internal "wait
 * loop" that re-dispatches as long as the mode stays 8 or 24.
 *
 * Sibling of sub_08009D9C (per-tick entity advance) — both shipped NAKED
 * for the same reasons. This one is bigger (~298 instr vs sub_08009D9C's
 * ~80) and adds:
 *   - PC-relative jump-table dispatch via `mov pc, r0` from a 14-entry
 *     .word table at 0x08000954. agbcc 2.x cannot emit `mov pc, rN` from
 *     C `switch` — it falls back to a compare-and-branch chain.
 *   - 6 distinct IWRAM bases (0x03005330 gGameStuff, 0x03005398,
 *     0x03003720, 0x03006110, 0x03005328, 0x03003480) referenced in
 *     adjacent basic blocks. Per docs/codegen-notes.md "Adjacent IWRAM
 *     bases — defeat CSE-fold via linker-assigned symbols", letting
 *     agbcc see these as raw absolute addresses would CSE-fold them.
 *   - The 14-case state machine sequences through gameplay setup phases.
 *     Active cases (jump table at 0x08000954):
 *       0  init prep — sub_08000C98 → state := 1
 *       1  async-wait gate — sub_0800A104 poll, advance to state 2 on accept
 *       2  per-tick advance — sub_08009D9C gate, advance to state 3 on tick
 *       3  engine init — sub_080004C4 (writes 0x03005398). Special cases:
 *            value==0x40 → state 6 + sub_0800E060
 *            bit 8 of gIwram_3720[0x34] set → state 4
 *            bit 2 of gIwram_6110[0x2e] set → sub_08006948(2) + sub_08009BA0
 *              -1 + sub_0800E600 + state 5
 *            bit 8 of gIwram_6110[0x2e] set → sub_08006948(8) + state 13
 *            else fall through to sub_08000CEC (case 3's inner block)
 *       4  sub_0800EF90 + sub_08000D2C, clears latch
 *       5  sub_080004C4 + sub_0800FD50 gate; on FD50==0 → state 3 +
 *            sub_08006948(2)
 *       6  sub_080004C4 + sub_0800E6A8 gate; on E6A8==0 → sub_0800EF90 +
 *            state 7; checks gIwram_5328 → state 3 on zero
 *       7  cleanup latch — sub_08010694(0xbf) + sub_080106B8 wait +
 *            snap mode to 4 (gGameStuff.mode = 4)
 *       8  retry-wait gate — sub_0800A104 + sub_0800A1C8 + sub_080008DC
 *       13 just calls sub_08000D50 (post-loop hook)
 *     Cases 9-12 are no-op (jump table → tail directly).
 *   - A common tail at 0x08000b50 reads gGameStuff.mode and jumps back
 *     to 0x08000934 (the dispatch head) while mode is 8 or 24,
 *     producing the wait-loop shape.
 *
 * The 14-entry jump table is preserved verbatim in the NAKED body via
 * .4byte literals (cases 9-12 all share the tail label). Local stack
 * scratch frame is 52 bytes (`sub sp, #0x34`); the dispatch state byte
 * lives at sp+0x29 (loaded into r6 as a stable pointer), a secondary
 * latch lives at sp+0x28, and a third at sp+0x2c.
 *
 * Shipped NAKED + #ifdef NON_MATCHING. `mov pc, r0` jump-table dispatch
 * is the dispositive blocker (agbcc emits cmp/beq chains, never
 * computed branch); the 6 adjacent IWRAM bases compound it. The
 * reference body below documents the algorithm for the phase-3 PC port.
 */

extern void sub_08020BC0(void);
extern void sub_08000C98(void *a, void *b);
extern u32 sub_0800A104(void *arg, void *table);
extern u32 sub_08009D9C(void *arg);
extern u32 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_08006948(void *a, u32 b);
extern u32 sub_08009BA0(void);
extern void sub_0800E600(u32 a);
extern void sub_08000CEC(void *a, void *b);
extern void sub_0800EF90(void);
extern void sub_08000D2C(void *a, void *b, void *c);
extern u32 sub_0800FD50(void);
extern u32 sub_0800E6A8(void);
extern void sub_08010694(u32 a);
extern u32 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_080008DC(void);
extern void sub_08000D50(void);

extern u8 gIwram_5328;

#ifndef NON_MATCHING
NAKED void sub_08000918(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, lr}\n"
        "    sub     sp, #52\n"
        "    mov     r0, sp\n"
        "    adds    r0, #41\n"
        "    movs    r1, #0\n"
        "    strb    r1, [r0, #0]\n"
        "    ldr     r1, _sub_08000918_pool_gGameStuff_a\n"
        "    ldrb    r1, [r1, #9]\n"
        "    adds    r6, r0, #0\n"
        "    cmp     r1, #8\n"
        "    beq     _sub_08000918_dispatch\n"
        "    cmp     r1, #24\n"
        "    beq     _sub_08000918_dispatch\n"
        "    b       _sub_08000918_epilogue\n"
        "_sub_08000918_dispatch:\n"
        "    bl      sub_08020BC0\n"
        "    ldrb    r0, [r6, #0]\n"
        "    cmp     r0, #13\n"
        "    bls     _sub_08000918_index_ok\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_index_ok:\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, _sub_08000918_pool_jump_table\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .align  2, 0\n"
        "_sub_08000918_pool_gGameStuff_a: .4byte 0x03005330\n"
        "_sub_08000918_pool_jump_table:   .4byte _sub_08000918_jt\n"
        "_sub_08000918_jt:\n"
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
        "    add     r1, sp, #44\n"
        "    mov     r0, sp\n"
        "    bl      sub_08000C98\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r6, #0]\n"
        "    add     r1, sp, #40\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_case1:\n"
        "    add     r4, sp, #40\n"
        "    ldr     r1, _sub_08000918_pool_0800cb1\n"
        "    adds    r0, r4, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_case1_accept\n"
        "    b       _sub_08000918_case8_8dc\n"
        "_sub_08000918_case1_accept:\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r1, _sub_08000918_pool_gGameStuff_b\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    strb    r0, [r4, #0]\n"
        "    b       _sub_08000918_case8_8dc\n"
        "    .align  2, 0\n"
        "_sub_08000918_pool_0800cb1:     .4byte 0x08000cb1\n"
        "_sub_08000918_pool_gGameStuff_b: .4byte 0x03005330\n"
        "_sub_08000918_case2:\n"
        "    add     r0, sp, #40\n"
        "    bl      sub_08009D9C\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_case2_advance\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_case2_advance:\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r1, _sub_08000918_pool_gGameStuff_c\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    b       _sub_08000918_tail\n"
        "    .align  2, 0\n"
        "_sub_08000918_pool_gGameStuff_c: .4byte 0x03005330\n"
        "_sub_08000918_case3:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08000918_pool_iwram_5398_a\n"
        "    strh    r0, [r1, #0]\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #64\n"
        "    bne     _sub_08000918_case3_check_bits\n"
        "    movs    r0, #6\n"
        "    strb    r0, [r6, #0]\n"
        "    bl      sub_0800E060\n"
        "    b       _sub_08000918_tail\n"
        "    .align  2, 0\n"
        "_sub_08000918_pool_iwram_5398_a: .4byte 0x03005398\n"
        "_sub_08000918_case3_check_bits:\n"
        "    ldr     r1, _sub_08000918_pool_iwram_3720_a\n"
        "    movs    r3, #8\n"
        "    adds    r0, r3, #0\n"
        "    ldrh    r1, [r1, #52]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000918_case3_bit2\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08000918_tail\n"
        "    .align  2, 0\n"
        "_sub_08000918_pool_iwram_3720_a: .4byte 0x03003720\n"
        "_sub_08000918_case3_bit2:\n"
        "    ldr     r2, _sub_08000918_pool_iwram_6110_a\n"
        "    ldrh    r1, [r2, #46]\n"
        "    movs    r0, #2\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000918_case3_bit8\n"
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
        "    .align  2, 0\n"
        "_sub_08000918_pool_iwram_6110_a: .4byte 0x03006110\n"
        "_sub_08000918_case3_bit8:\n"
        "    adds    r0, r3, #0\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000918_case3_fall\n"
        "    adds    r0, r2, #0\n"
        "    movs    r1, #8\n"
        "    bl      sub_08006948\n"
        "    movs    r0, #13\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_case3_fall:\n"
        "    add     r1, sp, #44\n"
        "    mov     r0, sp\n"
        "    bl      sub_08000CEC\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_case4:\n"
        "    bl      sub_0800EF90\n"
        "    add     r2, sp, #44\n"
        "    adds    r0, r6, #0\n"
        "    mov     r1, sp\n"
        "    bl      sub_08000D2C\n"
        "    add     r1, sp, #40\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08000918_tail\n"
        "_sub_08000918_case5:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08000918_pool_iwram_5398_b\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_0800FD50\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_tail\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r0, _sub_08000918_pool_iwram_6110_b\n"
        "    movs    r1, #2\n"
        "    bl      sub_08006948\n"
        "    b       _sub_08000918_tail\n"
        "    .align  2, 0\n"
        "_sub_08000918_pool_iwram_5398_b: .4byte 0x03005398\n"
        "_sub_08000918_pool_iwram_6110_b: .4byte 0x03006110\n"
        "_sub_08000918_case6:\n"
        "    bl      sub_080004C4\n"
        "    ldr     r1, _sub_08000918_pool_iwram_5398_c\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      sub_0800E6A8\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r4, r0, #24\n"
        "    cmp     r4, #0\n"
        "    bne     _sub_08000918_case6_chk5328\n"
        "    bl      sub_0800EF90\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r6, #0]\n"
        "    add     r0, sp, #40\n"
        "    strb    r4, [r0, #0]\n"
        "_sub_08000918_case6_chk5328:\n"
        "    ldr     r0, _sub_08000918_pool_iwram_5328\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_tail\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #0]\n"
        "    b       _sub_08000918_tail\n"
        "    .align  2, 0\n"
        "_sub_08000918_pool_iwram_5398_c: .4byte 0x03005398\n"
        "_sub_08000918_pool_iwram_5328:   .4byte 0x03005328\n"
        "_sub_08000918_case7:\n"
        "    add     r4, sp, #40\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_case7_check_ack\n"
        "    movs    r0, #191\n"
        "    bl      sub_08010694\n"
        "    ldrb    r0, [r4, #0]\n"
        "    adds    r0, #1\n"
        "    strb    r0, [r4, #0]\n"
        "_sub_08000918_case7_check_ack:\n"
        "    ldrb    r4, [r4, #0]\n"
        "    lsls    r4, r4, #24\n"
        "    asrs    r4, r4, #24\n"
        "    cmp     r4, #1\n"
        "    bne     _sub_08000918_tail\n"
        "    bl      sub_080106B8\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000918_tail\n"
        "    ldr     r0, _sub_08000918_pool_iwram_3480\n"
        "    movs    r1, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    strb    r4, [r0, #6]\n"
        "    ldr     r0, _sub_08000918_pool_gGameStuff_d\n"
        "    strb    r1, [r0, #9]\n"
        "    b       _sub_08000918_tail\n"
        "    .align  2, 0\n"
        "_sub_08000918_pool_iwram_3480:  .4byte 0x03003480\n"
        "_sub_08000918_pool_gGameStuff_d: .4byte 0x03005330\n"
        "_sub_08000918_case8:\n"
        "    add     r5, sp, #40\n"
        "    ldr     r1, _sub_08000918_pool_0800a26d\n"
        "    adds    r0, r5, #0\n"
        "    bl      sub_0800A104\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000918_case8_8dc\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r6, #0]\n"
        "    ldr     r0, _sub_08000918_pool_gGameStuff_e\n"
        "    movs    r4, #0\n"
        "    str     r4, [r0, #20]\n"
        "    bl      sub_0800A1C8\n"
        "    strb    r4, [r5, #0]\n"
        "_sub_08000918_case8_8dc:\n"
        "    bl      sub_080008DC\n"
        "    b       _sub_08000918_tail\n"
        "    .align  2, 0\n"
        "_sub_08000918_pool_0800a26d:    .4byte 0x0800a26d\n"
        "_sub_08000918_pool_gGameStuff_e: .4byte 0x03005330\n"
        "_sub_08000918_case13:\n"
        "    bl      sub_08000D50\n"
        "_sub_08000918_tail:\n"
        "    ldr     r0, _sub_08000918_pool_gGameStuff_f\n"
        "    ldrb    r0, [r0, #9]\n"
        "    cmp     r0, #8\n"
        "    bne     _sub_08000918_tail_not8\n"
        "    b       _sub_08000918_dispatch\n"
        "_sub_08000918_tail_not8:\n"
        "    cmp     r0, #24\n"
        "    bne     _sub_08000918_epilogue\n"
        "    b       _sub_08000918_dispatch\n"
        "_sub_08000918_epilogue:\n"
        "    add     sp, #52\n"
        "    pop     {r4, r5, r6}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_sub_08000918_pool_gGameStuff_f: .4byte 0x03005330\n"
        "    .syntax divided\n");
}
#else
/* Reference body for the phase-3 PC port. The dispatch uses a literal
 * jump table from C — phase-3 will swap to a function-pointer table. */
void sub_08000918(void)
{
    u8 state[4]; /* sp+0x28 byte, sp+0x29 byte */
    u8 *st;
    u8 *latch;

    state[0] = 0; /* sp+0x28: secondary latch (case 1 / 5 / 7 / 13 clear) */
    state[1] = 0; /* sp+0x29: dispatch state, addressed via r6 */
    st = &state[1];
    latch = &state[0];

    /* Entry gate: function only runs if mode is 8 or 24 at entry. */
    if (gGameStuff.mode != 8 && gGameStuff.mode != 24)
        return;

dispatch:
    sub_08020BC0();
    if (*st > 13)
        goto tail;

    switch (*st) {
    case 0:
        sub_08000C98((void *)&state, (void *)(&state + 0x2c));
        *st = 1;
        *latch = 0;
        break;
    case 1: {
        u32 ok = sub_0800A104(latch, (void *)0x08000cb1);
        if ((u8)ok == 0) {
            sub_080008DC();
            goto tail;
        }
        *st = 2;
        *(u32 *)(0x03005330 + 20) = 0;
        *latch = 0;
        sub_080008DC();
        goto tail;
    }
    case 2:
        if (sub_08009D9C(latch) == 0)
            goto tail;
        *st = 3;
        *(u32 *)(0x03005330 + 20) = 0;
        break;
    case 3: {
        u16 v = sub_080004C4();
        *(u16 *)0x03005398 = v;
        if ((u16)v == 0x40) {
            *st = 6;
            sub_0800E060();
            break;
        }
        if ((*(u16 *)(0x03003720 + 52) & 8) != 0) {
            *st = 4;
            break;
        }
        if ((*(u16 *)(0x03006110 + 46) & 2) != 0) {
            sub_08006948((void *)0x03006110, 2);
            sub_08006948((void *)0x03006110, sub_08009BA0() - 1);
            sub_0800E600(0); /* arg from BA0 result */
            *st = 5;
            break;
        }
        if ((*(u16 *)(0x03006110 + 46) & 8) != 0) {
            sub_08006948((void *)0x03006110, 8);
            *st = 13;
            break;
        }
        /* Fallthrough: case 3 falls through into a sub_08000CEC call
         * (no state advance) — NOT a separate jump-table entry. */
        sub_08000CEC(&state, (void *)(&state + 0x2c));
        break;
    }
    case 4:
        sub_0800EF90();
        sub_08000D2C(st, &state, (void *)(&state + 0x2c));
        *latch = 0;
        break;
    case 5: {
        u16 v = sub_080004C4();
        *(u16 *)0x03005398 = v;
        if (sub_0800FD50() != 0)
            break;
        *st = 3;
        sub_08006948((void *)0x03006110, 2);
        break;
    }
    case 6: {
        u16 v = sub_080004C4();
        *(u16 *)0x03005398 = v;
        u8 v2 = (u8)sub_0800E6A8();
        if (v2 == 0) {
            sub_0800EF90();
            *st = 7;
            *latch = 0;
        }
        if (gIwram_5328 != 0)
            break;
        *st = 3;
        break;
    }
    case 7:
        if ((s8)*latch == 0) {
            sub_08010694(0xbf);
            *latch += 1;
        }
        if ((s8)*latch != 1)
            break;
        if ((u8)sub_080106B8() != 0)
            break;
        *(u8 *)0x03003480 = 4;
        *(u8 *)(0x03003480 + 6) = 0;
        gGameStuff.mode = 4;
        break;
    case 8: {
        u32 ok = sub_0800A104(latch, (void *)0x0800a26d);
        if ((u8)ok == 0) {
            sub_080008DC();
            break;
        }
        *st = 2;
        *(u32 *)(0x03005330 + 20) = 0;
        sub_0800A1C8();
        *latch = 0;
        sub_080008DC();
        break;
    }
    case 13:
        sub_08000D50();
        break;
    case 9:
    case 10:
    case 11:
    case 12:
    default:
        break;
    }

tail:
    if (gGameStuff.mode == 8 || gGameStuff.mode == 24)
        goto dispatch;
    /* return */
}
#endif
