#include "iwram.h"
#include "types.h"

extern u8 gIwram_53A0[];

void AnimChannels_Reset(void)
{
    struct IwramAt5360 *chA;
    struct IwramAt6150 *chB;

    chA = &gIwram_5360;
    chA->_field_04 = 0;
    chB = &gIwram_6150;
    chB->_field_04 = 0;
    chA->_maxFrames = 0;
    chA->_field_00 = 0;
    chB->_maxFrames = 0;
    chB->_field_00 = 1;
    gIwram_53A0[0xff] = 0;
    gIwram_6410._maxFrames = 8;
}
