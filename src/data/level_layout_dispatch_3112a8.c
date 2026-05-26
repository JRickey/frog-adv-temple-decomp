#include "macros.h"
#include "types.h"

/* Small dispatch array of 8 sub-table pointers at 0x083112a8.
 *
 * Each pointer targets a 32-byte sub-table in the preceding region
 * [0x083111a8..0x083112a8) -- the same {u16, u16, u32 count} + 3
 * 8-byte records shape used elsewhere in the level-layout cluster.
 *
 * 4 pool-load references from consumers in the still-asm range
 * [0x080220ca..0x08022126]. Anchor reported by
 * refcount_pool_loads.py iter-5 brief.
 *
 * Followed by another sub-table cluster starting at 0x083112c8 (with
 * the familiar `{u16 a=2, u16 b, u32 count=3} + records` header). Not
 * extracted here -- the sub-tables remain in text_0x083112c8.s until
 * a future pass groups them with their consumers.
 *
 * TODO: confirm field semantics once 0x08022xxx consumers land in C.
 * Likely a per-mode / per-level lookup with 8 modes worth of variant
 * mini-tables. */

const u32 sLevelLayoutDispatch_3112A8[8] = INCBIN_U32("data/level/layout_ptrs_3112a8.bin");
