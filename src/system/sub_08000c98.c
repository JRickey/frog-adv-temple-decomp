#include "game.h"
#include "types.h"

extern void sub_0800B7B0(u32 a, u32 b, u8 c);

/* Thin wrapper around sub_0800B7B0 — sets gGameStuff.pendingMode = 1 then
 * forwards the caller's two args with the constant third argument 18. */
void sub_08000C98(u32 a, u32 b)
{
    gGameStuff.pendingMode = 1;
    sub_0800B7B0(a, b, 18);
}
