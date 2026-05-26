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

/* --- Continuation cluster [0x08317b54..0x08318020) ---
 *
 * Iter-5 deferred the 16 pool-load anchors in this range; iter-6
 * extracts them as 23 typed sub-tables (mini-tables + index manifests
 * + small pointer arrays) feeding consumers in
 * [0x0802a186..0x0802b3b6] and [0x0802bc00..0x0802bc52].
 *
 * Three structural shapes coexist here:
 *
 *   (a) "Index manifest" -- flat array of 8-byte entries `{u32, u32}`
 *       where some entries are `{0xffffffff, 0xffffffff}` (absent
 *       slot) and others are small u32 pairs. Consumers iterate a
 *       known count and copy each entry into per-entity RAM. Loop
 *       boilerplate: `ldr r1, [r0,#4]; ldr r0, [r0,#0]; str r0,
 *       [r2,#4]; str r1, [r2,#8]`.
 *   (b) "Mini-table" -- 8-byte header followed by N records of 8
 *       bytes. The header shape is `{u8 _, u8 _, u8 _, u8 _, u8 _,
 *       u8 _, u8 _, u8 _}` (semantic field positions vary -- count
 *       sometimes at byte 0, sometimes at byte 4). Records are
 *       `{u16, u16, u32}` or `{u8 x4, u32}`.
 *   (c) "Pointer array" -- N pointers (u32 each), each into the
 *       preceding mini-table backing store. Strides between pointed-
 *       to entries determine mini-table size (typically 16 or 32
 *       bytes).
 *
 * The cluster crosses 0x08318000 by 32 bytes: the final manifest at
 * 0x08317ffc reads 4 entries (32 B), reaching 0x08318020. Kept in
 * this file to preserve the manifest’s logical wholeness; iter-7
 * resumes at 0x08318020.
 *
 * Field semantics still inferred indirectly via consumer behaviour
 * (see refs in 0x0802axxx). Names remain ROM-address-suffixed pending
 * decomp of those consumers.
 */

/* Pre-cluster index manifest. 11 entries `{u32, u32}` with values
 * 0x64, 0x54, 0x1f, 0x3f, 0x61, 0x60, 0x44, 0x59, 0x58, 0x44, 0x17 in
 * the low slot. No direct pool reference; loaded as
 * `sLevelLayoutPtrs + 0x108` by consumers indexing across the
 * boundary. */
const u32 sLevelLayout_317B54[22] = INCBIN_U32("data/level/layout_317b54.bin");

/* Mini-tables: 8-byte header + N×8 records. Counts 5/5/1/12. Anchored
 * individually by pool refs at 0x0802a1d8, 0x0802a218, 0x0802a240,
 * 0x0802a186 + 0x0802a274. */
const u32 sLevelLayout_317BAC[12] = INCBIN_U32("data/level/layout_317bac.bin");
const u32 sLevelLayout_317BDC[12] = INCBIN_U32("data/level/layout_317bdc.bin");
const u32 sLevelLayout_317C0C[4] = INCBIN_U32("data/level/layout_317c0c.bin");
const u32 sLevelLayout_317C1C[26] = INCBIN_U32("data/level/layout_317c1c.bin");

/* Index manifest: 8 entries of `{u32, u32}`, mostly `{ffff,ffff}`
 * sentinel slots with two real entries. Consumer at 0x0802a29e
 * iterates `r3 < 8` and copies into RAM. */
const u32 sLevelLayout_317C84[16] = INCBIN_U32("data/level/layout_317c84.bin");

/* Backing store for 8 mini-tables (each 32 bytes, header
 * `{02,03,02,00, 01,_,_,_}` + 3 records). Dispatched by
 * sLevelLayoutPtrs_317DEC. */
const u32 sLevelLayoutData_317CC4[64] = INCBIN_U32("data/level/layout_317cc4.bin");

/* Standalone mini-tables anchored separately. Counts inferred from
 * record boundaries. */
const u32 sLevelLayout_317DC4[6] = INCBIN_U32("data/level/layout_317dc4.bin");
const u32 sLevelLayout_317DDC[4] = INCBIN_U32("data/level/layout_317ddc.bin");

/* Pointer array dispatching the 8 mini-tables in
 * sLevelLayoutData_317CC4 (0x08317cc4, 0x08317ce4, ..., 0x08317da4 --
 * stride 0x20). */
const u32 sLevelLayoutPtrs_317DEC[8] = INCBIN_U32("data/level/layout_317dec.bin");

/* Backing store for 6 mini-tables of 16 bytes each (header
 * `{02,_,_,_, 02,_,_,_}` + records). Dispatched by
 * sLevelLayoutPtrs_317E6C (only 2 of the 6 are pointed to directly --
 * remaining 4 may be reachable via stride arithmetic from
 * consumers). */
const u32 sLevelLayoutData_317E0C[24] = INCBIN_U32("data/level/layout_317e0c.bin");

/* 2-entry pointer array into sLevelLayoutData_317E0C (entries 0 and
 * 3, stride 0x30). */
const u32 sLevelLayoutPtrs_317E6C[2] = INCBIN_U32("data/level/layout_317e6c.bin");

/* Index manifest: 6 entries `{u32, u32}`, five `{ffff,ffff}` slots +
 * one real entry `{0x21, 0}`. Consumer at 0x0802ac66 iterates `r3 <=
 * 5`. */
const u32 sLevelLayout_317E74[12] = INCBIN_U32("data/level/layout_317e74.bin");

/* Backing for sLevelLayoutPtrs_317ED4 (a single-pointer dispatcher --
 * one mini-table of 48 bytes: header + 5 records of 8B). */
const u32 sLevelLayoutData_317EA4[12] = INCBIN_U32("data/level/layout_317ea4.bin");

/* Single-entry pointer array (-> 0x08317ea4). Two consumer refs:
 * 0x0802aed6 and 0x0802af8a both load the same anchor. */
const u32 sLevelLayoutPtrs_317ED4[1] = INCBIN_U32("data/level/layout_317ed4.bin");

/* Backing for sLevelLayoutPtrs_317F58: 8 mini-tables of 16 bytes
 * each, dispatched in groups of 4 by the pointer array (entries at
 * 0x08317ed8, 0x08317ef8, 0x08317f18, 0x08317f38). */
const u32 sLevelLayoutData_317ED8[32] = INCBIN_U32("data/level/layout_317ed8.bin");

/* 4-entry pointer array into sLevelLayoutData_317ED8 (stride 0x20). */
const u32 sLevelLayoutPtrs_317F58[4] = INCBIN_U32("data/level/layout_317f58.bin");

/* Index manifest: 4 entries `{u32, u32}`, four `{ffff,ffff}` slots
 * (no real values -- "all-absent" manifest). Consumer at 0x0802afc6
 * iterates `r3 <= 3`. */
const u32 sLevelLayout_317F68[8] = INCBIN_U32("data/level/layout_317f68.bin");

/* Standalone sub-table (header `{02,_,_,_, 03,_,_,_}` + 3 records of
 * 8 bytes). Reachable via sLevelLayoutPtrs_317FF8 -- not directly
 * pool-referenced. */
const u32 sLevelLayout_317F88[8] = INCBIN_U32("data/level/layout_317f88.bin");

/* Mini-tables consumed via callee at 0x21140 with stride 16: counts
 * `{4, 4}` and records of 8 bytes. Anchored at 0x0802bc00 and
 * 0x0802bc28. */
const u32 sLevelLayout_317FA8[10] = INCBIN_U32("data/level/layout_317fa8.bin");
const u32 sLevelLayout_317FD0[10] = INCBIN_U32("data/level/layout_317fd0.bin");

/* Single-pointer array -> sLevelLayout_317F88 (consumer at
 * 0x0802b3b6: do-while loop runs exactly once because `r4+1 != 0`
 * after first iteration). */
const u32 sLevelLayoutPtrs_317FF8[1] = INCBIN_U32("data/level/layout_317ff8.bin");

/* Index manifest: 4 entries `{u32, u32}`. Crosses the 0x08318000
 * bucket boundary (entries span 0x08317ffc..0x08318020 -- 36 bytes
 * total). Consumer at 0x0802bc52 iterates `r3 <= 3`. Kept in this
 * file to preserve manifest wholeness; the next iter resumes data
 * extraction at 0x08318020. */
const u32 sLevelLayout_317FFC[9] = INCBIN_U32("data/level/layout_317ffc.bin");
