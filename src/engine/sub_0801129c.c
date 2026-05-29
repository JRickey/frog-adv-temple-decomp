#include "types.h"

/* Reset helper: clear the 16-byte record at 0x030063F0 back-to-front, then
 * zero bytes 0 and 2 of the state block at 0x03006540.
 *
 * Matching notes (built with old_agbcc — see Makefile):
 *   - old_agbcc avoids the redundant `push {lr}; pop {r0}; bx r0` epilogue
 *     that newer agbcc emits for the loop's control-flow join.
 *   - `buf`/`p` are signed s32 (not u8*) so the loop-bound `cmp` compiles to
 *     a signed `bge`, matching the baserom (unsigned pointers give `bcs`).
 *   - the store value is pinned to r2 and initialised first so agbcc emits
 *     `movs r2, #0` ahead of the pointer setup, matching instruction order. */
void sub_0801129C(void)
{
    u8 *state = (u8 *)0x03006540;
    s32 buf = 0x030063F0;
    register u8 zero asm("r2") = 0;
    s32 p;

    for (p = buf + 15; p >= buf; p--) {
        *(u8 *)p = zero;
    }

    state[0] = 0;
    state[2] = 0;
}
