#include "types.h"
#include "iwram.h"

extern void sub_0800E85C(unsigned int arg);
extern void sub_0800EB1C(void);
extern void sub_08013B54(void);
extern void sub_0800F24C(unsigned int arg);
extern void sub_0800EBDC(unsigned int arg);
extern void sub_08012CAC(void);
extern void sub_08016A40(void);
extern void sub_0800EE94(u8 layer);
extern void sub_08010A44(u8 a, u8 b);
extern void sub_08010958(u8 a, u8 b);
extern void sub_08017000(void);
extern u8 gIwram_60A0[];

struct TransferDesc_13D44 {
    u32 word0;
    u32 word4;
    u32 word8;
    u32 wordC;
};

extern void sub_08013C60(struct TransferDesc_13D44 desc, u8 mode, void *buf);

void sub_08013D1C(void)
{
    sub_0800E85C(3);
    sub_0800EB1C();
    sub_08013B54();
    sub_0800F24C(3);
    sub_0800EBDC(3);
    sub_08012CAC();
    sub_08016A40();
}

void sub_08013D44(void)
{
    u8 *scrollBase;
    u8 *scrollFlag;
    u8 *control;
    const struct TransferDesc_13D44 *desc;

    scrollBase = gIwram_60A0;
    scrollFlag = scrollBase + 0x40;
    if ((*scrollFlag & 1) != 0) {
        *(u16 *)0x04000050 = 0x1744;
        *(u16 *)0x04000052 = 0x0C04;
        *scrollFlag &= 0xFE;
        sub_0800EE94(2);
    }

    control = (u8 *)&gIwram_6110;
    if ((*(u16 *)(control + 0x26) & 1) != 0) {
        control[0x2A] |= 1;
    }

    sub_08010A44(1, 1);
    sub_08017000();

    desc = (const struct TransferDesc_13D44 *)0x08307238;
    sub_08013C60(*desc, ((const u8 *)desc)[2], (void *)0x030064C0);
}

void sub_08013DD4(void)
{
    sub_0800E85C(2);
    sub_0800EB1C();
    sub_08010958(1, 1);
    sub_0800F24C(2);
    sub_0800EBDC(2);
    sub_08016A40();
}
