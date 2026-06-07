#include "game.h"
#include "iwram.h"
#include "types.h"

extern void Sound_ServiceQueue(void);
extern void EntityScript_BuildSlotData(u32 arg0, void *obj);
extern void Entity_UpdateHitboxSlots(void *buf, void *r4_obj, u32 kind);
extern u8 RunFadeTransition(u8 *localState, u32 callbackTable);
extern u32 Scene_InitScan(u8 *localState);
extern void Entity_RunScript(u32 arg0, void *obj);
extern u16 Input_Poll(void);
extern void Scene_LoadBg(void);
extern void Scene_DisableBg2(void);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Scene12_UpdateTileInteraction(void *buf, void *r4_obj);
extern void ModeControl_ClearBit(void *base, u32 idx, u32 val);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StartFade(u8 arg);
extern u8 Blend_StepFade(void);
extern void EntityParam_Reset(void);
extern void Game_FrameEnd(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void Scene12_Main(void)
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
        u8 *statep;
        register u8 zero asm("r1");
        statep = &frame.state;
        zero = 0;
        *(volatile u8 *)statep = zero;
    }
    goto tail;

    do {
        Sound_ServiceQueue();
        switch (frame.state) {
        default:
            goto tail;
        case 0: {
            void *obj;
            obj = frame.r4_obj;
            gGameStuff.pendingMode = 5;
            EntityScript_BuildSlotData(0, frame.obj0);
            Entity_UpdateHitboxSlots(frame.buf, obj, 5);
            frame.state = 1;
            frame.spByte = 0;
            break;
        }
        case 1:
            if (RunFadeTransition((u8 *)&frame.spByte, 0x08001d19) == 0)
                goto finalize;
            *(volatile u8 *)&frame.state = 2;
            gGameStuff._unk14 = 0;
            frame.spByte = 0;
            goto finalize;
        case 2:
            if (Scene_InitScan((u8 *)&frame.spByte) != 0) {
                *(volatile u8 *)&frame.state = 3;
                gGameStuff._unk14 = 0;
            }
            Entity_RunScript(0, frame.obj0);
            break;
        case 3: {
            register u32 nextState asm("r3");
            struct Entity *p3720;
            void *obj;
            gIwram_5398 = Input_Poll();
            if (gIwram_5398 == 0x40) {
                frame.state = 5;
                Scene_LoadBg();
                break;
            }
            p3720 = gEntities;
            nextState = 8;
            if ((p3720->status & 8) != 0) {
                frame.state = 4;
                Scene_DisableBg2();
                break;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                frame.state = nextState;
                break;
            }
            obj = frame.r4_obj;
            Entity_RunScript(0, frame.obj0);
            Game_RunEntityFrame();
            WaitVblank();
            Game_ForceRender();
            Entity_CheckAllCollisions();
            Player_CheckTileEvents();
            Scene12_UpdateTileInteraction(frame.buf, obj);
            gGameStuff._unk14++;
            break;
        }
        case 4: {
            u8 *statep;
            void *obj;
            statep = &frame.state;
            obj = frame.r4_obj;
            asm("" : "+r"(statep));
            if (Scene_EntityTick(&frame.state) == 0)
                *statep = 7;
            Entity_UpdateHitboxSlots(frame.buf, obj, 5);
            if (gIwram_35E0._field_5 <= 1) {
                ModeControl_ClearBit(&gIwram_6110, 8, 0);
                ModeControl_ClearBit(&gIwram_6110, 9, 0);
            }
            if ((u8)gIwram_35E0._field_5 == 2) {
                ModeControl_ClearBit(&gIwram_6110, 8, 1);
                ModeControl_ClearBit(&gIwram_6110, 9, 1);
            }
            if ((u8)gIwram_35E0._field_5 == 3) {
                ModeControl_ClearBit(&gIwram_6110, 8, 1);
                ModeControl_ClearBit(&gIwram_6110, 9, 1);
            }
            frame.spByte = 0;
            break;
        }
        case 5:
            gIwram_5398 = Input_Poll();
            if (Scene_FadeUpdate() == 0) {
                frame.state = 6;
                frame.spByte = 0;
            }
            if (gIwram_5328 == 0)
                frame.state = 3;
            break;
        case 6: {
            s32 counter;
            if ((s8)frame.spByte == 0) {
                Blend_StartFade(0xBF);
                frame.spByte += 1;
            }
            counter = (s8)frame.spByte;
            if (counter != 1)
                break;
            if (Blend_StepFade() != 0)
                break;
            gIwram_3480._data[0] = 4;
            gIwram_3480._data[6] = counter;
            gGameStuff.mode = GAME_MODE_ROUTER;
            break;
        }
        case 7:
            if (RunFadeTransition((u8 *)&frame.spByte, 0x0800a26d) != 0) {
                *(volatile u8 *)&frame.state = 2;
                gGameStuff._unk14 = 0;
                frame.spByte = 0;
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
    } while (gGameStuff.mode == GAME_MODE_SCENE_12 || gGameStuff.mode == GAME_MODE_ATTRACT);
}

void Scene12_InitPlayState(void *buf, void *r4_obj, u32 kind)
{
    gGameStuff.pendingMode = 5;
    EntityScript_BuildSlotData(0, buf);
    Entity_UpdateHitboxSlots(r4_obj, (void *)kind, 5);
}
