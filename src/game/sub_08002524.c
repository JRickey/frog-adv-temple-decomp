#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_08020BC0(void);
extern u8 sub_0800A104(u8 *accept, u32 callbackTable);
extern u32 sub_08009D9C(u8 *accept);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800EF90(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern u8 sub_0800CD88(u8 a, u8 b, s16 c, s16 d);
extern void sub_0800C3E4(u8 a);
extern u32 sub_08009C14(u8 *state);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void sub_08002524(void)
{
    struct {
        s8 accept;
        u8 state;
        u8 pad[2];
    } frame;
    u8 *statep;
    register u8 *statepInit asm("r0");

    {
        u8 zero;
        statepInit = &frame.state;
        zero = 0;
        *(volatile u8 *)statepInit = zero;
    }
    {
        u32 mode;
        mode = gGameStuff.mode;
        statep = statepInit;
        if (mode == 14)
            goto loop;
        if (mode == 24)
            goto loop;
        goto epilogue;
    }

loop:
    sub_08020BC0();

    switch (*statep) {
    default:
        goto tail;
    case 0:
        gGameStuff.pendingMode = 7;
        *statep = 1;
        frame.accept = 0;
        break;
    case 1:
        if (sub_0800A104((u8 *)&frame.accept, 0x0800276D) == 0)
            goto finalize;
        *statep = 2;
        gGameStuff._unk14 = 0;
        frame.accept = 0;
        goto finalize;
    case 2:
        if (sub_08009D9C((u8 *)&frame.accept) == 0)
            goto tail;
        *statep = 3;
        gGameStuff._unk14 = 0;
        break;
    case 3: {
        register u32 nextState asm("r3");
        struct Entity *p3720;
        gIwram_5398 = sub_080004C4();
        if (gIwram_5398 == 0x40) {
            *statep = 5;
            sub_0800E060();
            goto tail;
        }
        p3720 = gEntities;
        nextState = 8;
        if ((p3720->status & 8) != 0) {
            *statep = 4;
            sub_0800EF90();
            goto tail;
        }
        if ((gIwram_6110.inputFlags & 8) != 0) {
            *statep = nextState;
            goto tail;
        }
        sub_0800A2D8();
        sub_080008DC();
        sub_0800A328();
        sub_080094F8();
        sub_08009984();
        if ((gIwram_35E0._field_10 & 0x10) != 0) {
            u8 result =
                sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);
            sub_0800C3E4(result);
        }
        gGameStuff._unk14++;
        break;
    }
    case 4:
        if (sub_08009C14(statep) == 0)
            *statep = 7;
        {
            register u8 *acceptp asm("r1");
            u8 zero;
            acceptp = (u8 *)&frame.accept;
            zero = 0;
            *(volatile u8 *)acceptp = zero;
        }
        break;
    case 5:
        gIwram_5398 = sub_080004C4();
        if (sub_0800E6A8() == 0) {
            *statep = 6;
            frame.accept = 0;
        }
        if (gIwram_5328 != 0)
            goto tail;
        *statep = 3;
        break;
    case 6: {
        s32 counter;
        if ((s8)frame.accept == 0) {
            register u8 *acceptDst asm("r0");
            u8 *acceptSrc;
            u8 nextAccept;
            sub_08010694(0xBF);
            acceptDst = (u8 *)&frame.accept;
            acceptSrc = (u8 *)&frame.accept;
            nextAccept = *acceptSrc + 1;
            *acceptDst = nextAccept;
        }
        counter = (s8)frame.accept;
        if (counter != 1)
            goto tail;
        if (sub_080106B8() != 0)
            goto tail;
        gIwram_3480._data[0] = 4;
        gIwram_3480._data[6] = counter;
        gGameStuff.mode = GAME_MODE_ROUTER;
        break;
    }
    case 7:
        if (sub_0800A104((u8 *)&frame.accept, 0x0800A26D) != 0) {
            *statep = 2;
            gGameStuff._unk14 = 0;
            frame.accept = 0;
            sub_0800A1C8();
        }
    finalize:
        sub_080008DC();
        break;
    case 8:
        sub_0800DE80();
        break;
    }

tail:
    if (gGameStuff.mode == GAME_MODE_SCENE_14 || gGameStuff.mode == GAME_MODE_ATTRACT)
        goto loop;

epilogue:;
}
