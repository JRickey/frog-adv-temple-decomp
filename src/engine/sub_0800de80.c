#include "game.h"
#include "types.h"

extern void sub_0800DC50(void);
extern void sub_0800DD80(void);
extern void sub_0800DF7C(void);
extern void sub_0801BB54(u32 arg);
extern void sub_08020B88(u32 arg);
extern void sub_0802D8F8(void);

/* Mode-dispatched scene-step driver.
 *
 * Header: calls sub_0800DC50, sub_0800DF7C, sub_0802D8F8, then clears
 * bit 1 (mask 0xFD) of the byte at 0x03003570 (gStructAt3003570.flags
 * — see src/game/sub_08020b30.c).
 *
 * First dispatch on gGameStuff.pendingMode (1..16; out-of-range = no-op):
 *   modes 3, 6, 9, 12, 16 → sub_08020B88(1)
 *   all others 1..16     → sub_08020B88(2)
 *
 * Second dispatch on gGameStuff.pendingMode (1..16; out-of-range = no-op):
 *   modes 3, 6, 9, 12, 16 → sub_0801BB54(2)
 *   mode 15              → (skipped)
 *   all others 1..16     → sub_0801BB54(1)
 *
 * Tail: bl sub_0800DD80, return.
 *
 * Matching notes (old_agbcc):
 *   - gGameStuff base is cached across the three opening BLs so
 *     pendingMode materializes without a fresh pool load.
 *   - The second dispatch reads gGameStuff.pendingMode via the macro
 *     (fresh pool load), not via the cached pointer — baserom reloads
 *     the base address before the second ldrb.
 *   - Each switch uses an explicit dense 1..16 case list so old_agbcc
 *     keeps the `subs #1; cmp #15; bhi default; lsls #2; ldr table` jump
 *     table instead of folding the four active cases into an if-chain.
 *   - Within each switch the arg-2 case group is listed FIRST. That puts
 *     the arg-2 body at the lower-address jump-table target (matching
 *     baserom's 0x0800def8 = arg=2, 0x0800df00 = arg=1).
 *   - The flags-clear is written `t = 0xFD; t &= p->flags; p->flags = t;`
 *     giving baserom's `ldr r1, =0x03003570; movs r0, #253;
 *     ldrb r2, [r1]; ands r0, r2; strb r0, [r1]` shape.
 */

typedef struct {
    u8 flags;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

void sub_0800DE80(void)
{
    GameStuff *g;
    u8 t;

    g = &gGameStuff;

    sub_0800DC50();
    sub_0800DF7C();
    sub_0802D8F8();

    {
        StructAt3003570 *p1 = &gStructAt3003570;
        t = 0xFD;
        t &= p1->flags;
        p1->flags = t;
    }

    switch (g->pendingMode) {
    case 1:
    case 2:
    case 4:
    case 5:
    case 7:
    case 8:
    case 10:
    case 11:
    case 13:
    case 14:
    case 15:
        sub_08020B88(2);
        break;
    case 3:
    case 6:
    case 9:
    case 12:
    case 16:
        sub_08020B88(1);
        break;
    default:
        break;
    }

    switch (gGameStuff.pendingMode) {
    case 1:
    case 2:
    case 4:
    case 5:
    case 7:
    case 8:
    case 10:
    case 11:
    case 13:
    case 14:
        sub_0801BB54(1);
        break;
    case 3:
    case 6:
    case 9:
    case 12:
    case 16:
        sub_0801BB54(2);
        break;
    case 15:
        break;
    default:
        break;
    }

    sub_0800DD80();
}
