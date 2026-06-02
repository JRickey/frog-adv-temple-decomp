#include "iwram.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"

/* Linker-assigned (docs/codegen-notes.md "Adjacent IWRAM bases"): keeping
 * the table opaque to agbcc holds its pool load ahead of the gIwram_3480
 * index read, matching the baserom. */
extern void (*const gHandlerTable_08308058[])(void);

/* Dispatch through a ROM handler table indexed by gIwram_3480._data[3].
 * Class-sibling of sub_08019540 (which indexes by _data[4]); both share
 * the 0x08308058 table and discard the handler's return value (the popped
 * lr lands in r0 before bx). */

void sub_08019560(void)
{
    gHandlerTable_08308058[gIwram_3480._data[3]]();
}

extern void sub_08020B50(void);
extern s32 sub_08010710(void);
extern u32 sub_08000900(void);
extern u8 sub_08010694(u8 arg);

void sub_08019580(void)
{
    u32 now;

    sub_08020B50();
    gIwram_3480._data[5] = 0;
    gIwram_3608._data = 0;

    if (sub_08010710() != 0)
        return;

    now = sub_08000900();
    now -= gIwram_3480._unk0C;
    if (now <= 0x77)
        return;

    gIwram_3480._unk0C = sub_08000900();
    gIwram_3480._data[0]++;
    sub_08010694(0xBF);
}

extern const void *const sUiAssetSlots[];

/* Declared s32 (canonical type is u8) so agbcc compares the return value
 * directly with `cmp r0, #0` instead of zero-extending via `lsls #24`,
 * matching the baserom's branch. */
extern s32 sub_080106B8(void);
extern u16 sub_080106EC(u16 arg);

/* Reload the status-bar BG3 graphics (DMA3 from sUiAssetSlots[3..5] into
 * tile/palette/map VRAM), arm BG3 + 1D-OBJ, and re-init the fade-out
 * (sub_080106EC). Skips the whole reload while the fade-in ticker
 * (sub_080106B8) is still counting down. Sibling of sub_08017ABC, which
 * does the same DMA3 sequence with sUiAssetSlots[0..2]. */
void sub_080195C4(void)
{
    volatile DmaChannel *dma;

    gIwram_3480._data[5] = 0;

    if (sub_080106B8() != 0)
        return;

    REG_BG3CNT = 0x1E08;

    dma = &REG_DMA3;
    dma->src = sUiAssetSlots[3];
    dma->dst = (void *)0x06008000;
    dma->cnt = DMA_ENABLE | 0x890;
    (void)dma->cnt;

    dma->src = sUiAssetSlots[4];
    dma->dst = (void *)0x05000000;
    dma->cnt = DMA_ENABLE | 0x100;
    (void)dma->cnt;

    dma->src = sUiAssetSlots[5];
    dma->dst = (void *)0x0600F000;
    dma->cnt = DMA_ENABLE | 0x400;
    (void)dma->cnt;

    REG_DISPCNT = DISPCNT_OBJ_1D | DISPCNT_BG3_ON;

    sub_080106EC(0xBF);
    gIwram_3480._data[0]++;
}

/* Resets the status-bar dispatch state (clears _data[7] and _data[0])
 * once the fade-in ticker has finished. Same guard idiom as
 * sub_080195C4. */
void sub_0801964C(void)
{
    if (sub_080106B8() != 0)
        return;

    gIwram_3480._data[7] = 0;
    gIwram_3480._data[0] = 0;
}

/* Bumps the status-bar sub-state counter (_data[3]). Companion to
 * sub_08019678, which does the same _data[3]++ but also seeds _data[9]
 * and clears _data[0]. */
void sub_08019668(void)
{
    gIwram_3480._data[3]++;
}
