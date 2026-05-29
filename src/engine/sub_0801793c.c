#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

typedef void (*GameProc)(void);
extern const GameProc gHandlerTable_08308028[];

extern void sub_08017A88(void);

void sub_0801793C(void)
{
    GameStuff *tmp;
    GameStuff *gs;
    u8 step;

    gIwram_35E0._data[0] = gIwram_34B4._data[2];
    *(u16 *)&gIwram_35E0._data[2] = 0;

    tmp = &gGameStuff;
    step = tmp->_step24;
    gs = tmp;
    if (step == 2)
        gs->_step24 = 0;
    else
        gs->_step24 = step + 1;

    switch (step) {
    case 0:
        gs->pendingMode = 1;
        break;
    case 1:
        gs->pendingMode = 2;
        break;
    case 2:
        gs->pendingMode = 4;
        break;
    case 3:
        gs->pendingMode = 7;
        break;
    }

    gHandlerTable_08308028[step]();
    sub_08017A88();
    gGameStuff.pendingMode = 0;
}
