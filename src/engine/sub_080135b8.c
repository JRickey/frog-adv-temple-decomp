#include "macros.h"
#include "types.h"

/* --- Selector_StepScrollAxes: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "macros.h"
#include "types.h"
#include "game.h"

enum ScrollAxisKind {
    SCROLL_AXIS_Y_FORWARD = 1,
    SCROLL_AXIS_Y_BACKWARD = 2,
    SCROLL_AXIS_X_BACKWARD = 3,
    SCROLL_AXIS_X_FORWARD = 4,
};

struct ScrollAxisX {
    u8 _pad00[4];
    u32 lastTick;
    u8 _pad08;
    u8 kind;
    u8 _pad0a;
    u8 interval;
    u8 _pad0c[0x20];
    s16 delta;
    u8 _pad2e[6];
    s16 pos;
};

struct ScrollAxisY {
    u8 _pad00[4];
    u32 lastTick;
    u8 _pad08;
    u8 kind;
    u8 _pad0a;
    u8 interval;
    u8 _pad0c[0x22];
    s16 delta;
    u8 _pad30[6];
    s16 pos;
};

extern struct ScrollAxisX gIwram_6540;
extern struct ScrollAxisY gIwram_6480;

void Selector_StepScrollAxes(u16 maxX, u8 stepX, u16 maxY, u8 stepY)
{
    struct ScrollAxisX *x;
    struct ScrollAxisY *y;
    GameStuff *gs;
    u8 kind;

    gIwram_6540.delta = 0;
    gIwram_6480.delta = 0;

    x = &gIwram_6540;
    y = &gIwram_6480;

    kind = x->kind;
    if (kind != 0) {
        gs = &gGameStuff;
        if (gs->_unk00 - x->lastTick >= x->interval) {
            if (kind == SCROLL_AXIS_X_FORWARD) {
                if ((s32)x->pos <= (s32)(s16)maxX)
                    x->pos += stepX;
                x->delta = stepX;
            }
            if (x->kind == SCROLL_AXIS_X_BACKWARD) {
                if ((s32)x->pos >= (s32)(s16)maxX)
                    x->pos -= stepX;
                x->delta = -stepX;
            }
            x->lastTick = gs->_unk00;
        }
    }

    kind = y->kind;
    if (kind != 0) {
        gs = &gGameStuff;
        if (gs->_unk00 - y->lastTick >= y->interval) {
            if (kind == SCROLL_AXIS_Y_FORWARD) {
                if ((s32)y->pos <= (s32)(s16)maxY)
                    y->pos += stepY;
                y->delta = stepY;
            }
            if (y->kind == SCROLL_AXIS_Y_BACKWARD) {
                if ((s32)y->pos >= (s32)(s16)maxY)
                    y->pos -= stepY;
                y->delta = -stepY;
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
