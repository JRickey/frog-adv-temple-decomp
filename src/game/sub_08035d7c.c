#include "macros.h"
#include "types.h"

void IntrEnable(void);

/* Thumb-callable interwork thunk: switches to ARM mode and branches to IntrEnable.
 * Emits: bx pc; nop (Thumb), then ARM `b IntrEnable`. */
NAKED void IntrEnable_Thunk(void)
{
    asm(".syntax unified\n"
        "    bx      pc\n"
        "    nop\n"
        "    .ARM\n"
        "    b       IntrEnable\n"
        "    .syntax divided\n");
}
