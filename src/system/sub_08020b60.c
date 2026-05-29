#include "types.h"

extern void sub_0802E13C(void);
extern void sub_08020E98(u32 a);
extern void sub_08032094(u32 a);
extern u32 SoundSlot_ClearInProgress(void);

void sub_08020B60(void)
{
    sub_0802E13C();
    sub_08020E98(0);
    sub_08032094(1);
}

void sub_08020B78(void)
{
    sub_08020E98(45);
    SoundSlot_ClearInProgress();
}
