#include "types.h"
#include "macros.h"

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
    s16 acc;           /* slot+0x2c */
    s16 step;          /* slot+0x2e */
    s8 negLimit;       /* slot+0x30 */
    s8 posLimit;       /* slot+0x31 */
    u8 frameReload;    /* slot+0x32 — sub_0802EDF0 only */
    u8 frameCountdown; /* slot+0x33 — sub_0802EDF0 only */
} SlotEnvelope;

typedef struct SoundSlot {
    u8 _pad00[0x2c];
    SlotEnvelope envelope; /* agbcc rounds nested struct to 8 bytes here */
    u8 _pad34[4];
    u32 flags; /* slot+0x38 */
} SoundSlot;

typedef struct SoundMixEntry {
    u32 base; /* +0x00 */
    u8 _pad04[8];
    u32 outSample; /* +0x0c */
    u8 _pad10[16];
} SoundMixEntry; /* sizeof == 28 */

/* Per-slot ring-buffer cursor used by sub_0802EDF0. Sub-buffer pointer
 * at +0, sub-buffer bound at +0x8, cursor at +0xc, wrap distance at
 * +0x10. Field +0x4 is unused at this offset granularity. */
typedef struct SoundStream {
    void *sub; /* +0x00 — &{bound, ...} */
    u8 _pad04[4];
    u32 field8;  /* +0x08 — comparison threshold for cursor */
    u32 head;    /* +0x0c — current cursor */
    u32 field10; /* +0x10 — wrap distance */
} SoundStream;

typedef struct SoundSystem {
    u8 count; /* +0x00 */
    u8 _pad01[0xbf];
    SoundMixEntry *mixTable;   /* +0xc0 */
    SoundStream **streamTable; /* +0xc4 — sub_0802EDF0 */
    u8 _padc8[4];
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

/* sub_0802EDF0 — per-frame stream-cursor advancer.
 *
 * Iterates `gpSoundSystem->count` slots. For each slot that is (a) active
 * (flag 0x800), (b) has a non-NULL SoundStream in `(*gpSoundSystem)->
 * streamTable[i]`, and (c) has elapsed its per-frame countdown, advances
 * the stream's cursor (`head`) by the signed envelope `acc`. The
 * remaining-frames counter at slot+0x30 ticks down; when it hits zero,
 * either flips into a bounce (flag 0x4000 → reload limit from step and
 * negate acc) or clears flags 0x4800.
 *
 * Shipped as NAKED inline asm + a NON_MATCHING reference C body.
 * The baserom pins `&gpSoundSystem` into the Thumb high register `sl`
 * (r10) to keep it live across the b.n into the shared count-check at
 * the loop tail. Corpus-validated unmatchable in agbcc 2.x — see
 * docs/codegen-notes.md "High registers (sl/r10, sb/r9, r8) —
 * corpus-validated unmatchable".
 *
 * History: c. May 2026 — ~2000-iter permuter run + multi-pin register
 * variants reached byte_diff 207; abandoned in favour of NAKED form
 * after corpus search confirmed no agbcc decomp in the wild matches a
 * function with sl pinned for loop state.
 */
#ifdef NON_MATCHING
void sub_0802EDF0(void)
{
    register SoundSystem **gpsp asm("sl");
    SoundSystem *ss;
    SoundSlot *slot;
    SoundStream *stream;
    SlotEnvelope *env;
    u16 remaining;
    u32 head;
    u32 cursor;
    register s32 i asm("r9");
    register s32 overflow asm("r8");
    void *sub;
    u32 sub16;

    i = 0;
    gpsp = &gpSoundSystem;
    ss = *gpsp;
    goto loop_count_check;

loop_body:
    ss = *gpsp;
    slot = ss->slotPtrTable[i];
    if (slot == NULL)
        goto next;
    if (!(slot->flags & 0x800))
        goto next;
    stream = ss->streamTable[i];
    if (stream == NULL)
        goto next;
    env = &slot->envelope;
    if (env->frameCountdown != 0)
        goto dec_countdown;
    env->frameCountdown = env->frameReload;
    remaining = *(u16 *)&env->negLimit;
    if (remaining != 0)
        goto active_block;
    if (slot->flags & 0x4000) {
        *(u16 *)&env->negLimit = env->step;
        {
            u16 accVal = *(u16 *)((u8 *)slot + 0x2c);
            *(u16 *)((u8 *)slot + 0x2c) = (u16) - (s16)accVal;
        }
    } else {
        slot->flags &= 0xFFFFB7FF;
    }
    remaining = *(u16 *)&env->negLimit;
    if (remaining == 0)
        goto next;

active_block: {
    s16 accS = env->acc;
    u32 fieldC = stream->head;
    u32 field10;
    cursor = fieldC + (u32)(s32)accS;
    overflow = 0;
    sub = stream->sub;
    sub16 = (u32)((u8 *)sub + 0x10);
    field10 = stream->field10;
    head = fieldC;
    if (head > stream->field8) {
        u32 t = cursor - field10;
        if (t < sub16)
            goto set_overflow;
        {
            u32 top = sub16 + *(u32 *)sub;
            if (cursor <= top)
                goto check_overflow;
        }
    set_overflow:
        overflow = 1;
    } else {
        if (cursor < sub16)
            goto do_bounce;
        {
            u32 sum = cursor + field10;
            u32 top = sub16 + *(u32 *)sub;
            if (sum <= top)
                goto check_overflow;
        }
        goto do_bounce;
    }
check_overflow:
    if (overflow != 0)
        goto do_bounce;
    *(u16 *)&env->negLimit = remaining - 1;
    goto store_head;
do_bounce:
    cursor = head;
    env->step = (s16)(env->step - (s16)remaining);
    *(u16 *)&env->negLimit = 0;
store_head:
    stream->head = cursor;
}
    goto next;
dec_countdown:
    env->frameCountdown = env->frameCountdown - 1;
next:
    i++;
    ss = *gpsp;
loop_count_check:
    if (i < ss->count)
        goto loop_body;
}
#else
NAKED
void sub_0802EDF0(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    movs    r0, #0\n"
        "    mov     r9, r0\n"
        "    ldr     r1, _0802EE08            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r0, [r1, #0]\n"
        "    mov     sl, r1\n"
        "    b       _0802EEE4\n"
        "    .align  2, 0\n"
        "_0802EE08: .4byte 0x030065e0\n"
        "_0802EE0C:\n"
        "    ldr     r4, [r1, #0]\n"
        "    adds    r0, r4, #0\n"
        "    adds    r0, #0xcc\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     r1, r9\n"
        "    lsls    r3, r1, #2\n"
        "    adds    r0, r3, r0\n"
        "    ldr     r2, [r0, #0]\n"
        "    cmp     r2, #0\n"
        "    beq     _0802EEDC\n"
        "    ldr     r0, [r2, #0x38]\n"
        "    movs    r1, #0x80\n"
        "    lsls    r1, r1, #4\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802EEDC\n"
        "    adds    r0, r4, #0\n"
        "    adds    r0, #0xc4\n"
        "    ldr     r0, [r0, #0]\n"
        "    adds    r0, r3, r0\n"
        "    ldr     r7, [r0, #0]\n"
        "    cmp     r7, #0\n"
        "    beq     _0802EEDC\n"
        "    adds    r3, r2, #0\n"
        "    adds    r3, #0x2c\n"
        "    ldrb    r0, [r3, #7]\n"
        "    cmp     r0, #0\n"
        "    bne     _0802EED8\n"
        "    ldrb    r0, [r3, #6]\n"
        "    strb    r0, [r3, #7]\n"
        "    ldrh    r0, [r3, #4]\n"
        "    adds    r6, r0, #0\n"
        "    cmp     r6, #0\n"
        "    bne     _0802EE76\n"
        "    ldr     r1, [r2, #0x38]\n"
        "    movs    r0, #0x80\n"
        "    lsls    r0, r0, #7\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802EE68\n"
        "    ldrh    r0, [r3, #2]\n"
        "    strh    r0, [r3, #4]\n"
        "    ldrh    r1, [r2, #0x2c]\n"
        "    negs    r0, r1\n"
        "    strh    r0, [r2, #0x2c]\n"
        "    b       _0802EE6E\n"
        "_0802EE68:\n"
        "    ldr     r0, _0802EEA4            @ =0xffffb7ff\n"
        "    ands    r1, r0\n"
        "    str     r1, [r2, #0x38]\n"
        "_0802EE6E:\n"
        "    ldrh    r0, [r3, #4]\n"
        "    adds    r6, r0, #0\n"
        "    cmp     r6, #0\n"
        "    beq     _0802EEDC\n"
        "_0802EE76:\n"
        "    movs    r1, #0\n"
        "    ldrsh   r0, [r3, r1]\n"
        "    ldr     r1, [r7, #0xc]\n"
        "    adds    r5, r1, r0\n"
        "    movs    r0, #0\n"
        "    mov     r8, r0\n"
        "    ldr     r4, [r7, #0]\n"
        "    adds    r2, r4, #0\n"
        "    adds    r2, #0x10\n"
        "    ldr     r0, [r7, #8]\n"
        "    mov     ip, r1\n"
        "    cmp     ip, r0\n"
        "    bhi     _0802EEA8\n"
        "    cmp     r5, r2\n"
        "    bcc     _0802EEC2\n"
        "    ldr     r1, [r7, #0x10]\n"
        "    adds    r1, r5, r1\n"
        "    ldr     r0, [r4, #0]\n"
        "    adds    r0, r2, r0\n"
        "    cmp     r1, r0\n"
        "    bls     _0802EEBC\n"
        "    b       _0802EEC2\n"
        "    .align  2, 0\n"
        "_0802EEA4: .4byte 0xffffb7ff\n"
        "_0802EEA8:\n"
        "    ldr     r0, [r7, #0x10]\n"
        "    subs    r0, r5, r0\n"
        "    cmp     r0, r2\n"
        "    bcc     _0802EEB8\n"
        "    ldr     r0, [r4, #0]\n"
        "    adds    r0, r2, r0\n"
        "    cmp     r5, r0\n"
        "    bls     _0802EEBC\n"
        "_0802EEB8:\n"
        "    movs    r1, #1\n"
        "    mov     r8, r1\n"
        "_0802EEBC:\n"
        "    mov     r0, r8\n"
        "    cmp     r0, #0\n"
        "    beq     _0802EED0\n"
        "_0802EEC2:\n"
        "    mov     r5, ip\n"
        "    ldrh    r1, [r3, #2]\n"
        "    subs    r0, r1, r6\n"
        "    movs    r1, #0\n"
        "    strh    r0, [r3, #2]\n"
        "    strh    r1, [r3, #4]\n"
        "    b       _0802EED4\n"
        "_0802EED0:\n"
        "    subs    r0, r6, #1\n"
        "    strh    r0, [r3, #4]\n"
        "_0802EED4:\n"
        "    str     r5, [r7, #0xc]\n"
        "    b       _0802EEDC\n"
        "_0802EED8:\n"
        "    subs    r0, #1\n"
        "    strb    r0, [r3, #7]\n"
        "_0802EEDC:\n"
        "    movs    r0, #1\n"
        "    add     r9, r0\n"
        "    mov     r1, sl\n"
        "    ldr     r0, [r1, #0]\n"
        "_0802EEE4:\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r9, r0\n"
        "    blt     _0802EE0C\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n");
}
#endif
