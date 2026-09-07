#include "types.h"
#include "iwram.h"
#include "game.h"
#include "sound.h"
#include "gba/dma.h"

void SetBgPriorities(void)
{
    vu16 *reg = (vu16 *)0x0400000A;
    u16 val = *reg;
    u16 mask = 0xFFFC;

    *reg = val & mask;
    *reg = *reg | 1;
    reg++;
    *reg = *reg & mask;
    *reg = *reg | 2;
}

extern void Scroll_FlushTilemapWindow(u32 mode, const void *src, void *dst);
extern void Scenery_BlitAndCyclePalette(void);

/* Scenery scroll/anim state block at IWRAM 0x03003610 (view for this TU). */
struct SceneryState {
    u8 mode;
    u8 _pad01[6];
    u8 phase; /* +7: 0 = waiting for the selector cells to change, 1 = animating */
    u8 _pad08[3];
    u8 cachedSel; /* +11: last gSceneSel value blitted into the EWRAM tilemap bank */
};

extern struct SceneryState gIwram_3610;
#define gSceneryState gIwram_3610

/* Scenery animation state that lives inside the gEntities pool region. The
 * struct OVERLAYS the gEntities symbol so agbcc materialises the offsets from
 * the symbol base (movs/lsls/adds for 0xb70 and 0x1a60, a pool word for 0x1a5b)
 * and GCSE keeps the base in a callee-saved register across the DMA writes. The
 * union gives the signed change-test read and the unsigned cache-write read. */
struct SceneryAnim {
    u8 _pad0[0xb70];
    union {
        s16 s;
        u16 u;
    } sel;
    u8 _pad1[0x1a5b - 0xb72];
    u8 paletteIdx; /* +0x1a5b */
    u8 _pad2[4];
    u32 lastTick; /* +0x1a60: gGameStuff._unk00 at the last palette step */
};
#define gSceneryAnim (*(struct SceneryAnim *)gEntities)

/* Byte offsets of the SceneryAnim fields from the gEntities base, for the
 * pointer-arithmetic form in Scenery_CyclePalette: agbcc emits the baserom's
 * movs/lsls/adds only for a literal added to a pointer; OFFSET_OF() and
 * struct-member access through a pointer both spill 0x1a60 to the pool. */
#define SCENERY_ANIM_PALETTE_IDX 0x1a5b
#define SCENERY_ANIM_LAST_TICK   0x1a60

/* One full DMA3 transfer per call site: the baserom emits the whole sequence in
 * both arms of a branch and cross-jumps the common tail. Deliberately NOT a
 * do-while(0) macro: the loop notes would double the ref weight of the source
 * pointer and flip the r3/r4 colouring of `high` vs the selector address. */
#define DMA3_COPY(srcp, dstp, ctrl)                                                                                    \
    {                                                                                                                  \
        REG_DMA3.src = (srcp);                                                                                         \
        REG_DMA3.dst = (dstp);                                                                                         \
        REG_DMA3.cnt = (ctrl);                                                                                         \
        (void)REG_DMA3.cnt;                                                                                            \
    }

void Scenery_BlitVariant(const u16 *low, const u16 *high)
{
    if (gSceneryAnim.sel.s == gSceneryState.cachedSel)
        return;

    if (gSceneryAnim.sel.s == 0) {
        DMA3_COPY(low, (void *)0x02010000, DMA_ENABLE | 0x8000);
    } else {
        DMA3_COPY(high, (void *)0x02010000, DMA_ENABLE | 0x8000);
    }

    gSceneryState.cachedSel = gSceneryAnim.sel.u;
    Scroll_FlushTilemapWindow(1, (void *)0x02010000, (void *)0x0600e800);
}

void Scenery_CyclePalette(u8 interval, u8 count, const void *const *paletteTable)
{
    GameStuff *game = &gGameStuff;
    u8 *base = (u8 *)gEntities;
    u32 *lastTick = (u32 *)(base + SCENERY_ANIM_LAST_TICK);
    u8 *paletteIdx;

    if (game->_unk00 - *lastTick < interval)
        return;
    *lastTick = game->_unk00;

    paletteIdx = base + SCENERY_ANIM_PALETTE_IDX;
    if (*paletteIdx >= count)
        *paletteIdx = 0;

    DMA3_COPY(paletteTable[(*paletteIdx)++], (void *)0x05000140, DMA_ENABLE | 0x20);
}

void Scenery_UpdatePhase(void)
{
    switch (gSceneryState.phase) {
    case 0:
        if ((gIwram_6110.selector5Flags & 0xf0) != (gIwram_6110.selector6Flags & 0xf0)) {
            Sound_Play(25);
            gSceneryState.phase = 1;
        }
        break;
    case 1:
        Scenery_BlitAndCyclePalette();
        break;
    }
}
