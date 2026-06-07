#include "iwram.h"
#include "entity.h"
#include "types.h"

extern void Entity_CheckProximityAndPlaySound(struct Entity *s, u8 idx, u8 halfW, u8 halfH);

extern const u32 sLevelLayout_312210[];

void UpdateEntitySlot5F(void)
{
    struct Entity *entity;
    u8 fieldA;
    u8 fieldB;

    entity = &gEntities[0x5f];
    fieldA = entity->state;
    if (fieldA != 3) {
        goto done;
    }
    fieldB = entity->field_1B;
    if (fieldB != 0) {
        goto done;
    }
    if (entity->status & 0x200) {
        goto done;
    }
    Entity_CheckProximityAndPlaySound(entity, 6, 2, 2);
done:
    Entity_WalkCompactRecords(0x5f, sLevelLayout_312210, 0x19, &gIwram_6110, 0);
}
