#include "types.h"
#include "gfx.h"

extern void CharLayers_Upload(u8 arg);
extern void FrogOam_Init(void);
extern void Scroll_ResetDirStep(void);
extern void ModeChannel_Apply(u8 arg0, u8 arg1);
extern void BgScrollBlit(u8 arg);
extern void StatusBar_Update(void);

struct Unk6500 {
    u8 _pad[10];
    u8 field_a;
};

void InitScene2LayerC(void)
{
    CharLayers_Upload(2);
    FrogOam_Init();
    ((struct Unk6500 *)0x03006500)->field_a = 0;
    Scroll_ResetDirStep();
    ModeChannel_Apply(6, 2);
    Scroll_UpdateCamera(2);
    BgScrollBlit(2);
    StatusBar_Update();
}

void ClearQueueSeed(void)
{
    ((struct Unk6500 *)0x03006500)->field_a = 0;
}
