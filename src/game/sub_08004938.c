#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_08020BC0(void);
extern void sub_08006BB4(u32 partId, void *out);
extern void sub_0800B7B0(void *a, void *b, u32 kind);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern u32 sub_08009D9C(u8 *localState);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_08007660(u32 partId, void *out);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_080045EC(void *a, void *b);
extern u32 sub_08009C14(u8 *localState);
extern void sub_080066C4(void *base, u32 selector, u32 bit);
extern void sub_08006600(void *base, u32 selector, u32 bit);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void sub_08004938(void)
{
    struct {
        u8 a[0x118];
        u8 obj0[0x264];
        s8 accept;
        u8 state;
        u8 pad[2];
        u8 b[8];
    } frame;

    {
        u8 *statep;
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
            /* partId pinned to r0 as an explicit store: agbcc precomputes the
             * expensive &frame.obj0 address into r1 ahead of the cheap literal
             * 5, so without the pin `add r1, sp, #280` lands before `mov r0,
             * #5`. The pin forces the constant out first. */
            register u32 partId asm("r0");
            void *b;
            b = frame.b;
            gGameStuff.pendingMode = 14;
            partId = 5;
            sub_08006BB4(partId, frame.obj0);
            sub_0800B7B0(frame.a, b, 17);
            frame.state = 1;
            frame.accept = 0;
            break;
        }
        case 1:
            if (sub_0800A104((u8 *)&frame.accept, 0x08004C31) == 0)
                goto finalize;
            *(volatile u8 *)&frame.state = 2;
            gGameStuff._unk14 = 0;
            frame.accept = 0;
            goto finalize;
        case 2:
            if (sub_08009D9C((u8 *)&frame.accept) == 0)
                goto tail;
            *(volatile u8 *)&frame.state = 3;
            gGameStuff._unk14 = 0;
            break;
        case 3: {
            register u32 nextState asm("r3");
            struct Entity *p3720;
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                frame.state = 5;
                sub_0800E060();
                goto tail;
            }
            p3720 = gEntities;
            nextState = 8;
            if ((p3720->status & 8) != 0) {
                frame.state = 4;
                goto tail;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                frame.state = nextState;
                goto tail;
            }
            {
                /* Same &frame.obj0-vs-literal-5 argument-order pin as case 0. */
                register u32 partId asm("r0");
                void *b;
                b = frame.b;
                partId = 5;
                sub_08007660(partId, frame.obj0);
                sub_0800A2D8();
                sub_080008DC();
                sub_0800A328();
                sub_080094F8();
                sub_08009984();
                sub_080045EC(frame.a, b);
                gGameStuff._unk14++;
            }
            break;
        }
        case 4: {
            u8 *statep;
            void *a;
            void *b;
            statep = &frame.state;
            a = frame.a;
            b = frame.b;
            if ((s8)gIwram_35E0._field_5 <= 2) {
                sub_080066C4(&gIwram_6110, 3, 0);
                sub_080066C4(&gIwram_6110, 3, 1);
            } else {
                sub_08006600(&gIwram_6110, 3, 1);
            }
            if (sub_08009C14(&frame.state) == 0)
                *statep = 7;
            sub_0800B7B0(a, b, 17);
            frame.accept = 0;
            break;
        }
        case 5:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                frame.state = 6;
                frame.accept = 0;
            }
            if (gIwram_5328 == 0)
                frame.state = 3;
            break;
        case 6: {
            s32 counter;
            if ((s8)frame.accept == 0) {
                sub_08010694(0xBF);
                frame.accept += 1;
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
                *(volatile u8 *)&frame.state = 2;
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

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_21 || gGameStuff.mode == GAME_MODE_ATTRACT);
}
