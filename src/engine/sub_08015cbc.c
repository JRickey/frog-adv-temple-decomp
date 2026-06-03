#include "macros.h"
#include "types.h"
#include "game.h"
#include "iwram.h"
#include "gba/dma.h"

struct DmaFrameJob_15CBC {
    u16 count;
    u16 _hw02;
    const void *const *table;
    void *dest;
    u16 xferCount;
    u16 _hw0E;
};

struct DmaFrameCtrl_15CBC {
    u8 _pad00[0x1B];
    u8 cursor;
    u8 _pad1C[4];
    u32 seed;
};

u8 sub_08015CBC(struct DmaFrameJob_15CBC job, u8 threshold, struct DmaFrameCtrl_15CBC *ctrl)
{
    u32 seed;
    u32 oldSeed;
    u8 wrapped;

    wrapped = 0;
    seed = gGameStuff._unk00;
    oldSeed = ctrl->seed;
    if ((u32)(seed - oldSeed) >= threshold || seed == oldSeed) {
        const void *source;
        volatile DmaChannel *dma;

        dma = &REG_DMA3;

        {
            register u8 cursor asm("r0");

            cursor = ctrl->cursor;
            ctrl->cursor = cursor + 1;
            source = job.table[cursor];
        }

        dma->src = source;
        dma->dst = job.dest;
        dma->cnt = DMA_ENABLE | (job.xferCount >> 1);
        (void)dma->cnt;

        if (ctrl->cursor >= job.count) {
            ctrl->cursor = 0;
            wrapped = 1;
        }

        ctrl->seed = gGameStuff._unk00;
    }

    return wrapped;
}
