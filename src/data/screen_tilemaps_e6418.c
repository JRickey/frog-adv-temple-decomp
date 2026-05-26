#include "macros.h"
#include "types.h"

/* Screenblock-29 source tilemap at 0x081e6418..0x081e6c18 (1 x 2 KiB).
 *
 * sVramTilePtrTable slot [32]. First entry of the [32..36] sub-family
 * that precedes the existing screen_tilemaps_e9418 cluster ([37..41]).
 * Split from screen_tilemaps_e7418.c (slots [33..36]) because the
 * direct-loaded tilemap_e6c18 anchor sits between this slot and the
 * next one in ROM:
 *
 *   0x081e6418  sScreenTilemap_E6418   (slot [32], this file)
 *   0x081e6c18  sBgTilemap_E6C18       (tilemap_e6c18.c, literal-pool)
 *   0x081e7418  sScreenTilemap_E7418   (slot [34], screen_tilemaps_e7418.c)
 *   0x081e7c18  sScreenTilemap_E7C18   (slot [33])
 *   0x081e8418  sScreenTilemap_E8418   (slot [35])
 *   0x081e8c18  sScreenTilemap_E8C18   (slot [36])
 *   0x081e9418  sScreenTilemap_E9418   (slot [37], screen_tilemaps_e9418.c)
 *   ...                                (slots [38..41])
 *
 * All ten table-reached entries plus the two literal-pool variants
 * (E9C18 default, EA418 mode3) and the sBgTilemap_E6C18 anchor share
 * the same screenblock-29 destination and the same DMA3 triple emitted
 * by the function near 0x0801e738. See screen_tilemaps_e9418.c for the
 * full context.
 *
 * Content: sparse 32x32 halfword tilemap, same shape as the rest of
 * the family -- 17-cell-wide stripes on rows 2..17 using sequential
 * tile ids (0x5193..0x51b3 in this slot), zero elsewhere.
 *
 * TODO: rename to sScreenTilemap_<purpose> together with the rest of
 * the family once the sVramTilePtrTable consumer surfaces.
 */

const u16 sScreenTilemap_E6418[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e6418/tilemap_slot32.bin");
