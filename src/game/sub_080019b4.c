#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_08020BC0(void);
extern void sub_08006BB4(u32 arg0, void *obj);
extern void sub_0800B7B0(void *buf, void *r4_obj, u32 kind);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern u32 sub_08009D9C(u8 *localState);
extern void sub_08007660(u32 arg0, void *obj);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800EF90(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_080018F8(void *buf, void *r4_obj);
extern u32 sub_08009C14(void *p);
extern void sub_080066C4(void *base, u32 idx, u32 val);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void sub_080019B4(void)
{
    struct {
        u8 obj0[0x438];
        u8 buf[0x90];
        s8 spByte;
        u8 state;
        u8 pad[2];
        u8 r4_obj[8];
    } frame;

    {
        register u8 *statep asm("r0");
        register u8 zero asm("r1");
        statep = &frame.state;
        zero = 0;
        *(volatile u8 *)statep = zero;
    }
    goto tail;

    do {
        sub_08020BC0();
        switch (frame.state) {
        default:
            goto tail;
        case 0: {
            void *obj;
            obj = frame.r4_obj;
            gGameStuff.pendingMode = 5;
            sub_08006BB4(0, frame.obj0);
            sub_0800B7B0(frame.buf, obj, 5);
            frame.state = 1;
            frame.spByte = 0;
            break;
        }
        case 1:
            if (sub_0800A104((u8 *)&frame.spByte, 0x08001d19) == 0)
                goto finalize;
            *(volatile u8 *)&frame.state = 2;
            gGameStuff._unk14 = 0;
            frame.spByte = 0;
            goto finalize;
        case 2:
            if (sub_08009D9C((u8 *)&frame.spByte) != 0) {
                *(volatile u8 *)&frame.state = 3;
                gGameStuff._unk14 = 0;
            }
            sub_08007660(0, frame.obj0);
            break;
        case 3: {
            register u32 nextState asm("r3");
            struct IwramAt3720 *p3720;
            void *obj;
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                frame.state = 5;
                sub_0800E060();
                break;
            }
            p3720 = &gIwram_3720;
            nextState = 8;
            if ((p3720->_field_34 & 8) != 0) {
                frame.state = 4;
                sub_0800EF90();
                break;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                frame.state = nextState;
                break;
            }
            obj = frame.r4_obj;
            sub_08007660(0, frame.obj0);
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
            sub_080094F8();
            sub_08009984();
            sub_080018F8(frame.buf, obj);
            gGameStuff._unk14++;
            break;
        }
        case 4: {
            u8 *statep;
            void *obj;
            statep = &frame.state;
            obj = frame.r4_obj;
            asm("" : "+r"(statep));
            if (sub_08009C14(&frame.state) == 0)
                *statep = 7;
            sub_0800B7B0(frame.buf, obj, 5);
            if (gIwram_35E0._field_5 <= 1) {
                sub_080066C4(&gIwram_6110, 8, 0);
                sub_080066C4(&gIwram_6110, 9, 0);
            }
            if ((u8)gIwram_35E0._field_5 == 2) {
                sub_080066C4(&gIwram_6110, 8, 1);
                sub_080066C4(&gIwram_6110, 9, 1);
            }
            if ((u8)gIwram_35E0._field_5 == 3) {
                sub_080066C4(&gIwram_6110, 8, 1);
                sub_080066C4(&gIwram_6110, 9, 1);
            }
            frame.spByte = 0;
            break;
        }
        case 5:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                frame.state = 6;
                frame.spByte = 0;
            }
            if (gIwram_5328 == 0)
                frame.state = 3;
            break;
        case 6: {
            s32 counter;
            if ((s8)frame.spByte == 0) {
                sub_08010694(0xBF);
                frame.spByte += 1;
            }
            counter = (s8)frame.spByte;
            if (counter != 1)
                break;
            if (sub_080106B8() != 0)
                break;
            gIwram_3480._data[0] = 4;
            gIwram_3480._data[6] = counter;
            gGameStuff.mode = GAME_MODE_ROUTER;
            break;
        }
        case 7:
            if (sub_0800A104((u8 *)&frame.spByte, 0x0800a26d) != 0) {
                *(volatile u8 *)&frame.state = 2;
                gGameStuff._unk14 = 0;
                frame.spByte = 0;
                sub_0800A1C8();
            }
        finalize:
            sub_080008DC();
            break;
        case 8:
            sub_0800DE80();
            break;
        }

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_12 || gGameStuff.mode == GAME_MODE_ATTRACT);
}

void sub_08001CEC(void *buf, void *r4_obj, u32 kind)
{
    gGameStuff.pendingMode = 5;
    sub_08006BB4(0, buf);
    sub_0800B7B0(r4_obj, (void *)kind, 5);
}
