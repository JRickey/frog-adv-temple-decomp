#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08020BC0(void);
extern u32 sub_0800A214(void);
extern u8 sub_0800A104(u8 *flag, u32 callbackTable);
extern void sub_0801B514(u32 arg);
extern void sub_0800A258(u32 arg);
extern u32 sub_08009D9C(u8 *flag);
extern void sub_08006600(u32 base, u32 idx, u32 val);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_080011A4(void);
extern u32 sub_08009C14(void *p);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800CBE8(u8 col, u8 row, u32 a, u32 b, u32 c);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void sub_08001214(void)
{
    s8 spByte4;
    u8 substate;
    u32 r7;

    substate = 0;

    if (gGameStuff.mode != GAME_MODE_SCENE_10)
        return;

    do {
        sub_08020BC0();
        if (substate > 9)
            goto tail;

        switch (substate) {
        case 0:
            gGameStuff.pendingMode = 3;
            r7 = sub_0800A214();
            substate = 1;
            spByte4 = 0;
            break;
        case 1:
            if (sub_0800A104((u8 *)&spByte4, 0x08001485) == 0)
                goto finalize;
            substate = 2;
            gGameStuff._unk14 = 0;
            spByte4 = 0;
            goto finalize;
        case 2:
            sub_0801B514(3);
            sub_0800A258(r7);
            substate = 3;
            break;
        case 3:
            if (sub_08009D9C((u8 *)&spByte4) == 0)
                goto tail;
            substate = 4;
            gGameStuff._unk14 = 0;
            sub_08006600(0x03006110, 8, 1);
            goto tail;
        case 4:
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                substate = 6;
                sub_0800E060();
                goto tail;
            }
            if ((gEntities[0].status & 8) != 0) {
                substate = 5;
                goto tail;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                substate = 9;
                goto tail;
            }
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
            sub_080094F8();
            sub_08009984();
            sub_080011A4();
            gGameStuff._unk14++;
            goto tail;
        case 5:
            if (sub_08009C14(&substate) == 0)
                substate = 8;
            spByte4 = 0;
            break;
        case 6:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                substate = 7;
                spByte4 = 0;
            }
            if (gIwram_5328 == 0)
                substate = 4;
            break;
        case 7: {
            s32 counter;
            if ((s8)spByte4 == 0) {
                sub_08010694(0xBF);
                spByte4 += 1;
            }
            counter = (s8)spByte4;
            if (counter != 1)
                goto tail;
            if (sub_080106B8() != 0)
                goto tail;
            gIwram_3480._data[0] = 4;
            gIwram_3480._data[6] = counter;
            gGameStuff.mode = GAME_MODE_ROUTER;
            break;
        }
        case 8:
            if (sub_0800A104((u8 *)&spByte4, 0x0800a26d) != 0) {
                substate = 3;
                gGameStuff._unk14 = 0;
                spByte4 = 0;
                sub_0800A258(r7);
            }
        finalize:
            sub_080008DC();
            goto tail;
        case 9:
            sub_0800CBE8(gIwram_35E0._field_18, gIwram_35E0._field_19, 6, 11, 15);
            sub_0800CBE8(gIwram_35E0._field_18, gIwram_35E0._field_19, 6, 10, 15);
            sub_0800CBE8(gIwram_35E0._field_18, gIwram_35E0._field_19, 7, 11, 7);
            sub_0800DE80();
            break;
        }

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_10);
}
