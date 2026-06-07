#include "gba/intr.h"
#include "gfx.h"
#include "gba/io.h"
#include "types.h"

extern void CharLayers_Upload(u8 arg);
extern void FrogOam_Init(void);
extern void Scroll_ResetDirStep(void);
extern void ModeChannel_Apply(u8 arg0, u8 arg1);
extern void BgScrollBlit(u8 arg);
extern void StatusBar_Update(void);

/* Tears down the HBlank-driven display effect: drops BG2 from REG_DISPCNT
 * and disables the HBlank IRQ at both the enable (REG_IE) and trigger
 * (REG_DISPSTAT) ends. */
void Scene_DisableBg2(void)
{
    REG_DISPCNT &= ~DISPCNT_BG2_ON;
    REG_IE &= ~IRQ_HBLANK;
    REG_DISPSTAT &= ~DISPSTAT_HBLANK_IRQ;
}

void SceneInit_WithHud(void)
{
    CharLayers_Upload(2);
    FrogOam_Init();
    Scroll_ResetDirStep();
    ModeChannel_Apply(5, 3);
    Scroll_UpdateCamera(2);
    BgScrollBlit(2);
    StatusBar_Update();
}

void SceneInit(void)
{
    CharLayers_Upload(2);
    FrogOam_Init();
    Scroll_UpdateCamera(2);
    BgScrollBlit(2);
    StatusBar_Update();
}
