#include "sound.h"

/* sub_0802F9F0 — channel-flags STOP transition + queued-program swap.
 *
 * Slot-retire helper called from sub_080315D8's stop opcode handlers and
 * from sub_0802E13C's drain-all path. Two responsibilities:
 *
 *   1. Set the STOP-pending bit (0x100) on the channel's u32 flag word
 *      and run a one-shot transition: if the current mode (low 3 bits)
 *      is 1 (RUNNING) — encoded as `(flags & 9) == 1`, i.e. STOP bit set
 *      AND mode==1 — promote to mode 6 (STOPPING) by clearing the low
 *      3 bits and OR'ing in 6. Only does the promotion if the existing
 *      mode bits would land below 2 after masking with 6 (gate skips
 *      the promotion if the channel is already in an end-of-program
 *      mode where bit 2 or bit 1 is set).
 *
 *   2. If the channel-sequencer slot at SoundSystem+0x114[idx] has a
 *      queued opcode pointer at +0x4, promote it: clear the u16 cursor
 *      at +0xa and store the queued pointer into +0x0 so the dispatcher
 *      picks up the new program next frame.
 *
 * Flag-word location splits on idx:
 *   - idx <= 3 (music channels): ss->chFlags[idx] at SoundSystem+0x10
 *     (stride 4).
 *   - idx >= 4 (dynamic SFX slots): swSlots[idx-4].flags at +0x38
 *     within the 64-byte SoundSlot. Phrased as
 *     `(SoundSlot *)((u8 *)swSlots + (idx*64 - 256))` so agbcc emits
 *     the same `lsls #6; add; subs #200` baserom sequence the sibling
 *     sub_0802E7C4 uses.
 *
 * Matching notes:
 *   - `if (idx <= 3) { small } else { big }` (not the reverse) — the
 *     baserom puts the small-channel path in the fall-through slot
 *     immediately after the `bgt`, with the pool literal sandwiched
 *     between the two paths.
 *   - Mode-promotion is written as
 *         newFlags &= ~6;
 *         *pFlags = newFlags | mask;
 *     across two statements so agbcc actually emits both the
 *     `and r3, r0` and the `orr r3, r2` — folding them into a single
 *     `(newFlags & ~6) | 6` lets agbcc collapse to a bare `orr` since
 *     the AND+OR cancel mathematically.
 *   - `mask = 6` then `newFlags & mask` (rather than `newFlags & 6`)
 *     keeps r2 holding 6 across the mode-check store, so the later
 *     `orr r3, r2` reuses that register instead of materialising 6
 *     twice. The split into a NEW local `newFlags = flags | 0x10`
 *     similarly pins the modified value in a separate register from
 *     the pre-OR `flags` (r3 vs r2 in the baserom).
 */

extern u32 sub_080301C4(u32 base, u32 hi, u32 lo);

void sub_0802F9F0(s32 idx)
{
    SoundSystem *ss;
    SoundChannelSeq *seq;
    u32 *pFlags;
    u32 flags;
    u32 mode;

    ss = gpSoundSystem;
    seq = &ss->channelSeqs[idx];

    if (idx <= 3) {
        pFlags = &ss->chFlags[idx];
    } else {
        SoundSlot *slot = (SoundSlot *)((u8 *)ss->swSlots + (idx * 64 - 256));
        pFlags = &slot->flags;
    }

    flags = *pFlags | 0x100;
    *pFlags = flags;

    if ((flags & 9) == 1) {
        u32 newFlags = flags | 0x10;
        u32 mask;
        *pFlags = newFlags;
        mask = 6;
        mode = newFlags & mask;
        if (mode <= 2) {
            newFlags &= ~6;
            *pFlags = newFlags | mask;
        }
    }

    if (seq->queuedOpPtr != NULL) {
        seq->cursor = 0;
        seq->opPtr = (u32 *)seq->queuedOpPtr;
    }
}

void sub_0802FA60(s32 idx)
{
    SoundSystem *ss;
    SoundSlotAccs *slot;
    SoundPeriodEntry *entry;
    u32 sum;

    ss = gpSoundSystem;
    slot = (SoundSlotAccs *)ss->slotPtrTable[idx];
    if (slot == NULL)
        return;

    entry = (SoundPeriodEntry *)((u8 *)ss->mixTable + idx * 28);
    sum = (u16)(slot->acc0 + slot->acc1 + slot->acc2 + slot->acc3 + slot->acc4 + slot->acc5);
    entry->period = (u16)sub_080301C4(entry->base, (u16)sum >> 8, (sum << 24) >> 24);
}
