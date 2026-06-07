#include "types.h"
#include "sound.h"
#include "gba/dma.h"
#include "gba/io.h"

struct DmaJob_152B0 {
    u32 word0;
    u32 word4;
    u32 word8;
    u32 wordC;
};

extern const struct DmaJob_152B0 gDmaJobTable_08307DA8[];
extern const void *const gPaletteSrcTable_08307E78[];

extern const u8 sScreenCharTiles_1A3B6A[];
extern const u8 sScreenTilemap_1A5B6A[];
extern const u8 sScreenCharTiles_1B23CA[];
extern const u8 sScreenTilemap_1B43CA[];

extern u8 gIwram_6400[];
extern u8 gIwram_6410[];
extern u8 gIwram_6580[];

extern void BgLayer_Disable(u8 layer);
extern void BgLayer_Enable(u8 layer);
extern void AnimChannels_Reset(void);
extern void DmaJob_Advance(struct DmaJob_152B0 job, u8 mode, void *buf);

void Screen_LoadForMode(void)
{
    u8 mode;

    mode = *(u8 *)0x03003610;

    switch (mode) {
    case 0:
        BgLayer_Disable(2);
        break;

    case 1:
        REG_DMA3.src = sScreenTilemap_1A5B6A;
        REG_DMA3.dst = (void *)0x0600F000;
        REG_DMA3.cnt = DMA_ENABLE | 0x400;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = sScreenCharTiles_1A3B6A;
        REG_DMA3.dst = (void *)0x0600C000;
        REG_DMA3.cnt = DMA_ENABLE | 0x1000;
        (void)REG_DMA3.cnt;

        REG_BG2CNT = 0x1E0D;

        gIwram_6410[12] = 0;
        gIwram_6410[0] = 3;
        gIwram_6400[12] = 1;
        gIwram_6400[0] = 2;

        *(vu16 *)0x04000050 = 0x1744;
        *(vu16 *)0x04000052 = 0x0C04;
        BgLayer_Enable(2);
        break;

    case 2:
        REG_DMA3.src = sScreenTilemap_1B43CA;
        REG_DMA3.dst = (void *)0x0600F000;
        REG_DMA3.cnt = DMA_ENABLE | 0x400;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = sScreenCharTiles_1B23CA;
        REG_DMA3.dst = (void *)0x0600C000;
        REG_DMA3.cnt = DMA_ENABLE | 0x1000;
        (void)REG_DMA3.cnt;

        *(vu16 *)0x04000050 = 0x1744;
        *(vu16 *)0x04000052 = 0x0C04;
        gIwram_6580[10] = 0;
        BgLayer_Enable(2);
        break;

    case 3:
        AnimChannels_Reset();
        BgLayer_Disable(2);
        Sound_Play(28);
        break;

    case 4:
        REG_DMA3.src = (const void *)0x0813CE20;
        REG_DMA3.dst = (void *)0x0600F000;
        REG_DMA3.cnt = DMA_ENABLE | 0x400;
        (void)REG_DMA3.cnt;

        gIwram_6410[12] = 8;
        gIwram_6410[0] = 4;
        gIwram_6400[12] = 16;
        gIwram_6400[0] = 2;

        *(vu16 *)0x04000050 = 0x1744;
        *(vu16 *)0x04000052 = 0x0C04;
        BgLayer_Enable(2);
        break;
    }

    Sound_Play(0x6C);

    {
        /* Anchor the table-base load into r0 before reading the state byte
         * (baserom `ldr r0, table; ldr r4, &state; ldrb r1, [r4]`), and keep
         * the state pointer r4 live so the trailing palette DMA re-reads it. */
        const struct DmaJob_152B0 *table = gDmaJobTable_08307DA8;
        u8 *state = (u8 *)0x03003610;
        const struct DmaJob_152B0 *job = (const struct DmaJob_152B0 *)((*state << 4) + (u32)table);

        DmaJob_Advance(*job, 0, (void *)0x030064C0);

        REG_DMA3.src = gPaletteSrcTable_08307E78[*state];
        REG_DMA3.dst = (void *)0x05000100;
        REG_DMA3.cnt = DMA_ENABLE | 0x10;
        (void)REG_DMA3.cnt;
    }
}
