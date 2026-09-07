#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_0802D294(u8 group, u8 idx);
extern u32 sub_0802D40C(u8 group, u8 idx);
extern u32 sub_0802D350(u8 group, u8 idx);
extern void Entity_Update(struct Entity *e);

void sub_0802D170(void)
{
    s8 i;
    s32 slot;
    struct Entity *e;

    for (i = 0; i <= 19; i++) {
        slot = i + 3;
        e = &gEntities[slot];
        if (e->status & 0x08) {
            if (!(e->status & 0x80)) {
                e->field_32 = (u8)RandRange(10) * 300 + 50;
                e->status |= 0x80;
                gEntities[slot].spawnTick = gGameStuff._unk00;
                continue;
            }
            if (gGameStuff._unk00 - gEntities[slot].spawnTick <= e->field_32)
                continue;
            sub_0802D294(3, i);
            e->status &= 0xFF7F;
            continue;
        }
        ModeControl_SetBit(&gIwram_6110, slot);
        if (sub_0802D40C(3, i)) {
            if (sub_0802D350(3, i))
                return;
            continue;
        }
        if (e->status & 0x8000)
            e->status = (e->status & 0x7FFF) | 2;
        EntityMover_Tick(slot);
        Entity_Update(&gEntities[i + 3]);
    }
}
