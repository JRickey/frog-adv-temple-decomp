#include "game.h"
#include "gba/io.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08000430(void);   /* Init1 */
extern u16 sub_080004C4(void);    /* boot helper — returns u16 stored at gIwram_5398 */
extern void sub_08000918(void);   /* mode 8 handler */
extern void sub_080008DC(void);   /* shared per-frame finalize (tail) */
extern void sub_08000EB8(void);   /* mode 9 */
extern void sub_08001214(void);   /* mode 10 */
extern void sub_08001508(void);   /* mode 11 */
extern void sub_080019B4(void);   /* mode 12 */
extern void sub_08002184(void);   /* mode 13 */
extern void sub_08002524(void);   /* mode 14 */
extern void sub_08002844(void);   /* mode 15 */
extern void sub_08002B58(void);   /* mode 16 */
extern void sub_0800336C(void);   /* mode 17 */
extern void sub_08003864(void);   /* mode 18 */
extern void sub_08003CA8(void);   /* mode 19 */
extern void sub_0800411C(void);   /* mode 20 */
extern void sub_08004938(void);   /* mode 21 */
extern void sub_08004FAC(void);   /* mode 22 */
extern void sub_080054A8(void);   /* mode 23 */
extern void sub_0801793C(void);   /* mode 24 */
extern void sub_08019500(void);   /* boot helper, second call */
extern void sub_08019540(void);   /* mode 26 */
extern void sub_08019560(void);   /* mode 25 */
extern void sub_0801A268(u8 arg); /* mode 29 */
extern void sub_080201A8(void);   /* mode 6 */
extern void sub_080201C8(void);   /* mode 7 */
extern void sub_080201E8(void);   /* mode 27 */
extern void sub_080202A8(void);   /* mode 5 */
extern void sub_08020BC0(void);   /* Init2 / per-frame tick */

extern u16 gIwram_5398;
#define gIwram_3540 (*(u8 *)0x03003540)

void AgbMain(void)
{
    REG_WAITCNT = 0x4014;
    sub_08000430(); /* Init1 */
    gGameStuff.mode = GAME_MODE_ROUTER;

    for (;;) {
        sub_08020BC0(); /* per-frame tick / VBlank wait */
        /* Agbcc sorts the jump table by case value, but emits bodies in source order. */
        switch (gGameStuff.mode) {
        case GAME_MODE_ROUTER: {
            gIwram_5398 = sub_080004C4();
            sub_08019500();
            /* Read gIwram_3480._data[5] twice in baserom — the second load
             * is used for the {3, 2, 4} compares. */
            if (gIwram_3480._data[5] == 1)
                gGameStuff.mode = GAME_MODE_FILE_SELECT;
            if (gIwram_3480._data[5] == 3)
                gGameStuff.mode = GAME_MODE_MENU_07;
            if (gIwram_3480._data[5] == 2)
                gGameStuff.mode = GAME_MODE_OPTIONS;
            if (gIwram_3480._data[5] == 4)
                gGameStuff.mode = GAME_MODE_ATTRACT;
            break;
        }
        case GAME_MODE_ATTRACT:
            sub_0801793C();
            break;
        case GAME_MODE_SCENE_08:
            sub_08000918();
            break;
        case GAME_MODE_SCENE_09:
            sub_08000EB8();
            break;
        case GAME_MODE_SCENE_10:
            sub_08001214();
            break;
        case GAME_MODE_SCENE_11:
            sub_08001508();
            break;
        case GAME_MODE_SCENE_12:
            sub_080019B4();
            break;
        case GAME_MODE_SCENE_13:
            sub_08002184();
            break;
        case GAME_MODE_SCENE_14:
            sub_08002524();
            break;
        case GAME_MODE_SCENE_15:
            sub_08002844();
            break;
        case GAME_MODE_SCENE_16:
            sub_08002B58();
            break;
        case GAME_MODE_SCENE_17:
            sub_0800336C();
            break;
        case GAME_MODE_SCENE_18:
            sub_08003864();
            break;
        case GAME_MODE_SCENE_19:
            sub_08003CA8();
            break;
        case GAME_MODE_SCENE_20:
            sub_0800411C();
            break;
        case GAME_MODE_SCENE_21:
            sub_08004938();
            break;
        case GAME_MODE_SCENE_22:
            sub_08004FAC();
            break;
        case GAME_MODE_SCENE_23:
            sub_080054A8();
            break;
        case GAME_MODE_MENU_25:
            sub_08019560();
            break;
        case GAME_MODE_MENU_07:
            sub_080201C8();
            break;
        case GAME_MODE_OPTIONS:
            sub_080201A8();
            break;
        case GAME_MODE_MENU_26:
            sub_08019540();
            break;
        case GAME_MODE_MENU_27:
            sub_080201E8();
            break;
        case GAME_MODE_FILE_SELECT:
            sub_080202A8();
            break;
        case GAME_MODE_WORLD_MAP:
            sub_0801A268(gIwram_3540);
            break;
        case GAME_MODE_NO_HANDLER: /* shared-tail fallthrough — no per-mode handler */
            break;
        default:
            break; /* mode out of range -> straight to tail */
        }
        sub_080008DC(); /* per-frame finalize */
    }
}
