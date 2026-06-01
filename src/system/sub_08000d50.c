#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800DE80(void);

extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);
extern void sub_0800CBE8(u8 col, u8 row, u32 a, u32 b, u32 c);

/* Thin forwarder to sub_0800DE80 (the mode-15 / "level-cleanup" handler also
 * called from mode_15.c case 8). One of sub_08000918's mode-dispatch callees;
 * appears to be the "release / teardown" entry the dispatcher invokes from
 * its mode-handler table. */
void sub_08000D50(void)
{
    sub_0800DE80();
}

void sub_08000D5C(void)
{
    struct IwramAt35E0 *p35E0;

    ModeControl_Init(&gIwram_6110, 0x64, 2, (const void *)0x082f99e8, 1, 5);
    sub_0800CE98(3, 0);
    sub_08009CBC();

    p35E0 = &gIwram_35E0;
    sub_0800CBE8(p35E0->_field_18, p35E0->_field_19, 13, 36, 14);
    sub_0800CBE8(p35E0->_field_18, p35E0->_field_19, 14, 36, 13);
    sub_0800CBE8(p35E0->_field_18, p35E0->_field_19, 14, 35, 13);
    sub_0800CBE8(p35E0->_field_18, p35E0->_field_19, 14, 34, 13);
    sub_0800CBE8(p35E0->_field_18, p35E0->_field_19, 14, 33, 13);
    sub_0800CBE8(p35E0->_field_18, p35E0->_field_19, 14, 32, 13);
    sub_0800CBE8(p35E0->_field_18, p35E0->_field_19, 14, 31, 13);
    sub_0800CBE8(p35E0->_field_18, p35E0->_field_19, 14, 30, 13);
}
