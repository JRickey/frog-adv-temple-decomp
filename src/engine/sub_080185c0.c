#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "iwram.h"

/* --- Sprite_CycleDmaFrame: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "iwram.h"

extern u32 GetFrameTick(void);

typedef struct {
    u16 limit;
    u8 delay;
    u8 _pad3;
    const u32 *srcTable;
    void *dst;
    u16 dmaHalfwords;
    u16 _pad14;
} DmaCycleCfg;

/* Time-gated cyclic DMA + alpha-blend setup. The 16-byte config record
 * (sOamDmaCfg_08100) is passed by value. */
void Sprite_CycleDmaFrame(DmaCycleCfg cfg)
{
    vu32 *dma;
    const u32 *src;
    u8 *state;
    u32 now = GetFrameTick();

    state = (u8 *)0x03006480;

    if (now - *(u32 *)(state + 4) >= cfg.delay) {
        if (state[0xa] >= cfg.limit)
            state[0xa] = 0;

        dma = (vu32 *)0x040000D4;
        src = cfg.srcTable;
        dma[0] = src[state[0xa]];
        dma[1] = (u32)cfg.dst;
        dma[2] = DMA_ENABLE | (cfg.dmaHalfwords >> 1);
        dma[2];

        state[0xa]++;
        *(u32 *)(state + 4) = GetFrameTick();
    }

    *(vu16 *)0x04000050 = 0x1142;
    *(vu16 *)0x04000052 = 0x0909;
}
#endif /* NON_MATCHING */
