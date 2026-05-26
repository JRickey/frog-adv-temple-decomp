#include "types.h"

extern void sub_0800DE80(void);

/* Thin forwarder to sub_0800DE80 — sibling of sub_08000D50, same shape
 * (push lr; bl sub_0800DE80; pop r0; bx r0). Likely another mode-dispatch
 * "release / teardown" entry. */
void sub_08001E18(void)
{
    sub_0800DE80();
}
