#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "sound.h"
#include "types.h"

extern void MotionDesc_Set(struct Entity *e, s8 sel, s8 a, s8 b);

void sub_0802D4AC(struct Entity *e)
{
    e->state = 0;
    MotionDesc_Set(e, 0, 0, 0);
    e->status |= 2;

    gIwram_6110.scenePhase--;
    CtrlFlags_SetBit(&gIwram_6110, 8, 3);

    if (gIwram_6110.scenePhase == 0) {
        Sound_Play(0x69);
        return;
    }

    Sound_Play(0x7a);
}
