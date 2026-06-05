#include "types.h"

struct FloatComponents {
    u32 type;
    u32 sign;
    s32 exp;
    u32 mantissa;
};

void sub_080340D4(u32 *input, struct FloatComponents *out)
{
    u32 bits;
    u32 mantissa;
    u32 exponent;
    u32 sign;
    s32 exp4;
    s32 e;
    u32 test;

    bits = *input;
    mantissa = (bits << 9) >> 9;
    exponent = (bits << 1) >> 24;
    sign = bits >> 31;

    out->sign = sign;

    if (exponent == 0) {
        if (mantissa == 0) {
            out->type = 2;
            return;
        }

        exp4 = (s32)exponent - 126;
        out->exp = exp4;
        mantissa = mantissa << 7;
        out->type = 3;

        if (mantissa <= 0x3FFFFFFF) {
            e = exp4;
            do {
                mantissa <<= 1;
                e -= 1;
            } while (mantissa <= 0x3FFFFFFF);
            out->exp = e;
        }

        out->mantissa = mantissa;
        return;
    }

    if (exponent == 0xFF) {
        if (mantissa == 0) {
            out->type = 4;
            return;
        }

        test = ((u32)0x80 << 13) & mantissa;
        if (test != 0) {
            test = 1;
        }
        out->type = test;
        out->mantissa = mantissa;
        return;
    }

    out->exp = (s32)exponent - 127;
    out->type = 3;
    out->mantissa = (mantissa << 7) | ((u32)0x80 << 23);
}
