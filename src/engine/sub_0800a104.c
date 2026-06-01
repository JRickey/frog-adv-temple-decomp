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

extern u8 sub_0800CED0(void *ctx, struct PackedRect0800A158 rect, s16 c, s16 d);
extern u16 sub_08010694(u16 arg);
extern int sub_080106B8(void);
extern u16 sub_080106EC(u16 arg);
extern int sub_08010710(void);

int sub_0800A104(s8 *phase, GameProc callback)
{
    int p = (s8)*phase;

    if (p == 0) {
        sub_08010694(0xBF);
        goto advance;
    }
    if (p == 1) {
        if (sub_080106B8() != 0)
            goto zero_return;
        goto advance;
    }
    if (p == 2) {
        callback();
        sub_080106EC(0xBF);
    advance:
        *phase = *phase + 1;
    zero_return:
        return 0;
    }
    if (p == 3) {
        if (sub_08010710() == 0)
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

u8 sub_0800A158(void *ctx, struct EntityBounds0800A158 *entity)
{
    struct PackedRect0800A158 rect;

    rect.x = entity->y + entity->yOffset - entity->width;
    rect.y = entity->x + entity->xOffset - (entity->height >> 1);
    rect.height = entity->height;
    rect.width = entity->width;

    return sub_0800CED0(ctx, rect, 0, 0);
}
