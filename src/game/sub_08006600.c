#include "types.h"
#include "iwram.h"

/* Generic bit-set accessor on a struct at `base` — the "set bit" companion
 * to ModeControl_ClearBit ("clear bit") and ModeControl_GetFlag ("test bit"). Same
 * (selector, bit) shape; ten populated cases (selector >= 10 falls through
 * to the shared pop/bx epilogue, leaving the struct untouched).
 *
 * Selector 1 sets one bit in a 64-bit halfword pair stored at offsets 4 /
 * 8. Unlike the clear-bit sibling, the mask is built with `asrs r3, r2,
 * #31` — i.e. the high half is the sign-extension of the low half. For
 * `bit < 32`, the high half is zero; for `bit >= 32`, the high half is the
 * shifted bit and the low half is zero (the lsls drops the bits out).
 *
 * Selectors 7 / 8 / 9 fold through a shared `set_byte` epilogue that
 * builds the bitmask in r0 and sets the bit at the byte pointer prepared
 * in each case (`p asm("r1")` keeps the pointer in r1 across the
 * dispatch).
 *
 * Matching notes (old_agbcc):
 *   - `base asm("r4")` pins the struct base into the callee-saved
 *     register that the baserom uses across every case body.
 *   - Selector 1: `lo asm("r2")` / `hi asm("r3")` pin the two mask
 *     halves to the registers the baserom uses (the `asrs r3, r2, #31`
 *     sign-extension is the natural agbcc lowering of a signed shift
 *     into r2/r3).
 *   - `p asm("r1")` pins the byte pointer used by selectors 7/8/9 so
 *     the shared `set_byte` block ships as `adds r1, r4, #0; adds r1,
 *     #N` for each, without spurious copies. */

void CtrlFlags_SetBit(void *baseIn, u32 selectorIn, u32 bitIn)
{
    u8 *base = (u8 *)baseIn;
    u32 selector = (u8)selectorIn;
    u32 bit = (u8)bitIn;
    u32 mask;
    u8 *p;

    switch (selector) {
    case 0:
        mask = 1 << bit;
        *(u16 *)(base + 0) = *(u16 *)(base + 0) | mask;
        break;
    case 1: {
        s32 maskLo;
        s32 maskHi;
        register u32 lo asm("r0");
        register u32 hi asm("r1");
        maskLo = 1 << bit;
        maskHi = maskLo >> 31;
        lo = *(u32 *)(base + 4);
        hi = *(u32 *)(base + 8);
        lo |= maskLo;
        hi |= maskHi;
        *(u32 *)(base + 4) = lo;
        *(u32 *)(base + 8) = hi;
        break;
    }
    case 2:
        mask = 1 << bit;
        *(u16 *)(base + 12) = *(u16 *)(base + 12) | mask;
        break;
    case 3:
        mask = 1 << bit;
        *(u32 *)(base + 16) = *(u32 *)(base + 16) | mask;
        break;
    case 4:
        mask = 1 << bit;
        *(u16 *)(base + 0x24) = *(u16 *)(base + 0x24) | mask;
        break;
    case 5:
        mask = 1 << bit;
        *(u16 *)(base + 0x26) = *(u16 *)(base + 0x26) | mask;
        break;
    case 6:
        mask = 1 << bit;
        *(u16 *)(base + 0x28) = *(u16 *)(base + 0x28) | mask;
        break;
    case 7:
        p = base + 0x2c;
        goto set_byte;
    case 8:
        p = base + 0x2a;
        goto set_byte;
    case 9:
        p = base + 0x2b;
    set_byte:
        mask = 1 << bit;
        *p = *p | mask;
        break;
    }
}
