#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Per-script header table at 0x080C0AB0 (sEntityScriptIndex, 7 entries x 8 B,
 * extracted as a flat u32 array in src/data/entity_dispatch.c). Re-typed here
 * as records so this consumer can index by the signed script id and read the
 * per-entry signed-byte fields. Same family as the sub_080072E0 consumer in
 * src/game/sub_08007228.c. */
struct EntScript {
    s8 count; /* +0: signed loop bound */
    u8 _b1;
    s8 _b2; /* +2: forwarded to sub_08006D24 */
    u8 _b3;
    const void *script; /* +4 */
};

extern const struct EntScript sEntityScriptIndex[];

extern void sub_08006D24(void *cells, s32 first, s32 last, s8 arg3);
extern s32 sub_08006FEC(void *entries, s8 count);
extern void sub_08006E8C(void *entries, s8 first, s8 last);

/* Looks up the per-script header in sEntityScriptIndex[id], sweeps the cell
 * range [0, count-1] through sub_08006D24, then gates the grid sweep
 * sub_08006E8C on whether sub_08006FEC reports an engaged entry. */
void sub_08007660(u32 id, void *obj)
{
    const struct EntScript *table = sEntityScriptIndex;
    const struct EntScript *entry = &table[(s8)id];
    s8 count = entry->count;

    sub_08006D24(obj, 0, count - 1, entry->_b2);

    if (sub_08006FEC(obj, count))
        sub_08006E8C(obj, 0, (s8)((u8)entry->count - 1));
}
