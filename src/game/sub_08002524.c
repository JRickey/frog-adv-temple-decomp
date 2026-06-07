#include "game.h"
#include "iwram.h"
#include "types.h"

extern void Sound_ServiceQueue(void);
extern u8 RunFadeTransition(u8 *accept, u32 callbackTable);
extern u32 Scene_InitScan(u8 *accept);
extern u16 Input_Poll(void);
extern void Scene_LoadBg(void);
extern void Scene_DisableBg2(void);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern u8 Tilemap_GetTileClass(u8 a, u8 b, s16 c, s16 d);
extern u32 Scene_EntityTick(u8 *state);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StartFade(u8 arg);
extern u8 Blend_StepFade(void);
extern void EntityParam_Reset(void);
extern void Game_FrameEnd(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void SceneLoop_14(void)
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
    Sound_ServiceQueue();

    switch (*statep) {
    default:
        goto tail;
    case 0:
        gGameStuff.pendingMode = 7;
        *statep = 1;
        frame.accept = 0;
        break;
    case 1:
        if (RunFadeTransition((u8 *)&frame.accept, 0x0800276D) == 0)
            goto finalize;
        *statep = 2;
        gGameStuff._unk14 = 0;
        frame.accept = 0;
        goto finalize;
    case 2:
        if (Scene_InitScan((u8 *)&frame.accept) == 0)
            goto tail;
        *statep = 3;
        gGameStuff._unk14 = 0;
        break;
    case 3: {
        register u32 nextState asm("r3");
        struct Entity *p3720;
        gIwram_5398 = Input_Poll();
        if (gIwram_5398 == 0x40) {
            *statep = 5;
            Scene_LoadBg();
            goto tail;
        }
        p3720 = gEntities;
        nextState = 8;
        if ((p3720->status & 8) != 0) {
            *statep = 4;
            Scene_DisableBg2();
            goto tail;
        }
        if ((gIwram_6110.inputFlags & 8) != 0) {
            *statep = nextState;
            goto tail;
        }
        Game_RunEntityFrame();
        WaitVblank();
        Game_ForceRender();
        Entity_CheckAllCollisions();
        Player_CheckTileEvents();
        if ((gIwram_35E0._field_10 & 0x10) != 0) {
            u8 result = Tilemap_GetTileClass(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                             gIwram_35E0._field_A);
            UpdateSceneGate(result);
        }
        gGameStuff._unk14++;
        break;
    }
    case 4:
        if (Scene_EntityTick(statep) == 0)
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
        gIwram_5398 = Input_Poll();
        if (Scene_FadeUpdate() == 0) {
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
            Blend_StartFade(0xBF);
            acceptDst = (u8 *)&frame.accept;
            acceptSrc = (u8 *)&frame.accept;
            nextAccept = *acceptSrc + 1;
            *acceptDst = nextAccept;
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
    case 7:
        if (RunFadeTransition((u8 *)&frame.accept, 0x0800A26D) != 0) {
            *statep = 2;
            gGameStuff._unk14 = 0;
            frame.accept = 0;
            EntityParam_Reset();
        }
    finalize:
        WaitVblank();
        break;
    case 8:
        Game_FrameEnd();
        break;
    }

tail:
    if (gGameStuff.mode == GAME_MODE_SCENE_14 || gGameStuff.mode == GAME_MODE_ATTRACT)
        goto loop;

epilogue:;
}
