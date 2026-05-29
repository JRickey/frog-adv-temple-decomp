#include "game.h"
#include "types.h"

extern void sub_0800B7B0(u32 a, u32 b, u8 c);

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

/* Thin wrapper around sub_0800B7B0 — sets gGameStuff.pendingMode = 1 then
 * forwards the caller's two args with the constant third argument 18. */
void sub_08000C98(u32 a, u32 b)
{
    gGameStuff.pendingMode = 1;
    sub_0800B7B0(a, b, 18);
}

/* Sibling of sub_08001484 / sub_08001D18: installs config table 0x082f998c
 * into the gGameStuff_6110 cluster via the shared 6-arg setup helper, then
 * runs two post-setup state primes (sub_0800CE98(0, 0); sub_0800CE98(1, 1))
 * before sub_08009CBC(). */
void sub_08000CB0(void)
{
    sub_0800658C((void *)0x03006110, 0x64, 0, (const void *)0x082f998c, 1, 3);
    sub_0800CE98(0, 0);
    sub_0800CE98(1, 1);
    sub_08009CBC();
}
