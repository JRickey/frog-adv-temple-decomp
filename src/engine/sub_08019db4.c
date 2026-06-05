#include "gba/io.h"
#include "types.h"

extern void sub_080100E4(u32, void *, void *);

struct ScrollData {
    u32 f0;
    u32 f1;
    u32 f2;
    u32 f3;
};

struct Unk03006420 {
    u32 active;
    u16 dispcnt;
    u16 _pad;
    struct ScrollData scroll;
};

extern struct Unk03006420 gUnk03006420;

void sub_08019DB4(void)
{
    REG_DISPCNT = gUnk03006420.dispcnt;

    *(struct ScrollData *)0x03003550 = gUnk03006420.scroll;

    sub_080100E4(0, (void *)(0x80 << 18), (void *)0x0600e000);
    sub_080100E4(1, (void *)0x02010000, (void *)0x0600e800);
    sub_080100E4(2, (void *)0x02020000, (void *)0x0600f000);
    sub_080100E4(3, (void *)0x02030000, (void *)0x0600f800);

    gUnk03006420.active = 0;
}

void sub_08019E28(s32 bg)
{
    switch (bg) {
    case 0:
        REG_DISPCNT = DISPCNT_BG0_ON;
        break;
    case 1:
        REG_DISPCNT = DISPCNT_BG1_ON;
        break;
    case 2:
        REG_DISPCNT = DISPCNT_BG2_ON;
        break;
    case 3:
        REG_DISPCNT = DISPCNT_BG3_ON;
        break;
    }
}
