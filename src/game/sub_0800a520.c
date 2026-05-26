#include "game.h"
#include "macros.h"
#include "types.h"

/* Per-frame helper called once from sub_0800A2D8 (the entity-dispatch
 * tail). Runs five fixed subsystem updates in sequence. The single
 * non-zero argument (24, 24) to sub_0800793C is preserved literally;
 * its meaning is unknown until that callee is decompiled.
 *
 * Lives in its own .c rather than dispatch_helpers.c because the
 * sibling sub_0800A2D8 sits at 0x0800a2d8 with multiple intervening
 * asm functions before this one — one .o cannot span both slots
 * without -ffunction-sections, which agbcc isn't built with here.
 */

extern void sub_08007DD0(void);
extern void sub_0800793C(u32 a, u32 b);
extern void sub_08008174(void);
extern void sub_080090B0(void);
extern void sub_0800A4D0(void);

void sub_0800A520(void)
{
    sub_08007DD0();
    sub_0800793C(24, 24);
    sub_08008174();
    sub_080090B0();
    sub_0800A4D0();
}
