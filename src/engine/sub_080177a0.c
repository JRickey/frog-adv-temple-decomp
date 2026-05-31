#include "macros.h"
#include "types.h"

extern int sub_080178FC(u16 *buf, u16 start, u8 count);

int sub_080177A0(u16 *dest)
{
    u16 buf[4];
    u8 i;

    if (sub_080178FC(buf, 0, 1)) {
        i = 0;
        do {
            dest[i] = buf[i];
            i++;
        } while (i <= 3);
        return 1;
    }
    return 0;
}
