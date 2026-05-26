#include "macros.h"
#include "types.h"

/* Level/room-layout cluster spanning [0x08316f24..0x08317b54).
 *
 * --- Cluster overview ---
 *
 * The cluster has three logically-distinct regions:
 *
 *   [0x08316f24..0x083170d4)  sLevelLayout_316F24..._31707C
 *       Six standalone sub-tables anchored individually by 1..7 pool
 *       references each. Extracted in prior data passes.
 *
 *   [0x083170d4..0x08317a4c)  sLevelLayoutData
 *       Backing store for 64 size-varying sub-tables addressed
 *       indirectly via sLevelLayoutPtrs (below). No direct pool
 *       references -- every consumer pulls a base pointer out of
 *       sLevelLayoutPtrs[idx].
 *
 *   [0x08317a4c..0x08317b54)  sLevelLayoutPtrs
 *       Dispatch array of 64 sub-table pointers followed by two
 *       0xffffffff sentinel entries. Consumers in the still-asm range
 *       [0x08028xxx..0x08029xxx] load *interior* anchors (e.g.,
 *       0x08317a60, 0x08317a98, 0x08317b2c) as pool literals and index
 *       relative to them -- so the array is conceptually a flat
 *       lookup, but a single ROM byte appears under multiple base
 *       names depending on which consumer "window" loads it.
 *
 *       Verified anchor windows (refcount_pool_loads.py):
 *         entry  5 (0x08317a60)  -- loaded at 0x08028586, 0x08029714
 *         entry 20 (0x08317a98)  -- loaded at 0x0802860a, 0x0802974c
 *         entry 27 (0x08317ab0)  -- loaded at 0x080297b2, 0x080297f4
 *         entry 29 (0x08317ab8)  -- loaded at 0x08028736, 0x0802982e
 *         entry 43 (0x08317af8)  -- 3 refs (0x0802883c, 0x08029880,
 *                                   0x080298ac)
 *         entry 45 (0x08317b00)  -- 2 refs
 *         entry 50 (0x08317b10)  -- 1 ref (window of 4 entries)
 *         entry 52 (0x08317b1c)  -- 3 refs (window of 4 entries)
 *         entry 56 (0x08317b2c)  -- 5 refs (window of 8 entries:
 *                                   0x08029356, 0x08029388, 0x080293d2,
 *                                   0x0802940e, 0x0802942e)
 *
 * --- Sub-table shape (sLevelLayoutData) ---
 *
 * Each sub-table starts with an 8-byte header `{u16 a, u16 b, u32
 * count}` followed by `count * 8` record bytes. Records appear to be
 * `{u16 coordA, u16 coordB, u8 flags, u8 type, u16 _pad}` based on the
 * value distribution (high halfwords cycle through small fixed values;
 * second u32 always has 0 in upper bits except for a 0x4303 / 0x0303
 * "kind" field).
 *
 * Sub-table sizes (from sLevelLayoutPtrs stride): mostly 32 B (3-
 * record tables) or 48 B (5-record), with a handful of larger entries
 * up to 192 B. Two pointer-array entries (indices 50, 55) reference
 * earlier sub-tables, so total unique-byte coverage is < 64 * 48 B.
 *
 * Field names await decomp of the consumer cluster around
 * 0x08029000..0x0802a000 (level/room renderer + state advance).
 *
 * --- Sub-table count read (consumer-side) ---
 *
 * Sub-table iteration is driven by `ptr[0]` (u8) -- the callee
 * 0x080219bc loads count from offset 0 of the table base, not from a
 * caller arg. Both 32-byte and 48-byte tables share this convention;
 * what differs is whether the trailing record count happens to equal
 * the header u8 (in which case the "stride" matches "ptr[0]+1
 * 8-byte records") or whether the table is "padded" out to its
 * pointer-array slot.
 *
 * TODO: confirm field semantics + sub-table boundaries once
 * 0x080219bc and 0x08029000..0x0802a000 land in C. Until then the
 * sub-tables ship as a single typed `u32[]` and consumers index via
 * sLevelLayoutPtrs[idx]. */

/* Six original sub-tables (prior data passes). Counts as previously
 * documented; underlying shape verified against the consumer-side
 * `ptr[0] = u8 count` reading convention. */
const u32 sLevelLayout_316F24[8] = INCBIN_U32("data/level/layout_316f24.bin");
const u32 sLevelLayout_316F44[8] = INCBIN_U32("data/level/layout_316f44.bin");
const u32 sLevelLayout_316F64[48] = INCBIN_U32("data/level/layout_316f64.bin");
const u32 sLevelLayout_317024[12] = INCBIN_U32("data/level/layout_317024.bin");
const u32 sLevelLayout_317054[10] = INCBIN_U32("data/level/layout_317054.bin");
const u32 sLevelLayout_31707C[22] = INCBIN_U32("data/level/layout_31707c.bin");

/* 64-entry sub-table backing store. Sub-table boundaries are dictated
 * by sLevelLayoutPtrs (below); see the cluster overview at the top of
 * this file for the access pattern. */
const u32 sLevelLayoutData[606] = INCBIN_U32("data/level/layout_sub_tables.bin");

/* Dispatch array: 64 sub-table pointers + 2 sentinel entries
 * (0xffffffff each). Consumers load interior offsets into this array
 * as base pointers; see the anchor-window list in the cluster
 * overview. */
const u32 sLevelLayoutPtrs[66] = INCBIN_U32("data/level/layout_ptrs.bin");
