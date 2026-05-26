#include "macros.h"
#include "types.h"

/* Screen-graphics resource cluster at 0x081fbd58..0x08204758 (35328 B).
 *
 * Sibling to the iter-18 screen_d8b98 and screen_c578 blocks; same
 * three-stage shape (BG palette + screenblock-28 tilemap + char-tile
 * bank) installed via DMA3 by a setup function in the still-asm
 * 0x0801xxxx region.
 *
 * Three ROM anchors surfaced together by the pool-load scan
 * (refcount_pool_loads.py --range 0x081f0000 0x08200000):
 *
 *   0x081fbd58 - 0x081fbf58  ( 512 B)  16-bit BG palette (256 entries)
 *   0x081fbf58 - 0x081fc758  (2048 B)  tilemap (screenblock 28)
 *   0x081fc758 - 0x08204758  (32768 B) 4bpp char tiles (charblock 0)
 *
 * All three are consumed by the screen-install dispatcher at 0x0801d268
 * (still in asm/text/text_0x0801a614.s). The DMA3 sequence is the
 * canonical sibling pattern:
 *
 *   1. SAD = sScreenCharTilesC758  -> DAD = 0x06000000 (VRAM charblock 0)
 *      CNT = 0x80004000   (DMA_ENABLE | 0x4000 halfwords = 32 KiB)
 *   2. SAD = sScreenPaletteBD58    -> DAD = 0x05000000 (BG palette RAM)
 *      CNT = 0x80000100   (DMA_ENABLE | 0x100 halfwords = 512 B)
 *   3. SAD = sScreenTilemapBF58    -> DAD = 0x0600e000 (screenblock 28)
 *      CNT = 0x80000400   (DMA_ENABLE | 0x400 halfwords = 2048 B)
 *
 * The dispatcher chains additional DMAs after stage 3 from sibling
 * pointers (mode-table entry at 0x080c1254 + r1*24, OBJ palette at
 * 0x083087c8 / 0x083087e8, BG2 install bytes at 0x0600b570). Those
 * sources belong to other clusters and are not part of this block.
 */

const u16 sScreenPaletteBD58[256] = INCBIN_U16("data/sprite/screen_bd58/palette.bin");
const u16 sScreenTilemapBF58[1024] = INCBIN_U16("data/sprite/screen_bd58/tilemap_screenblock28.bin");
const u8 sScreenCharTilesC758[32768] = INCBIN_U8("data/sprite/screen_bd58/char_tiles.bin");
