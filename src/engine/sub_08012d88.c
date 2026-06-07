#include "macros.h"
#include "gfx.h"
#include "types.h"

struct TransferDesc {
    u32 word0;
    u32 word4;
    u32 word8;
    u32 wordC;
};

extern u8 gIwram_60A0[];
extern u8 gIwram_6410[];
extern u8 gIwram_6400[];
extern u8 gIwram_6480[];

extern void BgLayer_Enable(u8 layer);
extern void DmaJob_Advance(struct TransferDesc desc, u8 mode, void *buf);
extern void BgScrollAnim_Update(void);
extern void sub_08010A44(u8 a, u8 b);
extern void FrogStatusBar_Update(void);

void sub_08012D88(void)
{
    if (gIwram_60A0[0x40] & 1) {
        *(vu16 *)0x04000050 = 0x1744;
        *(vu16 *)0x04000052 = 0x0e02;
        BgLayer_Enable(2);
        gIwram_60A0[0x40] &= 0xfe;
    }

    {
        struct TransferDesc *desc = (struct TransferDesc *)0x08306f08;
        DmaJob_Advance(*desc, ((u8 *)desc)[2], (void *)0x030064c0);
    }

    BgScrollAnim_Update();
    sub_08010A44(4, 4);
    FrogStatusBar_Update();
}

extern void CharLayers_Upload(u8 arg);
extern void BgLayer_Disable(u8 layer);
extern void FrogOam_Init(void);
extern void BgScrollAnim_Init(void);
extern void BgScrollBlit(u8 arg);
extern void StatusBar_Update(void);

void Scene_InitFull(void)
{
    CharLayers_Upload(3);
    BgLayer_Disable(2);
    FrogOam_Init();
    BgScrollAnim_Init();
    Scroll_UpdateCamera(3);
    BgScrollBlit(3);
    StatusBar_Update();
}

void BgScrollAnim_InitPartial(void)
{
    u8 zero;
    u8 val;
    u8 old;
    u8 *ptr1;
    register u8 *ptr0 asm("r0");

    ptr1 = gIwram_6410;
    zero = 0;
    asm("" : "+r"(zero));
    ptr1[12] = 8;
    ptr1[0] = 4;
    gIwram_6400[12] = 16;
    gIwram_6400[0] = 2;
    ptr0 = gIwram_60A0;
    ptr0 += 0x40;
    val = 1;
    old = *ptr0;
    val |= old;
    *ptr0 = val;
    ptr0 = gIwram_6480;
    ptr0[10] = zero;
}
