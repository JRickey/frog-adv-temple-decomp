#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 sub_0800CE10(u8 a, u8 b, s16 c, s16 d);
extern void sub_0800E600(u32 a);
extern void sub_080008DC(void);
extern u32 sub_0800FD50(void);
extern u8 sub_08009BA0(void);
extern void sub_0800A540(void);
extern void sub_08020C78(u32 a);

void sub_08009884(u8 arg)
{
    u8 cls;
    s32 t;

    if (gIwram_3720._field_34 & 4)
        return;

    cls = sub_0800CE10(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);

    /* The widen-then-subtract split (not `t = arg - 30`) anchors r6/r5 the way
       old_agbcc allocates them here; the single-statement form mis-colours. */
    t = arg;
    t = t - 30;
    if (cls == 3) {
        if ((s8)gIwram_35E0._data[4] >= gIwram_6110.threshold) {
            gIwram_35E0._field_10 |= 0x100;
        } else {
            u8 mod = gGameStuff.pendingMode % 3;
            if (mod == 1) {
                sub_0800E600(5);
            } else if (mod == 2) {
                sub_0800E600(6);
            }
            t = arg - 30;
            while (sub_0800FD50() != 0) {
                sub_080008DC();
            }
        }
    }

    cls = sub_0800CE10(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);
    if (cls == 1) {
        gIwram_6110.inputFlags |= 4;
    }
    if ((u8)sub_08009BA0() != 0) {
        if ((gIwram_6110.inputFlags & 2) == 0) {
            gIwram_6110.inputFlags |= 2;
        }
    }

    if ((u8)t <= 7) {
        if ((s8)gIwram_35E0._field_5 < t) {
            gIwram_35E0._field_5 = t;
            sub_0800A540();
            sub_08020C78(4);
        }
    }
}
