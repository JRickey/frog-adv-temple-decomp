#include "sound.h"
#include "macros.h"

/* Per-frame pitch/pan envelope tick for the sound subsystem.
 *
 * Called from SoundMixer_VBlankUpdate (the per-VBlank mixer) over the slot table
 * pointed to by `(*gpSoundSystem)->slotPtrTable`. For each active slot
 * (flag bit 0x400 in `flags`), advances the signed accumulator in
 * `slot->envelope.acc` by `slot->envelope.step`, reflecting off the
 * ±limit walls held in `posLimit` / `negLimit`. The bounced value
 * (`>>8 + 16`) is then added to the per-channel mix entry at
 * `(*gpSoundSystem)->mixTable[i].base` and stored into `outSample`.
 *
 * Struct shapes here are scaffold-grade — sized for the offsets this
 * function touches. Promote to include/sound.h once a second sound-
 * system file lands and the offsets stabilize.
 *
 * Matching note: an explicit `&gpSoundSystem` cache (`gpsp`) inside
 * the count guard is what gets agbcc to emit `mov ip, r2` before
 * `movs r7, #0` in the loop prologue — without it, agbcc lazily caches
 * the address only when emitting the loop body, and the resulting
 * scheduler pick swaps those two instructions vs the baserom. Found by
 * decomp-permuter.
 */

void Sound_TickSlotEnvelopeB(void)
{
    SoundSlot **slotPtr;
    s32 i;
    s32 byteOffset;

    slotPtr = gpSoundSystem->slotPtrTable;
    i = 0;
    if (i < gpSoundSystem->count) {
        SoundSystem **gpsp = &gpSoundSystem;
        byteOffset = 0;
        do {
            SoundSlot *slot = *slotPtr;
            if (slot != NULL && (slot->flags & SOUND_SLOT_FLAG_ENVELOPE_B_ACTIVE)) {
                SlotEnvelope *env = &slot->envelope;
                register s32 acc asm("r1");
                u16 stepU;
                register s32 limit asm("r0");
                SoundMixEntry *entry;

                acc = slot->envelope.acc + env->step;
                stepU = env->step;
                if (env->step >= 0) {
                    limit = env->posLimit;
                    if (acc < (limit << 8))
                        goto apply;
                } else {
                    limit = env->negLimit;
                    if (acc > (limit << 8))
                        goto apply;
                }
                acc = (limit << 9) - acc;
                env->step = -stepU;
            apply:
                env->acc = acc;
                entry = (SoundMixEntry *)((u8 *)(*gpsp)->mixTable + byteOffset);
                acc = (s32)((u32)acc >> 8);
                acc += 16;
                entry->outSample = entry->base + acc;
            }
            byteOffset += 28;
            i++;
            slotPtr++;
        } while (i < (*gpsp)->count);
    }
}
