#include "gba/io.h"
#include "iwram.h"
#include "types.h"

extern void sub_080100E4(u32, void *, void *);
extern void sub_08019A14(void);

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

/* clang-format off */
#define FIXED_ARG_U32(reg, expr) ({ register u32 _v asm(reg) = (expr); _v; })
#define FIXED_ARG_PTR(reg, expr) ({ register void *_v asm(reg) = (void *)(expr); _v; })
/* clang-format on */

u32 sub_08019E6C(void)
{
    register struct Unk03006420 *base asm("r4") = &gUnk03006420;

    if (base->active == 0) {
        sub_08019A14();
        return 0;
    }

    REG_DISPCNT = base->dispcnt;

    *(struct ScrollData *)0x03003550 = base->scroll;

    sub_080100E4(FIXED_ARG_U32("r0", 0), FIXED_ARG_PTR("r1", 0x80 << 18), FIXED_ARG_PTR("r2", 0x0600e000));
    sub_080100E4(FIXED_ARG_U32("r0", 1), FIXED_ARG_PTR("r1", 0x02010000), FIXED_ARG_PTR("r2", 0x0600e800));
    sub_080100E4(FIXED_ARG_U32("r0", 2), FIXED_ARG_PTR("r1", 0x02020000), FIXED_ARG_PTR("r2", 0x0600f000));
    sub_080100E4(FIXED_ARG_U32("r0", 3), FIXED_ARG_PTR("r1", 0x02030000), FIXED_ARG_PTR("r2", 0x0600f800));

    base->active = 0;
    return 1;
}
