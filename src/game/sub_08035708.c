#include "macros.h"
#include "types.h"

struct DoubleComponents {
    u32 type;
    u32 sign;
    s32 exp;
    u64 frac64;
};

extern u64 sub_080349D8(struct DoubleComponents *comp);

u64 sub_08035708(u32 type, u32 sign, s32 exp, u64 frac64)
{
    struct DoubleComponents s;

    s.type = type;
    s.sign = sign;
    s.exp = exp;
    s.frac64 = frac64;
    return sub_080349D8(&s);
}
