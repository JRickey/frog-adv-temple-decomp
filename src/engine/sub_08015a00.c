#include "macros.h"
#include "types.h"
#include "iwram.h"
#include "gba/dma.h"

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

extern void sub_08012BC4(u8 mode, u16 a, u16 b, u16 c, u16 d, void *tiles, u8 e);
extern void sub_0800E7D4(void);
extern void sub_0802BC94(void);
extern void sub_08017000(void);
extern void sub_0800534C(void);
extern void sub_080100E4(u32, void *, void *);
extern void sub_0800E85C(u8 arg);
extern void sub_0800EB1C(void);
extern void sub_080159B0(void);
extern void sub_0800F24C(u8 arg);
extern void sub_0800EBDC(u8 arg);
extern void sub_08016A40(void);

#define sTilemapTable_307CE8 (*(const struct TilemapTableEntry *)0x08307ce8)

extern const u16 sBgTilemapVariantA_19C312[];
extern const u16 sBgTilemapVariantB_19CFDE[];

void sub_08015A00(void)
{
    const struct TilemapTableEntry *desc = &sTilemapTable_307CE8;

    sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, desc->tiles, 1);
}

void sub_08015A2C(void)
{
    sub_0800E7D4();
    if (gIwram_6110.spawnMask == 0)
        sub_0802BC94();
    sub_08017000();
    sub_0800534C();
}

void sub_08015A50(void)
{
    REG_DMA3.src = sBgTilemapVariantA_19C312;
    REG_DMA3.dst = (void *)(0x80 << 18);
    REG_DMA3.cnt = DMA_ENABLE | 0x8000;
    (void)REG_DMA3.cnt;
    sub_080100E4(0, (void *)(0x80 << 18), (void *)0x0600e000);
}

void sub_08015A80(void)
{
    REG_DMA3.src = sBgTilemapVariantB_19CFDE;
    REG_DMA3.dst = (void *)(0x80 << 18);
    REG_DMA3.cnt = DMA_ENABLE | 0x8000;
    (void)REG_DMA3.cnt;
    sub_080100E4(0, (void *)(0x80 << 18), (void *)0x0600e000);
}

void sub_08015AB0(void)
{
    sub_0800E85C(2);
    sub_0800EB1C();
    sub_080159B0();
    sub_0800F24C(2);
    sub_0800EBDC(2);
    sub_08016A40();
}
