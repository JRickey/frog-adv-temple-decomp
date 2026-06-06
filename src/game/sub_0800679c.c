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
 *   - The shared result/pointer locals (`r asm("r0")`, `p asm("r0")`) keep
 *     the function free of callee-saved push/pop and let `mov pc, r0`
 *     dispatch directly out of the jump-table load.
 *   - Selectors 7/8/9 build `base + off` in `p` (also r0) — the pin
 *     stops agbcc from clobbering r3, and the shared `goto load_byte`
 *     keeps the trailing `ldrb r0, [r0, #0]` block reused by all
 *     three.
 *   - Selector 1 pins `lo asm("r2")`, `hi asm("r3")`, `signExt asm("r1")`
 *     to force agbcc to destructively reuse the input arg registers
 *     for the two `ldr`s. The empty `hi` barrier
 *     between `hi &= signExt;` and `r = hi;` prevents agbcc from
 *     folding the two into a single `r = hi & signExt`, restoring the
 *     baserom's `ands r3, r1; adds r0, r3, #0; orrs r0, r2` ordering. */

u32 ModeControl_GetFlag(u8 *baseIn, u32 selectorIn, u32 bitIn)
{
    u8 *base = baseIn;
    u32 selector = (u8)selectorIn;
    u32 bit = (u8)bitIn;
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

/* Reads bit-range [lo, hi] out of the 128-bit flag bank at IWRAM
 * 0x03006110 (two adjacent u64 lanes at byte offsets 20 and 28), shifts
 * the selected bits down so bit `lo` lands at bit 0, and returns them as
 * a 64-bit value. The `unused` base pointer callers pass is ignored — the
 * bank address is reloaded from this function's own pool.
 *
 * Matching notes (old_agbcc):
 *   - `mask` is a single local reused by all three branches; the spanning
 *     branch's four live values (lowCount, the literal 1, the bank pointer,
 *     and `hi`) consume r4-r7, which spills `mask` to the stack everywhere,
 *     exactly as the baserom does.
 *   - The two-statement `result = bankval >> shift; result &= mask;` form
 *     routes the masked AND through the stack (the lone-expression
 *     `mask & (bankval >> shift)` keeps it in registers and diverges).
 *   - `bankBase` is a branch-local pointer distinct from `bank` so its live
 *     range pins it into r6 across both reads in the spanning branch.
 */
s64 CtrlFlags_ReadBitRange(void *unused, s32 lo, s32 hi)
{
    u8 count = hi - lo + 1;
    s64 mask;
    s32 shift;
    unsigned long long bankval;
    unsigned long long *bank;
    s64 result;

    if (hi <= 63) {
        mask = (unsigned long long)(s32)((1 << (s8)count) - 1);
        bank = (unsigned long long *)0x03006110;
        bankval = *(unsigned long long *)((char *)bank + 20);
        shift = lo;
        goto applyMask;
    }

    if (lo > 63) {
        mask = (unsigned long long)(s32)((1 << (s8)count) - 1);
        bank = (unsigned long long *)0x03006110;
        shift = lo - 64;
        bankval = *(unsigned long long *)((char *)bank + 28);
    applyMask:
        result = bankval >> shift;
        result &= mask;
        goto done;
    }

    {
        s32 lowCount = 64 - lo;
        unsigned long long *bankBase;
        s64 highBits;

        mask = (unsigned long long)(s32)((1 << lowCount) - 1);
        bankBase = (unsigned long long *)0x03006110;
        result = *(unsigned long long *)((char *)bankBase + 20) >> lo;
        result &= mask;

        mask = (unsigned long long)(s32)((1 << (hi - 63)) - 1);
        highBits = *(unsigned long long *)((char *)bankBase + 28) & mask;
        result += (unsigned long long)highBits << lowCount;
    }

done:
    return result;
}
