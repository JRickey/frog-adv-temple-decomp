#include "macros.h"
#include "types.h"

/* Large dispatch array of 90 sub-table pointers at 0x08315a48.
 *
 * Each pointer targets a 32-byte sub-table in the preceding region
 * [0x08314c00..0x08315a48) -- same {u16, u16, u32 count} + records
 * shape as the rest of the level-layout cluster.
 *
 * Interior anchor 0x08315adc (4 pool-load refs from consumers at
 * 0x080260cc, 0x08026384, 0x08026a5e, etc.) is at entry 37
 * (offset 0x94) of this array. Consumers index relative to that
 * interior base.
 *
 * No 0xffffffff sentinels at the end -- the array ends at 0x08315bb0
 * where a `{u32 X, u32 0}` header-list pattern resumes (analogous to
 * the [0x08317b54..0x08317bac) prelude that follows sLevelLayoutPtrs).
 *
 * TODO: confirm field semantics once 0x08026xxx consumers land in C.
 * Likely a per-world / per-stage selector with 90 stages. */

const u32 sLevelLayoutDispatch_315A48[90] = INCBIN_U32("data/level/layout_ptrs_315a48.bin");
