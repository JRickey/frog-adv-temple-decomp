#include "iwram.h"
#include "macros.h"
#include "types.h"

struct CenterRect {
    u16 y;
    u16 x;
    u16 height;
    u16 width;
};

struct PackedRect {
    s16 x;
    s16 y;
    s16 height;
    s16 width;
};

extern s32 sub_0800CED0(void *ctx, struct PackedRect rect, s16 c, s16 d);

s32 sub_080076A4(void *ctx, struct CenterRect *rect)
{
    struct PackedRect packed;
    register void *c asm("ip") = ctx;
    struct CenterRect *r;
    u32 widthShift;

    if (c == NULL || rect == NULL)
        return 0;

    widthShift = rect->width << 16;
    packed.x = rect->x - (widthShift >> 17);
    r = rect;
    packed.y = r->y - (r->height >> 1) - 1;
    packed.height = r->height;
    packed.width = widthShift >> 16;

    return sub_0800CED0(ctx, packed, 0, 0);
}
