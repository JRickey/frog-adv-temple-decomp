#include "types.h"

/* sub_0802E724 — per-channel silence/reset.
 *
 * Counterpart to the volume/period/pan envelope setters in this cluster.
 * Stops a channel by clearing its dirty-flag bits, zeroing the per-channel
 * MMIO output state, and (for the higher software-mixed slot range) clearing
 * the slot's "active" flag.
 *
 * Channels 0..3 are the DMG-style PSG channels; ch 4..N are software-mixed
 * slots tracked through tables hung off gpSoundSystem at +0xC4 / +0xC8.
 *
 *   ch in {0,1,3}: clear bits 0x21 from chDirty[ch], write 0x800 (reset env)
 *                  to sChannelRegTable[ch], write 0x8000 (key-off) to
 *                  sChannelFreqRegTable[ch]. (ch in {0,1} also clears the
 *                  per-channel half-word at +0xB4 + ch*2.)
 *   ch == 2:       clear bits 0x21 from chDirty[2], clear the +0xB8 half-word,
 *                  write 0 to sChannelRegTable[2] (the wave channel uses a
 *                  separate volume code, not the env bits), write 0x8000 to
 *                  sChannelFreqRegTable[2].
 *   ch >= 4:       idx = ch - 4. Clear the idx-th word in the +0xC4 pointer
 *                  array. Walk the slot array at +0xC8 to slot[idx] (64-byte
 *                  stride) and clear bit 0x200 in slot->flags (+0x38).
 */

typedef struct SoundSlot {
    u8 _pad00[0x38];
    u32 flags; /* +0x38 — 0x200 = "active" */
} SoundSlot;

typedef struct SoundSystem {
    u8 _pad00[0x10];
    u32 chDirty[4]; /* +0x10 — per-channel dirty flags */
    u8 _pad20[0x94];
    u16 chWaveBuf[4]; /* +0xB4 — per-channel halfword scratch (ch 0..2) */
    u8 _padBC[0x8];
    u32 *swSlotResetTab; /* +0xC4 — pointer table cleared for software slots */
    SoundSlot *swSlots;  /* +0xC8 — base of the 64-byte software slot array */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

extern vu16 *const sChannelFreqRegTable[4];
extern vu16 *const sChannelRegTable[4];

/* Matching notes:
 *   - Mask `~0x21` is emitted as `movs r2, #0x22; negs r2, r2; ands r0, r2`
 *     (Thumb-1 has no `mvn #imm`); the inverse-of-positive trick happens
 *     because `-0x22 == 0xFFFFFFDE == ~0x21`.
 *   - The big-slot path (ch >= 4) needs ss in a caller-save scratch (r2)
 *     so agbcc can emit the in-place `adds r2, #0xc8` between the +0xc4
 *     and +0xc8 accesses. Register-pinning + an empty-asm reinterpret of
 *     `offset` as `slot` (r1) seeds the `adds r1, r1, r0` operand order
 *     the baserom uses — without the reinterpret, agbcc commutes to
 *     `adds r1, r0, r1`.
 */
void sub_0802E724(s32 ch)
{
    SoundSystem *ss;

    if (ch > 3)
        goto big_slot;

    ss = gpSoundSystem;
    ss->chDirty[ch] &= ~0x21;

    if (ch > 2)
        goto write_env_default;

    ss->chWaveBuf[ch] = 0;
    if (ch == 2)
        goto write_wave;

write_env_default:
    *sChannelRegTable[ch] = 0x800;
    goto write_freq;
write_wave:
    *sChannelRegTable[2] = 0;
write_freq:
    *sChannelFreqRegTable[ch] = 0x8000;
    return;

big_slot: {
    register SoundSystem *bigSs asm("r2");
    register SoundSlot *bigSlot asm("r1");
    register SoundSlot *slots asm("r0");
    register s32 offset asm("r1");
    ch -= 4;
    bigSs = gpSoundSystem;
    bigSs->swSlotResetTab[ch] = 0;
    slots = bigSs->swSlots;
    offset = ch * 64;
    asm("" : "=r"(bigSlot) : "0"(offset));
    bigSlot = (SoundSlot *)((u8 *)bigSlot + (u32)slots);
    bigSlot->flags &= ~0x200;
}
}
