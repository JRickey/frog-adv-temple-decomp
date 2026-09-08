#include "entity.h"
#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "types.h"

typedef void (*GameProc)(void);

extern void Sound_ServiceQueue(void);
extern void EntityScript_BuildSlotData(u8 partId, u8 *out);
extern void Entity_SetupHitboxSlots(CollisionSlot *slots, unsigned long long *out, s8 type);
extern int RunFadeTransition(s8 *phase, GameProc callback);
extern u32 Scene_InitScan(u8 *state);
extern u32 Input_Poll(void);
extern void Scene_LoadBg(void);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Scene_UpdateCollisionAndTile(u32 arg0, u32 arg1, u32 arg2, u32 arg3, void *arg4, void *arg5);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StepFade(void);
extern void EntityParam_Reset(void);
extern void Game_FrameEnd(void);
extern void Mode12_Init(void);

#define gIwram_5398 (*(u16 *)0x03005398)
#define gIwram_5328 (*(u8 *)0x03005328)

static inline void Scene18_Setup(u8 *script, CollisionSlot *slots6, unsigned long long *mask6, CollisionSlot *slots7,
                                 unsigned long long *mask7, CollisionSlot *slots22, unsigned long long *mask22)
{
    gGameStuff.sceneType = 11;
    EntityScript_BuildSlotData(1, script);
    Entity_UpdateHitboxSlots(slots6, mask6, 6);
    Entity_UpdateHitboxSlots(slots7, mask7, 7);
    Entity_SetupHitboxSlots(slots22, mask22, 22);
}

static inline void Scene18_Update(u8 *script, CollisionSlot *slots6, unsigned long long *mask6, CollisionSlot *slots7,
                                  unsigned long long *mask7, CollisionSlot *slots22, unsigned long long *mask22)
{
    Entity_RunScript(1, script);
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    Scene_UpdateCollisionAndTile((u32)slots6, (u32)mask6, (u32)slots7, (u32)mask7, slots22, mask22);
    gGameStuff._unk14++;
}

static inline void Scene18_InitHitboxes(u8 *state, CollisionSlot *slots6, unsigned long long *mask6,
                                        CollisionSlot *slots7, unsigned long long *mask7, CollisionSlot *slots22,
                                        unsigned long long *mask22)
{
    if (Scene_EntityTick(state) == 0)
        *state = 7;
    Entity_UpdateHitboxSlots(slots6, mask6, 6);
    Entity_UpdateHitboxSlots(slots7, mask7, 7);
    Entity_SetupHitboxSlots(slots22, mask22, 22);
}

void GameMode_Scene18(void)
{
    CollisionSlot slots6[42];
    CollisionSlot slots7[29];
    CollisionSlot slots22[12];
    u8 script[108];
    s8 accept;
    u8 state;
    unsigned long long mask6Storage;
    unsigned long long mask7Storage;
    unsigned long long mask22Storage;

    state = 0;
    goto tail;

    do {
        Sound_ServiceQueue();
        switch (state) {
        default:
            goto tail;
        case 0:
            Scene18_Setup(script, slots6, &mask6Storage, slots7, &mask7Storage, slots22, &mask22Storage);
            state = 1;
            accept = 0;
            break;
        case 1:
            if ((u8)RunFadeTransition(&accept, Mode12_Init) == 0)
                goto finalize;
            state = 2;
            gGameStuff._unk14 = 0;
            accept = 0;
            goto finalize;
        case 2:
            if (Scene_InitScan((u8 *)&accept) == 0)
                goto tail;
            state = 3;
            gGameStuff._unk14 = 0;
            goto tail;
        case 3: {
            gIwram_5398 = Input_Poll();
            if (gIwram_5398 == 0x40) {
                state = 5;
                Scene_LoadBg();
                break;
            }
            if ((gEntities[0].status & 8) != 0) {
                state = 4;
                break;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                state = 8;
                break;
            }
            Scene18_Update(script, slots6, &mask6Storage, slots7, &mask7Storage, slots22, &mask22Storage);
            break;
        }
        case 4:
            Scene18_InitHitboxes(&state, slots6, &mask6Storage, slots7, &mask7Storage, slots22, &mask22Storage);
            accept = 0;
            break;
        case 5:
            gIwram_5398 = Input_Poll();
            if (Scene_FadeUpdate() == 0) {
                state = 6;
                accept = 0;
            }
            if (gIwram_5328 == 0)
                state = 3;
            break;
        case 6: {
            s32 counter;
            if (accept == 0) {
                Blend_StartFade(0xBF);
                accept++;
            }
            counter = accept;
            if (counter != 1)
                break;
            if (Blend_StepFade() != 0)
                break;
            gIwram_3480.subState = 4;
            gIwram_3480.reloadFlag = counter;
            gGameStuff.mode = GAME_MODE_ROUTER;
            break;
        }
        case 7:
            if ((u8)RunFadeTransition(&accept, (GameProc)0x0800A26D) != 0) {
                state = 2;
                gGameStuff._unk14 = 0;
                accept = 0;
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
    } while (gGameStuff.mode == GAME_MODE_SCENE_18 || gGameStuff.mode == GAME_MODE_ATTRACT);
}
