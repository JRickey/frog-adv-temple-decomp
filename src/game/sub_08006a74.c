#include "iwram.h"
#include "macros.h"
#include "types.h"

void StatusBar_Update(void);

/* Seeds the player run-state (gIwram_35E0): lives/coins/elements from the args,
 * then zeroes the collision + scratch fields. StatusBar_Update() is called
 * between writing elementsCollected and _field_5 to match the baserom order. */
void PlayerState_Init(struct IwramAt35E0 *p, u8 a, u16 b, u8 c, u8 e)
{
    p->lives = a;
    p->coins = b;
    p->elementsCollected = c;
    StatusBar_Update();
    p->_field_5 = (u8)e;
    p->colliderTag = 0;
    p->collisionType = 0;
    p->_field_14 = 0;
    p->_field_10 = 0;
    p->_field_12 = 0;
}

void PlayerState_SetByte(u8 *p, u8 v)
{
    *p = v;
    StatusBar_Update();
}

u32 PlayerState_IncrByteMax10(u8 *p)
{
    u32 v;

    v = *p + 1;
    *p = (u8)v;
    if ((s32)(v << 24) >> 24 > 10) {
        *p = 10;
        return 0;
    }
    StatusBar_Update();
    return 1;
}
