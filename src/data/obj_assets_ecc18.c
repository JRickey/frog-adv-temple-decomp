#include "macros.h"
#include "types.h"

/* OBJ asset triple at 0x081ecc18..0x081ece58 (576 B).
 *
 * Three pool-load anchors surfaced together by refcount_pool_loads.py
 * (--range 0x081e0000 0x081f0000 --pending-only), all consumed by a
 * single 4-record DMA install in the function spanning 0x08018d78.
 * The dispatcher writes four 12-byte {src, dst, cnt} records into the
 * DMA queue at 0x030054a0; the first three records cover this
 * cluster, the fourth pulls a separate 2 KiB char-tile block from
 * 0x083080c0 into 0x06010420:
 *
 *   1. SAD = sObjPalette_ECC18    -> DAD = 0x05000200 (OBJ palette block 1)
 *      CNT = 0x80000010 (DMA_ENABLE | 0x10 halfwords = 32 B; full block)
 *   2. SAD = sObjPalette_ECE38    -> DAD = 0x05000220 (OBJ palette block 2)
 *      CNT = 0x80000010 (32 B; full block)
 *   3. SAD = sObjCharTiles_ECC38  -> DAD = 0x06010020 (charblock 4,
 *      tile slot 1) -- the 4-tile-wide tile slot 0 is left untouched.
 *      CNT = 0x80000100 (DMA_ENABLE | 0x100 halfwords = 512 B = 16 4bpp
 *      tiles); full block.
 *
 * Layout note: the palette+tiles+palette interleave (32 + 512 + 32)
 * is unusual -- most screen-install clusters group palettes together.
 * Best guess is that the cluster was built by concatenating two
 * 4bpp sprite frames, each with its own 16-color palette, where the
 * second frame’s palette wraps to follow its tile body. Confirmed
 * stable as a single 576-byte run: zero-padded before 0x081ecc18
 * and after 0x081ece58.
 *
 * TODO: rename palette/char-tile symbols to something semantic once
 * the owning subsystem (the function containing 0x08018d78) lands in
 * C. The 4-record DMA install layout suggests a small status-bar or
 * UI sprite set rather than a full character-animation frame.
 */

const u16 sObjPalette_ECC18[16] = INCBIN_U16("data/sprite/obj_assets_ecc18/palette0.bin");
const u8 sObjCharTiles_ECC38[512] = INCBIN_U8("data/sprite/obj_assets_ecc18/char_tiles.bin");
const u16 sObjPalette_ECE38[16] = INCBIN_U16("data/sprite/obj_assets_ecc18/palette1.bin");
