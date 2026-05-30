#include "game.h"
#include "iwram.h"
#include "types.h"

extern const u32 sEntityParamTable[17];
extern void sub_08020BAC(void);
extern void sub_08020B88(u32 arg);

void sub_0800A1C8(void)
{
    u8 m;
    u32 value;
    GameStuff *p;

    p = &gGameStuff;

    m = p->pendingMode;
    if ((u8)(m % 3) == 0)
        return;
    if (m == 16)
        return;

    value = 0;
    sub_08020BAC();
    if (gIwram_6110._field_32 == 1) {
        const u32 *table = sEntityParamTable;
        /* Reuse the now-dead base pointer so agbcc overwrites r5 with the table index. */
        p = (GameStuff *)(u32)p->pendingMode;
        value = table[(u32)p];
    }
    sub_08020B88(value);
}

int sub_0800A214(void)
{
    /* result pinned to r5 so the &gGameStuff pointer lands in r4 — baserom
     * keeps the base live across both BLs; the natural allocation swaps r4/r5. */
    register int result asm("r5");
    GameStuff *p = &gGameStuff;

    switch (p->_unk00 % 3) {
    case 0:
        result = 13;
        break;
    case 1:
        result = 8;
        break;
    case 2:
        result = 18;
        break;
    }

    if ((u8)(p->pendingMode - 15) <= 1)
        result = 7;

    sub_08020BAC();
    return result;
}

void sub_0800A258(u32 arg)
{
    sub_08020BAC();
    sub_08020B88(arg);
}

typedef void (*GameProc)(void);

extern const GameProc sEntityProcB[17];
extern const GameProc sEntityProcC[17];
extern const u8 sEntitySubtypeLut[20];

extern void sub_0800A520(void);
extern void sub_0800F24C(u8 arg);
extern void sub_08009A58(void);
extern void sub_08009188(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);

extern u8 gIwram_5330;

void sub_0800A26C(void)
{
    struct IwramAt6110 *s = &gIwram_6110;
    register const GameProc *t1 asm("r1");
    register GameStuff *base asm("r4");
    register u8 idx asm("r2");
    register u32 offset asm("r0");

    s->_field_14 = -1;
    s->_field_1c = -1;

    sub_0800A520();

    /* sEntityProcB dispatch — t1 loads first (r1), then base (r4).
     * idx (r2) holds pendingMode temporarily; shift and add route through r0
     * to match the baserom's lsls r0,r2,#2 + adds r0,r0,r1 encoding. */
    t1 = sEntityProcB;
    base = (GameStuff *)&gIwram_5330;
    idx = base->pendingMode;
    offset = ((u32)idx << 2) + (u32)t1;
    ((GameProc)(*(const u32 *)offset))();

    t1 = sEntityProcC;
    idx = base->pendingMode;
    offset = ((u32)idx << 2) + (u32)t1;
    ((GameProc)(*(const u32 *)offset))();

    {
        register const u8 *lut asm("r0");
        register u32 lastidx asm("r4");
        lut = sEntitySubtypeLut;
        lastidx = base->pendingMode;
        sub_0800F24C(*(const u8 *)(lastidx + (u32)lut));
    }

    sub_08009A58();
    sub_08009188();
    sub_080008DC();
    sub_0800A328();
}
