#include "types.h"
#include "gfx.h"

extern void CharLayers_Upload(u8 arg);
extern void EntitySlots_Init(const void *src, u8 arg);
extern void FrogOam_Init(void);
extern void BgScrollBlit(u8 arg);
extern void StatusBar_Update(void);

void SceneReset(void)
{
    CharLayers_Upload(2);
    EntitySlots_Init((const void *)0x08306944, 5);
    FrogOam_Init();
    Scroll_UpdateCamera(2);
    BgScrollBlit(2);
    StatusBar_Update();
    *(vu32 *)0x03006420 = 0;
}
