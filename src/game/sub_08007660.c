#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Per-script header table at 0x080C0AB0 (sEntityScriptIndex, 7 entries x 8 B,
 * extracted as a flat u32 array in src/data/entity_dispatch.c). Re-typed here
 * as records so this consumer can index by the signed script id and read the
 * per-entry signed-byte fields. Same family as the EntityScript_Advance consumer in
 * src/game/LoadPartEntry.c. */
struct EntScript {
    s8 count; /* +0: signed loop bound */
    u8 _b1;
    s8 _b2; /* +2: forwarded to Entity_TickCells */
    u8 _b3;
    const void *script; /* +4 */
};

extern const struct EntScript sEntityScriptIndex[];

extern void Entity_TickCells(void *cells, s32 first, s32 last, s8 arg3);
extern s32 Entity_CheckEngage(void *entries, s8 count);
extern void Entity_ApplyGridMovement(void *entries, s8 first, s8 last);

/* Looks up the per-script header in sEntityScriptIndex[id], sweeps the cell
 * range [0, count-1] through Entity_TickCells, then gates the grid sweep
 * Entity_ApplyGridMovement on whether Entity_CheckEngage reports an engaged entry. */
void Entity_RunScript(u32 id, void *obj)
{
    const struct EntScript *table = sEntityScriptIndex;
    const struct EntScript *entry = &table[(s8)id];
    s8 count = entry->count;

    Entity_TickCells(obj, 0, count - 1, entry->_b2);

    if (Entity_CheckEngage(obj, count))
        Entity_ApplyGridMovement(obj, 0, (s8)((u8)entry->count - 1));
}
