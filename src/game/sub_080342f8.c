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
extern fp_number_type *sub_08034150(fp_number_type *a, fp_number_type *b, fp_number_type *tmp);
extern float sub_0803401C(fp_number_type *src);

float sub_080342F8(float arg_a, float arg_b)
{
    fp_number_type a;
    fp_number_type b;
    fp_number_type tmp;
    fp_number_type *res;

    sub_080340D4((u32 *)&arg_a, &a);
    sub_080340D4((u32 *)&arg_b, &b);

    b.sign ^= 1;

    res = sub_08034150(&a, &b, &tmp);

    return sub_0803401C(res);
}
