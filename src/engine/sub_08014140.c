#include "macros.h"
#include "types.h"

/* --- AnimState_BlitStep: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "macros.h"
#include "types.h"

enum AnimStepMode {
    ANIM_STEP_DOWN = 1,
    ANIM_STEP_UP = 2,
    ANIM_STEP_RIGHT = 3,
    ANIM_STEP_LEFT = 4,
};

struct AnimState {
    u8 _pad00[4];
    u32 field_04;
    u8 idx;
    u8 field_09;
    u8 _pad0a;
    u8 field_0b;
    u32 field_0c;
    u32 field_10;
    u8 _pad14[24];
    u16 field_2c;
    u16 field_2e;
    u16 field_30;
    u16 field_32;
    u16 field_34;
    u16 field_36;
};

struct BlitState_14140 {
    u8 _pad00[26];
    u16 stride;
};

#define gBlitState_14140 (*(struct BlitState_14140 *)0x030060A0)

struct BgFlag_14140 {
    u8 _pad00;
    u8 dirty;
};

#define gBgFlag_14140 (*(struct BgFlag_14140 *)0x03003610)

u8 AnimState_BlitStep(struct AnimState *p0, u8 step)
{
    register struct AnimState *p asm("r4") = p0;
    register u32 counter asm("r2");
    u16 oldField2e[1];
    u16 oldField2c;
    register u16 oldField34 asm("sl");
    u32 oldField36[1];
    register u32 old10 asm("r8");
    register int f9 asm("r9");
    register u32 rows asm("ip");
    u8 cols;
    u8 t9;
    u8 mode;
    u8 hi;
    s32 v34;
    s32 v36;
    s32 t34;
    s32 t36;
    u16 *dst;
    register u16 *src asm("r3");
    u16 stride;
    u8 row;
    register u8 c asm("r2");

    counter = gGameStuff._unk00;
    if (counter - p->field_04 < p->field_0b) {
        return 0;
    }

    oldField2e[0] = p->field_2e;
    if ((s16)p->field_2e == 0) {
        return 1;
    }

    oldField2c = p->field_2c;
    if ((s16)p->field_2c == 0) {
        return 1;
    }

    p->field_04 = counter;
    oldField34 = p->field_34;
    oldField36[0] = p->field_36;
    old10 = p->field_10;
    p->field_0c = old10;
    t9 = p->field_09;
    mode = t9 & 0xF;
    f9 = t9;

    switch (mode) {
    case ANIM_STEP_DOWN:
        p->field_36 += step;
        p->field_2e = oldField2e[0] - step;
        rows = step;
        cols = (u8)oldField2c;
        p->field_10 = old10 + rows * p->field_30 * 2;
        break;
    case ANIM_STEP_UP:
        p->field_36 -= step;
        p->field_2e = oldField2e[0] - step;
        rows = step;
        cols = (u8)oldField2c;
        p->field_10 = old10 - rows * p->field_30 * 2;
        break;
    case ANIM_STEP_RIGHT:
        p->field_34 += step;
        p->field_2c = oldField2c - step;
        cols = step;
        rows = (u8)oldField2e[0];
        p->field_10 = old10 + (step << 1);
        break;
    case ANIM_STEP_LEFT:
        p->field_34 -= step;
        p->field_2c = oldField2c - step;
        cols = step;
        rows = (u8)oldField2e[0];
        p->field_10 = old10 - (step << 1);
        break;
    }

    gBgFlag_14140.dirty = 1;

    hi = (u8)f9 >> 4;
    t34 = (s32)oldField34 << 16;
    t36 = (s32)oldField36[0] << 16;
    v34 = t34 >> 16;
    v36 = t36 >> 16;

    switch (hi) {
    case 0:
        dst = (u16 *)0x02000000;
        break;
    case 1:
        dst = (u16 *)0x02010000;
        break;
    case 2:
        dst = (u16 *)0x02020000;
        break;
    }

    dst += v34 + gBlitState_14140.stride * v36;
    src = (u16 *)p->field_0c;

    row = 0;
    while (row < rows) {
        u8 next = row + 1;
        for (c = 0; c < cols; c++) {
            *dst++ = *src++;
        }
        dst += gBlitState_14140.stride - cols;
        src += p->field_30 - cols;
        row = next;
    }

    return 0;
}
#else
NAKED void AnimState_BlitStep(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x14140, 0x194\n");
}
#endif /* NON_MATCHING */
