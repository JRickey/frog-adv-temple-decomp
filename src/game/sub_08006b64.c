#include "macros.h"
#include "types.h"

void sub_08016A40(void);

/* Increment-and-call timer: increments the s16 counter at [p+2], then
 * checks the signed byte at [p+0]. If that byte is negative, clamps the
 * s16 counter back to 0 and returns 0; otherwise invokes sub_08016A40()
 * and returns 1.
 *
 * v = 0; *f = v; return v; shares the single materialised zero between
 * the strh and the return value (same trick as sub_08006B20), avoiding a
 * second movs r0, #0. */

u8 sub_08006B64(u8 *p)
{
    u16 *f = (u16 *)(p + 2);
    int v;

    *f += 1;
    if ((s8)p[0] < 0) {
        v = 0;
        *f = v;
        return v;
    }
    sub_08016A40();
    return 1;
}
