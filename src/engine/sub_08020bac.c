#include "types.h"

extern u32 sub_08032148(void);
extern void sub_08031FDC(u32 a);

void sub_08020BAC(void)
{
    if (sub_08032148()) {
        sub_08031FDC(1);
    }
}
