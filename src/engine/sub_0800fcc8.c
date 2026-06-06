#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void ScrollUpdate_Pass1(u8 arg);
extern void ScrollUpdate_Pass0(u8 arg);

void Scroll_RunSubtypeTicks(u8 arg)
{
    ScrollUpdate_Pass0(arg);
    ScrollUpdate_Pass1(arg);
}

/* Switch returns a fixed EWRAM bank pointer. Default case is unreachable
 * in practice; baserom leaves r2 untouched and returns it as-is, so the
 * return value pins to r2 and is left undefined in default. */
void *GetEwramBuffer(u8 idx)
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

void *GetVramTilemapBuffer(u8 idx)
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
