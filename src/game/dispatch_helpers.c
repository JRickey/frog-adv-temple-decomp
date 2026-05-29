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
 * Two agbcc levers are needed to match the baserom's `adds r0, r1, r0`
 * (LUT base + entity index, index first):
 *   - The gGameStuff base is read through the link-time IWRAM symbol
 *     gIwram_5330 (= 0x03005330) rather than the `(*(GameStuff *)0x...)`
 *     absolute-address macro. The macro form lets agbcc tie the add result
 *     to the index register (`adds r1, r1, r0`); the opaque relocation
 *     pins the LUT base in r0 and ties the result there instead. Same
 *     linker-symbol idiom that defeats the adjacent-IWRAM CSE-fold
 *     (see docs/codegen-notes.md "Adjacent IWRAM bases").
 *   - `idx + (u32)lut` (index first, integer-space add) gives the
 *     `r1, r0` operand order; `lut[idx]` folds the pointer to the front
 *     and yields `adds r0, r0, r1` instead. */
extern u8 gIwram_5330;

void sub_0800A328(void)
{
    register const u8 *lut asm("r0");
    register u32 idx asm("r1");
    register vu16 *dst asm("r1");
    register u16 *src asm("r2");

    REG_IE &= ~IRQ_VBLANK;
    lut = sEntitySubtypeLut;
    idx = ((GameStuff *)&gIwram_5330)->pendingMode;
    sub_0800FCC8(*(const u8 *)(idx + (u32)lut));
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

/* Descending-sort comparator over a pair of 8-byte records.
 *
 * Compares the upper 16 bits of word 0 (i.e. the halfword at offset 2)
 * — returns +1 when a < b, -1 when a > b, 0 when equal. The function
 * is referenced from data still inside text_0x0800a3d0.bin so its
 * caller is not yet known; the address embedding has not surfaced
 * in any currently-decoded code or pool literal.
 *
 * The asm shape reads the full 8 bytes of each record via two ldr's
 * (offsets 0 and 4) even though only offset 2 is compared. This is
 * the agbcc 2.x output for whole-struct copy into locals — the
 * `aa = *a` / `bb = *b` form forces both words to be loaded before
 * the comparisons execute. The first comparison loads the halfword
 * directly via `ldrh [r0,#2]`; the fall-through path reuses the
 * already-loaded word 0 via `lsrs r1, r2, #16`. */
typedef struct {
    u32 word0;
    u32 word1;
} CmpPair;

int sub_0800A3A4(const CmpPair *a, const CmpPair *b)
{
    CmpPair aa = *a;
    CmpPair bb = *b;
    if (((const u16 *)a)[1] < ((const u16 *)b)[1])
        return 1;
    if ((aa.word0 >> 16) > (bb.word0 >> 16))
        return -1;
    (void)aa.word1;
    (void)bb.word1;
    return 0;
}
