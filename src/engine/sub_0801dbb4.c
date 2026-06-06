#include "macros.h"
#include "types.h"

enum TextGlyph {
    GLYPH_LOWERCASE_OFFSET = 26,
    GLYPH_DIGIT_OFFSET = 0x3A,
    GLYPH_ZERO_INDEX = 9,
    GLYPH_STAR_TOP = 0x24,
    GLYPH_QUESTION = 0xE0D6,
    GLYPH_TILDE = 0xE0EA,
};

extern void Credits_DrawLineAlt(const u8 *str, u8 count, u8 colBase, u8 rowBase, u16 tileBase, s32 palBank, u8 screen);
extern s32 ParseDecimalStr(const char *str, u8 len);

extern const u8 sCreditsTilemapEng[];

void Credits_DrawLine(const u8 *str, u32 dst, u8 colBase, u8 rowBase)
{
    /* base=r6 and palBits=sl pins keep the loop state live across ParseDecimalStr; digitDst=r0
     * doubles as the colBase*2 staging scratch (see the base setup below). */
    s32 col;
    s32 row;
    register u16 palBits asm("sl");
    register u16 *base asm("r6");
    u8 i;
    int c;
    u16 t;
    u16 *dst16;
    s32 n;
    int letterIndex;
    u8 count;
    u8 start;
    s32 mode;
    u16 tileBase;
    register u16 *digitDst asm("r0");
    u16 digitValue;

    row = 0;
    count = 0;
    col = 1;

    while (str[count] != '|')
        count++;

    switch (str[0]) {
    case '1':
        start = 1;
        mode = 1;
        tileBase = 0x8B << 1;
        palBits = 0xE0 << 8;
        break;
    case '2':
        start = 1;
        mode = 2;
        tileBase = 0xA0;
        palBits = 0xF0 << 8;
        break;
    case '3':
        start = 1;
        mode = 3;
        tileBase = 1;
        palBits = 0xF0 << 8;
        break;
    default:
        start = 0;
        mode = 4;
        tileBase = 1;
        palBits = 0xE0 << 8;
        break;
    }

    if (mode == 1) {
        Credits_DrawLineAlt(str + 1, count - 1, colBase + 1, rowBase, tileBase, 14, 0);
        return;
    }

    i = start;
    if (i < count) {
        /* Stage colBase*2 through the r0 scratch so the base address is
         * built as `adds r6, r0, r1` (shift in r0, dst in r1) rather than
         * folded into r6 in place. */
        digitDst = (u16 *)(colBase * 2);
        base = (u16 *)((u32)digitDst + dst);
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
        } else if (c == '.') {
            *(u16 *)(((row * 2 + rowBase) << 6) + (u32)((u8 *)base + col * 2) + 0x40) = palBits + 0xD5;
        } else if (c == ',') {
            *(u16 *)(((row * 2 + rowBase) << 6) + (u32)((u8 *)base + col * 2) + 0x40) = palBits + 0xD4;
        } else if (c == ' ') {
            *(u16 *)(((row * 2 + rowBase) << 6) + (u32)((u8 *)base + col * 2) + 0x40) = 0;
        } else if (c == '*') {
            dst16 = (u16 *)((row * 2 + rowBase) << 6);
            dst16 = (u16 *)((u32)dst16 + (u32)(col * 2 + (u32)(u8 *)base));
            *dst16 = palBits + GLYPH_STAR_TOP;
            dst16 = (u16 *)((u8 *)dst16 + 0x40);
            *dst16 = palBits + GLYPH_STAR_TOP - 0x1B;
        } else if (c == '\'') {
            *(u16 *)(((row * 2 + rowBase) << 6) + (u32)((u8 *)base + col * 2) + 0x40) = palBits + 0xF8;
        } else if (c == ':') {
            *(u16 *)(((row * 2 + rowBase) << 6) + (u32)((u8 *)base + col * 2) + 0x40) = palBits + 0xFA;
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
