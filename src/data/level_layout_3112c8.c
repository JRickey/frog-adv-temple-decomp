#include "macros.h"
#include "types.h"

/* Level-layout sub-cluster filling [0x083112c8..0x08312c20) -- continues
 * the multi-tier level-layout dispatch hierarchy documented in
 * src/data/level_layout.c.
 *
 * This is the tail of sLevelLayoutDispatch_3112A8’s backing region: that
 * 8-entry pointer array (0x083112a8..0x083112c8) dispatches into the
 * 8-mini-table block that opens this file. The rest of the region
 * carries six more (backing-store + pointer-array) sub-clusters plus a
 * large mixed-record tail before the next named cluster
 * (sLevelLayout_312C20).
 *
 * --- Consumer convention ---
 *
 * Sub-tables are consumed by fn 0x08021140 (walker variant; byte[0] of
 * the table base = record count) and fn 0x080219bc (count-from-byte0
 * iterator helper). Pointer-array consumers iterate `r4 = 0..N-1` and
 * load `ptrs_base + r4*4` as the per-iteration sub-table base.
 *
 * Sub-table size is NOT always `8 + byte[0]*8`: some entries in the
 * 0x08311a50 / 0x08311b10 backing are padded out to their pointer-
 * array slot size (the byte[0] count drives consumer iteration; the
 * trailing bytes are the rest of the slot’s stride). Authoritative
 * boundaries come from the dispatching pointer array, not from byte[0].
 *
 * --- Cluster A: [0x083112c8..0x083113e8) ---
 *
 *   sLevelLayoutData_3112C8 (64 u32s = 256 B)
 *     8 mini-tables of 32 B each (8B header + 3 records of 8B). Headers
 *     all follow the `{u16 a, u16 b=1, u32 count=3}` shape; the u16 a
 *     selects between 2 and 3 across the eight slots. The records share
 *     a high halfword 0x0000_0004; the low halfword cycles through
 *     small fixed values.
 *
 *   sLevelLayoutPtrs_3113C8 (8 u32s = 32 B)
 *     Dispatches the eight 32 B mini-tables above. Two pool refs from
 *     consumers at 0x08021f70 and 0x08022924 (sequential iteration
 *     loop, r4 = 0..7).
 *
 * --- Cluster B tail: [0x083113e8..0x083114c0) ---
 *
 * Three variable-size sub-tables, one 7-entry index manifest, and one
 * more sub-table -- none dispatched by a tail pointer array. Each
 * sub-table is anchored individually as a base pointer in the pool.
 *
 *   sLevelLayout_3113E8 (12 u32s = 48 B)   count=5 records
 *     Anchor refcount 2 (0x08022cda, 0x08023248). Passed as r1 to fn
 *     0x08021140 with iteration count 5.
 *
 *   sLevelLayout_311418 (10 u32s = 40 B)   count=4 records
 *     Anchor refcount 2 (0x0802295c, 0x08022984).
 *
 *   sLevelLayout_311440 (4 u32s = 16 B)    count=1 record
 *     Anchor refcount 2 (0x080229a8, 0x080229d0).
 *
 *   sLevelLayoutManifest_311450 (14 u32s = 56 B, 7 manifest entries)
 *     Flat `{u32 count, u32 0}` index manifest: counts 0x27, 0x25,
 *     0x11, 0x12, 0x10, 0x26, 0x0e. No direct pool reference;
 *     reachable via interior offset from a still-asm consumer (likely
 *     loaded as `sLevelLayout_311488 - 0x38` or similar).
 *
 *   sLevelLayout_311488 (4 u32s = 16 B)    count=1 record
 *     Anchor refcount 2 (0x080234ec, 0x08023518).
 *
 *   sLevelLayout_311498 (10 u32s = 40 B)   count=4 records
 *     Anchor refcount 2 (0x08022c22, 0x080231f8).
 *
 * --- Cluster C: [0x083114c0..0x083116f0) ---
 *
 *   sLevelLayoutData_3114C0 (126 u32s = 504 B)
 *     14 mini-tables of 32 B each (same `{u16, u16, u32 count=3}` +
 *     3 records shape as cluster A).
 *
 *   sLevelLayoutPtrs_3116B8 (14 u32s = 56 B)
 *     14-entry dispatch. Anchor refcount 2 (0x08022cda, 0x08023248
 *     -- same consumers as 0x083113E8).
 *
 * --- Cluster D: [0x083116f0..0x08311810) ---
 *
 *   sLevelLayoutData_3116F0 (64 u32s = 256 B)
 *     8 mini-tables of 32 B each.
 *
 *   sLevelLayoutPtrs_3117F0 (8 u32s = 32 B)
 *     8-entry dispatch. Anchor refcount 2 (0x08022d5a, 0x08022e1a).
 *
 * --- Cluster E: [0x08311810..0x08311930) ---
 *
 *   sLevelLayoutData_311810 (64 u32s = 256 B)
 *     8 mini-tables of 32 B each.
 *
 *   sLevelLayoutPtrs_311910 (8 u32s = 32 B)
 *     8-entry dispatch. Anchor refcount 2 (0x08022d7a, 0x08022e2a).
 *
 * --- Cluster F: [0x08311930..0x08311a50) ---
 *
 *   sLevelLayoutData_311930 (64 u32s = 256 B)
 *     8 mini-tables of 32 B each.
 *
 *   sLevelLayoutPtrs_311A30 (8 u32s = 32 B)
 *     8-entry dispatch. Anchor refcount 2 (0x08022d98, 0x08022e38).
 *
 * --- Cluster G: [0x08311a50..0x08311cb0) ---
 *
 *   sLevelLayoutData_311A50 (140 u32s = 560 B)
 *     12 variable-size mini-tables. The first eight are 48 B each
 *     (header + 5 records); the last four are 32 B each (header +
 *     3 records). Headers here use the alternate `{u16 a, u16 b=4,
 *     u32 count=2}` shape -- distinct from clusters A..F’s `{*, *=1,
 *     count=3}` -- so the records-per-slot count is ABOVE the byte[0]
 *     count value, with the trailing bytes acting as padding to the
 *     pointer-array’s stride.
 *
 *   sLevelLayoutPtrs_311C80 (12 u32s = 48 B)
 *     12-entry dispatch into the cluster-G mini-tables (non-uniform
 *     stride: 0x30 x 8 then 0x20 x 4 -- consistent with the size mix
 *     above). Anchor refcount 2 (0x08022eb2, 0x080232d0). Consumer
 *     iterates `r4 = 0..11`.
 *
 * --- Cluster H tail: [0x08311cb0..0x08311ec0) ---
 *
 * Six standalone sub-tables, similar in shape to the cluster-B tail
 * but mostly larger. Each anchored individually.
 *
 *   sLevelLayout_311CB0 (12 u32s = 48 B)   count=5 records
 *     Anchor refcount 2 (0x080233d8, 0x08023404).
 *
 *   sLevelLayout_311CE0 (22 u32s = 88 B)   count=10 records
 *     Anchor refcount 2 (0x08023338, 0x08023364).
 *
 *   sLevelLayout_311D38 (8 u32s = 32 B)    count=3 records
 *     Anchor refcount 2 (0x08023388, 0x080233b4).
 *
 *   sLevelLayoutData_311D58 (90 u32s = 360 B)
 *     10 mini-tables of 32 or 40 B each, dispatched by the following
 *     pointer array. Variable sizes mirror cluster G’s pattern.
 *
 *   sLevelLayoutPtrs_311EC0 (10 u32s = 40 B)
 *     10-entry dispatch into sLevelLayoutData_311D58. Anchor refcount
 *     2 (0x08022f56, 0x08023428). Consumer iterates `r4 = 0..9`.
 *
 * --- Cluster I: [0x08311ee8..0x08311f80) ---
 *
 *   sLevelLayoutData_311EE8 (16 u32s = 64 B)
 *     2 mini-tables of 32 B each (count=4 records each).
 *
 *   sLevelLayoutPtrs_311F28 (2 u32s = 8 B)
 *     2-entry dispatch into sLevelLayoutData_311EE8.
 *
 *   sLevelLayoutData_311F30 (18 u32s = 72 B)
 *     3 mini-tables (24 B + 24 B + 24 B). Headers use the `{u16 a=1,
 *     u16 b=1, u32 count=3}` shape -- count above the actual record
 *     length, again a "consumer count vs slot stride" mismatch.
 *
 *   sLevelLayoutPtrs_311F78 (2 u32s = 8 B)
 *     2-entry dispatch (entries 0x08311f48 and 0x08311f60 -- only the
 *     last two mini-tables in sLevelLayoutData_311F30).
 *
 * --- Cluster J tail: [0x08311f80..0x08312c20) ---
 *
 * Long mixed tail: a 40-record sub-table, a 1-record sub-table, four
 * 0xffffffff sentinels (manifest absent-slot markers), an 8-entry
 * `{count, 0}` index manifest, two more sentinels, a tail of
 * standalone sub-tables, and a large run of mini-tables stretching to
 * 0x08312c20 where the next named cluster (sLevelLayout_312C20)
 * begins.
 *
 * Notable anchors:
 *   0x08311f80 (size 0x148, count=40)    -- not directly refcounted
 *   0x08312138 (count=1 sub-table)       -- refcount 2 (0x08024448, 0x08024474)
 *   0x08312148 (count=20 sub-table)      -- refcount 2 (0x0802404c, 0x08024074)
 *   0x083121f0 (count=3 sub-table)       -- refcount 2 (0x08023bcc, 0x080243d8)
 *   0x08312210 (count=2 sub-table)       -- refcount 2 (0x08024238, 0x0802428a)
 *   0x08312228 (count=3 sub-table)       -- refcount 2 (0x08023ffc, 0x08024028)
 *   0x08312248 (count=4 sub-table)       -- refcount 2 (0x080236d2, 0x080242b0)
 *   0x08312270 (count=2 sub-table)       -- refcount 2 (0x080242dc, 0x08024308)
 *
 * The 0xffffffff sentinel runs at [0x083120d8, 0x083120e8) and
 * [0x08312128, 0x08312130) are "absent slot" markers in embedded index
 * manifests -- same convention as src/data/level_layout.c’s
 * "Index manifest" shape.
 *
 * TODO: split sLevelLayoutData_311F80 along its internal manifest /
 * sub-table boundaries when the [0x08023bcc..0x08024474] consumers
 * land in C. The tail’s manifests at 0x083120d8, 0x083120e8,
 * 0x08312128, 0x08312130 hint at an inner grouping the still-asm
 * consumers will name. */

const u32 sLevelLayoutData_3112C8[64] = INCBIN_U32("data/level/layout_3112c8.bin");
const u32 sLevelLayoutPtrs_3113C8[8] = INCBIN_U32("data/level/layout_ptrs_3113c8.bin");

const u32 sLevelLayout_3113E8[12] = INCBIN_U32("data/level/layout_3113e8.bin");
const u32 sLevelLayout_311418[10] = INCBIN_U32("data/level/layout_311418.bin");
const u32 sLevelLayout_311440[4] = INCBIN_U32("data/level/layout_311440.bin");
const u32 sLevelLayoutManifest_311450[14] = INCBIN_U32("data/level/layout_manifest_311450.bin");
const u32 sLevelLayout_311488[4] = INCBIN_U32("data/level/layout_311488.bin");
const u32 sLevelLayout_311498[10] = INCBIN_U32("data/level/layout_311498.bin");

const u32 sLevelLayoutData_3114C0[126] = INCBIN_U32("data/level/layout_3114c0.bin");
const u32 sLevelLayoutPtrs_3116B8[14] = INCBIN_U32("data/level/layout_ptrs_3116b8.bin");

const u32 sLevelLayoutData_3116F0[64] = INCBIN_U32("data/level/layout_3116f0.bin");
const u32 sLevelLayoutPtrs_3117F0[8] = INCBIN_U32("data/level/layout_ptrs_3117f0.bin");

const u32 sLevelLayoutData_311810[64] = INCBIN_U32("data/level/layout_311810.bin");
const u32 sLevelLayoutPtrs_311910[8] = INCBIN_U32("data/level/layout_ptrs_311910.bin");

const u32 sLevelLayoutData_311930[64] = INCBIN_U32("data/level/layout_311930.bin");
const u32 sLevelLayoutPtrs_311A30[8] = INCBIN_U32("data/level/layout_ptrs_311a30.bin");

const u32 sLevelLayoutData_311A50[140] = INCBIN_U32("data/level/layout_311a50.bin");
const u32 sLevelLayoutPtrs_311C80[12] = INCBIN_U32("data/level/layout_ptrs_311c80.bin");

const u32 sLevelLayout_311CB0[12] = INCBIN_U32("data/level/layout_311cb0.bin");
const u32 sLevelLayout_311CE0[22] = INCBIN_U32("data/level/layout_311ce0.bin");
const u32 sLevelLayout_311D38[8] = INCBIN_U32("data/level/layout_311d38.bin");
const u32 sLevelLayoutData_311D58[90] = INCBIN_U32("data/level/layout_311d58.bin");
const u32 sLevelLayoutPtrs_311EC0[10] = INCBIN_U32("data/level/layout_ptrs_311ec0.bin");

const u32 sLevelLayoutData_311EE8[16] = INCBIN_U32("data/level/layout_311ee8.bin");
const u32 sLevelLayoutPtrs_311F28[2] = INCBIN_U32("data/level/layout_ptrs_311f28.bin");
const u32 sLevelLayoutData_311F30[18] = INCBIN_U32("data/level/layout_311f30.bin");
const u32 sLevelLayoutPtrs_311F78[2] = INCBIN_U32("data/level/layout_ptrs_311f78.bin");

const u32 sLevelLayoutData_311F80[808] = INCBIN_U32("data/level/layout_311f80.bin");
