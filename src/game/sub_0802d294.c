#include "entity.h"
#include "game.h"
#include "game_constants.h"
#include "iwram.h"
#include "types.h"

extern s32 RandRange(u8 range);
extern void Entity_Init(struct Entity *p, u8 kind, s16 x, s16 y, u8 actorId, u16 e, u8 f, u8 g, u8 state,
                        u16 initFlags);
extern void MotionDesc_Set(struct MotionDesc *m, s8 sel, s8 a, s8 b);
extern u32 sub_0802D448(void);
extern void Entity_Update(void *entity);

/* Spawns slot 3+index with a random kind (0x5D/0x5E) at a random tile column
 * (7..11 for the first ten slots, 2..6 after), then marks mode bit bitBase+index. */
void sub_0802D294(u8 bitBase, u8 index)
{
    u8 kind;
    u8 sel;
    u16 x;
    struct Entity *entity;

    kind = RandRange(2) + 0x5D;
    entity = &gEntities[index + 3];
    sel = RandRange(2) + 5;
    if (index <= 9) {
        x = TILE_CENTER_X(RandRange(5) + 7);
    } else {
        x = TILE_CENTER_X(RandRange(5) + 2);
    }

    Entity_Init(entity, kind, x, 11, 3, (index << 5) + 0x81, 3, 2, 2, 16);
    MotionDesc_Set((struct MotionDesc *)entity, sel, 0, 1);
    ModeControl_SetBit(&gIwram_6110, bitBase + index);
}

/* Ticks slot bitBase+index; returns 1 once its 0x8000 flag retires it and
 * sub_0802D448 reports the whole group (slots 3..22) retired. */
u32 sub_0802D350(u8 bitBase, u8 index)
{
    u32 maskedStatus;
    struct Entity *entity;
    u16 status;

    /* entity holds the pool base and is bumped in place: a separate base
     * variable is block-local, gets local-alloc'd into r0 and shifts the
     * index/offset temporaries off r1/r0. */
    entity = gEntities;
    entity += bitBase + index;

    if (entity->state != 0) {
        entity->state = 0;
        entity->status |= 2;
    }

    status = entity->status;
    if ((status & 0x8000) != 0) {
        maskedStatus = 8;
        maskedStatus |= status;
        maskedStatus &= 0x7FFF;
        entity->status = maskedStatus;
        if (sub_0802D448() != 0) {
            return 1;
        }
    }

    Entity_Update(&gEntities[bitBase + index]);
    return 0;
}
