#include "macros.h"
#include "gfx.h"
#include "sound.h"
#include "iwram.h"
#include "types.h"
#include "game.h"
#include "gba/dma.h"

struct Rom306F6C {
    u8 _pad0[2];
    u8 byte2; /* +0x02 */
};

extern struct ScrollBlitLayer gIwram_6480;
extern struct ScrollBlitLayer gIwram_6500;
extern struct ScrollBlitLayer gIwram_6540;
extern struct BgScrollState gIwram_60A0[3];

extern void CharLayers_Upload(u8 arg);
extern void FrogOam_Init(void);
extern void ScaleAnim_SyncSelectors(void);
extern void BgScrollBlit(u8 arg);
extern void StatusBar_Update(void);
extern void BgScrollAnim_InitPartial(void);
extern u8 gIwram_3610;

void BgLayer_Init(void)
{
    vu16 *scroll;
    vu32 *dma;
    u8 *flags;

    Sound_Play(0x33);

    gIwram_60A0[0].scrollX = 24;
    gIwram_60A0[0].scrollY = 40;
    gIwram_60A0[1].scrollX = 24;
    gIwram_60A0[1].scrollY = 40;

    scroll = (vu16 *)0x04000010;
    scroll[0] = 24;
    scroll += 1;
    scroll[0] = 40;
    scroll += 1;
    scroll[0] = 24;
    scroll += 1;
    scroll[0] = 40;

    gIwram_6540._field_34 = 0;
    gIwram_6480._field_36 = 0;
    gIwram_6540.frameCtr = 0;
    gIwram_6480.frameCtr = 18;
    gIwram_6540.phase = 0;
    gIwram_6480.phase = 1;
    gIwram_6500.frameCtr = ((struct Rom306F6C *)0x08306F6C)->byte2;
    gIwram_60A0[1].tileRows = 66;

    dma = (vu32 *)0x040000D4;
    dma[0] = 0x0813DF68;
    dma[1] = 0x02000000;
    dma[2] = DMA_ENABLE | 0x8000;
    (void)dma[2];

    dma[0] = 0x08142E84;
    dma[1] = 0x02010000;
    dma[2] = DMA_ENABLE | 0x8000;
    (void)dma[2];

    flags = (u8 *)0x03003610;
    flags[0] = 0;
    flags[0xDC] = 0;
    flags[0xD4] = 0;
}

void ScaleAnim_Reset(void)
{
    u32 zero;
    u8 *flags;
    u8 *control;

    CharLayers_Upload(3);
    FrogOam_Init();
    Scroll_UpdateCamera(2);

    flags = &gIwram_3610;
    zero = 0;
    flags[0] = zero;
    flags[0xdc] = zero;
    flags[0xd4] = zero;

    control = (u8 *)&gIwram_6110;
    *(u16 *)(control + 0x28) = zero;
    control[0x2b] &= 0xf;

    ScaleAnim_SyncSelectors();
    ScaleAnim_SyncSelectors();
    BgScrollBlit(3);
    StatusBar_Update();
    BgScrollAnim_InitPartial();
    BgLayer_Disable(2);
}
