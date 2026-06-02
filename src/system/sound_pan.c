#include "sound.h"

/* sub_0802F2FC — per-frame pan-envelope tick.
 *
 * Sister of sub_0802ED5C (envelope B at +0x2c) and sub_0802EC7C (envelope A
 * at +0x1c). This one drives the per-slot pan envelope: a triangular-bounce
 * accumulator at slot+0xa (acc) / slot+0x12 (step) clamped against byte limits
 * stored in slot+0x1a (negLimit) / slot+0x1b (posLimit), scaled << 8. The
 * 8-bit-shifted MSB of the new accumulator is the current pan value; it is
 * cached in slot+0x3c and any change flips the slot.flags dirty bit 0x80 so
 * the mixer reapplies pan on the next mix step.
 *
 * One additional twist: on a bounce against either limit, the step writeback is
 * slot.flags & 0x2000; that non-zero value is replaced with -oldStep, while a
 * clear flag stores 0.
 *
 * Companion to sub_0802ED5C (volume envelope, +0x2c block) and sub_0802EC7C
 * (envelope A at +0x1c). Called sequentially from sub_0802F4B0, the
 * per-VBlank mixer driver.
 *
 * Matching notes: the register pins keep the loop state in the same registers
 * as the baserom, while the two tiny inline-asm assists preserve agbcc's r6
 * choices for the pan-acc and negative-limit loads. Replacing those assists
 * with plain C is semantically fine but leaves the linked function byte_diff 12
 * (or 9 with autoReverseMask pinned to r7) because agbcc insists on r0 for
 * those load temps. The empty stepCopy barriers are also required: removing
 * them shrinks the function and shifts branches to byte_diff 97.
 */

void sub_0802F2FC(void)
{
    register SoundSystem **gpsp asm("r1");
    register SoundSystem **gpspCache asm("ip");
    register SoundSlot *slot asm("r3");
    register SoundSlot *slotCache asm("r8");
    register s32 i asm("r5");
    register s32 step asm("r2");
    register u16 savedStep asm("r4");
    register s32 sum asm("r1");
    register s32 stepCopy asm("r0");
    u32 autoReverseMask;
    SoundSystem *ss;
    s32 writeStep;

    i = 0;
    gpsp = &gpSoundSystem;
    ss = *gpsp;
    gpspCache = gpsp;
    if (i >= ss->count)
        return;

    autoReverseMask = SOUND_SLOT_FLAG_PAN_AUTO_REVERSE;
body:
    slot = SOUND_SYSTEM_SLOT_PTR_TABLE(*gpsp)[i];
    if (slot == NULL)
        goto advance;
    slotCache = slot;
    savedStep = (u16)SOUND_SLOT_PAN_STEP(slot);
    step = SOUND_SLOT_PAN_STEP(slot);
    if (step == 0)
        goto advance;
    asm("mov r6, #0xa\n\tldrsh %0, [%1, r6]" : "=r"(sum) : "r"(slot) : "r6");
    stepCopy = step;
    asm("" : "+r"(stepCopy));
    sum += stepCopy;
    if (step > 0) {
        step = *((u8 *)slot + 0x1b) << 8;
        if (sum >= step) {
            stepCopy = sum - step;
            asm("" : "+r"(stepCopy));
            sum = step - stepCopy;
            goto bounce;
        } else {
            goto write_acc;
        }
    } else {
        asm("ldrb r6, [%1, #0x1a]\n\tlsl %0, r6, #0x8" : "=r"(step) : "r"(slot) : "r6");
        if (sum <= step) {
            stepCopy = step - sum;
            asm("" : "+r"(stepCopy));
            sum = step + stepCopy;
        bounce:
            writeStep = slot->flags & autoReverseMask;
            if (writeStep != 0)
                writeStep = -savedStep;
            SOUND_SLOT_PAN_STEP(slot) = writeStep;
        } else {
            goto write_acc;
        }
    }
write_acc:
    ((SoundSlotPanAccView *)slotCache)->panAcc = (s16)sum;
    {
        register u8 *panCachep asm("r2");
        register s32 newPan asm("r0");

        newPan = sum >> 8; /* arithmetic — sum is signed */
        panCachep = &slot->panCache;
        if (newPan != *panCachep) {
            *panCachep = (u8)newPan;
            slot->flags |= SOUND_FLAG_UPDATE_DIRTY;
        }
    }
advance:
    i++;
    gpsp = gpspCache;
    if (i < (*gpsp)->count)
        goto body;
}
