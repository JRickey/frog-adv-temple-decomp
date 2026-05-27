#include "types.h"

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
 * stays in asm/disasm_0x0802e874.s — its small-channel path needs old_agbcc
 * to spill ss into a caller-save scratch (r1) while keeping ch in r3, and
 * agbcc 2.x's natural choice is to put ss in r4 (callee-save). Decomp
 * deferred until that idiom can be matched.
 */

#define REG_SOUNDCNT_L (*(vu16 *)0x04000080)

typedef struct SoundSlot {
    u8 _pad00[0x38];
    u32 flags; /* +0x38 — 0x80 = "dirty, reapply pan/vol on mix" */
    u8 _pad3c[4];
    u8 panCache; /* +0x3c — last emitted pan byte (shared with sound_pan.c) */
} SoundSlot;

typedef struct SoundSystem {
    u8 _pad00[0xba];
    u8 panBits; /* +0xba — hi byte of REG_SOUNDCNT_L cache */
    u8 _padbb[0xc];
    SoundSlot *swSlots; /* +0xc8 — software-mixed slot array (64-byte stride) */
    u8 _padcc[0x43];
    u8 muteMask; /* +0x010f — per-channel mute bits (0x10 = ch muted) */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

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
