#include "macros.h"
#include "types.h"

/* Level-layout sub-cluster filling [0x08318020..0x083181bc) -- continues
 * the multi-tier level-layout dispatch hierarchy documented in
 * src/data/level_layout.c. Anchored by five charter-grade refcount-2
 * sub-tables in the 0x0831807c..0x0831813c span (the 5-anchor cluster
 * picked up by tools/agent/refcount_pool_loads.py).
 *
 * --- Cluster overview ---
 *
 *   [0x08318020..0x0831802c)  sLevelLayoutSentinels_318020
 *       Three 0xffffffff "absent slot" sentinels. Same convention as
 *       level_layout.c (0x083120d8 / 0x08312128) and the trailing
 *       sentinels in sLevelLayoutPtrs at 0x08317a4c.
 *
 *   [0x0831802c..0x0831805c)  sLevelLayoutManifest_31802C
 *       Six `{u32 count, u32 0}` manifest entries. Counts are
 *       0x70, 0x66, 0x81, 0x6f, 0x6d, 0x6e -- a 5-language x N-record
 *       descriptor (the 0x6d..0x81 range matches per-world record
 *       counts elsewhere in the level-layout tables). No direct pool
 *       reference; reachable as `sLevelLayout_31805C - 0x30` from a
 *       still-asm consumer.
 *
 *   [0x0831805c..0x0831807c)  sLevelLayout_31805C
 *       One sub-table, header + 3 records. Header `{u16=2, u16=3,
 *       u32 count=3}`; records share x=0x30 (lower halfword of word
 *       1), with x varying through 0x9b, 0x23, 0xe3. Loaded by a
 *       single consumer at 0x0802ca84 (refcount 1; called as
 *       sub_080210a0 walker variant -- same walker as the 5th anchor).
 *
 *   [0x0831807c..0x0831813c)  sLevelLayout_31807C..._31810C
 *       Four parallel-array sub-tables of identical shape (48 bytes
 *       each: 8-byte header + 5 records of 8 bytes). Header convention
 *       `{u16=5, u16=0, u32=0}` -- count-of-5 records follow. Records
 *       carry the high-halfword "kind" word 0x303 (for _31807C),
 *       0x3303 (for _3180AC), 0x2303 (for _3180DC), 0x1303 (for
 *       _31810C) -- so the four tables encode the same 5 record-
 *       coordinates with a per-table varying type code. Classic
 *       parallel-array shape.
 *
 *       Both consumers reference all four anchors in different orders:
 *
 *         sub_0802C780 (dispatched by r2):
 *           r2=0 -> 0x0831807c, r2=1 -> 0x0831810c,
 *           r2=2 -> 0x083180dc, r2=3 -> 0x083180ac
 *           Calls LevelLayout_WalkRecords (walker) with (0x85, anchor, 0x10, 0x4, ...).
 *
 *         sub_0802C8C8 (dispatched by `*(u8*)r0_in`):
 *           [0] -> 0x0831807c, [1] -> 0x083180ac,
 *           [2] -> 0x083180dc, [3] -> 0x0831810c
 *           Calls Entity_WalkCompactRecords (walker variant) with the same anchor.
 *
 *       Refcount-2 anchors (one ref from each consumer):
 *         0x0831807c (0x0802c792, 0x0802c8ca)
 *         0x083180ac (0x0802c7cc, 0x0802c8d4)
 *         0x083180dc (0x0802c7ac, 0x0802c8dc)
 *         0x0831810c (0x0802c7a4, 0x0802c8f4)
 *
 *   [0x0831813c..0x083181bc)  sLevelLayout_31813C
 *       Larger (128-byte) sub-table consumed by a different walker
 *       (sub_080210a0 at 0x080210a0 -- reads `[r1, #2]` (u8) and
 *       `[r1, #8]` / `[r1, #10]` (u16 pair) from the table header).
 *       Header `{u16=2, u16=2, u32=3}` then 16 records of 8 bytes
 *       carrying `{u16 x, u16 y, u32 type=5}` shape with intermittent
 *       sentinel rows `{0x05, 0, 0, 0}` at +0x20 and +0x50 (likely
 *       group separators).
 *
 *       Two pool refs (0x0802ceae, 0x0802d3c4). Both call sites
 *       pass the same fixed stack args (0x41, 1, 3, 2) along with
 *       r2=0x10, r3=0x59 -- the walker plugs the values into a 0x40-
 *       byte per-record output struct.
 *
 *       A dispatch entry `{ptr=0x0831813c, count=0x20}` appears at
 *       0x083181bc -- so this anchor is also reachable as the head of
 *       a 0x20-record window through that dispatcher (out of charter;
 *       the dispatcher itself is in the next data pass).
 *
 * --- Walker family ---
 *
 * LevelLayout_WalkRecords (entries 1-4):  reads `[base, #8]` halfword and `[base,
 *   #10]` halfword as the first record; the stack args (0x85, 3, 0/3)
 *   and immediate args (r2=0x10, r3=4) drive a small switch table that
 *   consumes the rest of the records.
 *
 * Entity_WalkCompactRecords (entries 1-4 via second consumer):  same prologue
 *   shape as 0x21140, but the per-record dispatch uses r2=0x4 (vs 0x10
 *   for 0x21140) -- likely a "compact-record" variant of the same
 *   walker.
 *
 * sub_080210a0 (entry 5 and sLevelLayout_31805C):  single-shot reader,
 *   no per-table count loop -- so the table count fields above 1 are
 *   driven externally (likely by an outer dispatcher iterating
 *   `r4 = 0..N-1` against the dispatch entry at 0x083181bc and
 *   passing each row to sub_080210a0).
 *
 * TODO: rename `_NNNNNN` symbols to semantic names once 0x0802c780
 * and 0x0802c8c8 (entity / scene setup family) land in C. The 4-way
 * parallel-array shape suggests a per-difficulty or per-region scene
 * descriptor; the parallel ordering 0x07c -> 0x0ac/_dc/_10c hints at
 * a 2-bit difficulty enum.
 *
 * TODO: extract the dispatcher block at [0x083181bc..) as a follow-up
 * pass -- it carries the `{ptr=sLevelLayout_31813C, count=0x20}`
 * record plus a long monotonic-offset table the next consumer
 * family will name.
 */

const u32 sLevelLayoutSentinels_318020[3] = INCBIN_U32("data/level/layout_318020_sentinels.bin");
const u32 sLevelLayoutManifest_31802C[12] = INCBIN_U32("data/level/layout_manifest_31802c.bin");

const u32 sLevelLayout_31805C[8] = INCBIN_U32("data/level/layout_31805c.bin");

const u32 sLevelLayout_31807C[12] = INCBIN_U32("data/level/layout_31807c.bin");
const u32 sLevelLayout_3180AC[12] = INCBIN_U32("data/level/layout_3180ac.bin");
const u32 sLevelLayout_3180DC[12] = INCBIN_U32("data/level/layout_3180dc.bin");
const u32 sLevelLayout_31810C[12] = INCBIN_U32("data/level/layout_31810c.bin");

const u32 sLevelLayout_31813C[32] = INCBIN_U32("data/level/layout_31813c.bin");
