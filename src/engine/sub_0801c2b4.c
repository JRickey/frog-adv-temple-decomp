#include "text.h"
#include "macros.h"
#include "types.h"

#define EMPTY_DIGIT         0xFF
#define ASCII_ZERO          0x30
#define MAX_PRINTABLE_VALUE 9999
#define BLANK_DIGITS        ((const u8 *)0x081BE03C)

extern u32 __udivsi3(u32 num, u32 den);
extern u32 __umodsi3(u32 num, u32 den);

void DrawNumber(u16 value, u8 x, u8 y, u16 a, u16 b, u8 c, u32 forceZeros)
{
    u8 buf[4];
    u8 digit;
    u8 out;

    for (out = 0; out <= 3; out++) {
        buf[out] |= EMPTY_DIGIT;
    }

    out = 0;
    if (value == 0) {
        DrawTextGlyphs(BLANK_DIGITS, 4, x, y, a, b, c);
    }

    if (value <= MAX_PRINTABLE_VALUE) {
        digit = (u8)__udivsi3(value, 1000);
        value = (u16)__umodsi3(value, 1000);
        {
            u8 *dst;

            dst = &buf[out];
            if (digit != 0 || forceZeros != 0) {
                *dst = digit + ASCII_ZERO;
            } else {
                *dst = EMPTY_DIGIT;
            }
        }
        if (buf[out] != EMPTY_DIGIT) {
            out++;
            if (forceZeros == 0) {
                forceZeros = 1;
            }
        }

        digit = (u8)__udivsi3(value, 100);
        value = (u16)__umodsi3(value, 100);
        {
            u8 *dst;

            dst = &buf[out];
            if (digit != 0 || forceZeros != 0) {
                *dst = digit + ASCII_ZERO;
            } else {
                *dst = EMPTY_DIGIT;
            }
        }
        if (buf[out] != EMPTY_DIGIT) {
            out++;
            if (forceZeros == 0) {
                forceZeros = 1;
            }
        }

        digit = (u8)__udivsi3(value, 10);
        value = (u16)__umodsi3(value, 10);
        {
            u8 *dst;

            dst = &buf[out];
            if (digit != 0 || forceZeros != 0) {
                *dst = digit + ASCII_ZERO;
            } else {
                *dst = EMPTY_DIGIT;
            }
        }
        if (buf[out] != EMPTY_DIGIT) {
            out++;
            if (forceZeros == 0) {
                forceZeros = 1;
            }
        }

        digit = (u8)value;
        {
            register u8 *dst asm("r0");

            dst = &buf[out];
            if (digit != 0 || forceZeros != 0) {
                *dst = digit + ASCII_ZERO;
            } else {
                *dst = EMPTY_DIGIT;
            }
        }
    }

    DrawTextGlyphs(buf, 4, x, y, a, b, c);
}
