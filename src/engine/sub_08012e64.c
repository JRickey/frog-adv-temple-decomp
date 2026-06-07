#include "macros.h"
#include "gfx.h"
#include "types.h"

extern u8 gIwram_60A0[];

extern void BgScrollAnim_Update(void);
extern void DmaJob_Advance(struct TransferDesc desc, u8 mode, void *buf);
extern void FrogStatusBar_Update(void);

void Scene_UpdateWithBlend(void)
{
    u8 val = gIwram_60A0[0x40];

    if (val & 1) {
        *(vu16 *)0x04000050 = 0x1744;
        *(vu16 *)0x04000052 = 0x0e02;
        /* agbcc: `ands r0, r2` (0xfe in r0, val in r2 from earlier load); pin r0 to
         * keep the result in r0 so strb r0 matches. */
        {
            register u8 cleared asm("r0");
            cleared = (u8)(0xfe & val);
            gIwram_60A0[0x40] = cleared;
        }
        BgLayer_Enable(2);
    }

    BgScrollAnim_Update();

    {
        struct TransferDesc *desc = (struct TransferDesc *)0x08306f08;
        DmaJob_Advance(*desc, ((u8 *)desc)[2], (void *)0x030064c0);
    }

    FrogStatusBar_Update();
}

extern void CharLayers_Upload(u8 arg);
extern void FrogOam_Init(void);
extern void BgScrollAnim_InitPartial(void);
extern void BgScrollBlit(u8 arg);
extern void StatusBar_Update(void);

void Scene_InitLayers(void)
{
    CharLayers_Upload(3);
    BgLayer_Disable(2);
    FrogOam_Init();
    BgScrollAnim_InitPartial();
    Scroll_UpdateCamera(3);
    BgScrollBlit(3);
    StatusBar_Update();
}
