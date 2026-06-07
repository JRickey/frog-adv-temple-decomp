#include "entity.h"
#include "game.h"
#include "types.h"

/* When Scene_EntityTick returns 0 (the failure / "not handled" path), write
 * state=8 to the caller's byte pointer before forwarding to Entity_UpdateHitboxSlots.
 * Mirrors the localState-mutation pattern in mode_15.c's case-4 handler. */
void Mode8_StateStep(u8 *state, u32 a, u32 b)
{
    if (Scene_EntityTick(state) == 0) {
        *state = 8;
    }
    Entity_UpdateHitboxSlots((void *)a, (void *)b, 18);
}
