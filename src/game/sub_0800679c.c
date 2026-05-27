#include "types.h"

/* Generic bit-test accessor on a struct at `base`. The (selector, bit)
 * pair indexes a packed flag stored in one of nine struct fields; the
 * return value is the selected bit, normalised to 0 or 1.
 *
 * Selector 1 reads a 64-bit halfword pair (offsets 4 / 8) and routes the
 * sign-extended (1<<bit) mask through both lanes so bit indices 32-63
 * naturally extract from the high half — that branch joins the final
 * `r != 0 ? 1 : 0` normaliser directly, skipping the trailing
 * `asrs r0, bit; ands r0, 1` step the other selectors share.
 *
 * Selector 6 is the explicit "no such flag" slot — its jump-table entry
 * targets the same `r0 = 0; bx lr` epilogue the `default:` (selector
 * >= 10) and the false-check both fall through to, so the function
 * ships with a single shared "false" exit.
 *
 * Matching notes (old_agbcc):
 *   - Every live value is pinned to its arg / return register
 *     (`base asm("r3")`, `bit asm("r2")`, `r asm("r0")`, `p asm("r0")`)
 *     so the function ships with no callee-saved push/pop and
 *     `mov pc, r0` dispatches directly out of the jump-table load.
 *   - Selectors 7/8/9 build `base + off` in `p` (also r0) — the pin
 *     stops agbcc from clobbering r3, and the shared `goto load_byte`
 *     keeps the trailing `ldrb r0, [r0, #0]` block reused by all
 *     three.
 *   - Selector 1 pins `lo asm("r2")`, `hi asm("r3")`, `signExt asm("r1")`
 *     to force agbcc to destructively reuse the input arg registers
 *     for the two `ldr`s. The `asm volatile("" : "+r"(hi))` barrier
 *     between `hi &= signExt;` and `r = hi;` prevents agbcc from
 *     folding the two into a single `r = hi & signExt`, restoring the
 *     baserom's `ands r3, r1; adds r0, r3, #0; orrs r0, r2` ordering. */

u32 sub_0800679C(u8 *baseIn, u32 selectorIn, u32 bitIn)
{
    register u8 *base asm("r3") = baseIn;
    register u32 selector asm("r0") = (u8)selectorIn;
    register u32 bit asm("r2") = (u8)bitIn;
    register u32 r asm("r0");
    register u8 *p asm("r0");
    s32 mask;

    switch (selector) {
    case 0:
        r = *(u16 *)(base + 0);
        break;
    case 1: {
        register u32 lo asm("r2");
        register u32 hi asm("r3");
        register s32 signExt asm("r1");
        mask = 1 << bit;
        signExt = mask >> 31;
        lo = *(u32 *)(base + 4);
        hi = *(u32 *)(base + 8);
        lo &= mask;
        hi &= signExt;
        asm volatile("" : "+r"(hi));
        r = hi;
        r |= lo;
        goto check;
    }
    case 2:
        r = *(u16 *)(base + 12);
        break;
    case 3:
        mask = 1 << bit;
        r = *(u32 *)(base + 16) & mask;
        goto check;
    case 4:
        r = *(u16 *)(base + 0x24);
        break;
    case 5:
        r = *(u16 *)(base + 0x26);
        break;
    case 7:
        p = base;
        p += 0x2c;
        goto load_byte;
    case 8:
        p = base;
        p += 0x2a;
        goto load_byte;
    case 9:
        p = base;
        p += 0x2b;
    load_byte:
        r = *p;
        break;
    default:
        goto ret_zero;
    }

    r = (u32)((s32)r >> bit) & 1;

check:
    if (r != 0)
        return 1;

ret_zero:
    return 0;
}
