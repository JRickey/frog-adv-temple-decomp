#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern int sub_0801185C(u8 arg);

void sub_08019964(void)
{
    gGameStuff.rngSeed = sub_0801185C(200);
    gIwram_34A0.dispatchIdx = 2;
}
