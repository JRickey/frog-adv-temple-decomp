#include "sound.h"

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
 *     keeps it live across the halfword store so agbcc leaves the value in r4.
 *   - `hwOff` as a u16 variable (not a literal) stops agbcc folding the
 *     +0xac base into the index add — the baserom builds the address in four
 *     instructions, with the local `idx2` naturally taking r1.
 *   - `ch->delta + ch->step` (delta first) reproduces the baserom's load
 *     order for the accumulator sum; the `chSum` temp is needed to hold that
 *     order — folding the add straight into `ch->acc =` re-swaps the loads.
 */

void SoundChannel_Init(u32 index, u32 step, u32 mode, u32 ctrl)
{
    u32 index8;
    SoundSystem **pPool = &gpSoundSystem;
    u8 *p = (u8 *)*pPool;
    SoundSystem *ss;
    ChannelState *ch;
    u32 chOff;
    u32 chSum;
    u32 idxCopy;
    u16 hwOff;

    ((SoundSystem *)p)->chFlags[index] &= 0xffff7eef;

    index8 = index * 8;
    p += index8;
    p[0x93] = mode;

    ss = *pPool;
    hwOff = 0xac;
    idxCopy = index8;
    {
        u32 idx2 = index * 2;
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
    SoundRequestSlot *slot = gpSoundSystem->slot;

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
 * Matching note: the flag byte is read once into `flags` and reused by both the
 * `(flags & 7) == 5` test and the write-back. Splitting the write-back through
 * `newFlags` keeps the loaded byte in r1 across the compare-and-branch and
 * produces the AND/OR result in r0. The `== 5` test (not an early-return `!= 5`)
 * keeps agbcc's forward `beq` to the act block, matching SoundSlot_QueueRequest's
 * branch direction. */
u32 SoundSlot_ClearInProgress(void)
{
    SoundRequestSlot *slot = gpSoundSystem->slot;
    u8 flags = slot->flags;
    u32 newFlags;

    if ((flags & 7) == 5) {
        newFlags = (u8)~4;
        newFlags &= flags;
        newFlags |= 2;
        slot->flags = newFlags;
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
 * Matching note: the u16 argument is zero-extended into a local `id` and kept
 * across the slot load. The slot pointer is loaded unconditionally before the
 * `id == 0` guard (the baserom reads *gpSoundSystem->slot into r2 ahead of the
 * compare). The two guards stay as separate `if (cond) return 0;` early-returns
 * (id, then flag bit) to keep both `beq`-forward branches to the shared
 * return-0 tail. */
u32 SoundSlot_QueueId(u16 idArg)
{
    u16 id = idArg;
    SoundRequestSlot *slot = gpSoundSystem->slot;

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

/* sub_08032AA0 — initializes a sound slot: stores it as gpSoundSystem->slot,
 * zeros the slot header (0x154 bytes), sets slot->nextRegion to arg1+0x154,
 * zeros the channel region ((arg0[2]+4)*12 bytes), clears flags, stores the
 * channel count, and returns 1.
 *
 * Matching notes:
 *   - pPool (&gpSoundSystem, r8) and buf (arg1, naturally allocated to r5) are
 *     callee-saved across the first bl to sub_0802E380. After the bl, sz (r4) =
 *     arg1+0x154 (next).
 *   - To reproduce `mov r2, r8; ldr r1, [r2, #0]`, pPool is explicitly copied
 *     to r2pPool asm("r2") first; ssTmp then naturally loads into r1.
 *   - The slot reload after the nextRegion store reuses r1 (slotField, kept across
 *     the store) and the recomputed 0x110 offset.
 *   - The strb section: flagOff asm("r2") holds 0x151 (from pool), and addrHi
 *     computes buf+flagOff for each strb; v = arg0[2] is read before flagOff++ so
 *     agbcc can use `ldrb r0, [r1, #2]` (immediate offset) vs modify-then-load.
 */

extern void sub_0802E380(u8 *ptr, u32 count);

u32 sub_08032AA0(u8 *arg0, u8 *arg1)
{
    u8 *buf = arg1;
    register SoundSystem **pPool asm("r8") = &gpSoundSystem;
    u32 sz;
    register u32 flagOff asm("r2");
    u8 *addrHi;
    u8 v;

    (*pPool)->slot = (SoundRequestSlot *)buf;
    sz = 0x154;
    sub_0802E380(buf, sz);

    {
        SoundSystem *ssTmp;
        register SoundSystem **r2pPool asm("r2");
        register SoundRequestSlot **slotField asm("r1");
        u32 nextOff;

        sz = (u32)buf + sz;
        r2pPool = pPool;                                        /* mov r2, r8 */
        ssTmp = *r2pPool;                                       /* ldr r1, [r2, #0] */
        slotField = (SoundRequestSlot **)((u8 *)ssTmp + 0x118); /* adds r1, r1, r6 */
        nextOff = 0x110;
        (*slotField)->nextRegion = (u8 *)sz;
        sub_0802E380((*slotField)->nextRegion, ((u32)arg0[2] + 4) * 12);
    }

    flagOff = 0x151;
    addrHi = buf + flagOff;
    *addrHi = 0;
    v = arg0[2];
    flagOff++;
    addrHi = buf + flagOff;
    *addrHi = v;

    return 1;
}
