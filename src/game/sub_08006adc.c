#include "macros.h"
#include "types.h"

void sub_08016A40(void);

/* Decrement-and-call timer leaf: decrements the u8 counter at *p. When the
 * decremented value goes signed-negative (the high bit of the byte sets),
 * clamps the byte back to 0 and returns 0; otherwise invokes
 * sub_08016A40() and returns 1.
 *
 * The `v = 0; *p = v; return v;` shape (instead of `*p = 0; return 0;`) is
 * load-bearing — it lets agbcc share the materialised constant 0 between
 * the strb and the return value, matching the baserom's single `movs r0,
 * #0; strb r0, [r1, #0]; pop {r1}; bx r1` tail. The straightforward
 * spelling emits a second `movs r0, #0` after the store. */

u8 sub_08006ADC(u8 *p)
{
    u8 v;

    *p -= 1;
    if ((s8)*p < 0) {
        v = 0;
        *p = v;
        return v;
    }
    sub_08016A40();
    return 1;
}

/* Increment-and-call timer: increments the s16 counter at [p+2]. When
 * the incremented value exceeds 99, clamps it back to 99 and returns 0;
 * otherwise invokes sub_08016A40() and returns 1.
 *
 * Using int for v avoids the agbcc u16-truncation pattern (lsls/lsrs)
 * before strh; the (s16) cast defers sign-extension to the comparison,
 * matching the baserom's lsls/asrs after the strh. */

u8 sub_08006AFC(u8 *p)
{
    u16 *f = (u16 *)(p + 2);
    int v;

    v = *f + 1;
    *f = v;
    if ((s16)v > 99) {
        *f = 99;
        return 0;
    }
    sub_08016A40();
    return 1;
}

/* Increment-and-call timer: increments the s16 counter at [p+2]. When
 * the incremented value goes negative (bit 15 set), clamps it back to 0
 * and returns 0; otherwise invokes sub_08016A40() and returns 1.
 *
 * int v avoids u16 truncation before strh; (s16) cast matches the lsls/cmp
 * blt check in baserom. v = 0; *f = v; return v; shares the single
 * materialised zero between the strh and the return value (same trick as
 * sub_08006ADC), avoiding a second movs r0, #0. */

u8 sub_08006B20(u8 *p)
{
    u16 *f = (u16 *)(p + 2);
    int v;

    v = *f + 1;
    *f = v;
    if ((s16)v < 0) {
        v = 0;
        *f = v;
        return v;
    }
    sub_08016A40();
    return 1;
}
