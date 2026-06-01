#include "sound.h"

/* Sound-system mutation lock — acquire (sub_0802E418) and release
 * (sub_0802E3F8).
 *
 * The sound subsystem keeps a refcount byte at SoundSystem+0xbb that
 * brackets every mutator of the SoundState block (per-channel envelope
 * ticks, the mixer tick, the per-slot pan/fade emitters). On the 0->1
 * acquire transition the underlying ARM trampoline at 0x08035d8c
 * disables the sound IRQ; on the 1->0 release transition the trampoline
 * at 0x08035d94 re-enables it.
 *
 * Together these form the critical-section primitive used throughout
 * the sound engine to keep the per-VBlank tick from racing the audio
 * DMA. See docs/subsystems.md "Audio / sound" for the broader cluster
 * picture.
 */

/* Thumb-callable interwork veneers that branch to the ARM-mode
 * sound-IRQ toggle routines. Both are 8-byte `bx pc; nop; b TARGET`
 * thunks living at the named addresses. */
extern void sub_08035D8C(void); /* sound-IRQ disable; b 0x08032e38 */
extern void sub_08035D94(void); /* sound-IRQ enable;  b 0x08032e1c */

void sub_0802E3F8(void)
{
    u8 *p = &gpSoundSystem->lockRefCount;
    s32 v = *p - 1;
    *p = v;
    if ((u8)v == 0)
        sub_08035D94();
}

void sub_0802E418(void)
{
    u8 *p = &gpSoundSystem->lockRefCount;
    s32 v = *p + 1;
    *p = v;
    if ((u8)v == 1)
        sub_08035D8C();
}
