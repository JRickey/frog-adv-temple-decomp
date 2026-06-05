#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_08020BC0(void);
extern u32 sub_0800A214(void);
extern u8 sub_0800A104(u8 *state, u32 callbackTable);
extern void sub_0801B514(u32 arg);
extern void sub_0800A258(u32 arg);
extern u32 sub_08009D9C(void *obj);
extern void sub_08006600(void *base, u32 a, u32 b);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern void sub_0800A520(void);
extern void sub_08009A58(void);
extern void sub_08009188(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08001E24(void *obj, void *r4_obj);
extern u32 sub_08009C14(u8 *state);
extern void sub_0802AB64(void);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800B7B0(void *obj, void *r4_obj, u32 size);
extern void sub_08012B38(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void sub_08002184(void)
{
    struct {
        u8 obj[0xc0];
        s8 accept;
        u8 state;
        u8 pad[2];
        u8 r4_obj[8];
    } frame;
    u8 *statep;
    u8 *statepInit;
    u32 r7;
    u32 zero;

    {
        register u8 zero asm("r1");
        statepInit = &frame.state;
        zero = 0;
        *(volatile u8 *)statepInit = zero;
    }
    {
        register GameStuff *game asm("r1");
        game = &gGameStuff;
        statep = statepInit;
        asm("" : "+r"(game));
        if (game->mode == GAME_MODE_SCENE_13)
            goto loop;
        goto epilogue;
    }

loop:
    sub_08020BC0();

    switch (*statep) {
    default:
        goto tail;
    case 0: {
        register GameStuff *game asm("r1");
        game = &gGameStuff;
        asm("" : "+r"(game));
        zero = 0;
        game->pendingMode = 6;
    }
        r7 = sub_0800A214();
        *statep = 1;
        goto storeAcceptZero;
    case 1:
        if (sub_0800A104((u8 *)&frame.accept, 0x08002451) == 0)
            goto finalize;
        *statep = 2;
        {
            GameStuff *game;
            u8 *iwram;
            u32 localZero;
            game = &gGameStuff;
            asm("" : "+r"(game));
            localZero = 0;
            game->_unk14 = localZero;
            frame.accept = localZero;
            iwram = (u8 *)&gIwram_6110;
            iwram[43] = localZero;
        }
        goto finalize;
    case 2:
        sub_0801B514(6);
        sub_0800A258(r7);
        *statep = 3;
        break;
    case 3:
        if (sub_08009D9C((u8 *)&frame.accept) == 0)
            goto tail;
        *statep = 4;
        gGameStuff._unk14 = 0;
        sub_08006600(&gIwram_6110, 8, 0);
        {
            u8 *base;
            u32 offset;
            u32 value;
            base = (u8 *)gEntities;
            offset = 0xb54;
            *(u32 *)(base + offset) = gGameStuff._unk00;
            value = gGameStuff._unk00;
            offset = 0xb48;
            *(u32 *)(base + offset) = value;
        }
        break;
    case 4: {
        void *obj;
        gIwram_5398 = sub_080004C4();
        if (gIwram_5398 == 0x40) {
            *statep = 6;
            sub_0800E060();
            goto tail;
        }
        if ((gEntities[0].status & 8) != 0) {
            *statep = 5;
            goto tail;
        }
        if ((gIwram_6110.inputFlags & 8) != 0) {
            *statep = 9;
            goto tail;
        }
        obj = frame.r4_obj;
        sub_0800A520();
        {
            void (**proc)(void);
            GameStuff *game;
            proc = (void (**)(void))0x080C0CB8;
            asm("" : "+r"(proc));
            game = &gGameStuff;
            proc[game->pendingMode]();
            proc = (void (**)(void))0x080C0D40;
            asm("" : "+r"(proc));
            proc[game->pendingMode]();
        }
        sub_08009A58();
        sub_08009188();
        sub_080008DC();
        sub_0800A328();
        sub_080094F8();
        sub_08009984();
        sub_08001E24(frame.obj, obj);
        gGameStuff._unk14++;
        break;
    }
    case 5:
        if (sub_08009C14(statep) == 0)
            *statep = 8;
        {
            u8 *base;
            u8 *bytep;
            register u32 localZero asm("r1");
            base = (u8 *)&gIwram_6110;
            bytep = base;
            bytep += 42;
            localZero = 0;
            *bytep = localZero;
            zero = 0;
            *(u16 *)(base + 12) = localZero;
            if (base[43] == 1)
                sub_0802AB64();
            goto storeAcceptZero;
        }
    storeAcceptZero:
        frame.accept = zero;
        goto tail;
    case 6:
        gIwram_5398 = sub_080004C4();
        if (sub_0800E6A8() == 0) {
            *statep = 7;
            frame.accept = 0;
        }
        if (gIwram_5328 != 0)
            goto tail;
        *statep = 4;
        break;
    case 7: {
        s32 counter;
        if ((s8)frame.accept == 0) {
            sub_08010694(0xBF);
            frame.accept++;
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
    case 8: {
        u8 *base;
        if (sub_0800A104((u8 *)&frame.accept, 0x0800A26D) == 0)
            goto finalize;
        base = (u8 *)&gIwram_6110;
        if (base[43] == 2) {
            void *obj;
            obj = frame.r4_obj;
            sub_0800B7B0(frame.obj, obj, 28);
            sub_08012B38();
        }
        *statep = 3;
        {
            GameStuff *game;
            register u32 localZero asm("r0");
            localZero = 0;
            frame.accept = localZero;
            asm("" ::: "r0");
            game = &gGameStuff;
            localZero = 0;
            game->_unk14 = localZero;
        }
        sub_0800A258(r7);
        goto finalize;
    }
    finalize:
        sub_080008DC();
        break;
    case 9:
        sub_0800DE80();
        break;
    }

    goto tail;

tail:
    switch (gGameStuff.mode) {
    case 13:
        goto loop;
    }

epilogue:;
}
