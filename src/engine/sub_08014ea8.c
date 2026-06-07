#include "macros.h"
#include "gfx.h"
#include "types.h"

/* Declared as extern symbols (not cast literals) so agbcc does not fold
 * gIwram_6580 = gIwram_6500 + 0x80 into an add instruction. */
extern u8 gIwram_6500[];
extern u8 gIwram_6580[];

void Display_ResetLayers(void)
{
    /* r3/r2 pins + inner scope for b: reproduce baserom's interleaved
     * pool-load order (ldr r3 first, then movs r0, #0, strb, ldr r2). */
    register u8 *a asm("r3") = (u8 *)0x03006540;
    register u8 one asm("r1");

    a[0] = 0;
    {
        register u8 *b asm("r2") = (u8 *)0x03006480;
        b[0] = 0;
        one = 1;
        a[8] = one;
        b[8] = one;
    }
    gIwram_6500[8] = one;
    gIwram_6580[8] = one;
    BgLayer_Disable(2);
    *(u8 *)0x03003610 = 4;
}
