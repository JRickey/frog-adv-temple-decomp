#include "macros.h"
#include "types.h"

/* (backing-store + pointer-array + backing-store) cluster at
 * [0x08315bb0..0x08316dc8).
 *
 * Continues the multi-tier level-layout dispatch pattern documented in
 * src/data/level_layout.c. This cluster sits between
 * sLevelLayoutDispatch_315A48 (upstream, 90-entry stage dispatcher)
 * and sLevelLayoutDispatch_316DC8 (downstream, 35-entry dispatcher).
 *
 * --- sLevelLayoutData_315BB0 (684 u32s = 2736 B) ---
 *
 *   Backing store opening with an 11-entry {u32 count, u32 0} index
 *   manifest at 0x08315bb0. Counts: 0x76, 0x64, 0x49, 0x2f, 0x37,
 *   0x4a, 0x3c, 0x47, 0x35, 0x7c, 0x01. The trailing 0x01 is the
 *   terminator -- same shape as the manifests in
 *   sLevelLayoutData_312E94 / _313360 / _314068 / _314B78.
 *
 *   Followed by mixed-count sub-tables sharing the {u16 a, u16 b,
 *   u32 c} 8-byte record convention. Interior anchors (pool-loaded
 *   by consumers in [0x0802705x..0x0802777x]):
 *     0x08315c00 -- loaded at 0x08027748, 0x08027774
 *                   (= manifest terminator entry; consumer scans
 *                   manifest until count==1)
 *     0x08315c10 -- loaded at 0x08027314, 0x0802733c
 *     0x08315d18 -- loaded at 0x08027360, 0x08027388
 *     0x08315d38 -- loaded at 0x080273ac, 0x080273d4
 *     0x08315e68 -- loaded at 0x08027058, 0x08027494
 *     0x083163f0 -- loaded at 0x08027116, 0x0802755c
 *
 * --- sLevelLayoutPtrs_316660 (46 u32s = 184 B, 44 ptrs + 2 sentinels) ---
 *
 *   Dispatches sub-tables in sLevelLayoutData_315BB0. Entries 0..31
 *   point into the local backing store in roughly ascending address
 *   order (0x08315d68..0x08316570). Entries 32..35 jump BACK to
 *   addresses earlier in the same backing store (0x08315dc8, 0x315df8,
 *   0x315e28, 0x315e48) -- the iter-12 "embedded mini ptr-array"
 *   pattern, here expressed as a non-monotonic tail in the main
 *   dispatcher rather than an interior insertion. Consumer indexes by
 *   semantic key, not address order. Entries 41..43 jump back into
 *   the middle of the array as well (0x08316458, 0x08316478,
 *   0x08316498).
 *
 *   Interior anchors:
 *     0x08316660 -- loaded at 0x080273fa, 0x0802745c (= entry 0)
 *     0x0831667c -- loaded at 0x080274c6, 0x08027514 (= entry 7)
 *     0x083166e0 -- loaded at 0x080275bc, 0x08027600 (= entry 32)
 *     0x083166f4 -- loaded at 0x08027640, 0x08027684 (= entry 37)
 *     0x08316704 -- loaded at 0x080276be, 0x08027700 (= entry 41)
 *
 *   Terminated by two 0xFFFFFFFF sentinels at [0x08316710, 0x08316718).
 *
 * --- sLevelLayoutData_316718 (428 u32s = 1712 B) ---
 *
 *   Second backing store opening with a 10-entry {u32 count, u32 0}
 *   index manifest at 0x08316718. Counts: 0x64, 0x61, 0x2f, 0x37,
 *   0x4a, 0x3c, 0x60, 0x35, 0x7c, 0x01. Same shape as the leading
 *   manifest of sLevelLayoutData_315BB0 (one fewer entry; identical
 *   tail terminator).
 *
 *   The pointer array dispatching THIS backing store lives downstream
 *   at 0x08316dc8 (sLevelLayoutDispatch_316DC8, in
 *   src/data/level_layout_dispatch_316dc8.c) -- mirroring the
 *   (sLevelLayoutData_314068 / sLevelLayoutPtrs_314A68) layout in the
 *   preceding cluster.
 *
 *   Interior anchors:
 *     0x08316760 -- loaded at 0x0802818c, 0x080281b8
 *                   (= manifest terminator entry)
 *     0x083167a0 -- loaded at 0x08027d1c, 0x08027d44
 *     0x083167c0 -- loaded at 0x08027d68, 0x08027d90
 *     0x083167e8 -- loaded at 0x08027db4, 0x08027ddc
 *     0x083168a8 -- loaded at 0x080278a6, 0x08027e00
 *     0x083168c8 -- loaded at 0x080278b8, 0x08027e18
 *
 * TODO: confirm field semantics + sub-table boundaries once
 * [0x08027xxx..0x080281xx] consumers land in C. Until then the backing
 * stores ship as typed u32[] each and consumers index via the pointer
 * array / interior anchor pool loads. Same access pattern as
 * sLevelLayoutPtrs in src/data/level_layout.c. */

const u32 sLevelLayoutData_315BB0[684] = INCBIN_U32("data/level/layout_315bb0.bin");
const u32 sLevelLayoutPtrs_316660[46] = INCBIN_U32("data/level/layout_ptrs_316660.bin");
const u32 sLevelLayoutData_316718[428] = INCBIN_U32("data/level/layout_316718.bin");
