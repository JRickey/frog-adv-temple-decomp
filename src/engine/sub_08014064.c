#include "macros.h"
#include "types.h"

extern void sub_08010A44(u8 a, u8 b);
extern void FrogStatusBar_Update(void);

void Engine_Update(void)
{
    sub_08010A44(5, 3);
    FrogStatusBar_Update();
}
