#include "iwram.h"
#include "types.h"

struct IwramAt6410 {
    u8 _pad00[8];
    u32 _field_08;
    u8 _maxFrames;
};

extern struct IwramAt6410 gIwram_6410;
extern u8 gIwram_53A0[];

void sub_080124D0(void)
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
