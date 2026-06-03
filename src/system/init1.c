#include "game.h"
#include "gba/intr.h"
#include "gba/io.h"
#include "iwram.h"

extern void sub_08020B30(void);
extern void sub_08017364(void);
extern void sub_0800072C(void);
extern void sub_08000820(void);

extern u32 sub_08000900(void);
extern u32 sub_080179B8(void);

/* Init1: one-time setup called from AgbMain's prologue.
 *
 * Disables all hardware IRQs (REG_IE = 0), zeros the cross-subsystem
 * fields of gGameStuff (seeding the RNG with 13 along the way), primes
 * six IWRAM subsystem state blocks with their default-config bytes,
 * runs the dependent subsystem inits, zero-fills the BG-scroll shadow
 * at gIwram_3550, then turns the display back on with all four BGs +
 * OBJ enabled in 1D char-mapping mode.
 *
 * Matching depends on declaring the six IWRAM bases as link-time symbols
 * (see include/iwram.h + linker.ld). Earlier attempts using
 * `(T *)0x03003480` casts triggered agbcc 2.x's CSE-fold on adjacent
 * compile-time-constant addresses; opaque externs sidestep that. See
 * docs/codegen-notes.md "Adjacent IWRAM bases". */
void sub_08000430(void)
{
    sub_08020B30();
    REG_IE = 0;
    gGameStuff.rngSeed = 13;
    gGameStuff._unk00 = 0;
    gGameStuff._unk10 = 0;
    gGameStuff._unk18 = 0;
    gGameStuff._unk14 = 0;
    gGameStuff.pendingMode = 0;
    gGameStuff._unk04 = 0;
    gIwram_3480._data[5] = 0;
    gIwram_3480._data[0] = 0;
    gIwram_34A0.dispatchIdx = 0;
    gIwram_34B4._data[0] = 1;
    gIwram_34B4._data[1] = 1;
    gIwram_34B4._data[2] = 5;
    gIwram_34B4._data[3] = 5;
    gIwram_35E0._data[0] = 5;
    gIwram_35E0._data[4] = 0;
    gIwram_34B0._data = 0;
    sub_08017364();
    sub_0800072C();
    gIwram_3550._data[0] = 0;
    gIwram_3550._data[1] = 0;
    gIwram_3550._data[2] = 0;
    gIwram_3550._data[3] = 0;
    gIwram_3550._data[4] = 0;
    gIwram_3550._data[5] = 0;
    gIwram_3550._data[6] = 0;
    gIwram_3550._data[7] = 0;
    sub_08000820();
    REG_DISPCNT = DISPCNT_OBJ_1D | DISPCNT_BG0_ON | DISPCNT_BG1_ON | DISPCNT_BG2_ON | DISPCNT_BG3_ON | DISPCNT_OBJ_ON;
}

/* Per-frame input poll + attract-mode advancer. Called inside AgbMain's
 * mode 4 case body; its u16 return value is stored at gIwram_5398.
 *
 * Reads REG_KEYINPUT (active-low), inverts to an active-high pressed
 * mask, computes the just-pressed mask vs the previous frame's mask in
 * gIwram_3710, then walks a fixed remap that swaps GBA keys to the
 * game's internal layout (START<->UP, UP<->A, DOWN<->B, LEFT<->SELECT,
 * RIGHT<->START, A<->RIGHT, B<->LEFT, SELECT<->DOWN, L<->R, R<->L).
 *
 * The mode==24 branch handles the attract-loop case: if the player
 * presses any remapped key, force mode 4 (return to title); otherwise
 * advance the attract step every (now - lastTick) > 10 ticks. The
 * function lives in init1.c because it shares iwram-base discovery
 * with Init1.
 *
 * Matching trick (permuter-found): the second `jpKeysShadow = jpKeys`
 * copy splits the bit-test sequence onto a separate value, defeating
 * agbcc 2.x's preemptive spill of jpKeys to r4 (which otherwise
 * cascades into a +2 byte branch-offset drift across the whole
 * function). The r0-pinned `gs` local pairs with it
 * to anchor the gGameStuff load in the right register at the post-
 * remap mode check. */
u32 sub_080004C4(void)
{
    u16 raw;
    u16 mapped;
    u32 now;
    struct IwramAt5358 *jp;
    struct IwramAt3710 *prev;
    u16 jpKeys;
    u16 jpKeysShadow;

    raw = ~REG_KEYINPUT;
    jp = &gIwram_5358;
    prev = &gIwram_3710;
    jpKeys = raw & ~prev->prevKeys;
    jp->justPressed = jpKeys;
    prev->prevKeys = raw;

    jpKeysShadow = jpKeys;
    mapped = ((u16)(jpKeysShadow & KEY_START)) ? KEY_UP : 0;
    if (jpKeysShadow & KEY_UP)
        mapped |= KEY_A;
    if (jpKeysShadow & KEY_DOWN)
        mapped |= KEY_B;
    if (jpKeysShadow & KEY_LEFT)
        mapped |= KEY_SELECT;
    if (jpKeysShadow & KEY_RIGHT)
        mapped |= KEY_START;
    if (jpKeysShadow & KEY_A)
        mapped |= KEY_RIGHT;
    if (jpKeysShadow & KEY_B)
        mapped |= KEY_LEFT;
    if (jpKeysShadow & KEY_SELECT)
        mapped |= KEY_DOWN;
    if (jpKeysShadow & KEY_L)
        mapped |= KEY_R;
    if (jpKeysShadow & KEY_R)
        mapped |= KEY_L;

    {
        register GameStuff *gs asm("r0");
        gs = &gGameStuff;
        if (gs->mode != GAME_MODE_ATTRACT) {
            return mapped;
        }

        if (mapped != 0) {
            gs->mode = GAME_MODE_ROUTER;
            gIwram_3480._data[0] = 4;
            return 0;
        }
    }

    now = sub_08000900();
    if (now - gIwram_34C0.lastTick <= 10) {
        return 0;
    }
    gIwram_34C0.lastTick = sub_08000900();
    return (u16)sub_080179B8();
}

u32 sub_080005D8(void)
{
    u16 raw;
    u16 mapped;
    u32 now;
    struct IwramAt5358 *jp;
    struct IwramAt3710 *prevRead;
    struct IwramAt3710 *prev;
    register u16 prevKeys asm("r3");
    u16 jpKeys;
    u16 keyA;
    u16 aHeld;
    register u16 keyB asm("r1");

    raw = ~REG_KEYINPUT;
    mapped = 0;
    jp = &gIwram_5358;
    prevRead = &gIwram_3710;
    prevKeys = prevRead->prevKeys;
    jpKeys = raw & ~prevKeys;
    jp->justPressed = jpKeys;
    keyA = KEY_A;
    aHeld = keyA & prevKeys;
    prev = prevRead;
    if (!aHeld)
        mapped = (u16)(jpKeys & keyA) ? KEY_RIGHT : 0;
    keyB = KEY_B;
    if (!(prevKeys & keyB)) {
        jpKeys &= keyB;
        if (jpKeys != 0)
            mapped = KEY_LEFT;
    }
    prev->prevKeys = raw;

    {
        register GameStuff *gs asm("r0");
        gs = &gGameStuff;
        if (gs->mode != GAME_MODE_ATTRACT) {
            return mapped;
        }

        if (mapped == 0) {
            now = sub_08000900();
            if (now - gIwram_34C0.lastTick > 10) {
                gIwram_34C0.lastTick = sub_08000900();
                return (u16)sub_080179B8();
            }
            return 0;
        }

        gs->mode = GAME_MODE_ROUTER;
        gIwram_3480._data[0] = 4;
        return 0;
    }
}

/* Per-frame input poll variant: like sub_080004C4 / sub_080005D8 but with a
 * different remap. START is edge-triggered (just-pressed) and maps to KEY_UP;
 * the four D-pad directions are level-triggered (currently-held `raw`) and map
 * to the game's extended virtual-button bits 10..13.
 *
 * In the mode==24 attract case: any remapped input forces mode 4 (return to
 * title); otherwise the attract step advances via sub_080179B8 (no timer gate,
 * unlike the two siblings).
 *
 * Matching trick: `rawShadow = raw` before the directional bit-test sequence
 * splits the held-key mask onto a separate value, defeating agbcc 2.x's
 * preemptive spill of `raw` into a second callee-saved register (which
 * otherwise widens the prologue to `push {r4, r5, lr}`). Same idiom the
 * `jpKeysShadow` copy uses in sub_080004C4. */
u32 sub_08000678(void)
{
    u16 raw;
    u16 rawShadow;
    u16 mapped;
    struct IwramAt5358 *jp;
    struct IwramAt3710 *prev;
    u16 jpKeys;
    GameStuff *gs;

    raw = ~REG_KEYINPUT;
    jp = &gIwram_5358;
    prev = &gIwram_3710;
    jpKeys = raw & ~prev->prevKeys;
    jp->justPressed = jpKeys;
    prev->prevKeys = raw;

    rawShadow = raw;
    mapped = ((u16)(jpKeys & KEY_START)) ? KEY_UP : 0;
    if (rawShadow & KEY_UP)
        mapped |= (1 << 10);
    if (rawShadow & KEY_DOWN)
        mapped |= (1 << 11);
    if (rawShadow & KEY_LEFT)
        mapped |= (1 << 12);
    if (rawShadow & KEY_RIGHT)
        mapped |= (1 << 13);

    gs = &gGameStuff;
    if (gs->mode != GAME_MODE_ATTRACT) {
        return mapped;
    }

    if (mapped == 0) {
        return (u16)sub_080179B8();
    }

    gs->mode = GAME_MODE_ROUTER;
    return 0;
}

/* Empty stub in the 4-byte gap between sub_08000678's epilogue and
 * sub_0800072C. Caller TBD; kept as a separate symbol so the surrounding
 * layout stays byte-identical. The Makefile's trailing `.align 2, 0`
 * emits the 0x0000 halfword pad the baserom has after it. */
void sub_08000728(void)
{}
