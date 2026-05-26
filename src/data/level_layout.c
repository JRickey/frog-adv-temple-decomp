#include "macros.h"
#include "types.h"

/* Level/room-layout anchors flagged by the data-extraction pass.
 *
 * Each table is 32 bytes: an 8-byte header { u32 mask, u32 count }
 * followed by three 8-byte records { u32 coord, u32 type }. Both tables
 * use the same header value 0x00040302 / 0x00000001; the third field of
 * the trailing record uses sentinel 0x00000007 in both tables.
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
 * around 0x08028af0 land in C. The pair likely encodes two related
 * room/section descriptors that the renderer chooses between via a
 * mode flag. */

const u32 sLevelLayout_316F24[8] = INCBIN_U32("data/level/layout_316f24.bin");
const u32 sLevelLayout_316F44[8] = INCBIN_U32("data/level/layout_316f44.bin");
