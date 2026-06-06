#include "iwram.h"
#include "macros.h"
#include "types.h"

void Attract_Cleanup(void);

void Attract_StepFinish(void)
{
    Attract_Cleanup();
    gIwram_35E0._data[0] = gIwram_34B4._data[2];
    *(u16 *)&gIwram_35E0._data[2] = 0;
}
