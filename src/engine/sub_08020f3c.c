#include "game.h"
#include "iwram.h"
#include "types.h"

typedef struct EntityMover {
    u8 _pad00[2];
    u16 x;
    u16 y;
    u8 _pad06[0x26];
    u32 stamp;
    s8 dx;
    u8 dy;
    u8 interval;
    u8 _pad33[5];
} EntityMover;

extern long long sub_08006830(struct IwramAt6110 *p, u8 a, u8 b);

void sub_08020F3C(u8 arg)
{
    register EntityMover *base asm("r3");
    EntityMover *e;
    GameStuff *gsLo;
    GameStuff *gsHi;
    register u32 argReg asm("r6");
    u32 arg8;
    u32 off;
    u32 elapsed;
    u8 interval;

    argReg = arg;
    if (sub_08006830(&gIwram_6110, argReg, argReg) == 0)
        return;

    gsLo = &gGameStuff;
    base = (EntityMover *)&gIwram_3720;
    arg8 = argReg << 3;
    off = (arg8 - argReg) << 3;

    {
        u8 *stampBase = (u8 *)base + 0x2c;
        elapsed = gsLo->_unk00 - *(u32 *)(off + (u32)stampBase);
    }

    e = (EntityMover *)((u8 *)base + off);
    interval = e->interval;
    gsHi = gsLo;
    if (elapsed < interval)
        return;

    {
        s32 dx;
        register s32 dy asm("r1");
        u8 *eBytes;
        u8 *dxAddr;
        u32 coord;
        u32 sum;

        eBytes = (u8 *)e;
        dxAddr = (u8 *)e + 0x30;
        eBytes += 0x31;
        dy = *eBytes;
        dx = *(s8 *)dxAddr;
        e->x += dx;
        dy = (dy << 24) >> 24;
        e->y += dy;

        if ((gIwram_35E0._field_10 & 2) != 0 && argReg == gIwram_35E0._field_D) {
            coord = base->x;
            sum = coord + dx;
            base->x = sum;
            coord = base->y;
            sum = coord + dy;
            base->y = sum;
        }
    }

    {
        register u32 finalOff asm("r0");
        register u8 *stampBase asm("r1");
        GameStuff *gs;
        u32 *stamp;

        finalOff = (arg8 - argReg) << 3;
        stampBase = (u8 *)base;
        stampBase += 0x2c;
        stamp = (u32 *)(finalOff + (u32)stampBase);
        gs = gsHi;
        *stamp = gs->_unk00;
    }
}
