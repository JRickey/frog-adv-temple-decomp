#include "entity.h"
#include "entity_motion.h"
#include "iwram.h"
#include "types.h"

extern void Entity_CheckProximityAndPlaySound(struct Entity *entity, u8 sound, u8 halfW, u8 halfH);
extern void Entity_Update(struct Entity *entity);

enum {
    PRIMARY_SLOT_START = 40,
    PEER_SLOT_START = 50,
    PRIMARY_COUNT = 10,
    ENTITY_STATUS_DIRTY = 2,
    ENTITY_STATUS_SOUND_PENDING = 0x200,
    ENTITY_STATUS_FLAG_8000 = 0x8000,
};

void sub_08028270(void)
{
    u8 i;
    struct Entity *primary;
    struct Entity *peer;

    i = 0;
    for (; i < PRIMARY_COUNT; i++) {
        primary = &gEntities[PRIMARY_SLOT_START] + i;
        peer = &gEntities[PEER_SLOT_START] + (i >> 1);

        if (primary->status & ENTITY_STATUS_FLAG_8000) {
            primary->status |= ENTITY_STATUS_DIRTY;
            gEntities[i + PRIMARY_SLOT_START].status &= ~ENTITY_STATUS_FLAG_8000;
        }

        switch (primary->state) {
        case 0:
            if (peer->y - primary->y <= 17)
                primary->state++;
            break;

        case 1:
            /* The reference keeps phase 0 separate from the following phase chain. */
            if (primary->field_1B == 0) {
                peer->y = primary->y + 18;
                if (primary->status & ENTITY_STATUS_SOUND_PENDING) {
                    Entity_CheckProximityAndPlaySound(primary, 10, 2, 2);
                    primary->status &= ~ENTITY_STATUS_SOUND_PENDING;
                }
            }

            if (primary->field_1B == 1) {
                peer->y = primary->y + 13;
            } else if (primary->field_1B == 2) {
                peer->y = primary->y + 8;
            } else if (primary->field_1B == 3) {
                peer->y = primary->y + 13;
            } else if (primary->field_1B == 4) {
                peer->y = primary->y + 18;
                primary->state--;
                peer->state = 2;
                MotionDesc_Set(peer, 5, 0, 1);
                primary->status |= ENTITY_STATUS_SOUND_PENDING;
            }
            break;

        case 2:
            if (primary->y - peer->y <= 17)
                primary->state++;
            break;

        case 3:
            if (primary->field_1B == 0) {
                peer->y = primary->y - 18;
                if (primary->status & ENTITY_STATUS_SOUND_PENDING) {
                    Entity_CheckProximityAndPlaySound(primary, 10, 2, 2);
                    primary->status &= ~ENTITY_STATUS_SOUND_PENDING;
                }
            } else if (primary->field_1B == 1) {
                peer->y = primary->y - 13;
            } else if (primary->field_1B == 2) {
                peer->y = primary->y - 8;
            } else if (primary->field_1B == 3) {
                peer->y = primary->y - 13;
            } else if (primary->field_1B == 4) {
                peer->y = primary->y - 18;
                primary->state--;
                peer->state = 1;
                MotionDesc_Set(peer, 5, 0, -1);
                primary->status |= ENTITY_STATUS_SOUND_PENDING;
            }
            break;

        case 4:
            if (peer->x - primary->x <= 17)
                primary->state++;
            break;

        case 5:
            if (primary->field_1B == 0) {
                peer->x = primary->x + 18;
                if (primary->status & ENTITY_STATUS_SOUND_PENDING) {
                    Entity_CheckProximityAndPlaySound(primary, 10, 2, 2);
                    primary->status &= ~ENTITY_STATUS_SOUND_PENDING;
                }
            } else if (primary->field_1B == 1) {
                peer->x = primary->x + 13;
            } else if (primary->field_1B == 2) {
                peer->x = primary->x + 8;
            } else if (primary->field_1B == 3) {
                peer->x = primary->x + 13;
            } else if (primary->field_1B == 4) {
                peer->x = primary->x + 18;
                primary->state--;
                peer->state = 4;
                MotionDesc_Set(peer, 5, 1, 0);
                primary->status |= ENTITY_STATUS_SOUND_PENDING;
            }
            break;

        case 6:
            if (primary->x - peer->x <= 17)
                primary->state++;
            break;

        case 7:
            if (primary->field_1B == 0) {
                peer->x = primary->x - 18;
                if (primary->status & ENTITY_STATUS_SOUND_PENDING) {
                    Entity_CheckProximityAndPlaySound(primary, 10, 2, 2);
                    primary->status &= ~ENTITY_STATUS_SOUND_PENDING;
                }
            } else if (primary->field_1B == 1) {
                peer->x = primary->x - 13;
            } else if (primary->field_1B == 2) {
                peer->x = primary->x - 8;
            } else if (primary->field_1B == 3) {
                peer->x = primary->x - 13;
            } else if (primary->field_1B == 4) {
                peer->x = primary->x - 18;
                primary->state--;
                peer->state = 3;
                MotionDesc_Set(peer, 5, -1, 0);
                primary->status |= ENTITY_STATUS_SOUND_PENDING;
            }
            break;
        }

        Entity_Update(&gEntities[PRIMARY_SLOT_START] + i);
    }
}
