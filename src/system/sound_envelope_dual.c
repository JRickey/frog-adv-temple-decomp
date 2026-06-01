#include "types.h"
#include "macros.h"

/* sub_0802E934 — per-frame "dual envelope" tick.
 *
 * Sister of sub_0802EC7C (sound_channel.c, envelope-A at +0x1c) and
 * sub_0802EA80 (sound_envelope.c, envelope-A0 at +0x14). Same two-stage
 * shape: stage 1 walks three inline channel blocks embedded in
 * SoundSystem itself (ss+0x20, ss+0x44, ss+0x68 — stride 36); stage 2
 * walks the per-slot bank via ss->slotPtrTable[i]. The distinguishing
 * feature: each channel/slot exposes TWO sub-envelopes back-to-back at
 * the START of the channel block (offsets +4 and +12 inside each ch_base,
 * stride 8). Each sub-envelope has the familiar 8-byte acc/step/limit
 * shape.
 *
 * Bounce semantics differ from sub_0802EC7C: instead of clamping to the
 * limit and zeroing step, the wrap subtracts the unsigned u16 form of
 * the limit from the accumulator — a true sawtooth wrap. step is
 * preserved across the wrap. dirty bit 0x40 is ORd into ss->chFlags[i]
 * (stage 1) or slot->flags (stage 2) unconditionally whenever step is
 * non-zero.
 *
 *   if step != 0:
 *       acc = (u16)(acc + step)
 *       if limit > 0 && (s16)acc > limit:  acc -= (u16)limit
 *       if limit < 0 && (s16)acc < limit:  acc -= (u16)limit
 *       (limit == 0 has its own bge path that effectively no-ops)
 *       chFlags[i] |= 0x40   /  slot->flags |= 0x40
 *
 * Shipped as NAKED inline asm + a NON_MATCHING reference C body. The
 * baserom pins THREE values into Thumb high registers as loop state:
 *   sl  =  &gpSoundSystem        (alive across stage 2 count check)
 *   r9  =  sl  (mirror, used by stage-1 inner reload)
 *   r8  =  ch_base offset i*36+32
 *   ip  =  i*4 (chFlags byte stride)
 * agbcc 2.x will not promote any of these to high regs from C source —
 * see docs/codegen-notes.md "High registers (sl/r10, sb/r9, r8) —
 * corpus-validated unmatchable". The readable C is preserved behind
 * NON_MATCHING for the phase-3 PC port; the NAKED form ships the
 * baserom bytes.
 */

/* The +4/+12 sub-envelope pair. Both sub-envelopes share this shape.
 * Promote to include/sound.h once a common header is needed. */
typedef struct DualSubEnv {
    u16 acc;   /* +0 — accumulator */
    s16 step;  /* +2 — per-frame step */
    s16 limit; /* +4 — wrap threshold (signed) */
    u8 _pad6[2];
} DualSubEnv;

typedef struct SoundSlot {
    u8 _pad00[4];
    DualSubEnv subEnv[2]; /* +4 (acc/step/limit), +12 (same) */
    u8 _pad14[0x24];
    u32 flags; /* slot+0x38 */
} SoundSlot;

typedef struct SoundSystem {
    u8 count; /* +0x00 */
    u8 _pad01[0xf];
    u32 chFlags[4]; /* +0x10 — per-channel dirty-flag word */
    u8 _pad20[0xac];
    SoundSlot **slotPtrTable; /* +0xcc */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

#ifdef NON_MATCHING
void sub_0802E934(void)
{
    SoundSystem *ss;
    SoundSlot *slot;
    DualSubEnv *env;
    s32 i;
    s32 j;
    s32 chBaseOff;
    s32 envOff;
    s16 step;
    u16 acc;
    s16 limit;
    u16 limitU;

    /* Stage 1: three inline channel envelopes embedded in SoundSystem
     * at ss+0x20, ss+0x44, ss+0x68 (stride 36). Each channel block has
     * two sub-envelopes at +4 and +12 inside it. */
    i = 0;
    do {
        chBaseOff = i * 36 + 0x20;
        envOff = 4;
        for (j = 0; j <= 1; j++) {
            ss = gpSoundSystem;
            env = (DualSubEnv *)((u8 *)ss + chBaseOff + envOff);
            step = env->step;
            if (step != 0) {
                acc = (u16)(env->acc + step);
                env->acc = acc;
                limit = env->limit;
                limitU = (u16)limit;
                if (limit > 0) {
                    if ((s16)acc > limit)
                        env->acc = (u16)(acc - limitU);
                } else {
                    if ((s16)acc < limit)
                        env->acc = (u16)(acc - limitU);
                }
                gpSoundSystem->chFlags[i] |= 0x40;
            }
            envOff += 8;
        }
        i++;
    } while (i <= 2);

    /* Stage 2: per-slot dual envelope bank, walked via slotPtrTable. */
    i = 0;
    while (i < gpSoundSystem->count) {
        slot = gpSoundSystem->slotPtrTable[i];
        if (slot != NULL) {
            envOff = 0;
            for (j = 0; j <= 1; j++) {
                env = (DualSubEnv *)((u8 *)&slot->subEnv[0] + envOff);
                step = env->step;
                if (step != 0) {
                    acc = (u16)(env->acc + step);
                    env->acc = acc;
                    limit = env->limit;
                    limitU = (u16)limit;
                    if (limit > 0) {
                        if ((s16)acc > limit)
                            env->acc = (u16)(acc - limitU);
                    } else {
                        if ((s16)acc < limit)
                            env->acc = (u16)(acc - limitU);
                    }
                    slot->flags |= 0x40;
                }
                envOff += 8;
            }
        }
        i++;
    }
}
#else
NAKED
void sub_0802E934(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    movs    r2, #0\n"
        "    ldr     r0, _0802E988            @ =gpSoundSystem (0x030065e0)\n"
        "    mov     sl, r0\n"
        "    mov     r9, sl\n"
        "_0802E946:\n"
        "    lsls    r0, r2, #3\n"
        "    adds    r7, r2, #1\n"
        "    adds    r0, r0, r2\n"
        "    lsls    r0, r0, #2\n"
        "    adds    r0, #0x20\n"
        "    mov     r8, r0\n"
        "    movs    r5, #4\n"
        "    lsls    r2, r2, #2\n"
        "    mov     ip, r2\n"
        "    movs    r6, #1\n"
        "_0802E95A:\n"
        "    mov     r1, r9\n"
        "    ldr     r0, [r1, #0]\n"
        "    add     r0, r8\n"
        "    adds    r2, r0, r5\n"
        "    ldrh    r1, [r2, #2]\n"
        "    movs    r3, #2\n"
        "    ldrsh   r0, [r2, r3]\n"
        "    cmp     r0, #0\n"
        "    beq     _0802E9A8\n"
        "    ldrh    r0, [r2, #0]\n"
        "    adds    r1, r1, r0\n"
        "    strh    r1, [r2, #0]\n"
        "    ldrh    r4, [r2, #4]\n"
        "    movs    r0, #4\n"
        "    ldrsh   r3, [r2, r0]\n"
        "    cmp     r3, #0\n"
        "    ble     _0802E98C\n"
        "    lsls    r0, r1, #0x10\n"
        "    asrs    r0, r0, #0x10\n"
        "    cmp     r0, r3\n"
        "    ble     _0802E998\n"
        "    b       _0802E994\n"
        "    .align  2, 0\n"
        "_0802E988: .4byte 0x030065e0\n"
        "_0802E98C:\n"
        "    lsls    r0, r1, #0x10\n"
        "    asrs    r0, r0, #0x10\n"
        "    cmp     r0, r3\n"
        "    bge     _0802E998\n"
        "_0802E994:\n"
        "    subs    r0, r1, r4\n"
        "    strh    r0, [r2, #0]\n"
        "_0802E998:\n"
        "    mov     r1, r9\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0x10\n"
        "    add     r0, ip\n"
        "    ldr     r1, [r0, #0]\n"
        "    movs    r2, #0x40\n"
        "    orrs    r1, r2\n"
        "    str     r1, [r0, #0]\n"
        "_0802E9A8:\n"
        "    adds    r5, #8\n"
        "    subs    r6, #1\n"
        "    cmp     r6, #0\n"
        "    bge     _0802E95A\n"
        "    adds    r2, r7, #0\n"
        "    cmp     r2, #2\n"
        "    ble     _0802E946\n"
        "    movs    r2, #0\n"
        "    b       _0802EA12\n"
        "_0802E9BA:\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0xcc\n"
        "    ldr     r1, [r0, #0]\n"
        "    lsls    r0, r2, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r5, [r0, #0]\n"
        "    adds    r7, r2, #1\n"
        "    cmp     r5, #0\n"
        "    beq     _0802EA10\n"
        "    adds    r2, r5, #4\n"
        "    movs    r6, #1\n"
        "_0802E9D0:\n"
        "    ldrh    r1, [r2, #2]\n"
        "    movs    r3, #2\n"
        "    ldrsh   r0, [r2, r3]\n"
        "    cmp     r0, #0\n"
        "    beq     _0802EA08\n"
        "    ldrh    r0, [r2, #0]\n"
        "    adds    r1, r1, r0\n"
        "    strh    r1, [r2, #0]\n"
        "    ldrh    r4, [r2, #4]\n"
        "    movs    r0, #4\n"
        "    ldrsh   r3, [r2, r0]\n"
        "    cmp     r3, #0\n"
        "    ble     _0802E9F4\n"
        "    lsls    r0, r1, #0x10\n"
        "    asrs    r0, r0, #0x10\n"
        "    cmp     r0, r3\n"
        "    ble     _0802EA00\n"
        "    b       _0802E9FC\n"
        "_0802E9F4:\n"
        "    lsls    r0, r1, #0x10\n"
        "    asrs    r0, r0, #0x10\n"
        "    cmp     r0, r3\n"
        "    bge     _0802EA00\n"
        "_0802E9FC:\n"
        "    subs    r0, r1, r4\n"
        "    strh    r0, [r2, #0]\n"
        "_0802EA00:\n"
        "    ldr     r0, [r5, #0x38]\n"
        "    movs    r1, #0x40\n"
        "    orrs    r0, r1\n"
        "    str     r0, [r5, #0x38]\n"
        "_0802EA08:\n"
        "    adds    r2, #8\n"
        "    subs    r6, #1\n"
        "    cmp     r6, #0\n"
        "    bge     _0802E9D0\n"
        "_0802EA10:\n"
        "    adds    r2, r7, #0\n"
        "_0802EA12:\n"
        "    mov     r1, sl\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r2, r0\n"
        "    blt     _0802E9BA\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .hword  0x0000\n"
        "    .syntax divided\n");
}
#endif

void sub_0802EA2C(s32 step, u32 reload, s32 ch)
{
    if (ch <= 2) {
        u8 *base;
        register s32 off asm("r1");
        u32 half;

        base = (u8 *)gpSoundSystem;
        off = ch * 36;
        *(u8 *)(base + off + 57) = reload;
        base = (u8 *)gpSoundSystem + off;
        half = reload >> 1;
        base[56] = half;
        *(s16 *)((u8 *)gpSoundSystem + off + 54) = step;
        return;
    }

    if (ch <= 3)
        return;

    {
        u8 **bankp = (u8 **)((u8 *)gpSoundSystem + 0xc8);
        u8 *slot = (u8 *)(ch * 64 + (s32)*bankp - 0xec);

        slot[5] = reload;
        slot[4] = reload >> 1;
        *(s16 *)(slot + 2) = step;
    }
}
