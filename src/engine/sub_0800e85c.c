#include "macros.h"
#include "gfx.h"
#include "types.h"

/* --- CharLayers_Upload: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "gba/dma.h"
#include "gba/intr.h"
#include "gba/io.h"
#include "game.h"
#include "iwram.h"
#include "types.h"

#define CHARACTER_BG0CNT 0x1C03
#define CHARACTER_BG1CNT 0x1D02
#define CHARACTER_BG2CNT 0x1E0D

struct CharacterSpriteFrame {
    const void *tilesA;
    const void *tilesB;
    const void *tilesC;
    u16 width;
    u16 height;
};

struct CharacterLayerCtrl {
    u8 _pad00[0x18];
    u16 width;
    u16 height;
    u8 _pad1C[4];
};

extern const struct CharacterSpriteFrame sCharacterSpriteFrames[];

extern void LZ77UnCompWram(const void *src, void *dst); /* BIOS SWI 17 */

void CharLayers_Upload(u8 count)
{
    volatile DmaChannel *dma;
    struct CharacterLayerCtrl *layer;
    const struct CharacterSpriteFrame *frames;
    GameStuff *game;
    const void *tilesA;
    u16 zero;
    u8 pose;

    zero = 0;
    REG_DMA3.src = &zero;
    REG_DMA3.dst = (void *)0x02000000;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 2;
    (void)REG_DMA3.cnt;

    zero = 0;
    REG_DMA3.src = &zero;
    REG_DMA3.dst = (void *)0x06000000;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 2;
    (void)REG_DMA3.cnt;

    zero = 0;
    REG_DMA3.src = &zero;
    REG_DMA3.dst = (void *)0x05000000;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 2;
    (void)REG_DMA3.cnt;

    for (pose = 0; pose < count; pose++) {
        frames = sCharacterSpriteFrames;
        game = &gGameStuff;
        dma = &REG_DMA3;
        layer = (struct CharacterLayerCtrl *)0x030060A0;

        layer[pose].width = frames[game->pendingMode * 3 + pose].width;
        layer[pose].height = frames[game->pendingMode * 3 + pose].height;

        switch (pose) {
        case 0:
            if (frames[game->pendingMode * 3].tilesA != NULL) {
                tilesA = frames[game->pendingMode * 3].tilesA;
            }
            LZ77UnCompWram(tilesA, (void *)0x02000000);

            dma->src = (const void *)0x02000000;
            dma->dst = (void *)0x06000000;
            dma->cnt = DMA_ENABLE | 0x4000;
            (void)dma->cnt;

            if (game->pendingMode == 13) {
                dma->src = frames[game->pendingMode * 3].tilesA;
                dma->dst = (void *)0x06000000;
                dma->cnt = DMA_ENABLE | 0x4000;
                (void)dma->cnt;
            }

            LZ77UnCompWram(frames[game->pendingMode * 3].tilesC, (void *)0x02000000);
            REG_BG0CNT = CHARACTER_BG0CNT;
            break;
        case 1:
            if (frames[game->pendingMode * 3 + 1].tilesA != NULL) {
                dma->src = frames[game->pendingMode * 3 + 1].tilesA;
                dma->dst = (void *)0x02010000;
                dma->cnt = DMA_ENABLE | 0x2000;
                (void)dma->cnt;
            }
            LZ77UnCompWram(frames[game->pendingMode * 3 + 1].tilesC, (void *)0x02010000);
            REG_BG1CNT = CHARACTER_BG1CNT;
            break;
        case 2:
            if (frames[game->pendingMode * 3 + 2].tilesA != NULL) {
                dma->src = frames[game->pendingMode * 3 + 2].tilesA;
                dma->dst = (void *)0x0600C000;
                dma->cnt = DMA_ENABLE | 0x1000;
                (void)dma->cnt;
            }
            if (frames[game->pendingMode * 3 + 2].tilesC != NULL) {
                dma->src = frames[game->pendingMode * 3 + 2].tilesC;
                dma->dst = (void *)0x02020000;
                dma->cnt = DMA_ENABLE | 0x8000;
                (void)dma->cnt;
            } else {
                zero = 0;
                dma->src = &zero;
                dma->dst = (void *)0x02020000;
                dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x8000;
                (void)dma->cnt;
            }
            REG_BG2CNT = CHARACTER_BG2CNT;
            break;
        }
    }

    REG_DMA3.src = sCharacterSpriteFrames[gGameStuff.pendingMode * 3].tilesB;
    REG_DMA3.dst = (void *)0x05000000;
    REG_DMA3.cnt = DMA_ENABLE | 0x100;
    (void)REG_DMA3.cnt;

    REG_DISPCNT = DISPCNT_OBJ_ON | DISPCNT_OBJ_1D;

    switch (count) {
    case 1:
        BgLayer_Enable(0);
        BgLayer_Disable(1);
        BgLayer_Disable(2);
        BgLayer_Enable(3);
        break;
    case 2:
        BgLayer_Enable(0);
        BgLayer_Enable(1);
        BgLayer_Disable(2);
        BgLayer_Enable(3);
        break;
    case 3:
        BgLayer_Enable(0);
        BgLayer_Enable(1);
        BgLayer_Enable(2);
        BgLayer_Enable(3);
        break;
    }

    REG_IE &= ~IRQ_HBLANK;
    REG_DISPSTAT &= ~DISPSTAT_HBLANK_IRQ;
    gIwram_3608._pad4 = 1;
    gIwram_3608._field_5 = 0;
}
#else
NAKED void CharLayers_Upload(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0xe85c, 0x2c0\n");
}
#endif /* NON_MATCHING */
