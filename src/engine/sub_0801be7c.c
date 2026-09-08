#include "text.h"
#include "types.h"

enum TextScreenblock {
    TEXT_VRAM_BASE = 0x0600E000,
    TEXT_SCREENBLOCK_BYTES = 0x800,
    TEXT_ROW_BYTES = 64,
};

#define SCREENBLOCK_BASE(screen) (TEXT_VRAM_BASE + (screen) * TEXT_SCREENBLOCK_BYTES)

enum TextGlyph {
    GLYPH_LETTER_OFFSET = 20,
    GLYPH_ZERO_INDEX = 9,
    GLYPH_BRACKET_TOP = 0x180,
    GLYPH_BRACKET_PAIR = 0x186,
    GLYPH_STAR_TOP = 0x24,
    GLYPH_STAR_BOTTOM = 9,
    GLYPH_TILDE = 0x192,
};

void DrawTextGlyphs(const u8 *str, s32 countArg, s32 colArg, s32 rowArg, s32 tileBaseArg, s32 palBank, s32 screenArg)
{
    u16 *base;
    u8 i;
    u16 palBits;
    s32 character;
    s32 glyphIndex;
    s32 glyph;
    s16 signedPaletteBits;
    /* Physical VRAM addresses keep the row-byte offset ahead of the column offset. */
    u32 tileAddress;
    s32 escapeIndex;
    s32 letterTopGlyph;
    s32 tileEntry;

    /* Callers pass words; the renderer narrows coordinates and glyph counts on entry. */
    u8 count = countArg;
    u8 col = colArg;
    u8 row = rowArg;
    u16 tileBase = tileBaseArg;
    u8 screen = screenArg;

    palBits = ((u32)palBank << 28) >> 16;

    switch (screen) {
    case 0:
        base = (u16 *)SCREENBLOCK_BASE(0);
        break;
    case 1:
        base = (u16 *)SCREENBLOCK_BASE(1);
        break;
    case 2:
        base = (u16 *)SCREENBLOCK_BASE(2);
        break;
    case 3:
        base = (u16 *)SCREENBLOCK_BASE(3);
        break;
    }

    for (i = 0; i < count; i++) {
        signedPaletteBits = (s16)palBits;
        character = str[i];

        if ((u8)(character - '0') <= 9) {
            if (character == '0') {
                glyphIndex = GLYPH_ZERO_INDEX;
            } else {
                glyphIndex = (u16)(character - '1');
            }
            tileAddress = row * TEXT_ROW_BYTES;
            tileAddress += (u32)(base + col);
            glyph = glyphIndex * 2;
            glyph += (u32)tileBase;
            *(u16 *)tileAddress = palBits + glyph;
            tileAddress += TEXT_ROW_BYTES;
            *(u16 *)tileAddress = signedPaletteBits + (glyph + 1);
        } else if ((u8)(character - 'A') <= 25) {
            glyphIndex = (u16)(character - 'A');
            tileAddress = row * TEXT_ROW_BYTES;
            tileAddress += (u32)(base + col);
            glyphIndex <<= 1;
            letterTopGlyph = glyphIndex + GLYPH_LETTER_OFFSET;
            letterTopGlyph += (u32)tileBase;
            tileEntry = palBits;
            tileEntry += letterTopGlyph;
            *(u16 *)tileAddress = tileEntry;
            tileAddress += TEXT_ROW_BYTES;
            glyphIndex += (u32)tileBase;
            glyphIndex += GLYPH_LETTER_OFFSET + 1;
            /* Subtracting the negated index preserves the reference add operand order. */
            glyphIndex = signedPaletteBits - -glyphIndex;
            *(u16 *)tileAddress = glyphIndex;
        } else if ((u8)(character - 'a') <= 25) {
            glyphIndex = (u16)(character - 'a');
            tileAddress = row * TEXT_ROW_BYTES;
            tileAddress += (u32)(base + col);
            glyphIndex <<= 1;
            letterTopGlyph = glyphIndex + GLYPH_LETTER_OFFSET;
            letterTopGlyph += (u32)tileBase;
            tileEntry = palBits;
            tileEntry += letterTopGlyph;
            *(u16 *)tileAddress = tileEntry;
            tileAddress += TEXT_ROW_BYTES;
            glyphIndex += (u32)tileBase;
            glyphIndex += GLYPH_LETTER_OFFSET + 1;
            /* Subtracting the negated index preserves the reference add operand order. */
            glyphIndex = signedPaletteBits - -glyphIndex;
            *(u16 *)tileAddress = glyphIndex;
        } else if (character == '[' && str[i + 4] == ']') {
            u32 escapeAddress;
            s32 escapeBase;

            escapeIndex = ParseDecimalStr((const char *)(str + i + 1), 3);
            if ((u32)escapeIndex <= 5) {
                col = (u8)(col - 1);
                escapeAddress = row * TEXT_ROW_BYTES;
                escapeAddress += (u32)(base + col);
                escapeAddress -= TEXT_ROW_BYTES;
                escapeBase = GLYPH_BRACKET_TOP;
                *(u16 *)escapeAddress = signedPaletteBits + (escapeIndex + escapeBase);
            } else {
                escapeIndex -= 6;
                if ((u32)escapeIndex <= 6) {
                    escapeAddress = row * TEXT_ROW_BYTES;
                    escapeAddress += (u32)(base + col);
                    escapeIndex *= 2;
                    escapeBase = GLYPH_BRACKET_PAIR;
                    *(u16 *)escapeAddress = signedPaletteBits + (escapeIndex + escapeBase);
                    escapeAddress += TEXT_ROW_BYTES;
                    escapeBase++;
                    *(u16 *)escapeAddress = signedPaletteBits + (escapeIndex + escapeBase);
                }
            }
            count = (u8)(count + 4);
            i = (u8)(i + 4);
        } else if (character == ' ') {
            *(u16 *)(row * TEXT_ROW_BYTES + (u32)(base + col)) = 0;
            *(u16 *)(row * TEXT_ROW_BYTES + (u32)(base + col) + TEXT_ROW_BYTES) = 0;
        } else if (character == '*') {
            *(u16 *)(row * TEXT_ROW_BYTES + (u32)(base + col)) = palBits + GLYPH_STAR_TOP;
            *(u16 *)(row * TEXT_ROW_BYTES + (u32)(base + col) + TEXT_ROW_BYTES) = palBits + GLYPH_STAR_BOTTOM;
        } else if (character == '~') {
            *(u16 *)(row * TEXT_ROW_BYTES + (u32)(base + col)) = palBits + GLYPH_TILDE;
        } else if (character == '\n') {
            col = 0;
            row = (u8)(row + 3);
        }

        if (col > 28 && row <= 19) {
            col = 0;
            row = (u8)(row + 1);
        } else if (col > 30 && row > 30) {
            break;
        } else {
            col = (u8)(col + 1);
        }
    }
}
