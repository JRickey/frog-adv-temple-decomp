#include "macros.h"
#include "types.h"

/* BG tilemap at 0x081e6c18..0x081e7418 (2048 B, 1024 entries).
 *
 * DMAed by the function containing the load site at 0x08017f0c into
 * VRAM screenblock 29 (0x0600e800). The control word is 0x80000400
 * (DMA_ENABLE | 0x400 halfwords), so the full 2 KiB block is copied.
 *
 * Content: a sparse 32x32 tilemap. Most non-zero entries are 0x0132 --
 * a single tile id with palette 0, used as repeated row fills with
 * 6-cell-wide stripes (idx 0..5 set, 6..15 zero, 16..21 set, ...).
 * The pattern matches a low-detail menu/status backdrop where most of
 * the screen is left blank and the active band is two short runs per
 * row.
 *
 * Sibling refcount-pool anchors in the same 0x081e0000 window have
 * consumers in [0x08017f0c, 0x08020180] and look like one logical
 * subsystem (probably a screen-install dispatcher), but each anchor
 * is loaded by a different function so they extract as separate
 * files. The OBJ asset triple at 0x081ecc18 lives in
 * src/data/obj_assets_ecc18.c.
 *
 * TODO: rename to sScreenTilemap_<purpose> once the owning subsystem
 * surfaces -- 0x0600e800 is the canonical screenblock used by most
 * "screen 1" installs, so this is probably the BG2 tilemap for one
 * of the menu screens.
 */

const u16 sBgTilemap_E6C18[1024] = INCBIN_U16("data/sprite/tilemap_e6c18/tilemap_screenblock29.bin");
