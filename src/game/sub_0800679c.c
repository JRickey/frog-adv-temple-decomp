#include "types.h"
#include "iwram.h"

/* Selector picks one of the control block's packed flag fields; the selected
 * bit comes back normalised to 0/1.
 *
 * Matching notes: `mask` is shared between selector 3 and the common tail so
 * it is a global (not block-local) pseudo -- global alloc then hands `r` r0
 * and `mask` r1, and the two `r &= mask` tails cross-jump into one `ands`.
 * Selector 1 branches straight to `ret_zero` so its 64-bit test shares the
 * tail's `cmp; beq` instead of growing a second compare. */
u32 ModeControl_GetFlag(void *baseIn, u32 selectorIn, u32 bitIn)
{
    struct IwramAt6110 *control = baseIn;
    u32 selector = (u8)selectorIn;
    u32 bit = (u8)bitIn;
    u32 r;
    u32 mask;

    switch (selector) {
    case 0:
        r = control->flags0;
        break;
    case 1:
        if ((control->flags64 & (1 << bit)) == 0)
            goto ret_zero;
        return 1;
    case 2:
        r = control->flags2;
        break;
    case 3:
        mask = 1;
        mask <<= bit;
        r = control->scenePhase;
        r &= mask;
        goto check;
    case 4:
        r = control->activeFlags;
        break;
    case 5:
        r = control->selector5Flags;
        break;
    case 7:
        r = control->byteFlags7;
        break;
    case 8:
        r = control->byteFlags8;
        break;
    case 9:
        r = control->gateByte;
        break;
    default:
        goto ret_zero;
    }

    r = (s32)r >> bit;
    mask = 1;
    r &= mask;

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
