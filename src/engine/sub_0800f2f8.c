#include "iwram.h"
#include "types.h"

struct SceneScrollState_F2F8 {
    u8 _pad00[12];
    s32 scrollX;
    s32 scrollY;
    u16 bgHofs;
    u16 bgVofs;
    u16 tileHeight;
    u16 tileWidth;
    u8 _pad1c[4];
};

void sub_0800F2F8(u8 direction, u8 channel)
{
    u8 ch = channel;

    switch (ch) {
    case 0:
        if (direction == 0) {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct SceneScrollState_F2F8 *ss = (struct SceneScrollState_F2F8 *)0x030060A0;
            r->_data[0] = ss->bgHofs;
        } else {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct SceneScrollState_F2F8 *ss = (struct SceneScrollState_F2F8 *)0x030060A0;
            r->_data[1] = ss->bgVofs;
        }
        break;
    case 1:
        if (direction == 0) {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct SceneScrollState_F2F8 *ss = (struct SceneScrollState_F2F8 *)0x030060A0;
            r->_data[2] = (ss + 1)->bgHofs;
        } else {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct SceneScrollState_F2F8 *ss = (struct SceneScrollState_F2F8 *)0x030060A0;
            r->_data[3] = (ss + 1)->bgVofs;
        }
        break;
    case 2:
        if (direction == 0) {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct SceneScrollState_F2F8 *ss = (struct SceneScrollState_F2F8 *)0x030060A0;
            asm("" : "+r"(ss));
            ss += 2;
            r->_data[4] = ss->bgHofs;
        } else {
            struct IwramAt3550 *r = (struct IwramAt3550 *)0x03003550;
            struct SceneScrollState_F2F8 *ss = (struct SceneScrollState_F2F8 *)0x030060A0;
            asm("" : "+r"(ss));
            ss += 2;
            r->_data[5] = ss->bgVofs;
        }
        break;
    }
}
