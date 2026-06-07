#include "gfx.h"
#include "gba/io.h"
#include "types.h"

extern void Scroll_FlushTilemapWindow(u32, void *, void *);

void Display_RestoreState(void)
{
    REG_DISPCNT = gUnk03006420.dispcnt;

    *(struct ScrollData *)0x03003550 = gUnk03006420.scroll;

    Scroll_FlushTilemapWindow(0, (void *)(0x80 << 18), (void *)0x0600e000);
    Scroll_FlushTilemapWindow(1, (void *)0x02010000, (void *)0x0600e800);
    Scroll_FlushTilemapWindow(2, (void *)0x02020000, (void *)0x0600f000);
    Scroll_FlushTilemapWindow(3, (void *)0x02030000, (void *)0x0600f800);

    gUnk03006420.active = 0;
}

void Display_EnableBg(s32 bg)
{
    switch (bg) {
    case 0:
        REG_DISPCNT = DISPCNT_BG0_ON;
        break;
    case 1:
        REG_DISPCNT = DISPCNT_BG1_ON;
        break;
    case 2:
        REG_DISPCNT = DISPCNT_BG2_ON;
        break;
    case 3:
        REG_DISPCNT = DISPCNT_BG3_ON;
        break;
    }
}
