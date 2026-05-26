#include "game.h"
#include "types.h"

/* Cluster of four small dispatcher helpers between sub_08000EB8 (mode-9
 * inner loop) and sub_080011A4 (an input gate). The cluster is glue
 * between the mode-9 / mode-11 inner loops in sub_08000EB8 / sub_08001508
 * and the per-entity probe dispatcher in sub_08000E0C. None of the four
 * functions are referenced from any already-decompiled C — they are
 * called by sub_08001214 (still asm) which sits immediately after this
 * cluster and looks like another mode dispatcher.
 *
 * Shape sketch (verified by baserom objdump):
 *   sub_08001128(a, b)         — sets gGameStuff.pendingMode = 2 and calls
 *                                sub_0800B7B0(a, b, 3).
 *   sub_08001140(a, b)         — tail of an init/reset chain (5 subsystem
 *                                resets) followed by sub_08000E0C(a, b)
 *                                and gGameStuff._unk14++; matches the
 *                                sub_08000CEC pattern exactly with
 *                                sub_08000B6C swapped for sub_08000E0C
 *                                (and no sub_08016404 config-load step).
 *   sub_08001174(p, a, b)      — calls sub_08009C14(p); if it returns 0
 *                                writes 7 to *p, then unconditionally
 *                                sub_0800B7B0(a, b, 3).
 *   sub_08001198(void)         — single-statement thunk to sub_0800DE80.
 */

extern void sub_0800B7B0(void *sp_buf, void *r4_obj, u32 arg2);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08000E0C(void *ent, u32 arg1);
extern u32 sub_08009C14(u8 *p);
extern void sub_0800DE80(void);

void sub_08001128(void *a, void *b)
{
    gGameStuff.pendingMode = 2;
    sub_0800B7B0(a, b, 3);
}

void sub_08001140(void *a, u32 b)
{
    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    sub_08000E0C(a, b);
    gGameStuff._unk14++;
}

void sub_08001174(u8 *p, void *a, void *b)
{
    if (sub_08009C14(p) == 0)
        *p = 7;
    sub_0800B7B0(a, b, 3);
}

void sub_08001198(void)
{
    sub_0800DE80();
}
