#include "macros.h"
#include "types.h"

extern void ModeChannel_Apply(u8 arg0, u8 arg1);

extern u8 gIwram_6410[];
extern u8 gIwram_6400[];
extern u8 gIwram_6480[];
extern u8 gIwram_60A0[];

void BgScrollAnim_Init(void)
{
    register u8 val asm("r1");

    gIwram_6410[12] = 8;
    gIwram_6410[0] = 4;
    gIwram_6400[12] = 16;
    gIwram_6400[0] = 2;
    gIwram_6480[0] = 1;
    gIwram_6480[10] = 0;
    val = gIwram_60A0[0x40];
    val |= 1;
    gIwram_60A0[0x40] = val;
    ModeChannel_Apply(4, 4);
}
