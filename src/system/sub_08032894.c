#include "sound.h"
#include "macros.h"

/* sub_08032894 — sound slot initializer.
 *
 * Pure leaf (no callees, no globals). Clears the streaming/envelope state
 * of a SoundSlot-shaped object and primes the per-slot mixer constants:
 * pan = 0xff00 at +0x28, base step = 0xc000 at +0x36, "active" byte = 1
 * at +0x3f, plus the +0x22 mixer accumulator preset to (slot[0] + slot[0x1c]).
 *
 * Struct shapes are scaffold-grade — fields named by byte offset so the
 * literal offsets in the asm have an obvious source mapping. Promote to
 * include/sound.h once the surrounding 0x08032xxx slot-management cluster
 * lands.
 *
 * Matching notes:
 *   - Built with OLD_AGBCC_BIN (Makefile override). Under the newer agbcc
 *     the +0x22 sum statement allocates r0 (not r4) for the first ldrh
 *     and gets stuck at byte_diff 2; old_agbcc picks r4 naturally.
 *   - Args are u32 (not u8/u16). agbcc's narrowing for sub-word args
 *     (lsls/lsrs pair) is not in the baserom — only the `adds rD, rS, #0`
 *     register-copy prologue, which is what u32-wide args generate. The
 *     `byte_2b` write nonetheless tests the LOW BYTE explicitly because
 *     the asm `lsls #24; cmp #0` is a u8 truncation, not a full-word zero
 *     check; that's preserved here with an explicit `(u8)` cast.
 */

void sub_08032894(SoundSlotInit *slot, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
{
    slot->byte_3d = 0;
    slot->word_28 = 0xff00;
    slot->word_36 = 0xc000;
    slot->byte_3f = 1;

    arg3 <<= 1;
    slot->byte_2b = arg3;
    if ((u8)arg3 != 0)
        slot->byte_2b = arg3 + 1;

    slot->byte_2a = 0;
    slot->dword_38 = 0;
    slot->byte_3c = arg2;
    slot->word_34 = arg4;
    slot->word_22 = slot->word_00 + slot->word_1c;

    slot->word_00 = arg1 << 8;
    slot->word_02 = 0;
    slot->word_1c = 0;
    slot->word_1e = 0;
    slot->word_20 = 0;
    slot->word_14 = 0;
    slot->word_16 = 0;
    slot->word_04 = 0;
    slot->word_06 = 0;
    slot->word_0c = 0;
    slot->word_0e = 0;
    slot->word_12 = 0;
}

extern void sub_0802E724(s32 ch);
extern void sub_0802E7C4(u8 pan, s32 ch);

/* sub_08032904 — sound channel state primer (high-register variant of SoundChannel_Init).
 *
 * Clears the channel dirty flag, stores the hw-control halfword (5th stack
 * arg) and the chMode bytes, then for channels 0–2 primes the SoundSlotInit
 * state block at ss + ch*36 + 0x20.
 *
 * Matching notes:
 *   The 5th stack argument hwCtrl is passed on the caller's stack, but the
 *   original GCC 2.9 compiler (not our old_agbcc) kept it there rather than
 *   preloading it into a callee-saved register. old_agbcc eagerly loads it
 *   into r6, causing 67 bytes of drift. No pure-C lever (register pins,
 *   type variants, volatile, dummy variables) has been found to prevent this.
 *   The NAKED asm path reproduces the baserom byte-exactly; the NON_MATCHING
 *   block is the readable C equivalent.
 *
 *   class: stack-arg lazy-load (compiler version behavioral difference).
 *   Corpus evidence: all `mov rN, sp; ldrh rN, [rN, #imm]` lazy-stack-arg
 *   patterns in the agbcc corpus appear exclusively inside NAKED/INCLUDE_ASM
 *   blocks, never in pure-C matched decomps.
 */
#ifndef NON_MATCHING
NAKED void sub_08032904(s32 ch, u32 step, u32 pan, u32 ctrl, u16 hwCtrl)
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
        "    bl sub_0802E724\n"
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
void sub_08032904(s32 ch, u32 step, u32 pan, u32 ctrl, u16 hwCtrl)
{
    u32 savedStep = step;
    u32 savedCtrl = ctrl;
    SoundSystem **pPool;
    SoundSystem *ss;
    SoundSlotInit *chState;
    u8 *chMode;
    u32 ch8;
    u16 hwOff;
    u16 acc;
    s32 savedCh;

    savedCh = ch;
    sub_0802E724(savedCh);
    pan = (u8)pan;
    sub_0802E7C4(pan, savedCh);

    pPool = &gpSoundSystem;
    ss = *pPool;
    ss->chFlags[savedCh] = 0;
    hwOff = 0xac;
    {
        u32 idx2 = (u32)savedCh * 2;
        *(u16 *)((u8 *)ss + hwOff + idx2) = hwCtrl;
    }

    ch8 = (u32)savedCh * 8;
    chMode = (u8 *)ss + ch8 + 0x8c;
    *(u16 *)(chMode + 4) = 0xff00;
    *(u8 *)(chMode + 7) = savedCtrl;
    *(u8 *)(chMode + 6) = 0;

    if (savedCh > 2)
        return;

    {
        u32 chOff = (ch8 + (u32)savedCh) * 4 + 0x20;
        chState = (SoundSlotInit *)((u8 *)*pPool + chOff);
    }

    acc = chState->word_00 + chState->word_1c;
    chState->word_22 = acc;

    chState->word_00 = savedStep << 8;
    chState->word_02 = 0;
    chState->word_1c = 0;
    chState->word_1e = 0;
    chState->word_20 = 0;
    chState->word_14 = 0;
    chState->word_16 = 0;
    chState->word_04 = 0;
    chState->word_06 = 0;
    chState->word_0c = 0;
    chState->word_0e = 0;
    chState->word_12 = 0;
}
#endif
