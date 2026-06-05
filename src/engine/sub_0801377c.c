#include "macros.h"
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

extern void sub_08020C78(u32 arg);
extern void sub_0800E85C(u8 arg);
extern void sub_0800EB1C(void);
extern void sub_0800F24C(u8 arg);
extern void sub_0801310C(void);
extern void sub_0800EBDC(u8 arg);
extern void sub_08016A40(void);
extern void sub_08012E2C(void);
extern void sub_0800EE34(u8 layer);
extern u8 gIwram_3610;
extern u8 gIwram_6110;

void sub_0801377C(void)
{
    vu16 *scroll;
    vu32 *dma;
    u8 *flags;

    sub_08020C78(0x33);

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

void sub_08013828(void)
{
    u32 zero;
    u8 *flags;
    u8 *control;

    sub_0800E85C(3);
    sub_0800EB1C();
    sub_0800F24C(2);

    flags = &gIwram_3610;
    zero = 0;
    flags[0] = zero;
    flags[0xdc] = zero;
    flags[0xd4] = zero;

    control = (u8 *)&gIwram_6110;
    *(u16 *)(control + 0x28) = zero;
    control[0x2b] &= 0xf;

    sub_0801310C();
    sub_0801310C();
    sub_0800EBDC(3);
    sub_08016A40();
    sub_08012E2C();
    sub_0800EE34(2);
}
