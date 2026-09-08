#include "entity.h"
#include "iwram.h"
#include "level_layout_data.h"
#include "sound.h"
#include "types.h"

extern void Entity_AdvanceAnimFrames(s32 first, s32 last);

enum {
    FIRST_PATH_SLOT = 78,
    LAST_PATH_SLOT = 92,
    PATH_COUNT = 15,
    PROXIMITY_SLOT_A = 80,
    PROXIMITY_SLOT_B = 85,
    PROXIMITY_SLOT_C = 90,
    PROXIMITY_DISTANCE = 73,
    PATH_STOP_PLAYER_Y = 587,
    PATH_STOP_X = 347,
    PATH_STOP_ENTITY_Y = 450,
    PATH_STOP_ENTITY_Y_RANGE = 12,
    SOUND_ENTRY = 6,
};

void sub_08024DBC(void)
{
    u8 i;
    u16 xDistance80;
    u16 yDistance80;
    u16 xDistance85;
    u16 yDistance85;
    u16 xDistance90;
    u16 yDistance90;
    /* The unsigned staging value preserves each axis difference before the
     * signed threshold comparisons below. */
    u16 distance;

    i = 0;
    do {
        if (gEntities[0].y > PATH_STOP_PLAYER_Y || gEntities[0].x > PATH_STOP_X) {
            if ((u16)(gEntities[FIRST_PATH_SLOT].y - PATH_STOP_ENTITY_Y) <= PATH_STOP_ENTITY_Y_RANGE &&
                gEntities[FIRST_PATH_SLOT].x == PATH_STOP_X) {
                Entity_AdvanceAnimFrames(FIRST_PATH_SLOT, LAST_PATH_SLOT);
                SoundEntry_Stop(SOUND_ENTRY);
                return;
            }
        }

        Entity_FollowPath(sEntityPathTable_313F88[i], i + FIRST_PATH_SLOT);
        ModeControl_SetBit(&gIwram_6110, i + FIRST_PATH_SLOT);
        i++;
    } while (i < PATH_COUNT);

    if (gEntities[0].x - gEntities[PROXIMITY_SLOT_A].x >= 0)
        distance = gEntities[0].x - gEntities[PROXIMITY_SLOT_A].x;
    else
        distance = gEntities[PROXIMITY_SLOT_A].x - gEntities[0].x;
    xDistance80 = distance;
    if (gEntities[0].y - gEntities[PROXIMITY_SLOT_A].y >= 0)
        distance = gEntities[0].y - gEntities[PROXIMITY_SLOT_A].y;
    else
        distance = gEntities[PROXIMITY_SLOT_A].y - gEntities[0].y;
    yDistance80 = distance;

    if (gEntities[0].x - gEntities[PROXIMITY_SLOT_B].x >= 0)
        distance = gEntities[0].x - gEntities[PROXIMITY_SLOT_B].x;
    else
        distance = gEntities[PROXIMITY_SLOT_B].x - gEntities[0].x;
    xDistance85 = distance;
    if (gEntities[0].y - gEntities[PROXIMITY_SLOT_B].y >= 0)
        distance = gEntities[0].y - gEntities[PROXIMITY_SLOT_B].y;
    else
        distance = gEntities[PROXIMITY_SLOT_B].y - gEntities[0].y;
    yDistance85 = distance;

    if (gEntities[0].x - gEntities[PROXIMITY_SLOT_C].x >= 0)
        distance = gEntities[0].x - gEntities[PROXIMITY_SLOT_C].x;
    else
        distance = gEntities[PROXIMITY_SLOT_C].x - gEntities[0].x;
    xDistance90 = distance;
    if (gEntities[0].y - gEntities[PROXIMITY_SLOT_C].y >= 0)
        yDistance90 = gEntities[0].y - gEntities[PROXIMITY_SLOT_C].y;
    else
        yDistance90 = gEntities[PROXIMITY_SLOT_C].y - gEntities[0].y;

    if ((gIwram_35E0._field_10 & 2) != 0 ||
        ((s16)xDistance80 <= PROXIMITY_DISTANCE && (s16)yDistance80 <= PROXIMITY_DISTANCE) ||
        ((s16)xDistance85 <= PROXIMITY_DISTANCE && (s16)yDistance85 <= PROXIMITY_DISTANCE) ||
        ((s16)xDistance90 <= PROXIMITY_DISTANCE && (s16)yDistance90 <= PROXIMITY_DISTANCE)) {
        SoundEntry_Play(SOUND_ENTRY);
    } else {
        SoundEntry_Stop(SOUND_ENTRY);
    }

    Entity_UpdateMovers(FIRST_PATH_SLOT, LAST_PATH_SLOT);
    Entity_AdvanceAnimFrames(FIRST_PATH_SLOT, LAST_PATH_SLOT);
}
