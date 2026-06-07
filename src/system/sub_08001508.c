#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void Sound_ServiceQueue(void);
extern void Entity_UpdateHitboxSlots(void *sp_buf, void *r4_obj, u32 arg2);
extern u8 RunFadeTransition(u8 *localState, u32 callbackTable);
extern u32 Scene_InitScan(u8 *localState);
extern u16 Input_Poll(void);
extern void Scene_LoadBg(void);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Entity_UpdateHitboxWithTile(void *ent, void *arg1, u32 kind);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s32 tileX, s32 tileY);
extern void Entity_ActivateHitSlot(void *ent, void *arg1, u32 kind, u32 tile);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StepFade(void);
extern void EntityParam_Reset(void);
extern void Game_FrameEnd(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void Scene11_AttractModeMain(void)
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
        Sound_ServiceQueue();
        switch (frame.localState) {
        default:
            goto tail;
        case 0: {
            void *obj;
            obj = frame.r4_obj;
            gGameStuff.pendingMode = 4;
            Entity_UpdateHitboxSlots(frame.sp_buf, obj, 4);
            frame.localState = 1;
            frame.spByte = 0;
            break;
        }
        case 1:
            if (RunFadeTransition((u8 *)&frame.spByte, 0x080017a9) == 0) {
                goto finalize;
            }
            *(volatile u8 *)&frame.localState = 2;
            gGameStuff._unk14 = 0;
            frame.spByte = 0;
            goto finalize;
        case 2:
            if (Scene_InitScan((u8 *)&frame.spByte) == 0)
                goto tail;
            *(volatile u8 *)&frame.localState = 3;
            gGameStuff._unk14 = 0;
            goto tail;
        case 3: {
            register u32 nextState asm("r3");
            struct Entity *p3720;
            void *obj;
            gIwram_5398 = Input_Poll();
            if (gIwram_5398 == 0x40) {
                frame.localState = 5;
                Scene_LoadBg();
                break;
            }
            p3720 = gEntities;
            nextState = 8;
            if ((p3720->status & 8) != 0) {
                frame.localState = 4;
                break;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                frame.localState = nextState;
                break;
            }
            obj = frame.r4_obj;
            Game_RunEntityFrame();
            WaitVblank();
            Game_ForceRender();
            Entity_CheckAllCollisions();
            Player_CheckTileEvents();
            Entity_UpdateHitboxWithTile(frame.sp_buf, obj, 4);
            if ((p3720->status & 4) == 0) {
                u8 tile = (u8)Tilemap_GetTileClass(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                                   gIwram_35E0._field_A);
                if ((gIwram_35E0._field_10 & 0x10) != 0)
                    Entity_ActivateHitSlot(frame.sp_buf, obj, 4, tile);
            }
            gGameStuff._unk14++;
            break;
        }
        case 4: {
            void *obj;
            obj = frame.r4_obj;
            if (Scene_EntityTick(&frame.localState) == 0)
                frame.localState = 7;
            Entity_UpdateHitboxSlots(frame.sp_buf, obj, 4);
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
            gIwram_5398 = Input_Poll();
            if (Scene_FadeUpdate() == 0) {
                frame.localState = 6;
                frame.spByte = 0;
            }
            if (gIwram_5328 == 0)
                frame.localState = 3;
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
                *(volatile u8 *)&frame.localState = 2;
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
    } while (gGameStuff.mode == GAME_MODE_SCENE_11 || gGameStuff.mode == GAME_MODE_ATTRACT);
}

/* Mode-4 re-arm thunk: queues pendingMode = 4, then forwards its two
 * (untouched) register arguments plus the same literal 4 to Entity_UpdateHitboxSlots.
 * agbcc reuses the 4 it materialised for the strb as the third call arg,
 * so the constant is loaded once. */
void Scene11_ArmModeTransition(void *a, void *b)
{
    gGameStuff.pendingMode = 4;
    Entity_UpdateHitboxSlots(a, b, 4);
}
