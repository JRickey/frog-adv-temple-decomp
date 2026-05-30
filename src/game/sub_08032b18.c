#include "types.h"

/* SoundSlot_PickByPriority — slot arbitration for the sound system. Given a
 * candidate priority and a slot index (or 0xFF to scan), decides which sound
 * slot a new request may claim.
 *
 * With an explicit index (idx != 0xFF): accept the slot unless it is occupied
 * by a higher-priority record (slotPtrTable[idx]->priority > priority), in
 * which case return -1.
 *
 * With idx == 0xFF: scan the active window [startIndex, count) of
 * slotPtrTable[] for the lowest-priority record (ties broken by the lower +0x36
 * secondary key). An empty slot in the window is taken immediately. If the
 * weakest record found still outranks the request, return -1; otherwise return
 * its index.
 *
 * arg0 and arg2 are passed by every call site (a flag and a 0xFF sentinel) but
 * unused here — kept in the signature so the prologue/arg registers match.
 *
 * Matching notes:
 *   - `priority` is u32 (not the u16 it semantically is): the baserom keeps the
 *     raw arg in ip with no `lsl/lsr` zero-extension, and every priority compare
 *     is unsigned (`bhi`/`bcs`). A u16 param both truncates the arg and flips the
 *     compares to signed.
 *   - `bestIdx` (r7) is initialised before `minPri` so the baserom's `movs r7,#0`
 *     lands ahead of the `ip+1` materialise.
 *   - `minSec` seeded as 0x10000 (0x80 << 9) — a u32 sentinel above any u16.
 *   - The early-index path keeps `slot != NULL && slot->priority > priority` as
 *     one short-circuit so the null test feeds the same fall-through to
 *     `return idx` that the baserom's `beq` does.
 */

typedef struct SoundSlot {
    u8 _pad00[0x34];
    u16 priority;  /* +0x34 */
    u16 secondary; /* +0x36 */
} SoundSlot;

typedef struct SoundSystem {
    u8 count;      /* +0x00 */
    u8 startIndex; /* +0x01 */
    u8 _pad02[0xca];
    SoundSlot **slotPtrTable; /* +0xcc */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

s32 SoundSlot_PickByPriority(s32 a0, u32 priority, s32 a2, s32 idx)
{
    SoundSlot *slot;
    s32 i;
    s32 bestIdx;
    u32 minPri;
    u32 minSec;

    if (idx != 0xff) {
        slot = gpSoundSystem->slotPtrTable[idx];
        if (slot != NULL && slot->priority > priority)
            return -1;
        return idx;
    }

    bestIdx = 0;
    minPri = priority + 1;
    minSec = 0x10000;

    for (i = gpSoundSystem->startIndex; i < gpSoundSystem->count; i++) {
        slot = gpSoundSystem->slotPtrTable[i];
        if (slot == NULL)
            return i;

        if (slot->priority < minPri) {
            minPri = slot->priority;
            minSec = slot->secondary;
            bestIdx = i;
        } else if (slot->priority == minPri && slot->secondary < minSec) {
            minSec = slot->secondary;
            bestIdx = i;
        }
    }

    if (minPri > priority)
        return -1;

    return bestIdx;
}
