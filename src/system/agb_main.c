#include "game.h"
#include "gba/io.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void Init1(void);                   /* Init1 */
extern u16 Input_Poll(void);               /* boot helper — returns u16 stored at gIwram_5398 */
extern void Scene08_Main(void);            /* mode 8 handler */
extern void WaitVblank(void);              /* shared per-frame finalize (tail) */
extern void Scene09_Run(void);             /* mode 9 */
extern void Scene10_Main(void);            /* mode 10 */
extern void Scene11_AttractModeMain(void); /* mode 11 */
extern void Scene12_Main(void);            /* mode 12 */
extern void Scene13_Update(void);          /* mode 13 */
extern void SceneLoop_14(void);            /* mode 14 */
extern void Scene15_Main(void);            /* mode 15 */
extern void SceneLoop_16(void);            /* mode 16 */
extern void SceneLoop_17(void);            /* mode 17 */
extern void GameMode_Scene18(void);        /* mode 18 */
extern void GameMode_Scene19(void);        /* mode 19 */
extern void SceneLoop_20(void);            /* mode 20 */
extern void SceneLoop_21(void);            /* mode 21 */
extern void SceneLoop_22(void);            /* mode 22 */
extern void GameMode_Scene23(void);        /* mode 23 */
extern void GameMode_Attract(void);        /* mode 24 */
extern void GameMode_Router(void);         /* boot helper, second call */
extern void GameMode_Menu26(void);         /* mode 26 */
extern void GameMode_Menu25(void);         /* mode 25 */
extern void GameMode_WorldMap(u8 arg);     /* mode 29 */
extern void GameMode_Options(void);        /* mode 6 */
extern void GameMode_Menu07(void);         /* mode 7 */
extern void GameMode_Menu27(void);         /* mode 27 */
extern void GameMode_FileSelect(void);     /* mode 5 */
extern void Sound_ServiceQueue(void);      /* Init2 / per-frame tick */

extern u16 gIwram_5398;
#define gIwram_3540 (*(u8 *)0x03003540)

void AgbMain(void)
{
    REG_WAITCNT = 0x4014;
    Init1(); /* Init1 */
    gGameStuff.mode = GAME_MODE_ROUTER;

    for (;;) {
        Sound_ServiceQueue(); /* per-frame tick / VBlank wait */
        /* Agbcc sorts the jump table by case value, but emits bodies in source order. */
        switch (gGameStuff.mode) {
        case GAME_MODE_ROUTER: {
            gIwram_5398 = Input_Poll();
            GameMode_Router();
            /* Read gIwram_3480.routerSelection twice in baserom — the second load
             * is used for the {3, 2, 4} compares. */
            if (gIwram_3480.routerSelection == 1)
                gGameStuff.mode = GAME_MODE_FILE_SELECT;
            if (gIwram_3480.routerSelection == 3)
                gGameStuff.mode = GAME_MODE_MENU_07;
            if (gIwram_3480.routerSelection == 2)
                gGameStuff.mode = GAME_MODE_OPTIONS;
            if (gIwram_3480.routerSelection == 4)
                gGameStuff.mode = GAME_MODE_ATTRACT;
            break;
        }
        case GAME_MODE_ATTRACT:
            GameMode_Attract();
            break;
        case GAME_MODE_SCENE_08:
            Scene08_Main();
            break;
        case GAME_MODE_SCENE_09:
            Scene09_Run();
            break;
        case GAME_MODE_SCENE_10:
            Scene10_Main();
            break;
        case GAME_MODE_SCENE_11:
            Scene11_AttractModeMain();
            break;
        case GAME_MODE_SCENE_12:
            Scene12_Main();
            break;
        case GAME_MODE_SCENE_13:
            Scene13_Update();
            break;
        case GAME_MODE_SCENE_14:
            SceneLoop_14();
            break;
        case GAME_MODE_SCENE_15:
            Scene15_Main();
            break;
        case GAME_MODE_SCENE_16:
            SceneLoop_16();
            break;
        case GAME_MODE_SCENE_17:
            SceneLoop_17();
            break;
        case GAME_MODE_SCENE_18:
            GameMode_Scene18();
            break;
        case GAME_MODE_SCENE_19:
            GameMode_Scene19();
            break;
        case GAME_MODE_SCENE_20:
            SceneLoop_20();
            break;
        case GAME_MODE_SCENE_21:
            SceneLoop_21();
            break;
        case GAME_MODE_SCENE_22:
            SceneLoop_22();
            break;
        case GAME_MODE_SCENE_23:
            GameMode_Scene23();
            break;
        case GAME_MODE_MENU_25:
            GameMode_Menu25();
            break;
        case GAME_MODE_MENU_07:
            GameMode_Menu07();
            break;
        case GAME_MODE_OPTIONS:
            GameMode_Options();
            break;
        case GAME_MODE_MENU_26:
            GameMode_Menu26();
            break;
        case GAME_MODE_MENU_27:
            GameMode_Menu27();
            break;
        case GAME_MODE_FILE_SELECT:
            GameMode_FileSelect();
            break;
        case GAME_MODE_WORLD_MAP:
            GameMode_WorldMap(gIwram_3540);
            break;
        case GAME_MODE_NO_HANDLER: /* shared-tail fallthrough — no per-mode handler */
            break;
        default:
            break; /* mode out of range -> straight to tail */
        }
        WaitVblank(); /* per-frame finalize */
    }
}
