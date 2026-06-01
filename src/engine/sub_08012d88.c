#include "macros.h"
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

extern void sub_0800EE94(u8 layer);
extern void sub_08013C60(struct TransferDesc desc, u8 mode, void *buf);
extern void sub_08012CAC(void);
extern void sub_08010A44(u8 a, u8 b);
extern void sub_08017000(void);

void sub_08012D88(void)
{
    if (gIwram_60A0[0x40] & 1) {
        *(vu16 *)0x04000050 = 0x1744;
        *(vu16 *)0x04000052 = 0x0e02;
        sub_0800EE94(2);
        gIwram_60A0[0x40] &= 0xfe;
    }

    {
        struct TransferDesc *desc = (struct TransferDesc *)0x08306f08;
        sub_08013C60(*desc, ((u8 *)desc)[2], (void *)0x030064c0);
    }

    sub_08012CAC();
    sub_08010A44(4, 4);
    sub_08017000();
}

extern void sub_0800E85C(u8 arg);
extern void sub_0800EE34(u8 layer);
extern void sub_0800EB1C(void);
extern void sub_08012D40(void);
extern void sub_0800F24C(u8 arg);
extern void sub_0800EBDC(u8 arg);
extern void sub_08016A40(void);

void sub_08012E00(void)
{
    sub_0800E85C(3);
    sub_0800EE34(2);
    sub_0800EB1C();
    sub_08012D40();
    sub_0800F24C(3);
    sub_0800EBDC(3);
    sub_08016A40();
}

void sub_08012E2C(void)
{
    register u8 zero asm("r2");
    register u8 val asm("r1");
    register u8 old asm("r3");
    register u8 *ptr1 asm("r1");
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
