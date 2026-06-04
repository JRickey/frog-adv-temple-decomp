#include "game.h"
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

typedef void (*GameProc)(void);

extern const GameProc sEntityProcB[17];
extern const u8 sEntitySubtypeLut[];

/* sub_08009140 is declared void(void) in its own TU but the calling
 * convention here passes gEntities[0].x and .y as arguments — the callee
 * ignores r0/r1 (it reloads from pool immediately) but agbcc at the call
 * site still emits the ldrsh r0 / ldrsh r1 sequence. */
extern void sub_08009140(s16 x, s16 y);
extern void sub_0801A6D4(u8 countArg);
extern void sub_0800EBDC(u8 arg);
extern void sub_08009A58(void);
extern void sub_08009188(void);
extern void sub_0800A328(void);

extern u8 gIwram_5330;

void sub_0801B0AC(void)
{
    const GameProc *procs;
    GameStuff *base;
    u8 idx;
    u32 offset;

    sub_08009140(gEntities[0].x, gEntities[0].y);

    sub_0801A6D4(sEntitySubtypeLut[0]);
    sub_0800EBDC(2);

    procs = sEntityProcB;
    base = (GameStuff *)&gIwram_5330;
    idx = base->pendingMode;
    offset = ((u32)idx << 2) + (u32)procs;
    ((GameProc)(*(const u32 *)offset))();

    sub_08009A58();
    sub_08009188();
    sub_0800A328();
}

void sub_0801B0FC(u32 arg)
{
    /* r4 holds zero across four strh and one strb — prevents agbcc from
     * reloading a literal zero for each store. */
    register u32 zero asm("r4");
    vu16 *win;
    vu16 *dispcnt;
    u16 ctrl;
    u8 mode_val;

    mode_val = (u8)arg;

    win = (vu16 *)0x04000040;
    zero = 0;
    *win = zero;
    win += 2;
    *win = zero;
    win += 2;
    *win = zero;
    win += 1;
    *win = zero;

    /* 0x04000000 computed as 128<<19 keeps it out of the pool and produces the
     * baserom's movs r1, #128 / lsls r1, r1, #19 sequence. */
    dispcnt = (vu16 *)((u32)128 << 19);
    ctrl = *dispcnt;
    ctrl &= ~DISPCNT_WIN0_ON;
    *dispcnt = ctrl;
    ctrl = *dispcnt;
    ctrl &= ~DISPCNT_WIN1_ON;
    *dispcnt = ctrl;

    if (mode_val == 0)
        mode_val = 1;

    *(u8 *)0x03003540 = (u8)zero;
    gGameStuff.mode = mode_val + 7;
}
