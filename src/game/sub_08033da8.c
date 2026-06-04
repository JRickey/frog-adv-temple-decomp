#include "macros.h"
#include "types.h"

/* sub_08033DA8 is __div0 from libgcc _dvmd_tls.o — the divide-by-zero handler
 * called by __divsi3 when the divisor is 0. It immediately returns to the
 * caller of the __divsi3 Ldiv0 path, which then returns 0.
 *
 * Shipped NAKED. agbcc always emits `bx lr` for empty Thumb leaf functions;
 * the libgcc helper was compiled non-interwork and uses `mov pc, lr` (0x46f7)
 * instead. No pure-C body produces that encoding. */
NAKED void sub_08033DA8(void)
{
    asm(".syntax unified\n"
        "    mov pc, lr\n"
        "    .syntax divided\n");
}

/* sub_08033DAC is __fixunssfsi from libgcc — converts a single-precision
 * float to unsigned 32-bit integer. Handles values >= 2^31 by subtracting
 * 2^31 (via float addition of -2^31), converting the reduced value through
 * the signed __fixsfsi path, then adding 2^31 back as an integer offset. */
extern int sub_08034760(float, float);   /* __gesf2  */
extern int sub_08034898(float);          /* __fixsfsi */
extern float sub_080342CC(float, float); /* __addsf3 */

u32 sub_08033DAC(float a0)
{
    int r;

    r = sub_08034760(a0, 2147483648.0f);
    if (r >= 0) {
        float t = sub_080342CC(a0, -2147483648.0f);
        r = sub_08034898(t);
        return (u32)r + 0x80000000;
    }
    return (u32)sub_08034898(a0);
}
