#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

/* Mode-setup entry, sibling of sub_08001D18: installs config table
 * 0x082f9a1c into the gGameStuff_6110 cluster via the shared 6-arg
 * setup helper, then primes the post-setup state via
 * sub_0800CE98(5, 0) and sub_08009CBC(). */
void sub_080017A8(void)
{
    sub_0800658C((void *)0x03006110, 0x80, 5, (const void *)0x082f9a1c, 1, 3);
    sub_0800CE98(5, 0);
    sub_08009CBC();
}
