#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/intr.h"
#include "gba/io.h"

typedef struct {
    u8 unk0[4];
    u8 unk4;
    u8 unk5;
    u8 unk6;
    u8 unk7;
} Src08016360;

typedef struct {
    u16 unk0;
    u16 unk2;
    u8 unk4;
    u8 unk5;
    u8 unk6[6];
    u8 unk12;
    u8 unk13[3];
} Dst08016360;

void EntitySlots_Init(Src08016360 *src, u8 count)
{
    u8 *flags;
    vu16 fill;
    u8 i;
    int zero;

    fill = 0;
    REG_DMA3.src = (void *)&fill;
    REG_DMA3.dst = (void *)0x030053A0;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x80;
    (void)REG_DMA3.cnt;

    fill = 0;
    REG_DMA3.src = (void *)&fill;
    REG_DMA3.dst = (void *)0x03003610;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x80;
    (void)REG_DMA3.cnt;

    /* `i = 0` is split out of the for-init so agbcc emits the counter clear
     * before the loop-invariant `flags` base load (baserom preheader order). */
    i = 0;
    flags = (u8 *)0x03003608;

    for (; i < count; i++) {
        Dst08016360 *dst = (Dst08016360 *)0x03006360;
        dst[i].unk4 = src[i].unk4;
        dst[i].unk5 = src[i].unk5;
        dst[i].unk12 = src[i].unk6;
        dst[i].unk0 = 0;
        dst[i].unk2 = 0;
    }

    /* `zero` pre-materializes the 0 into its own register so both flag
     * stores emit back-to-back without reloading the constant. */
    zero = 0;
    flags[4] = 1;
    flags[5] = zero;

    REG_IE |= IRQ_VBLANK | IRQ_HBLANK;
    REG_DISPSTAT |= DISPSTAT_VBLANK_IRQ | DISPSTAT_HBLANK_IRQ;
}
