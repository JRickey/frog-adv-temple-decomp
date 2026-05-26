#include "types.h"

/* Per-frame pitch/pan envelope tick for the sound subsystem.
 *
 * Called from sub_0802F4B0 (the per-VBlank mixer) over the slot table
 * pointed to by `(*gpSoundSystem)->slotPtrTable`. For each active slot
 * (flag bit 0x400 in `flags`), advances the signed accumulator in
 * `slot->envelope.acc` by `slot->envelope.step`, reflecting off the
 * ±limit walls held in `posLimit` / `negLimit`. The bounced value
 * (`>>8 + 16`) is then added to the per-channel mix entry at
 * `(*gpSoundSystem)->mixTable[i].base` and stored into `outSample`.
 *
 * Struct shapes here are scaffold-grade — sized for the offsets this
 * function touches. Promote to include/sound.h once a second sound-
 * system file lands and the offsets stabilize.
 *
 * Matching note: an explicit `&gpSoundSystem` cache (`gpsp`) inside
 * the count guard is what gets agbcc to emit `mov ip, r2` before
 * `movs r7, #0` in the loop prologue — without it, agbcc lazily caches
 * the address only when emitting the loop body, and the resulting
 * scheduler pick swaps those two instructions vs the baserom. Found by
 * decomp-permuter.
 */

typedef struct SlotEnvelope {
    s16 acc;     /* slot+0x2c */
    s16 step;    /* slot+0x2e */
    s8 negLimit; /* slot+0x30 */
    s8 posLimit; /* slot+0x31 */
} SlotEnvelope;

typedef struct SoundSlot {
    u8 _pad00[0x2c];
    SlotEnvelope envelope; /* agbcc rounds nested struct to 8 bytes here */
    u8 _pad34[2];
    u32 flags; /* slot+0x38 */
} SoundSlot;

typedef struct SoundMixEntry {
    u32 base; /* +0x00 */
    u8 _pad04[8];
    u32 outSample; /* +0x0c */
    u8 _pad10[16];
} SoundMixEntry; /* sizeof == 28 */

typedef struct SoundSystem {
    u8 count; /* +0x00 */
    u8 _pad01[0xbf];
    SoundMixEntry *mixTable; /* +0xc0 */
    u8 _padc4[8];
    SoundSlot **slotPtrTable; /* +0xcc */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

void sub_0802ED5C(void)
{
    SoundSlot **slotPtr;
    s32 i;
    s32 byteOffset;

    slotPtr = gpSoundSystem->slotPtrTable;
    i = 0;
    if (i < gpSoundSystem->count) {
        SoundSystem **gpsp = &gpSoundSystem;
        byteOffset = 0;
        do {
            SoundSlot *slot = *slotPtr;
            if (slot != NULL && (slot->flags & 0x400)) {
                SlotEnvelope *env = &slot->envelope;
                register s32 acc asm("r1");
                register u16 stepU asm("r4");
                register s32 limit asm("r0");
                SoundMixEntry *entry;

                acc = slot->envelope.acc + env->step;
                stepU = env->step;
                if (env->step >= 0) {
                    limit = env->posLimit;
                    if (acc < (limit << 8))
                        goto apply;
                } else {
                    limit = env->negLimit;
                    if (acc > (limit << 8))
                        goto apply;
                }
                acc = (limit << 9) - acc;
                {
                    register u16 negStep asm("r0") = -stepU;
                    env->step = negStep;
                }
            apply:
                env->acc = acc;
                entry = (SoundMixEntry *)((u8 *)(*gpsp)->mixTable + byteOffset);
                acc = (s32)((u32)acc >> 8);
                acc += 16;
                entry->outSample = entry->base + acc;
            }
            byteOffset += 28;
            i++;
            slotPtr++;
        } while (i < (*gpsp)->count);
    }
}

/* sub_0802EDF0 — per-frame stream-cursor advancer (refined asm; C deferred).
 *
 * Lives in asm/disasm_0x0802edf0.s. The asm slice has been refined from
 * .incbin to real Thumb mnemonics (matching). The C decomp was attempted but
 * left blocked at ~207 byte_diff after both register-pinning iteration and
 * a ~2k-iteration permuter run (best score 2725 vs base 3410, no clear
 * convergence).
 *
 * Function shape and discovered fields (for the next agent):
 *   - Iterates `gpSoundSystem->count` slots, similar loop shape to
 *     sub_0802ED5C but with stream-table bookkeeping.
 *   - Gates per slot on flag 0x800 (active) AND a u8 frame-countdown at
 *     slot+0x33 (current) / slot+0x32 (reload).
 *   - On expiry, decrements a u16 "remaining frames" at slot+0x30
 *     (overlay of negLimit/posLimit). When remaining hits 0:
 *     if flag 0x4000 set: copy step (slot+0x2e) → slot+0x30, negate
 *     acc (slot+0x2c). Else: clear flag bits 0x4800 from slot+0x38.
 *   - Active block reads per-slot `(*gpSoundSystem)->streamTable[i]`
 *     (offset 0xc4 in SoundSystem) — a `SoundStream *[]` whose entries
 *     have fields at +0 (sub-buffer ptr), +0x8 (bound), +0xc (head /
 *     cursor), +0x10 (wrap distance). Advances head by signed acc with
 *     a non-trivial overflow predicate that varies by head-vs-field8.
 *
 * Structural blockers found during the attempt:
 *
 *   (1) The baserom prologue does `ldr r0, [r1, #0]` (preload ss) then
 *       `b _0802EEE4` straight INTO the count-check after the
 *       end-of-iteration `ldr r0, [r1]` re-fetch. agbcc's DCE removes
 *       this preload because ss is reassigned at loop_body; no source
 *       structure tried (pinned register, opaque asm("") fence, explicit
 *       passthrough) kept the load live across the b.n.
 *
 *   (2) Register allocation drift: pinning {gpsp→sl, i→r9, overflow→r8,
 *       stream→r7, remaining→r6} gets close, but agbcc allocates
 *       {ss, slot, env} to {r2, r3, r2} in our build vs {r4, r2, r3}
 *       in baserom. Pinning ss→r4 spills locals in the active block
 *       (`ldr [sp, #N]` for stream/head/field8/field10). Pinning both
 *       ss and slot makes the active block re-load stream fields from
 *       the stack instead of via r6.
 *
 *   (3) Two-step ldrh + adds reg=r0 idiom for `remaining` (baserom:
 *       `ldrh r0, [r3, #4]; adds r6, r0, #0`; agbcc folds to
 *       `ldrh r6, [r3, #4]`). The `asm("" : "=r"(remaining) : "0"(r0))`
 *       mov-fence helps locally but disturbs adjacent code.
 *
 * Permuter setup (working) is at `nonmatchings/sub_0802EDF0/`. Best
 * mutations found: cache `stream->field10` into a local before the
 * head-vs-field8 branch. Restart points: try keeping ss pinned to r0
 * with a no-op asm fence at loop_count_check, or split prologue into
 * its own function-prefix block.
 */
