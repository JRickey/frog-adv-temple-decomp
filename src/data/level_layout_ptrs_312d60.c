#include "macros.h"
#include "types.h"

/* Five pointer-array dispatchers + tail sentinel at
 * [0x08312d60..0x08312e94).
 *
 * Five contiguous pointer arrays, each indexed directly by a u8 loop
 * variable in a consumer at [0x08023xxx, 0x08024xxx]. All point back
 * into the preceding [0x08312000..0x08312c20) backing-store region
 * (still in asm) using the same {u16 a, u16 b, u32 count} + 8-byte
 * record sub-table layout documented in src/data/level_layout.c.
 *
 *   sLevelLayoutPtrs_312D60 (2 pool-load refs from 0x08023..., 0x08024...)
 *     8-entry pointer array, sub-tables at [0x08312288..0x083123b8)
 *     (stride 0x30/0x28 mix).
 *
 *   sLevelLayoutPtrs_312D80 (2 pool-load refs from 0x08023b5e, 0x0802439a)
 *     10-entry pointer array. Both consumers iterate r4/r5 = 0..9 and
 *     call sub-table walker 0x080219bc. Sub-tables at
 *     [0x083123b8..0x083124f8).
 *
 *   sLevelLayoutPtrs_312DA8 (2 pool-load refs from 0x080240a0, 0x080240e4)
 *     11-entry pointer array. Consumers loop r4 = 0..10. Sub-tables
 *     at [0x083124f8..0x08312680) (variable stride: 0x28/0x20 mix
 *     reflecting variable record counts).
 *
 *   sLevelLayoutPtrs_312DD4 (2 pool-load refs from 0x080235cc, 0x0802413e)
 *     38-entry pointer array -- the widest in this cluster. Consumer
 *     at 0x080235cc iterates r4 = 0..0x25 calling sub-table walker
 *     0x080219bc with `i + 0x33` as the second arg (state ID). Sub-
 *     tables at [0x08312680..0x08312ae0), each 32 B (header + 3
 *     records of 8 B).
 *
 *   sLevelLayoutPtrs_312E6C (2 pool-load refs from 0x0802418c, 0x080241d0)
 *     6-entry pointer array. Consumer at 0x0802418c iterates r4 = 0..5
 *     with `i + 0x59` as the state arg. Sub-tables at
 *     [0x08312ae0..0x08312bf0).
 *
 *   sLevelLayoutSentinel_312E84
 *     Four-word 0xffffffff tail marking the end of this cluster --
 *     the next data block at 0x08312e94 starts with a fresh
 *     {u32 count, u32 0} header. Kept as a typed sentinel rather than
 *     dropped so the byte range is owned by a named symbol.
 *
 * TODO: confirm the per-array semantic role once the 0x08023xxx and
 * 0x08024xxx consumers land in C. The `+ 0x33`, `+ 0x59`, `+ 0x0A`,
 * `+ 0x28` second-arg offsets passed to the sub-table walker look
 * like base state IDs distinguishing the five dispatchers. */

const u32 sLevelLayoutPtrs_312D60[8] = INCBIN_U32("data/level/layout_ptrs_312d60.bin");
const u32 sLevelLayoutPtrs_312D80[10] = INCBIN_U32("data/level/layout_ptrs_312d80.bin");
const u32 sLevelLayoutPtrs_312DA8[11] = INCBIN_U32("data/level/layout_ptrs_312da8.bin");
const u32 sLevelLayoutPtrs_312DD4[38] = INCBIN_U32("data/level/layout_ptrs_312dd4.bin");
const u32 sLevelLayoutPtrs_312E6C[6] = INCBIN_U32("data/level/layout_ptrs_312e6c.bin");
const u32 sLevelLayoutSentinel_312E84[4] = INCBIN_U32("data/level/layout_sentinel_312e84.bin");
