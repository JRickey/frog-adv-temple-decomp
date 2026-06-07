#include "gfx.h"
#include "macros.h"
#include "types.h"
#include "iwram.h"
#include "gba/io.h"

extern void sub_08012BC4(u8 mode, u16 a, u16 b, u16 c, u16 d, void *tiles, u8 e);

void Tilemap_DispatchPendingBlits(void)
{
    /* The baserom holds the loop constants (1, table base, table base + 16) in
     * high registers across the inner BL; pin them so agbcc does the same. */
    u8 i = 0;
    struct IwramAt6110 *ctrl = &gIwram_6110;
    u32 one = 1;
    struct TilemapTableEntry *table = (struct TilemapTableEntry *)0x08307e18;
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

/* Minimal struct views for the Scenery_InitScrollState init pass. */
struct IwramInited6480 {
    u8 base; /* +0 */
    u8 _pad[7];
    u8 flag; /* +8 */
};

struct IwramInited6540 {
    u8 base; /* +0 */
    u8 _pad[7];
    u8 flag; /* +8 */
};

struct IwramInited3610 {
    u8 base; /* +0 */
    u8 _pad[5];
    u8 field6; /* +6 */
    u8 field7; /* +7 */
    u8 _pad2[2];
    u8 fielda; /* +10 */
    u8 fieldb; /* +11 */
};

extern struct IwramInited6480 gIwram_6480;
extern struct IwramInited6540 gIwram_6540;
extern u8 gIwram_6500;
extern u8 gIwram_6580;
extern struct IwramInited3610 gIwram_3610;

void Scenery_InitScrollState(void)
{
    /* r2 holds &gIwram_6540 throughout the paired init writes;
     * without the pin, agbcc assigns the wrong register. */
    struct IwramInited6540 *p6540 = &gIwram_6540;

    p6540->flag = 0;
    gIwram_6480.flag = 0;
    p6540->base = 0;
    gIwram_6480.base = 0;
    gIwram_6500 = 0;
    gIwram_6580 = 0;
    gIwram_3610.base = 0;
    gIwram_3610.field6 = 0;
    gIwram_3610.field7 = 0;
    gIwram_3610.fielda = 0;
    gIwram_3610.fieldb = 0;
    Tilemap_DispatchPendingBlits();
    REG_BG2CNT = 0x1e0d;
}
