#include "macros.h"
#include "types.h"

/* Screenblock-29 source tilemap cluster at 0x081e7418..0x081e9418 (4 x 2 KiB).
 *
 * sVramTilePtrTable slots [33..36], ordered here by ROM address (which
 * means table index 34 lands before table index 33 -- the table is not
 * strictly address-ordered):
 *
 *   0x081e7418  sScreenTilemap_E7418   (slot [34])
 *   0x081e7c18  sScreenTilemap_E7C18   (slot [33])
 *   0x081e8418  sScreenTilemap_E8418   (slot [35])
 *   0x081e8c18  sScreenTilemap_E8C18   (slot [36])
 *
 * Sibling of slot [32] (screen_tilemaps_e6418.c) and slots [37..41]
 * (screen_tilemaps_e9418.c); see screen_tilemaps_e9418.c for the full
 * family context (DMA3 triple, screenblock-29 destination,
 * sparse-stripe content shape).
 *
 * The four tilemaps share the same sparse 32x32 layout as the rest of
 * the family -- 17-cell-wide stripes on rows 2..17 using sequential
 * tile ids, zero elsewhere. The tile-id base differs per slot
 * (0x5141..0x52b2 across these four), which is consistent with the
 * "variant swap for difficulty / language modes" hypothesis from
 * screen_tilemaps_e9418.c.
 *
 * TODO: rename each variant to sScreenTilemap_<purpose> together with
 * the rest of the family once the sVramTilePtrTable consumer surfaces.
 */

const u16 sScreenTilemap_E7418[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e7418/tilemap_slot34.bin");
const u16 sScreenTilemap_E7C18[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e7418/tilemap_slot33.bin");
const u16 sScreenTilemap_E8418[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e7418/tilemap_slot35.bin");
const u16 sScreenTilemap_E8C18[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e7418/tilemap_slot36.bin");
