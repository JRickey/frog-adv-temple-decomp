#include "macros.h"
#include "types.h"

/* --- Selector_StepScrollAxes: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "macros.h"
#include "types.h"
#include "game.h"
#include "iwram.h"

enum ScrollAxisKind {
    SCROLL_AXIS_Y_FORWARD = 1,
    SCROLL_AXIS_Y_BACKWARD = 2,
    SCROLL_AXIS_X_BACKWARD = 3,
    SCROLL_AXIS_X_FORWARD = 4,
};

/* gIwram_6540 is the X axis (step at _field_2c, target/pos at _field_34);
 * gIwram_6480 is the Y axis (step at _field_2e, target/pos at _field_36).
 * phase doubles as the per-axis direction tag (1..4); frameCtr as the
 * inter-step interval. */
extern struct ScrollBlitLayer gIwram_6540;
extern struct ScrollBlitLayer gIwram_6480;

void Selector_StepScrollAxes(u16 maxX, u8 stepX, u16 maxY, u8 stepY)
{
    struct ScrollBlitLayer *x;
    struct ScrollBlitLayer *y;
    GameStuff *gs;
    u8 kind;

    gIwram_6540._field_2c = 0;
    gIwram_6480._field_2e = 0;

    x = &gIwram_6540;
    y = &gIwram_6480;

    kind = x->phase;
    if (kind != 0) {
        gs = &gGameStuff;
        if (gs->_unk00 - x->lastTick >= x->frameCtr) {
            if (kind == SCROLL_AXIS_X_FORWARD) {
                if ((s32)(s16)x->_field_34 <= (s32)(s16)maxX)
                    x->_field_34 += stepX;
                x->_field_2c = stepX;
            }
            if (x->phase == SCROLL_AXIS_X_BACKWARD) {
                if ((s32)(s16)x->_field_34 >= (s32)(s16)maxX)
                    x->_field_34 -= stepX;
                x->_field_2c = -stepX;
            }
            x->lastTick = gs->_unk00;
        }
    }

    kind = y->phase;
    if (kind != 0) {
        gs = &gGameStuff;
        if (gs->_unk00 - y->lastTick >= y->frameCtr) {
            if (kind == SCROLL_AXIS_Y_FORWARD) {
                if ((s32)y->_field_36 <= (s32)(s16)maxY)
                    y->_field_36 += stepY;
                y->_field_2e = stepY;
            }
            if (y->phase == SCROLL_AXIS_Y_BACKWARD) {
                if ((s32)y->_field_36 >= (s32)(s16)maxY)
                    y->_field_36 -= stepY;
                y->_field_2e = -stepY;
            }
            y->lastTick = gs->_unk00;
        }
    }
}
#else
NAKED void Selector_StepScrollAxes(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x135b8, 0xdc\n");
}
#endif /* NON_MATCHING */
