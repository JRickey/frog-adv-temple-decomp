#include "types.h"

/* Reassembles an IEEE-754 single-precision float from the decomposed form
 * produced by sub_080340D4 (the inverse routine):
 *   type 0/1 -> NaN (force exponent 0xFF, set quiet bit)
 *   type 2   -> zero (mantissa 0)
 *   type 4   -> infinity (exponent 0xFF, mantissa 0)
 *   type 3   -> finite value, renormalised from exp + mantissa
 * The mantissa arrives shifted up by 7 guard bits; the type-3 path rounds
 * round-half-to-even on those guard bits before shifting them back out. */
struct FloatComponents {
    u32 type;
    u32 sign;
    s32 exp;
    u32 mantissa;
};

u32 sub_0803401C(struct FloatComponents *comp)
{
    u32 result;
    u32 type;
    /* The original holds the -126 minimum-exponent constant in the register
     * vacated by `type`; pin it to r3 so agbcc reuses that register rather
     * than the one freed by `flag`. */
    register s32 neg_min asm("r3");
    u32 mantissa;
    u32 sign;
    u32 biased_exp;
    s32 exp;
    s32 shift;
    /* The dispatch booleans live in r1, which forces mantissa up to r2 and
     * keeps the whole low-register file in baserom order; without the pin
     * agbcc colours the boolean one register too high. r1 is also reused for
     * the exponent/sign bitfield shifts in the tail, matching the original. */
    register u32 flag asm("r1");

    mantissa = comp->mantissa;
    sign = comp->sign;
    biased_exp = 0;
    flag = 0;
    type = comp->type;

    if (type <= 1) {
        flag = 1;
    }
    if (flag) {
        biased_exp = 0xFF;
        mantissa |= (u32)0x80 << 13;
        goto assemble;
    }

    flag = 0;
    if (type == 4) {
        flag = 1;
    }
    if (flag) {
        goto infinity;
    }

    flag = 0;
    if (type == 2) {
        flag = 1;
    }
    if (flag) {
        mantissa = 0;
        goto assemble;
    }

    if (mantissa == 0) {
        goto assemble;
    }

    exp = comp->exp;
    neg_min = -126;
    if (exp < neg_min) {
        shift = neg_min - exp;
        if (shift > 25) {
            mantissa = 0;
            goto assemble_shifted;
        }
        mantissa >>= shift;
        goto assemble_shifted;
    }

    if (exp > 127) {
    infinity:
        biased_exp = 0xFF;
        mantissa = 0;
        goto assemble;
    }

    biased_exp = exp + 127;

    if ((mantissa & 0x7F) == 0x40) {
        if (mantissa & 0x80) {
            mantissa += 0x40;
        }
    } else {
        mantissa += 0x3F;
    }

    if ((s32)mantissa < 0) {
        mantissa >>= 1;
        biased_exp += 1;
    }

assemble_shifted:
    mantissa >>= 7;

assemble:
    mantissa &= 0x007FFFFF;
    result &= 0xFF800000;
    result |= mantissa;
    biased_exp &= 0xFF;
    flag = biased_exp << 23;
    result &= 0x807FFFFF;
    result |= flag;
    flag = sign << 31;
    result &= 0x7FFFFFFF;
    result |= flag;

    return result;
}
