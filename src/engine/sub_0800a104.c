#include "game.h"
#include "iwram.h"
#include "types.h"

typedef void (*GameProc)(void);

struct PackedRect0800A158 {
    s16 x;
    s16 y;
    s16 height;
    s16 width;
};

struct EntityBounds0800A158 {
    u8 _pad00[2];
    u16 x;
    u16 y;
    u8 _pad06[0x1E];
    u16 xOffset;
    u16 yOffset;
    u8 height;
    u8 width;
};

extern u8 Rect_PointInRect(void *ctx, struct PackedRect0800A158 rect, s16 c, s16 d);
extern u16 Blend_StartFade(u16 arg);
extern int Blend_StepFade(void);
extern u16 Screen_BeginFlash(u16 arg);
extern int Screen_TickFlash(void);

int RunFadeTransition(s8 *phase, GameProc callback)
{
    int p = (s8)*phase;

    if (p == 0) {
        Blend_StartFade(0xBF);
        goto advance;
    }
    if (p == 1) {
        if (Blend_StepFade() != 0)
            goto zero_return;
        goto advance;
    }
    if (p == 2) {
        callback();
        Screen_BeginFlash(0xBF);
    advance:
        *phase = *phase + 1;
    zero_return:
        return 0;
    }
    if (p == 3) {
        if (Screen_TickFlash() == 0)
            return 1;
        {
            int ret;
            /* Keep phase 3's zero return distinct from the shared 0/1/2 return. */
            asm("" : "=r"(ret) : "0"(0));
            return ret;
        }
    }
    return p;
}

u8 Entity_RectOverlap(void *ctx, struct EntityBounds0800A158 *entity)
{
    struct PackedRect0800A158 rect;

    rect.x = entity->y + entity->yOffset - entity->width;
    rect.y = entity->x + entity->xOffset - (entity->height >> 1);
    rect.height = entity->height;
    rect.width = entity->width;

    return Rect_PointInRect(ctx, rect, 0, 0);
}
