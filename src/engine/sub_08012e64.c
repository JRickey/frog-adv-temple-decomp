#include "macros.h"
#include "types.h"

struct TransferDesc {
    u32 word0;
    u32 word4;
    u32 word8;
    u32 wordC;
};

extern u8 gIwram_60A0[];

extern void sub_0800EE94(u8 layer);
extern void sub_08012CAC(void);
extern void sub_08013C60(struct TransferDesc desc, u8 mode, void *buf);
extern void sub_08017000(void);

void sub_08012E64(void)
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
        sub_0800EE94(2);
    }

    sub_08012CAC();

    {
        struct TransferDesc *desc = (struct TransferDesc *)0x08306f08;
        sub_08013C60(*desc, ((u8 *)desc)[2], (void *)0x030064c0);
    }

    sub_08017000();
}

extern void sub_0800E85C(u8 arg);
extern void sub_0800EE34(u8 layer);
extern void sub_0800EB1C(void);
extern void sub_08012E2C(void);
extern void sub_0800F24C(u8 arg);
extern void sub_0800EBDC(u8 arg);
extern void sub_08016A40(void);

void sub_08012ED4(void)
{
    sub_0800E85C(3);
    sub_0800EE34(2);
    sub_0800EB1C();
    sub_08012E2C();
    sub_0800F24C(3);
    sub_0800EBDC(3);
    sub_08016A40();
}
