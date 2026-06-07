#include "iwram.h"
#include "types.h"

void SaveBgScrollOffset(u8 direction, u8 channel)
{
    u8 ch = channel;

    switch (ch) {
    case 0:
        if (direction == 0) {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct BgScrollState *ss = (struct BgScrollState *)0x030060A0;
            r->_data[0] = ss->bgHofs;
        } else {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct BgScrollState *ss = (struct BgScrollState *)0x030060A0;
            r->_data[1] = ss->bgVofs;
        }
        break;
    case 1:
        if (direction == 0) {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct BgScrollState *ss = (struct BgScrollState *)0x030060A0;
            r->_data[2] = (ss + 1)->bgHofs;
        } else {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct BgScrollState *ss = (struct BgScrollState *)0x030060A0;
            r->_data[3] = (ss + 1)->bgVofs;
        }
        break;
    case 2:
        if (direction == 0) {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct BgScrollState *ss = (struct BgScrollState *)0x030060A0;
            asm("" : "+r"(ss));
            ss += 2;
            r->_data[4] = ss->bgHofs;
        } else {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct BgScrollState *ss = (struct BgScrollState *)0x030060A0;
            asm("" : "+r"(ss));
            ss += 2;
            r->_data[5] = ss->bgVofs;
        }
        break;
    }
}
