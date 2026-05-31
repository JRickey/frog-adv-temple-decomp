#include "macros.h"
#include "types.h"

extern const u8 sEepromSignatureBlock[64];

extern void *sub_0803578C(void *dst, const void *src, u32 n);
extern u32 sub_080338A8(u16 arg0);
extern u32 sub_08033910(u8 idx, void *out);
extern u16 sub_080178FC(u16 *buf, u16 start, u8 count);
extern u16 sub_0801789C(u16 *buf, u16 start, u8 count);

int sub_080172F4(void)
{
    struct {
        u16 *p;
        u16 buf[4];
        u8 tmp[64];
    } s;
    u8 i;

    sub_0803578C(s.tmp, sEepromSignatureBlock, 64);

    i = 0;
    {
        u16 *q = s.buf;
        do {
            u16 *dst = q + i;
            *dst = ((u16 *)s.tmp)[i];
            i++;
        } while (i <= 3);
    }

    sub_080338A8(4);
    sub_08033910(3, (void *)0x08017939);

    if (sub_080178FC(s.buf, 20, 1)) {
        if (sub_0801789C(s.buf, 20, 1)) {
            return 1;
        }
    }
    return 0;
}
