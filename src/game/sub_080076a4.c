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

s32 sub_08007714(void *ctx, struct CenterRect *rect, u16 c, u16 d)
{
    struct PackedRect packed;
    struct CenterRect *r;
    /* The two extra args (c->r9, d->sl) raise register pressure so that one of
     * the long-lived width<<16 value and the recovered height must spill to ip.
     * The baserom keeps width<<16 in a low reg (r5) and spills the recovered
     * height to ip; agbcc's default coloring does the opposite. Pinning the
     * width-shift to r5 forces rect into r4 and the height spill into ip. */
    register u32 widthShift asm("r5");

    if (ctx == NULL || rect == NULL)
        return 0;

    widthShift = rect->width << 16;
    packed.x = rect->x - (widthShift >> 17);
    r = rect;
    packed.y = r->y - (r->height >> 1) - 1;
    packed.height = r->height;
    packed.width = widthShift >> 16;

    return sub_0800CED0(ctx, packed, c, d);
}
