#include "types.h"

extern void sub_0800DE80(void);

/* Thin forwarder to sub_0800DE80 (the mode-15 / "level-cleanup" handler also
 * called from mode_15.c case 8). One of sub_08000918's mode-dispatch callees;
 * appears to be the "release / teardown" entry the dispatcher invokes from
 * its mode-handler table. */
void sub_08000D50(void)
{
    sub_0800DE80();
}
