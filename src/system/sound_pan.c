#include "types.h"
#include "macros.h"

/* sub_0802F2FC — per-frame pan-envelope tick.
 *
 * Sister of sub_0802ED5C (envelope B at +0x2c) and sub_0802EC7C (envelope A
 * at +0x1c). This one drives the per-slot pan envelope: a triangular-bounce
 * accumulator at slot+0xa (acc) / slot+0x12 (step) clamped against signed
 * limits stored in slot+0x1a (negLimit, byte) / slot+0x1b (posLimit, byte),
 * scaled << 8. The 8-bit-shifted MSB of the new accumulator is the current
 * pan value; it is cached in slot+0x3c and any change flips the slot.flags
 * dirty bit 0x80 so the mixer reapplies pan on the next mix step.
 *
 * One additional twist: on a bounce against either limit, the step is
 * negated ONLY when flag bit 0x2000 ("auto-reverse") is set in slot.flags.
 * Without that bit the bounce clamps acc but leaves step unchanged, so the
 * envelope re-bounces every frame (the clamp keeps acc pinned at the wall).
 *
 * Companion to sub_0802ED5C (volume envelope, +0x2c block) and sub_0802EC7C
 * (envelope A at +0x1c). Called sequentially from sub_0802F4B0, the
 * per-VBlank mixer driver.
 *
 * Shipped as NAKED inline asm + NON_MATCHING reference C. The baserom
 * caches the per-iteration slot pointer in r8 (mov r8, r3 in the loop body,
 * mov r0, r8 at the writeback site) and &gpSoundSystem in ip across the
 * count-check at the loop tail. agbcc 2.x will not promote a value to a
 * Thumb high register for loop state — see docs/codegen-notes.md
 * "High registers (sl/r10, sb/r9, r8) — corpus-validated unmatchable".
 */

typedef struct SlotPanEnvelope {
    s16 acc;     /* slot+0x0a — pan accumulator */
    s16 step;    /* slot+0x12 — per-frame step */
    s8 negLimit; /* slot+0x1a — limits, scaled << 8 against acc */
    s8 posLimit; /* slot+0x1b */
    u32 flags;   /* slot+0x38 — auto-reverse @0x2000, dirty @0x80 */
    u8 panCache; /* slot+0x3c — last emitted pan byte */
} SlotPanEnvelope;

typedef struct SoundSlot {
    u8 _pad00[0xa];
    s16 panAcc; /* +0x0a */
    u8 _pad0c[6];
    s16 panStep; /* +0x12 */
    u8 _pad14[6];
    s8 panNegLimit; /* +0x1a */
    s8 panPosLimit; /* +0x1b */
    u8 _pad1c[0x1c];
    u32 flags;   /* +0x38 */
    u8 panCache; /* +0x3c */
} SoundSlot;

typedef struct SoundSystem {
    u8 count; /* +0x00 */
    u8 _pad01[0xcb];
    SoundSlot **slotPtrTable; /* +0xcc */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

#ifdef NON_MATCHING
void sub_0802F2FC(void)
{
    register SoundSystem **gpsp asm("ip");
    register SoundSlot *slot asm("r8");
    s32 i;
    s32 step;
    s32 sum;
    s32 limQ;
    u16 savedStep;

    i = 0;
    gpsp = &gpSoundSystem;
    if (i >= (*gpsp)->count)
        return;

    for (; i < (*gpsp)->count; i++) {
        slot = (*gpsp)->slotPtrTable[i];
        if (slot == NULL)
            continue;
        savedStep = (u16)slot->panStep;
        step = slot->panStep;
        if (step == 0)
            continue;
        sum = slot->panAcc + step;
        if (step > 0) {
            limQ = slot->panPosLimit << 8;
            if (sum >= limQ) {
                /* Reflect across posLimit: sum = 2*limQ - sum. */
                sum = limQ - (sum - limQ);
                if (slot->flags & 0x2000)
                    slot->panStep = -(s16)savedStep;
            } else {
                goto write_acc;
            }
        } else {
            limQ = slot->panNegLimit << 8;
            if (sum <= limQ) {
                sum = limQ + (limQ - sum);
                if (slot->flags & 0x2000)
                    slot->panStep = -(s16)savedStep;
            } else {
                goto write_acc;
            }
        }
    write_acc:
        slot->panAcc = (s16)sum;
        {
            s32 newPan = sum >> 8; /* arithmetic — sum is signed */
            if (newPan != slot->panCache) {
                slot->panCache = (u8)newPan;
                slot->flags |= 0x80;
            }
        }
    }
}
#else
NAKED
void sub_0802F2FC(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, r8\n"
        "    push    {r7}\n"
        "    movs    r5, #0\n"
        "    ldr     r1, _0802F34C            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r0, [r1, #0]\n"
        "    mov     ip, r1\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r5, r0\n"
        "    bge     _0802F38E\n"
        "    movs    r7, #0x80\n"
        "    lsls    r7, r7, #6\n"
        "_0802F314:\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0xcc\n"
        "    ldr     r1, [r0, #0]\n"
        "    lsls    r0, r5, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r3, [r0, #0]\n"
        "    cmp     r3, #0\n"
        "    beq     _0802F382\n"
        "    mov     r8, r3\n"
        "    ldrh    r4, [r3, #0x12]\n"
        "    movs    r0, #0x12\n"
        "    ldrsh   r2, [r3, r0]\n"
        "    cmp     r2, #0\n"
        "    beq     _0802F382\n"
        "    movs    r6, #0xa\n"
        "    ldrsh   r1, [r3, r6]\n"
        "    adds    r0, r2, #0\n"
        "    adds    r1, r1, r0\n"
        "    cmp     r2, #0\n"
        "    ble     _0802F350\n"
        "    ldrb    r0, [r3, #0x1b]\n"
        "    lsls    r2, r0, #8\n"
        "    cmp     r1, r2\n"
        "    blt     _0802F368\n"
        "    subs    r0, r1, r2\n"
        "    subs    r1, r2, r0\n"
        "    b       _0802F35C\n"
        "    .align  2, 0\n"
        "_0802F34C: .4byte 0x030065e0\n"
        "_0802F350:\n"
        "    ldrb    r6, [r3, #0x1a]\n"
        "    lsls    r2, r6, #8\n"
        "    cmp     r1, r2\n"
        "    bgt     _0802F368\n"
        "    subs    r0, r2, r1\n"
        "    adds    r1, r2, r0\n"
        "_0802F35C:\n"
        "    ldr     r0, [r3, #0x38]\n"
        "    ands    r0, r7\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F366\n"
        "    negs    r0, r4\n"
        "_0802F366:\n"
        "    strh    r0, [r3, #0x12]\n"
        "_0802F368:\n"
        "    mov     r0, r8\n"
        "    strh    r1, [r0, #0xa]\n"
        "    asrs    r0, r1, #8\n"
        "    adds    r2, r3, #0\n"
        "    adds    r2, #0x3c\n"
        "    ldrb    r1, [r2, #0]\n"
        "    cmp     r0, r1\n"
        "    beq     _0802F382\n"
        "    strb    r0, [r2, #0]\n"
        "    ldr     r0, [r3, #0x38]\n"
        "    movs    r1, #0x80\n"
        "    orrs    r0, r1\n"
        "    str     r0, [r3, #0x38]\n"
        "_0802F382:\n"
        "    adds    r5, #1\n"
        "    mov     r1, ip\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r5, r0\n"
        "    blt     _0802F314\n"
        "_0802F38E:\n"
        "    pop     {r3}\n"
        "    mov     r8, r3\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .syntax divided\n");
}
#endif
