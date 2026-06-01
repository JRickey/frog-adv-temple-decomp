#include "sound.h"
#include "macros.h"

/* sub_0802E7C4 — per-channel pan apply.
 *
 * Sister to sub_0802E724 (per-channel silence/reset). Same SoundSystem
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
 * Companion sub_0802E874 (delta-pan, externally called from 0x08031148)
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

    mask = (0x88u << 21) << ch >> 24;
    pPool = &gpSoundSystem;
    (*pPool)->panBits &= ~mask;
    muteByte = *((u8 *)*pPool + 0x010f);
    maskTen = 0x10 & muteByte;
    gpsp = pPool;
    if (maskTen != 0)
        goto orr_phase;
    maskTen = 0x10;
    if (pan == 0xff)
        goto orr_phase;
    if (pan <= 0x29) {
        mask = (maskTen << ch) << 24 >> 24;
        goto orr_phase;
    }
    if (pan > 0x55) {
        mask = (0x80u << 17) << ch >> 24;
    }
    /* else: mask stays 0x11<<ch (centre — both bits) */
orr_phase:
    (*gpsp)->panBits |= mask;
    REG_SOUNDCNT_L = (REG_SOUNDCNT_L & 0xff) | ((*gpsp)->panBits << 8);
    return;

big_slot: {
    SoundSlot *slot;
    u8 oldPan;

    slot = (SoundSlot *)((u8 *)gpSoundSystem->swSlots + (ch * 64 - 256));
    oldPan = *((u8 *)slot + 0x3c);
    *((u8 *)slot + 0x3c) = pan;
    if (pan == oldPan)
        return;
    slot->flags |= 0x80;
}
}

/* sub_0802E874 — delta-pan applicator. Externally called from 0x08031148.
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

void sub_0802E874(s8 delta, s32 ch)
{
    register SoundSystem *ss asm("r1");
    register s32 newPan asm("r1");
    register s32 deltaS asm("r4");
    register s32 chReg asm("r3");
    s32 chBit;
    u32 maskTen;
    u8 muteByte;
    u8 deltaU;
    register u32 extracted asm("r0");

    chReg = ch;
    deltaU = (u8)delta;
    deltaS = delta;
    if (deltaS == 0)
        return;

    if (chReg > 3)
        goto big_slot;

    chBit = (s32)((0x88u << 21) << chReg >> 24);
    ss = gpSoundSystem;
    muteByte = *((u8 *)ss + 0x010f);
    maskTen = 0x10 & muteByte;
    if (maskTen == 0) {
        register u8 *panBitsP asm("r1");

        panBitsP = (u8 *)ss;
        panBitsP += 0xba;
        extracted = chBit;
        asm("" : "+r"(extracted));
        extracted &= *panBitsP;
        extracted = (u8)((s32)extracted >> chReg);

        newPan = 0x2a;
        if (extracted != 0x10) {
            newPan = 0x40;
            if (extracted == 1)
                newPan = 0x55;
        }
        newPan += (s8)deltaU;
        if (newPan < 0) {
            newPan = 0;
            goto call_pan;
        }
        if (newPan > 0x7f)
            newPan = 0x7f;
        goto call_pan;
    }

    newPan = 0x40;

call_pan:
    sub_0802E7C4((u8)newPan, chReg);
    return;

big_slot: {
    register u8 *fieldp asm("r1");
    register s32 off asm("r0");
    register u8 *slotp asm("r2");
    register s32 newPanB asm("r1");
    u8 oldPan;

    fieldp = (u8 *)gpSoundSystem;
    fieldp += 0xc8;
    off = chReg << 6;
    off += -0x100;
    fieldp = *(u8 **)fieldp;
    slotp = fieldp + off;
    fieldp = slotp;
    fieldp += 0x3c;
    oldPan = *fieldp;
    if (oldPan == 0xff)
        return;
    newPanB = (s32)fieldp;
    asm("ldrb %0, [%0]" : "+r"(newPanB));
    newPanB += deltaS;
    if (newPanB < 0)
        newPanB = 0;
    else if (newPanB > 0x7f)
        newPanB = 0x7f;
    *(slotp + 0x3c) = (u8)newPanB;
    *(u32 *)(slotp + 0x38) |= 0x80;
}
}
