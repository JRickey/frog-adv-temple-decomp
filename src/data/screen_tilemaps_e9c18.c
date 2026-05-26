#include "macros.h"
#include "types.h"

/* Sibling BG tilemaps at 0x081e9c18..0x081eac18 (2 x 2 KiB).
 *
 * Selected by the function at 0x0801e738 (Init1-style screen install
 * still in asm/disasm_0x0801e28c.s). The default source pointer is
 * sScreenTilemap_E9C18; when the IWRAM mode word at gUnk_030034b0 == 3
 * the alternate sScreenTilemap_EA418 is substituted. Both go through
 * the same DMA3 triple:
 *
 *   REG_DMA3SAD = sScreenTilemap_E9C18 or sScreenTilemap_EA418
 *   REG_DMA3DAD = 0x0600e800   (VRAM screenblock 29)
 *   REG_DMA3CNT = 0x80000400   (DMA_ENABLE | 0x400 halfwords = 2 KiB)
 *
 * Content: sparse 32x32 halfword tilemap. Most non-zero entries reuse
 * two tile ids (0x093c = tile 316 with vflip, 0x0132 = tile 306) as
 * 17-cell-wide stripes on rows 2..17 -- the same "low-detail status
 * backdrop" shape seen in sBgTilemap_E6C18 (its near neighbour, also
 * destined for screenblock 29). The two tilemaps differ in 64 cells,
 * consistent with a localized region (probably a logo or HUD label
 * swap) rather than a wholesale layout change.
 *
 * Sibling-cluster scout: refcount_pool_loads.py --range 0x081e0000
 * 0x081f0000 also surfaces 0x081e5418, 0x081e5c18, and the offset
 * table at 0x08308f84 lists 0x081e9418, 0x081eac18, 0x081eb418,
 * 0x081ebc18, 0x081ec418 -- five more 2 KiB tilemap slots in the
 * same window, likely the rest of the screenblock-29 variant pool.
 * Deferred to a future pass.
 *
 * TODO: rename E9C18 -> sScreenTilemap_<purpose>_default and EA418 ->
 * sScreenTilemap_<purpose>_mode3 once gUnk_030034b0 gets a semantic
 * name (looks like a language or difficulty selector based on the
 * "cmp #3" gate).
 */

const u16 sScreenTilemap_E9C18[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e9c18/tilemap_default.bin");
const u16 sScreenTilemap_EA418[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e9c18/tilemap_mode3.bin");
