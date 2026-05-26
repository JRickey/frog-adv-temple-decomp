#include "macros.h"
#include "types.h"

/* Screen-graphics resource block at 0x0820c578..0x0820d778 (4608 B).
 *
 * Sibling cluster to the iter-18 screen-install block at 0x081d8b98; same
 * three-stage shape (BG palette + screenblock-28 tilemap + char-tile bank)
 * but for a different screen / menu.
 *
 * Four ROM anchors surfaced together by the pool-load scan
 * (refcount_pool_loads.py --range 0x0820c000 0x0820d800):
 *
 *   0x0820c578 - 0x0820cd78   (2048 B)   aux tile-pattern bank (4bpp pixels)
 *   0x0820cd78 - 0x0820cf78   ( 512 B)   16-bit BG palette (256 entries)
 *   0x0820cf78 - 0x0820d778   (2048 B)   tilemap (screenblock 28)
 *   0x0820d778 - ?            (~70 KB)   char tiles bank (deferred -- see below)
 *
 * The three bounded blocks are consumed by sub_0801e078 -- a single
 * dispatcher that DMA3-loads them in sequence on top of an earlier
 * char-tile install. Each DMA stage is the canonical sibling pattern:
 *
 *   1. SAD = sScreenCharTilesD778   -> DAD = 0x06000000 (charblock 0)
 *      CNT = 0x80004000   (DMA_ENABLE | 0x4000 halfwords = 32768 B);
 *      block extends past the 32 KB DMA (data trails off near 0x0821ee00,
 *      ~70 KB; left as raw INCBIN this pass because its end cannot be
 *      pinned tight without another anchor downstream).
 *   2. SAD = sScreenPaletteCD78     -> DAD = 0x05000000 (BG palette RAM)
 *      CNT = 0x80000100   (DMA_ENABLE | 0x100 halfwords = 512 B; full block)
 *   3. SAD = sScreenTilemapCF78     -> DAD = 0x0600e000 (screenblock 28)
 *      CNT = 0x80000400   (DMA_ENABLE | 0x400 halfwords = 2048 B; full block)
 *
 * The fourth block (sScreenAuxTilesC578) is used differently: its first
 * 8 bytes are DMA3-copied to VRAM 0x060000f8 (the last two rows of tile 7
 * inside charblock 0) by TWO sibling setup functions at 0x0801e28c and
 * the function containing 0x0801e5f8. Both DMAs use identical control
 * (0x80000004, 4 halfwords = 8 B). The remaining 2040 B of the block are
 * a long run of repeating 4bpp pixel data with occasional sentinel runs
 * (0x0000 / 0x00e0); structurally identical to char-tile pixel data but
 * not DMA-consumed by either function we have asm for. Likely an indexed
 * tile bank that another (still-asm) routine pulls into VRAM at offsets
 * other than 0x060000f8 -- kept whole so the byte layout stays stable.
 *
 * TODO: confirm the role of sScreenAuxTilesC578 tail bytes (offset 8..2047)
 * once a consumer for tile-bank offsets >=8 lands in C. Likely a second
 * dispatcher in the same 0x0801exxx region performs partial DMAs from
 * mid-block offsets.
 */

const u8 sScreenAuxTilesC578[2048] = INCBIN_U8("data/sprite/screen_c578/aux_tiles.bin");
const u16 sScreenPaletteCD78[256] = INCBIN_U16("data/sprite/screen_c578/palette.bin");
const u16 sScreenTilemapCF78[1024] = INCBIN_U16("data/sprite/screen_c578/tilemap_screenblock28.bin");
