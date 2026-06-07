#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

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
