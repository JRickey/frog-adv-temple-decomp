#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

extern void sub_080100E4(u32, void *, void *);
extern void sub_0800A05C(void);
extern void sub_08019A14(void);
extern void sub_08020B88(u32);
extern void sub_08020BAC(void);
extern const u8 sRoomDmaTable_080C1254[];

struct ScrollData {
    u32 f0;
    u32 f1;
    u32 f2;
    u32 f3;
};

struct Unk03006420 {
    u32 active;
    u16 dispcnt;
    u16 _pad;
    struct ScrollData scroll;
    u8 _pad18;
    u8 tileBank; /* +25: high tilemap-entry bits (<<12) for the screen fill */
};

extern struct Unk03006420 gUnk03006420;

/* clang-format off */
#define FIXED_ARG_U32(reg, expr) ({ register u32 _v asm(reg) = (expr); _v; })
#define FIXED_ARG_PTR(reg, expr) ({ register void *_v asm(reg) = (void *)(expr); _v; })
/* clang-format on */

u32 sub_08019E6C(void)
{
    register struct Unk03006420 *base asm("r4") = &gUnk03006420;

    if (base->active == 0) {
        sub_08019A14();
        return 0;
    }

    REG_DISPCNT = base->dispcnt;

    *(struct ScrollData *)0x03003550 = base->scroll;

    sub_080100E4(FIXED_ARG_U32("r0", 0), FIXED_ARG_PTR("r1", 0x80 << 18), FIXED_ARG_PTR("r2", 0x0600e000));
    sub_080100E4(FIXED_ARG_U32("r0", 1), FIXED_ARG_PTR("r1", 0x02010000), FIXED_ARG_PTR("r2", 0x0600e800));
    sub_080100E4(FIXED_ARG_U32("r0", 2), FIXED_ARG_PTR("r1", 0x02020000), FIXED_ARG_PTR("r2", 0x0600f000));
    sub_080100E4(FIXED_ARG_U32("r0", 3), FIXED_ARG_PTR("r1", 0x02030000), FIXED_ARG_PTR("r2", 0x0600f800));

    base->active = 0;
    return 1;
}

/* Per-room DMA3 setup: clears the BG3 screen block, then streams two
 * room-specific source pointers (from the 24-byte ROM table at 0x080C1254,
 * indexed by gIwram_34B0) into palette RAM and back into VRAM, finally
 * arming REG_BG3CNT.
 *
 * tableBase is kept opaque (the barrier) so agbcc adds the +8/+4 field
 * offsets to the base register at runtime instead of folding each into a
 * separate pool constant. The zptr pointer-first store makes &zero (reused
 * as the fixed DMA source) materialize before the zero value. */
void sub_08019EF0(void)
{
    u16 zero;
    u16 *zptr;
    vu32 *dma;
    u32 dst;
    u32 idx24;
    u32 tableBase;
    u32 entry;
    u32 cnt;

    zptr = &zero;
    *zptr = 0;

    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)zptr;
    dst = 0x06008000;
    dma[1] = dst;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    cnt = dma[2];

    tableBase = 0x080C1254;
    asm volatile("" : "+r"(tableBase));
    idx24 = gIwram_34B0._data * 24;

    entry = tableBase + 8;
    dma[0] = *(const u32 *)(idx24 + entry);
    dma[1] = 0x050001A0;
    dma[2] = DMA_ENABLE | 0x30;
    cnt = dma[2];

    tableBase += 4;
    dma[0] = *(const u32 *)(idx24 + tableBase);
    dma[1] = dst;
    dma[2] = DMA_ENABLE | 0x2000;
    cnt = dma[2];
    (void)cnt;

    REG_BG3CNT = 0x1F08;
}

void sub_08019F70(u8 arg)
{
    vu16 *dst;
    u16 i;

    switch (arg) {
    case 0:
        dst = (vu16 *)0x0600E000;
        break;
    case 1:
        dst = (vu16 *)0x0600E800;
        break;
    case 2:
        dst = (vu16 *)0x0600F000;
        break;
    case 3:
        dst = (vu16 *)0x0600F800;
        break;
    }

    i = 0;
    do {
        *dst = i + (gUnk03006420.tileBank << 12);
        dst++;
        i++;
    } while (i <= 0x3FF);
}

void sub_08019FD8(void)
{
    u16 zero;
    vu32 *dma;
    u16 *win;
    u32 idx24;
    u32 tableBase;

    sub_0800A05C();

    *(u16 *)&zero = 0;

    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)&zero;
    dma[1] = 0x06000000;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x8000;
    (void)dma[2];

    REG_BG3CNT = 0x1F08;

    win = (u16 *)0x04000040;
    *win = 0;
    win += 2;
    *win = 0;
    win += 2;
    *win = 0;
    win += 1;
    *win = 0;

    REG_DISPCNT = REG_DISPCNT & ~DISPCNT_WIN0_ON;
    REG_DISPCNT = REG_DISPCNT & ~DISPCNT_WIN1_ON;

    gIwram_3550._data[6] = 0;
    gIwram_3550._data[7] = 0;

    tableBase = (u32)sRoomDmaTable_080C1254;
    idx24 = gIwram_34B0._data * 24;
    tableBase += 4;
    dma[0] = *(const u32 *)(idx24 + tableBase);
    dma[1] = 0x06008000;
    dma[2] = DMA_ENABLE | 0x2000;
    (void)dma[2];

    gIwram_34C0.cursor = 0;
    gIwram_34C0.delay = 0;
    gIwram_34C0.holdFlag = 0;

    gIwram_6110.inputFlags ^= 8;

    sub_08020BAC();
    sub_08020B88(15);
}
