#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

/* Sibling of sub_08001D18 (one of the mode-setup entries). Installs
 * config table 0x082f9be0 into the gGameStuff_6110 cluster via the
 * shared 6-arg setup helper, then primes the post-setup state
 * (sub_0800CE98(4, 0); sub_08009CBC()). Unlike sub_08001D18 it does
 * not clear the 0x03006500 halfword afterwards. */
void sub_08001484(void)
{
    ModeControl_Init(&gIwram_6110, 0x50, 4, (const void *)0x082f9be0, 1, 0);
    sub_0800CE98(4, 0);
    sub_08009CBC();
}
