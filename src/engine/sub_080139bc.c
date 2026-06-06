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

extern void sub_08012BC4(u8 mode, u16 a, u16 b, u16 c, u16 d, void *tiles, u8 e);

void ScaleAnim_BlitDescIdx1(u8 idx)
{
    struct TilemapTableEntry *table = (struct TilemapTableEntry *)0x0830702c;
    struct TilemapTableEntry *desc;
    u32 stride;

    stride = (u32)idx * 3;
    stride <<= 3;
    desc = (struct TilemapTableEntry *)(stride + (u32)table);

    sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06,
                 *(void **)((stride += (u32)(table = (struct TilemapTableEntry *)((u8 *)table + 16))), (void *)stride),
                 1);
}
