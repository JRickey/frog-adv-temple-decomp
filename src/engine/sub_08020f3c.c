#include "game.h"
#include "entity.h"
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

void EntityMover_Tick(u8 arg)
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
    if (CtrlFlags_ReadBitRange(&gIwram_6110, argReg, argReg) == 0)
        return;

    gsLo = &gGameStuff;
    base = (EntityMover *)gEntities;
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

        if ((gIwram_35E0._field_10 & 2) != 0 && argReg == gIwram_35E0.colliderTag) {
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

void Entity_UpdateMovers(s32 start, s32 end)
{
    EntityMover *base;
    GameStuff *gsLo;
    u8 *stampBasePtr;
    GameStuff *gsHi;
    s32 idx;
    s32 last;
    u32 arg8;
    u32 off;
    u32 elapsed;
    s32 stampOff;
    s32 xyOff;
    u8 interval;

    idx = start;
    last = end;
    if (CtrlFlags_ReadBitRange(&gIwram_6110, idx, last) == 0)
        return;

    gsLo = &gGameStuff;
    do {
        base = (EntityMover *)gEntities;
        arg8 = idx << 3;
        off = (arg8 - idx) << 3;
    } while (0);
    stampBasePtr = (u8 *)base + 0x2c;

    {
        u8 *stampBase = stampBasePtr;
        elapsed = gsLo->_unk00 - *(u32 *)(off + (u32)stampBase);
    }

    interval = *(u8 *)((off + (u32)base) + 0x32);
    gsHi = gsLo;
    if (elapsed < interval)
        return;
    if (idx > last)
        return;

    {
        EntityMover *mover;
        u32 *stampPtr;
        struct IwramAt35E0 *flags;
        u16 *xyPtr;

        mover = base;
        flags = &gIwram_35E0;
        stampOff = off + 0x2c;
        stampPtr = (u32 *)(stampOff + (u32)mover);
        xyOff = off + 2;
        xyPtr = (u16 *)(xyOff + (u32)mover);

        do {
            s32 dx;
            register s32 dy;

            dy = ((u8 *)stampPtr)[5];
            dx = ((s8 *)stampPtr)[4];
            xyPtr[0] += dx;
            dy <<= 24;
            dy >>= 24;
            xyPtr[1] += dy;

            {
                u32 active;

                active = 2;
                active &= flags->_field_10;
                if (active != 0 && idx == flags->colliderTag) {
                    mover->x += dx;
                    mover->y += dy;
                }
            }

            *stampPtr = gsHi->_unk00;
            stampPtr = (u32 *)((u32)stampPtr + 0x38);
            xyPtr = (u16 *)((u32)xyPtr + 0x38);
            idx++;
        } while (idx <= last);
    }
}
