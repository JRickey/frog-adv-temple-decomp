#include "game.h"
#include "types.h"

/* sub_0802D558 is a thin Thumb wrapper around BIOS SWI 12 (CpuFastSet):
 *   r0=src, r1=dst, r2=count|mode-bits. The high bit of `count` (0x01000000)
 *   selects fill-mode (read src once, replicate into dst). */
extern void sub_0802D558(void *src, void *dst, u32 mode);

/* Called from Init1. Zero-clears OBJ tile 0 (32 bytes at 0x06010000) and
 * an unnamed 1KB IWRAM buffer at 0x030054a0 via CpuFastSet fill mode. */
void sub_0800072C(void)
{
    u32 zero1 = 0;
    u32 zero2;

    sub_0802D558(&zero1, (void *)0x06010000, 0x01000008);
    zero2 = 0;
    sub_0802D558(&zero2, (void *)0x030054a0, 0x01000100);
}

/* Step the LCG seed and return the result modulo `range`.
 * Multiplier 109 / increment 1021 — small-period generator used for
 * gameplay randomness (callers TBD; verified via struct_xref on offset 28). */
u8 sub_08000764(u8 range)
{
    gGameStuff.rngSeed = gGameStuff.rngSeed * 109 + 1021;
    return (u8)(gGameStuff.rngSeed % range);
}
