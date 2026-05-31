#include "game.h"
#include "types.h"

extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_080011A4(void);
extern void sub_0800DE80(void);
extern u32 sub_08009C14(u8 *state);

/* Per-frame gameplay tick: runs the entity-dispatch / render pipeline once
 * and bumps the frame counter. Same 6-call sequence + counter bump as the
 * case-3 active block of the mode_15 family (sub_08002844 etc.). */
void sub_080014B8(void)
{
    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    sub_080011A4();
    gGameStuff._unk14++;
}

/* Thin forwarder to sub_0800DE80 — same shape as sub_08001E18
 * (push lr; bl sub_0800DE80; pop r0; bx r0). */
void sub_080014E4(void)
{
    sub_0800DE80();
}

/* On sub_08009C14 reject: force state byte to 8. Same sub_08009C14 guard
 * pattern as sub_08001D94 (state=7) and sub_08003BFC (state=7). */
void sub_080014F0(u8 *state)
{
    if (sub_08009C14(state) == 0)
        *state = 8;
}
