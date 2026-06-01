#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

void sub_08002450(void)
{
    ModeControl_Init(&gIwram_6110, 0x19, 7, (const void *)0x082f9bf0, 1, 0);
    sub_0800CE98(7, 0);
    sub_08009CBC();
}

typedef void (*GameProc)(void);

extern const GameProc sEntityProcB[17];
extern const GameProc sEntityProcD[17];

extern void sub_0800A520(void);
extern void sub_08009A58(void);
extern void sub_08009188(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08001E24(void *obj, void *r4_obj);

void sub_08002484(void *arg0, void *arg1)
{
    GameStuff *g;

    sub_0800A520();

    {
        const GameProc *procs = sEntityProcB;
        register u8 id asm("r2");
        register u32 offset asm("r0");

        g = &gGameStuff;
        id = g->pendingMode;
        offset = id << 2;
        offset += (u32)procs;
        (*(GameProc *)offset)();
    }

    {
        const GameProc *procsD = sEntityProcD;
        register u8 id asm("r2");
        register u32 offset asm("r0");

        id = g->pendingMode;
        offset = id << 2;
        offset += (u32)procsD;
        (*(GameProc *)offset)();
    }

    sub_08009A58();
    sub_08009188();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    sub_08001E24(arg0, arg1);
    g->_unk14++;
}

extern u32 sub_08009C14(u8 *state);
extern void sub_0802AB64(void);

void sub_080024E4(u8 *state)
{
    u8 *base;
    u32 zero;
    u8 *addr;

    if (sub_08009C14(state) == 0)
        *state = 8;
    base = (u8 *)0x03006110;
    addr = base + 42;
    zero = 0;
    *addr = (u8)zero;
    *(u16 *)(base + 12) = (u16)zero;
    if (*(base + 43) == 1)
        sub_0802AB64();
}
