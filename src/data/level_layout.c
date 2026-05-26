#include "macros.h"
#include "types.h"

/* Level/room-layout anchors flagged by the data-extraction pass.
 *
 * The first two tables are 32 bytes each: an 8-byte header { u32 mask,
 * u32 count } followed by three 8-byte records { u32 coord, u32 type }.
 * Both 32-byte tables use the same header value 0x00040302 / 0x00000001;
 * the third field of the trailing record uses sentinel 0x00000007 in
 * both tables.
 *
 * The remaining tables follow a different but consistent shape: an
 * 8-byte header { u32 count, u32 zero } followed by count*8-byte
 * records. Boundaries are pinned by pool-literal callsites:
 *   0x08317024 -- 2 refs (0x080295fc, 0x08029624), count=5
 *   0x08317054 -- 2 refs (0x08029648, 0x08029670), count=4
 *   0x0831707c -- 1 ref  (0x08029694),             count=10
 * The count=23 sub-table at 0x08316f64 immediately follows the existing
 * 0x08316f44 table; it has no direct pool reference but its 23 records
 * end exactly at 0x08317024 where the next anchored table begins.
 *
 * 0x08316f24 has 6 pool-literal callsites from the still-asm range
 *   [0x08028af0, 0x08029a10] -- the room-layout / level-renderer
 *   cluster pass 3 deferred.
 * 0x08316f44 has 7 pool-literal callsites from the same range.
 *
 * Field naming awaits decomp of the consumers; the current names are
 * keyed off ROM offset so the symbols are addressable without
 * pretending to know what each field means.
 *
 * TODO: confirm field semantics after the room-renderer functions
 * around 0x08028af0..0x08029a10 land in C. The cluster likely encodes
 * a list of related room/section descriptors selected by mode flag,
 * with the trailing tables holding per-mode object placement lists. */

const u32 sLevelLayout_316F24[8] = INCBIN_U32("data/level/layout_316f24.bin");
const u32 sLevelLayout_316F44[8] = INCBIN_U32("data/level/layout_316f44.bin");
const u32 sLevelLayout_316F64[48] = INCBIN_U32("data/level/layout_316f64.bin");
const u32 sLevelLayout_317024[12] = INCBIN_U32("data/level/layout_317024.bin");
const u32 sLevelLayout_317054[10] = INCBIN_U32("data/level/layout_317054.bin");
const u32 sLevelLayout_31707C[22] = INCBIN_U32("data/level/layout_31707c.bin");
