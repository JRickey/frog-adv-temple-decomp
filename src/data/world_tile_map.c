#include "macros.h"
#include "types.h"

/* World / level tile-type byte map at 0x081be810..0x081bee64.
 *
 * 1620 bytes (one logical grid worth of single-byte tile-type codes).
 * Single pool-load callsite at 0x08020384 (a still-asm routine in the
 * world-render cluster), with value 0x081be810 loaded as the base of a
 * byte-indexed scan.
 *
 * Byte values observed: 0x00, 0x01, 0x02, 0x04, 0x08, 0xfe, 0xff. The
 * sentinels 0xfe and 0xff appear at row breaks / region terminators; the
 * remaining values 0x01/0x02/0x04/0x08 are 4 mutually-exclusive tile
 * classes (probably "walkable", "obstacle", "pit", "entity-spawn") — a
 * one-byte-per-tile collision / classification map for the overworld /
 * world-select screen.
 *
 * Likely shape: a row-major grid of 0x654 / row_stride entries. Without
 * the consumer at 0x08020384 lifted to C, the exact row stride is
 * uncertain, so this is shipped as a flat u8 buffer. Promote to a
 * 2-D array once the renderer lands.
 */

const u8 sWorldTileTypeMap[1620] = INCBIN_U8("data/ui/world_tile_type_map.bin");
