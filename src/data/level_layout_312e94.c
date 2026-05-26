#include "macros.h"
#include "types.h"

/* Three (backing-store + pointer-array) clusters at
 * [0x08312e94..0x08314a68).
 *
 * Continues the multi-tier level-layout dispatch pattern documented in
 * src/data/level_layout.c. Each cluster comprises a backing store of
 * sub-tables sharing the {u8 count, _x3, u32 _} 8-byte header + count
 * 8-byte records convention, followed by a pointer array that
 * dispatches them. Boundaries are marked by runs of 0xffffffff
 * sentinels at the tail of each pointer array.
 *
 * --- Cluster A: [0x08312e94..0x08313360) ---
 *
 *   sLevelLayoutData_312E94 (294 u32s = 1176 B)
 *     Backing store starting with a 9-entry `{u32 count, u32 0}` index
 *     manifest at 0x08312e94 (counts: 0x11, 0x12, 0x10, 0x21, 0x14,
 *     0x3d, 0x61, 0x60, 0x36). Followed by mixed-count sub-tables.
 *     Interior anchors (pool-loaded by consumers in
 *     [0x080247xx..0x08024axx]):
 *       0x08312edc, 0x08312eec, 0x08312fe4, 0x08313014, 0x0831326c
 *
 *   sLevelLayoutPtrs_31332C (13 u32s = 52 B, 11 ptrs + 2 sentinels)
 *     Dispatches 11 sub-tables in sLevelLayoutData_312E94. Consumers
 *     in [0x0802489x..0x080249xx] load interior windows --
 *     0x0831332c (entry 0), 0x08313338 (entry 3), 0x08313344 (entry 6),
 *     0x08313348 (entry 7).
 *
 * --- Cluster B: [0x08313360..0x08314068) ---
 *
 *   sLevelLayoutData_313360 (774 u32s = 3096 B)
 *     Backing store opening with another 9-entry index manifest
 *     (counts: 0x64, 0x11, 0x12, 0x10, 0x21, 0x61, 0x60, 0x28, 0x01).
 *     The "0x64" leading count distinguishes this cluster from A’s
 *     0x11 leader -- likely a per-mode selector. Interior anchors at
 *     0x083133a0, 0x083133b0, 0x083133d0, 0x083134d0, 0x08313508,
 *     0x08313528 (pool-loaded by consumers in
 *     [0x08025xxx..0x080254xx]).
 *
 *   sLevelLayoutPtrs_313F78 (60 u32s = 240 B, 56 ptrs + 4 sentinels)
 *     Dispatches the 56 sub-tables in sLevelLayoutData_313360.
 *     Consumers in [0x08025xxx] index via multiple interior anchor
 *     windows -- 0x08313f88 (entry 4), 0x08313fc4 (entry 19),
 *     0x08313fec (entry 29), 0x08314004 (entry 35), 0x08314014
 *     (entry 39), 0x08314034 (entry 47), 0x08314044 (entry 51),
 *     0x08314048 (entry 52).
 *
 * --- Cluster C: [0x08314068..0x08314a68) ---
 *
 *   sLevelLayoutData_314068 (640 u32s = 2560 B)
 *     Pure backing store -- the dispatching pointer array lives
 *     downstream at 0x08314a68 (sLevelLayoutPtrs_314A68, in
 *     src/data/level_layout_ptrs_314a68.c). Opens with a 3-entry
 *     manifest {0x39, 0x45, 0x2e} followed by sub-tables. Interior
 *     anchors at 0x083140a8, 0x083140b8, 0x083140e8, 0x083141e8,
 *     0x08314208, 0x08314828 (pool-loaded by consumers in
 *     [0x08025xxx..0x08026xxx]).
 *
 * TODO: confirm field semantics + sub-table boundaries once
 * [0x08024xxx..0x08026xxx] consumers land in C. Until then the
 * backing stores ship as a single typed u32[] each and consumers
 * index via the pointer arrays. Same access pattern as
 * sLevelLayoutPtrs in src/data/level_layout.c. */

const u32 sLevelLayoutData_312E94[294] = INCBIN_U32("data/level/layout_312e94.bin");
const u32 sLevelLayoutPtrs_31332C[13] = INCBIN_U32("data/level/layout_ptrs_31332c.bin");
const u32 sLevelLayoutData_313360[774] = INCBIN_U32("data/level/layout_313360.bin");
const u32 sLevelLayoutPtrs_313F78[60] = INCBIN_U32("data/level/layout_ptrs_313f78.bin");
const u32 sLevelLayoutData_314068[640] = INCBIN_U32("data/level/layout_314068.bin");
