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
    SoundSystem **gpsp;
    SoundSlot *slot;
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

/* sub_0802F398 — recompute and commit one slot's stereo pan into its mix entry.
 *
 * Standalone form of the per-slot pan stage that the mixer (sub_0802F4B0)
 * also runs inline. Given a slot index it advances the slot's volume scale,
 * maps the slot's 8-bit pan position (slot+0x3c) through a 3-segment bounce
 * curve into left/right gains scaled by that volume, then multiplies each
 * gain by the master pan base (gpSoundSystem+0xbe when slot flag 0x10000 is
 * set, else +0xbc) and commits the two gain bytes plus a mono flag into the
 * mix entry at gpSoundSystem[0xc0] + index*28, bracketed by the sound
 * mutation lock (sub_0802E418 / sub_0802E3F8).
 *
 *   pan in [0x00,0x3f]  — left-biased segment   (mono = 0)
 *   pan in [0x40,0x7f]  — right-biased segment   (mono = 0)
 *   pan >= 0x80         — both channels equal     (mono = 1)
 *
 * Matching notes: the SoundSystem base-pointer address is anchored in r2 and
 * re-dereferenced at every use (never cached) so agbcc emits one pool load;
 * the slot pointer lives in ip, idx/vol/mix in r5/r4/r7, and the mono flag in
 * r8 across the lock BL (high-register local), mirroring the void-return /
 * save-r8 prologue shape used throughout this sound cluster (sub_0802F2FC).
 * vol and panBase share r4 (vol is dead once the gains are scaled). The
 * baserom loads panBase into r0 then recolours it into r4 with an explicit
 * `adds r4, r0, #0`; agbcc would otherwise load straight into r4, so the
 * `asm("" : "=r"(panBase) : "0"(pbLoaded))` barrier reinstates that copy (a
 * register-recolour lever, not emitted code — see docs/codegen-notes.md).
 * The pan-curve coefficients (0x4ac8, 0xb538, 0xb818) are the same Q-format
 * constants the mixer's inline pan block uses.
 */

#define PAN_COEF_A 0x4ac8
#define PAN_COEF_B 0xb538
#define PAN_COEF_C 0xb818

typedef struct PanSlot {
    u8 _pad00[0x28];
    u16 pitchStep; /* +0x28 */
    u8 volCache;   /* +0x2a — written: scaled volume */
    u8 volScale;   /* +0x2b */
    u8 _pad2c[0xc];
    u32 flags; /* +0x38 */
    u8 panPos; /* +0x3c */
} PanSlot;

typedef struct PanMixEntry {
    u8 _pad00[0x18];
    u8 gainL; /* +0x18 */
    u8 gainR; /* +0x19 */
    u8 mono;  /* +0x1a */
} PanMixEntry;

typedef struct PanSoundSystem {
    u8 _pad00[0xbc];
    u16 panBase;    /* +0xbc */
    u16 panBaseAlt; /* +0xbe */
    u8 *mixTable;   /* +0xc0 */
    u8 _padc4[8];
    PanSlot **slotPtrTable; /* +0xcc */
} PanSoundSystem;

#define gpPanSystem (*(PanSoundSystem **)0x030065e0)

extern void sub_0802E418(void);
extern void sub_0802E3F8(void);

void sub_0802F398(s32 index)
{
    register s32 idx asm("r5");
    register PanSoundSystem **gpsp asm("r2");
    register PanSlot *slot asm("ip");
    PanMixEntry *mix;
    register u32 vol asm("r4");
    u32 pan;
    u32 gainL;
    u32 gainR;
    u32 t;
    register u32 mono asm("r8");
    register u32 panBase asm("r4");
    u16 *pbp;

    idx = index;
    gpsp = &gpPanSystem;
    slot = (*gpsp)->slotPtrTable[idx];
    if (slot == NULL)
        return;

    vol = slot->pitchStep >> 8;
    if (vol != 0)
        vol++;
    t = slot->volScale * vol << 8;
    vol = t >> 16;
    slot->volCache = vol;

    pan = *((u8 *)&slot->volCache + 0x12);

    mix = (PanMixEntry *)((*gpsp)->mixTable + idx * 28);

    if ((pan << 24) >> 24 <= 0x3f) {
        gainL = (u8)((s32)(((u32)((s32)((0x40 - pan) * PAN_COEF_A) >> 6) + PAN_COEF_B) * vol) >> 16);
        t = (s32)(PAN_COEF_C * pan) >> 6;
        gainR = (u8)((s32)(t * vol) >> 16);
        mono = 0;
    } else if ((s32)(pan << 24) >= 0) {
        gainL = (u8)((s32)(((s32)((0x7f - pan) * PAN_COEF_C) >> 6) * vol) >> 16);
        t = (u32)((s32)((pan - 0x3f) * PAN_COEF_A) >> 6) + PAN_COEF_B;
        gainR = (u8)((s32)(t * vol) >> 16);
        mono = 0;
    } else {
        gainR = (u8)((s32)(PAN_COEF_B * vol) >> 16);
        gainL = gainR;
        mono = 1;
    }

    {
        register PanSlot *sf asm("r1");
        sf = slot;
        if (sf->flags & 0x10000)
            pbp = &(*gpsp)->panBaseAlt;
        else
            pbp = &(*gpsp)->panBase;
    }
    {
        register u32 pbLoaded asm("r0");
        pbLoaded = *pbp;
        asm("" : "=r"(panBase) : "0"(pbLoaded));
    }

    sub_0802E418();
    mix->gainL = (s32)(gainL * panBase) >> 8;
    mix->gainR = (s32)(gainR * panBase) >> 8;
    mix->mono = mono;
    sub_0802E3F8();
}
