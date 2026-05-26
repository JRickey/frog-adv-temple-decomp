#include "game.h"
#include "types.h"

extern void sub_08007660(u32 a, u32 b);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_080018F8(u32 a, u32 b);

/* Per-frame tick for one of the mode handlers: drives shared input
 * (sub_08007660), per-frame state services (sub_0800A2D8 / sub_080008DC /
 * sub_0800A328), the sprite/asset pump (sub_080094F8 / sub_08009984), then
 * defers mode-specific work to sub_080018F8 before ticking the counter
 * at gGameStuff._unk14. */
void sub_08001D54(u32 a, u32 b, u32 c)
{
    sub_08007660(0, a);
    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    sub_080018F8(b, c);
    gGameStuff._unk14++;
}
