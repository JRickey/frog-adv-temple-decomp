#include "text.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

#define BG_SCREENBLOCK_31              ((volatile struct BgScreenblock *)0x0600f800)
#define BG_SCREENBLOCK_ROW_OFFSET(row) OFFSET_OF(struct BgScreenblock, entry[row][0])
#define BG_SCREENBLOCK_COL_OFFSET(col) OFFSET_OF(struct BgScreenblock, entry[0][col])

struct BgScreenblock {
    vu16 entry[32][32];
};

void HUD_DrawStampIcons(void)
{
    u32 tileBase1 = (u32)0xb1 << 8;
    u32 tileBase2 = 0x0000a109;
    register u32 ipBase asm("ip");
    register volatile struct BgScreenblock *screenblock asm("r6");
    register u32 row2 asm("r0");
    u32 row;
    u8 col;
    u32 rowOff;
    u32 vramRow;
    u32 nextRow;

    row = 0;
    ipBase = BG_SCREENBLOCK_ROW_OFFSET(16);
    rowOff = ipBase + BG_SCREENBLOCK_COL_OFFSET(1);
    screenblock = BG_SCREENBLOCK_31;
    do {
        u32 row64;
        u32 vramRow1;
        u32 tileRow1;

        col = 0;
        row64 = (u32)row * 64;
        row2 = (u32)row * 2;
        vramRow1 = row64 + rowOff;
        tileRow1 = tileBase1 + (row2 + (u32)row);
        do {
            *(vu16 *)((u32)col * 2 + vramRow1 + (u32)screenblock) = (u16)(tileRow1 + col);
            col++;
        } while (col <= 2);
        row = (u8)(row + 1);
    } while (row <= 2);

    row = 0;
    asm volatile("" : "+r"(ipBase));
    rowOff = ipBase + BG_SCREENBLOCK_COL_OFFSET(20);
    screenblock = BG_SCREENBLOCK_31;
    do {
        u32 row64;

        col = 0;
        row64 = (u32)row * 64;
        row2 = (u32)row * 2;
        nextRow = row + 1;
        vramRow = row64 + rowOff;
        row = tileBase2 + (row2 + row);
        do {
            *(vu16 *)((u32)col * 2 + vramRow + (u32)screenblock) = (u16)(row + col);
            col++;
        } while (col <= 2);
        row = (u8)nextRow;
    } while (row <= 2);
}

/* UI string addresses (raw casts, matching the sibling style in
 * DrawNumber / sub_0801C0xx). Both live in sWinLoseLabels at 0x081be008. */
#define UI_DIGIT_GLYPH ((const u8 *)0x081BE040) /* "*" digit-fill glyph */
#define UI_TIME_LABEL  ((const u8 *)0x081BE044) /* "TIME" label */

/* Codepoints for the two 2x2 frame stamps that bracket the two score
 * readouts on row 17 (TL/TR over BL/BR). */
#define UI_STAMP_TL 0xc112
#define UI_STAMP_TR 0xc113
#define UI_STAMP_BL 0xc114
#define UI_STAMP_BR 0xc115

/* Paints the dual score panel on BG screenblock 31: two "*NN" readouts on
 * row 17 (values b and a, each framed by a 2x2 stamp) plus a "TIME NN"
 * readout (value c) on row 1. NN is rendered as two ASCII digits via the
 * div/mod-10 helpers. The scene supplies signed halfword scores and an
 * unsigned halfword counter; the renderer displays their low bytes.
 *
 * rowBase (= row 17's byte offset, 17*64) is anchored in a register by the
 * asm barrier so each stamp store keeps its full screenblock address as an
 * independent pool literal instead of being CSE-folded into +2 increments. */
void HUD_DrawStatus(s16 rightValue, s16 leftValue, u16 counter)
{
    u8 a = (u8)rightValue;
    u8 b = (u8)leftValue;
    u8 c = (u8)counter;
    u8 buf[4];
    u8 tens;
    u8 units;
    u32 rowBase;

    rowBase = 17 * 64;
    asm volatile("" : "+r"(rowBase));
    *(vu16 *)(rowBase + 0x0600f80aU) = UI_STAMP_TL;
    *(vu16 *)(rowBase + 0x0600f80cU) = UI_STAMP_TR;
    *(vu16 *)(rowBase + 0x0600f84aU) = UI_STAMP_BL;
    *(vu16 *)(rowBase + 0x0600f84cU) = UI_STAMP_BR;

    DrawTextGlyphs(UI_DIGIT_GLYPH, 4, 7, 17, 278, 14, 3);

    tens = (u8)(b / 10u);
    units = (u8)(b % 10u);
    buf[0] = tens + 0x30;
    buf[1] = units + 0x30;
    DrawTextGlyphs(buf, 2, 9, 17, 278, 14, 3);

    *(vu16 *)(rowBase + 0x0600f830U) = UI_STAMP_TL;
    *(vu16 *)(rowBase + 0x0600f832U) = UI_STAMP_TR;
    *(vu16 *)(rowBase + 0x0600f870U) = UI_STAMP_BL;
    *(vu16 *)(rowBase + 0x0600f872U) = UI_STAMP_BR;

    DrawTextGlyphs(UI_DIGIT_GLYPH, 4, 26, 17, 278, 14, 3);

    tens = (u8)(a / 10u);
    units = (u8)(a % 10u);
    buf[0] = tens + 0x30;
    buf[1] = units + 0x30;
    DrawTextGlyphs(buf, 2, 28, 17, 278, 14, 3);

    DrawTextGlyphs(UI_TIME_LABEL, 4, 12, 1, 278, 14, 3);

    tens = (u8)(c / 10u);
    units = (u8)(c % 10u);
    buf[0] = tens + 0x30;
    buf[1] = units + 0x30;
    DrawTextGlyphs(buf, 2, 17, 1, 278, 14, 3);
}

/* Tear down the bonus/score panel: turn off WIN0 in DISPCNT, blank the
 * window clip registers and palette entry 0, then DMA3-clear BG screenblock
 * 31 (2048 bytes) before turning off BG3. The state value `a` the callers
 * pass (always via `adds r0, r5, #0`) is unused by this clear path, but the
 * function still takes it as a u8.
 *
 * The two empty asm barriers reproduce the baserom's register/CSE profile:
 *   - the barrier on `dispcnt` keeps 0x04000000 opaque so the WIN0 clear
 *     consumes that register and the final BG3 clear re-materializes the
 *     DISPCNT base (movs #128; lsls #19) instead of CSE-ing the first load.
 *   - the barrier on `a` references the otherwise-dead parameter so agbcc
 *     keeps its u8 narrow (lsl #24; lsr #24) in r0; without a use the narrow
 *     is eliminated and the whole allocation shifts.
 * Writing the fill value through `*p` (staged: address, then a fresh `zero`)
 * lands `mov r1,sp; movs r0,#0` in baserom order rather than reusing the
 * palette-write zero already sitting in r2. */
void HUD_ClearScreen(u8 a)
{
    vu16 local;
    vu16 *p;
    u32 dispcnt;
    u32 zero;

    dispcnt = (u32)128 << 19;
    asm volatile("" : "+r"(dispcnt));
    *(vu16 *)dispcnt &= ~DISPCNT_WIN0_ON;
    *(vu16 *)0x04000040 = 0;
    *(vu16 *)0x04000044 = 0;
    *(vu16 *)0x05000000 = 0;

    asm volatile("" : : "r"(a));
    p = &local;
    zero = 0;
    *p = zero;

    REG_DMA3.src = (void *)&local;
    REG_DMA3.dst = (void *)0x0600F800;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)REG_DMA3.cnt;

    REG_DISPCNT &= ~DISPCNT_BG3_ON;
}

extern void UiWindow_DrawBordered(u8 col, u8 row, const u8 *str, u8 innerRows, u8 width, u16 palColor, u16 frames);
extern const u16 sFrogSpritePalettes_E3774[5][16];
extern const u8 *const *const sWorldNameTable_30873C[];

/* Tile-space window rectangle; agbcc keeps the 4-byte struct packed in one
 * register (x | y << 8 | w << 16 | h << 24), the same layout Screen_ClearRect
 * takes as its u32 argument. */
struct WinRect {
    u8 x;
    u8 y;
    u8 w;
    u8 h;
};

void sub_0801C6FC(u8 level)
{
    struct WinRect rect;
    const u8 *str;
    u8 x;
    u8 y;
    u8 world;
    u8 lines;
    u8 i;
    u8 col;
    u8 maxCol;

    REG_DISPCNT &= ~DISPCNT_WIN0_ON;
    REG_DISPCNT |= DISPCNT_BG3_ON;
    REG_DMA3.src = sFrogSpritePalettes_E3774;
    REG_DMA3.dst = (void *)0x050001E0;
    REG_DMA3.cnt = DMA_ENABLE | 0x10;
    (void)REG_DMA3.cnt;

    /* Out-of-range ids fall back to world 0; the pre-init also keeps the
     * baserom's `movs r2, #0` ahead of the jump table. */
    world = 0;
    switch (level) {
    case 0:
    case 1:
    case 2:
    case 3:
        x = 1;
        y = 1;
        world = 0;
        break;
    case 4:
    case 5:
    case 6:
        x = 10;
        y = 16;
        world = 1;
        break;
    case 7:
    case 8:
    case 9:
        x = 10;
        y = 16;
        world = 2;
        break;
    case 10:
    case 11:
    case 12:
        x = 10;
        y = 1;
        world = 3;
        break;
    case 13:
    case 14:
    case 15:
        x = 1;
        y = 1;
        world = 4;
        break;
    }

    str = sWorldNameTable_30873C[gIwram_34B0._data][world];

    lines = 1;
    i = 0;
    col = 0;
    maxCol = 0;
    /* The ternary (not `if (maxCol < col)`) yields the baserom's
     * copy-compare-overwrite shape. `[nnn]` is a 5-char glyph-code escape
     * that counts as one column. */
    while (str[i] != '|') {
        col++;
        maxCol = (maxCol >= col) ? maxCol : col;
        if (str[i] == '\n') {
            lines++;
            col = 0;
        } else if (str[i] == '[') {
            i += 4;
        }
        i++;
    }

    rect.x = x;
    rect.y = y;
    rect.h = lines * 2 + 2;
    UiWindow_DrawBordered(x, y, str, lines, maxCol, 0, 6);
    rect.w = maxCol + 2;

    REG_WININ = 0x0808;
    REG_WINOUT = 0x3F3F;
    REG_WINOUT |= 0x3F;
    REG_WINOUT &= 0xFFF7;
    REG_WIN0H = (rect.x << 11) | ((rect.x + rect.w) << 3);
    REG_WIN0V = (rect.y << 11) | ((rect.y + rect.h) << 3);
    REG_DISPCNT |= DISPCNT_WIN0_ON;
}
