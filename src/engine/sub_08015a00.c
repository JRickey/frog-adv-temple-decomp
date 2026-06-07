#include "macros.h"
#include "gfx.h"
#include "sound.h"
#include "types.h"
#include "iwram.h"
#include "gba/dma.h"

extern void SetModeBlendRegs(void);
extern void GateRoom_Tick(void);
extern void FrogStatusBar_Update(void);
extern void Gate_TryUnlock(void);
extern void Scroll_FlushTilemapWindow(u32, void *, void *);
extern void CharLayers_Upload(u8 arg);
extern void FrogOam_Init(void);
extern void Scenery_InitScrollState(void);
extern void BgScrollBlit(u8 arg);
extern void StatusBar_Update(void);

#define sTilemapTable_307CE8 (*(const struct TilemapTableEntry *)0x08307ce8)

extern const u16 sBgTilemapVariantA_19C312[];
extern const u16 sBgTilemapVariantB_19CFDE[];

void BgTilemap_LoadScene(void)
{
    const struct TilemapTableEntry *desc = &sTilemapTable_307CE8;

    sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, desc->tiles, 1);
}

void Scene_Update(void)
{
    SetModeBlendRegs();
    if (gIwram_6110.spawnMask == 0)
        GateRoom_Tick();
    FrogStatusBar_Update();
    Gate_TryUnlock();
}

void BgTilemap_DmaVariantA(void)
{
    REG_DMA3.src = sBgTilemapVariantA_19C312;
    REG_DMA3.dst = (void *)(0x80 << 18);
    REG_DMA3.cnt = DMA_ENABLE | 0x8000;
    (void)REG_DMA3.cnt;
    Scroll_FlushTilemapWindow(0, (void *)(0x80 << 18), (void *)0x0600e000);
}

void BgTilemap_DmaVariantB(void)
{
    REG_DMA3.src = sBgTilemapVariantB_19CFDE;
    REG_DMA3.dst = (void *)(0x80 << 18);
    REG_DMA3.cnt = DMA_ENABLE | 0x8000;
    (void)REG_DMA3.cnt;
    Scroll_FlushTilemapWindow(0, (void *)(0x80 << 18), (void *)0x0600e000);
}

void Scene_Init(void)
{
    CharLayers_Upload(2);
    FrogOam_Init();
    Scenery_InitScrollState();
    Scroll_UpdateCamera(2);
    BgScrollBlit(2);
    StatusBar_Update();
}

extern void Scenery_UpdateSelectorCells(void);
extern void Scenery_BlitAndCyclePalette(void);

void Scene_UpdateFrame(void)
{
    u8 *base;

    FrogStatusBar_Update();
    Scenery_UpdateSelectorCells();

    base = (u8 *)0x03003610;
    switch (base[7]) {
    case 0:
        if ((gIwram_6110.selector5Flags & 0xf0) != (gIwram_6110.selector6Flags & 0xf0)) {
            Sound_Play(25);
            base[7] = 1;
        }
        break;
    case 1:
        Scenery_BlitAndCyclePalette();
        break;
    }
}

void FlushFramebufferBank(u8 arg)
{
    void *src;
    void *dst;

    switch (arg) {
    case 0:
        src = (void *)(0x80 << 18);
        dst = (void *)0x0600e000;
        break;
    case 1:
        src = (void *)0x02010000;
        dst = (void *)0x0600e800;
        break;
    case 2:
        src = (void *)0x02020000;
        dst = (void *)0x0600f000;
        break;
    }
    Scroll_FlushTilemapWindow(arg, src, dst);
}
