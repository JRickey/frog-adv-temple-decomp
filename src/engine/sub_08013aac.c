#include "macros.h"
#include "types.h"
#include "game.h"
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

struct DmaJob_13BA4 {
    u16 count;
    u16 _hw02;
    void *table;
    void *dest;
    u16 xferCount;
    u16 _hw0E;
};

struct Queue_64C0 {
    u8 _field_00;
    u8 _pad01[3];
    u32 _seed;
    u8 _pad08[2];
    u8 _cursor;
};

extern void sub_08012BC4(u8 mode, u16 a, u16 b, u16 c, u16 d, void *tiles, u8 e);
extern void sub_0800E7D4(void);
extern void sub_0800EE34(u8 layer);
extern void sub_0800EE94(u8 layer);
extern void sub_08012CAC(void);
extern u8 sub_08013C60(struct DmaJob_13BA4 job, u8 mode, struct Queue_64C0 *queue);
extern void sub_0801310C(void);
extern void sub_08017000(void);
extern u8 gIwram_6410[];
extern u8 gIwram_6400[];
extern u8 gIwram_6480[];
extern u8 gIwram_6500[];
extern u8 gIwram_60A0[];

void sub_08013AAC(u8 idx)
{
    struct TilemapTableEntry *table = (struct TilemapTableEntry *)0x083070ec;
    struct TilemapTableEntry *desc;
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
        struct DmaJob_13BA4 *desc0;

        sub_0800E7D4();
        sub_08012CAC();
        desc0 = (struct DmaJob_13BA4 *)0x08306f08;
        sub_08013C60(*desc0, ((u8 *)desc0)[2], (struct Queue_64C0 *)0x030064c0);
        break;
    }
    }

    {
        struct DmaJob_13BA4 *desc1 = (struct DmaJob_13BA4 *)0x08306f50;

        sub_08013C60(*desc1, ((u8 *)desc1)[2], (struct Queue_64C0 *)0x03006580);
    }

    sub_0801310C();
}

void sub_08013B54(void)
{
    u32 zero;
    register u8 small asm("r3");

    {
        u8 *ptr;

        ptr = gIwram_6410;
        zero = 0;
        small = 2;
        ptr[12] = small;
        ptr[0] = 3;
        *(u32 *)(ptr + 4) = zero;
    }

    {
        u8 *ptr;
        u8 sixteen;

        ptr = gIwram_6400;
        *(u32 *)(ptr + 4) = zero;
        sixteen = 16;
        ptr[12] = sixteen;
        ptr[0] = small;
    }

    {
        u8 *ptr;

        ptr = gIwram_6480;
        small = 1;
        ptr[0] = 1;
    }

    {
        u8 *ptr;

        ptr = gIwram_6500;
        ptr[10] = zero;
    }
    {
        u8 val;

        val = gIwram_60A0[0x40];
        val |= small;
        gIwram_60A0[0x40] = val;
    }
    sub_0800EE34(2);
}

void sub_08013BA4(void)
{
    const struct DmaJob_13BA4 *src;
    struct DmaJob_13BA4 job;
    register struct Queue_64C0 *queue asm("r4");
    GameStuff *gs;
    u8 mode;
    u32 seed;
    u32 oldSeed;

    if ((gIwram_60A0[0x40] & 1) != 0) {
        *(u16 *)0x04000050 = 0x1744;
        *(u16 *)0x04000052 = 0x030D;
        gIwram_60A0[0x40] &= 0xFE;
        sub_0800EE94(2);
    }

    sub_08012CAC();

    src = (const struct DmaJob_13BA4 *)0x08307220;
    mode = ((const u8 *)src)[2];
    queue = (struct Queue_64C0 *)0x030064C0;
    job = *src;

    gs = &gGameStuff;
    seed = gs->_unk00;
    oldSeed = queue->_seed;
    if ((u32)(seed - oldSeed) >= mode || seed == oldSeed) {
        const void *source;

        {
            /* cursor pinned to r0 (as in sub_08013BA4): forces agbcc to keep the
               pre-increment cursor live for the `<<24 >>22` fused u8*4 table index. */
            register u8 cursor asm("r0");

            cursor = queue->_cursor;
            queue->_cursor = cursor + 1;
            source = ((const void *const *)job.table)[cursor];
        }

        REG_DMA3.src = source;
        REG_DMA3.dst = job.dest;
        REG_DMA3.cnt = DMA_ENABLE | (job.xferCount >> 1);
        (void)REG_DMA3.cnt;

        {
            struct DmaJob_13BA4 *jobPtr;
            register u8 wrapCursor asm("r6");

            jobPtr = &job;
            wrapCursor = queue->_cursor;
            if (wrapCursor >= jobPtr->count) {
                queue->_cursor = 0;
            }
        }

        queue->_seed = gs->_unk00;
    }

    sub_08017000();
}

u8 sub_08013C60(struct DmaJob_13BA4 job, u8 mode, struct Queue_64C0 *queue)
{
    u32 seed;
    u32 oldSeed;
    u8 wrapped;

    wrapped = 0;
    seed = gGameStuff._unk00;
    oldSeed = queue->_seed;
    if ((u32)(seed - oldSeed) >= mode || seed == oldSeed) {
        const void *source;

        {
            /* cursor pinned to r0 (as in sub_08013BA4): forces agbcc to keep the
               pre-increment cursor live for the `<<24 >>22` fused u8*4 table index. */
            register u8 cursor asm("r0");

            cursor = queue->_cursor;
            queue->_cursor = cursor + 1;
            source = ((const void *const *)job.table)[cursor];
        }

        REG_DMA3.src = source;
        REG_DMA3.dst = job.dest;
        REG_DMA3.cnt = DMA_ENABLE | (job.xferCount >> 1);
        (void)REG_DMA3.cnt;

        if (queue->_cursor >= job.count) {
            queue->_cursor = 0;
            wrapped = 1;
        }

        queue->_seed = gGameStuff._unk00;
    }

    return wrapped;
}

/* Unreferenced variant of sub_08013C60 (no callers in ROM): gates on the same
   seed window, but only wraps the cursor — no cursor advance, no DMA. The 24-byte
   by-value struct is load-bearing: agbcc homes the first 16 bytes as pretend args
   (sub sp / push order, struct at sp+16), which is how the baserom prologue looks. */
struct DmaJob2_13CD4 {
    u8 _pad00[10];
    u16 count;
    u8 _pad0C[12];
};

u8 sub_08013CD4(struct DmaJob2_13CD4 job, u8 mode, struct Queue_64C0 *queue)
{
    u32 seed;
    u32 oldSeed;
    u8 wrapped;

    wrapped = 0;
    seed = gGameStuff._unk00;
    oldSeed = queue->_seed;
    if ((u32)(seed - oldSeed) >= mode || seed == oldSeed) {
        if (queue->_cursor >= job.count) {
            queue->_cursor = 0;
            wrapped = 1;
        }

        queue->_seed = gGameStuff._unk00;
    }

    return wrapped;
}
