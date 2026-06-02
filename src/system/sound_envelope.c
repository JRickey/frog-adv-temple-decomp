#include "sound.h"

/* sub_0802EA80 — per-frame countdown-bounce envelope tick (envelope-A0).
 *
 * Sister of sub_0802EC7C in sound_channel.c. Same two-stage shape — three
 * inline channel envelopes embedded in SoundSystem itself, then a per-slot
 * bank walked via slotPtrTable — but each channel/slot exposes a SECOND
 * envelope block at +0x14 (envelope-A0), and the bounce model is different:
 * a 1-byte countdown ticks down each frame and, on 0xff underflow, reloads
 * from a paired reload byte while negating the envelope step. No
 * triangular acc-limit clamp here; the envelope simply oscillates on a
 * fixed frame schedule.
 *
 * Stage 1 (3 iterations, fixed): three inline channel envelopes embedded
 * in SoundSystem itself at ss+0x34, ss+0x58, ss+0x7c (stride 36, envelope
 * at +0x14 inside each). On every step the envelope step is accumulated
 * into the envelope acc; when the countdown wraps from 0 to 0xff, the
 * step is negated and the countdown is reloaded. Whenever step != 0
 * (whether or not a bounce fired) ss->chFlags[i] gets a 0x40 dirty bit
 * ORd in.
 *
 * Stage 2 (ss->count iterations): per-slot envelope-A0 bank, walked via
 * ss->slotPtrTable[i]. Same accumulate + countdown-bounce shape; on each
 * tick the slot flags get 0x40 ORd in (whenever the slot is present and
 * step is non-zero).
 *
 * Matching notes:
 *   - `i`, `offset`, and the gpSoundSystem mirror are pinned to match the
 *     baserom's two-stage loop lifetime.
 *   - The inline `add` preserves the ROM's commutative Thumb encoding; agbcc
 *     otherwise emits the operands in the opposite order.
 */

void sub_0802EA80(void)
{
    register SoundSystem **gpsp asm("ip");
    register SoundSystem **gpspMirror asm("r6");
    register SoundSystem **gpCheck asm("r1");
    SoundSystem *ss;
    SoundSlot *slot;
    SlotEnvelopeA0 *env;
    register s32 i asm("r4");
    register s32 offset asm("r5");
    s16 step;
    u16 acc;
    s32 ctr;

    i = 0;
    gpsp = &gpSoundSystem;
    gpspMirror = gpsp;
    offset = SOUND_INLINE_CHANNEL_BASE_OFFSET;

    /* Stage 1: three inline channel envelopes embedded in SoundSystem
     * itself at ss+0x34, ss+0x58, ss+0x7c (stride 36, envelope at +0x14
     * inside each). */
    do {
        ss = *gpspMirror;
        env = SOUND_INLINE_CHANNEL_ENVELOPE_A0_AT(ss, offset);
        step = env->step;
        if (step != 0) {
            acc = env->acc;
            asm("add %0, %1, %2" : "=r"(acc) : "r"(step), "r"(acc));
            env->acc = acc;
            ctr = env->countdown - 1;
            env->countdown = ctr;
            ctr = (u8)ctr;
            if (ctr == SOUND_ENVELOPE_COUNTDOWN_UNDERFLOW) {
                env->countdown = env->reload;
                env->step = -env->step;
            }
            {
                s32 flagOffset;
                register u32 *flags asm("r2");

                flags = (u32 *)*gpspMirror;
                flagOffset = i << 2;
                flags = (u32 *)((u8 *)flags + SOUND_CH_FLAGS_OFFSET);
                flags = (u32 *)((u8 *)flags + flagOffset);
                *flags |= SOUND_FLAG_ENV_DIRTY;
            }
        }
        offset += SOUND_INLINE_CHANNEL_STRIDE;
        i++;
    } while (i <= SOUND_INLINE_CHANNEL_COUNT - 1);

    /* Stage 2: per-slot envelope-A0 bank, walked via slotPtrTable. */
    i = 0;
    goto count_check;
body:
    slot = SOUND_SYSTEM_SLOT_PTR_TABLE(*gpCheck)[i];
    if (slot != NULL) {
        env = &slot->envelopeA0;
        step = env->step;
        if (step != 0) {
            acc = env->acc;
            asm("add %0, %1, %2" : "=r"(acc) : "r"(step), "r"(acc));
            env->acc = acc;
            ctr = env->countdown - 1;
            env->countdown = ctr;
            ctr = (u8)ctr;
            if (ctr == SOUND_ENVELOPE_COUNTDOWN_UNDERFLOW) {
                env->countdown = env->reload;
                env->step = -env->step;
            }
            slot->flags |= SOUND_FLAG_ENV_DIRTY;
        }
    }
    i++;
count_check:
    gpCheck = gpsp;
    if (i < (*gpCheck)->count)
        goto body;
}
