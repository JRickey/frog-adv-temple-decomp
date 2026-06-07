#include "macros.h"
#include "game.h"
#include "types.h"

extern const u8 sEepromSignatureBlock[64];

extern void *Memcpy(void *dst, const void *src, u32 n);
extern u32 Eeprom_SetSizeConfig(u16 arg0);
extern u16 SaveReadBlocks(u16 *buf, u16 start, u8 count);
extern u16 SaveWriteBlocks(u16 *buf, u16 start, u8 count);

int SaveDetect(void)
{
    struct {
        u16 *p;
        u16 buf[4];
        u8 tmp[64];
    } s;
    u8 i;

    Memcpy(s.tmp, sEepromSignatureBlock, 64);

    i = 0;
    {
        u16 *q = s.buf;
        do {
            u16 *dst = q + i;
            *dst = ((u16 *)s.tmp)[i];
            i++;
        } while (i <= 3);
    }

    Eeprom_SetSizeConfig(4);
    Timer_SetIrqHandler(3, (void *)0x08017939);

    if (SaveReadBlocks(s.buf, 20, 1)) {
        if (SaveWriteBlocks(s.buf, 20, 1)) {
            return 1;
        }
    }
    return 0;
}
