#include "types.h"

extern void *sub_0803578C(void *dst, const void *src, u32 n);
extern void sub_080196EC(u32 *attr, const void *src, u8 arg2);
extern void sub_080184DC(u32 *attr, u16 arg1, u16 arg2, u8 arg3);
extern int sub_0801F970(u8 arg0);

int sub_0801F8BC(u8 arg0)
{
    struct {
        u8 name[10];
        u8 pad[2];
        u32 attr;
    } s;

    sub_0803578C(s.name, (const void *)0x081BE804, 10);

    {
        u32 mask = 0xffffff00;
        s.attr = (s.attr & mask) | 0x02;
    }
    s.attr = (s.attr & 0xffff00ff) | 0x0300;
    s.attr = (s.attr & 0x00ffffff) | 0x04000000;
    s.attr = (s.attr & 0xff00ffff) | 0x001a0000;

    switch (arg0) {
    case 0:
        s.attr = (s.attr & 0xffff00ff) | 0x0300;
        break;
    case 1:
        s.attr = (s.attr & 0xffff00ff) | 0x0700;
        break;
    case 2:
        s.attr = (s.attr & 0xffff00ff) | 0x0b00;
        break;
    case 3:
        s.attr = (s.attr & 0xffff00ff) | 0x0f00;
        break;
    }

    sub_080196EC(&s.attr, (const void *)0x081D8398, 2);
    sub_080184DC(&s.attr, 5, 4, 2);
    return sub_0801F970(arg0);
}
