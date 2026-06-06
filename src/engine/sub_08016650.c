#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "game.h"
#include "iwram.h"

/* Animated-icon frame sources. Each frame is a 16-colour palette (32 B)
 * immediately followed by 80 halfwords of 4bpp tiles (160 B); the five
 * frames live back-to-back in sIconAnimFrames (src/data/icon_anim_frames.c).
 * They are referenced here as independent linker-assigned ROM symbols so
 * agbcc cannot fold each palette as (tiles - 32) — see linker.ld. */
extern const u16 sIconFramePal0[16], sIconFrameTiles0[80];
extern const u16 sIconFramePal1[16], sIconFrameTiles1[80];
extern const u16 sIconFramePal2[16], sIconFrameTiles2[80];
extern const u16 sIconFramePal3[16], sIconFrameTiles3[80];
extern const u16 sIconFramePal4[16], sIconFrameTiles4[80];

#define ICON_TILE_VRAM ((void *)0x06008800)
#define ICON_PAL_RAM   ((void *)0x05000180)

/* Uploads one frame: 160 B of tiles to VRAM, then 32 B of palette to
 * PAL_RAM, via DMA3. Written inline in each case (no shared tail in source);
 * agbcc cross-jumps the identical palette-upload suffix into one tail. */
#define LOAD_ICON_FRAME(n)                                                                                             \
    REG_DMA3.src = sIconFrameTiles##n;                                                                                 \
    REG_DMA3.dst = ICON_TILE_VRAM;                                                                                     \
    REG_DMA3.cnt = DMA_ENABLE | 0x50;                                                                                  \
    (void)REG_DMA3.cnt;                                                                                                \
    REG_DMA3.src = sIconFramePal##n;                                                                                   \
    REG_DMA3.dst = ICON_PAL_RAM;                                                                                       \
    REG_DMA3.cnt = DMA_ENABLE | 0x10;                                                                                  \
    (void)REG_DMA3.cnt

/* Refreshes the on-screen animated icon for the current scene type.
 * gGameStuff.pendingMode (the scene-type id) selects which of the five
 * icon frames to upload; scene type 15 reads a finer animation state
 * from gIwram_6110.spawnMask. */
void Icon_LoadFrameByMode(void)
{
    switch (gGameStuff.pendingMode - 1) {
    case 0:
    case 1:
        LOAD_ICON_FRAME(1);
        return;
    case 3:
    case 4:
        LOAD_ICON_FRAME(3);
        return;
    case 6:
    case 7:
        LOAD_ICON_FRAME(2);
        return;
    case 9:
    case 10:
        LOAD_ICON_FRAME(0);
        return;
    case 12:
    case 13:
        LOAD_ICON_FRAME(4);
        return;
    case 14:
        switch (gIwram_6110.spawnMask) {
        case 0:
            LOAD_ICON_FRAME(1);
            return;
        case 1:
            LOAD_ICON_FRAME(3);
            return;
        case 2:
            LOAD_ICON_FRAME(2);
            return;
        case 3:
            LOAD_ICON_FRAME(0);
            return;
        }
        return;
    }
}
