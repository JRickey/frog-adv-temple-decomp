#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "sound.h"
#include "types.h"

enum {
    CAMERA_TARGET_X = 131,
    CAMERA_TARGET_Y = 323,
    CAMERA_TARGET_Y_SPECIAL = 2315,
    SCREEN_HALF_WIDTH = 120,
    SCREEN_HALF_HEIGHT = 80,
    CAMERA_TRANSITION_SOUND = 98,
    CAMERA_TRANSITION_ACTIVE = 1,
};

extern struct BgScrollState gIwram_60A0[3];

/* Runs the scripted camera transition used by SceneLoop_17. The transition
 * first scrolls toward the caller's vertical offset, then moves the player and
 * its scene-specific companion to the fixed staging point, and finally eases
 * each active BG layer back to a player-centered camera. */
void Scroll_UpdateCameraAlt(s32 countArg, s16 *verticalOffset)
{
    u32 count = (u8)countArg;
    s8 i;

    if (gIwram_6110.scenePhase == 1) {
        if (gIwram_60A0[0].scrollY == gEntities[0].y - *verticalOffset && gIwram_60A0[0].scrollX == 0) {
            gIwram_6110.scenePhase = 2;
        } else {
            for (i = 0; i < (s8)count; i++) {
                if (gIwram_60A0[i].scrollX > 0)
                    gIwram_60A0[i].scrollX--;
                if (gIwram_60A0[i].scrollY != gEntities[0].y - *verticalOffset)
                    gIwram_60A0[i].scrollY--;
            }
            PlayerFlags_Set(&gIwram_35E0, CAMERA_TRANSITION_ACTIVE);
        }
    }

    if (gIwram_6110.scenePhase == 2) {
        for (i = 0; i < (s8)count; i++) {
            gIwram_60A0[i].scrollX = 0;
            gIwram_60A0[i].scrollY = gEntities[0].y - *verticalOffset;
        }
    }

    if (gIwram_6110.scenePhase == 4) {
        if (gIwram_35E0.platformId == 2) {
            if (gEntities[0].x == CAMERA_TARGET_X && gEntities[0].y == CAMERA_TARGET_Y_SPECIAL) {
                gIwram_6110.scenePhase = 5;
            } else {
                if (gEntities[0].x > CAMERA_TARGET_X) {
                    gEntities[0].x--;
                    gEntities[2].x--;
                }
                if (gEntities[0].x <= CAMERA_TARGET_X - 1) {
                    gEntities[0].x++;
                    gEntities[2].x++;
                }
                if (gEntities[0].y > CAMERA_TARGET_Y_SPECIAL) {
                    gEntities[0].y--;
                    gEntities[2].y--;
                }
            }
        } else {
            if (gEntities[0].x == CAMERA_TARGET_X && gEntities[0].y == CAMERA_TARGET_Y) {
                gIwram_6110.scenePhase = 5;
            } else {
                if (gEntities[0].x > CAMERA_TARGET_X) {
                    gEntities[0].x--;
                    gEntities[3].x--;
                }
                if (gEntities[0].x <= CAMERA_TARGET_X - 1) {
                    gEntities[0].x++;
                    gEntities[3].x++;
                }
                if (gEntities[0].y > CAMERA_TARGET_Y) {
                    gEntities[0].y--;
                    gEntities[3].y--;
                }
            }
        }

        for (i = 0; i < (s8)count; i++) {
            gIwram_60A0[i].scrollX = 0;
            gIwram_60A0[i].scrollY = gEntities[0].y - *verticalOffset;
        }
    }

    if (gIwram_6110.scenePhase == 5) {
        if (gIwram_60A0[0].scrollY == gEntities[0].y - SCREEN_HALF_HEIGHT &&
            gIwram_60A0[0].scrollX == gEntities[0].x - SCREEN_HALF_WIDTH) {
            Sound_Play(CAMERA_TRANSITION_SOUND);
            gIwram_6110.scenePhase = 0;
            IwramFlags_Clear(&gIwram_35E0, CAMERA_TRANSITION_ACTIVE);
            gIwram_35E0._field_12 = 0;
        } else {
            for (i = 0; i < (s8)count; i++) {
                if (gIwram_60A0[i].scrollX < gEntities[0].x - SCREEN_HALF_WIDTH)
                    gIwram_60A0[i].scrollX++;
                if (gIwram_60A0[i].scrollX > gEntities[0].x - SCREEN_HALF_WIDTH)
                    gIwram_60A0[i].scrollX--;
                if (gIwram_60A0[i].scrollY != gEntities[0].y - SCREEN_HALF_HEIGHT)
                    gIwram_60A0[i].scrollY++;
            }
        }
    }
}
