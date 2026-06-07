#include "iwram.h"
#include "macros.h"
#include "types.h"

void Attract_Cleanup(void);

void Attract_StepFinish(void)
{
    Attract_Cleanup();
    gIwram_35E0.lives = gIwram_34B4._data[2];
    gIwram_35E0.coins = 0;
}
