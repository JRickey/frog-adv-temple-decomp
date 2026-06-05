#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern int sub_0801185C(u8 arg);
extern void sub_08020C78(u32 arg);
extern u8 gIwram_3610;
extern u8 gIwram_5330;
extern u8 gIwram_53A0;

void sub_08019964(void)
{
    gGameStuff.rngSeed = sub_0801185C(200);
    gIwram_34A0.dispatchIdx = 2;
}

void sub_08019984(void)
{
    u8 *src;

    src = &gIwram_53A0;
    if (src[14] != 0) {
        u8 *state;

        state = &gIwram_5330;
        state[16] = 0;
        sub_08020C78(1);
        return;
    }

    {
        u8 i;
        u8 *state;
        u8 *src2;
        u8 *cmp;

        i = 0;
        state = &gIwram_5330;
        src2 = src;
        cmp = &gIwram_3610;
        do {
            u8 *srcByte;
            u8 *cmpByte;

            srcByte = (u8 *)(i + (u32)src2);
            cmpByte = (u8 *)(i + (u32)cmp);
            if (*srcByte != *cmpByte) {
                state[16] = 0;
                sub_08020C78(1);
                return;
            }
            i++;
        } while (i <= 11);

        state[16] = 1;
        sub_08020C78(13);
    }
}
