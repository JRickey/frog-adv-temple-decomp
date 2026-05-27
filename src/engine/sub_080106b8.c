#include "macros.h"
#include "types.h"

/* Fade-in ticker. Decrements the fade countdown at 0x03006538; when
 * it reaches zero this frame, also clears the tick-RNG word at
 * 0x03005398 and the byte at 0x03003480+5. Then writes (16 -
 * countdown) to REG_BLDCNT so the blend fades up as the countdown
 * runs out. Returns the post-decrement countdown.
 *
 * Companion to sub_08010694 (the fade-in init helper). 30 BL callers
 * across the ROM.
 *
 * Matching notes (old_agbcc, control-flow join would otherwise emit
 * push {lr}; pop {r1}; bx r1):
 *   - countdown pinned to r2 (otherwise allocated to r3).
 *   - p3480 anchors the 0x03003480 base before the [5] index so the
 *     constant fold doesn't collapse it to 0x03003485.
 *   - bldcnt pinned to r0 and the literal 16 pinned to r1 to force
 *     the target's evaluation order for `16 - *countdown`. */

u8 sub_080106B8(void)
{
    register vu8 *countdown asm("r2") = (vu8 *)0x03006538;
    register vu16 *bldcnt asm("r0");
    vu8 *p3480 = (vu8 *)0x03003480;
    int c = *countdown;
    if (c != 0) {
        *countdown = c - 1;
        *(vu16 *)0x03005398 = 0;
        p3480[5] = 0;
    }
    bldcnt = (vu16 *)0x04000054;
    {
        register int n asm("r1") = 16;
        *bldcnt = n - *countdown;
    }
    return *countdown;
}

/* Fade-out init helper. Sets countdown=16, REG_BLDCNT=16 (full
 * darkness), and installs `arg` as REG_WININ. Companion to
 * sub_08010710 (fade-out ticker). */

u16 sub_080106EC(u16 arg)
{
    *(vu8 *)0x03006538 = 16;
    *(vu16 *)0x04000054 = 16;
    *(vu16 *)0x04000050 = arg;
    return arg;
}

/* Fade-out ticker. Same countdown logic as sub_080106B8 but writes
 * the raw countdown value (rather than 16-countdown) to REG_BLDCNT,
 * so the blend darkens as the countdown runs out. 12 BL callers.
 *
 * Matching notes: same r2 pin + p3480 anchor as sub_080106B8. The
 * final block doesn't need the bldcnt/n pins because there's no
 * arithmetic on countdown before the store. */

u8 sub_08010710(void)
{
    register vu8 *countdown asm("r2") = (vu8 *)0x03006538;
    vu8 *p3480 = (vu8 *)0x03003480;
    int c = *countdown;
    if (c != 0) {
        *countdown = c - 1;
        *(vu16 *)0x03005398 = 0;
        p3480[5] = 0;
    }
    *(vu16 *)0x04000054 = *countdown;
    return *countdown;
}
