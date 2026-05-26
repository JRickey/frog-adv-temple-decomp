#include "macros.h"
#include "types.h"

/* Screen-graphics resource block at 0x081d8b98..0x081e4c18 (36480 B).
 *
 * Four ROM anchors surfaced together by the pool-load scan
 * (refcount_pool_loads.py --pending-only --data-only --threshold 3):
 *
 *   0x081d8b98 - 0x081d9398   (2048 B)   tilemap (screenblock 29)
 *   0x081dab98 - 0x081dad98   ( 512 B)   16-bit palette
 *   0x081dad98 - 0x081e4418   (38528 B)  4bpp char tiles (charblock 0)
 *   0x081e4418 - 0x081e4c18   (2048 B)   tilemap (screenblock 28)
 *
 * All four are consumed together by a trio of sibling routines at
 * 0x0801EED4 (3 callsites), 0x0801F418, and 0x0801FDB0 (still in
 * asm/text/text_0x0801a614.s). Each routine performs the same
 * four-stage screen install via DMA3:
 *
 *   1. SAD = sScreenPaletteDAB98   -> DAD = 0x05000000 (BG palette RAM)
 *      CNT = 0x80000100   (DMA_ENABLE | 0x100 halfwords = 512 B)
 *   2. SAD = sScreenCharTilesDAD98 -> DAD = 0x06000000 (VRAM charblock 0)
 *      CNT = 0x80004000   (DMA_ENABLE | 0x4000 halfwords = 32768 B);
 *      the table itself is 0x9680 B and the DMA copies only the first
 *      0x8000 B (charblock 0 capacity) -- the remaining 0x1680 B of
 *      tile bytes are loaded via a different code path or simply held
 *      in ROM as overflow tiles addressable through a different base.
 *   3. SAD = sScreenTilemapE4418   -> DAD = 0x0600e000 (screenblock 28)
 *      CNT = 0x80000400   (DMA_ENABLE | 0x400 halfwords = 2048 B)
 *   4. SAD = sScreenTilemapD8B98   -> DAD = 0x0600e800 (screenblock 29)
 *      CNT = 0x80000400   (2048 B; tilemap #2 covers a second BG layer)
 *
 * The 0x1800 B between the screenblock-29 tilemap and the palette is
 * not DMAed by these consumers and has no pool-load references anywhere
 * in [0x08000000, 0x08036000). Its bytes look like 4bpp pixel data /
 * tilemap halfwords, suggesting it belongs to a sibling subsystem that
 * accesses it through a pointer table still buried in the asm region.
 * Kept as a typed buffer so the byte layout stays stable; promote once
 * a consumer surfaces.
 *
 * TODO: confirm purpose of sScreenAuxBlock_D9398 once a referencing
 * function lands in C. Likely candidates: an OAM tile-stream for the
 * matching sprite set, or a secondary tilemap loaded by a different
 * dispatcher.
 */

const u16 sScreenTilemapD8B98[1024] = INCBIN_U16("data/sprite/screen_d8b98/tilemap_screenblock29.bin");
const u8 sScreenAuxBlock_D9398[6144] = INCBIN_U8("data/sprite/screen_d8b98/aux_d9398.bin");
const u16 sScreenPaletteDAB98[256] = INCBIN_U16("data/sprite/screen_d8b98/palette.bin");
const u8 sScreenCharTilesDAD98[38528] = INCBIN_U8("data/sprite/screen_d8b98/char_tiles.bin");
const u16 sScreenTilemapE4418[1024] = INCBIN_U16("data/sprite/screen_d8b98/tilemap_screenblock28.bin");
