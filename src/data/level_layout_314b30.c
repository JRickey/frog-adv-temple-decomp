#include "macros.h"
#include "types.h"

/* (manifest + backing-store + embedded ptr-array + backing-store) cluster at
 * [0x08314b30..0x08315a48).
 *
 * Continues the multi-tier level-layout dispatch pattern documented in
 * src/data/level_layout.c. This cluster sits between sLevelLayoutPtrs_314A68
 * (upstream, dispatcher for the [0x083140xx..0x08314a48) backing store) and
 * sLevelLayoutDispatch_315A48 (downstream, 90-entry stage dispatcher).
 *
 * --- sLevelLayoutManifest_314B30 (18 u32s = 72 B) ---
 *
 *   9-entry {u32 count, u32 0} index manifest. Counts:
 *     0x39, 0x45, 0x2e, 0x32, 0x30, 0x3e, 0x2c, 0x2d, 0x01
 *   The last entry (0x01) is the sentinel/terminator -- same shape as the
 *   leading manifests in sLevelLayoutData_312E94 / _313360 / _314068.
 *
 * --- sLevelLayoutData_314B78 (444 u32s = 1776 B) ---
 *
 *   Backing store of sub-tables sharing the {u16 a, u16 b, u32 c} 8-byte
 *   header + 8-byte-records convention. Interior anchors (pool-loaded by
 *   consumers in [0x0802652x..0x080269xx]):
 *     0x08314b70 -- loaded at 0x08026e44, 0x08026e70
 *     0x08314b80 -- loaded at 0x0802652a, 0x080266f6
 *     0x08314bc0 -- loaded at 0x0802656e, 0x08026842
 *     0x083150f0 -- loaded at 0x080269e8, 0x08026a10
 *
 * --- sLevelLayoutPtrs_315268 (6 u32s = 24 B) ---
 *
 *   Mini pointer array nested inside the backing-store region. Points to
 *   six interior sub-tables in [0x083151a8..0x08315248):
 *     entry 0: 0x083151a8
 *     entry 1: 0x08315228
 *     entry 2: 0x08315248
 *     entry 3: 0x083151c8
 *     entry 4: 0x083151e8
 *     entry 5: 0x08315208
 *   Reordered (not strictly ascending) -- the consumer indexes by a
 *   semantic key, not by address order. Anchor 0x08315274 (refs from
 *   0x08026e9a, 0x08026ee0) resolves to entry 3 (0x08315274 = base+0xC).
 *   Same multi-window addressing pattern as sLevelLayoutPtrs_314A68.
 *
 * --- sLevelLayoutData_315280 (498 u32s = 1992 B) ---
 *
 *   Tail backing store. Interior anchors:
 *     0x083158c0 -- loaded at 0x08026cc4, 0x08026cec
 *     0x083159c0 -- loaded at 0x08026d10, 0x08026d38
 *     0x083159d8 -- loaded at 0x08026dd0, 0x08026e1c
 *     0x08315a10 -- loaded at 0x08026d5c, 0x08026da8
 *
 * TODO: confirm field semantics + sub-table boundaries once
 * [0x08026xxx] consumers land in C. Until then the backing stores ship
 * as typed u32[] each and consumers index via the pointer array /
 * directly via interior anchor pool loads. Same access pattern as
 * sLevelLayoutPtrs in src/data/level_layout.c. */

const u32 sLevelLayoutManifest_314B30[18] = INCBIN_U32("data/level/layout_manifest_314b30.bin");
const u32 sLevelLayoutData_314B78[444] = INCBIN_U32("data/level/layout_314b78.bin");
const u32 sLevelLayoutPtrs_315268[6] = INCBIN_U32("data/level/layout_ptrs_315268.bin");
const u32 sLevelLayoutData_315280[498] = INCBIN_U32("data/level/layout_315280.bin");
