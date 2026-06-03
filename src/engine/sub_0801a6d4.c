#include "iwram.h"
#include "types.h"

/* Per-scene scroll-clamp, sibling of sub_0800F24C (same SceneScrollState
 * layout at 0x030060A0, same camera target at gIwram_3720). Walks `count`
 * scroll-state entries and clamps each one's scroll origin to the camera
 * target, bounded below by 0 and above by the entry's tile extent. */

enum {
    SCREEN_HALF_WIDTH = 120,
    SCREEN_CLAMP_Y = 104,
    SCREEN_CLAMP_HEIGHT = 160,
    TILE_PIXELS_SHIFT = 3,
};

struct SceneScrollState_A6D4 {
    u8 _pad00[12];
    s32 scrollX;
    s32 scrollY;
    u8 _pad14[4];
    u16 tileHeight;
    u16 tileWidth;
    u8 _pad1c[4];
};

struct ScrollCameraTarget_A6D4 {
    u8 _pad00[2];
    s16 x;
    s16 y;
};

void sub_0801A6D4(u8 countArg)
{
    /* count holds the loop bound across the body; pinned to r8 (vs. ip) so
     * scrollStates lands in ip, matching the baserom allocation. */
    register u32 count asm("r8");

    struct SceneScrollState_A6D4 *scrollStates;
    struct ScrollCameraTarget_A6D4 *cameraTarget;
    /* stateOffset (i * sizeof entry) is the Rn of the address adds; pinned to
     * r2 to keep `adds Rd, r2, <base+off>` in the baserom's operand order. */
    register s32 stateOffset asm("r2");
    s32 *scrollX;
    s32 *scrollY;
    struct SceneScrollState_A6D4 *state;
    s32 targetX;
    register s32 targetY asm("r1");
    u8 stateIndex;

    count = countArg;
    stateIndex = 0;
    if (stateIndex >= count) {
        return;
    }
    scrollStates = (struct SceneScrollState_A6D4 *)0x030060A0;
    cameraTarget = (struct ScrollCameraTarget_A6D4 *)&gIwram_3720;
    do {
        u32 scrollXBase;
        u32 scrollYBase;
        stateOffset = stateIndex * sizeof(struct SceneScrollState_A6D4);
        scrollXBase = (u32)&scrollStates->scrollX;
        scrollX = (s32 *)(stateOffset + scrollXBase);
        *scrollX = cameraTarget->x - SCREEN_HALF_WIDTH;
        scrollYBase = (u32)&scrollStates->scrollY;
        scrollY = (s32 *)(stateOffset + scrollYBase);
        *scrollY = cameraTarget->y - SCREEN_CLAMP_Y;
        if (cameraTarget->x <= SCREEN_HALF_WIDTH) {
            *scrollX = 0;
        }
        if (cameraTarget->y <= SCREEN_CLAMP_Y) {
            *scrollY = 0;
        }

        targetX = cameraTarget->x;
        state = (struct SceneScrollState_A6D4 *)(stateOffset + (u32)scrollStates);
        {
            /* rawX/shiftedX pinned to r0/r2 to reuse the stride register and
             * keep the shifted limit in the baserom's registers. */
            register u32 rawX asm("r0");
            register u32 shiftedX asm("r2");
            s32 limitX;

            rawX = state->tileWidth;
            shiftedX = rawX << TILE_PIXELS_SHIFT;
            limitX = (s32)shiftedX - SCREEN_HALF_WIDTH;

            if (targetX >= limitX) {
                *scrollX = limitX - SCREEN_HALF_WIDTH;
            }
        }

        targetY = cameraTarget->y;
        {
            register u32 shiftedY asm("r2");
            register u32 rawY asm("r3");
            s32 limitY;

            rawY = state->tileHeight;
            shiftedY = rawY << TILE_PIXELS_SHIFT;
            limitY = (s32)shiftedY - SCREEN_CLAMP_Y;

            if (targetY >= limitY) {
                *scrollY = limitY - (SCREEN_CLAMP_HEIGHT - SCREEN_CLAMP_Y);
            }
        }
        stateIndex++;
    } while (stateIndex < count);
}
