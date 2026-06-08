#include "iwram.h"
#include "types.h"

struct IwramAt6410 {
    u8 _pad00[8];
    u32 _field_08;
    u8 _maxFrames;
};

extern struct IwramAt6410 gIwram_6410;
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
