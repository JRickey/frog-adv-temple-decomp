#include "macros.h"
#include "types.h"

/* BG1 char-tile bank at 0x08100cc4..0x08104cc4 (16384 B, 4bpp).
 *
 * Tail half of the five-anchor screen-install cluster headed at
 * 0x080f72c4 (see src/data/screen_0800f014.c for the full DMA narrative).
 * Lives in a separate .c file because a 0x800 B zero-padded gap
 * (asm/text/text_0x081004c4.s) sits between the BG1 tilemap at 0x080ffcc4
 * and this BG1 char-tile bank -- the gap prevents a single contiguous
 * .rodata pull.
 *
 * Consumer at 0x0800f014, stage 4:
 *   SAD = sScreenCharTilesBg1_100CC4 -> DAD = 0x06008000 (charblock 1)
 *   CNT = 0x80002000  (DMA_ENABLE | 0x2000 halfwords = 16384 B)
 */

const u8 sScreenCharTilesBg1_100CC4[16384] = INCBIN_U8("data/sprite/screen_0800f014/char_tiles_bg1_charblock1.bin");
