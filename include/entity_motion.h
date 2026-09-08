#ifndef GUARD_ENTITY_MOTION_H
#define GUARD_ENTITY_MOTION_H

#include "types.h"

/* Signed inputs are encoded as bytes in the motion fields of an entity record. */
void MotionDesc_Set(void *record, s8 selection, s8 deltaX, s8 deltaY);

#endif /* GUARD_ENTITY_MOTION_H */
