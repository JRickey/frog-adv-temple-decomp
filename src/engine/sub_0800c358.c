#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_0800A910(void);

/* agbcc register layout: mode stays in r4 throughout; cases 20/21 load
 * the base pointer into r5; case 22 repurposes r4 (mode is no longer
 * needed) for the base pointer. The register pin forces that split. */
void sub_0800C358(u8 mode)
{
    u8 *base;

    if (mode == 20) {
        base = (u8 *)0x03006110;
        if (sub_0800679C(base, 5, 0) == 0) {
            sub_08006600(base, 5, 0);
            sub_0800A910();
        }
    }

    if (mode == 21) {
        base = (u8 *)0x03006110;
        if (sub_0800679C(base, 5, 1) == 0) {
            sub_08006600(base, 5, 1);
            sub_0800A910();
        }
    }

    if (mode == 22) {
        register u8 *base4 asm("r4") = (u8 *)0x03006110;
        if (sub_0800679C(base4, 5, 3) != 0) {
            if (sub_0800679C(base4, 5, 2) == 0) {
                sub_08006600(base4, 5, 2);
                sub_0800A910();
            }
        }
    }
}

/* agbcc register layout: case 20 loads base into r5; case 21 loads base
 * into r4 (r5 is still live from the previous block). The register pin for
 * case 21 forces agbcc to use r4 instead of spilling to r5. */
void sub_0800C3E4(u8 mode)
{
    if (mode == 20) {
        u8 *base = (u8 *)0x03006110;
        if (sub_0800679C(base, 5, 0) == 0) {
            sub_08006600(base, 5, 0);
        }
    }

    if (mode == 21) {
        register u8 *base4 asm("r4") = (u8 *)0x03006110;
        if (sub_0800679C(base4, 5, 0) != 0) {
            if (sub_0800679C(base4, 5, 1) == 0) {
                sub_08006600(base4, 5, 1);
            }
        }
    }
}
