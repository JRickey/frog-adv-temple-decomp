#include "macros.h"
#include "types.h"
#include "iwram.h"

struct TransferDesc {
    u32 word0;
    u32 word4;
    u32 word8;
    u32 wordC;
};

struct IwramAt6480 {
    u8 _pad00[4];
    u32 field_4;
    u8 _pad08[3];
    u8 field_b;
    u8 _pad0C[42];
    u16 field_36;
};

struct IwramAt6540 {
    u8 _pad00[52];
    s16 field_34;
    u16 field_36;
};

struct IwramAt60A0 {
    u8 _pad00[12];
    u32 field_c;
    u32 field_10;
    u8 _pad14[24];
    u32 field_2c;
    u32 field_30;
    u8 _pad34[24];
    u32 field_4c;
    u32 field_50;
};

extern struct IwramAt6480 gIwram_6480;
extern struct IwramAt6540 gIwram_6540;
extern struct IwramAt60A0 gIwram_60A0;

extern void sub_0800EE94(u8 layer);
extern void sub_0800EE34(u8 layer);
extern void sub_08013C60(struct TransferDesc desc, u8 mode, void *buf);
extern void sub_080135B8(u16 a, u8 b, u16 c, u8 d);

u8 sub_080142D4(void)
{
    if (gIwram_6480.field_36 != 0xc0) {
        if (gIwram_6110._field_10 & 1)
            sub_0800EE94(2);
    }

    {
        struct TransferDesc *desc = (struct TransferDesc *)0x0830775c;
        sub_08013C60(*desc, ((u8 *)desc)[2], (void *)0x030064c0);
    }

    sub_080135B8(0, 0, 0, 1);

    {
        register struct IwramAt60A0 *p60a0 asm("r2") = &gIwram_60A0;
        u32 f10;

        p60a0->field_4c += gIwram_6540.field_34;
        f10 = p60a0->field_10;
        p60a0->field_50 = f10 + (s16)gIwram_6480.field_36;

        gIwram_6540.field_36 = 312 - gIwram_6480.field_36;

        if (gIwram_6480.field_36 == 0) {
            sub_0800EE34(2);
            return 1;
        }
    }
    return 0;
}
