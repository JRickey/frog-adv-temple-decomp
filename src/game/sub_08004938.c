#include "game.h"
#include "entity.h"
#include "gfx.h"
#include "iwram.h"
#include "types.h"

extern void Sound_ServiceQueue(void);
extern void EntityScript_BuildSlotData(u32 partId, void *out);
extern u8 RunFadeTransition(u8 *localState, u32 callbackTable);
extern u32 Scene_InitScan(u8 *localState);
extern u16 Input_Poll(void);
extern void Scene_LoadBg(void);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Player_HandleTileTransitions(void *a, void *b);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StepFade(void);
extern void EntityParam_Reset(void);
extern void Game_FrameEnd(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void SceneLoop_21(void)
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
        register u32 partId asm("r0");

        Sound_ServiceQueue();
        switch (frame.state) {
        default:
            goto tail;
        case 0: {
            /* partId pinned to r0 as an explicit store: agbcc precomputes the
             * expensive &frame.obj0 address into r1 ahead of the cheap literal
             * 5, so without the pin `add r1, sp, #280` lands before `mov r0,
             * #5`. The pin forces the constant out first. */
            void *b;
            b = frame.b;
            gGameStuff.pendingMode = 14;
            partId = 5;
            EntityScript_BuildSlotData(partId, frame.obj0);
            Entity_UpdateHitboxSlots(frame.a, b, 17);
            frame.state = 1;
            frame.accept = 0;
            break;
        }
        case 1:
            if (RunFadeTransition((u8 *)&frame.accept, 0x08004C31) == 0)
                goto finalize;
            *(volatile u8 *)&frame.state = 2;
            gGameStuff._unk14 = 0;
            frame.accept = 0;
            goto finalize;
        case 2:
            if (Scene_InitScan((u8 *)&frame.accept) == 0)
                goto tail;
            *(volatile u8 *)&frame.state = 3;
            gGameStuff._unk14 = 0;
            break;
        case 3: {
            register u32 nextState asm("r3");
            struct Entity *p3720;
            gIwram_5398 = Input_Poll();
            if (gIwram_5398 == 0x40) {
                frame.state = 5;
                Scene_LoadBg();
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
                void *b;
                b = frame.b;
                partId = 5;
                Entity_RunScript(partId, frame.obj0);
                Game_RunEntityFrame();
                WaitVblank();
                Game_ForceRender();
                Entity_CheckAllCollisions();
                Player_CheckTileEvents();
                Player_HandleTileTransitions(frame.a, b);
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
                ModeControl_ClearBit(&gIwram_6110, 3, 0);
                ModeControl_ClearBit(&gIwram_6110, 3, 1);
            } else {
                CtrlFlags_SetBit(&gIwram_6110, 3, 1);
            }
            if (Scene_EntityTick(&frame.state) == 0)
                *statep = 7;
            Entity_UpdateHitboxSlots(a, b, 17);
            frame.accept = 0;
            break;
        }
        case 5:
            gIwram_5398 = Input_Poll();
            if (Scene_FadeUpdate() == 0) {
                frame.state = 6;
                frame.accept = 0;
            }
            if (gIwram_5328 == 0)
                frame.state = 3;
            break;
        case 6: {
            s32 counter;
            if ((s8)frame.accept == 0) {
                Blend_StartFade(0xBF);
                frame.accept += 1;
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
                *(volatile u8 *)&frame.state = 2;
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

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_21 || gGameStuff.mode == GAME_MODE_ATTRACT);
}
