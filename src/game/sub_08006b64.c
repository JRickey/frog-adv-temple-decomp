#include "macros.h"
#include "types.h"

void StatusBar_Update(void);

/* Increment-and-call timer: increments the s16 counter at [p+2], then
 * checks the signed byte at [p+0]. If that byte is negative, clamps the
 * s16 counter back to 0 and returns 0; otherwise invokes StatusBar_Update()
 * and returns 1.
 *
 * v = 0; *f = v; return v; shares the single materialised zero between
 * the strh and the return value (same trick as Timer_IncrS16Wrap), avoiding a
 * second movs r0, #0. */

u8 Timer_IncrementCheckNeg(u8 *p)
{
    u16 *f = (u16 *)(p + 2);
    int v;

    *f += 1;
    if ((s8)p[0] < 0) {
        v = 0;
        *f = v;
        return v;
    }
    StatusBar_Update();
    return 1;
}
