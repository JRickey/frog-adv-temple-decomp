#include "game.h"
#include "macros.h"
#include "types.h"

/* sub_08003254 — per-tick scene-step for one game-mode branch. Called from
 * sub_0800336C (the mode-state-machine at 0x08003498).
 *
 *   - sub_08007660(6) + sub_08007DD0() — frame/state setup.
 *   - Branch on the word at 0x03006110[+16] (a scene-phase selector):
 *       == 0 -> sub_0800793C(24, 24)   (intro / spawn)
 *       == 2 -> sub_080031D4(2)
 *   - sub_08008174() + sub_080090B0() + sub_0800A4D0() — subsystem ticks.
 *   - Handler dispatch through sEntityProcB[gGameStuff.pendingMode]().
 *   - Again branch on 0x03006110[+16]:
 *       == 0 -> sub_0800F24C(sEntitySubtypeLut[pendingMode])
 *       else -> sub_08002EE8((s8)sEntitySubtypeLut[pendingMode], arg)
 *   - Handler dispatch through sEntityProcD[gGameStuff.pendingMode](),
 *     then sub_08009A58 / sub_08009188 / sub_080008DC / sub_0800A328 /
 *     sub_080094F8 / sub_08009984.
 *   - Late-tick check: when neither bit 4 of gIwram_3720[+0x34] is set
 *     and 0x03006110[+16] == 2, query sub_0800CD88 over the entity tile
 *     coords; if its result is 2 and gGameStuff._unk10 bit 0 is clear,
 *     fire sub_08006B88(0x030035e0, 0x400) + sub_08020C78(93).
 *   - gGameStuff._unk14++ on every tick.
 *
 * Shipped NAKED + NON_MATCHING. Same fourth-class blocker as the sibling
 * dispatch_helpers.c (sub_0800A2D8) and sub_08009D9C: gGameStuff is pinned
 * in r4 across two `_call_via_r0` indirect dispatches through the
 * sEntityProcB / sEntityProcD ROM tables (agbcc lowers a Thumb
 * function-pointer call to the libgcc helper at asm/disasm_0x08033cd8.s).
 * The register-coloring around those callee-saved-base dispatches is not
 * recoverable from pure C — the NON_MATCHING reference documents intent
 * for the phase-3 PC port. */

typedef void (*GameProc)(void);

extern const GameProc sEntityProcB[17];
extern const GameProc sEntityProcD[17];
extern const u8 sEntitySubtypeLut[20];

extern void sub_08007660(u32 arg);
extern void sub_08007DD0(void);
extern void sub_0800793C(u32 a, u32 b);
extern void sub_080031D4(u32 arg);
extern void sub_08008174(void);
extern void sub_080090B0(void);
extern void sub_0800A4D0(void);
extern void sub_0800F24C(u8 arg);
extern void sub_08002EE8(s32 a, void *b);
extern void sub_08009A58(void);
extern void sub_08009188(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern u8 sub_0800CD88(u8 a, u8 b, s16 c, s16 d);
extern void sub_08006B88(void *a, u32 b);
extern void sub_08020C78(u32 arg);

NAKED void sub_08003254(void *arg)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, lr}\n"
        "    adds    r5, r0, #0\n"
        "    movs    r0, #6\n"
        "    bl      sub_08007660\n"
        "    bl      sub_08007DD0\n"
        "    ldr     r0, _pool_3254_6110_a\n"
        "    ldr     r0, [r0, #16]\n"
        "    cmp     r0, #0\n"
        "    bne     1f\n"
        "    movs    r0, #24\n"
        "    movs    r1, #24\n"
        "    bl      sub_0800793C\n"
        "    b       2f\n"
        "    .align  2, 0\n"
        "_pool_3254_6110_a: .4byte 0x03006110\n"
        "1:\n"
        "    cmp     r0, #2\n"
        "    bne     2f\n"
        "    movs    r0, #2\n"
        "    bl      sub_080031D4\n"
        "2:\n"
        "    bl      sub_08008174\n"
        "    bl      sub_080090B0\n"
        "    bl      sub_0800A4D0\n"
        "    ldr     r1, _pool_3254_procB\n"
        "    ldr     r4, _pool_3254_gGameStuff_a\n"
        "    ldrb    r2, [r4, #10]\n"
        "    lsls    r0, r2, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    bl      _call_via_r0\n"
        "    ldr     r0, _pool_3254_6110_b\n"
        "    ldr     r0, [r0, #16]\n"
        "    cmp     r0, #0\n"
        "    bne     3f\n"
        "    ldr     r0, _pool_3254_lut_a\n"
        "    ldrb    r4, [r4, #10]\n"
        "    adds    r0, r4, r0\n"
        "    ldrb    r0, [r0, #0]\n"
        "    bl      sub_0800F24C\n"
        "    b       4f\n"
        "    .align  2, 0\n"
        "_pool_3254_procB:        .4byte 0x080c0cb8\n"
        "_pool_3254_gGameStuff_a: .4byte 0x03005330\n"
        "_pool_3254_6110_b:       .4byte 0x03006110\n"
        "_pool_3254_lut_a:        .4byte 0x080c0d84\n"
        "3:\n"
        "    ldr     r0, _pool_3254_lut_b\n"
        "    ldrb    r4, [r4, #10]\n"
        "    adds    r0, r4, r0\n"
        "    ldrb    r0, [r0, #0]\n"
        "    lsls    r0, r0, #24\n"
        "    asrs    r0, r0, #24\n"
        "    adds    r1, r5, #0\n"
        "    bl      sub_08002EE8\n"
        "4:\n"
        "    ldr     r1, _pool_3254_procD\n"
        "    ldr     r5, _pool_3254_gGameStuff_b\n" /* shared with the tail load below */
        "    ldrb    r3, [r5, #10]\n"
        "    lsls    r0, r3, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    bl      _call_via_r0\n"
        "    bl      sub_08009A58\n"
        "    bl      sub_08009188\n"
        "    bl      sub_080008DC\n"
        "    bl      sub_0800A328\n"
        "    bl      sub_080094F8\n"
        "    bl      sub_08009984\n"
        "    ldr     r1, _pool_3254_3720\n"
        "    movs    r0, #4\n"
        "    ldrh    r1, [r1, #52]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     5f\n"
        "    ldr     r0, _pool_3254_6110_c\n"
        "    ldr     r0, [r0, #16]\n"
        "    cmp     r0, #2\n"
        "    bne     5f\n"
        "    ldr     r4, _pool_3254_35e0\n"
        "    ldrb    r0, [r4, #24]\n"
        "    ldrb    r1, [r4, #25]\n"
        "    movs    r6, #8\n"
        "    ldrsh   r2, [r4, r6]\n"
        "    movs    r6, #10\n"
        "    ldrsh   r3, [r4, r6]\n"
        "    bl      sub_0800CD88\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r1, r0, #24\n"
        "    movs    r0, #1\n"
        "    ldrb    r5, [r5, #16]\n"
        "    ands    r0, r5\n"
        "    cmp     r0, #0\n"
        "    bne     5f\n"
        "    cmp     r1, #2\n"
        "    bne     5f\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #128\n"
        "    lsls    r1, r1, #3\n"
        "    bl      sub_08006B88\n"
        "    movs    r0, #93\n"
        "    bl      sub_08020C78\n"
        "5:\n"
        "    ldr     r1, _pool_3254_gGameStuff_b\n"
        "    ldr     r0, [r1, #20]\n"
        "    adds    r0, #1\n"
        "    str     r0, [r1, #20]\n"
        "    pop     {r4, r5, r6}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_pool_3254_lut_b:        .4byte 0x080c0d84\n"
        "_pool_3254_procD:        .4byte 0x080c0d40\n"
        "_pool_3254_gGameStuff_b: .4byte 0x03005330\n"
        "_pool_3254_3720:         .4byte 0x03003720\n"
        "_pool_3254_6110_c:       .4byte 0x03006110\n"
        "_pool_3254_35e0:         .4byte 0x030035e0\n"
        ".syntax divided\n");
}

#ifdef NON_MATCHING
/* Reference body for the phase-3 PC port — mirrors the asm shape. Does
 * not match in pure C (see header note). */
void sub_08003254(void *arg)
{
    u8 id;

    sub_08007660(6);
    sub_08007DD0();

    if (*(u32 *)(0x03006110 + 16) == 0) {
        sub_0800793C(24, 24);
    } else if (*(u32 *)(0x03006110 + 16) == 2) {
        sub_080031D4(2);
    }

    sub_08008174();
    sub_080090B0();
    sub_0800A4D0();

    id = gGameStuff.pendingMode;
    sEntityProcB[id]();

    if (*(u32 *)(0x03006110 + 16) == 0) {
        sub_0800F24C(sEntitySubtypeLut[gGameStuff.pendingMode]);
    } else {
        sub_08002EE8((s8)sEntitySubtypeLut[gGameStuff.pendingMode], arg);
    }

    sEntityProcD[gGameStuff.pendingMode]();
    sub_08009A58();
    sub_08009188();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();

    if ((*(u16 *)(0x03003720 + 0x34) & 4) == 0 && *(u32 *)(0x03006110 + 16) == 2) {
        u8 *e = (u8 *)0x030035e0;
        u8 result = sub_0800CD88(e[24], e[25], *(s16 *)(e + 8), *(s16 *)(e + 10));
        if ((gGameStuff._unk10 & 1) == 0 && result == 2) {
            sub_08006B88(e, 0x400);
            sub_08020C78(93);
        }
    }

    gGameStuff._unk14++;
}
#endif
