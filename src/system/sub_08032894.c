#include "sound.h"
#include "macros.h"

/* SoundSlot_InitParams — sound slot initializer.
 *
 * Pure leaf (no callees, no globals). Clears the streaming/envelope state
 * of a SoundSlot-shaped object and primes the per-slot mixer constants:
 * pan reset at +0x28, countdown reset at +0x36, countdown step = 1 at +0x3f,
 * plus the +0x22 mixer accumulator preset to (slot[0] + slot[0x1c]).
 *
 * Matching notes:
 *   - Built with OLD_AGBCC_BIN (Makefile override). Under the newer agbcc
 *     the +0x22 sum statement allocates r0 (not r4) for the first ldrh
 *     and gets stuck at byte_diff 2; old_agbcc picks r4 naturally.
 *   - Args are u32 (not u8/u16). agbcc's narrowing for sub-word args
 *     (lsls/lsrs pair) is not in the baserom — only the `adds rD, rS, #0`
 *     register-copy prologue, which is what u32-wide args generate. The
 *     `period` write nonetheless tests the LOW BYTE explicitly because
 *     the asm `lsls #24; cmp #0` is a u8 truncation, not a full-word zero
 *     check; that's preserved here with an explicit `(u8)` cast.
 */

void SoundSlot_InitParams(SoundSlotInit *slot, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
{
    slot->byte_3d = 0;
    slot->panReset = SOUND_CHANNEL_PAN_RESET;
    slot->countdown = SOUND_CHANNEL_COUNTDOWN_RESET;
    slot->countdownStep = 1;

    arg3 <<= 1;
    slot->period = arg3;
    if ((u8)arg3 != 0)
        slot->period = arg3 + 1;

    slot->gate = 0;
    slot->flags = 0;
    slot->panCache = arg2;
    slot->priority = arg4;
    slot->accSumTarget = slot->acc0 + slot->acc5;

    slot->acc0 = arg1 << 8;
    slot->acc1 = 0;
    slot->acc5 = 0;
    slot->acc5Step = 0;
    slot->acc5Limit = 0;
    slot->acc4 = 0;
    slot->acc4Step = 0;
    slot->acc2 = 0;
    slot->acc2Step = 0;
    slot->acc3 = 0;
    slot->acc3Step = 0;
    slot->acc3Limit = 0;
}
