#include "macros.h"
#include "types.h"

void IntrEnable(void);

/* Thumb-callable interwork thunk: switches to ARM mode and branches to IntrEnable.
 * Emits: bx pc; nop (Thumb), then ARM `b IntrEnable`. */
NAKED void sub_08035D7C(void)
{
    asm(".syntax unified\n"
        "    bx      pc\n"
        "    nop\n"
        "    .ARM\n"
        "    b       IntrEnable\n"
        "    .syntax divided\n");
}
