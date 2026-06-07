#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

typedef void (*GameProc)(void);
extern const GameProc gHandlerTable_08308028[];

extern void Attract_StepFinish(void);

void GameMode_Attract(void)
{
    GameStuff *tmp;
    GameStuff *gs;
    u8 step;

    gIwram_35E0._data[0] = gIwram_34B4._data[2];
    *(u16 *)&gIwram_35E0._data[2] = 0;

    tmp = &gGameStuff;
    step = tmp->attractStep;
    gs = tmp;
    if (step == 2)
        gs->attractStep = 0;
    else
        gs->attractStep = step + 1;

    switch (step) {
    case 0:
        gs->sceneType = 1;
        break;
    case 1:
        gs->sceneType = 2;
        break;
    case 2:
        gs->sceneType = 4;
        break;
    case 3:
        gs->sceneType = 7;
        break;
    }

    gHandlerTable_08308028[step]();
    Attract_StepFinish();
    gGameStuff.sceneType = 0;
}
