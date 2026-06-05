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

#define MAX_SI_INT ((s32)((u32)(~0) >> 1))

static __inline__ int iszero(fp_number_type *x)
{
    return x->class == CLASS_ZERO;
}

static __inline__ int isnan(fp_number_type *x)
{
    return x->class == CLASS_SNAN || x->class == CLASS_QNAN;
}

static __inline__ int isinf(fp_number_type *x)
{
    return x->class == CLASS_INFINITY;
}

s32 sub_08034898(u32 a)
{
    fp_number_type buf;
    s32 shift;
    s32 tmp;

    sub_080340D4(&a, &buf);

    if (iszero(&buf))
        return 0;
    if (isnan(&buf))
        return 0;
    if (isinf(&buf))
        return buf.sign ? (-MAX_SI_INT) - 1 : MAX_SI_INT;
    if (buf.normal_exp < 0)
        return 0;
    if (buf.normal_exp > 30)
        return buf.sign ? (-MAX_SI_INT) - 1 : MAX_SI_INT;
    shift = 30 - buf.normal_exp;
    tmp = (s32)(buf.fraction >> shift);
    return buf.sign ? -tmp : tmp;
}
