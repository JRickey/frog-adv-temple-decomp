#include "macros.h"
#include "types.h"

/* Level-layout sub-cluster filling [0x08310eb4..0x083112a8) -- the
 * immediate predecessors of the already-extracted
 * sLevelLayoutDispatch_3112A8.
 *
 * The cluster is three (sub-table backing + pointer-array) pairs, each
 * pair structured identically to sLevelLayoutDispatch_3112A8 and the
 * other sub-cluster pairs elsewhere in this region:
 *
 *   sLevelLayoutData_310EB4 / sLevelLayoutPtrs_311074
 *     14 sub-tables of 32 B each (header `{0x0302_0003, count=1}` plus
 *     3 records of 8 B), followed by a 14-entry pointer array. Pointer-
 *     array anchor 0x08311074 has 2 pool refs at 0x08022062 and
 *     0x08022804 -- a stride-0x04 indexed load (`r5 = ptrs_base;
 *     r0 = ptrs_base[i]; bl 0x080219bc` iteration helper). Records all
 *     share the high halfword 0x0459_xxxx; the low halfwords of the
 *     three records per sub-table consistently follow {010, 1b8, ffe0}
 *     stride 0x1ae -- looks like a fixed XY-offset triple repeated for
 *     14 indices (probably an animation/path stride row).
 *
 *   sLevelLayoutData_3110AC / sLevelLayoutPtrs_31118C
 *     7 sub-tables of 32 B each (header `{0x0302_0004, count=1}` plus
 *     3 records of 8 B), followed by a 7-entry pointer array. Pointer-
 *     array anchor 0x0831118C has 2 pool refs at 0x0802283E and
 *     0x080229F4. Records share high halfword 0x0473_xxxx; the per-
 *     sub-table varying low halfword cycles through 0x000a, 0x003c,
 *     0x0054, 0x00a7, 0x00bf, 0x00d7, 0x0107 (7 base offsets).
 *
 *   sLevelLayoutData_3111A8 / sLevelLayoutDispatch_3112A8 (existing)
 *     8 sub-tables of 32 B each (header `{0x0302_0002, count=1}` etc).
 *     These are the data rows dispatched by the already-extracted
 *     sLevelLayoutDispatch_3112A8 -- moving the backing store out of
 *     the raw blob and into typed C closes that pair.
 *
 * Sub-table iteration matches the level-layout convention documented
 * in src/data/level_layout.c: callee 0x080219bc loads `count` from
 * byte offset 0 of the table base, then walks `count` records of 8 B
 * starting at offset 8. The header byte at offset 1 distinguishes the
 * three pairs (3 / 4 / 2) but its consumer-side semantics are still
 * inferred indirectly.
 *
 * TODO: confirm record-field semantics + sub-cluster purpose once the
 * 0x08022xxx consumers land in C. Likely a per-scene/per-room asset
 * dispatch where the 14/7/8 split corresponds to fixed scene-state
 * counts. */

const u32 sLevelLayoutData_310EB4[112] = INCBIN_U32("data/level/layout_310eb4.bin");
const u32 sLevelLayoutPtrs_311074[14] = INCBIN_U32("data/level/layout_ptrs_311074.bin");
const u32 sLevelLayoutData_3110AC[56] = INCBIN_U32("data/level/layout_3110ac.bin");
const u32 sLevelLayoutPtrs_31118C[7] = INCBIN_U32("data/level/layout_ptrs_31118c.bin");
const u32 sLevelLayoutData_3111A8[64] = INCBIN_U32("data/level/layout_3111a8.bin");
