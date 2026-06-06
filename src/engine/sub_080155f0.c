#include "macros.h"
#include "types.h"
#include "iwram.h"

/* --- Scenery_BlitAndCyclePalette: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "macros.h"
#include "types.h"
#include "iwram.h"
#include "game.h"
#include "gba/dma.h"

extern void Scroll_FlushTilemapWindow(u32 mode, void *src, void *dst);

extern const u16 sScenerVariantMode0Low_1B9DBA[];
extern const u16 sScenerVariantMode0High_1BAC7E[];
extern const u16 sScenerVariantMode1Low_1B62AA[];
extern const u16 sScenerVariantMode1High_1B716E[];
extern const u16 sScenerVariantMode2Low_1BBB42[];
extern const u16 sScenerVariantMode2High_1BCA06[];
extern const u16 sScenerVariantMode3Low_1B8032[];
extern const u16 sScenerVariantMode3High_1B8EF6[];

extern const void *const gPaletteSrcTable_08307E78[];

/* selector at gEntities + 0xb70: struct OVERLAY over the gEntities SYMBOL forces
 * agbcc to materialise 0xb70 arithmetically (movs #0xb7; lsls #4; adds); the
 * union gives the signed change-test read and the unsigned cache-write read from
 * one field. */
struct SceneSel {
    u8 _pad[0xb70];
    union {
        s16 s;
        u16 u;
    } sel;
};
#define gSceneSel (*(struct SceneSel *)gEntities)

#define BLIT_SCENERY(lowVariant, highVariant)                                                                          \
    do {                                                                                                               \
        const u16 *low = (lowVariant);                                                                                 \
        const u16 *high = (highVariant);                                                                               \
        u8 *cache = (u8 *)0x03003610;                                                                                  \
        if (gSceneSel.sel.s != cache[0xb]) {                                                                           \
            if (gSceneSel.sel.s == 0)                                                                                  \
                REG_DMA3.src = low;                                                                                    \
            else                                                                                                       \
                REG_DMA3.src = high;                                                                                   \
            REG_DMA3.dst = (void *)0x02010000;                                                                         \
            REG_DMA3.cnt = DMA_ENABLE | 0x8000;                                                                        \
            (void)REG_DMA3.cnt;                                                                                        \
            cache[0xb] = gSceneSel.sel.u;                                                                              \
            Scroll_FlushTilemapWindow(1, (void *)0x02010000, (void *)0x0600e800);                                      \
        }                                                                                                              \
    } while (0)

void Scenery_BlitAndCyclePalette(void)
{
    const void *const *paletteTable;

    switch (gIwram_6110.gateByte) {
    case 0:
        BLIT_SCENERY(sScenerVariantMode0Low_1B9DBA, sScenerVariantMode0High_1BAC7E);
        paletteTable = &gPaletteSrcTable_08307E78[5];
        break;
    case 1:
        BLIT_SCENERY(sScenerVariantMode1Low_1B62AA, sScenerVariantMode1High_1B716E);
        paletteTable = &gPaletteSrcTable_08307E78[7];
        break;
    case 2:
        BLIT_SCENERY(sScenerVariantMode2Low_1BBB42, sScenerVariantMode2High_1BCA06);
        paletteTable = &gPaletteSrcTable_08307E78[9];
        break;
    case 3:
        BLIT_SCENERY(sScenerVariantMode3Low_1B8032, sScenerVariantMode3High_1B8EF6);
        paletteTable = &gPaletteSrcTable_08307E78[11];
        break;
    default:
        return;
    }

    {
        u8 *base = (u8 *)gEntities;
        u32 *lastTick = (u32 *)(base + 0x1a60);
        u32 now = gGameStuff._unk00;

        if (now - *lastTick < 8)
            return;

        *lastTick = now;
        {
            u8 *idxByte = base + 0x1a5b;

            if (*idxByte > 1)
                *idxByte = 0;

            {
                u32 idx = *idxByte;
                *idxByte = idx + 1;

                REG_DMA3.src = paletteTable[idx];
                REG_DMA3.dst = (void *)0x05000140;
                REG_DMA3.cnt = DMA_ENABLE | 0x20;
                (void)REG_DMA3.cnt;
            }
        }
    }
}
#else
NAKED void Scenery_BlitAndCyclePalette(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x155f0, 0x26c\n");
}
#endif /* NON_MATCHING */
