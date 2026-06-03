#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 gIwram_53A0;

extern void sub_0800DB04(u32 *out, u32 idx);
extern void sub_0802BAF8(s32 a, s32 b, s32 c);
extern void sub_0802BB5C(s32 a, s32 b, s32 c);

void sub_0800D0F8(void)
{
    register u8 *base asm("r8");
    u8 *b1;
    u32 v0;
    u32 v1;
    s8 i;
    u8 x;
    u8 y;
    u8 *ep;
    u8 *tb;
    register u32 t asm("r4");
    register u32 next asm("r2");
    s8 j;
    u16 mask;
    u16 extra;
    s32 sx;
    s32 sy;

    x = 0;
    y = 0;
    i = 0;
    base = &gIwram_53A0;

    for (; i <= 63; i++) {
        b1 = &gIwram_53A0;
        if (b1[(s8)i] == 1 && (sx = (s8)x) <= 19) {
            sub_0800DB04(&v0, (u8)i);
            sub_0802BAF8(sx, (s16)v0, (s16)(v0 >> 16));
            x = (u8)(sx + 1);
        } else if (base[(s8)i] == 2 && (sy = (s8)y) <= 9) {
            sub_0800DB04(&v1, (u8)i);
            sub_0802BB5C(sy, (s16)v1, (s16)(v1 >> 16));
            y = (u8)(sy + 1);
        }
    }

    j = (s8)x;
    if (j <= 19) {
        tb = (u8 *)gEntities;
        ep = (u8 *)((u32)tb + (u32)((s8)x + 3) * 56);
        t = *(u16 *)(ep + 0x34);
        mask = 8;
        extra = 0;
        next = t;
        for (; j <= 19; j++) {
            next = t;
            next = next | mask;
            next = next | extra;
            t = next;
        }
        *(u16 *)(ep + 0x34) = next;
    }

    j = (s8)y;
    if (j <= 9) {
        tb = (u8 *)gEntities;
        ep = (u8 *)((u32)tb + (u32)((s8)y + 23) * 56);
        t = *(u16 *)(ep + 0x34);
        mask = 8;
        extra = 0;
        next = t;
        for (; j <= 9; j++) {
            next = t;
            next = next | mask;
            next = next | extra;
            t = next;
        }
        *(u16 *)(ep + 0x34) = next;
    }
}
