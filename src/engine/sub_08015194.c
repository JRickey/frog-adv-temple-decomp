#include "types.h"
#include "gfx.h"

extern u8 gIwram_6540[];
extern u8 gIwram_6480[];
extern u8 gIwram_6500[];
extern u8 gIwram_6580[];
extern u8 gIwram_64C0[];
extern u8 gIwram_3610[];

void ScrollBlit_ResetLayers(void)
{
    gIwram_6540[8] = 0;
    gIwram_6480[8] = 0;
    gIwram_6500[8] = 0;
    gIwram_6580[8] = 0;
    gIwram_6540[0] = 0;
    gIwram_6480[0] = 0;
    gIwram_6500[0] = 0;
    gIwram_6580[0] = 0;
    gIwram_64C0[0xA] = 0;

    *(u16 *)(gIwram_6540 + 0x36) = 0;

    gIwram_3610[0] = 0;
    gIwram_3610[0xA] = 0;
    gIwram_3610[2] = 0;
    gIwram_3610[4] = 0;

    *(u16 *)(gIwram_6540 + 0x34) = 0;
    *(u16 *)(gIwram_6480 + 0x36) = 0xC0;
    gIwram_6540[0xB] = 0;
    gIwram_6480[0xB] = 4;
    gIwram_6540[9] = 0;
    gIwram_6480[9] = 2;

    /* Force BG1/BG2 (REG_BG1CNT/REG_BG2CNT) to priority 1/2: clear the low
     * two priority bits, then OR in the new priority. The `val` temporary
     * pins the first ldrh ahead of the mask pool-load to match the baserom
     * instruction order. */
    {
        vu16 *reg = (vu16 *)0x0400000A;
        u16 val = *reg;
        u16 mask = 0xFFFC;
        *reg = val & mask;
        *reg = *reg | 1;
        reg++;
        *reg = *reg & mask;
        *reg = *reg | 2;
    }
}
