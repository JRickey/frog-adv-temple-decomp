#include "types.h"

struct Sub08012604Args {
    u8 pad00[4];
    u8 unk04;
    u8 pad05[9];
    u8 unk0E;
    u8 pad0F[5];
    u8 unk14;
};

struct Sub08012604State {
    u8 pad00[4];
    u32 unk04;
    u8 pad08[6];
    s16 unk0E;
};

extern void sub_0801223C(u8 a, u8 b, u8 c, u8 d, u8 e);
extern void sub_08012180(void);
extern void sub_08015B20(u32 arg);

u32 sub_08012604(void)
{
    register u32 ret asm("r4") = 0;
    struct Sub08012604Args *a = (struct Sub08012604Args *)0x08306e08;
    struct Sub08012604Args *b;
    struct Sub08012604State *state0;
    struct Sub08012604State *state1;
    u8 a0;
    u8 a1;
    s32 temp;

    a0 = a->unk04;
    a1 = a->unk14;
    b = (struct Sub08012604Args *)0x08306e28;
    sub_0801223C(a0, a1, b->unk04, b->unk04, b->unk0E);
    sub_08012180();

    state0 = (struct Sub08012604State *)0x03006150;
    if (state0->unk04 != 0) {
        return ret;
    }

    state1 = (struct Sub08012604State *)0x03005360;
    if (state1->unk04 != 0) {
        return ret;
    }

    temp = *(s16 *)((u8 *)state1 + 0x0E);
    if (temp != 0) {
        return ret;
    }

    sub_08015B20(0);
    sub_08015B20(1);
    ret = 1;
    return ret;
}
