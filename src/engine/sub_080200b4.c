#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

extern void TileBlit(u32 *attr, const void *src, u8 mode);

/* Builds a 4-byte tilemap descriptor on the stack, refines its tile column by
 * gIwram_3480._unk14, kicks a DMA3 screenblock load, then blits the descriptor
 * via TileBlit. Sibling of SaveSlot_DrawSelectionCursor (same attr-build idiom). */
void WinPoseScreen_DrawBg(void)
{
    u32 attr;

    attr = (attr & 0xffffff00) | 0x08;
    attr = (attr & 0xffff00ff) | 0x0300;
    attr = (attr & 0x00ffffff) | 0x03000000;
    attr = (attr & 0xff00ffff) | 0x000e0000;

    switch (gIwram_3480._unk14) {
    case 0:
        attr = (attr & 0xffff00ff) | 0x0300;
        break;
    case 1:
        attr = (attr & 0xffff00ff) | 0x0600;
        break;
    case 2:
        attr = (attr & 0xffff00ff) | 0x0900;
        break;
    case 3:
        attr = (attr & 0xffff00ff) | 0x0c00;
        break;
    case 4:
        attr = (attr & 0xffff00ff) | 0x0f00;
        break;
    }

    REG_DMA3.src = (void *)0x081e4c18;
    REG_DMA3.dst = (void *)0x0600f000;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;

    TileBlit(&attr, (const void *)0x081e5418, 2);
}
