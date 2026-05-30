#include "macros.h"
#include "types.h"

extern void sub_08010A44(u8 a, u8 b);
extern void sub_08017000(void);

void sub_08014064(void)
{
    sub_08010A44(5, 3);
    sub_08017000();
}
