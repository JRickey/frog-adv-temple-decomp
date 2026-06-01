#include "sound.h"
#include "macros.h"

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
 * Shipped as NAKED inline asm + NON_MATCHING reference C. The baserom
 * pattern `ldr r0, [pc, #N]; mov ip, r0; mov r6, ip` keeps gpSoundSystem
 * cached across both stages — r6 active in stage 1 and ip live across
 * both for the count-check reload. agbcc 2.x picks a different register
 * allocation here regardless of source structure: it spills *gpsp into a
 * callee-saved low register (r5) during stage 1 and reuses that across
 * the stage transition, but no pinning idiom recovered the baserom shape.
 * 500+ permuter iterations converged at score ~1015 (vs 0 = match) with
 * register-allocation drift alone. Like sub_0802EC7C / sub_0802EDF0, the
 * readable C is preserved behind NON_MATCHING; the NAKED form ships the
 * baserom bytes.
 */

/* Mirror of the SoundSlot / SoundSystem layout used in sound_channel.c
 * (sub_0802EC7C / sub_0802ED5C). Envelope-A0 lives at +0x14 inside each
 * channel/slot; envelope-A at +0x1c and envelope-B at +0x2c are owned by
 * sound_channel.c. Promote to include/sound.h once a common header is
 * needed. */
#ifdef NON_MATCHING
void sub_0802EA80(void)
{
    SoundSystem **gpsp;
    SoundSystem *ss;
    SoundSlot *slot;
    SlotEnvelopeA0 *env;
    s32 i;
    s32 offset;
    s16 step;
    u16 acc;
    u8 ctr;

    i = 0;
    gpsp = &gpSoundSystem;
    offset = 32;

    /* Stage 1: three inline channel envelopes embedded in SoundSystem
     * itself at ss+0x34, ss+0x58, ss+0x7c (stride 36, envelope at +0x14
     * inside each). */
    do {
        ss = *gpsp;
        env = (SlotEnvelopeA0 *)((u8 *)ss + offset + 0x14);
        step = env->step;
        if (step != 0) {
            acc = (u16)(env->acc + step);
            env->acc = acc;
            ctr = env->countdown - 1;
            env->countdown = ctr;
            if (ctr == 0xff) {
                env->countdown = env->reload;
                env->step = -env->step;
            }
            ((u32 *)((u8 *)(*gpsp) + 0x10))[i] |= 0x40;
        }
        offset += 36;
        i++;
    } while (i <= 2);

    /* Stage 2: per-slot envelope-A0 bank, walked via slotPtrTable. */
    i = 0;
    while (i < (*gpsp)->count) {
        slot = (*gpsp)->slotPtrTable[i];
        if (slot != NULL) {
            env = &slot->envelopeA0;
            step = env->step;
            if (step != 0) {
                acc = (u16)(env->acc + step);
                env->acc = acc;
                ctr = env->countdown - 1;
                env->countdown = ctr;
                if (ctr == 0xff) {
                    env->countdown = env->reload;
                    env->step = -env->step;
                }
                slot->flags |= 0x40;
            }
        }
        i++;
    }
}
#else
NAKED
void sub_0802EA80(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    movs    r4, #0\n"
        "    ldr     r0, _0802EAD8            @ =gpSoundSystem (0x030065e0)\n"
        "    mov     ip, r0\n"
        "    mov     r6, ip\n"
        "    movs    r5, #0x20\n"
        "_0802EA8C:\n"
        "    ldr     r0, [r6, #0]\n"
        "    adds    r2, r0, r5\n"
        "    adds    r1, r2, #0\n"
        "    adds    r1, #0x14\n"
        "    ldrh    r3, [r1, #2]\n"
        "    movs    r7, #2\n"
        "    ldrsh   r0, [r1, r7]\n"
        "    cmp     r0, #0\n"
        "    beq     _0802EACC\n"
        "    ldrh    r7, [r2, #0x14]\n"
        "    adds    r0, r3, r7\n"
        "    strh    r0, [r2, #0x14]\n"
        "    ldrb    r0, [r1, #4]\n"
        "    subs    r0, #1\n"
        "    strb    r0, [r1, #4]\n"
        "    lsls    r0, r0, #0x18\n"
        "    lsrs    r0, r0, #0x18\n"
        "    cmp     r0, #0xff\n"
        "    bne     _0802EABC\n"
        "    ldrb    r0, [r1, #5]\n"
        "    strb    r0, [r1, #4]\n"
        "    ldrh    r2, [r1, #2]\n"
        "    negs    r0, r2\n"
        "    strh    r0, [r1, #2]\n"
        "_0802EABC:\n"
        "    ldr     r2, [r6, #0]\n"
        "    lsls    r0, r4, #2\n"
        "    adds    r2, #0x10\n"
        "    adds    r2, r2, r0\n"
        "    ldr     r0, [r2, #0]\n"
        "    movs    r1, #0x40\n"
        "    orrs    r0, r1\n"
        "    str     r0, [r2, #0]\n"
        "_0802EACC:\n"
        "    adds    r5, #0x24\n"
        "    adds    r4, #1\n"
        "    cmp     r4, #2\n"
        "    ble     _0802EA8C\n"
        "    movs    r4, #0\n"
        "    b       _0802EB22\n"
        "    .align  2, 0\n"
        "_0802EAD8: .4byte 0x030065e0\n"
        "_0802EADC:\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0xcc\n"
        "    ldr     r1, [r0, #0]\n"
        "    lsls    r0, r4, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r2, [r0, #0]\n"
        "    cmp     r2, #0\n"
        "    beq     _0802EB20\n"
        "    adds    r1, r2, #0\n"
        "    adds    r1, #0x14\n"
        "    ldrh    r3, [r1, #2]\n"
        "    movs    r5, #2\n"
        "    ldrsh   r0, [r1, r5]\n"
        "    cmp     r0, #0\n"
        "    beq     _0802EB20\n"
        "    ldrh    r7, [r2, #0x14]\n"
        "    adds    r0, r3, r7\n"
        "    strh    r0, [r2, #0x14]\n"
        "    ldrb    r0, [r1, #4]\n"
        "    subs    r0, #1\n"
        "    strb    r0, [r1, #4]\n"
        "    lsls    r0, r0, #0x18\n"
        "    lsrs    r0, r0, #0x18\n"
        "    cmp     r0, #0xff\n"
        "    bne     _0802EB18\n"
        "    ldrb    r0, [r1, #5]\n"
        "    strb    r0, [r1, #4]\n"
        "    ldrh    r3, [r1, #2]\n"
        "    negs    r0, r3\n"
        "    strh    r0, [r1, #2]\n"
        "_0802EB18:\n"
        "    ldr     r0, [r2, #0x38]\n"
        "    movs    r1, #0x40\n"
        "    orrs    r0, r1\n"
        "    str     r0, [r2, #0x38]\n"
        "_0802EB20:\n"
        "    adds    r4, #1\n"
        "_0802EB22:\n"
        "    mov     r1, ip\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r4, r0\n"
        "    blt     _0802EADC\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .hword  0x0000\n"
        "    .syntax divided\n");
}
#endif
