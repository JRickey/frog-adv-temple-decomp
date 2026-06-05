#include "macros.h"
#include "types.h"

typedef enum { CLASS_SNAN, CLASS_QNAN, CLASS_ZERO, CLASS_NUMBER, CLASS_INFINITY } fp_class_type;

typedef struct {
    fp_class_type class;
    u32 sign;
    s32 normal_exp;
    u32 fraction;
} fp_number_type;

extern void sub_080340D4(u32 *src, fp_number_type *dst);
extern void sub_08035708(u32 type, u32 sign, s32 exp, u64 frac64);

void sub_0803493C(u32 a)
{
    fp_number_type buf;
    u32 type;
    u32 sign;
    s32 exp;
    u64 frac64;

    sub_080340D4(&a, &buf);
    type = buf.class;
    sign = buf.sign;
    exp = buf.normal_exp;
    frac64 = (u64)buf.fraction << 30;
    sub_08035708(type, sign, exp, frac64);
}
