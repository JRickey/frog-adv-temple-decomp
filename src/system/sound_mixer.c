#include "sound.h"
#include "macros.h"

/* sub_0802F4B0 — sound-system per-VBlank mixer tick.
 *
 * Architectural keystone of the sound subsystem. Called once per frame
 * from the VBlank IRQ handler (sub_08000790), after the OAM/BG-scroll
 * shadow flush. Drives the entire sound-channel state machine:
 *
 *   1. Dispatches the 8 per-frame sub-update routines in fixed order:
 *      sub_080315D8 (opcode-script dispatcher),
 *      sub_0802E934 (envelope-dual tick),
 *      sub_0802EA80 (envelope-A0 tick),
 *      sub_0802EC7C (envelope-A tick),
 *      sub_0802ED5C (envelope-B tick),
 *      sub_0802EDF0 (stream-cursor advancer),
 *      sub_0802F054 (envelope-C tick),
 *      sub_0802F2FC (pan-envelope tick).
 *
 *   2. Stage 1 — fade-request slots (3 entries, ss->chFlags[0..2]):
 *      bit 0x40 set means the active envelopes contributed enough to
 *      this channel that the mixer must apply a fade update. Sum 6
 *      halfwords scattered across slot+0x20..+0x3c (the 6 per-active-
 *      voice mix accumulators), pack the high 16 bits into r0/r1, and
 *      forward to sub_0802E5D8 (pitch-and-fade interpolator).
 *
 *   3. Stage 2 — volume-request slots (4 entries, ss->chFlags[0..3]):
 *      bit 0x80 set means channel volume changed; re-apply. Reads a
 *      per-channel halfword at +0x90 (volume), multiplies by the byte
 *      at +0x93 (mix scale), and either reads pan-base from +0xbc
 *      (normal) or +0xbe (high-bit pan-override) before forwarding to
 *      sub_0802E684 (per-channel volume setter). Also clears flag
 *      0xfffffdff (== ~0x200) on bit 0x200 set, OR-ing 0x8000 into
 *      *(ss->mixerRegs + 12).
 *
 *   4. Stage 3 — per-active-slot mixer pass (ss->slotPtrTable[0..count)):
 *      For each non-NULL slot:
 *        - decrement the u16 countdown at slot+0x36 by the byte at +0x3f,
 *          clamping at 0,
 *        - if slot.flags bit 0x80 set, apply pitch envelope:
 *          new_step = (slot.pitch_step_hi<<1 + carry) * slot.pitch_acc * 256 >> 16
 *          stored back to slot+0x2a,
 *        - compute pan via two LUT paths (positive/negative bounce) using
 *          the coefficient pool 0x4ac8 / 0xb538 / 0xb818 (and ROM-data at
 *          0x083dda1c for the LUT base), gated by the input value 0x3f /
 *          0x7f / negative split,
 *        - bracket the writes to mixTable+0x18..0x1a with sub_0802E418
 *          (mutation lock; increments refcount at ss+0xbb) and
 *          sub_0802E3F8 (unlock).
 *        - if slot.flags bit 0x40 set, sum 6 halfwords (different
 *          stride/offsets than stage 1) and forward to sub_080301C4
 *          (mix-table commit), writing the result to mixEntry+0x14.
 *        - if slot.flags bit 0x8000 set, clear ss->slotPtrTable[i] (slot
 *          retire).
 *
 *   5. Stage 4 — post-mixer slot-retire pass: walk the slot table again,
 *      clearing flag bit 0x500 from slot.flags entries that have both
 *      flag 0x200 and any of the 0xa00 bits set; writes a pointer (the
 *      ss-relative byte offset cached in r4) into a parallel table at
 *      ss+0xc4. Then bracketed by sub_0802E418 / sub_0802E3F8 again, and
 *      finally calls sub_080325B0 (sound-system tail).
 *
 * Shipped as NAKED inline asm + NON_MATCHING reference C. This is the
 * deepest stack of patterns we have seen so far:
 *   - High registers r8/r9/sl used as loop state and pointer caches
 *     (push {r4-r7, lr} + 3-slot high-reg save into r5-r7 in the
 *      prologue) — corpus-validated unmatchable.
 *   - Inline literal pools split across at least 4 sites with branch-
 *     over-pool idiom (`b.n past-pool; .hword 0; pool words; code`).
 *   - Three nested loops at 462 instructions, more than 3x the size of
 *     any prior sound-cluster NAKED function.
 * The readable C body lives behind NON_MATCHING for the phase-3 PC port;
 * the NAKED form ships the baserom bytes.
 *
 * See docs/subsystems.md "Sound" for the cluster overview and
 * docs/unknowns.md (sub_0802F4B0 section) for blocker history.
 */

/* Forward declarations of the 8 sub-update routines this function calls.
 * All live in the sibling sound_*.c files in this directory. */
extern void sub_080315D8(void);
extern void sub_0802E934(void);
extern void sub_0802EA80(void);
extern void sub_0802EC7C(void);
extern void sub_0802ED5C(void);
extern void sub_0802EDF0(void);
extern void sub_0802F054(void);
extern void sub_0802F2FC(void);

/* Per-channel and per-slot helpers (still in asm/disasm_*.s). */
extern void sub_0802E5D8(u32 hi16, u32 lo16, u32 channelIdx);
extern void sub_0802E684(u32 panBase, u32 channelIdx);
extern void sub_0802E418(void);
extern void sub_0802E3F8(void);
extern u32 sub_080301C4(u32 hi, u32 mid, u32 lo);
extern void sub_080325B0(void);

#ifdef NON_MATCHING
/* Reference body — readable shape for the phase-3 PC port. Does NOT
 * byte-match; agbcc 2.x's allocator picks low-reg shapes from any
 * plausible C input and the baserom uses sl/r9/r8 for loop state. */

void sub_0802F4B0(void)
{
    SoundSystem *ss;
    SoundSlot *slot;
    s32 i;
    u32 b, c;
    u32 sum;
    u32 stride;
    u32 panBase;

    sub_080315D8();
    sub_0802E934();
    sub_0802EA80();
    sub_0802EC7C();
    sub_0802ED5C();
    sub_0802EDF0();
    sub_0802F054();
    sub_0802F2FC();

    for (i = 0; i <= 2; i++) {
        ss = gpSoundSystem;
        if (ss->chFlags[i] & 0x40) {
            ss->chFlags[i] &= ~0x40u;
            slot = (SoundSlot *)((u8 *)ss + i * 36 + 0x20);
            sum = SOUND_SLOT_ACC_SUM(slot);
            sub_0802E5D8(sum >> 8, (sum & 0xff0000) >> 16, i);
        }
    }

    for (i = 0; i <= 3; i++) {
        ss = gpSoundSystem;
        if (ss->chFlags[i] & 0x80) {
            ss->chFlags[i] &= ~0x80u;
            b = SOUND_SYSTEM_CHANNEL_VOLUME(ss)[i][0];
            c = (b >> 8) ? (b >> 8) + 1 : 0;
            stride = ((u8 *)ss)[i * 8 + 0x93] * c << 8 >> 16;
            panBase = (ss->chFlags[i] & 0x10000) ? ss->panOverride2 : ss->panOverride1;
            sub_0802E684((panBase * stride << 8) >> 16, i);
        }
        if (gpSoundSystem->chFlags[i] & 0x200) {
            *(u16 *)((u32 *)ss->mixTable + 3) |= 0x8000;
            ss->chFlags[i] &= 0xfffffdff;
        }
    }

    for (i = 0; i < gpSoundSystem->count; i++) {
        slot = gpSoundSystem->slotPtrTable[i];
        if (slot == NULL)
            continue;
        if (SOUND_SLOT_COUNTDOWN(slot) != 0) {
            s32 d = (s32)SOUND_SLOT_COUNTDOWN(slot) - SOUND_SLOT_COUNTDOWN_STEP(slot);
            if (d < 0)
                d = 0;
            SOUND_SLOT_COUNTDOWN(slot) = (u16)d;
        }
        if (slot->flags & 0x80) {
            slot->flags &= ~0x80u;
            /* pitch + pan LUT path — see baserom bytes for exact math */
            sub_0802E418();
            sub_0802E3F8();
        }
        if (slot->flags & 0x40) {
            slot->flags &= ~0x40u;
            if (slot->flags & 0x1400) {
                sum = SOUND_SLOT_ACC_SUM(slot);
                sub_080301C4(0, ((sum << 16) >> 16) >> 8, (sum << 24) >> 24);
            }
        }
        if (slot->flags & 0x8000) {
            gpSoundSystem->slotPtrTable[i] = NULL;
        }
    }

    sub_0802E418();
    for (i = 0; i < gpSoundSystem->count; i++) {
        slot = gpSoundSystem->slotPtrTable[i];
        if (slot != NULL && (slot->flags & 0x200) && (slot->flags & 0xa00)) {
            slot->flags &= 0xfffffdff;
            SOUND_SYSTEM_RETIRE_TABLE(gpSoundSystem)[i] = (u32)((u8 *)gpSoundSystem->mixTable + i * 28);
        }
    }
    sub_0802E3F8();
    sub_080325B0();
}

#else
NAKED
void sub_0802F4B0(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    sub     sp, #0xc\n"
        "    bl      sub_080315D8\n"
        "    bl      sub_0802E934\n"
        "    bl      sub_0802EA80\n"
        "    bl      sub_0802EC7C\n"
        "    bl      sub_0802ED5C\n"
        "    bl      sub_0802EDF0\n"
        "    bl      sub_0802F054\n"
        "    bl      sub_0802F2FC\n"
        "    movs    r0, #0\n"
        "    mov     r9, r0\n"
        "    movs    r4, #0\n"
        "_0802F4E2:\n"
        "    ldr     r0, _0802F58C            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r3, [r0, #0]\n"
        "    mov     r2, r9\n"
        "    lsls    r1, r2, #2\n"
        "    adds    r0, r3, #0\n"
        "    adds    r0, #0x10\n"
        "    adds    r2, r0, r1\n"
        "    ldr     r1, [r2, #0]\n"
        "    movs    r0, #0x40\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F52C\n"
        "    movs    r0, #0x41\n"
        "    negs    r0, r0\n"
        "    ands    r1, r0\n"
        "    str     r1, [r2, #0]\n"
        "    adds    r0, r3, r4\n"
        "    ldrh    r3, [r0, #0x20]\n"
        "    ldrh    r1, [r0, #0x22]\n"
        "    adds    r2, r3, r1\n"
        "    ldrh    r3, [r0, #0x24]\n"
        "    adds    r2, r3, r2\n"
        "    ldrh    r1, [r0, #0x2c]\n"
        "    adds    r2, r1, r2\n"
        "    ldrh    r3, [r0, #0x34]\n"
        "    adds    r2, r3, r2\n"
        "    ldrh    r0, [r0, #0x3c]\n"
        "    adds    r2, r0, r2\n"
        "    lsls    r2, r2, #0x10\n"
        "    lsrs    r0, r2, #0x18\n"
        "    movs    r1, #0xff\n"
        "    lsls    r1, r1, #0x10\n"
        "    ands    r1, r2\n"
        "    asrs    r1, r1, #0x10\n"
        "    mov     r2, r9\n"
        "    bl      sub_0802E5D8\n"
        "_0802F52C:\n"
        "    adds    r4, #0x24\n"
        "    movs    r0, #1\n"
        "    add     r9, r0\n"
        "    mov     r1, r9\n"
        "    cmp     r1, #2\n"
        "    ble     _0802F4E2\n"
        "    movs    r2, #0\n"
        "    mov     r9, r2\n"
        "    movs    r5, #0\n"
        "_0802F53E:\n"
        "    ldr     r0, _0802F58C            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r4, [r0, #0]\n"
        "    adds    r0, r4, #0\n"
        "    adds    r0, #0x10\n"
        "    adds    r2, r0, r5\n"
        "    ldr     r1, [r2, #0]\n"
        "    movs    r0, #0x80\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F5A4\n"
        "    movs    r3, #0x81\n"
        "    negs    r3, r3\n"
        "    ands    r3, r1\n"
        "    str     r3, [r2, #0]\n"
        "    mov     r1, r9\n"
        "    lsls    r0, r1, #3\n"
        "    adds    r2, r4, r0\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0x90\n"
        "    ldrh    r0, [r0, #0]\n"
        "    lsrs    r1, r0, #8\n"
        "    cmp     r1, #0\n"
        "    beq     _0802F56E\n"
        "    adds    r1, #1\n"
        "_0802F56E:\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0x93\n"
        "    ldrb    r0, [r0, #0]\n"
        "    muls    r0, r1\n"
        "    lsls    r0, r0, #8\n"
        "    lsrs    r1, r0, #0x10\n"
        "    movs    r0, #0x80\n"
        "    lsls    r0, r0, #9\n"
        "    ands    r3, r0\n"
        "    cmp     r3, #0\n"
        "    beq     _0802F590\n"
        "    adds    r0, r4, #0\n"
        "    adds    r0, #0xbe\n"
        "    b       _0802F594\n"
        "    .hword  0x0000\n"
        "_0802F58C: .4byte 0x030065e0\n"
        "_0802F590:\n"
        "    adds    r0, r4, #0\n"
        "    adds    r0, #0xbc\n"
        "_0802F594:\n"
        "    ldrh    r0, [r0, #0]\n"
        "    muls    r0, r1\n"
        "    lsls    r0, r0, #8\n"
        "    lsrs    r1, r0, #0x10\n"
        "    adds    r0, r1, #0\n"
        "    mov     r1, r9\n"
        "    bl      sub_0802E684\n"
        "_0802F5A4:\n"
        "    ldr     r2, _0802F5DC            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r3, [r2, #0]\n"
        "    adds    r0, r3, #0\n"
        "    adds    r0, #0x10\n"
        "    adds    r0, r0, r5\n"
        "    ldr     r1, [r0, #0]\n"
        "    movs    r0, #0x80\n"
        "    lsls    r0, r0, #2\n"
        "    ands    r1, r0\n"
        "    adds    r6, r2, #0\n"
        "    cmp     r1, #0\n"
        "    beq     _0802F602\n"
        "    mov     r2, r9\n"
        "    cmp     r2, #3\n"
        "    beq     _0802F5E4\n"
        "    ldr     r0, _0802F5E0            @ =0x083dda1c\n"
        "    adds    r0, r5, r0\n"
        "    ldr     r2, [r0, #0]\n"
        "    mov     r1, r9\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r1, r3, #0\n"
        "    adds    r1, #0xb4\n"
        "    adds    r1, r1, r0\n"
        "    movs    r3, #0x80\n"
        "    lsls    r3, r3, #8\n"
        "    adds    r0, r3, #0\n"
        "    ldrh    r1, [r1, #0]\n"
        "    b       _0802F5F0\n"
        "    .align  2, 0\n"
        "_0802F5DC: .4byte 0x030065e0\n"
        "_0802F5E0: .4byte 0x083dda1c\n"
        "_0802F5E4:\n"
        "    ldr     r0, _0802F6BC            @ =0x083dda1c (ROM sound-channel reg table)\n"
        "    ldr     r2, [r0, #0xc]\n"
        "    ldrh    r0, [r2, #0]\n"
        "    movs    r3, #0x80\n"
        "    lsls    r3, r3, #8\n"
        "    adds    r1, r3, #0\n"
        "_0802F5F0:\n"
        "    orrs    r0, r1\n"
        "    strh    r0, [r2, #0]\n"
        "    ldr     r0, [r6, #0]\n"
        "    adds    r0, #0x10\n"
        "    adds    r0, r0, r5\n"
        "    ldr     r1, [r0, #0]\n"
        "    ldr     r2, _0802F6C0            @ =0xfffffdff\n"
        "    ands    r1, r2\n"
        "    str     r1, [r0, #0]\n"
        "_0802F602:\n"
        "    adds    r5, #4\n"
        "    movs    r0, #1\n"
        "    add     r9, r0\n"
        "    mov     r1, r9\n"
        "    cmp     r1, #3\n"
        "    ble     _0802F53E\n"
        "    movs    r2, #0\n"
        "    mov     r9, r2\n"
        "    adds    r1, r6, #0\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r9, r0\n"
        "    blt     _0802F61E\n"
        "    b       _0802F7E8\n"
        "_0802F61E:\n"
        "    movs    r3, #0\n"
        "    str     r3, [sp, #0]\n"
        "    movs    r0, #0\n"
        "    str     r0, [sp, #4]\n"
        "    mov     sl, r1\n"
        "_0802F628:\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0xcc\n"
        "    ldr     r0, [r0, #0]\n"
        "    ldr     r1, [sp, #4]\n"
        "    adds    r0, r1, r0\n"
        "    ldr     r5, [r0, #0]\n"
        "    cmp     r5, #0\n"
        "    bne     _0802F63A\n"
        "    b       _0802F7CC\n"
        "_0802F63A:\n"
        "    ldrh    r0, [r5, #0x36]\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F652\n"
        "    adds    r0, r5, #0\n"
        "    adds    r0, #0x3f\n"
        "    ldrh    r2, [r5, #0x36]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    subs    r0, r2, r0\n"
        "    cmp     r0, #0\n"
        "    bge     _0802F650\n"
        "    movs    r0, #0\n"
        "_0802F650:\n"
        "    strh    r0, [r5, #0x36]\n"
        "_0802F652:\n"
        "    ldr     r1, [r5, #0x38]\n"
        "    movs    r0, #0x80\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _0802F65E\n"
        "    b       _0802F75E\n"
        "_0802F65E:\n"
        "    movs    r0, #0x81\n"
        "    negs    r0, r0\n"
        "    ands    r1, r0\n"
        "    str     r1, [r5, #0x38]\n"
        "    ldrh    r3, [r5, #0x28]\n"
        "    lsrs    r4, r3, #8\n"
        "    cmp     r4, #0\n"
        "    beq     _0802F670\n"
        "    adds    r4, #1\n"
        "_0802F670:\n"
        "    adds    r0, r5, #0\n"
        "    adds    r0, #0x2b\n"
        "    ldrb    r0, [r0, #0]\n"
        "    muls    r0, r4\n"
        "    lsls    r0, r0, #8\n"
        "    lsrs    r3, r0, #0x10\n"
        "    adds    r0, r5, #0\n"
        "    adds    r0, #0x2a\n"
        "    strb    r3, [r0, #0]\n"
        "    ldr     r0, [r6, #0]\n"
        "    adds    r0, #0xc0\n"
        "    ldr     r0, [r0, #0]\n"
        "    ldr     r1, [sp, #0]\n"
        "    adds    r0, r0, r1\n"
        "    mov     r8, r0\n"
        "    adds    r2, r5, #0\n"
        "    adds    r2, #0x3c\n"
        "    ldrb    r0, [r2, #0]\n"
        "    lsls    r1, r0, #0x18\n"
        "    lsrs    r0, r1, #0x18\n"
        "    cmp     r0, #0x3f\n"
        "    bhi     _0802F6D0\n"
        "    ldrb    r2, [r2, #0]\n"
        "    movs    r0, #0x40\n"
        "    subs    r0, r0, r2\n"
        "    ldr     r1, _0802F6C4            @ =0x00004ac8\n"
        "    muls    r0, r1\n"
        "    asrs    r0, r0, #6\n"
        "    ldr     r1, _0802F6C8            @ =0x0000b538\n"
        "    adds    r0, r0, r1\n"
        "    muls    r0, r3\n"
        "    asrs    r0, r0, #0x10\n"
        "    lsls    r0, r0, #0x18\n"
        "    lsrs    r7, r0, #0x18\n"
        "    ldr     r0, _0802F6CC            @ =0x0000b818\n"
        "    muls    r0, r2\n"
        "    asrs    r0, r0, #6\n"
        "    b       _0802F6F4\n"
        "    .align  2, 0\n"
        "_0802F6BC: .4byte 0x083dda1c\n"
        "_0802F6C0: .4byte 0xfffffdff\n"
        "_0802F6C4: .4byte 0x00004ac8\n"
        "_0802F6C8: .4byte 0x0000b538\n"
        "_0802F6CC: .4byte 0x0000b818\n"
        "_0802F6D0:\n"
        "    cmp     r1, #0\n"
        "    blt     _0802F70C\n"
        "    ldrb    r2, [r2, #0]\n"
        "    movs    r0, #0x7f\n"
        "    subs    r0, r0, r2\n"
        "    ldr     r1, _0802F700            @ =0x0000b818\n"
        "    muls    r0, r1\n"
        "    asrs    r0, r0, #6\n"
        "    muls    r0, r3\n"
        "    asrs    r0, r0, #0x10\n"
        "    lsls    r0, r0, #0x18\n"
        "    lsrs    r7, r0, #0x18\n"
        "    subs    r2, #0x3f\n"
        "    ldr     r0, _0802F704            @ =0x00004ac8\n"
        "    muls    r0, r2\n"
        "    asrs    r0, r0, #6\n"
        "    ldr     r2, _0802F708            @ =0x0000b538\n"
        "    adds    r0, r0, r2\n"
        "_0802F6F4:\n"
        "    muls    r0, r3\n"
        "    asrs    r0, r0, #0x10\n"
        "    lsls    r0, r0, #0x18\n"
        "    lsrs    r6, r0, #0x18\n"
        "    movs    r2, #0\n"
        "    b       _0802F71A\n"
        "    .align  2, 0\n"
        "_0802F700: .4byte 0x0000b818\n"
        "_0802F704: .4byte 0x00004ac8\n"
        "_0802F708: .4byte 0x0000b538\n"
        "_0802F70C:\n"
        "    ldr     r0, _0802F730            @ =0x0000b538\n"
        "    muls    r0, r3\n"
        "    asrs    r0, r0, #0x10\n"
        "    lsls    r0, r0, #0x18\n"
        "    lsrs    r6, r0, #0x18\n"
        "    adds    r7, r6, #0\n"
        "    movs    r2, #1\n"
        "_0802F71A:\n"
        "    ldr     r0, [r5, #0x38]\n"
        "    movs    r1, #0x80\n"
        "    lsls    r1, r1, #9\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F734\n"
        "    mov     r3, sl\n"
        "    ldr     r0, [r3, #0]\n"
        "    adds    r0, #0xbe\n"
        "    b       _0802F73A\n"
        "    .hword  0x0000\n"
        "_0802F730: .4byte 0x0000b538\n"
        "_0802F734:\n"
        "    mov     r1, sl\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0xbc\n"
        "_0802F73A:\n"
        "    ldrh    r0, [r0, #0]\n"
        "    adds    r4, r0, #0\n"
        "    str     r2, [sp, #8]\n"
        "    bl      sub_0802E418\n"
        "    adds    r0, r7, #0\n"
        "    muls    r0, r4\n"
        "    asrs    r0, r0, #8\n"
        "    mov     r3, r8\n"
        "    strb    r0, [r3, #0x18]\n"
        "    adds    r0, r6, #0\n"
        "    muls    r0, r4\n"
        "    asrs    r0, r0, #8\n"
        "    strb    r0, [r3, #0x19]\n"
        "    ldr     r2, [sp, #8]\n"
        "    strb    r2, [r3, #0x1a]\n"
        "    bl      sub_0802E3F8\n"
        "_0802F75E:\n"
        "    ldr     r1, [r5, #0x38]\n"
        "    movs    r0, #0x40\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F7AE\n"
        "    movs    r0, #0x41\n"
        "    negs    r0, r0\n"
        "    ands    r0, r1\n"
        "    str     r0, [r5, #0x38]\n"
        "    movs    r1, #0xa0\n"
        "    lsls    r1, r1, #5\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F7AE\n"
        "    mov     r1, sl\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0xc0\n"
        "    ldr     r4, [r0, #0]\n"
        "    ldr     r2, [sp, #0]\n"
        "    adds    r4, r4, r2\n"
        "    ldrh    r3, [r5, #0]\n"
        "    ldrh    r1, [r5, #2]\n"
        "    adds    r0, r3, r1\n"
        "    ldrh    r2, [r5, #4]\n"
        "    adds    r0, r2, r0\n"
        "    ldrh    r3, [r5, #0xc]\n"
        "    adds    r0, r3, r0\n"
        "    ldrh    r1, [r5, #0x14]\n"
        "    adds    r0, r1, r0\n"
        "    ldrh    r2, [r5, #0x1c]\n"
        "    adds    r0, r2, r0\n"
        "    lsls    r0, r0, #0x10\n"
        "    lsrs    r2, r0, #0x10\n"
        "    ldr     r0, [r4, #0]\n"
        "    lsrs    r1, r2, #8\n"
        "    lsls    r2, r2, #0x18\n"
        "    lsrs    r2, r2, #0x18\n"
        "    bl      sub_080301C4\n"
        "    strh    r0, [r4, #0x14]\n"
        "_0802F7AE:\n"
        "    ldr     r1, [r5, #0x38]\n"
        "    movs    r0, #0x80\n"
        "    lsls    r0, r0, #8\n"
        "    ands    r1, r0\n"
        "    ldr     r6, _0802F868            @ =gpSoundSystem (0x030065e0)\n"
        "    cmp     r1, #0\n"
        "    beq     _0802F7CC\n"
        "    mov     r3, sl\n"
        "    ldr     r0, [r3, #0]\n"
        "    adds    r0, #0xcc\n"
        "    ldr     r0, [r0, #0]\n"
        "    ldr     r1, [sp, #4]\n"
        "    adds    r0, r1, r0\n"
        "    movs    r1, #0\n"
        "    str     r1, [r0, #0]\n"
        "_0802F7CC:\n"
        "    ldr     r2, [sp, #0]\n"
        "    adds    r2, #0x1c\n"
        "    str     r2, [sp, #0]\n"
        "    ldr     r3, [sp, #4]\n"
        "    adds    r3, #4\n"
        "    str     r3, [sp, #4]\n"
        "    movs    r0, #1\n"
        "    add     r9, r0\n"
        "    adds    r1, r6, #0\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r9, r0\n"
        "    bge     _0802F7E8\n"
        "    b       _0802F628\n"
        "_0802F7E8:\n"
        "    bl      sub_0802E418\n"
        "    movs    r1, #0\n"
        "    mov     r9, r1\n"
        "    ldr     r1, _0802F868            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r9, r0\n"
        "    bge     _0802F84E\n"
        "    adds    r6, r1, #0\n"
        "    movs    r4, #0\n"
        "_0802F7FE:\n"
        "    ldr     r2, [r1, #0]\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0xcc\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     r1, r9\n"
        "    lsls    r3, r1, #2\n"
        "    adds    r0, r3, r0\n"
        "    ldr     r5, [r0, #0]\n"
        "    cmp     r5, #0\n"
        "    beq     _0802F83E\n"
        "    ldr     r1, [r5, #0x38]\n"
        "    movs    r0, #0x80\n"
        "    lsls    r0, r0, #2\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F83E\n"
        "    movs    r0, #0xa0\n"
        "    lsls    r0, r0, #5\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F83E\n"
        "    ldr     r0, _0802F86C            @ =0xfffffdff\n"
        "    ands    r1, r0\n"
        "    str     r1, [r5, #0x38]\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0xc4\n"
        "    ldr     r1, [r0, #0]\n"
        "    adds    r1, r3, r1\n"
        "    subs    r0, #4\n"
        "    ldr     r0, [r0, #0]\n"
        "    adds    r0, r0, r4\n"
        "    str     r0, [r1, #0]\n"
        "_0802F83E:\n"
        "    adds    r4, #0x1c\n"
        "    movs    r2, #1\n"
        "    add     r9, r2\n"
        "    adds    r1, r6, #0\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r9, r0\n"
        "    blt     _0802F7FE\n"
        "_0802F84E:\n"
        "    bl      sub_0802E3F8\n"
        "    bl      sub_080325B0\n"
        "    add     sp, #0xc\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .hword  0x0000\n"
        "_0802F868: .4byte 0x030065e0\n"
        "_0802F86C: .4byte 0xfffffdff\n"
        "    .syntax divided\n");
}
#endif

extern vu16 *const sChannelRegTable[4];
extern vu16 *const sChannelFreqRegTable[4];

/* sub_0802F870 — write to a PSG channel's duty/envelope byte register.
 * Sets the byte at sChannelRegTable[channelIdx] to (value << 6). */
void sub_0802F870(u32 value, u32 channelIdx)
{
    *((u8 *)sChannelRegTable[channelIdx]) = value << 6;
}

/* sub_0802F884 — write to channel 3 (noise) frequency register byte. */
void sub_0802F884(u8 value)
{
    *((u8 *)sChannelFreqRegTable[3]) = value;
}

/* sub_0802F890 — update a PSG channel's duty/envelope register and mark dirty.
 *
 * If bit 3 of value is clear: reads the current halfword, masks with
 * 0xf0c0, OR-s in (value << 8), and writes back.
 * If bit 3 of value is set: writes (value << 8) directly without masking.
 * Either way, updates chFlags[channelIdx]: clears bits 0, 5, 7 and sets bit 9.
 *
 * Matching notes:
 *   - val pinned to r4 (push {r4, lr}) via a fixed-register local.
 *   - The local index shape keeps byteOff/off2 in r3/r2 for the table
 *     lookup and common-tail add without explicit register pins.
 *   - Commuted add form (off + tbl) forces "adds r0, r3/r2, r0" encoding.
 *   - The empty asm after each store keeps val (r4) live so the
 *     compiler uses r1 for the shifted intermediate instead of r4.
 *   - Common tail: ss+0x10 is computed in r2 via "ss = (u8*)ss + 0x10",
 *     giving adds r2, #16 then adds r2, r2, r3.
 */
void sub_0802F890(u8 value, u32 channelIdx)
{
    register u8 val asm("r4");
    u32 byteOff;
    SoundSystem *ss;
    u32 flags;
    u32 *pF;
    vu16 *reg;

    val = value;
    if (val & 8)
        goto set_path;

    {
        vu16 *const *tbl = sChannelRegTable;
        vu16 *rg;

        byteOff = channelIdx << 2;
        rg = *(vu16 **)(byteOff + (u32)tbl);
        *rg = (*rg & 0xf0c0) | (val << 8);
        asm("" : : "r"(val));
    }
    goto common_tail;

set_path: {
    vu16 *const *tbl = sChannelRegTable;
    u32 off2 = channelIdx << 2;

    reg = *(vu16 **)(off2 + (u32)tbl);
    *reg = val << 8;
    asm("" : : "r"(val));
    byteOff = off2;
}

common_tail:
    ss = gpSoundSystem;
    ss = (SoundSystem *)((u8 *)ss + 0x10);
    pF = (u32 *)((u8 *)ss + byteOff);
    flags = *pF;
    flags &= (u32)-0xa2;
    flags |= 0x200;
    *pF = flags;
}
