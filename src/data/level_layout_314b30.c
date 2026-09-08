#include "macros.h"
#include "level_layout_data.h"
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
 * --- region [0x08314b78..0x08315268) (444 u32s = 1776 B) ---
 *
 *   Backing store of sub-tables sharing the {u16 a, u16 b, u32 c} 8-byte
 *   header + 8-byte-records convention. The two 64-byte path pairs at
 *   0x08314b80 and 0x08314bc0 are literal typed objects; surrounding
 *   intervals remain extracted raw data. Interior anchors (pool-loaded by
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
const u32 sLevelLayoutRaw_314B78[2] = INCBIN_U32("data/level/layout_raw_314b78.bin");

const LevelLayoutPathPair sLevelLayoutPaths_314B80 = {
    {
        {{2, 3, 1, 0, 1}, {{131, 2315, 6, 0, 0, 0}, {131, 2315, 6, 0, 0, 0}, {59, 83, 6, 0, 0, 0}}},
        {{2, 3, 1, 0, 1}, {{59, 4451, 6, 0, 0, 0}, {59, 4451, 6, 0, 0, 0}, {59, 2243, 6, 0, 0, 0}}},
    },
};

const LevelLayoutPathPair sLevelLayoutPaths_314BC0 = {
    {
        {{2, 3, 1, 0, 1}, {{131, 323, 6, 0, 0, 0}, {131, 323, 6, 0, 0, 0}, {131, 251, 6, 0, 0, 0}}},
        {{2, 3, 1, 0, 1}, {{131, 2195, 6, 0, 0, 0}, {131, 2195, 6, 0, 0, 0}, {131, 251, 6, 0, 0, 0}}},
    },
};

const u32 sLevelLayoutRaw_314C00[410] = INCBIN_U32("data/level/layout_raw_314c00.bin");
const u32 sLevelLayoutPtrs_315268[6] = INCBIN_U32("data/level/layout_ptrs_315268.bin");

const LevelLayout3 sLevelLayoutData_315280[25] = {
    {{2, 3, 2, 0, 1}, {{107, 1667, 4, 0, 0, 0}, {107, 1667, 4, 0, 0, 0}, {107, 1907, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{131, 1691, 4, 0, 0, 0}, {131, 1667, 4, 0, 0, 0}, {131, 1907, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{155, 1667, 4, 0, 0, 0}, {155, 1667, 4, 0, 0, 0}, {155, 1907, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{11, 1547, 4, 0, 0, 0}, {11, 1547, 4, 0, 0, 0}, {11, 1787, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{35, 1571, 4, 0, 0, 0}, {35, 1547, 4, 0, 0, 0}, {35, 1787, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{59, 1547, 4, 0, 0, 0}, {59, 1547, 4, 0, 0, 0}, {59, 1787, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{179, 1427, 4, 0, 0, 0}, {179, 1427, 4, 0, 0, 0}, {179, 1667, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{203, 1451, 4, 0, 0, 0}, {203, 1427, 4, 0, 0, 0}, {203, 1667, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{227, 1427, 4, 0, 0, 0}, {227, 1427, 4, 0, 0, 0}, {227, 1667, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{107, 1235, 4, 0, 0, 0}, {107, 1235, 4, 0, 0, 0}, {107, 1475, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{131, 1259, 4, 0, 0, 0}, {131, 1235, 4, 0, 0, 0}, {131, 1475, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{155, 1235, 4, 0, 0, 0}, {155, 1235, 4, 0, 0, 0}, {155, 1475, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{11, 1115, 4, 0, 0, 0}, {11, 1115, 4, 0, 0, 0}, {11, 1355, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{35, 1139, 4, 0, 0, 0}, {35, 1115, 4, 0, 0, 0}, {35, 1355, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{59, 1115, 4, 0, 0, 0}, {59, 1115, 4, 0, 0, 0}, {59, 1355, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{179, 995, 4, 0, 0, 0}, {179, 995, 4, 0, 0, 0}, {179, 1235, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{203, 1019, 4, 0, 0, 0}, {203, 995, 4, 0, 0, 0}, {203, 1235, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{227, 995, 4, 0, 0, 0}, {227, 995, 4, 0, 0, 0}, {227, 1235, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{35, 875, 4, 0, 0, 0}, {35, 875, 4, 0, 0, 0}, {35, 1115, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{59, 899, 4, 0, 0, 0}, {59, 875, 4, 0, 0, 0}, {59, 1115, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{179, 875, 4, 0, 0, 0}, {179, 875, 4, 0, 0, 0}, {179, 1115, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{203, 899, 4, 0, 0, 0}, {203, 875, 4, 0, 0, 0}, {203, 1115, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{83, 755, 4, 0, 0, 0}, {83, 755, 4, 0, 0, 0}, {83, 995, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{107, 779, 4, 0, 0, 0}, {107, 755, 4, 0, 0, 0}, {107, 995, 4, 0, 0, 0}}},
    {{2, 3, 2, 0, 1}, {{131, 755, 4, 0, 0, 0}, {131, 755, 4, 0, 0, 0}, {131, 995, 4, 0, 0, 0}}},
};

const u32 sLevelLayoutRaw_3155A0[298] = INCBIN_U32("data/level/layout_raw_3155a0.bin");
