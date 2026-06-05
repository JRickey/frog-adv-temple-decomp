#include "types.h"

/* IEEE-754 comparator over the decomposed form sub_080340D4 emits.
 * type: 0/1 = NaN, 2 = zero, 3 = finite, 4 = infinity.
 *
 * Matching shape: each test materializes a boolean via the
 * `flag = 0; if (cond) flag = 1;` idiom (as in the caller sub_08034760),
 * with a distinct temporary per test so agbcc keeps the redundant zero
 * between adjacent checks that share a branch target. Caching a field in
 * a local before use (sb/sa/sign_a) pins the load order and lets the
 * sign-result tail reuse the dead pointer register. */
struct FloatComponents {
    u32 type;
    u32 sign;
    s32 exp;
    u32 mantissa;
};

s32 sub_0803457C(struct FloatComponents *a, struct FloatComponents *b)
{
    s32 c0, c1, c2, c3, c4, c5, c6, c7, c8;
    s32 r;
    s32 rg;
    s32 sb;
    s32 sa;
    s32 sign_a;

    c0 = 0;
    if (a->type <= 1)
        c0 = 1;
    if (c0 != 0)
        goto ret_one;
    c1 = 0;
    if (b->type <= 1)
        c1 = 1;
    if (c1 == 0)
        goto cont;
ret_one:
    return 1;

cont:
    c2 = 0;
    if (a->type == 4)
        c2 = 1;
    if (c2 != 0) {
        c3 = 0;
        if (b->type == 4)
            c3 = 1;
        if (c3 != 0)
            return b->sign - a->sign;
    }

    c4 = 0;
    if (a->type == 4)
        c4 = 1;
    if (c4 != 0)
        goto sign_of_a;
    c5 = 0;
    if (b->type == 4)
        c5 = 1;
    if (c5 == 0)
        goto skip_sign_of_b;
sign_of_b:
    sb = b->sign;
    r = -1;
    if (sb != 0)
        r = 1;
    goto ret_r;

skip_sign_of_b:
    c6 = 0;
    if (a->type == 2)
        c6 = 1;
    if (c6 != 0) {
        c7 = 0;
        if (b->type == 2)
            c7 = 1;
        if (c7 != 0)
            return 0;
    }

    c8 = 0;
    if (a->type == 2)
        c8 = 1;
    if (c8 != 0)
        goto sign_of_b;
    c0 = 0;
    if (b->type == 2)
        c0 = 1;
    if (c0 == 0)
        goto compare_finite;
sign_of_a:
    sa = a->sign;
    r = 1;
    if (sa != 0)
        r = -1;
ret_r:
    return r;

compare_finite:
    sign_a = a->sign;
    if (sign_a != b->sign) {
    by_sign:
        rg = 1;
        if (sign_a != 0)
            rg = -1;
        return rg;
    }
    if (a->exp > b->exp)
        goto by_sign;
    if (a->exp < b->exp) {
    by_sign_flipped:
        rg = -1;
        if (sign_a != 0)
            rg = 1;
        return rg;
    }
    if (a->mantissa > b->mantissa)
        goto by_sign;
    if (a->mantissa < b->mantissa)
        goto by_sign_flipped;
    return 0;
}
