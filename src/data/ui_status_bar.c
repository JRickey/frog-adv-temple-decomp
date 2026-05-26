#include "macros.h"
#include "types.h"

/* UI status-bar rendering cluster at 0x080e3550 / 0x080e3628 / 0x080e3a30.
 *
 * Surfaced by tools/agent/refcount_pool_loads.py as the top pending
 * data-region cluster: 0x080e3628 with 25 pool-load references (the
 * heaviest data-region anchor), 0x080e3550 with 6 — both consumed by
 * the still-asm UI routines around [0x080169c0, 0x08017d80).
 *
 * --- 0x080e3550  sUiAssetSlots[54]  (u32) ---
 *
 * Sparse u32 pointer table — 54 slots, 0xD8 bytes. Non-zero slots hold
 * ROM addresses of palette / tile graphics assets, the rest are zero
 * padding. Consumers reach individual slots by computed offset from
 * the table base, not by linear index, so the table is effectively a
 * named struct with fields at fixed offsets.
 *
 * Observed slot population (from objdump of [0x080e3550, 0x080e3628)):
 *   +0x00..+0x1c   8 ptrs, terminated by zero at +0x20
 *   +0x24..+0x38   6 ptrs (group 2)
 *   +0x84..+0x88   2 ptrs
 *   +0x90..+0x94   2 ptrs
 *   +0x9c..+0xa0   2 ptrs
 *   +0xb4..+0xb8   2 ptrs
 *
 * Consumer at 0x08017af4 (the heaviest user, an asset-load routine):
 *   r6 = &sUiAssetSlots[0]
 *   [r6, #0]    = palette source (later DMA-copied to 0x05000000)
 *   [r6, #4]    = palette source (alt)
 *   [r6, #8]    = tile-data source (later DMA-copied to 0x06000000)
 *   [r6+0x84]   = secondary tile source
 *   [r6+0x88]   = secondary tile source
 *   [r6+0x90]   = tertiary tile source
 *   [r6+0x9c]   = quaternary tile source
 *
 * The pointers themselves span multiple ROM regions
 * (0x080c9ccc..0x081d1f58 etc), suggesting different asset categories
 * (compressed font, palette, BG-tile sheet, sprite-tile sheet) live in
 * different ROM zones and the slots aggregate them for UI initializers.
 *
 * --- 0x080e3628  sFrogStatusBarFrames[25]  (12-byte records) ---
 *
 * 25 sprite-frame descriptors, same layout as the sSpriteFrameDescriptors
 * table @ 0x080c1128 in entity_dispatch.c: { u16 x, u16 y, u16 w, u16 h,
 *  const u16 *tile_data }. (x, y) is the destination tile coordinate
 * in the BG tilemap, (w, h) the size in tiles, and tile_data is a
 * row-major u16 array of BG tilemap entries.
 *
 * Field semantics confirmed by walking the consumer at 0x080169c0:
 *   r2 = &sFrogStatusBarFrames[24]                  (a, b, c, d, ptr)
 *   r1 = ldrh [r2+0x120]                              y_tiles
 *   r0 = ldrh [r2+0x122]; r0 <<= 5                    x_tiles * 32 (BG row)
 *   r4 = ldr  [r2+0x128]                              tile_data ptr
 *   dst = bg_base + (y_tiles + x_tiles * 32) * 2
 *   for (row = 0; row < h; row++)
 *     for (col = 0; col < w; col++)
 *       *dst++ = *tile_data++;        // 16-bit tilemap entries
 *     dst += (32 - w) * 2;            // advance to next BG row
 *
 * All 25 ptr fields point into 0x080e3a30..0x080e3aae (the inline
 * tile-data block below). Records cluster into shape groups:
 *   [ 0]    3x3 frame  (the "full" status icon)
 *   [ 1- 7] 7x 2x2 frames (compass/heading variants)
 *   [ 8-13] 6x 1x1 frames (single-tile dots/markers)
 *   [14-23] 10x 2x1 frames (horizontal pairs)
 *   [24]    2x2 final frame
 *
 * This is the in-game "frog status indicator" tile layout —
 * a small HUD widget with an icon + heading arrow + status dots.
 *
 * --- 0x080e3a30  sFrogStatusBarTileData[66]  (u16) ---
 *
 * 132 bytes of u16 BG tilemap entries. Each entry encodes
 * { 10-bit tile index, 4-bit palette, 2 flip bits } per the GBA BG
 * tilemap format. Indexed indirectly via the ptr field of
 * sFrogStatusBarFrames records. Tile indices visible in the data
 * (0xe001..0xe009, 0xf00a..0xf022, 0xc040..0xc045, 0xe025..0xe036,
 * 0xe09b..0xe09e) suggest palette IDs 0xe and 0xc / 0xf — three
 * adjacent palette slots for the widget color states.
 *
 * The 0x080e3754..0x080e3a30 gap and the 0x080e3ab4..end run are
 * unrelated graphics data left in the upstream asm/text blob.
 *
 * TODO: confirm field semantics + rename once sub_080169c0 (the
 *   "draw status indicator" routine) and sub_08017af4 (the
 *   "initialize UI assets" routine) land in C. Until then the
 *   sUiAssetSlots field offsets are documented above but the
 *   struct keeps a flat u32[54] shape so the indices match the
 *   hardcoded offsets used by the consumers exactly.
 */

const u32 sUiAssetSlots[54] = INCBIN_U32("data/ui/asset_slots.bin");

const u32 sFrogStatusBarFrames[25 * 3] = INCBIN_U32("data/ui/status_bar_frames.bin");

/* sFrogStatusBarTileData[66] @ 0x080e3a30 lives in
 * src/data/ui_status_bar_tiles.c — the 732-byte gap between the
 * descriptors and the tile data is filled by unrelated graphics
 * data still in the asm/text/text_0x080e3754.s blob. */
