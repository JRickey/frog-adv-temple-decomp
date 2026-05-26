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
