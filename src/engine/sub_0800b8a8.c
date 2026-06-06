#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Item-pickup handler — on b == 23, looks up an entity slot via
 * EntityHitbox_FindPoint(a, gIwram_35E0.tileX, gIwram_35E0.tileY) and, if the
 * slot's flag byte at +4 is clear, claims it (clear +5, set +4, copy
 * gGameStuff._unk00 to +0), plays sfx #22 via Sound_Play, and OR's
 * (1 << idx) into the caller-supplied 64-bit mask.
 *
 * Matching notes (agbcc 2.x):
 *   - The entry-pointer arithmetic is written as `(idx << 3) + (u32)arr`
 *     rather than `&arr[idx]` so agbcc emits `adds r1, r0, r5` (offset
 *     first, base second). The natural `&arr[idx]` form folds to
 *     `adds r1, r5, r0` — byte_diff 2 from baserom. */

extern s8 EntityHitbox_FindPoint(s8 a, s16 x, s16 y);
extern void Sound_Play(u32 a);

struct EntryB8A8 {
    u32 _field_0;
    u8 _field_4;
    u8 _field_5;
    u8 _pad6[2];
};

void Entity_ActivateHitSlot(struct EntryB8A8 *arr, unsigned long long *mask, u8 a, u8 b)
{
    s8 idx;
    struct EntryB8A8 *entry;

    if (b != 23)
        return;

    idx = EntityHitbox_FindPoint((s8)a, gIwram_35E0._field_8, gIwram_35E0._field_A);
    if (idx == -1)
        return;

    entry = (struct EntryB8A8 *)((u32)(idx << 3) + (u32)arr);
    if (entry->_field_4 != 0)
        return;

    entry->_field_5 = 0;
    entry->_field_4 = 1;
    entry->_field_0 = gGameStuff._unk00;
    Sound_Play(22);
    *mask |= (unsigned long long)1 << idx;
}
