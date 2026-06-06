#include "types.h"

/* Three signed-16-bit fixed-point helpers.
 *
 * For the two multiply helpers the baserom keeps the unbiased product in r0
 * (for the sign test) and the round-toward-zero divide works on a *copy* in
 * r1 (`adds r1, r0, #0`). agbcc's signed-divide-by-power-of-2 expander only
 * emits that eager copy when the dividend's source register is still live
 * past the divide; with the plain `a * b / N` form it biases r0 in place.
 * The trailing `t = a` dead store anchors `a`'s register live across the
 * divide, which is what forces the matching copy. */

/* 8.8 fixed-point multiply: (a * b) / 256, round toward zero. */
s16 Fixed8Mul(s16 a, s16 b)
{
    s32 prod;
    s16 t;

    prod = a * b;
    prod = prod / 256;
    t = a;
    return prod;
}

/* 16.16 fixed-point multiply: (a * b) / 0x10000, round toward zero. */
s16 Fixed16Mul(s16 a, s16 b)
{
    s32 prod;
    s16 t;

    prod = a * b;
    prod = prod / 0x10000;
    t = a;
    return prod;
}

/* 8.8 fixed-point divide: (a << 8) / b. */
s16 Fixed8Div(s16 a, s16 b)
{
    return ((s32)a << 8) / b;
}
