#include "types.h"

/* Per-frame pitch/pan envelope tick for the sound subsystem.
 *
 * Called from sub_0802F4B0 (the per-VBlank mixer) over the slot table
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

typedef struct SlotEnvelope {
    s16 acc;     /* slot+0x2c */
    s16 step;    /* slot+0x2e */
    s8 negLimit; /* slot+0x30 */
    s8 posLimit; /* slot+0x31 */
} SlotEnvelope;

typedef struct SoundSlot {
    u8 _pad00[0x2c];
    SlotEnvelope envelope; /* agbcc rounds nested struct to 8 bytes here */
    u8 _pad34[2];
    u32 flags; /* slot+0x38 */
} SoundSlot;

typedef struct SoundMixEntry {
    u32 base; /* +0x00 */
    u8 _pad04[8];
    u32 outSample; /* +0x0c */
    u8 _pad10[16];
} SoundMixEntry; /* sizeof == 28 */

typedef struct SoundSystem {
    u8 count; /* +0x00 */
    u8 _pad01[0xbf];
    SoundMixEntry *mixTable; /* +0xc0 */
    u8 _padc4[8];
    SoundSlot **slotPtrTable; /* +0xcc */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

void sub_0802ED5C(void)
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
            if (slot != NULL && (slot->flags & 0x400)) {
                SlotEnvelope *env = &slot->envelope;
                register s32 acc asm("r1");
                register u16 stepU asm("r4");
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
                {
                    register u16 negStep asm("r0") = -stepU;
                    env->step = negStep;
                }
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
