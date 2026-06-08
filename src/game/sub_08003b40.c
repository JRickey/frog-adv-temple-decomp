#include "entity.h"
#include "game.h"
#include "types.h"

extern void EntityScript_BuildSlotData(u32 arg, void *buf);
extern void Entity_SetupHitboxSlots(u8 *slots, u32 *out, s8 type);

void Mode11_SetupEntities(u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u8 *arg5, u32 *arg6)
{
    gGameStuff.sceneType = 11;
    EntityScript_BuildSlotData(1, (void *)arg0);
    Entity_UpdateHitboxSlots((void *)arg1, (void *)arg2, 6);
    Entity_UpdateHitboxSlots((void *)arg3, (void *)arg4, 7);
    Entity_SetupHitboxSlots(arg5, arg6, 22);
}
