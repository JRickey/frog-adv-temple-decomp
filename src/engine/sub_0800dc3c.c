#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void PadGrid_RemoveRandom(u32 count);
extern void PadGrid_FillGrid(s32 a, s32 b);

void sub_0800DC3C(void)
{
    PadGrid_RemoveRandom(5);
    PadGrid_FillGrid(20, 10);
}
