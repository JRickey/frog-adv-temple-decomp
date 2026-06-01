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

/* Mirror of the SoundSlot / SoundSystem layout used in sound_channel.c
 * (sub_0802EC7C / sub_0802ED5C). Envelope-A0 lives at +0x14 inside each
 * channel/slot; envelope-A at +0x1c and envelope-B at +0x2c are owned by
 * sound_channel.c. Promote to include/sound.h once a common header is
 * needed. */
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
    offset = 32;

    /* Stage 1: three inline channel envelopes embedded in SoundSystem
     * itself at ss+0x34, ss+0x58, ss+0x7c (stride 36, envelope at +0x14
     * inside each). */
    do {
        ss = *gpspMirror;
        env = (SlotEnvelopeA0 *)((u8 *)ss + offset + 0x14);
        step = env->step;
        if (step != 0) {
            acc = env->acc;
            asm("add %0, %1, %2" : "=r"(acc) : "r"(step), "r"(acc));
            env->acc = acc;
            ctr = env->countdown - 1;
            env->countdown = ctr;
            ctr = (u8)ctr;
            if (ctr == 0xff) {
                env->countdown = env->reload;
                env->step = -env->step;
            }
            {
                s32 flagOffset;
                register u32 *flags asm("r2");

                flags = (u32 *)*gpspMirror;
                flagOffset = i << 2;
                flags = (u32 *)((u8 *)flags + 0x10);
                flags = (u32 *)((u8 *)flags + flagOffset);
                *flags |= 0x40;
            }
        }
        offset += 36;
        i++;
    } while (i <= 2);

    /* Stage 2: per-slot envelope-A0 bank, walked via slotPtrTable. */
    i = 0;
    goto count_check;
body:
    slot = (*gpCheck)->slotPtrTable[i];
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
            if (ctr == 0xff) {
                env->countdown = env->reload;
                env->step = -env->step;
            }
            slot->flags |= 0x40;
        }
    }
    i++;
count_check:
    gpCheck = gpsp;
    if (i < (*gpCheck)->count)
        goto body;
}
