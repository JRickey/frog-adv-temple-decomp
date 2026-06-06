#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u32 Scene_EntityTick(u8 *state);
extern void Entity_UpdateHitboxSlots(u32 a, u32 b, u8 c);
extern void ModeControl_ClearBit(u32 base, u32 idx, u32 val);

/* Sibling of Mode8_StateStep: when Scene_EntityTick fails the predicate, force
 * state=7 onto the caller's byte pointer, then forward to Entity_UpdateHitboxSlots
 * (mode=5). Afterwards, branch on the signed sub-state byte at
 * gGameStuff_35E0[5]:
 *   <= 1 : clear flags 8 and 9 on the 0x03006110 cluster
 *   == 2 : set flags 8 and 9
 *   == 3 : set flags 8 and 9 (same as 2)
 * The two cmp #2 / cmp #3 arms reload the sub-state byte each time,
 * matching the baserom's three-arm cmp chain rather than a switch. */
void Scene_UpdateAnimState(u8 *state, u32 a, u32 b)
{
    if (Scene_EntityTick(state) == 0) {
        *state = 7;
    }
    Entity_UpdateHitboxSlots(a, b, 5);
    if (gIwram_35E0._field_5 <= 1) {
        ModeControl_ClearBit(0x03006110, 8, 0);
        ModeControl_ClearBit(0x03006110, 9, 0);
    }
    if ((u8)gIwram_35E0._field_5 == 2) {
        ModeControl_ClearBit(0x03006110, 8, 1);
        ModeControl_ClearBit(0x03006110, 9, 1);
    }
    {
        u8 lastState = (u8)gIwram_35E0._field_5;
        if (lastState == 3) {
            ModeControl_ClearBit(0x03006110, 8, 1);
            ModeControl_ClearBit(0x03006110, 9, 1);
        }
    }
}
