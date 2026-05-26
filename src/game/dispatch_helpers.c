#include "game.h"
#include "gba/intr.h"
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

extern void sub_0800FCC8(u8 arg);
extern void sub_08005FC8(void);
/* sub_0802D558 is a thin wrapper around BIOS SWI 12 (CpuFastSet) — see init.c. */
extern void sub_0802D558(void *src, void *dst, u32 mode);

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

/* Synchronous "force-render-now" tail: temporarily masks the VBlank IRQ,
 * runs subsystem ticks (sub_0800FCC8 with the per-entity subtype byte +
 * sub_08005FC8), then commits the deferred VRAM state itself — the same
 * CpuFastSet(0x030054a0 → OAM, 0x100) + 6 halfword BG scroll write that
 * the VBlank handler (sub_08000790) does, but here it runs from the
 * caller's context so the scene is up-to-date before whatever happens
 * next. Re-enables VBlank on the way out.
 *
 * Shipped NAKED. The pure-C body (see NON_MATCHING block below) lands
 * with byte_diff=1 (one Thumb instruction): the `adds r0, r1, r0` after
 * the LUT load. agbcc 2.x always emits `adds rd, rd, rm` for `base +
 * index` regardless of operand order in source — confirmed by corpus
 * grep (all 16 `adds r0, r1, r0` hits in pret/pokeruby are inside NAKED
 * blocks). Same class of register-coloring drift as sub_0800A2D8 above. */
#ifdef NON_MATCHING
void sub_0800A328(void)
{
    register const u8 *lut asm("r0");
    register GameStuff *g asm("r1");
    register vu16 *dst asm("r1");
    register u16 *src asm("r2");
    u8 idx;

    REG_IE &= ~IRQ_VBLANK;
    lut = sEntitySubtypeLut;
    g = &gGameStuff;
    idx = g->pendingMode;
    sub_0800FCC8(lut[idx]);
    sub_08005FC8();
    sub_0802D558((void *)0x030054a0, (void *)0x07000000, 0x100);
    dst = (vu16 *)0x04000010;
    src = (u16 *)0x03003550;
    *dst++ = src[0];
    *dst++ = src[1];
    *dst++ = src[2];
    *dst++ = src[3];
    *dst++ = src[4];
    *dst = src[5];
    REG_IE |= IRQ_VBLANK;
}
#else
NAKED void sub_0800A328(void)
{
    asm(".syntax unified\n"
        "    push    {r4, lr}\n"
        "    ldr     r4, _pool_REG_IE\n"
        "    ldrh    r1, [r4, #0]\n"
        "    ldr     r0, _pool_clear_vblank\n"
        "    ands    r0, r1\n"
        "    strh    r0, [r4, #0]\n"
        "    ldr     r0, _pool_lut_a328\n"
        "    ldr     r1, _pool_gGameStuff_a328\n"
        "    ldrb    r1, [r1, #10]\n"
        "    adds    r0, r1, r0\n"
        "    ldrb    r0, [r0, #0]\n"
        "    bl      sub_0800FCC8\n"
        "    bl      sub_08005FC8\n"
        "    ldr     r0, _pool_oam_shadow\n"
        "    movs    r1, #224\n"
        "    lsls    r1, r1, #19\n"
        "    movs    r2, #128\n"
        "    lsls    r2, r2, #1\n"
        "    bl      sub_0802D558\n"
        "    ldr     r1, _pool_bg_scroll_mmio\n"
        "    ldr     r2, _pool_bg_scroll_shadow\n"
        "    ldrh    r0, [r2, #0]\n"
        "    strh    r0, [r1, #0]\n"
        "    adds    r1, #2\n"
        "    ldrh    r0, [r2, #2]\n"
        "    strh    r0, [r1, #0]\n"
        "    adds    r1, #2\n"
        "    ldrh    r0, [r2, #4]\n"
        "    strh    r0, [r1, #0]\n"
        "    adds    r1, #2\n"
        "    ldrh    r0, [r2, #6]\n"
        "    strh    r0, [r1, #0]\n"
        "    adds    r1, #2\n"
        "    ldrh    r0, [r2, #8]\n"
        "    strh    r0, [r1, #0]\n"
        "    adds    r1, #2\n"
        "    ldrh    r0, [r2, #10]\n"
        "    strh    r0, [r1, #0]\n"
        "    ldrh    r0, [r4, #0]\n"
        "    movs    r1, #1\n"
        "    orrs    r0, r1\n"
        "    strh    r0, [r4, #0]\n"
        "    pop     {r4}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_pool_REG_IE:             .4byte 0x04000200\n"
        "_pool_clear_vblank:       .4byte 0x0000fffe\n"
        "_pool_lut_a328:           .4byte sEntitySubtypeLut\n"
        "_pool_gGameStuff_a328:    .4byte 0x03005330\n"
        "_pool_oam_shadow:         .4byte 0x030054a0\n"
        "_pool_bg_scroll_mmio:     .4byte 0x04000010\n"
        "_pool_bg_scroll_shadow:   .4byte 0x03003550\n"
        ".syntax divided\n");
}
#endif
