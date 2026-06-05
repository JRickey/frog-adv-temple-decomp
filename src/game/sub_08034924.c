#include "macros.h"
#include "types.h"

struct FloatComponents {
    u32 type;
    u32 sign;
    s32 exp;
    u32 mantissa;
};

extern u32 sub_0803401C(struct FloatComponents *comp);

u32 sub_08034924(u32 type, u32 sign, s32 exp, u32 mantissa)
{
    struct FloatComponents comp;

    comp.type = type;
    comp.sign = sign;
    comp.exp = exp;
    comp.mantissa = mantissa;
    return sub_0803401C(&comp);
}
