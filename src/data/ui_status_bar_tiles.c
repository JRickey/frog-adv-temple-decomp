#include "macros.h"
#include "types.h"

/* Tile-index data for sFrogStatusBarFrames (src/data/ui_status_bar.c).
 *
 * 66 u16 BG-tilemap entries at 0x080e3a30 — every ptr field in
 * sFrogStatusBarFrames[0..24] resolves into this 132-byte block.
 * Lives in its own file because a 732-byte run of unrelated graphics
 * sits between sFrogStatusBarFrames (ends 0x080e3754) and this table
 * (starts 0x080e3a30). See the comment block in ui_status_bar.c for
 * the full field semantics and consumer trace. */

const u16 sFrogStatusBarTileData[66] = INCBIN_U16("data/ui/status_bar_tile_data.bin");
