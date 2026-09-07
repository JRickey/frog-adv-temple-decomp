#include "gba/dma.h"
#include "gfx.h"
#include "types.h"

extern void CharLayers_Upload(unsigned int arg);
extern void FrogOam_Init(void);
extern void Selector_ResetState(void);
extern void BgScrollBlit(unsigned int arg);
extern void StatusBar_Update(void);

extern u8 gIwram_6410[];
extern u8 gIwram_6540[];

struct IwramAt6480 {
    u8 byte0;
    u8 _pad01;
    u8 byte2;
    u8 _pad03[0x33];
    u16 half36;
};

extern struct IwramAt6480 gIwram_6480;

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

void sub_080125B0(void)
{
    u16 zero;
    volatile DmaChannel *dma;
    struct IwramAt6480 *state;

    state = &gIwram_6480;
    state->half36 = 0;
    state->byte0 = 0;
    state->byte2 = 0;
    gIwram_6540[10] = 0;

    zero = 0;
    dma = &REG_DMA3;
    dma->src = &zero;
    dma->dst = (void *)0x02020000;
    dma->cnt = 0x81008000;
    (void)dma->cnt;
}

void ScaleAnim_ResetState(void)
{
    gIwram_6410[12] = 8;
    gIwram_6480.half36 = 0;
}
