#include "game.h"
#include "types.h"

extern u32 sub_08000900(void);

struct StructA0C {
    u8 _pad00[16];
    u16 _field_10;
    u16 _field_12;
    u32 _field_14;
};

u8 sub_08006A0C(struct StructA0C *p, u16 key)
{
    int field = p->_field_10;
    int val = field & 8;
    register int flag asm("r0");
    register int active asm("r0");

    flag = val ? ((val | 1) & 1) : 0;
    active = flag;

    if (active) {
        if (key == 16) {
            p->_field_12 = key;
            {
                int v = 9;
                p->_field_10 &= -v;
            }
            return 1;
        }

        if (sub_08000900() - p->_field_14 > 30) {
            int v = 9;
            p->_field_10 &= -v;
            return 0;
        }
    }

    if (key == 16) {
        p->_field_10 |= 8;
        p->_field_14 = gGameStuff._unk00;
    }

    return 0;
}
