#include "types.h"

/* sub_0802E3F8 — sound-system mutation lock release.
 *
 * The sound subsystem keeps a refcount byte at SoundSystem+0xbb that
 * brackets every mutator of the SoundState block (per-channel envelope
 * ticks, the mixer tick, the per-slot pan/fade emitters). Acquire is
 * sub_0802E418 (still asm); release is this function. On the 1->0
 * transition the refcount drops back to zero and the underlying ARM
 * trampoline at 0x08035d94 re-enables the sound IRQ.
 *
 * Together with sub_0802E418 (refcount increment + sound-IRQ disable
 * on 0->1) this is the critical-section primitive used throughout the
 * sound engine to keep the per-VBlank tick from racing the audio DMA.
 * See docs/subsystems.md "Audio / sound" for the broader cluster
 * picture.
 *
 * The peer sub_0802E418 lands here too once it gets decompiled —
 * keep co-located.
 */

typedef struct SoundSystem {
    u8 _pad00[0xbb];
    u8 lockRefCount; /* +0xbb */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

/* Thumb-callable interwork veneer that branches to the ARM-mode
 * sound-IRQ-enable routine at 0x08032e1c. Lives at 0x08035d94 as an
 * 8-byte `bx pc; nop; b 0x08032e1c` thunk. */
extern void sub_08035D94(void);

void sub_0802E3F8(void)
{
    register u8 *p asm("r0") = &gpSoundSystem->lockRefCount;
    register s32 v asm("r1") = *p - 1;
    *p = v;
    if ((u8)v == 0)
        sub_08035D94();
}
