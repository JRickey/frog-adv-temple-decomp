#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08020BC0(void);
extern u32 sub_0800A214(void);
extern u8 sub_0800A104(u8 *secondary, u32 callbackTable);
extern void sub_0801B514(u32 arg);
extern void sub_0800A258(u32 arg);
extern u32 sub_08009D9C(u8 *secondary);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern u8 sub_0800679C(void *base, u32 selector, u32 bit);
extern void sub_080066C4(void *base, u32 selector, u32 bit);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_0800ACE8(u8 arg);
extern u32 sub_08009C14(u8 *state);
extern void sub_08002AE8(void);
extern void sub_0800A540(void);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void sub_08002B58(void)
{
    s8 secondary;
    u8 state;
    u32 r6;

    state = 0;
    if (gGameStuff.mode != GAME_MODE_SCENE_16)
        return;

    do {
        sub_08020BC0();
        if (state > 11)
            goto tail;

        switch (state) {
        case 0:
            gGameStuff.pendingMode = 9;
            r6 = sub_0800A214();
            state = 1;
            secondary = 0;
            goto tail;
        case 1:
            if (sub_0800A104((u8 *)&secondary, 0x08002E11) == 0)
                goto cleanup;
            state = 2;
            gGameStuff._unk14 = 0;
            secondary = 0;
            goto cleanup;
        case 2:
            sub_0801B514(9);
            sub_0800A258(r6);
            state = 3;
            goto tail;
        case 3:
            if (sub_08009D9C((u8 *)&secondary) == 0)
                goto tail;
            state = 4;
            gGameStuff._unk14 = 0;
            secondary = 0;
            goto tail;
        case 4:
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                state = 7;
                sub_0800E060();
                goto tail;
            }
            if ((gEntities[0].status & 8) != 0) {
                state = 5;
                goto tail;
            }
            if (sub_0800679C(&gIwram_6110, 8, 0) != 0) {
                state = 10;
                goto tail;
            }
            if (sub_0800679C(&gIwram_6110, 8, 1) != 0) {
                sub_080066C4(&gIwram_6110, 8, 1);
                state = 6;
                goto tail;
            }
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
            sub_080094F8();
            sub_08009984();
            if ((gIwram_35E0._field_10 & 0x10) != 0) {
                sub_0800ACE8((u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                              gIwram_35E0._field_A));
            }
            gGameStuff._unk14++;
            goto tail;
        case 5:
            if (sub_08009C14(&state) == 0)
                state = 9;
            secondary = 0;
            goto tail;
        case 6:
            sub_08002AE8();
            gEntities[1].status |= 8;
            sub_0800A540();
            state = 4;
            gGameStuff._unk14 = 0;
            goto tail;
        case 7:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                state = 8;
                secondary = 0;
            }
            if (gIwram_5328 == 0)
                state = 4;
            goto tail;
        case 8: {
            s32 counter;
            if (secondary == 0) {
                sub_08010694(0xBF);
                secondary++;
            }
            counter = secondary;
            if (counter != 1)
                goto tail;
            if (sub_080106B8() != 0)
                goto tail;
            gIwram_3480._data[0] = 4;
            gIwram_3480._data[6] = counter;
            gGameStuff.mode = GAME_MODE_ROUTER;
            goto tail;
        }
        case 9:
            if (sub_0800A104((u8 *)&secondary, 0x0800A26D) != 0) {
                state = 3;
                gGameStuff._unk14 = 0;
                secondary = 0;
                sub_0800A258(r6);
            }
            /* fall through */
        cleanup:
            sub_080008DC();
            goto tail;
        case 10:
            state = 11;
            goto tail;
        case 11:
            sub_0800DE80();
            goto tail;
        }

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_16);
}
