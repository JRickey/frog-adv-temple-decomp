#include "iwram.h"
#include "types.h"

struct IwramAt6410 {
    u8 _pad00[8];
    u32 _field_08;
    u8 _maxFrames;
};

extern struct IwramAt6410 gIwram_6410;
extern struct BgScrollState gIwram_60A0[3];
extern u8 gIwram_53A0[];

void AnimChannels_Reset(void)
{
    struct ScrollAnimChannel *chA;
    struct ScrollAnimChannel *chB;

    chA = &gIwram_5360;
    chA->scrollPos = 0;
    chB = &gIwram_6150;
    chB->scrollPos = 0;
    chA->maxFrames = 0;
    chA->animState = 0;
    chB->maxFrames = 0;
    chB->animState = 1;
    gIwram_53A0[0xff] = 0;
    gIwram_6410._maxFrames = 8;
}

void sub_08012504(u16 height, u16 width, const u16 *src, u16 *dst)
{
    u16 row;
    u16 col;

    for (row = 0; row < height; row++) {
        for (col = 0; col < width; col++) {
            *dst = *src;
            src++;
            dst++;
        }
        dst = (u16 *)((u8 *)dst + ((gIwram_60A0[0].tileCols - width) << 1));
    }
}
