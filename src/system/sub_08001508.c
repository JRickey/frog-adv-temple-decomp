#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08020BC0(void);
extern void sub_0800B7B0(void *sp_buf, void *r4_obj, u32 arg2);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern u32 sub_08009D9C(u8 *localState);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_0800B918(void *ent, void *arg1, u32 kind);
extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_0800B8A8(void *ent, void *arg1, u32 kind, u32 tile);
extern u32 sub_08009C14(void *p);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void sub_08001508(void)
{
    struct {
        u8 sp_buf[72];
        s8 spByte;
        u8 localState;
        u8 pad[2];
        u8 r4_obj[8];
    } frame;

    frame.localState = 0;

    if (gGameStuff.mode != GAME_MODE_SCENE_11 && gGameStuff.mode != GAME_MODE_ATTRACT)
        return;

    do {
        sub_08020BC0();
        switch (frame.localState) {
        default:
            goto tail;
        case 0: {
            void *obj;
            obj = frame.r4_obj;
            gGameStuff.pendingMode = 4;
            sub_0800B7B0(frame.sp_buf, obj, 4);
            frame.localState = 1;
            frame.spByte = 0;
            break;
        }
        case 1:
            if (sub_0800A104((u8 *)&frame.spByte, 0x080017a9) == 0) {
                goto finalize;
            }
            *(volatile u8 *)&frame.localState = 2;
            gGameStuff._unk14 = 0;
            frame.spByte = 0;
            goto finalize;
        case 2:
            if (sub_08009D9C((u8 *)&frame.spByte) == 0)
                goto tail;
            *(volatile u8 *)&frame.localState = 3;
            gGameStuff._unk14 = 0;
            goto tail;
        case 3: {
            register u32 nextState asm("r3");
            struct IwramAt3720 *p3720;
            void *obj;
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                frame.localState = 5;
                sub_0800E060();
                break;
            }
            p3720 = &gIwram_3720;
            nextState = 8;
            if ((p3720->_field_34 & 8) != 0) {
                frame.localState = 4;
                break;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                frame.localState = nextState;
                break;
            }
            obj = frame.r4_obj;
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
            sub_080094F8();
            sub_08009984();
            sub_0800B918(frame.sp_buf, obj, 4);
            if ((p3720->_field_34 & 4) == 0) {
                u8 tile = (u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                           gIwram_35E0._field_A);
                if ((gIwram_35E0._field_10 & 0x10) != 0)
                    sub_0800B8A8(frame.sp_buf, obj, 4, tile);
            }
            gGameStuff._unk14++;
            break;
        }
        case 4: {
            void *obj;
            obj = frame.r4_obj;
            if (sub_08009C14(&frame.localState) == 0)
                frame.localState = 7;
            sub_0800B7B0(frame.sp_buf, obj, 4);
            if (gIwram_35E0._field_5 <= 1) {
                gIwram_6110.scenePhase = 0;
                gIwram_6110.selector5Flags = 0;
            } else {
                gIwram_6110.scenePhase = 5;
            }
            frame.spByte = 0;
            break;
        }
        case 5:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                frame.localState = 6;
                frame.spByte = 0;
            }
            if (gIwram_5328 == 0)
                frame.localState = 3;
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
                *(volatile u8 *)&frame.localState = 2;
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
    } while (gGameStuff.mode == GAME_MODE_SCENE_11 || gGameStuff.mode == GAME_MODE_ATTRACT);
}

/* Mode-4 re-arm thunk: queues pendingMode = 4, then forwards its two
 * (untouched) register arguments plus the same literal 4 to sub_0800B7B0.
 * agbcc reuses the 4 it materialised for the strb as the third call arg,
 * so the constant is loaded once. */
void sub_08001794(void *a, void *b)
{
    gGameStuff.pendingMode = 4;
    sub_0800B7B0(a, b, 4);
}
