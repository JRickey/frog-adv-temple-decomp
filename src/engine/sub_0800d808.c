#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 gIwram_53A0;
extern u8 gIwram_3610;

void PadGrid_RemoveRandom(u32 a)
{
    u8 *slots;
    register u8 *idx1 asm("r2");
    register u8 *slots1 asm("r5");
    u8 *ibuf;
    u8 *base;
    s16 count;
    s32 i;
    s32 j;
    volatile u8 rnd;
    volatile u8 *rndp;
    u8 n;

    n = (u8)a;
    count = 0;
    i = 0;
    slots1 = &gIwram_53A0;
    idx1 = &gIwram_3610;
    for (; i <= 63; i++) {
        if (*(u8 *)((s32)i + (s32)slots1) != 0) {
            *(u8 *)((s32)count + (s32)idx1) = i;
            count++;
        }
    }

    {
        s8 m = (s8)n;
        i = 0;
        if (!(i < m)) {
            return;
        }
    }

    rndp = &rnd;
    slots = &gIwram_53A0;
    ibuf = &gIwram_3610;
    do {
        s32 next;

        *rndp = RandRange(count);
        slots[ibuf[*rndp]] = 0;
        count = 0;
        j = 0;
        next = i + 1;
        for (; j <= 63; j++) {
            base = slots;
            if (*(u8 *)((s32)j + (s32)base) != 0) {
                *(u8 *)((s32)count + (s32)ibuf) = j;
                count++;
            }
        }
        i = next;
    } while (i < (s8)n);
}
