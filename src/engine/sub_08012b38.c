#include "types.h"
#include "gfx.h"
#include "gba/dma.h"

/* BG tilemap copied into screenblock 28 by the DMA below. */
extern const u16 sScreenTilemap_188EDC[1024];

/* DMA the 2048-byte BG tilemap at sScreenTilemap_188EDC into BG screenblock
 * 28 (0x0600E000). DMA_ENABLE | 0x400 = 1024 halfword transfers = one full
 * 32x32 screenblock. The read-back of cnt forces the store to retire before
 * returning. */
void LoadScreenTilemap_188EDC(void)
{
    REG_DMA3.src = sScreenTilemap_188EDC;
    REG_DMA3.dst = (void *)0x0600E000;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;
}

/* Resets the scene-scroll state block at 0x030060A0: clears the two offset
 * fields (0x0C, 0x2C) and seeds the two step fields (0x10, 0x30) to 8, then
 * clears the BG2-active sentinel byte at 0x03003610 (the same byte
 * AnimTile_ResetAndClearBg clears on teardown). */
void ScrollState_Reset(void)
{
    u8 *state = (u8 *)0x030060A0;

    *(u32 *)(state + 12) = 0;
    *(u32 *)(state + 16) = 8;
    *(u32 *)(state + 44) = 0;
    *(u32 *)(state + 48) = 8;
    *(u8 *)0x03003610 = 0;
}

extern void CharLayers_Upload(u8 arg);
extern void FrogOam_Init(void);
extern void BgScrollBlit(u8 arg);
extern void StatusBar_Update(void);

void Scene_Init2Layer(void)
{
    u8 *state;

    CharLayers_Upload(2);

    state = (u8 *)0x030060A0;
    *(u32 *)(state + 12) = 0;
    *(u32 *)(state + 16) = 8;
    *(u32 *)(state + 44) = 0;
    *(u32 *)(state + 48) = 8;
    *(u8 *)0x03003610 = 0;

    FrogOam_Init();
    Scroll_UpdateCamera(2);
    BgScrollBlit(2);
    StatusBar_Update();
}

extern void ScaleBlit_Tick(void);
extern void FrogStatusBar_Update(void);

void sub_08012BB4(void)
{
    ScaleBlit_Tick();
    FrogStatusBar_Update();
}
