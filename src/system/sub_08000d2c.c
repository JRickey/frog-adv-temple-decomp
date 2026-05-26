#include "game.h"
#include "types.h"

extern u32 sub_08009C14(u8 *state);
extern void sub_0800B7B0(u32 a, u32 b, u8 c);

/* When sub_08009C14 returns 0 (the failure / "not handled" path), write
 * state=8 to the caller's byte pointer before forwarding to sub_0800B7B0.
 * Mirrors the localState-mutation pattern in mode_15.c's case-4 handler. */
void sub_08000D2C(u8 *state, u32 a, u32 b)
{
    if (sub_08009C14(state) == 0) {
        *state = 8;
    }
    sub_0800B7B0(a, b, 18);
}
