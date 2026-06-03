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
/* sub_0802F398 — recompute and commit one slot's stereo pan into its mix entry.
 *
 * Standalone form of the per-slot pan stage that the mixer (sub_0802F4B0)
 * also runs inline. Given a slot index it advances the slot's volume scale,
 * maps the slot's 8-bit pan position (slot+0x3c) through a 3-segment bounce
 * curve into left/right gains scaled by that volume, then multiplies each
 * gain by the master pan base (gpSoundSystem+0xbe when slot flag 0x10000 is
 * set, else +0xbc) and commits the two gain bytes plus a mono flag into the
 * mix entry at gpSoundSystem[0xc0] + index*28, bracketed by the sound
 * mutation lock (sub_0802E418 / sub_0802E3F8).
 *
 *   pan in [0x00,0x3f]  — left-biased segment   (mono = 0)
 *   pan in [0x40,0x7f]  — right-biased segment   (mono = 0)
 *   pan >= 0x80         — both channels equal     (mono = 1)
 *
 * Matching notes: the SoundSystem base-pointer address is anchored in r2 and
 * re-dereferenced at every use (never cached) so agbcc emits one pool load;
 * the slot pointer lives in ip, idx/vol/mix in r5/r4/r7, and the mono flag in
 * r8 across the lock BL (high-register local), mirroring the void-return /
 * save-r8 prologue shape used throughout this sound cluster (sub_0802F2FC).
 * vol and panBase share r4 (vol is dead once the gains are scaled). The
 * baserom loads panBase into r0 then recolours it into r4 with an explicit
 * `adds r4, r0, #0`; agbcc would otherwise load straight into r4, so the
 * `asm("" : "=r"(panBase) : "0"(pbLoaded))` barrier reinstates that copy (a
 * register-recolour lever, not emitted code — see docs/codegen-notes.md).
 * The pan-curve coefficients (0x4ac8, 0xb538, 0xb818) are the same Q-format
 * constants the mixer's inline pan block uses.
 */

#define PAN_COEF_A 0x4ac8
#define PAN_COEF_B 0xb538
#define PAN_COEF_C 0xb818

typedef struct PanSlot {
    u8 _pad00[0x28];
    u16 pitchStep; /* +0x28 */
    u8 volCache;   /* +0x2a — written: scaled volume */
    u8 volScale;   /* +0x2b */
    u8 _pad2c[0xc];
    u32 flags; /* +0x38 */
    u8 panPos; /* +0x3c */
} PanSlot;

typedef struct PanMixEntry {
    u8 _pad00[0x18];
    u8 gainL; /* +0x18 */
    u8 gainR; /* +0x19 */
    u8 mono;  /* +0x1a */
} PanMixEntry;

typedef struct PanSoundSystem {
    u8 _pad00[0xbc];
    u16 panBase;    /* +0xbc */
    u16 panBaseAlt; /* +0xbe */
    u8 *mixTable;   /* +0xc0 */
    u8 _padc4[8];
    PanSlot **slotPtrTable; /* +0xcc */
} PanSoundSystem;

#define gpPanSystem (*(PanSoundSystem **)0x030065e0)

extern void sub_0802E418(void);
extern void sub_0802E3F8(void);

void sub_0802F398(s32 index)
{
    register s32 idx asm("r5");
    register PanSoundSystem **gpsp asm("r2");
    register PanSlot *slot asm("ip");
    PanMixEntry *mix;
    register u32 vol asm("r4");
    u32 pan;
    u32 gainL;
    u32 gainR;
    u32 t;
    register u32 mono asm("r8");
    register u32 panBase asm("r4");
    u16 *pbp;

    idx = index;
    gpsp = &gpPanSystem;
    slot = (*gpsp)->slotPtrTable[idx];
    if (slot == NULL)
        return;

    vol = slot->pitchStep >> 8;
    if (vol != 0)
        vol++;
    t = slot->volScale * vol << 8;
    vol = t >> 16;
    slot->volCache = vol;

    pan = *((u8 *)&slot->volCache + 0x12);

    mix = (PanMixEntry *)((*gpsp)->mixTable + idx * 28);

    if ((pan << 24) >> 24 <= 0x3f) {
        gainL = (u8)((s32)(((u32)((s32)((0x40 - pan) * PAN_COEF_A) >> 6) + PAN_COEF_B) * vol) >> 16);
        t = (s32)(PAN_COEF_C * pan) >> 6;
        gainR = (u8)((s32)(t * vol) >> 16);
        mono = 0;
    } else if ((s32)(pan << 24) >= 0) {
        gainL = (u8)((s32)(((s32)((0x7f - pan) * PAN_COEF_C) >> 6) * vol) >> 16);
        t = (u32)((s32)((pan - 0x3f) * PAN_COEF_A) >> 6) + PAN_COEF_B;
        gainR = (u8)((s32)(t * vol) >> 16);
        mono = 0;
    } else {
        gainR = (u8)((s32)(PAN_COEF_B * vol) >> 16);
        gainL = gainR;
        mono = 1;
    }

    {
        register PanSlot *sf asm("r1");
        sf = slot;
        if (sf->flags & 0x10000)
            pbp = &(*gpsp)->panBaseAlt;
        else
            pbp = &(*gpsp)->panBase;
    }
    {
        register u32 pbLoaded asm("r0");
        pbLoaded = *pbp;
        asm("" : "=r"(panBase) : "0"(pbLoaded));
    }

    sub_0802E418();
    mix->gainL = (s32)(gainL * panBase) >> 8;
    mix->gainR = (s32)(gainR * panBase) >> 8;
    mix->mono = mono;
    sub_0802E3F8();
}
