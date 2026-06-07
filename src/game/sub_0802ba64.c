#include "game.h"
#include "entity.h"
#include "iwram.h"
#include "types.h"

extern int __divsi3(int num, int den);
extern u8 TileMap_GetCell(u32 x, u32 y);

void FrogGoal_UpdateEntities(void)
{
    u32 hiMask;
    u32 d[2];
    u32 desc0;
    u32 z;
    u8 arg5;
    void *control;
    s32 i;
    s16 *ep;
    u8 *base;

    hiMask = 0xffff0000;
    desc0 = d[0];
    desc0 &= hiMask;
    desc0 |= 10;
    desc0 &= 0xffff;
    d[0] = desc0;
    d[1] &= hiMask;

    base = (u8 *)gEntities;
    z = 0;
    ep = (s16 *)(base + 0x50a);
    for (i = 9; i >= 0; i--) {
        s32 tx = (s16)__divsi3(ep[0], 24);
        s32 ty = (s16)__divsi3(ep[1], 24);
        u8 result = (u8)TileMap_GetCell(tx, ty);

        if (result != 2) {
            u16 st = 8;
            st |= *(u16 *)((u8 *)ep + 0x32);
            st |= 4;
            *(u16 *)((u8 *)ep + 0x32) = st;
        }

        ep = (s16 *)((u8 *)ep + 0x38);
    }

    arg5 = z;
    control = &gIwram_6110;
    Entity_WalkCompactRecords(23, d, 0x57, control, arg5);
}
