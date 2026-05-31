#include "macros.h"
#include "types.h"

extern void sub_080100E4(u32, void *, void *);

struct BlitState {
    u8 _pad00[26];
    u16 stride;
};

void sub_08012BC4(u32 flags, u32 dstX, u32 dstY, u32 widthArg, u32 srcRowsArg, const u16 **srcTable, u32 srcIndex)
{
    register u32 f asm("ip");
    register u32 x asm("r9");
    u32 y;
    u32 rows;
    register u32 width asm("r6");
    register u32 index asm("r8");
    u16 *dst;
    u16 *state;
    register u16 stride asm("r1");
    const u16 *src;
    register u32 bank asm("r5");
    register void *flushSrc asm("r2");
    register void *flushDst asm("r3");
    register u32 row asm("r0");
    register u32 nextRow asm("r4");
    u32 scratch;
    u8 col;

    f = flags << 24;
    x = (u16)dstX;
    y = (u16)dstY;
    width = (u8)widthArg;
    rows = (u8)srcRowsArg;
    index = (u8)srcIndex;
    if ((f >> 28) & 1) {
        dst = (u16 *)0x02010000;
    } else {
        dst = (u16 *)0x02000000;
    }

    state = (u16 *)0x030060A0;
    stride = state[13];
    dst += stride * y + x;
    scratch = index;
    src = srcTable[scratch];
    row = 0;
    bank = f >> 28;
    if (row < rows) {
        register u32 loopState asm("ip") = (u32)state;

        do {
            col = 0;
            nextRow = row + 1;
            if (col < width) {
                do {
                    *dst++ = *src++;
                    col++;
                } while (col < width);
            }
            {
                scratch = loopState;
                scratch = ((struct BlitState *)scratch)->stride;
                dst += scratch - width;
            }
            row = (u8)nextRow;
        } while (row < rows);
    }

    {
        register u32 one asm("r1");

        one = 1;
        if (bank & one) {
            flushSrc = (void *)0x02010000;
            flushDst = (void *)0x0600E800;
        } else {
            flushSrc = (void *)0x02000000;
            flushDst = (void *)0x0600E000;
        }
    }
    {
        register u32 one asm("r0");

        one = 1;
        bank = (bank & one) + scratch - scratch;
    }
    sub_080100E4(bank, flushSrc, flushDst);

    {
        u8 *sentinel = (u8 *)0x030064C0;

        sentinel[10] = 0;
    }
    if (index == 0) {
        *(u8 *)0x03003610 = 1;
    }
}
