#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_0800D808(u32 a);
extern void sub_0800D450(u32 a, u32 b);
extern void sub_0800D0F8(void);
extern void sub_08020C78(u32 a);
extern void sub_0802B9D4(void);
extern void sub_0802BA64(void);

void sub_0800D1F8(void)
{
    GameStuff *gs;
    u8 *base;
    u32 *counter;
    u32 diff;
    u8 threshold;
    u8 *ctr;
    u8 val;

    if (sub_0800679C((u8 *)&gIwram_6110, 3, 0) != 0) {
        gs = &gGameStuff;
        base = (u8 *)gEntities;
        counter = (u32 *)(base + 0xB1C);
        diff = gs->_unk00 - *counter;
        threshold = *(u8 *)(base + 0xB22);

        if (diff > threshold) {
            sub_0800D808(5);
            sub_0800D450(20, 10);
            sub_0800D0F8();
            sub_08020C78(0x38);

            ctr = base + 0xB20;
            val = *ctr;
            if (val <= 4) {
                *ctr = val + 1;
            }
            *counter = gs->_unk00;
        }
    }
    sub_0802B9D4();
    sub_0802BA64();
}
