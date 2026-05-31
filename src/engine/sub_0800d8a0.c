#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u32 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_0802C7EC(void);
extern void sub_0802CA64(void);
extern void sub_0802C000(void);
extern void sub_0802BF58(void);
extern void sub_0802CA70(void);

void sub_0800D8A0(void)
{
    register u8 *base6110 asm("r4");
    register u8 *saved6110 asm("r5");
    u8 *new_var;
    register u8 *base3720 asm("r4");
    register u8 *entry asm("r6");
    register u32 mask asm("r3");
    u32 c;
    s8 i;
    u8 *new_var2;
    u8 *ep;

    base6110 = (u8 *)&gIwram_6110;
    c = sub_0800679C(base6110, 3, 0) << 24;
    saved6110 = base6110;
    if (c != 0) {
        new_var2 = saved6110;
        i = 0;
        base3720 = (u8 *)&gIwram_3720;
        asm("" ::"r"(base3720));
        mask = 8;
        new_var = base3720;
        do {
            ep = (u8 *)((u32)((s8)i + 3) * 56 + (u32)new_var);
            *(u16 *)(ep + 0x34) = *(u16 *)(ep + 0x34) | mask;
            i++;
        } while (i <= 4);

        entry = new_var2;
        switch (*(u8 *)(entry + 0x33)) {
        case 0:
            sub_0802CA64();
            break;
        case 1:
            sub_0802C000();
            break;
        case 2:
            sub_0802BF58();
            break;
        case 3:
            sub_0802CA70();
            break;
        }
        return;
    }
    sub_0802C7EC();
}
