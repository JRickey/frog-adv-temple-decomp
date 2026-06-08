#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"
extern void Entity_SetupHitboxSlots(u8 *slots, u32 *out, s8 type);

void Scene_InitHitboxes(u8 *state, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u8 *arg5, u32 *arg6)
{
    if (Scene_EntityTick(state) == 0)
        *state = 7;

    Entity_UpdateHitboxSlots((void *)arg1, (void *)arg2, 6);
    Entity_UpdateHitboxSlots((void *)arg3, (void *)arg4, 7);
    Entity_SetupHitboxSlots(arg5, arg6, 22);
}
