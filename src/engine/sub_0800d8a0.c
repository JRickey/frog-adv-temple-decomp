#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u32 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_0802C7EC(void);
extern void sub_0802CA64(void);
extern void sub_0802C000(void);
extern void sub_0802BF58(void);
extern void sub_0802CA70(void);
extern u32 *sub_0800D070(u32 *out, s8 delta);
extern void sub_080113E8(void);
extern u32 sub_0800DA70(void);

void sub_0800D8A0(void)
{
    register u8 *base asm("r4");
    register u8 *saved6110 asm("r5");
    u8 *new_var;
    register u8 *entry asm("r6");
    register u32 mask asm("r3");
    u32 c;
    s8 i;
    u8 *new_var2;
    u8 *ep;

    base = (u8 *)&gIwram_6110;
    c = sub_0800679C(base, 3, 0) << 24;
    saved6110 = base;
    if (c != 0) {
        new_var2 = saved6110;
        i = 0;
        base = (u8 *)gEntities;
        asm("" ::"r"(base));
        mask = 8;
        new_var = base;
        do {
            ep = (u8 *)((u32)((s8)i + 3) * 56 + (u32)new_var);
            *(u16 *)(ep + 0x34) = *(u16 *)(ep + 0x34) | mask;
            i++;
        } while (i <= 4);

        entry = new_var2;
        switch (*(u8 *)(entry + 0x33)) {
        case 0:
            sub_0802CA64();
            break;
        case 1:
            sub_0802C000();
            break;
        case 2:
            sub_0802BF58();
            break;
        case 3:
            sub_0802CA70();
            break;
        }
        return;
    }
    sub_0802C7EC();
}

u32 *sub_0800D924(u32 *out, u32 mask, u32 limit)
{
    u32 *outp = out;
    u32 maskBits = mask;
    register u32 found asm("sl");
    register u8 ulimit asm("r8");
    u32 scratch;
    s32 slimit;
    s32 sf;
    s32 i;
    u32 loopValue;
    register u32 inRange asm("r3");
    register u32 belowLimit asm("r2");
    u32 shiftedLimit;
    u32 local;
    u32 result;

    shiftedLimit = limit << 24;
    found = 0xff;
    loopValue = 0;
    ulimit = shiftedLimit >> 24;
    slimit = (s32)shiftedLimit >> 24;
    goto test;

body:
    if ((maskBits & 1) != 0) {
        loopValue = sf + 1;
        loopValue <<= 24;
        loopValue >>= 24;
        found = loopValue;
    }
    maskBits >>= 1;
    loopValue = (u8)(i + 1);

test:
    inRange = 0;
    loopValue <<= 24;
    i = (s32)loopValue >> 24;
    if (i <= 24) {
        inRange = 1;
    }

    belowLimit = 0;
    scratch = found;
    loopValue = scratch << 24;
    sf = (s32)loopValue >> 24;
    scratch = ulimit;
    loopValue = scratch << 24;
    if (sf < slimit) {
        belowLimit = 1;
    }

    inRange &= belowLimit;
    if (inRange != 0) {
        goto body;
    }

    if (sf == (s32)loopValue >> 24) {
        sub_0800D070(&local, (s8)(i - 1));
        result = local;
    } else {
        result &= 0xffff0000;
        result |= (u16)-3;
        result &= (u16)-1;
        result |= (u32)((u16)-3) << 16;
    }

    *outp = result;
    return outp;
}

u32 sub_0800D9C8(void)
{
    register struct Entity *dst asm("r2");
    register struct IwramAt35E0 *src asm("r4");
    register u32 offset asm("r5");
    register u32 offset2 asm("r3");
    register u32 addrOrValue asm("r1");

    sub_080113E8();
    dst = gEntities;
    src = &gIwram_35E0;
    offset2 = (u16)src->_field_8;
    offset = 0x692;
    asm("" : "+r"(offset));
    addrOrValue = (u32)dst + offset;
    *(u16 *)addrOrValue = offset2;
    addrOrValue = (u16)src->_field_A;
    offset2 = 0x694;
    asm("" : "+r"(offset2));
    dst = (struct Entity *)((u8 *)dst + offset2);
    *(u16 *)dst = addrOrValue;
    return sub_0800DA70();
}
