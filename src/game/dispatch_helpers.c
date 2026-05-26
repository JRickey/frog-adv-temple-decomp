#include "game.h"
#include "macros.h"
#include "types.h"

/* Per-frame entity dispatch tail used by the game-mode handlers.
 *
 * Reads gGameStuff.pendingMode (the byte at offset 10 — used as a
 * global entity-type / pose index that also keys the
 * sEntityProc{A..E} / sEntitySubtypeLut tables in
 * src/data/entity_dispatch.c). Calls sub_0800A520 once, then
 * dispatches through sEntityProcB, sEntitySubtypeLut, sEntityProcD
 * by pendingMode, and finishes with sub_08009A58 + sub_08009188.
 *
 * The two `sEntityProcB[id]()` / `sEntityProcD[id]()` indirect calls
 * go through libgcc's _call_via_r0 helper
 * (asm/disasm_0x08033cd8.s) — agbcc lowers a Thumb function-pointer
 * call to that helper rather than emitting `bx r0` inline.
 *
 * Shipped NAKED. The straight-line pure-C body (see NON_MATCHING
 * block below) compiles to byte_diff=7 — agbcc's register allocator
 * chains the index through r0 for all three table dispatches, while
 * the baserom uses separate scratch registers (r2, then r1, then r4
 * reusing the gGameStuff base register once it's last-use). Permuter
 * (1575 iterations) couldn't crack the difference; the readable form
 * is preserved here for the phase-3 PC port.
 */

typedef void (*GameProc)(void);

extern const GameProc sEntityProcB[17];
extern const GameProc sEntityProcD[17];
extern const u8 sEntitySubtypeLut[20];

extern void sub_0800A520(void);
extern void sub_0800F24C(u8 arg);
extern void sub_08009A58(void);
extern void sub_08009188(void);

#ifdef NON_MATCHING
void sub_0800A2D8(void)
{
    sub_0800A520();
    sEntityProcB[gGameStuff.pendingMode]();
    sub_0800F24C(sEntitySubtypeLut[gGameStuff.pendingMode]);
    sEntityProcD[gGameStuff.pendingMode]();
    sub_08009A58();
    sub_08009188();
}
#else
NAKED void sub_0800A2D8(void)
{
    asm(".syntax unified\n"
        "    push    {r4, lr}\n"
        "    bl      sub_0800A520\n"
        "    ldr     r1, _pool_procB\n"
        "    ldr     r4, _pool_gGameStuff\n"
        "    ldrb    r2, [r4, #10]\n"
        "    lsls    r0, r2, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    bl      _call_via_r0\n"
        "    ldr     r0, _pool_lut\n"
        "    ldrb    r1, [r4, #10]\n"
        "    adds    r0, r1, r0\n"
        "    ldrb    r0, [r0, #0]\n"
        "    bl      sub_0800F24C\n"
        "    ldr     r1, _pool_procD\n"
        "    ldrb    r4, [r4, #10]\n"
        "    lsls    r0, r4, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    bl      _call_via_r0\n"
        "    bl      sub_08009A58\n"
        "    bl      sub_08009188\n"
        "    pop     {r4}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_pool_procB:     .4byte sEntityProcB\n"
        "_pool_gGameStuff: .4byte 0x03005330\n"
        "_pool_lut:       .4byte sEntitySubtypeLut\n"
        "_pool_procD:     .4byte sEntityProcD\n"
        ".syntax divided\n");
}
#endif
