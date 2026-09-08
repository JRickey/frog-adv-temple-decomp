#include "macros.h"
#include "level_layout_data.h"
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
 * The 25-entry window at 0x08315ae0 is a typed pointer table to the
 * contiguous 32-byte path records at 0x08315280. The prefix and suffix
 * remain extracted raw data.
 *
 * TODO: confirm field semantics once 0x08026xxx consumers land in C.
 * Likely a per-world / per-stage selector with 90 stages. */

const u32 sLevelLayoutDispatchPrefix_315A48[38] = INCBIN_U32("data/level/layout_ptrs_315a48.bin");

const LevelLayout3 *const sLevelLayoutDispatch_315AE0[25] = {
    &sLevelLayoutData_315280[0],  &sLevelLayoutData_315280[1],  &sLevelLayoutData_315280[2],
    &sLevelLayoutData_315280[3],  &sLevelLayoutData_315280[4],  &sLevelLayoutData_315280[5],
    &sLevelLayoutData_315280[6],  &sLevelLayoutData_315280[7],  &sLevelLayoutData_315280[8],
    &sLevelLayoutData_315280[9],  &sLevelLayoutData_315280[10], &sLevelLayoutData_315280[11],
    &sLevelLayoutData_315280[12], &sLevelLayoutData_315280[13], &sLevelLayoutData_315280[14],
    &sLevelLayoutData_315280[15], &sLevelLayoutData_315280[16], &sLevelLayoutData_315280[17],
    &sLevelLayoutData_315280[18], &sLevelLayoutData_315280[19], &sLevelLayoutData_315280[20],
    &sLevelLayoutData_315280[21], &sLevelLayoutData_315280[22], &sLevelLayoutData_315280[23],
    &sLevelLayoutData_315280[24],
};

const u32 sLevelLayoutDispatchRaw_315B44[27] = INCBIN_U32("data/level/layout_raw_315b44.bin");
