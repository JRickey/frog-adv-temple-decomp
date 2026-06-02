#include "types.h"

/* sub_0802E13C — drain all active dynamic-SFX/music slots.
 *
 * Walks the same ss->count + 4 slot range as sub_080315D8 (opcode-script
 * dispatcher) and sub_080325B0 stage 3, this time via the parallel pointer
 * table at SoundSystem+0x120 (not the channelSeqs at +0x114). For each
 * non-NULL entry, forwards to sub_0802F9F0(i) — the slot-retire helper
 * referenced from sub_080325B0 stage 1.
 *
 * Returns the count of non-NULL slots that were drained. Called from
 * sub_08020B60 (system-level "stop all sound" path).
 *
 * Matching notes:
 *   - The slot-table base ss+0x120 is loaded inside the loop because
 *     sub_0802F9F0 can clear individual entries. agbcc caches a pointer
 *     to the *preceding* struct field (ss+0x11c, encoded as one
 *     `movs imm #0x8e; lsls #1` pair) in callee-save r6, then
 *     dereferences `[r6, #4]` for the slot-table base each iteration —
 *     writing `ss->slotPtrTable[i]` direct lets agbcc skip the r6 push
 *     entirely.
 *   - The entry-check compares the slot counter (r5, initially 0)
 *     against `ss->count + 4` rather than the index (r4); both are 0 at
 *     entry, so the test is equivalent but agbcc picks the register
 *     spelled out in the goto-cond. Bottom-of-loop reload of
 *     gpSoundSystem keeps a fresh count read after sub_0802F9F0.
 *   - Compiled with old_agbcc (see Makefile per-file override) — the
 *     newer agbcc prologue inserts an extra `push {lr}` on sub_0802E184
 *     even though it's a leaf, breaking the 140-byte total slice.
 */

typedef struct SoundChannelSeq {
    u32 *opPtr; /* +0x00 — current opcode pointer */
    u8 _pad04[12];
} SoundChannelSeq; /* sizeof == 16 */

typedef struct SlotTableBase {
    u8 _pad00[4];        /* +0x00 — preceding field at ss+0x11c */
    void **slotPtrTable; /* +0x04 — slot pointer array at ss+0x120 */
} SlotTableBase;

typedef struct SoundSystem {
    u8 count; /* +0x00 — number of dynamic SFX slots */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

extern void sub_0802F9F0(s32 idx);

s32 sub_0802E13C(void)
{
    SoundSystem *ss;
    SlotTableBase *base;
    s32 active;
    s32 i;

    ss = gpSoundSystem;
    base = (SlotTableBase *)((u8 *)ss + 0x11c);
    active = 0;
    i = 0;
    if (active >= (s32)ss->count + 4)
        goto done;

loop:
    if (base->slotPtrTable[i] != NULL) {
        sub_0802F9F0(i);
        active++;
    }
    i++;
    ss = gpSoundSystem;
    if (i < (s32)ss->count + 4)
        goto loop;

done:
    return active;
}

/* sub_0802E184 — validate that a sound handle is still active.
 *
 * Handle layout: bits 16..23 carry the slot index. Returns 1 iff
 *   - the handle is non-zero,
 *   - the slot at that index still holds the same handle (token match), and
 *   - the channelSeq for that index still has a non-NULL opcode pointer
 *     (i.e. the script hasn't ended).
 * Otherwise returns 0.
 *
 * Called from sub_080204A4 (sound handle-aware wrappers).
 *
 * Matching note: old_agbcc picks `ip` as the scratch base for the two
 * `add r0, ip` sequences at +0x120 and +0x114 — the natural Thumb-1 way
 * to share a single SoundSystem pointer across two `movs imm; lsls #1;
 * add base` immediate-offset adds. The handle-vs-zero gate compares
 * against r3 (not r0) because agbcc commutes the assignment via
 * `adds r3, r0, #0` to free r0 for the literal-pool load.
 */
u32 sub_0802E184(u32 handle)
{
    SoundSystem *ss;
    u32 idx;
    void **slotTable;
    SoundChannelSeq *seqs;

    if (handle == 0)
        return 0;
    idx = (handle >> 16) & 0xff;
    ss = gpSoundSystem;
    slotTable = *(void ***)((u8 *)ss + 0x120);
    if ((u32)slotTable[idx] != handle)
        goto fail;
    seqs = *(SoundChannelSeq **)((u8 *)ss + 0x114);
    if (seqs[idx].opPtr == NULL)
        goto fail;
    return 1;
fail:
    return 0;
}

/* sub_0802E1C8 — get the period (pitch/rate byte) for a sound handle.
 *
 * Same handle layout: bits 16..23 carry the slot index.
 * Returns -1 if handle is 0 or if the slot token no longer matches.
 * For idx <= 3 (direct/hardware channels): reads channels[idx].period
 *   from ss+0x8c (the DirectSoundChannel array, 8-byte stride, period at +7).
 * For idx > 3 (software-mixed slots): reads swSlots[idx-4].period >> 1
 *   from the SoundSlotAcc array at ss+0xc8 (64-byte stride, period at +0x2b).
 *
 * Matching notes: idx is s32 for signed bgt.n. Common result puts direct
 * block first. Direct path: chanOff = (idx<<3)+0x8c computed as an
 * intermediate, then ss+chanOff, producing adds r0, #0x8c; adds r0, r4, r0.
 * SW-slot path: slotBase (ss+0xc8) computed before shift so agbcc schedules
 * the lsl r1 between adds r0, #0xc8 and ldr r0.
 */

typedef struct DirectSoundChan {
    u8 _pad00[6];
    u8 gate;   /* +0x06 */
    u8 period; /* +0x07 */
} DirectSoundChan;

s32 sub_0802E1C8(u32 handle)
{
    s32 idx;
    SoundSystem *ss;
    u32 *slotTable;
    u8 *p;
    u8 *slotBase;
    s32 result;
    s32 chanOff;

    if (handle == 0)
        return -1;
    idx = (s32)((handle >> 16) & 0xff);
    ss = gpSoundSystem;
    slotTable = *(u32 **)((u8 *)ss + 0x120);
    if (slotTable[idx] != handle)
        return -1;

    if (idx <= 3) {
        chanOff = (idx << 3) + 0x8c;
        result = ((u8 *)ss + chanOff)[7];
    } else {
        idx -= 4;
        slotBase = (u8 *)ss + 0xc8;
        p = *(u8 **)slotBase + (idx << 6) + 0x24;
        result = p[7] >> 1;
    }
    return result;
}
