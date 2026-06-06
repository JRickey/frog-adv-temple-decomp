#include "types.h"

/* Fixed-point reciprocal: 0x10000 / x as a signed 16-bit result (lowers to a
 * __divsi3 BL). The dividend is held in an int local so agbcc materializes the
 * 0x10000 constant before sign-extending the divisor — matches the baserom's
 * operand-evaluation order. */
s16 Fixed16Recip(s16 x)
{
    int n = 0x10000;

    return n / x;
}
