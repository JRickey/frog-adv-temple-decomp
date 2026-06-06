#include "sound.h"
#include "macros.h"

extern void SoundChannel_Reset(s32 ch);
extern void sub_0802E7C4(u8 pan, s32 ch);

/* SoundChannel_SetState — sound channel state primer (high-register variant of SoundChannel_Init).
 *
 * Clears the channel dirty flag, stores the hw-control halfword (5th stack
 * arg) and the chMode bytes, then for channels 0-2 primes the SoundSlotInit
 * state block at ss + ch*36 + 0x20.
 *
 * Matching notes:
 *   The 5th stack argument hwCtrl is passed on the caller's stack, but the
 *   original GCC 2.9 compiler (not our old_agbcc) kept it there rather than
 *   preloading it into a callee-saved register. This function now has its
 *   own translation unit, so linked experiments no longer perturb the
 *   preceding SoundSlot_InitParams initializer. Pinning &gpSoundSystem in r5
 *   and ctrl in r9, then copying the control-byte store through r6, naming
 *   the direct-channel pan-reset halfword, and writing the dirty-flag clear as
 *   a literal zero improves the current best pure-C candidate to byte_diff 62 /
 *   diff_count 20 with old_agbcc -O2 or -fforce-addr.
 *
 *   class: stack-arg lazy-load (compiler version behavioral difference).
 *   Negative experiments: C varargs made the stack argument lazy but
 *   worsened the prologue; taking &hwCtrl copied it to a new local stack slot;
 *   pinning step to r8 or ch8 to r4 regressed; forcing the pan-reset store
 *   through r0 or pinning the channel byte-zero to r2 moved other target registers away.
 *   A scoped r6 temp for the final step<<8 store was codegen-neutral; agbcc
 *   still emits `mov r2, r8`. Marking hwCtrl volatile delayed the final load
 *   only by copying it into a new local stack slot, adding a frame, and
 *   regressing to byte_diff 134. K&R-style parameter spelling and widening the
 *   stack argument to u32 were codegen-neutral; pinning the target's later
 *   channel-zero byte to r2 regressed to byte_diff 115, and pinning the ch*8
 *   offset to r4 regressed to byte_diff 76. Removing the ctrl-byte r6 pin
 *   regressed to byte_diff 70, while scoped r4/r2 locals for hwCtrl, a scoped
 *   r3 ctrl initializer, grouped channel-offset arithmetic, raw acc-pointer
 *   spelling, and literal first slot-zero spelling were all neutral and still
 *   kept the early `ldr r6, [sp, #28]` preload. Focused flag probes for
 *   -fno-caller-saves, -fno-defer-pop, and -fno-inline were neutral;
 *   -fno-omit-frame-pointer changed the saved high-register shape and
 *   regressed to byte_diff 144; -fvolatile regressed to byte_diff 132.
 *   Retesting after the current header/split work: literal-zero stores
 *   regress to byte_diff 80, ch8 pinned to r4 still regresses to byte_diff 76,
 *   and staging the accumulator write through a separate ss+0xac base pointer
 *   regresses to byte_diff 116. Current fifth-argument probes: s32/u32
 *   parameter spelling, explicit cast stores, a plain scoped temp, raw
 *   chanAcc address spelling, K&R-style spelling, and argument-alias flags are
 *   neutral; pinning a scoped hwCtrl temp to r4 worsens instruction diff, r2
 *   regresses to byte_diff 116, and moving the zero local after the chanAcc
 *   store regresses to byte_diff 80. A separate r2 zero local for the direct
 *   channel gate store regresses to byte_diff 72. Routing the channel byte
 *   stores through SOUND_SYSTEM_DIRECT_CHANNEL and the inline state block through
 *   SOUND_SYSTEM_INLINE_CHANNEL is codegen-neutral and keeps the offsets named.
 *   Routing the hwCtrl store through the typed chanAcc field regresses to
 *   byte_diff 124, so the raw +0xac helper remains for now. A wider diagnostic
 *   flag pass found no lane below byte_diff 62; every neutral lane keeps the
 *   same eager fifth-argument preload first mismatch.
 *
 *   Corpus evidence: all `mov rN, sp; ldrh rN, [rN, #imm]` lazy-stack-arg
 *   patterns in the agbcc corpus appear exclusively inside NAKED/INCLUDE_ASM
 *   blocks, never in pure-C matched decomps. Tiny harnesses also show both
 *   shipped compiler fronts eagerly preload a fifth fixed argument before the
 *   first BL across pointer, cast-store, extra-pressure, and empty-barrier
 *   spellings; delaying the read requires varargs or an address-taken local
 *   copy, both of which add a non-target frame.
 */
#if !defined(NON_MATCHING) && !defined(NON_MATCHING_sub_08032904)
NAKED void SoundChannel_SetState(s32 ch, u32 step, u32 pan, u32 ctrl, u16 hwCtrl)
{
    asm("    .syntax unified\n"
        "    push {r4, r5, r6, r7, lr}\n"
        "    mov r7, r9\n"
        "    mov r6, r8\n"
        "    push {r6, r7}\n"
        "    adds r7, r0, #0\n"
        "    mov r8, r1\n"
        "    adds r4, r2, #0\n"
        "    mov r9, r3\n"
        "    bl SoundChannel_Reset\n"
        "    lsls r4, r4, #24\n"
        "    lsrs r4, r4, #24\n"
        "    adds r0, r4, #0\n"
        "    adds r1, r7, #0\n"
        "    bl sub_0802E7C4\n"
        "    ldr r5, .Lgps2\n"
        "    ldr r1, [r5, #0]\n"
        "    lsls r2, r7, #2\n"
        "    adds r0, r1, #0\n"
        "    adds r0, #16\n"
        "    adds r0, r0, r2\n"
        "    movs r3, #0\n"
        "    str r3, [r0, #0]\n"
        "    lsls r2, r7, #1\n"
        "    adds r0, r1, #0\n"
        "    adds r0, #0xac\n"
        "    adds r0, r0, r2\n"
        "    movs r2, #0\n"
        "    mov r4, sp\n"
        "    ldrh r4, [r4, #28]\n"
        "    strh r4, [r0, #0]\n"
        "    lsls r4, r7, #3\n"
        "    adds r0, r4, #0\n"
        "    adds r0, #0x8c\n"
        "    adds r1, r1, r0\n"
        "    movs r0, #0xff\n"
        "    lsls r0, r0, #8\n"
        "    strh r0, [r1, #4]\n"
        "    mov r6, r9\n"
        "    strb r6, [r1, #7]\n"
        "    strb r2, [r1, #6]\n"
        "    cmp r7, #2\n"
        "    bgt .Lexit2\n"
        "    adds r1, r4, r7\n"
        "    lsls r1, r1, #2\n"
        "    adds r1, #32\n"
        "    ldr r0, [r5, #0]\n"
        "    adds r0, r0, r1\n"
        "    ldrh r2, [r0, #0]\n"
        "    ldrh r4, [r0, #28]\n"
        "    adds r1, r2, r4\n"
        "    strh r1, [r0, #34]\n"
        "    mov r6, r8\n"
        "    lsls r1, r6, #8\n"
        "    strh r1, [r0, #0]\n"
        "    strh r3, [r0, #2]\n"
        "    strh r3, [r0, #28]\n"
        "    strh r3, [r0, #30]\n"
        "    strh r3, [r0, #32]\n"
        "    strh r3, [r0, #20]\n"
        "    strh r3, [r0, #22]\n"
        "    strh r3, [r0, #4]\n"
        "    strh r3, [r0, #6]\n"
        "    strh r3, [r0, #12]\n"
        "    strh r3, [r0, #14]\n"
        "    strh r3, [r0, #18]\n"
        ".Lexit2:\n"
        "    pop {r3, r4}\n"
        "    mov r8, r3\n"
        "    mov r9, r4\n"
        "    pop {r4, r5, r6, r7}\n"
        "    pop {r0}\n"
        "    bx r0\n"
        "    .align 2, 0\n"
        ".Lgps2:\n"
        "    .word 0x030065e0\n"
        "    .syntax divided\n");
}
#else
void SoundChannel_SetState(s32 ch, u32 step, u32 pan, u32 ctrl, u16 hwCtrl)
{
    SoundSystem *ss;
    register SoundSystem **gpsp asm("r5");
    SoundSlotInit *slot;
    DirectSoundChannel *channel;
    register u32 ctrlLocal asm("r9");
    register u32 ctrlByte asm("r6");
    u32 zero;

    ctrlLocal = ctrl;

    SoundChannel_Reset(ch);
    sub_0802E7C4((u8)pan, ch);

    gpsp = &gpSoundSystem;
    ss = *gpsp;
    ss->chFlags[ch] = 0;
    zero = 0;
    SOUND_SYSTEM_CH_ACC(ss)[ch] = hwCtrl;

    channel = SOUND_SYSTEM_DIRECT_CHANNEL(ss, ch);
    channel->panReset = SOUND_CHANNEL_PAN_RESET;
    ctrlByte = ctrlLocal;
    channel->period = ctrlByte;
    channel->gate = zero;

    if (ch <= SOUND_INLINE_CHANNEL_COUNT - 1) {
        slot = SOUND_SYSTEM_INLINE_SLOT_INIT(*gpsp, ch);
        slot->accSumTarget = slot->acc0 + slot->acc5;
        slot->acc0 = step << 8;
        slot->acc1 = zero;
        slot->acc5 = zero;
        slot->acc5Step = zero;
        slot->acc5Limit = zero;
        slot->acc4 = zero;
        slot->acc4Step = zero;
        slot->acc2 = zero;
        slot->acc2Step = zero;
        slot->acc3 = zero;
        slot->acc3Step = zero;
        slot->acc3Limit = zero;
    }
}
#endif
