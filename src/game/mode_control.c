#include "iwram.h"

/* Resets the gIwram_6110 mode-control block and installs the per-mode config
 * table. Called once per dispatcher case in Scene08_Main's mode select; the
 * (limit, table, state, threshold) tuple varies by mode. `modeId` is accepted
 * by every caller but unused here. See src/data/mode_config_2f99e8.c for the
 * per-mode anchor inventory.
 *
 * Matching notes (old_agbcc):
 *   - The flags64, flagBank0, and flagBank1 stores clear as 64-bit stores,
 *     which old_agbcc emits through the r4/r5 pair.
 *   - `state` and `threshold` are byte-sized stack args. That keeps old_agbcc
 *     from sinking their stack loads to the tail of the clear sequence. */

void ModeControl_Init(struct IwramAt6110 *control, u32 limit, u32 modeId, const void *configTable, u8 state,
                      u8 threshold)
{
    control->flags0 = 0;
    control->flags64 = 0;
    control->flags2 = 0;
    control->scenePhase = 0;

    control->activeFlags = 1;
    control->selector5Flags = 0;
    control->selector6Flags = 0;
    control->byteFlags8 = 0;
    control->gateByte = 0;
    control->byteFlags7 = 0;
    control->inputFlags = 0;
    control->liveCount = 0;

    control->flagBank0 = 0;
    control->flagBank1 = 0;
    control->spawnMask = 0;

    control->threshold = threshold;
    control->state = state;
    control->limit = limit;
    control->configTable = (void *)configTable;
}
