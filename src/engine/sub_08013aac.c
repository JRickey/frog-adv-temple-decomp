#include "macros.h"
#include "types.h"

struct TilemapTableEntry {
    u16 unk00;
    u16 unk02;
    u16 unk04;
    u16 unk06;
    u8 unk08;
    u8 pad09[7];
    void *tiles;
    u8 pad14[4];
};

struct TransferDesc_13AE8 {
    u32 word0;
    u32 word4;
    u32 word8;
    u32 wordC;
};

extern void sub_08012BC4(u8 mode, u16 a, u16 b, u16 c, u16 d, void *tiles, u8 e);
extern void sub_0800E7D4(void);
extern void sub_0800EE34(u8 layer);
extern void sub_08012CAC(void);
extern void sub_08013C60(struct TransferDesc_13AE8 desc, u8 mode, void *buf);
extern void sub_0801310C(void);
extern u8 gIwram_6410[];
extern u8 gIwram_6400[];
extern u8 gIwram_6480[];
extern u8 gIwram_6500[];
extern u8 gIwram_60A0[];

void sub_08013AAC(u8 idx)
{
    register struct TilemapTableEntry *table asm("r6") = (struct TilemapTableEntry *)0x083070ec;
    register struct TilemapTableEntry *desc asm("r4");
    u32 stride;

    stride = (u32)idx * 3;
    stride <<= 3;
    desc = (struct TilemapTableEntry *)(stride + (u32)table);

    sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06,
                 *(void **)((stride += (u32)(table = (struct TilemapTableEntry *)((u8 *)table + 16))), (void *)stride),
                 3);
}

void sub_08013AE8(void)
{
    u8 state;
    u8 *statePtr;

    statePtr = (u8 *)0x03003610;
    state = *statePtr;

    switch (state) {
    case 0:
        *statePtr = 1;
        break;
    case 1: {
        struct TransferDesc_13AE8 *desc0;

        sub_0800E7D4();
        sub_08012CAC();
        desc0 = (struct TransferDesc_13AE8 *)0x08306f08;
        sub_08013C60(*desc0, ((u8 *)desc0)[2], (void *)0x030064c0);
        break;
    }
    }

    {
        struct TransferDesc_13AE8 *desc1 = (struct TransferDesc_13AE8 *)0x08306f50;

        sub_08013C60(*desc1, ((u8 *)desc1)[2], (void *)0x03006580);
    }

    sub_0801310C();
}

void sub_08013B54(void)
{
    register u32 zero asm("r2");
    register u8 small asm("r3");

    {
        register u8 *ptr asm("r1");

        ptr = gIwram_6410;
        zero = 0;
        small = 2;
        ptr[12] = small;
        ptr[0] = 3;
        *(u32 *)(ptr + 4) = zero;
    }

    {
        register u8 *ptr asm("r0");
        register u8 sixteen asm("r1");

        ptr = gIwram_6400;
        *(u32 *)(ptr + 4) = zero;
        sixteen = 16;
        ptr[12] = sixteen;
        ptr[0] = small;
    }

    {
        register u8 *ptr asm("r1");

        ptr = gIwram_6480;
        small = 1;
        ptr[0] = 1;
    }

    {
        register u8 *ptr asm("r0");

        ptr = gIwram_6500;
        ptr[10] = zero;
    }
    {
        register u8 val asm("r1");

        val = gIwram_60A0[0x40];
        val |= small;
        gIwram_60A0[0x40] = val;
    }
    sub_0800EE34(2);
}
