#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* TODO: decomp */

/* --- sub_08004FAC: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08020BC0(void);
extern u32 sub_0800A214(void);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern void sub_0801B514(u32 arg);
extern void sub_0800A258(u32 handle);
extern u32 sub_08009D9C(u8 *localState);
extern void sub_08006600(void *base, u32 selector, u32 bit);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08004D10(u8 *buf0, u32 *out0, u8 *buf1, u32 *out1);
extern u32 sub_08009C14(u8 *localState);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_08015A00(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void sub_08004FAC(void)
{
    struct {
        u8 buf[0x300];
        s8 accept;
        u8 state;
        u8 pad[2];
        u32 out0[2];
        u32 out1[2];
    } frame;
    u32 handle;

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
        case 0:
            gGameStuff.pendingMode = 15;
            handle = sub_0800A214();
            frame.state = 1;
            frame.accept = 0;
            break;
        case 1:
            if (sub_0800A104((u8 *)&frame.accept, 0x080052CD) == 0)
                goto finalize;
            *(volatile u8 *)&frame.state = 2;
            gGameStuff._unk14 = 0;
            frame.accept = 0;
            goto finalize;
        case 2:
            sub_0801B514(15);
            sub_0800A258(handle);
            frame.state = 3;
            break;
        case 3:
            if (sub_08009D9C((u8 *)&frame.accept) == 0)
                goto tail;
            *(volatile u8 *)&frame.state = 4;
            gGameStuff._unk14 = 0;
            sub_08006600(&gIwram_6110, 3, 4);
            break;
        case 4: {
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                frame.state = 6;
                sub_0800E060();
                goto tail;
            }
            if ((gEntities[0].status & 8) != 0) {
                frame.state = 5;
                goto tail;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                frame.state = 9;
                goto tail;
            }
            {
                register u32 *p0 asm("r4") = frame.out0;
                register u32 *p1 asm("r5") = frame.out1;
                sub_0800A2D8();
                sub_080008DC();
                sub_0800A328();
                sub_080094F8();
                sub_08009984();
                sub_08004D10(frame.buf, p0, frame.buf + 0x180, p1);
            }
            gGameStuff._unk14++;
            break;
        }
        case 5: {
            register u8 *statep asm("r4") = &frame.state;
            register u32 *q0 asm("r5") = frame.out0;
            register u32 *q1 asm("r6") = frame.out1;
            register u8 *maskp asm("r4");
            u32 off = 0x180;
            if (sub_08009C14(&frame.state) == 0)
                *statep = 8;
            gIwram_6110.scenePhase = 0;
            gIwram_6110.byteFlags8 = 0;
            gIwram_6110.gateByte = 0;
            maskp = &gIwram_6110.spawnMask;
            if (*maskp == 1) {
                sub_0800BE18(frame.buf, q0, 29);
                sub_0800BE18(frame.buf + 0x180, q1, 30);
                if (*maskp == 1) {
                    sub_0800BE18(frame.buf, q0, 29);
                    asm("" : "+r"(off));
                    sub_0800BE18(frame.buf + off, q1, 30);
                }
            }
            frame.accept = 0;
            break;
        }
        case 6:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                frame.state = 7;
                frame.accept = 0;
            }
            if (gIwram_5328 != 0)
                goto tail;
            frame.state = 4;
            break;
        case 7: {
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
        case 8:
            if (sub_0800A104((u8 *)&frame.accept, 0x0800A26D) == 0)
                goto finalize;
            *(volatile u8 *)&frame.state = 3;
            gGameStuff._unk14 = 0;
            frame.accept = 0;
            sub_0800A258(handle);
        finalize:
            sub_080008DC();
            break;
        case 9:
            gEntities[22].status |= 8;
            sub_08015A00();
            sub_0800DE80();
            break;
        }

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_22);
}
#endif /* NON_MATCHING */
