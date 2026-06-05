#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800F398(u8 arg);
extern void sub_0800F814(u8 arg);

void sub_0800FCC8(u8 arg)
{
    sub_0800F814(arg);
    sub_0800F398(arg);
}

/* Switch returns a fixed EWRAM bank pointer. Default case is unreachable
 * in practice; baserom leaves r2 untouched and returns it as-is, so the
 * return value pins to r2 and is left undefined in default. */
void *sub_0800FCE4(u8 idx)
{
    void *ret;
    switch (idx) {
    case 0:
        ret = (void *)0x02000000;
        break;
    case 1:
        ret = (void *)0x02010000;
        break;
    case 2:
        ret = (void *)0x02020000;
        break;
    }
    return ret;
}

void *sub_0800FD18(u8 idx)
{
    void *ret;
    switch (idx) {
    case 0:
        ret = (void *)0x0600E000;
        break;
    case 1:
        ret = (void *)0x0600E800;
        break;
    case 2:
        ret = (void *)0x0600F000;
        break;
    }
    return ret;
}
