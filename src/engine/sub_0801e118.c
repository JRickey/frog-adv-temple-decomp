#include "types.h"

extern void sub_0801D150(u8 arg);
extern void sub_0801D268(u8 arg);
extern u16 sub_080106EC(u16 arg);
extern void sub_0801E270(u32 delay);
extern s32 sub_08010710(void);
extern void sub_0801A894(u8 a, u8 b);
extern void sub_0801D33C(u8 arg);
extern void sub_0801D4CC(u8 arg);
extern u16 sub_080004C4(void);
extern u8 sub_0801E1AC(u8 arg);
extern void sub_0801A980(u8 a, u8 b);
extern u8 sub_08010694(u8 arg);
extern s32 sub_080106B8(void);

/* Scene transition: fade the screen out, swap room state, then fade back
 * in. sub_080106EC/sub_08010710 drive the fade-out, sub_08010694/
 * sub_080106B8 the fade-in; sub_0801E270 busy-waits N frame-timer ticks
 * between steps. The middle do/while reseeds gIwram_5398 from
 * sub_080004C4() until sub_0801E1AC reports completion (0xFE), and the
 * window registers (REG_WIN0H / REG_WIN1H at 0x04000040 / 0x04000044) are
 * cleared before the fade-in. The 0x03005398 base is anchored into a
 * local pointer so it survives across the loop's two BL callees. */

u8 sub_0801E118(void)
{
    u16 *fadeState;

    sub_0801D150(0);
    sub_0801D268(0);
    sub_080106EC(0xBF);
    while (sub_08010710() != 0)
        sub_0801E270(2);

    sub_0801E270(0x78);
    sub_0801A894(3, 20);
    sub_0801D33C(0);
    sub_0801D4CC(0);

    fadeState = (u16 *)0x03005398;
    do {
        *fadeState = sub_080004C4();
    } while (sub_0801E1AC(0) != 0xFE);

    sub_0801A980(3, 20);
    *(vu16 *)0x04000040 = 0;
    *(vu16 *)0x04000044 = 0;
    sub_0801E270(0x78);

    sub_08010694(0xBF);
    while (sub_080106B8() != 0)
        sub_0801E270(2);

    return 1;
}
