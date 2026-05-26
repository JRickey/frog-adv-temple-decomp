#include "macros.h"
#include "types.h"

/* Mid-sized dispatch array of 35 sub-table pointers + 2 sentinels at
 * 0x08316dc8.
 *
 * Each pointer targets a 32..48-byte sub-table in the preceding region
 * [0x08316770..0x08316dc8) -- same {u16, u16, u32 count} + records
 * shape as the rest of the level-layout cluster. The last two real
 * entries (0x08316770, 0x08316788) point upstream past the start of
 * the local sub-table backing store -- evidence that these pointers
 * sometimes alias entries owned by an adjacent dispatcher.
 *
 * Interior anchor 0x08316e3c (4 pool-load refs from consumers at
 * 0x08027c88, 0x08027cb2, 0x08027cde, etc.) is at entry 29
 * (offset 0x74) of this array.
 *
 * Followed by two 0xffffffff sentinels then a `{u32 X, u32 0}`
 * header-list (same pattern as 0x08317b54 prelude).
 *
 * TODO: confirm field semantics once 0x08027xxx consumers land in C. */

const u32 sLevelLayoutDispatch_316DC8[37] = INCBIN_U32("data/level/layout_ptrs_316dc8.bin");
