#include "macros.h"
#include "types.h"
#include "iwram.h"

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

void sub_08015930(void)
{
    /* The baserom holds the loop constants (1, table base, table base + 16) in
     * high registers across the inner BL; pin them so agbcc does the same. */
    u8 i = 0;
    struct IwramAt6110 *ctrl = &gIwram_6110;
    register u32 one asm("r8") = 1;
    register struct TilemapTableEntry *table asm("r9") = (struct TilemapTableEntry *)0x08307e18;
    register struct TilemapTableEntry *table16 asm("sl") = (struct TilemapTableEntry *)((u8 *)table + 16);
    u32 stride;

    do {
        if ((ctrl->selector5Flags >> i) & one) {
            struct TilemapTableEntry *desc;

            stride = (u32)i * 3;
            stride <<= 3;
            desc = (struct TilemapTableEntry *)(stride + (u32)table);

            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06,
                         *(void **)((stride += (u32)table16), (void *)stride), (ctrl->selector5Flags >> i) & one);
            ctrl->selector6Flags |= one << i;
        }
        i = (u8)(i + 1);
    } while (i <= 3);
}
