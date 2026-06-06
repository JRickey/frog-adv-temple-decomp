#include "types.h"

void BuildRangeTable(u32 *src, u32 value, u32 *dst)
{
    dst[1] = value;
    value += src[1];
    dst[0] = value;
    value += src[0];
    dst[2] = value;
    value += src[2];
    dst[3] = value;
}
