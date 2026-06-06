#include "macros.h"
#include "types.h"

/* --- UpdateBgTilemapFrames: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
typedef struct {
    u16 x;
    u16 y;
    u16 w;
    u16 h;
    const u16 *tile_data;
} FrameDescriptor;

extern const FrameDescriptor *const sSpriteAnimFrameSet_06824[];

/* Per-slot tile blitter into OBJ-VRAM screenblock 31 (0x0600F800). The five
 * control bytes at 0x03005370 (stride 4, written by Scene_LoadBg) each select
 * a blit mode for the matching FrameDescriptor record; bit 0x80 marks a slot
 * already drawn. Records come from the 0x080C1xxx descriptor array selected by
 * gIwram_34B0._data. After the loop, an empty handshake byte at 0x03005328
 * triggers a full VRAM clear + StatusBar_Update().
 *
 * Mode 1: blit verbatim.
 * Mode 2: blit each tile masked with 0xEFFF (clear the palette-bank-high bit).
 * Mode 3: gated on (gGameStuff._unk04 & 7) == 0; blits verbatim, and when
 *         (gGameStuff._unk04 & 0xF) == 0 re-stores the masked tile.
 * Mode 9: fill the rect with the blank tile 0xF039, then reset the slot byte.
 *
 * Matching note: the row advance to the record's y origin is a `dst += 32`
 * count-up loop (not a `y << 5` shift), and the per-row x indent is re-added
 * inside the outer loop so the trailing skip is `32 - x - h`.
 */
void UpdateBgTilemapFrames(void)
{
    const FrameDescriptor *records;
    u8 idx;

    records = sSpriteAnimFrameSet_06824[gIwram_34B0._data];

    for (idx = 0; idx <= 4; idx++) {
        u8 ctrl = ((u8 *)0x03005370)[idx * 4];

        if (ctrl & 0x80) {
            continue;
        }

        switch (ctrl & 0xF) {
        case 1: {
            const u16 *src = records[idx].tile_data;
            u16 *dst = (u16 *)0x0600F800;
            u16 row;
            u16 n;

            for (n = 0; n < records[idx].y; n++) {
                dst += 32;
            }
            for (row = 0; row < records[idx].w; row++) {
                u16 col;
                dst += records[idx].x;
                for (col = 0; col < records[idx].h; col++) {
                    *dst++ = *src++;
                }
                dst += 32 - records[idx].x - records[idx].h;
            }
            ((u8 *)0x03005370)[idx * 4] |= 0x80;
            break;
        }
        case 2: {
            const u16 *src = records[idx].tile_data;
            u16 *dst = (u16 *)0x0600F800;
            u16 row;
            u16 n;

            for (n = 0; n < records[idx].y; n++) {
                dst += 32;
            }
            for (row = 0; row < records[idx].w; row++) {
                u16 col;
                dst += records[idx].x;
                for (col = 0; col < records[idx].h; col++) {
                    *dst++ = *src++ & 0xEFFF;
                }
                dst += 32 - records[idx].x - records[idx].h;
            }
            ((u8 *)0x03005370)[idx * 4] |= 0x80;
            break;
        }
        case 3: {
            const u16 *src;
            u16 *dst;
            u16 row;
            u16 n;

            if ((gGameStuff._unk04 & 7) != 0) {
                break;
            }

            src = records[idx].tile_data;
            dst = (u16 *)0x0600F800;
            for (n = 0; n < records[idx].y; n++) {
                dst += 32;
            }
            for (row = 0; row < records[idx].w; row++) {
                u16 col;
                u32 lowMode = gGameStuff._unk04 & 0xF;
                u16 mask = 0xEFFF;
                dst += records[idx].x;
                for (col = 0; col < records[idx].h; col++) {
                    u16 tile = *src++;
                    *dst = tile;
                    if (lowMode == 0) {
                        *dst = tile & mask;
                    }
                    dst++;
                }
                dst += 32 - records[idx].x - records[idx].h;
            }
            break;
        }
        case 9: {
            u16 *dst = (u16 *)0x0600F800;
            u16 row;
            u16 n;

            for (n = 0; n < records[idx].y; n++) {
                dst += 32;
            }
            for (row = 0; row < records[idx].w; row++) {
                u16 col;
                dst += records[idx].x;
                for (col = 0; col < records[idx].h; col++) {
                    *dst++ = 0xF039;
                }
                dst += 32 - records[idx].x - records[idx].h;
            }
            ((u8 *)0x03005370)[idx * 4] = 0;
            break;
        }
        default:
            break;
        }
    }

    if (*(u8 *)0x03005328 == 0) {
        vu16 seed;
        vu32 *dma;

        seed = 0;
        dma = (vu32 *)0x040000D4;
        dma[0] = (u32)&seed;
        dma[1] = 0x0600F800;
        dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
        (void)dma[2];

        StatusBar_Update();
    }
}
#else
NAKED void UpdateBgTilemapFrames(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0xe174, 0x348\n");
}
#endif /* NON_MATCHING */
