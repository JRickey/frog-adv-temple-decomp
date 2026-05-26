#include "macros.h"
#include "types.h"

/* Sprite-tile pixel pool at 0x08215778..0x08219378 (5 x 3 KiB / 15 KiB).
 *
 * Five sibling 4bpp tile pixel blocks, each 0xc00 bytes = 3072 bytes =
 * 96 tiles of 8x8 4bpp pixels (32 bytes per tile). Referenced by indices
 * [42..46] of sVramTilePtrTable in sprite_dma_records.c:
 *
 *   [42] 0x08215778 -> sSpriteTiles_215778  (96 tiles)
 *   [43] 0x08216378 -> sSpriteTiles_216378  (96 tiles)
 *   [44] 0x08216f78 -> sSpriteTiles_216F78  (96 tiles)
 *   [45] 0x08217b78 -> sSpriteTiles_217B78  (96 tiles)
 *   [46] 0x08218778 -> sSpriteTiles_218778  (96 tiles)
 *
 * The uniform 3 KiB stride and the 4bpp pixel content (nibble palette
 * indices, sparse 0xff/0xfd/0x66 patterns typical of outlined character
 * sprites with white-fill and brown-shadow palette entries) is the same
 * shape as the sVramTilePtrTable entries in 0x081dxxxx -- this is the
 * forward 0x0821xxxx slice of the same sprite-tile system. Indexing
 * happens via the sprite frame descriptors in sSpriteFramePtrs_08110;
 * once those are decoded the variants will get semantic names
 * (likely per-direction or per-frame of one animated character).
 */

const u8 sSpriteTiles_215778[3072] = INCBIN_U8("data/sprite/sprite_tiles_215778/tiles_215778.bin");
const u8 sSpriteTiles_216378[3072] = INCBIN_U8("data/sprite/sprite_tiles_215778/tiles_216378.bin");
const u8 sSpriteTiles_216F78[3072] = INCBIN_U8("data/sprite/sprite_tiles_215778/tiles_216f78.bin");
const u8 sSpriteTiles_217B78[3072] = INCBIN_U8("data/sprite/sprite_tiles_215778/tiles_217b78.bin");
const u8 sSpriteTiles_218778[3072] = INCBIN_U8("data/sprite/sprite_tiles_215778/tiles_218778.bin");
