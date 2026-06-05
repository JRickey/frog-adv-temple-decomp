#include "sound.h"

#define REG_SOUNDCNT_L (*(vu16 *)0x04000080)

/* sub_0802DCBC — set the pan position of a sound channel identified by
 * handle, returning the channel's *previous* pan (clamped to 0x80).
 *
 * handle: bits 16..23 carry the channel index (same handle layout as the
 *         sibling sound functions).
 * vol:    target pan position. 0x80 is a sentinel for "max" (decoded to the
 *         0xff full value); otherwise clamped into [0, 0x7f].
 *
 * channel 0..3 (PSG): decode the previous pan from panBits {ch, ch+4}
 *   (0x10 -> 0x2a, 0x01 -> 0x55, otherwise 0x40), clear those bits, then OR
 *   in the new bits derived from vol and re-emit REG_SOUNDCNT_L.
 * channel >= 4 (SW slot): read/replace the slot's panCache byte; if it
 *   changed, set the slot's UPDATE_DIRTY flag.
 *
 * Matching notes:
 *   - pPool keeps &gpSoundSystem in a register; every access re-derefs *pPool
 *     (matches the baserom re-loading gpSoundSystem through the pool pointer).
 *   - `SOUND_PAN_BOTH_BITS_BASE << ch >> 24` reproduces the three-shift
 *     channel bitmap; `0x80u << 21 >> 24` and `0x80u << 17 >> 24` reproduce
 *     the single-bit forms without agbcc collapsing the shifts.
 */
s32 sub_0802DCBC(u32 handle, s32 vol)
{
    u32 handleR = handle;
    s32 volR = vol;
    register u32 channel asm("r5");
    SoundSystem **pPool;
    SoundSystem **gpsp;
    void **handleTable;
    u32 slotEntry;
    u32 chOff;
    s32 old;
    u32 bits;
    u32 mask;

    if (handleR == 0)
        return -1;

    channel = (handleR >> 16) & 0xff;
    pPool = &gpSoundSystem;
    chOff = 0x90;
    chOff <<= 1;
    handleTable = *(void ***)((u8 *)*pPool + chOff);
    slotEntry = (u32)handleTable[channel];
    gpsp = pPool;
    if (slotEntry != handleR)
        return -1;

    if (volR == SOUND_VOL_SET_MAX)
        volR = SOUND_PAN_MUTED;
    else if (volR < 0)
        volR = 0;
    else if (volR > SOUND_PAN_HIGH_MAX)
        volR = SOUND_PAN_HIGH_MAX;

    if ((s32)channel > 3)
        goto sw_slot;

    mask = SOUND_PAN_BOTH_BITS_BASE << channel >> 24;
    {
        u8 *panBitsP;
        register u32 acc asm("r0");

        panBitsP = (u8 *)*gpsp + SOUND_SYSTEM_PAN_BITS_OFFSET;
        acc = mask;
        /* fence: copy mask into acc before the panBits load so agbcc emits
         * `adds r0, r2, #0; ldrb r1, [r1]; ands r0, r1` (mask copy first)
         * instead of folding the load into acc's register. */
        asm("" : "+r"(acc));
        acc &= *panBitsP;
        acc = (u8)((s32)acc >> channel);
        bits = acc;
    }

    old = SOUND_PAN_LEFT_DECODE_VALUE;
    if (bits != SOUND_PAN_MUTE_MASK) {
        old = SOUND_PAN_CENTER_VALUE;
        if (bits == 1)
            old = SOUND_PAN_RIGHT_ONLY_MIN;
    }

    (*gpsp)->panBits &= ~mask;

    if (volR == SOUND_PAN_MUTED)
        goto orr_phase;
    if (volR <= SOUND_PAN_LEFT_ONLY_MAX) {
        mask = SOUND_PAN_RIGHT_BITS_BASE << channel >> 24;
    } else if (volR > SOUND_PAN_RIGHT_ONLY_MIN) {
        mask = (0x80u << 17) << channel >> 24;
    } else {
        /* center (0x2a..0x55): fall through with mask still the cleared bits,
         * so the |= is a no-op but the REG_SOUNDCNT_L write still happens. */
        goto orr_phase;
    }

orr_phase:
    (*gpsp)->panBits |= mask;
    REG_SOUNDCNT_L = (REG_SOUNDCNT_L & SOUND_SOUNDCNT_L_LOW_MASK) | ((*gpsp)->panBits << 8);
    goto tail;

sw_slot: {
    register u8 *swSlotsField asm("r1");
    register u32 off asm("r0");
    u8 *slot;
    u8 *panCacheP;

    swSlotsField = (u8 *)*gpsp + SOUND_SYSTEM_SW_SLOTS_OFFSET;
    off = (channel << 6) + 0xffffff00u;
    swSlotsField = *(u8 **)swSlotsField;
    slot = (u8 *)((u32)swSlotsField + off);
    panCacheP = slot + SOUND_SLOT_PAN_CACHE_OFFSET;
    old = *panCacheP;
    *panCacheP = volR;
    {
        u32 volByte;
        volByte = (u8)volR;
        if (volByte != (u8)old)
            *(u32 *)(slot + SOUND_SLOT_FLAGS_OFFSET) |= SOUND_FLAG_UPDATE_DIRTY;
    }
}

tail:
    if (old > SOUND_PAN_HIGH_MAX)
        old = SOUND_VOL_SET_MAX;
    return old;
}

/* sub_0802DDB0 — read the current pan position of a channel by handle.
 * Read-only counterpart of sub_0802DCBC; decodes panBits (PSG) or reads the
 * SW slot's panCache, clamped to 0x80. Returns -1 for an invalid handle. */
s32 sub_0802DDB0(u32 handle)
{
    register SoundSystem *ss asm("r4");
    u32 channel;
    void **handleTable;
    s32 old;
    u32 bits;

    if (handle == 0)
        return -1;

    channel = (handle >> 16) & 0xff;
    ss = gpSoundSystem;
    handleTable = SOUND_SYSTEM_SLOT_HANDLE_TABLE(ss);
    if ((u32)handleTable[channel] != handle)
        return -1;

    if ((s32)channel > 3)
        goto sw_slot;

    {
        u32 acc;
        register u8 *panBitsP asm("r1");

        acc = SOUND_PAN_BOTH_BITS_BASE << channel >> 24;
        panBitsP = (u8 *)ss + SOUND_SYSTEM_PAN_BITS_OFFSET;
        acc &= *panBitsP;
        bits = (u8)((s32)acc >> channel);
    }

    old = SOUND_PAN_LEFT_DECODE_VALUE;
    if (bits != SOUND_PAN_MUTE_MASK) {
        old = SOUND_PAN_CENTER_VALUE;
        if (bits == 1)
            old = SOUND_PAN_RIGHT_ONLY_MIN;
    }
    goto tail;

sw_slot: {
    register u8 *swSlotsField asm("r0");
    u8 *addr;

    swSlotsField = (u8 *)ss + SOUND_SYSTEM_SW_SLOTS_OFFSET;
    addr = (u8 *)(channel << 6);
    addr += (u32) * (u8 **)swSlotsField;
    addr -= 0xc4;
    old = *addr;
}

tail:
    if (old > SOUND_PAN_HIGH_MAX)
        old = SOUND_VOL_SET_MAX;
    return old;
}
