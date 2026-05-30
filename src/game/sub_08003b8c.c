#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);
extern void sub_0800CBE8(u8 col, u8 row, u32 a, u32 b, u32 c);

void sub_08003B8C(void)
{
    struct IwramAt35E0 *p35E0;
    s32 b;
    s32 i;

    sub_0800658C((void *)0x03006110, 0x80, 12, (const void *)0x082f9b2c, 1, 5);
    sub_0800CE98(12, 0);
    sub_08009CBC();

    i = 0;
    p35E0 = &gIwram_35E0;
    for (b = 0x5D0000; i <= 5; b += 0x10000, i++) {
        sub_0800CBE8(p35E0->_field_18, p35E0->_field_19, 6, b >> 16, 13);
        sub_0800CBE8(p35E0->_field_18, p35E0->_field_19, 7, b >> 16, 14);
    }
}
