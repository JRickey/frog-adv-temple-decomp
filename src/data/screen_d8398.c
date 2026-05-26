#include "macros.h"
#include "types.h"

/* Screenblock-30 source tilemap at 0x081d8398..0x081d8b98 (2048 B, 1024 halfwords).
 *
 * 32x32 BG tilemap (a full screenblock). Three consumers at 0x0801f270,
 * 0x0801f714, 0x0801f948 each load the base pointer and call the tile-blit
 * helper at 0x000196ec with mode=2 (screenblock 30 -> 0x0600f000). The
 * helper reads a {x, y, w, h} record from r4, computes a per-row
 * (y * 32 + x) * 2 destination offset inside the screenblock, and DMA3-
 * copies `w` halfwords per row from this source. Source rows advance by
 * 0x40 bytes per row -- consistent with a 32-tile-wide source map.
 *
 * Contents: mostly zero halfwords with populated regions of palette-5
 * glyph tiles (0x51xx, 0x61xx, 0x71xx, 0x81xx) -- looks like a menu/HUD
 * template that gets blitted in pieces, not a clear-screen blank.
 *
 * Sibling to iter-18 screenblock-29 tilemap at 0x081d8b98; the pair
 * makes up two BG-layer source tilemaps loaded by adjacent code in the
 * still-undecompiled dispatcher near sub_0801f1e0.
 */

const u16 sScreenTilemapD8398[1024] = INCBIN_U16("data/sprite/screen_d8398/tilemap_screenblock30.bin");
