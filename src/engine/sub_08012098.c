#include "game.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

struct IwramAt6410 {
    u8 _pad00[8];
    u32 _field_08;
    u8 _maxFrames;
};

extern struct IwramAt6410 gIwram_6410;
extern void sub_0800EE34(u8 layer);

/* The explicit gs/iw pointer vars force both pool loads before any
 * dereferences, which sets up the LIFO register reuse order that gives
 * r2=upper-byte and r3=lower-byte in the MMIO section. */
u32 sub_08012098(void)
{
    GameStuff *gs;
    struct IwramAt6410 *iw;
    u32 pos;
    u16 t1, t2;

    gs = &gGameStuff;
    iw = &gIwram_6410;
    pos = gs->_unk00;
    if (pos - iw->_field_08 < iw->_maxFrames)
        return 0;

    iw->_field_08 = pos;

    t1 = *(vu16 *)0x04000052 >> 8;
    t2 = *(vu16 *)0x04000052 & 0xff;

    if (t2 == 0 && t1 == 15) {
        sub_0800EE34(2);
        return 1;
    }

    if (t1 != 15)
        t1 = (u16)(t1 + 1);

    if (t2 != 0)
        t2 = (u16)(t2 - 1);

    t1 = (u16)((u8)t1 << 8);
    *(vu16 *)0x04000052 = t1 + t2;
    return 0;
}

extern u8 gIwram_53A0[];
extern u8 gEntities_03003720[];

struct IwramAt6480_12100 {
    u8 _pad00[54];
    s16 field_36;
};

struct IwramAt6540_12100 {
    u8 _pad00[10];
    u8 field_a;
};

extern struct IwramAt6480_12100 gIwram_6480;
extern struct IwramAt6540_12100 gIwram_6540;

void sub_08012100(void)
{
    u16 zero;
    struct IwramAt6110 *ctrl;

    ctrl = &gIwram_6110;
    ctrl->byteFlags8 = ctrl->byteFlags8 & 0xf0;
    ctrl->gateByte = ctrl->gateByte & 0xf0;

    gIwram_53A0[1] = 0;
    gIwram_53A0[0xff] = 0;
    gEntities_03003720[0x1a5b] = 0;

    gIwram_6480.field_36 = 0;
    *(u8 *)&gIwram_6480 = 0;
    *((u8 *)&gIwram_6480 + 2) = 0;

    gIwram_6540.field_a = 0;

    zero = 0;
    REG_DMA3.src = &zero;
    REG_DMA3.dst = (void *)0x02020000;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x8000;
    (void)REG_DMA3.cnt;
}
