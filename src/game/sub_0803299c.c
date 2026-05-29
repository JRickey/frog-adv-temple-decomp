#include "types.h"

/* SoundChannel_Init — per-channel sound-state primer (sibling of the high-register
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
    u8 _pad000[0x148];
    /* 0x148 */ u16 pendingId;
    u8 _pad14a[0x7];
    /* 0x151 */ u8 flags;
} SoundSlot;

typedef struct SoundSystem {
    u8 _pad00[0x10];
    /* 0x10 */ u32 chDirty[4];
    u8 _pad20[0xf8];
    /* 0x118 */ SoundSlot *slot;
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

void SoundChannel_Init(u32 index, u32 step, u32 mode, u32 ctrl)
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

/* SoundSlot_QueueRequest — sets the "queued" bit (0x2) on the active sound slot, but
 * only when its flag byte is exactly 1 (idle/ready). Returns 1 if it acted,
 * 0 otherwise. The active slot is reached through *gpSoundSystem->slot (the
 * +0x118 pointer); the +0x151 flag byte is the same one tested by the sibling
 * predicates SoundSlot_ClearInProgress / SoundSlot_QueueId.
 *
 * Matching note: the `== 1` test (not an early-return `!= 1`) is required —
 * agbcc lays the set-and-return-1 block AFTER the fall-through return-0, which
 * is the baserom's `beq`-forward branch direction. An early-return inverts it
 * to `bne` and drifts. */
u32 SoundSlot_QueueRequest(void)
{
    SoundSlot *slot = gpSoundSystem->slot;

    if (slot->flags == 1) {
        slot->flags |= 2;
        return 1;
    }

    return 0;
}

/* SoundSlot_ClearInProgress — sibling predicate of SoundSlot_QueueRequest. Reaches the active sound
 * slot through *gpSoundSystem->slot (+0x118) and inspects the same +0x151 flag
 * byte. Acts only when the low 3 bits equal 5: clears bit 2 (0x04) and sets bit
 * 1 (0x02), then returns 1. Otherwise returns 0 without touching the byte.
 *
 * Matching note: the flag byte is read once into `f` and reused by both the
 * `(f & 7) == 5` test and the `(~4 & f) | 2` write-back — the baserom keeps the
 * loaded byte in r1 across the compare-and-branch and produces the AND/OR result
 * in r0 (the scratch from the `& 7` test). Pinning `f` to r1 (`register u8 f
 * asm("r1")`) reproduces that allocation; without it agbcc reuses `f`'s register
 * as the result destination and swaps the operands. The `== 5` test (not an
 * early-return `!= 5`) keeps agbcc's forward `beq` to the act block, matching
 * SoundSlot_QueueRequest's branch direction. */
u32 SoundSlot_ClearInProgress(void)
{
    SoundSlot *slot = gpSoundSystem->slot;
    register u8 flags asm("r1") = slot->flags;

    if ((flags & 7) == 5) {
        slot->flags = (~4 & flags) | 2;
        return 1;
    }

    return 0;
}

extern void sub_08031DBC(void);

/* SoundSlot_QueueId — queues a 16-bit id (pose/sound selector) onto the active
 * sound slot, but only for a non-zero id and when the slot's +0x151 flag has
 * bit 0 set (ready). On success it stashes the id at slot+0x148, kicks
 * sub_08031DBC, and returns 1; otherwise returns 0. Sibling of the +0x151
 * predicates SoundSlot_QueueRequest / SoundSlot_ClearInProgress.
 *
 * Matching note: the u16 argument is zero-extended into r3 and kept there
 * across the slot load — pinning `id` to r3 (`register u16 id asm("r3")`)
 * reproduces that; a plain local truncates into r0 then copies to r3, adding
 * a spurious `adds r3, r0, #0`. The slot pointer is loaded unconditionally
 * before the `id == 0` guard (the baserom reads *gpSoundSystem->slot into r2
 * ahead of the compare). The two guards stay as separate `if (cond) return 0;`
 * early-returns (id, then flag bit) to keep both `beq`-forward branches to the
 * shared return-0 tail. */
u32 SoundSlot_QueueId(u16 idArg)
{
    register u16 id asm("r3") = idArg;
    SoundSlot *slot = gpSoundSystem->slot;

    if (id == 0)
        return 0;

    if (!(slot->flags & 1))
        return 0;

    slot->pendingId = id;
    sub_08031DBC();
    return 1;
}

/* SoundSlot_Stride — returns the fixed per-slot stride 0x150 (the size of one
 * SoundSlot record). agbcc materialises the constant as 0xa8 << 1, matching
 * the baserom's `movs r0, #168; lsls r0, r0, #1`. */
u32 SoundSlot_Stride(void)
{
    return 0x150;
}
