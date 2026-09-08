#include "text.h"
#include "types.h"

enum TextGlyph {
    GLYPH_LETTER_OFFSET = 20,
    GLYPH_ZERO_INDEX = 9,
    GLYPH_STAR_TOP = 0x24,
    GLYPH_STAR_BOTTOM = 0x24 - 0x1B,
    GLYPH_TILDE = 0x192,
};

extern const u8 sCreditsTilemapEng[];

void Credits_DrawLineAlt(const u8 *str, u8 count, u8 colBase, u8 rowBase, u16 tileBase, s32 palBank, u8 screen)
{
    u16 *base;
    u8 i;
    u16 palBits;
    s32 col;
    s32 row;
    int c;
    int t;
    s32 glyph;
    s16 palLow;
    u16 *dst;
    register u16 *dr2 asm("r2");
    s32 n;
    int letterIndex;
    s32 u;
    s32 top;

    palBits = (u32)(palBank << 28) >> 16;

    switch (screen) {
    case 0:
        base = (u16 *)0x02000000;
        break;
    case 1:
        base = (u16 *)0x02000800;
        break;
    case 2:
        base = (u16 *)0x02001000;
        break;
    case 3:
        base = (u16 *)0x02001800;
        break;
    }

    for (i = 0; i < count; i++) {
        palLow = (s16)palBits;
        c = str[i];

        if ((u8)(c - '0') <= 9) {
            if (c == '0') {
                t = GLYPH_ZERO_INDEX;
            } else {
                t = (u16)(c - '1');
            }
            dr2 = (u16 *)(rowBase << 6);
            dr2 = (u16 *)((u32)dr2 + (u32)(colBase * 2 + (u32)(u8 *)base));
            glyph = t * 2 + (u32)tileBase;
            *dr2 = palBits + glyph;
            dr2 = (u16 *)((u8 *)dr2 + 0x40);
            *dr2 = palLow + (glyph + 1);
        } else if ((letterIndex = c - 'A'), (u8)letterIndex <= 25) {
            t = (u16)letterIndex;
            dr2 = (u16 *)(rowBase << 6);
            dr2 = (u16 *)((u32)dr2 + (u32)(colBase * 2 + (u32)(u8 *)base));
            t <<= 1;
            u = t + GLYPH_LETTER_OFFSET;
            u += (u32)tileBase;
            top = palBits;
            top += u;
            *dr2 = top;
            dr2 = (u16 *)((u8 *)dr2 + 0x40);
            t += (u32)tileBase;
            t += 21;
            t = palLow - -t;
            *dr2 = t;
        } else if ((letterIndex = c - 'a'), (u8)letterIndex <= 25) {
            t = (u16)letterIndex;
            dr2 = (u16 *)(rowBase << 6);
            dr2 = (u16 *)((u32)dr2 + (u32)(colBase * 2 + (u32)(u8 *)base));
            t <<= 1;
            u = t + GLYPH_LETTER_OFFSET;
            u += (u32)tileBase;
            top = palBits;
            top += u;
            *dr2 = top;
            dr2 = (u16 *)((u8 *)dr2 + 0x40);
            t += (u32)tileBase;
            t += 21;
            t = palLow - -t;
            *dr2 = t;
        } else if (c == '[' && str[i + 4] == ']') {
            n = ParseDecimalStr((const char *)(str + i + 1), 3) - 0xC0;
            if ((u32)n <= 63) {
                u16 *escapeDst;
                const u8 *table;
                s32 m;

                escapeDst = (u16 *)(((row * 2 + rowBase) << 6) + (u32)(col * 2 + (u32)(colBase * 2 + (u32)(u8 *)base)));
                table = sCreditsTilemapEng;
                m = n * 3;
                *escapeDst = *(u16 *)(table + ((m + 1) << 1));
                *(u16 *)((u8 *)escapeDst + 0x40) = *(u16 *)(table + ((m + 2) << 1));
            }
            i = (u8)(i + 4);
        } else if (c == ' ') {
            *(u16 *)((rowBase << 6) + (u32)(colBase * 2 + (u32)(u8 *)base)) = 0;
            *(u16 *)((u8 *)(u16 *)((rowBase << 6) + (u32)(colBase * 2 + (u32)(u8 *)base)) + 0x40) = 0;
        } else if (c == '*') {
            *(u16 *)((rowBase << 6) + (u32)(colBase * 2 + (u32)(u8 *)base)) = palBits + GLYPH_STAR_TOP;
            *(u16 *)((u8 *)(u16 *)((rowBase << 6) + (u32)(colBase * 2 + (u32)(u8 *)base)) + 0x40) =
                palBits + GLYPH_STAR_BOTTOM;
        } else if (c == '~') {
            dst = (u16 *)((rowBase << 6) + (u32)(colBase * 2 + (u32)(u8 *)base));
            *dst = palBits + GLYPH_TILDE;
        }

        do {
            if (colBase <= 30) {
                ;
            } else if (rowBase > 30) {
                goto done;
            } else {
                colBase = 0;
                rowBase = (u8)(rowBase + 1);
                goto skipColIncrement;
            }
            colBase = (u8)(colBase + 1);
        skipColIncrement:;
        } while (0);
    }

done:;
}
