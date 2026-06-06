#include "game.h"
#include "types.h"

/* VBlank semaphore wait. Spins until the VBlank IRQ handler (VBlankIntr)
 * sets bit 0 of *(u16*)0x03006148. Used as the shared per-frame finalize
 * (tail) by every mode-dispatch case in AgbMain. */
void WaitVblank(void)
{
    register volatile u16 *p asm("r0") = (volatile u16 *)0x03006148;
    volatile u16 *q;
    u32 mask;

    /* `q = p; mask = 1;` materialize the loop pointer and bit-mask in
     * separate registers so the inner loop matches: ldrh into r1, mov-via-
     * add to r0, ands. Inlining either as a literal collapses two
     * registers into one and shrinks the loop below baserom. */
    *p &= 0xfffe;
    q = p;
    mask = 1;
    while ((mask & *q) == 0) {
    }
}

/* Returns the global frame counter (gGameStuff._unk00). Used by Init1 to
 * read `now` for fade/timeout bookkeeping. */
u32 GetFrameTick(void)
{
    return gGameStuff._unk00;
}
