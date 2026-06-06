#include "sound.h"

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

/* SoundChannel_CheckPriority — hardware-channel volume gate. Compares the stored hw control
 * halfword for channel idx against an adjusted threshold (threshold + 0x100 if
 * flag is set). Returns 1 if the stored value is <= the threshold (channel is
 * within the allowed range), 0 otherwise.
 *
 * Matching notes:
 *   - Must be compiled with OLD_AGBCC_BIN: the regular agbcc emits
 *     `push {lr}` / `pop {pc}` even for this leaf, while old_agbcc with
 *     -mthumb-interwork correctly elides the prologue and emits `bx lr`.
 *   - The inverted test (<=, return-1-first) matches the baserom's `bls`
 *     branch to the return-1 block with return-0 as the fall-through.
 */
u32 SoundChannel_CheckPriority(u32 flag, u32 threshold, u32 idx)
{
    u32 adj;

    adj = threshold;
    if (flag != 0)
        adj += 0x100;

    if (gpSoundSystem->chanAcc[idx] <= adj)
        return 1;
    return 0;
}

/* SoundVoice_Init — initializes fields of a sound voice struct. Takes a pointer
 * to the voice, a step value (stored shifted as step<<8 at +0x00), a flags
 * byte (doubled and conditionally incremented at +0x2b), and a priority
 * halfword (stored at +0x34). Also sets the secondary key to 0xC000 (+0x36),
 * sets a byte at +0x3f to 1, and clears control bits in the u32 at +0x38.
 * Finally, reads signed halfwords from +0x00 (old value) and +0x1c, sums
 * them, and stores the result at +0x22 — before overwriting +0x00 with step<<8.
 */
typedef struct SoundVoice {
    s16 field_00; /* +0x00 */
    u8 _pad02[0x1a];
    s16 field_1c; /* +0x1c */
    u8 _pad1e[4];
    u16 field_22; /* +0x22 */
    u8 _pad24[7];
    u8 field_2b; /* +0x2b */
    u8 _pad2c[8];
    u16 field_34; /* +0x34 */
    u16 field_36; /* +0x36 */
    u32 field_38; /* +0x38 */
    u8 _pad3c[3];
    u8 field_3f; /* +0x3f */
} SoundVoice;

void SoundVoice_Init(SoundVoice *p, u32 a1, u32 a2, u32 a3)
{
    s16 f00;
    s16 f1c;

    p->field_36 = 0xC000;
    p->field_3f = 1;
    p->field_38 &= 0xffff7eef;

    a2 <<= 1;
    p->field_2b = (u8)a2;
    if (a2 << 24)
        p->field_2b = (u8)(a2 + 1);

    p->field_34 = (u16)a3;

    f00 = p->field_00;
    f1c = p->field_1c;
    p->field_22 = (u16)(f00 + f1c);

    p->field_00 = (s16)((u16)(a1 << 8));
}
