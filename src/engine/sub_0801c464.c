#include "gba/dma.h"
#include "gba/io.h"
#include "macros.h"
#include "types.h"

#define BG_SCREENBLOCK_31              ((volatile struct BgScreenblock *)0x0600f800)
#define BG_SCREENBLOCK_ROW_OFFSET(row) OFFSET_OF(struct BgScreenblock, entry[row][0])
#define BG_SCREENBLOCK_COL_OFFSET(col) OFFSET_OF(struct BgScreenblock, entry[0][col])

struct BgScreenblock {
    vu16 entry[32][32];
};

void sub_0801C464(void)
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

extern void sub_0801BE7C(const u8 *str, int len, int x, int y, int a, int b, int c);

/* UI string addresses (raw casts, matching the sibling style in
 * sub_0801C2B4 / sub_0801C0xx). Both live in sWinLoseLabels at 0x081be008. */
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
 * div/mod-10 helpers. a/b/c are byte values.
 *
 * rowBase (= row 17's byte offset, 17*64) is anchored in a register by the
 * asm barrier so each stamp store keeps its full screenblock address as an
 * independent pool literal instead of being CSE-folded into +2 increments. */
void sub_0801C4F8(u8 a, u8 b, u8 c)
{
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

    sub_0801BE7C(UI_DIGIT_GLYPH, 4, 7, 17, 278, 14, 3);

    tens = (u8)(b / 10u);
    units = (u8)(b % 10u);
    buf[0] = tens + 0x30;
    buf[1] = units + 0x30;
    sub_0801BE7C(buf, 2, 9, 17, 278, 14, 3);

    *(vu16 *)(rowBase + 0x0600f830U) = UI_STAMP_TL;
    *(vu16 *)(rowBase + 0x0600f832U) = UI_STAMP_TR;
    *(vu16 *)(rowBase + 0x0600f870U) = UI_STAMP_BL;
    *(vu16 *)(rowBase + 0x0600f872U) = UI_STAMP_BR;

    sub_0801BE7C(UI_DIGIT_GLYPH, 4, 26, 17, 278, 14, 3);

    tens = (u8)(a / 10u);
    units = (u8)(a % 10u);
    buf[0] = tens + 0x30;
    buf[1] = units + 0x30;
    sub_0801BE7C(buf, 2, 28, 17, 278, 14, 3);

    sub_0801BE7C(UI_TIME_LABEL, 4, 12, 1, 278, 14, 3);

    tens = (u8)(c / 10u);
    units = (u8)(c % 10u);
    buf[0] = tens + 0x30;
    buf[1] = units + 0x30;
    sub_0801BE7C(buf, 2, 17, 1, 278, 14, 3);
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
void sub_0801C69C(u8 a)
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
