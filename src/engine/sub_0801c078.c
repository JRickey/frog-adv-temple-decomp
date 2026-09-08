#include "text.h"
#include "macros.h"
#include "types.h"

#define SCREENBLOCK_BASE(sb) (0x06000000u + (sb) * 0x800u)

enum TextGlyph {
    GLYPH_LOWERCASE_OFFSET = 26,
    GLYPH_DIGIT_OFFSET = 0x3A,
    GLYPH_ZERO_INDEX = 9,
    GLYPH_STAR_TOP = 0x24,
    GLYPH_QUESTION = 0xE0D6,
    GLYPH_TILDE = 0xE0EA,
};

extern const u8 sCreditsTilemapEng[];

void DrawTilemapString(const u8 *str, u8 count, u8 colBase, u8 rowBase, u16 tileBase, s32 palBank, u8 screen)
{
    /* Pins keep the baserom loop state live across ParseDecimalStr: col=r8, row=r9, palette=sl, base=r6. */
    s32 col;
    s32 row;
    register u16 palBits asm("sl");
    register u16 *base asm("r6");
    u8 i;
    int c;
    u16 t;
    u16 *dst;
    s32 n;
    int letterIndex;
    /* Digit pins make the digit store tail share the baserom's r1/r0 cross-jump with the tilde case. */
    u16 digitValue;
    register u16 *digitDst asm("r0");

    palBits = (palBank << 28) >> 16;
    col = 0;
    row = 0;

    switch (screen) {
    case 0:
        base = (u16 *)SCREENBLOCK_BASE(28);
        break;
    case 1:
        base = (u16 *)SCREENBLOCK_BASE(29);
        break;
    case 2:
        base = (u16 *)SCREENBLOCK_BASE(30);
        break;
    case 3:
        base = (u16 *)SCREENBLOCK_BASE(31);
        break;
    }

    i = 0;
    if (i < count) {
        base = (u16 *)(colBase * 2 + (u32)base);
    }

    for (; i < count; i++) {
        c = str[i];

        if ((u8)(c - '0') <= 9) {
            if (c == '0') {
                t = GLYPH_ZERO_INDEX;
            } else {
                t = c - '1';
            }

            digitDst = (u16 *)(((row * 2 + rowBase) << 6) + (u32)(col * 2 + (u32)(u8 *)base) + 0x40);
            digitValue = (u16)(t + GLYPH_DIGIT_OFFSET) + tileBase + palBits;
            *digitDst = digitValue;
        } else if ((letterIndex = c - 'A'), (u8)letterIndex <= 25) {
            t = letterIndex;
            *(u16 *)(((row * 2 + rowBase) << 6) + (u32)((u8 *)base + col * 2) + 0x40) = tileBase + t + palBits;
        } else if ((letterIndex = c - 'a'), (u8)letterIndex <= 25) {
            t = letterIndex;
            *(u16 *)(((row * 2 + rowBase) << 6) + (u32)((u8 *)base + col * 2) + 0x40) =
                (u16)(t + GLYPH_LOWERCASE_OFFSET) + tileBase + palBits;
        } else if (c == '[' && str[i + 4] == ']') {
            n = ParseDecimalStr((const char *)(str + i + 1), 3) - 0xC0;
            if ((u32)n <= 63) {
                /* These pins target the bracket-case rotation: dst=r2, table=r3, n*3=r1. */
                u16 *escapeDst;
                const u8 *table;
                s32 m;

                escapeDst = (u16 *)((row * 2 + rowBase) << 6);
                escapeDst = (u16 *)((u32)escapeDst + (u32)(col * 2 + (u32)(u8 *)base));
                table = sCreditsTilemapEng;
                m = n * 3;
                *escapeDst = *(u16 *)(((m + 1) << 1) + (u32)table);
                escapeDst = (u16 *)((u8 *)escapeDst + 0x40);
                *escapeDst = *(u16 *)(((m + 2) << 1) + (u32)table);
            }
            i += 4;
        } else if (c == ' ') {
            *(u16 *)(((row * 2 + rowBase) << 6) + (u32)((u8 *)base + col * 2) + 0x40) = 0;
        } else if (c == '*') {
            dst = (u16 *)((row * 2 + rowBase) << 6);
            dst = (u16 *)((u32)dst + (u32)(col * 2 + (u32)(u8 *)base));
            *dst = palBits + GLYPH_STAR_TOP;
            dst = (u16 *)((u8 *)dst + 0x40);
            *dst = palBits + GLYPH_STAR_TOP - 0x1B;
        } else if (c == '?') {
            *(u16 *)(((row * 2 + rowBase) << 6) + (u32)((u8 *)base + col * 2) + 0x40) = GLYPH_QUESTION;
        } else if (c == '~') {
            *(u16 *)(((row * 2 + rowBase) << 6) + (u32)((u8 *)base + col * 2) + 0x40) = GLYPH_TILDE + palBits;
        } else if (c == '|') {
            break;
        }

        col = (u8)(col + 1);
        if (c == '\n') {
            col = 0;
            row = (u8)(row + 1);
        }
    }
}
