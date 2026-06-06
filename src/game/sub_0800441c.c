#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void EntityScript_BuildSlotData(u32 partId, u8 *out);
extern void LoadPartEntry(u8 partId, u8 *out, u8 tag);
extern void Entity_UpdateHitboxSlots(u32 a, u32 b, u8 c);

void Mode13_SetupEntities(u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 arg5, u32 arg6)
{
    gGameStuff.pendingMode = 13;
    EntityScript_BuildSlotData(2, (u8 *)arg0);
    LoadPartEntry(3, (u8 *)arg1, 2);
    LoadPartEntry(4, (u8 *)arg2, 2);
    Entity_UpdateHitboxSlots(arg3, arg4, 11);
    Entity_UpdateHitboxSlots(arg5, arg6, 16);
}
