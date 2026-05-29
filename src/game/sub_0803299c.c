#include "types.h"

/* sub_0803299C — per-channel sound-state primer (sibling of the high-register
 * variant sub_08032904 at 0x08032904). Clears the channel's "playing" dirty
 * bits, stores a per-channel mode byte and a control halfword, and for the
 * non-wave channels (index != 3) primes the mixer accumulator and step.
 *
 * Struct shapes are scaffold-grade — fields named by byte offset so the
 * literal offsets in the asm map obviously. The SoundSystem layout matches
 * the neighbouring sound_*.c decomps (chDirty[] at +0x10, the per-channel
 * cache region near +0x93, control halfwords at +0xac). Promote to
 * include/sound.h once the 0x08032xxx slot-management cluster lands.
 *
 * Matching notes (built with OLD_AGBCC_BIN — see the Makefile override):
 *   - The whole body hangs off `&gpSoundSystem` kept in a pointer (`pPool`)
 *     that is dereferenced twice; the first slot pointer is consumed by the
 *     byte-store pointer arithmetic, forcing the baserom's reload via the
 *     pool pointer instead of keeping the slot pointer live.
 *   - `index * 8` is materialised once and reused for both the +0x93 byte
 *     address and the (index*9)*4 channel-block index; the `idxCopy` alias
 *     keeps it live across the halfword store. Pinning it to r4 keeps it in
 *     a low callee-saved register (a plain local spills to r8).
 *   - `hwOff` as a u16 variable (not a literal) stops agbcc folding the
 *     +0xac base into the index add — the baserom builds the address in four
 *     instructions. `idx2` pinned to r1 fixes which scratch register holds
 *     index*2 vs the base.
 *   - `ch->delta + ch->step` (delta first) reproduces the baserom's load
 *     order for the accumulator sum; the `chSum` temp is needed to hold that
 *     order — folding the add straight into `ch->acc =` re-swaps the loads.
 */

typedef struct ChannelState {
    u8 _pad00[0x20];
    /* 0x20 */ u16 step;
    u8 _pad22[0x1a];
    /* 0x3c */ u16 delta;
    u8 _pad3e[4];
    /* 0x42 */ u16 acc;
} ChannelState;

typedef struct SoundSlot {
    u8 _pad000[0x151];
    /* 0x151 */ u8 flags;
} SoundSlot;

typedef struct SoundSystem {
    u8 _pad00[0x10];
    /* 0x10 */ u32 chDirty[4];
    u8 _pad20[0xf8];
    /* 0x118 */ SoundSlot *slot;
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

void sub_0803299C(u32 index, u32 step, u32 mode, u32 ctrl)
{
    register u32 index8 asm("r4");
    SoundSystem **pPool = &gpSoundSystem;
    u8 *p = (u8 *)*pPool;
    SoundSystem *ss;
    ChannelState *ch;
    u32 chOff;
    u32 chSum;
    u32 idxCopy;
    u16 hwOff;

    ((SoundSystem *)p)->chDirty[index] &= 0xffff7eef;

    index8 = index * 8;
    p += index8;
    p[0x93] = mode;

    ss = *pPool;
    hwOff = 0xac;
    idxCopy = index8;
    {
        register u32 idx2 asm("r1") = index * 2;
        *(u16 *)((u8 *)ss + hwOff + idx2) = ctrl;
    }

    if (index == 3)
        return;

    chOff = (idxCopy + index) * 4;
    ch = (ChannelState *)((u8 *)ss + chOff);
    chSum = ch->delta + ch->step;
    ch->acc = chSum;
    ch->step = step << 8;
}

/* sub_080329F4 — sets the "queued" bit (0x2) on the active sound slot, but
 * only when its flag byte is exactly 1 (idle/ready). Returns 1 if it acted,
 * 0 otherwise. The active slot is reached through *gpSoundSystem->slot (the
 * +0x118 pointer); the +0x151 flag byte is the same one tested by the sibling
 * predicates sub_08032A20 / sub_08032A54.
 *
 * Matching note: the `== 1` test (not an early-return `!= 1`) is required —
 * agbcc lays the set-and-return-1 block AFTER the fall-through return-0, which
 * is the baserom's `beq`-forward branch direction. An early-return inverts it
 * to `bne` and drifts. */
u32 sub_080329F4(void)
{
    SoundSlot *slot = gpSoundSystem->slot;

    if (slot->flags == 1) {
        slot->flags |= 2;
        return 1;
    }

    return 0;
}
