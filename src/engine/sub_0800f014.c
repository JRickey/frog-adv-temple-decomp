#include "gba/dma.h"
#include "gba/intr.h"
#include "gba/io.h"
#include "game.h"
#include "iwram.h"
#include "types.h"

extern void SceneReset(void);
extern u32 Render_DmaLoadTileset(u8 layer);

extern const u16 sScreenPalette_F72C4[256];
extern const u16 sScreenTilemapBg0_F74C4[1024];
extern const u8 sScreenCharTilesBg0_F7CC4[32768];
extern const u16 sScreenTilemapBg1_FFCC4[1024];
extern const u8 sScreenCharTilesBg1_100CC4[16384];
extern const u32 sCharacterSpriteFrames[51 * 4];
extern const u8 sFrogTilePixels_E3AB6[0x4000];

struct SceneScrollState_F014 {
    u8 _pad00[20];
    u16 bgHofs; /* +0x14 */
    u16 bgVofs; /* +0x16 */
    u8 _pad18[52 - 24];
    u16 tileHeight; /* +0x34 */
    u16 tileWidth;  /* +0x36 */
};

void InitScreenBgGraphics(void)
{
    volatile DmaChannel *dma;
    vu16 *regs;
    u16 clear;

    dma = &REG_DMA3;
    dma->src = sScreenPalette_F72C4;
    dma->dst = (void *)0x05000000;
    dma->cnt = DMA_ENABLE | 0x100;
    (void)dma->cnt;

    dma->src = sScreenCharTilesBg0_F7CC4;
    dma->dst = (void *)0x06000000;
    dma->cnt = DMA_ENABLE | 0x4000;
    (void)dma->cnt;

    dma->src = sScreenTilemapBg0_F74C4;
    dma->dst = (void *)0x0600E000;
    dma->cnt = DMA_ENABLE | 0x400;
    (void)dma->cnt;

    *(vu16 *)0x04000008 = 0x1C83;

    dma->src = sScreenCharTilesBg1_100CC4;
    dma->dst = (void *)0x06008000;
    dma->cnt = DMA_ENABLE | 0x2000;
    (void)dma->cnt;

    dma->src = sScreenTilemapBg1_FFCC4;
    dma->dst = (void *)0x0600E800;
    dma->cnt = DMA_ENABLE | 0x400;
    (void)dma->cnt;

    *(vu16 *)0x0400000A = 0x1D8A;
    *(vu16 *)0x0400000C = 0x1E89;
    *(vu16 *)0x04000000 = 0x340;

    regs = (vu16 *)0x03003550;
    clear = 0;
    regs[0] = clear;
    regs[1] = clear;
    regs[2] = clear;
    regs[3] = clear;
    regs[4] = clear;
    regs[5] = clear;

    regs = (vu16 *)0x04000010;
    *regs = clear;
    regs += 2;
    *regs = clear;
    regs += 2;
    *regs = clear;
    regs -= 3;
    *regs = clear;
    regs += 2;
    *regs = clear;
    regs += 2;
    *regs = clear;

    REG_IE = IRQ_VBLANK;
    REG_DISPSTAT = DISPSTAT_VBLANK_IRQ;
}

void InitCharacterBgGraphics(void)
{
    volatile DmaChannel *dma;
    struct IwramAt3550 *r;
    struct SceneScrollState_F014 *ss;
    vu16 *regs;
    u32 enable4000;
    u32 zero;

    dma = &REG_DMA3;
    dma->src = (const void *)sCharacterSpriteFrames[1];
    dma->dst = (void *)0x05000000;
    dma->cnt = DMA_ENABLE | 0x100;
    (void)dma->cnt;

    dma->src = (const void *)sCharacterSpriteFrames[(gGameStuff.sceneType - 1) * 8];
    dma->dst = (void *)0x06000000;
    enable4000 = DMA_ENABLE | 0x4000;
    dma->cnt = enable4000;
    (void)dma->cnt;

    r = (struct IwramAt3550 *)0x03003550;
    ss = (struct SceneScrollState_F014 *)0x030060A0;
    r->_data[1] = ss->bgVofs;
    zero = 0;
    r->_data[0] = ss->bgHofs;

    *(vu16 *)0x04000008 = 0x1C03;

    dma->src = (const void *)sCharacterSpriteFrames[((gGameStuff.sceneType - 1) * 2 + 1) * 4];
    dma->dst = (void *)0x06008000;
    dma->cnt = enable4000;
    (void)dma->cnt;

    r->_data[3] = ss->tileWidth;
    r->_data[2] = ss->tileHeight;

    *(vu16 *)0x0400000A = 0x1D0A;

    dma->src = (const void *)0x080E3754;
    dma->dst = (void *)0x050001A0;
    dma->cnt = DMA_ENABLE | 0x30;
    (void)dma->cnt;

    dma->src = sFrogTilePixels_E3AB6;
    dma->dst = (void *)0x0600C000;
    dma->cnt = DMA_ENABLE | 0x1000;
    (void)dma->cnt;

    REG_IE = IRQ_VBLANK | IRQ_HBLANK;
    REG_DISPSTAT = DISPSTAT_VBLANK_IRQ | DISPSTAT_HBLANK_IRQ;
    REG_BG3CNT = 0x1F0C;

    regs = (vu16 *)0x04000000;
    *regs = (u16)zero;
    *regs = 0xB40;

    SceneReset();
}

void InitAllBgTilemapLayers(void)
{
    Render_DmaLoadTileset(0);
    Render_DmaLoadTileset(1);
    Render_DmaLoadTileset(2);
    Render_DmaLoadTileset(3);
}
