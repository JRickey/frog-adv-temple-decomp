#include "macros.h"
#include "types.h"

/* Three small tables filling the gap [0x08316e5c..0x08316f24) between
 * sLevelLayoutDispatch_316DC8 and sLevelLayout_316F24 (start of the
 * main level_layout.c cluster).
 *
 *   sLevelLayout_316E5C  (88 B)  -- pre-cluster index manifest.
 *       8 entries of `{u32 small, u32 0}` with values
 *       0x64, 0x54, 0x1f, 0x3f, 0x61, 0x60, 0x55, 0x56 followed by 4
 *       0xffffffff sentinel slots then one final {0x17, 0} entry.
 *       Mirrors the iter-6-documented sLevelLayout_317B54 manifest
 *       that precedes sLevelLayoutPtrs in level_layout.c. No direct
 *       pool reference; reached as interior offset of the preceding
 *       sLevelLayoutDispatch_316DC8 pointer cluster.
 *
 *   sLevelLayout_316EB4  (16 B)  -- small {count, data} record with
 *       count=1 in the first byte. Consumer at 0x08029b40 (2 pool
 *       refs) invokes the level-layout iteration helper at 0x08021510
 *       with this as its table base; with count=1 only one record is
 *       processed.
 *
 *   sLevelLayout_316EC4  (96 B)  -- mini-table at the brief anchor
 *       0x08316ec4 (3 pool-load refs from consumers at 0x080286fe,
 *       0x08029480, 0x08029784). 8-byte header `{0x0b, 0, 0, 0, 0,
 *       0, 0, 0}` followed by 11 records of 8 bytes each, ending
 *       exactly at 0x08316f24 where the existing
 *       src/data/level_layout.c cluster starts. Records follow the
 *       same `{u16 a, u16 b, u8 flags, u8 type, u16 _pad}` shape used
 *       elsewhere in the cluster (high halfword cycles 0x303 / 0x213
 *       / 0x303 etc.).
 *
 * TODO: field semantics await decomp of 0x08028xxx..0x08029xxx
 * consumers (level/room renderer dispatchers). */

const u32 sLevelLayout_316E5C[22] = INCBIN_U32("data/level/layout_316e5c.bin");
const u32 sLevelLayout_316EB4[4] = INCBIN_U32("data/level/layout_316eb4.bin");
const u32 sLevelLayout_316EC4[24] = INCBIN_U32("data/level/layout_316ec4.bin");
