#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

/* One of the mode-setup entries dispatched from sub_08000918's
 * 14-case state machine. Installs config table 0x082f9a50 into the
 * gGameStuff_6110 cluster via the shared 6-arg setup helper, then
 * primes the post-setup state (sub_0800CE98(6, 0); sub_08009CBC())
 * and clears halfword 0x36 of the 0x03006500 IWRAM block. */
void sub_08001D18(void)
{
    sub_0800658C((void *)0x03006110, 0x80, 6, (const void *)0x082f9a50, 1, 5);
    sub_0800CE98(6, 0);
    sub_08009CBC();
    {
        u16 *p = (u16 *)0x03006500;
        p[0x36 / 2] = 0;
    }
}
