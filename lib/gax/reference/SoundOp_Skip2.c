#include "types.h"

u32 SoundOp_Skip2(u32 arg0, u8 **cursor)
{
    *cursor += 2;
    return 1;
}
