#include "gba/dma.h"
#include "gba/io.h"
#include "macros.h"
#include "types.h"

/* --- sub_0801CD0C: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "macros.h"
#include "types.h"

#define BG31           0x0600F800
#define BG31_ROW2      0x0600F840
#define BG31_COL2      0x0600F802
#define BG31_ROW2_COL2 0x0600F842

#define WINDOW_TL      0
#define WINDOW_L       1
#define WINDOW_BL      2
#define WINDOW_T       3
#define WINDOW_C       4
#define WINDOW_B       5
#define WINDOW_TR      6
#define WINDOW_R       7
#define WINDOW_BR      8

extern const u16 sUiWindowBorderTiles[9];

extern void WaitVblank(void);
extern void DrawTilemapString(const u8 *str, u8 count, u8 colBase, u8 rowBase, u16 tileBase, s32 palBank, u8 screen);

/* new_var/new_var2/new_var3 are agbcc register-coloring anchors (permuter-found):
 * new_var pins cellOff into a C-fill scratch reg; new_var3 stages j*2 for the
 * B-edge; new_var2 caches i so j+1 (carried in ip) does not cross the VBlank bl
 * (keeps the frame at 0x2c). j++ MUST sit before the VBlank loop for the same
 * reason. Do not rename/inline without re-checking the byte match. */
void sub_0801CD0C(u8 col, u8 row, const u8 *str, u8 innerRows, u8 width, u16 palColor, u16 frames)
{
    u32 rows2;
    u8 i;
    s32 new_var;
    u8 new_var2;
    s32 new_var3;
    u8 j;

    *(u16 *)0x05000000 = palColor;

    rows2 = ((u32)innerRows << 25) >> 24;

    *(u16 *)(BG31 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_TL];

    for (i = 0; i < rows2; i++)
        *(u16 *)(BG31_ROW2 + i * 64 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_L];

    *(u16 *)(BG31_ROW2 + rows2 * 64 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_BL];

    j = 1;
    while (j <= width) {
        *(u16 *)(BG31 + j * 2 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_T];

        for (i = 0; i < rows2; i++) {
            new_var = col * 2 + row * 64;
            *(u16 *)(BG31_ROW2 + i * 64 + j * 2 + new_var) = sUiWindowBorderTiles[WINDOW_C];
        }

        new_var3 = j * 2;
        *(u16 *)(BG31_ROW2 + rows2 * 64 + (col * 2 + row * 64) + new_var3) = sUiWindowBorderTiles[WINDOW_B];
        j++;

        for (new_var2 = i; new_var2 > frames; i++)
            WaitVblank();
    }

    *(u16 *)(BG31_COL2 + width * 2 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_TR];

    for (i = 0; i < rows2; i++)
        *(u16 *)(BG31_ROW2_COL2 + i * 64 + width * 2 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_R];

    *(u16 *)(BG31_ROW2_COL2 + rows2 * 64 + (col * 2 + row * 64) + width * 2) = sUiWindowBorderTiles[WINDOW_BR];

    i = 0;
    while (str[i] != '|')
        i++;

    DrawTilemapString(str, i, (u8)(col + 1), (u8)(row + 1), 0xa0, 14, 3);
}
#else
NAKED void sub_0801CD0C(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x1cd0c, 0x1b4\n");
}
#endif /* NON_MATCHING */
