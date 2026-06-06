#include "sound.h"
#include "macros.h"

/* sub_0802E7C4 — per-channel pan apply.
 *
 * Sister to SoundChannel_Reset (per-channel silence/reset). Same SoundSystem
 * fields; the new ones here are:
 *   +0xBA (u8 panBits) — cached high byte of REG_SOUNDCNT_L (channel
 *                       L/R enable bitmap). Bit ch enables right (SO1),
 *                       bit ch+4 enables left (SO2).
 *   +0x010F (u8 muteMask) — per-channel mute byte; if bit 0x10 is set the
 *                       channel is muted and pan updates collapse to "redo
 *                       the same bits" — clear+set the same {ch, ch+4} pair,
 *                       which is a no-op in panBits but still re-emits the
 *                       cached byte to REG_SOUNDCNT_L.
 *
 * sub_0802E7C4(pan, ch): apply pan position `pan` (0..127, plus 0xFF =
 *   leave muted) to channel ch.
 *     ch in 0..3: clear bits {ch, ch+4} from panBits, then OR in:
 *       pan <= 41          → 0x10<<ch (left only)
 *       42 <= pan <= 85    → 0x11<<ch (centre — both)
 *       86 <= pan <= 254   → 0x01<<ch (right only)
 *       pan == 0xFF or muted → 0x11<<ch (no-op: same bits we cleared)
 *     and write REG_SOUNDCNT_L hi byte = panBits.
 *     ch >= 4: write pan into swSlots[ch-4]+0x3c. If it changed, set
 *     slot.flags bit 0x80 (mixer reapplies on next tick).
 *
 * Companion Sound_AdjustPan (delta-pan, externally called from 0x08031148)
 * shares the same pan-bit decode and slot dirtying paths.
 */

#define REG_SOUNDCNT_L (*(vu16 *)0x04000080)

/* Matching notes:
 *   - `(0x88 << 21) << ch >> 24` reproduces the baserom's three-shift
 *     channel-bitmap derivation. `0x88 << 21 == 0x11000000` and the final
 *     `>>24` extracts the byte (bits ch and ch+4 set). Writing `0x11 << ch`
 *     directly would let agbcc skip the first shift and break the match.
 *   - The `pPool / gpsp` split forces old_agbcc to materialise the pool
 *     pointer (`&gpSoundSystem` → r2) before saving a copy into r7. Folding
 *     them into one variable lets agbcc skip the `adds r7, r2, #0` and
 *     instead reload via the original pool literal.
 *   - `maskTen = 0x10 & muteByte; if (maskTen != 0)` is a deliberate
 *     workaround: writing the natural `if ((muteByte & 0x10) != 0)` emits
 *     `adds r7, r2, #0` BEFORE the `ands`, which doesn't match. Splitting
 *     the AND into a stored value pushes the r7 spill past the AND.
 *   - The mute-or-0xFF paths fall through to `orr_phase` with `mask` still
 *     holding `0x11<<ch` (the original clear mask), so the |= is a no-op
 *     on panBits but the REG_SOUNDCNT_L write still happens.
 *   - Compiled with old_agbcc (see Makefile per-file override) — natural
 *     agbcc 2.x folds the chBit `>> 24` into the prior `<< 21`, breaking
 *     the `lsrs r3, r0, #24` post-shift.
 */

void sub_0802E7C4(u8 pan, s32 ch)
{
    SoundSystem **pPool;
    SoundSystem **gpsp;
    u32 mask;
    u32 maskTen;
    u8 muteByte;

    if (ch > 3)
        goto big_slot;

    mask = SOUND_PAN_BOTH_BITS_BASE << ch >> 24;
    pPool = &gpSoundSystem;
    (*pPool)->panBits &= ~mask;
    muteByte = *((u8 *)*pPool + SOUND_SYSTEM_MUTE_MASK_OFFSET);
    maskTen = SOUND_PAN_MUTE_MASK & muteByte;
    gpsp = pPool;
    if (maskTen != 0)
        goto orr_phase;
    maskTen = SOUND_PAN_MUTE_MASK;
    if (pan == SOUND_PAN_MUTED)
        goto orr_phase;
    if (pan <= SOUND_PAN_LEFT_ONLY_MAX) {
        mask = (maskTen << ch) << 24 >> 24;
        goto orr_phase;
    }
    if (pan > SOUND_PAN_RIGHT_ONLY_MIN) {
        mask = (0x80u << 17) << ch >> 24;
    }
    /* else: mask stays 0x11<<ch (centre — both bits) */
orr_phase:
    (*gpsp)->panBits |= mask;
    REG_SOUNDCNT_L = (REG_SOUNDCNT_L & SOUND_SOUNDCNT_L_LOW_MASK) | ((*gpsp)->panBits << 8);
    return;

big_slot: {
    SoundSlot *slot;
    u8 oldPan;

    slot = SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(gpSoundSystem, ch);
    oldPan = slot->panCache;
    slot->panCache = pan;
    if (pan == oldPan)
        return;
    slot->flags |= SOUND_SLOT_FLAG_PAN_DIRTY;
}
}

/* Sound_AdjustPan — delta-pan applicator. Externally called from 0x08031148.
 *
 * Takes a signed delta in the s8 range and applies it to channel `ch`:
 *   ch in 0..3 (small slot): decode current pan-bits {ch, ch+4} back to
 *     a 0..127 position (0x10 → 42, 0x01 → 85, otherwise → 64), add the
 *     delta, clamp [0..127], then forward to sub_0802E7C4 to re-emit.
 *     If the channel is muted (muteMask bit 0x10), skip the decode and
 *     reapply at centre (64).
 *   ch >= 4 (big slot): read swSlots[ch-4].pan, abort if 0xff, otherwise
 *     add delta, clamp, write back, set the dirty bit.
 *
 * The small-channel path keeps the pan-bit extraction in r0 and the
 * big-slot path reloads the pan byte destructively through r1 so agbcc
 * follows the baserom's register lifetimes.
 */

void Sound_AdjustPan(s8 delta, s32 ch)
{
    SoundSystem *ss;
    s32 newPan;
    s32 deltaS;
    register s32 chReg asm("r3");
    s32 chBit;
    u32 maskTen;
    u8 muteByte;
    u8 deltaU;
    u32 extracted;

    chReg = ch;
    deltaU = (u8)delta;
    deltaS = delta;
    if (deltaS == 0)
        return;

    if (chReg > 3)
        goto big_slot;

    chBit = (s32)(SOUND_PAN_BOTH_BITS_BASE << chReg >> 24);
    ss = gpSoundSystem;
    muteByte = *((u8 *)ss + SOUND_SYSTEM_MUTE_MASK_OFFSET);
    maskTen = SOUND_PAN_MUTE_MASK & muteByte;
    if (maskTen == 0) {
        register u8 *panBitsP asm("r1");

        panBitsP = (u8 *)ss;
        panBitsP += SOUND_SYSTEM_PAN_BITS_OFFSET;
        extracted = chBit;
        asm("" : "+r"(extracted));
        extracted &= *panBitsP;
        extracted = (u8)((s32)extracted >> chReg);

        newPan = SOUND_PAN_LEFT_DECODE_VALUE;
        if (extracted != SOUND_PAN_MUTE_MASK) {
            newPan = SOUND_PAN_CENTER_VALUE;
            if (extracted == 1)
                newPan = SOUND_PAN_RIGHT_ONLY_MIN;
        }
        newPan += (s8)deltaU;
        if (newPan < 0) {
            newPan = 0;
            goto call_pan;
        }
        if (newPan > SOUND_PAN_HIGH_MAX)
            newPan = SOUND_PAN_HIGH_MAX;
        goto call_pan;
    }

    newPan = SOUND_PAN_CENTER_VALUE;

call_pan:
    sub_0802E7C4((u8)newPan, chReg);
    return;

big_slot: {
    u8 *fieldp;
    register s32 off asm("r0");
    u8 *slotp;
    s32 newPanB;
    u8 oldPan;

    fieldp = (u8 *)gpSoundSystem;
    fieldp += SOUND_SYSTEM_SW_SLOTS_OFFSET;
    off = chReg << 6;
    off += -(SOUND_SW_SLOT_STRIDE * 4);
    fieldp = *(u8 **)fieldp;
    slotp = fieldp + off;
    fieldp = slotp;
    fieldp += SOUND_SLOT_PAN_CACHE_OFFSET;
    oldPan = *fieldp;
    if (oldPan == SOUND_PAN_MUTED)
        return;
    newPanB = (s32)fieldp;
    asm("ldrb %0, [%0]" : "+r"(newPanB));
    newPanB += deltaS;
    if (newPanB < 0)
        newPanB = 0;
    else if (newPanB > SOUND_PAN_HIGH_MAX)
        newPanB = SOUND_PAN_HIGH_MAX;
    *(slotp + SOUND_SLOT_PAN_CACHE_OFFSET) = (u8)newPanB;
    *(u32 *)(slotp + SOUND_SLOT_FLAGS_OFFSET) |= SOUND_SLOT_FLAG_PAN_DIRTY;
}
}
