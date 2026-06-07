#include "macros.h"
#include "gfx.h"
#include "sound.h"
#include "types.h"
#include "game.h"
#include "gba/dma.h"

struct IwramAt6480 {
    u8 _pad00[9];
    u8 field_9; /* +0x09 */
    u8 _pad0A;
    u8 field_b; /* +0x0b: frame counter */
    u8 _pad0C[42];
    s16 field_36; /* +0x36: signed coord */
};

struct IwramAt6500 {
    u8 _pad00[11];
    u8 field_b; /* +0x0b: frame counter */
};

struct IwramAt6540 {
    u8 _pad00[9];
    u8 field_9; /* +0x09 */
    u8 _pad0A;
    u8 field_b; /* +0x0b */
    u8 _pad0C[40];
    s16 field_34; /* +0x34: signed coord */
};

struct IwramAt60A0 {
    u8 _pad00[12];
    u32 field_c;  /* +0x0c */
    u32 field_10; /* +0x10 */
    u8 _pad14[24];
    u32 field_2c; /* +0x2c */
    u32 field_30; /* +0x30 */
    u8 _pad34[4];
    s16 field_38; /* +0x38 */
};

struct Rom306F6C {
    u8 _pad0[2];
    u8 byte2; /* +0x02 */
};

extern struct IwramAt6480 gIwram_6480;
extern struct IwramAt6500 gIwram_6500;
extern struct IwramAt6540 gIwram_6540;
extern struct IwramAt60A0 gIwram_60A0;

extern void CharLayers_Upload(u8 arg);
extern void FrogOam_Init(void);
extern void ScaleAnim_SyncSelectors(void);
extern void BgScrollBlit(u8 arg);
extern void StatusBar_Update(void);
extern void BgScrollAnim_InitPartial(void);
extern void BgLayer_Disable(u8 layer);
extern u8 gIwram_3610;
extern u8 gIwram_6110;

void BgLayer_Init(void)
{
    vu16 *scroll;
    vu32 *dma;
    u8 *flags;

    Sound_Play(0x33);

    gIwram_60A0.field_c = 24;
    gIwram_60A0.field_10 = 40;
    gIwram_60A0.field_2c = 24;
    gIwram_60A0.field_30 = 40;

    scroll = (vu16 *)0x04000010;
    scroll[0] = 24;
    scroll += 1;
    scroll[0] = 40;
    scroll += 1;
    scroll[0] = 24;
    scroll += 1;
    scroll[0] = 40;

    gIwram_6540.field_34 = 0;
    gIwram_6480.field_36 = 0;
    gIwram_6540.field_b = 0;
    gIwram_6480.field_b = 18;
    gIwram_6540.field_9 = 0;
    gIwram_6480.field_9 = 1;
    gIwram_6500.field_b = ((struct Rom306F6C *)0x08306F6C)->byte2;
    gIwram_60A0.field_38 = 66;

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
