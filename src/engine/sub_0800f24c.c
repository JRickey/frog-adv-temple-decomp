#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

#define SCROLL_STATE_BASE ((struct SceneScrollState *)0x030060A0)

enum {
    SCROLL_SKIP_PENDING_MODE = 6,
    SCREEN_HALF_WIDTH = 120,
    SCREEN_HALF_HEIGHT = 80,
    TILE_PIXELS_SHIFT = 3,
};

struct SceneScrollState {
    u8 _pad00[12];
    s32 scrollX;
    s32 scrollY;
    u8 _pad14[4];
    u16 tileHeight;
    u16 tileWidth;
    u8 _pad1c[4];
};

struct ScrollCameraTarget {
    u8 _pad00[2];
    s16 x;
    s16 y;
};

void Scroll_UpdateCamera(u8 countArg)
{
    u32 stateCount = countArg;
    struct SceneScrollState *scrollStates;
    struct ScrollCameraTarget *cameraTarget;
    register s32 r2v asm("r2");
    s32 *scrollX;
    s32 *scrollY;
    struct SceneScrollState *state;
    s32 targetX;
    register s32 targetY asm("r1");
    u8 stateIndex;

    if (gGameStuff.sceneType == SCROLL_SKIP_PENDING_MODE) {
        return;
    }
    stateIndex = 0;
    if (stateIndex >= stateCount) {
        return;
    }
    scrollStates = SCROLL_STATE_BASE;
    cameraTarget = (struct ScrollCameraTarget *)gEntities;
    do {
        u32 scrollXBase;
        u32 scrollYBase;
        r2v = stateIndex * sizeof(struct SceneScrollState);
        scrollXBase = (u32)&scrollStates->scrollX;
        scrollX = (s32 *)(r2v + scrollXBase);
        *scrollX = cameraTarget->x - SCREEN_HALF_WIDTH;
        scrollYBase = (u32)&scrollStates->scrollY;
        scrollY = (s32 *)(r2v + scrollYBase);
        *scrollY = cameraTarget->y - SCREEN_HALF_HEIGHT;
        if (cameraTarget->x <= SCREEN_HALF_WIDTH - 1) {
            *scrollX = 0;
        }
        if (cameraTarget->y <= SCREEN_HALF_HEIGHT - 1) {
            *scrollY = 0;
        }

        targetX = cameraTarget->x;
        state = (struct SceneScrollState *)(r2v + (u32)scrollStates);
        {
            register u32 rawX asm("r0");
            s32 limitX;

            rawX = state->tileWidth;
            r2v = rawX << TILE_PIXELS_SHIFT;
            limitX = r2v - SCREEN_HALF_WIDTH;

            if (targetX > limitX) {
                *scrollX = limitX - SCREEN_HALF_WIDTH;
            }
        }

        targetY = cameraTarget->y;
        {
            register u32 rawY asm("r3");
            s32 limitY;

            rawY = state->tileHeight;
            r2v = rawY << TILE_PIXELS_SHIFT;
            limitY = r2v - SCREEN_HALF_HEIGHT;

            if (targetY > limitY) {
                *scrollY = limitY - SCREEN_HALF_HEIGHT;
            }
        }
        stateIndex++;
    } while (stateIndex < stateCount);
}
