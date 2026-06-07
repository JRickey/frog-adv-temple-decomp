#include "game.h"
#include "entity.h"
#include "iwram.h"
#include "types.h"

extern void Sound_ServiceQueue(void);
extern u32 Scene_SelectEntityLimit(void);
extern u8 RunFadeTransition(u8 *state, u32 callbackTable);
extern void RunWorldSelectTransition(u32 arg);
extern u32 Scene_InitScan(void *obj);
extern void CtrlFlags_SetBit(void *base, u32 a, u32 b);
extern u16 Input_Poll(void);
extern void Scene_LoadBg(void);
extern void Game_UpdateSubsystems(void);
extern void Entity_UpdateVisibility(void);
extern void Entity_Advance(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Entity_CollisionProbe(void *obj, void *r4_obj);
extern u32 Scene_EntityTick(u8 *state);
extern void EntitySlot17_Init(void);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StartFade(u8 arg);
extern u8 Blend_StepFade(void);
extern void Entity_UpdateHitboxSlots(void *obj, void *r4_obj, u32 size);
extern void LoadScreenTilemap_188EDC(void);
extern void Game_FrameEnd(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void Scene13_Update(void)
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
    Sound_ServiceQueue();

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
        r7 = Scene_SelectEntityLimit();
        *statep = 1;
        goto storeAcceptZero;
    case 1:
        if (RunFadeTransition((u8 *)&frame.accept, 0x08002451) == 0)
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
        RunWorldSelectTransition(6);
        EntityParam_Apply(r7);
        *statep = 3;
        break;
    case 3:
        if (Scene_InitScan((u8 *)&frame.accept) == 0)
            goto tail;
        *statep = 4;
        gGameStuff._unk14 = 0;
        CtrlFlags_SetBit(&gIwram_6110, 8, 0);
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
        gIwram_5398 = Input_Poll();
        if (gIwram_5398 == 0x40) {
            *statep = 6;
            Scene_LoadBg();
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
        Game_UpdateSubsystems();
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
        Entity_UpdateVisibility();
        Entity_Advance();
        WaitVblank();
        Game_ForceRender();
        Entity_CheckAllCollisions();
        Player_CheckTileEvents();
        Entity_CollisionProbe(frame.obj, obj);
        gGameStuff._unk14++;
        break;
    }
    case 5:
        if (Scene_EntityTick(statep) == 0)
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
                EntitySlot17_Init();
            goto storeAcceptZero;
        }
    storeAcceptZero:
        frame.accept = zero;
        goto tail;
    case 6:
        gIwram_5398 = Input_Poll();
        if (Scene_FadeUpdate() == 0) {
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
            Blend_StartFade(0xBF);
            frame.accept++;
        }
        counter = (s8)frame.accept;
        if (counter != 1)
            goto tail;
        if (Blend_StepFade() != 0)
            goto tail;
        gIwram_3480._data[0] = 4;
        gIwram_3480._data[6] = counter;
        gGameStuff.mode = GAME_MODE_ROUTER;
        break;
    }
    case 8: {
        u8 *base;
        if (RunFadeTransition((u8 *)&frame.accept, 0x0800A26D) == 0)
            goto finalize;
        base = (u8 *)&gIwram_6110;
        if (base[43] == 2) {
            void *obj;
            obj = frame.r4_obj;
            Entity_UpdateHitboxSlots(frame.obj, obj, 28);
            LoadScreenTilemap_188EDC();
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
        EntityParam_Apply(r7);
        goto finalize;
    }
    finalize:
        WaitVblank();
        break;
    case 9:
        Game_FrameEnd();
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
