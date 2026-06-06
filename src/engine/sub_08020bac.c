#include "types.h"

extern u32 SoundSystem_IsActive(void);
extern void sub_08031FDC(u32 a);

void sub_08020BAC(void)
{
    if (SoundSystem_IsActive()) {
        sub_08031FDC(1);
    }
}
