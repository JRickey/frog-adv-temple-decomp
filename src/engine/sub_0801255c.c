#include "gfx.h"
extern void CharLayers_Upload(unsigned int arg);
extern void BgLayer_Disable(unsigned int arg);
extern void BgLayer_Enable(unsigned int arg);
extern void FrogOam_Init(void);
extern void Selector_ResetState(void);
extern void BgScrollBlit(unsigned int arg);
extern void StatusBar_Update(void);

void InitScrollScene(void)
{
    CharLayers_Upload(3);
    BgLayer_Disable(2);
    FrogOam_Init();
    Selector_ResetState();
    Scroll_UpdateCamera(3);
    BgScrollBlit(3);
    StatusBar_Update();
}

void SetupBlendRegs(void)
{
    BgLayer_Enable(2);
    *(volatile unsigned short *)0x04000050 = 0x1744;
    *(volatile unsigned short *)0x04000052 = 0x020e;
}
