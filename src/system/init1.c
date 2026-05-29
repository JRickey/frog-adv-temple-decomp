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
 * function). The `register GameStuff *gs asm("r0")` pin pairs with it
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
        if (gs->mode != 24) {
            return mapped;
        }

        if (mapped != 0) {
            gs->mode = 4;
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
