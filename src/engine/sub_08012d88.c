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
