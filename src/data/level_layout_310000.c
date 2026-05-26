#include "macros.h"
#include "types.h"

/* Sprite-anim dispatch sub-system filling [0x08310000..0x08310eb4) -- the
 * pre-anchor head of the original [0x08310000, 0x08320000) blob and the
 * immediate predecessor of the already-extracted sLevelLayoutData_310EB4
 * cluster (src/data/level_layout_310eb4.c).
 *
 * --- Entry points (sSpriteAssetTable cross-refs) ---
 *
 * Four interior pointer arrays in this region are stored as the
 * `ptr` field of entries in sSpriteAssetTable (src/data/sprite_asset_table.c
 * at 0x082F8ad8). The consumer cluster at [0x080221F0..0x08022AD8) loads
 * the dispatcher base via sSpriteAssetTable, then iterates 8/12-byte
 * stride records of {sub-table ptr, gfx ptr, count word}:
 *
 *   sSpriteAssetTable entry @ 0x082F8B54 -> sLevelLayoutDispatch_3102F0
 *   sSpriteAssetTable entry @ 0x082F8B64 -> sLevelLayoutDispatch_310600
 *   sSpriteAssetTable entry @ 0x082F8D34 -> sLevelLayoutDispatch_3106D0
 *   sSpriteAssetTable entry @ 0x082F8BD4 -> sLevelLayoutDispatch_310B24
 *
 * Eleven additional sub-tables are anchored individually as pool loads
 * (refcount 2 each, refs from 0x08022206..0x08022A7C). They are passed
 * as `r1` to fn 0x08021140 / fn 0x080219bc -- the same level-layout
 * walker callees documented in src/data/level_layout_3112c8.c. Each
 * iterates `byte[0]` records of 8 B starting at offset 8 of the table.
 *
 * --- Sub-table record convention ---
 *
 * Every backing sub-table opens with an 8 B header `{u32 a, u32 b}`
 * followed by N 8 B records `{u32 c, u32 d}`. Two header shapes:
 *
 *   - `{u32 count, u32 0}` : count drives consumer iteration (b54/b64/
 *     b84/c2c/c44 anchors); records share the high halfword 0x0NNN_xxxx
 *     pattern with a {0x00000202, 0x00000203, 0x00000303} type code in
 *     the second word.
 *   - `{u16 a, u16 b, u32 c}` : c74/df4/e14/e44/e74/e94 anchors; same
 *     stride-not-byte0 mismatch documented in
 *     docs/codegen-notes.md "Pointer-array slot size != byte[0]*stride".
 *
 * --- Cluster A: [0x08310000..0x08310380) ---
 *
 *   sLevelLayoutData_310000 (188 u32s = 752 B)
 *     Backing store opened by the sLevelLayoutDispatch_3102F0 dispatcher.
 *     Five inner anchors (loaded as the per-slot `ptr` field of the
 *     dispatcher):
 *       0x083100F0 -- count=7 records, gfx 0x082F1D18
 *       0x08310160 -- count=7 records
 *       0x083101D0 -- count=5 records
 *       0x08310220 -- count=4 records
 *       0x08310260 -- count=10 records
 *     Plus a small head at 0x08310000..0x08310054 carrying three 16 B
 *     stub records and an embedded mini ptr-array (iter-12 pattern).
 *
 *   sLevelLayoutDispatch_3102F0 (36 u32s = 144 B)
 *     12-slot dispatcher, stride 0xC: {sub-table ptr, gfx ptr 0x082F1D18,
 *     count u32}. Eight slots are live (entries 0..4, 7, 10..11); four
 *     slots are all-zero "absent" markers (entries 5..6, 8..9) -- the
 *     iter-13 "non-monotonic tail with sentinel-zero slots" convention.
 *
 * --- Cluster B: [0x08310380..0x08310630) ---
 *
 *   sLevelLayoutData_310380 (160 u32s = 640 B)
 *     Four 160 B (0xA0) record sets at 0x08310380, 0x08310420,
 *     0x083104C0, 0x08310560. Each holds 10 records of 16 B
 *     {0x00000000, gfx ptr 0x082DCxxx, count word, 0x0A0A0005}.
 *     Consumer treats first sub-table as the canonical anim-row layout.
 *
 *   sLevelLayoutDispatch_310600 (12 u32s = 48 B)
 *     4-slot dispatcher into sLevelLayoutData_310380 at the four 0xA0
 *     stride offsets. Same {ptr, gfx, count} stride-0xC entry shape as
 *     sLevelLayoutDispatch_3102F0.
 *
 * --- Cluster C: [0x08310630..0x08310718) ---
 *
 *   sLevelLayoutData_310630 (40 u32s = 160 B)
 *     Single 160 B record set: 10 records of 16 B sharing the same
 *     {0x00000000, gfx ptr, count, 0x0A0A0005} shape as cluster B.
 *
 *   sLevelLayoutDispatch_3106D0 (18 u32s = 72 B)
 *     6-slot dispatcher. Four entries point at 0x08310630 (the same
 *     record set, count=1 each -- dispatcher index selects which row
 *     of the shared backing is iterated). Last two entries point at
 *     0x08310640 (count=8) and 0x083106C0 (count=1) -- interior offsets
 *     into the same record set.
 *
 * --- Cluster D: [0x08310718..0x08310964) ---
 *
 *   sLevelLayoutData_310718 (138 u32s = 552 B)
 *     Three large record sets at 0x08310718 (0xB0), 0x083107C8 (0xB0),
 *     0x08310878 (0xC8). Records are 0x14 B {0x00000000, gfx ptr
 *     0x082Dxxxx, count word, 0x0A0A000A}. The 0x14 stride
 *     differentiates this cluster from clusters B/C (stride 0x10).
 *
 *   sLevelLayoutPtrs_310940 (9 u32s = 36 B)
 *     3-slot interior dispatcher into sLevelLayoutData_310718.
 *     Reachable only through sLevelLayoutDispatch_310B24 (no direct
 *     sSpriteAssetTable entry).
 *
 * --- Cluster E: [0x08310964..0x08310B54) ---
 *
 *   sLevelLayoutData_310964 (112 u32s = 448 B)
 *     Two big record runs at 0x08310964..0x08310A54 and 0x08310A54..
 *     0x08310B24. Records are 0x10 B {0x00000000, ptr 0x082Dxxxx,
 *     0x00000206, halfword stride 0x14140002}. Stride differs from
 *     clusters B/C/D again -- 28 records of 16 B for the first run, 13
 *     for the second.
 *
 *   sLevelLayoutDispatch_310B24 (12 u32s = 48 B)
 *     4-slot dispatcher: points at 0x08310964, 0x08310984, 0x08310A54,
 *     0x08310974. Same stride-0xC {sub-table ptr, gfx ptr 0x082D7B18,
 *     count word} shape as the earlier dispatchers.
 *
 * --- Standalone sub-tables: [0x08310B54..0x08310C74) ---
 *
 * Five anchors loaded individually by walker callers:
 *
 *   sLevelLayout_310B54 (4 u32s = 16 B)
 *     count=1 record. Refs 0x08022AA0, 0x08022ACC.
 *
 *   sLevelLayout_310B64 (8 u32s = 32 B)
 *     count=3 records. Refs 0x08022734, 0x0802275C.
 *
 *   sLevelLayout_310B84 (42 u32s = 168 B)
 *     count=20 (0x14) records -- the largest standalone here. Refs
 *     0x08022888, 0x080228B0.
 *
 *   sLevelLayout_310C2C (6 u32s = 24 B)
 *     count=2 records. Refs 0x080227B8, 0x080227E0.
 *
 *   sLevelLayout_310C44 (12 u32s = 48 B)
 *     count=5 records. Refs 0x080228D4, 0x08022900.
 *
 * --- Cluster F: [0x08310C74..0x08310DF4) ---
 *
 *   sLevelLayoutData_310C74 (88 u32s = 352 B)
 *     Eight variable-size sub-tables: five 48 B slots (5 records each)
 *     interleaved with three 32 B slots (3 records each) -- pattern
 *     {5,3,5,3,5,5,5,5} records. Headers all use the {u16,u16,u32}
 *     stride-not-byte0 shape (e.g. {0x00040004, 0x00000002}).
 *
 *   sLevelLayoutPtrs_310DD4 (8 u32s = 32 B)
 *     8-entry pointer array into sLevelLayoutData_310C74. Refs
 *     0x08022206, 0x08022780 -- top-level entry of this cluster.
 *
 * --- Standalone sub-tables tail: [0x08310DF4..0x08310EB4) ---
 *
 *   sLevelLayout_310DF4 (8 u32s = 32 B)
 *     Header {0x00040002, 0x00000003} + 3 records. Refs 0x080222C6,
 *     0x08022A34.
 *
 *   sLevelLayout_310E14 (12 u32s = 48 B)
 *     Header {0x00030004, 0x00000003} + 5 records. Refs 0x080222E4,
 *     0x08022A46.
 *
 *   sLevelLayout_310E44 (12 u32s = 48 B)
 *     Header {0x00020004, 0x00000002} + 5 records. Refs 0x080222FC,
 *     0x08022A58.
 *
 *   sLevelLayout_310E74 (8 u32s = 32 B)
 *     Header {0x00040002, 0x00000003} + 3 records. Refs 0x08022312,
 *     0x08022A6A.
 *
 *   sLevelLayout_310E94 (8 u32s = 32 B)
 *     Header {0x00020002, 0x00000003} + 3 records. Refs 0x08022326,
 *     0x08022A7C. Ends exactly at 0x08310EB4 -- the start of the
 *     already-extracted sLevelLayoutData_310EB4.
 *
 * --- TODO ---
 *
 * Once the [0x080221F0..0x08022AD8) consumer cluster lands in C, the
 * dispatcher record shape will collapse into a typed
 * `struct LevelLayoutDispatch { void *ptr; const u32 *gfx; u32 count; }`
 * and the walker pair (fn 0x08021140 + fn 0x080219BC) will name the
 * "type" discriminator in the 8 B headers. The gfx pointers
 * (0x082F1D18, 0x082DCxxx, 0x082D7B18, 0x082Dxxxx) all land in the
 * sprite_anim_block / sprite_dma_records clusters -- another
 * cross-system dependency on consumers still in asm. */

const u32 sLevelLayoutData_310000[188] = INCBIN_U32("data/level/layout_310000.bin");
const u32 sLevelLayoutDispatch_3102F0[36] = INCBIN_U32("data/level/layout_dispatch_3102f0.bin");

const u32 sLevelLayoutData_310380[160] = INCBIN_U32("data/level/layout_310380.bin");
const u32 sLevelLayoutDispatch_310600[12] = INCBIN_U32("data/level/layout_dispatch_310600.bin");

const u32 sLevelLayoutData_310630[40] = INCBIN_U32("data/level/layout_310630.bin");
const u32 sLevelLayoutDispatch_3106D0[18] = INCBIN_U32("data/level/layout_dispatch_3106d0.bin");

const u32 sLevelLayoutData_310718[138] = INCBIN_U32("data/level/layout_310718.bin");
const u32 sLevelLayoutPtrs_310940[9] = INCBIN_U32("data/level/layout_dispatch_310940.bin");

const u32 sLevelLayoutData_310964[112] = INCBIN_U32("data/level/layout_310964.bin");
const u32 sLevelLayoutDispatch_310B24[12] = INCBIN_U32("data/level/layout_dispatch_310b24.bin");

const u32 sLevelLayout_310B54[4] = INCBIN_U32("data/level/layout_310b54.bin");
const u32 sLevelLayout_310B64[8] = INCBIN_U32("data/level/layout_310b64.bin");
const u32 sLevelLayout_310B84[42] = INCBIN_U32("data/level/layout_310b84.bin");
const u32 sLevelLayout_310C2C[6] = INCBIN_U32("data/level/layout_310c2c.bin");
const u32 sLevelLayout_310C44[12] = INCBIN_U32("data/level/layout_310c44.bin");

const u32 sLevelLayoutData_310C74[88] = INCBIN_U32("data/level/layout_310c74.bin");
const u32 sLevelLayoutPtrs_310DD4[8] = INCBIN_U32("data/level/layout_dispatch_310dd4.bin");

const u32 sLevelLayout_310DF4[8] = INCBIN_U32("data/level/layout_310df4.bin");
const u32 sLevelLayout_310E14[12] = INCBIN_U32("data/level/layout_310e14.bin");
const u32 sLevelLayout_310E44[12] = INCBIN_U32("data/level/layout_310e44.bin");
const u32 sLevelLayout_310E74[8] = INCBIN_U32("data/level/layout_310e74.bin");
const u32 sLevelLayout_310E94[8] = INCBIN_U32("data/level/layout_310e94.bin");
