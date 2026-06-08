#include "macros.h"
#include "gfx.h"
#include "types.h"

/* Declared as extern symbols (not cast literals) so agbcc does not fold
 * gIwram_6580 = gIwram_6500 + 0x80 into an add instruction. */
extern u8 gIwram_6500[];
extern u8 gIwram_6580[];

void Display_ResetLayers(void)
{
    /* The inner scope for b reproduces the baserom's interleaved pool-load
     * order (ldr first base, then movs r0, #0, strb, ldr second base). */
    u8 *a = (u8 *)0x03006540;
    u8 one;

    a[0] = 0;
    {
        u8 *b = (u8 *)0x03006480;
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
