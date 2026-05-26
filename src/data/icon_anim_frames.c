#include "macros.h"
#include "types.h"

/* Animated icon graphics cluster at 0x08173000..0x08173ab8.
 *
 * Surfaced by tools/agent/refcount_pool_loads.py as a 7-anchor data
 * cluster (refs >=2) consumed by the still-asm graphics routines
 * around [0x080166ae..0x080167d0] and [0x080168f4..0x08017292].
 *
 * Layout — five { palette[16] u16, tiles[80] u16 } records preceded
 * by a standalone palette and an unreferenced multi-frame block:
 *
 *   0x08173000  sIconTilesHeader_173000  (56 B, unreferenced)
 *   0x08173038  sIconPalette_173038       (32 B, palette; 2 DMA srcs)
 *   0x08173058  sIconUnrefAnimData_173058 (1696 B, structured but no
 *                                          direct pool refs found;
 *                                          likely accessed through a
 *                                          pointer table still in the
 *                                          asm region — promote in a
 *                                          later pass)
 *   0x081736f8  sIconAnimFrames           (5 frames x 192 B = 960 B)
 *
 * Frame indexing (consumer at 0x080166ac..0x08016806):
 *   The "base" frame at index 0 (palette 0x081739f8, tiles 0x08173a18)
 *   is loaded unconditionally as prelude; the function then reads a
 *   state byte at *(u8 *)(g_global + 0x33) and switches:
 *     state 0  -> frame 1  (palette 0x081737b8, tiles 0x081737d8)
 *     state 1  -> frame 4  (palette 0x08173938, tiles 0x08173958)
 *     state 2  -> frame 3  (palette 0x08173878, tiles 0x08173898)
 *     state 3  -> frame 2  (palette 0x081736f8, tiles 0x08173718)
 *   Each frame DMA-loads 32 B of palette to PAL_RAM @ 0x05000180 and
 *   160 B of tile bytes to VRAM @ 0x06008800 via DMA3. (The five frame
 *   pairs are laid out in ROM in the same address order as the cases
 *   read them: 0x081736f8 / 0x081737b8 / 0x08173878 / 0x08173938 /
 *   0x081739f8.)
 *
 * The standalone palette at 0x08173038 is uploaded to PAL_RAM @
 * 0x05000180 (the same destination) by an earlier code path at
 * 0x080168f4 / 0x08017292 — looks like the "neutral" palette before
 * the state-driven animator overrides it.
 *
 * TODO: confirm purpose and rename once the consuming routines around
 *   [0x080166ac, 0x08017292] land in C. Rename sIcon* placeholders
 *   to the in-game widget name they belong to once identified.
 *   The unreferenced sIconUnrefAnimData_173058 block contains a
 *   repeating 0x0000deff... 0x00bbbb00 record structure; it almost
 *   certainly feeds the same widget through a higher-level frame
 *   table that has not yet been found via pool-load scanning.
 */

/* clang-format off */

const u32 sIconTilesHeader_173000[14] = INCBIN_U32("data/ui/icon_tiles_header_173000.bin");

const u16 sIconPalette_173038[16] = INCBIN_U16("data/ui/icon_palette_173038.bin");

const u32 sIconUnrefAnimData_173058[424] = INCBIN_U32("data/ui/icon_unref_anim_data_173058.bin");

const u16 sIconAnimFrames[5 * 96] = INCBIN_U16("data/ui/icon_anim_frames.bin");

/* clang-format on */
