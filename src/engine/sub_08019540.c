#include "macros.h"
#include "types.h"

typedef void (*GameProc)(void);

/* State-handler dispatch table at ROM 0x0830804c (currently inside the
 * sSpriteAnimBlock_07104 blob; surfaced as a linker-assigned symbol so the
 * relocated array operand evaluates before the index — matching baserom's
 * r1-before-r0 pool order). Indexed by the byte at offset 4 of the IWRAM
 * scene-state struct at 0x03003480. Sibling dispatchers sub_08019500 /
 * sub_08019560 key off offsets 0 and 3 of the same struct.
 *
 * The indirect call lowers to `bl _call_via_r0` (libgcc thunk at
 * 0x08033cd8) — agbcc's standard Thumb function-pointer call sequence. */

extern const GameProc gStateHandlers_0830804C[];

struct SceneState {
    u8 _pad[4];
    u8 stateIdx;
};

void sub_08019540(void)
{
    gStateHandlers_0830804C[((struct SceneState *)0x03003480)->stateIdx]();
}
