#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern const u32 sEntityParamTable[17];
extern void sub_08020BAC(void);
extern void sub_08020B88(u32 arg);

/* sub_0800A1C8 — pendingMode-gated entity-param dispatch.
 *
 * Gate: skip if gGameStuff.pendingMode is divisible by 3 (modes 0, 3, 6,
 * 9, 12, 15) or equals 16. For the remaining values, call sub_08020BAC
 * then dispatch sub_08020B88 with either 0 (default) or the per-mode
 * entry from sEntityParamTable when a state byte at gIwram_6110._field_32
 * equals 1.
 *
 * Ships NAKED + #ifdef NON_MATCHING — 5th-class register-coloring drift.
 * Baserom reuses r5 (which holds &gGameStuff) as the destination of the
 * second pendingMode read (`ldrb r5, [r5, #10]`), overwriting the now-dead
 * pointer with the byte value. agbcc 2.x's natural allocation puts that
 * byte into r0 instead, leaving r5 = &gGameStuff alive. The 1-register
 * difference also flips the surrounding instruction schedule (pool ldr
 * before vs after the byte ldrb). byte_diff plateau is 2.
 *
 * Evidence: 1656-iteration permuter run on the pure-C base.c, no
 * improvement past the base score 1110. Multiple manual variations
 * (u32 idx local, explicit p = &gGameStuff pointer, register asm("r5")
 * pin on idx, register asm("r5") pin on p) all gave the same diff or
 * worse. Corpus search for `ldrb r5, [r5, ...]` across 17+ agbcc
 * decomps returns hits exclusively inside NAKED inline-asm blocks —
 * no pure-C source produces the pattern.
 */

#ifdef NON_MATCHING
void sub_0800A1C8(void)
{
    u8 m;
    u32 value;

    m = gGameStuff.pendingMode;
    if ((u8)(m % 3) == 0)
        return;
    if (m == 16)
        return;

    value = 0;
    sub_08020BAC();
    if (gIwram_6110._field_32 == 1) {
        value = sEntityParamTable[gGameStuff.pendingMode];
    }
    sub_08020B88(value);
}
#else
NAKED
void sub_0800A1C8(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, lr}\n"
        "    ldr     r5, _0800A208\n"
        "    ldrb    r4, [r5, #10]\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #3\n"
        "    bl      __umodsi3\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _0800A200\n"
        "    cmp     r4, #16\n"
        "    beq     _0800A200\n"
        "    movs    r4, #0\n"
        "    bl      sub_08020BAC\n"
        "    ldr     r0, _0800A20C\n"
        "    adds    r0, #50\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #1\n"
        "    bne     _0800A1FA\n"
        "    ldr     r1, _0800A210\n"
        "    ldrb    r5, [r5, #10]\n"
        "    lsls    r0, r5, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r4, [r0, #0]\n"
        "_0800A1FA:\n"
        "    adds    r0, r4, #0\n"
        "    bl      sub_08020B88\n"
        "_0800A200:\n"
        "    pop     {r4, r5}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_0800A208: .word 0x03005330\n"
        "_0800A20C: .word 0x03006110\n"
        "_0800A210: .word sEntityParamTable\n"
        "    .syntax divided\n");
}
#endif

int sub_0800A214(void)
{
    /* result pinned to r5 so the &gGameStuff pointer lands in r4 — baserom
     * keeps the base live across both BLs; the natural allocation swaps r4/r5. */
    register int result asm("r5");
    GameStuff *p = &gGameStuff;

    switch (p->_unk00 % 3) {
    case 0:
        result = 13;
        break;
    case 1:
        result = 8;
        break;
    case 2:
        result = 18;
        break;
    }

    if ((u8)(p->pendingMode - 15) <= 1)
        result = 7;

    sub_08020BAC();
    return result;
}
