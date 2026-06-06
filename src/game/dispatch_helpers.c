#include "game.h"
#include "iwram.h"
#include "gba/intr.h"
#include "macros.h"
#include "types.h"

/* Per-frame entity dispatch tail used by the game-mode handlers.
 *
 * Reads gGameStuff.pendingMode (the byte at offset 10 — used as a
 * global entity-type / pose index that also keys the
 * sEntityProc{A..E} / sEntitySubtypeLut tables in
 * src/data/entity_dispatch.c). Calls Game_UpdateSubsystems once, then
 * dispatches through sEntityProcB, sEntitySubtypeLut, sEntityProcD
 * by pendingMode, and finishes with Entity_UpdateVisibility + Entity_Advance.
 *
 * The two `sEntityProcB[id]()` / `sEntityProcD[id]()` indirect calls
 * go through libgcc's _call_via_r0 helper from libgcc.a:_call_via_rX.o;
 * agbcc lowers a Thumb function-pointer call to that helper rather than
 * emitting `bx r0` inline.
 *
 * Uses the same explicit table-offset idiom as Entity_DispatchBC: load the
 * gGameStuff base through the linker-assigned IWRAM symbol, keep the
 * table base separate from the index, then call the loaded function
 * pointer. That gives agbcc the baserom's r2/r1/r4 pendingMode chain
 * without register pins.
 */

typedef void (*GameProc)(void);

extern const GameProc sEntityProcB[17];
extern const GameProc sEntityProcD[17];
extern const u8 sEntitySubtypeLut[20];

extern void Game_UpdateSubsystems(void);
extern void Scroll_UpdateCamera(u8 arg);
extern void Entity_UpdateVisibility(void);
extern void Entity_Advance(void);

extern void Scroll_RunSubtypeTicks(u8 arg);
extern void Game_CommitRender(void);
/* BiosSwiTable is a thin wrapper around BIOS SWI 12 (CpuFastSet) — see init.c. */
extern void BiosSwiTable(void *src, void *dst, u32 mode);
extern u8 gIwram_5330;

void Game_RunEntityFrame(void)
{
    const GameProc *procs;
    GameStuff *base;
    u8 idx;
    u32 offset;

    Game_UpdateSubsystems();

    procs = sEntityProcB;
    base = (GameStuff *)&gIwram_5330;
    idx = base->pendingMode;
    offset = ((u32)idx << 2) + (u32)procs;
    ((GameProc)(*(const u32 *)offset))();

    {
        const u8 *lut;
        u32 subtype;

        lut = sEntitySubtypeLut;
        subtype = base->pendingMode;
        Scroll_UpdateCamera(*(const u8 *)(subtype + (u32)lut));
    }

    procs = sEntityProcD;
    idx = base->pendingMode;
    offset = ((u32)idx << 2) + (u32)procs;
    ((GameProc)(*(const u32 *)offset))();

    Entity_UpdateVisibility();
    Entity_Advance();
}

/* Synchronous "force-render-now" tail: temporarily masks the VBlank IRQ,
 * runs subsystem ticks (Scroll_RunSubtypeTicks with the per-entity subtype byte +
 * Game_CommitRender), then commits the deferred VRAM state itself — the same
 * CpuFastSet(0x030054a0 → OAM, 0x100) + 6 halfword BG scroll write that
 * the VBlank handler (VBlankIntr) does, but here it runs from the
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
void Game_ForceRender(void)
{
    const u8 *lut;
    u32 idx;
    register vu16 *dst asm("r1");
    u16 *src;

    REG_IE &= ~IRQ_VBLANK;
    lut = sEntitySubtypeLut;
    idx = ((GameStuff *)&gIwram_5330)->pendingMode;
    Scroll_RunSubtypeTicks(*(const u8 *)(idx + (u32)lut));
    Game_CommitRender();
    BiosSwiTable((void *)0x030054a0, (void *)0x07000000, 0x100);
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

int CmpPair_Compare(const CmpPair *a, const CmpPair *b)
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

/* Boundary/collision step gate. dir is a 4-way direction flag
 * (1/2 = vertical, 4/8 = horizontal); coord is the candidate tile
 * coordinate along that axis. Reads the cached tile coords at
 * gIwram_35E0._field_8 (X) / _field_A (Y), and returns:
 *   0    when the actor isn't ready (gEntities[0].field_1A > 3),
 *   0xff when the move is blocked by the cached coordinate,
 *   1    otherwise, after recording dir in gIwram_35E0._field_12.
 *
 * The cached coord and the candidate are both u16 but compared as
 * signed 16-bit: `field << 16 > coord << 16` is the agbcc 2.x idiom
 * for `(s16)field > (s16)coord` over two u16 values — both operands
 * sign-align at bit 31 via the left shift, so the arithmetic
 * right-shift is elided and the field loads as ldrh (not ldrsh).
 *
 * Matching shape (agbcc 2.x register allocation): the three pinned
 * locals + the `tmp` split are all load-bearing.
 *   - `field` (r4) holds the freshly-loaded u16, kept callee-saved so
 *     cases 1/4 and 2/8 can cross-jump to a shared `field << 16; cmp`
 *     tail (baserom's `b 0xa42e` / `b 0xa442`).
 *   - `cs` (r2) caches `coord << 16` and `fs` (r1) caches `field << 16`
 *     so the compare reads `cmp r1, r2` in that operand order.
 *   - Reading the field value into `tmp` *before* `cs = coord << 16`
 *     forces the base-address `ldr r0` to precede the `lsls r2` (cs),
 *     matching baserom's `ldr r0; lsls r2; ldrh r4` order. Inlining the
 *     field read instead emits the cs shift first.
 */
u8 Scroll_CheckTileStep(u16 dir, s16 coord)
{
    u16 field;
    int cs;
    register int fs asm("r1");
    u16 tmp;

    if (gEntities[0].field_1A > 3)
        return 0;

    switch (dir) {
    case 1:
        tmp = (u16)gIwram_35E0._field_A;
        cs = coord << 16;
        field = tmp;
        fs = field << 16;
        if (fs > cs)
            break;
        return 0xff;
    case 2:
        tmp = (u16)gIwram_35E0._field_A;
        cs = coord << 16;
        field = tmp;
        fs = field << 16;
        if (fs >= cs)
            return 0xff;
        break;
    case 4:
        tmp = (u16)gIwram_35E0._field_8;
        cs = coord << 16;
        field = tmp;
        fs = field << 16;
        if (fs > cs)
            break;
        return 0xff;
    case 8:
        tmp = (u16)gIwram_35E0._field_8;
        cs = coord << 16;
        field = tmp;
        fs = field << 16;
        if (fs >= cs)
            return 0xff;
        break;
    }

    gIwram_35E0._field_12 = dir;
    return 1;
}

u32 Scroll_StepTowardTile(u16 x, u16 y)
{
    u32 xShift;
    u32 yShift;
    u16 xTile;
    register u16 yTile asm("r4");
    u32 coordBits;
    u16 field8;
    s32 field;
    s32 coord;
    u8 result;
    u8 dir;

    xShift = x << 16;
    yShift = y << 16;
    yTile = yShift >> 16;
    field8 = (u16)gIwram_35E0._field_8;
    xTile = xShift >> 16;

    if ((int)(field8 << 16) == (int)xShift && (u16)gIwram_35E0._field_A == yTile)
        return 1;

    coordBits = xTile << 16;
    coord = (s32)coordBits >> 16;
    if (coord < gIwram_35E0._field_8) {
        dir = 4;
        goto check_x_or_y_low;
    }

    if (coord > gIwram_35E0._field_8) {
        dir = 8;
        goto check_x_or_y_low;
    }

    coordBits = yTile << 16;
    coord = (s32)coordBits >> 16;
    field = gIwram_35E0._field_A;
    if (coord >= field)
        goto y_ge;

    dir = 1;
check_x_or_y_low:
    switch (Scroll_CheckTileStep(dir, coord)) {
    case 1:
        goto return_ff;
    }
    result = 0;
    return result;

y_ge:
    if (coord <= field)
        return field;

    result = Scroll_CheckTileStep(2, coord);
    if (result != 1)
        goto return_zero_after;
return_ff:
    result = 0xff;
    goto done;
return_zero_after:
    result = 0;
done:
    return result;
}
