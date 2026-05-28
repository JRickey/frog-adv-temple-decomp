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

struct ClusterA710;
extern void sub_0800A710(struct ClusterA710 *p, u8 a, s16 b, s16 c, u8 d, u16 e, u8 f, u8 g, u8 h, u16 i);

/* Seeds entity[1] (0x03003758) from entity[0] (0x03003720, one 0x38 stride
 * back): copies its position halfwords (offsets 2/4, the +4 value biased by
 * 24) into the 10-arg struct initializer with otherwise constant fields.
 *
 * dst anchors the only pool literal (0x03003758); src is derived by
 * subtracting the 0x38 stride at runtime so agbcc keeps one pool word and
 * emits register-offset ldrsh instead of folding to a second literal. The
 * b/c parameters are declared s16 here (the canonical sub_0800A710 stores
 * them into u16 fields) so the caller sign-extends the position values. */
void sub_0800A540(void)
{
    struct ClusterA710 *dst = (struct ClusterA710 *)0x03003758;
    u8 *src = (u8 *)dst - 0x38;

    sub_0800A710(dst, 84, *(s16 *)(src + 2), (s16)(*(u16 *)(src + 4) - 24), 3, 992, 15, 2, 0, 32);
}
