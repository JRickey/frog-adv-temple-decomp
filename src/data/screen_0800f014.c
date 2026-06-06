#include "macros.h"
#include "types.h"

/* Screen-graphics resource block at 0x080f72c4..0x081004c4 (37312 B).
 *
 * Head half of the five-anchor cluster surfaced by the pool-load scan
 * (refcount_pool_loads.py --range 0x080f0000 0x081100ff). The trailing
 * BG1 char-tile bank lives in src/data/screen_08100cc4.c -- the two are
 * separated by a 0x800 B run of zero padding (asm/text/text_0x081004c4.s)
 * that is not DMA-copied by the consumer.
 *
 * Anchors here (4 tables):
 *
 *   0x080f72c4 - 0x080f74c4   (  512 B)   16-bit BG palette
 *   0x080f74c4 - 0x080f7cc4   ( 2048 B)   BG0 tilemap (screenblock 28)
 *   0x080f7cc4 - 0x080ffcc4   (32768 B)   4bpp char tiles (charblock 0)
 *   0x080ffcc4 - 0x081004c4   ( 2048 B)   BG1 tilemap (screenblock 29)
 *
 * All five tables (these four plus sScreenCharTilesBg1_100CC4) are
 * consumed by a single setup function at 0x0800f014 (still in raw blob
 * text_0x0800eff4) whose body packs five contiguous DMA3 stages between
 * 0x0800f018 and 0x0800f05c, sharing REG_DMA3 base 0x040000d4 in r0
 * across the whole sequence:
 *
 *   1. SAD = sScreenPalette_F72C4      -> DAD = 0x05000000 (BG palette RAM)
 *      CNT = 0x80000100   (DMA_ENABLE | 0x100 halfwords = 512 B)
 *   2. SAD = sScreenCharTilesBg0_F7CC4 -> DAD = 0x06000000 (charblock 0)
 *      CNT = 0x80004000   (DMA_ENABLE | 0x4000 halfwords = 32768 B,
 *      the full charblock)
 *   3. SAD = sScreenTilemapBg0_F74C4   -> DAD = 0x0600e000 (screenblock 28)
 *      CNT = 0x80000400   (DMA_ENABLE | 0x400 halfwords = 2048 B)
 *      Then REG_BG0CNT = 0x1c83 (charblock 0, screenblock 28, prio 3).
 *   4. SAD = sScreenCharTilesBg1_100CC4 -> DAD = 0x06008000 (charblock 1)
 *      CNT = 0x80002000   (DMA_ENABLE | 0x2000 halfwords = 16384 B)
 *   5. SAD = sScreenTilemapBg1_FFCC4   -> DAD = 0x0600e800 (screenblock 29)
 *      CNT = 0x80000400   (DMA_ENABLE | 0x400 halfwords = 2048 B)
 *      Then REG_BG1CNT = 0x1d8a and REG_BG2CNT = 0x1e89 (charblock 1,
 *      screenblocks 29/30, priorities 2/1), all BG scroll regs cleared,
 *      and a final pair of post-setup writes (REG_BLDCNT, REG_BLDALPHA).
 *
 * Sibling pattern to:
 *   - screen_d8b98 (iter-18): 4-anchor variant at 0x081d8b98.
 *   - screen_c578 (iter-23):  3-anchor variant at 0x0820c578.
 *   - screen_188edc (iter-24): single-tilemap variant at 0x08188edc.
 *
 * The 5-anchor variant here is the dual-BG (BG0+BG1) install: both
 * background layers get their own dedicated char tiles and tilemap,
 * which is consistent with the consumer also setting REG_BG2CNT (BG2
 * comes online via a sibling block whose anchor is not in the 1 MiB
 * scan window).
 *
 * TODO: rename InitScreenBgGraphics once its surrounding function-table entry
 * lands in C -- it is almost certainly a screen-install entry point
 * (title / world map / cutscene background, etc).
 */

const u16 sScreenPalette_F72C4[256] = INCBIN_U16("data/sprite/screen_0800f014/palette.bin");
const u16 sScreenTilemapBg0_F74C4[1024] = INCBIN_U16("data/sprite/screen_0800f014/tilemap_bg0_screenblock28.bin");
const u8 sScreenCharTilesBg0_F7CC4[32768] = INCBIN_U8("data/sprite/screen_0800f014/char_tiles_bg0_charblock0.bin");
const u16 sScreenTilemapBg1_FFCC4[1024] = INCBIN_U16("data/sprite/screen_0800f014/tilemap_bg1_screenblock29.bin");
