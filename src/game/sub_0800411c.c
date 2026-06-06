#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* TODO: decomp */

/* --- sub_0800411C: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_08020BC0(void);
extern void sub_08006BB4(u32 partId, u8 *out);
extern void sub_08007228(u8 partId, u8 *out, u8 tag);
extern void sub_0800B7B0(u32 a, u32 b, u8 c);
extern u8 sub_0800A104(u8 *localState, u32 callbackTable);
extern u32 sub_08009D9C(u8 *localState);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_08007660(u32 a, u32 b);
extern void sub_080072E0(u32 a, u32 b, u32 c);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08004508(u32 a, u32 b, u32 c, u32 d);
extern u32 sub_08009C14(u8 *localState);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800A1C8(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

#define STATE (*(volatile u8 *)&ctrl[1])

void sub_0800411C(void)
{
    u8 buf0[612];
    u8 buf1[72];
    u8 buf2[108];
    u8 buf3[32];
    u8 buf4[128];
    u8 ctrl[4];
    u8 pair11[8];
    u8 pair16[8];

    STATE = 0;
    goto tail;

loop:
    sub_08020BC0();

    switch (STATE) {
    default:
        goto tail;
    case 0: {
        u8 *p11 = pair11;
        u8 *p16 = pair16;
        gGameStuff.pendingMode = 13;
        sub_08006BB4(2, buf0);
        sub_08007228(3, buf1, 2);
        sub_08007228(4, buf2, 2);
        sub_0800B7B0((u32)buf3, (u32)p11, 11);
        sub_0800B7B0((u32)buf4, (u32)p16, 16);
        STATE = 1;
        ctrl[0] = 0;
        break;
    }
    case 1:
        if (sub_0800A104(&ctrl[0], 0x08004471) == 0)
            goto finalize;
        STATE = 2;
        gGameStuff._unk14 = 0;
        ctrl[0] = 0;
        goto finalize;
    case 2:
        if (sub_08009D9C(&ctrl[0]) == 0)
            goto tail;
        STATE = 3;
        gGameStuff._unk14 = 0;
        break;
    case 3: {
        register u32 nextState asm("r3");
        struct Entity *p3720;
        gIwram_5398 = sub_080004C4();
        if (gIwram_5398 == 0x40) {
            STATE = 5;
            sub_0800E060();
            goto tail;
        }
        p3720 = gEntities;
        nextState = 8;
        if ((p3720->status & 8) != 0) {
            STATE = 4;
            goto tail;
        }
        if ((gIwram_6110.inputFlags & 8) != 0) {
            STATE = nextState;
            goto tail;
        }
        {
            u8 *p11 = pair11;
            u8 *p16 = pair16;
            sub_08007660(2, (u32)buf0);
            sub_080072E0(0, 3, (u32)buf1);
            sub_080072E0(1, 4, (u32)buf2);
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
            sub_080094F8();
            sub_08009984();
            sub_08004508((u32)buf3, (u32)p11, (u32)buf4, (u32)p16);
            gGameStuff._unk14++;
        }
        break;
    }
    case 4: {
        u8 *statep = &ctrl[1];
        u8 *p11 = pair11;
        u8 *p16 = pair16;
        if ((s8)gIwram_35E0._field_5 <= 1)
            gIwram_6110.scenePhase = 0;
        else
            gIwram_6110.scenePhase = 1;
        if (sub_08009C14(statep) == 0)
            *statep = 7;
        sub_0800B7B0((u32)buf3, (u32)p11, 11);
        sub_0800B7B0((u32)buf4, (u32)p16, 16);
        ctrl[0] = 0;
        break;
    }
    case 5:
        gIwram_5398 = sub_080004C4();
        if (sub_0800E6A8() == 0) {
            STATE = 6;
            ctrl[0] = 0;
        }
        if (gIwram_5328 == 0)
            STATE = 3;
        break;
    case 6: {
        s32 counter;
        if ((s8)ctrl[0] == 0) {
            sub_08010694(0xBF);
            ctrl[0] = ctrl[0] + 1;
        }
        counter = (s8)ctrl[0];
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
        if (sub_0800A104(&ctrl[0], 0x0800A26D) != 0) {
            STATE = 2;
            gGameStuff._unk14 = 0;
            ctrl[0] = 0;
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
    if (gGameStuff.mode == GAME_MODE_SCENE_20 || gGameStuff.mode == GAME_MODE_ATTRACT)
        goto loop;
}
#endif /* NON_MATCHING */
