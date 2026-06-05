#include "iwram.h"
#include "types.h"

extern void sub_0802321C(void);
extern void sub_080233D4(void);
extern void sub_08022F4C(void);
extern void sub_08023334(void);
extern void sub_08023384(void);
extern void sub_08022EA8(void);
extern void sub_080231F4(void);
extern void sub_08022CD4(void);
extern void sub_08022D4C(void);
extern void sub_0802349C(void);
extern void sub_080234E8(void);

extern const u32 sLevelLayout_3120D8[24];

void sub_08023538(void)
{
    u8 i;

    i = 0;
    do {
        u32 *dst = (u32 *)((u8 *)0x03003570 + (u32)i * 8);
        const u32 *src = sLevelLayout_3120D8 + (u32)i * 2;
        u32 w1 = src[1];
        u32 w0 = src[0];
        dst[1] = w0;
        dst[2] = w1;
        i++;
    } while (i <= 11);

    sub_0802321C();
    sub_080233D4();
    sub_08022F4C();
    sub_08023334();
    sub_08023384();
    sub_08022EA8();
    sub_080231F4();
    sub_08022CD4();
    sub_08022D4C();
    sub_0802349C();
    sub_080234E8();
}
