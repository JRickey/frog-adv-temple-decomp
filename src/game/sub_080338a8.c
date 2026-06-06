#include "iwram.h"
#include "types.h"

#define gUnknown_030065E4     (*(const void **)0x030065e4)
#define sUnknown_082F8E98     ((const void *)0x082f8e98)
#define sSoundDmaBufCfg_Large ((const void *)0x082f8ea4)

u32 Eeprom_SetSizeConfig(u32 value)
{
    u32 ret;

    value = (u16)value;
    ret = 0;
    if (value == 4) {
        gUnknown_030065E4 = sUnknown_082F8E98;
    } else if (value == 0x40) {
        gUnknown_030065E4 = sSoundDmaBufCfg_Large;
    } else {
        gUnknown_030065E4 = sUnknown_082F8E98;
        ret = 1;
    }

    return ret;
}

void Eeprom_TickTimer(void)
{
    u32 timer;

    if (gIwram_3432 == 0) {
        return;
    }

    timer = gIwram_3432 - 1;
    gIwram_3432 = timer;
    if ((u16)timer == 0) {
        gIwram_3434 = 1;
    }
}
