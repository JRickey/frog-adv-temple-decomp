#include "gba/io.h"
#include "iwram.h"
#include "types.h"

extern void sub_080228FC(void);
extern void sub_08022758(void);
extern void sub_080227DC(void);
extern void sub_080228AC(void);
extern void sub_08022A28(void);
extern void sub_0802277C(void);
extern void sub_080229F0(void);
extern void sub_08022800(void);
extern void sub_08022434(void);
extern void sub_08022160(void);
extern void sub_08022920(void);
extern void sub_08022AC8(void);
extern void sub_08022958(void);
extern void sub_080229A4(void);

void sub_08022B4C(void)
{
    gIwram_6110.liveCount = 0;
    sub_080228FC();
    sub_08022758();
    sub_080227DC();
    sub_080228AC();
    sub_08022A28();
    sub_0802277C();
    sub_080229F0();
    sub_08022800();
    sub_08022434();
    sub_08022160();
    sub_08022920();
    sub_08022AC8();
}

void sub_08022B90(void)
{
    REG_DISPCNT |= DISPCNT_OBJ_ON;
    sub_08022958();
    sub_080229A4();
}
