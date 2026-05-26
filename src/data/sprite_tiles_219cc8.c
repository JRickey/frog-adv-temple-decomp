#include "macros.h"
#include "types.h"

/* Sprite-tile pixel pool at 0x08219cc8..0x0821ecc8 (4 x 5 KiB / 20 KiB).
 *
 * Four sibling 4bpp tile pixel blocks, each 0x1400 bytes = 5120 bytes =
 * 160 tiles of 8x8 4bpp pixels (32 bytes per tile). Referenced by indices
 * [47..50] of sVramTilePtrTable in sprite_dma_records.c:
 *
 *   [47] 0x08219cc8 -> sSpriteTiles_219CC8  (160 tiles)
 *   [48] 0x0821b0c8 -> sSpriteTiles_21B0C8  (160 tiles)
 *   [49] 0x0821c4c8 -> sSpriteTiles_21C4C8  (160 tiles)
 *   [50] 0x0821d8c8 -> sSpriteTiles_21D8C8  (160 tiles)
 *
 * Same shape as the 3 KiB variants in sprite_tiles_215778.c but with
 * a larger per-asset tile count (160 vs 96). The byte content of the
 * first ~32 bytes of each 0x1400 slot is nearly identical across all
 * four entries (a 0x77/0x66/0xff outlined sprite-head shape), strongly
 * suggesting these are per-direction or per-frame variants of one
 * larger animated character. Semantic naming awaits the sprite frame
 * descriptor consumer in 0x0801xxxx.
 *
 * The 0x950-byte gap between this pool’s start (0x08219cc8) and the
 * previous pool’s stride-end (0x08219378) holds residual data of
 * unknown shape -- left in the surrounding text_0x08219378.s blob for
 * future inspection.
 */

const u8 sSpriteTiles_219CC8[5120] = INCBIN_U8("data/sprite/sprite_tiles_219cc8/tiles_219cc8.bin");
const u8 sSpriteTiles_21B0C8[5120] = INCBIN_U8("data/sprite/sprite_tiles_219cc8/tiles_21b0c8.bin");
const u8 sSpriteTiles_21C4C8[5120] = INCBIN_U8("data/sprite/sprite_tiles_219cc8/tiles_21c4c8.bin");
const u8 sSpriteTiles_21D8C8[5120] = INCBIN_U8("data/sprite/sprite_tiles_219cc8/tiles_21d8c8.bin");
