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
    register u8 *base6110 asm("r4");
    register u8 *saved6110 asm("r5");
    u8 *new_var;
    register u8 *base3720 asm("r4");
    register u8 *entry asm("r6");
    register u32 mask asm("r3");
    u32 c;
    s8 i;
    u8 *new_var2;
    u8 *ep;

    base6110 = (u8 *)&gIwram_6110;
    c = sub_0800679C(base6110, 3, 0) << 24;
    saved6110 = base6110;
    if (c != 0) {
        new_var2 = saved6110;
        i = 0;
        base3720 = (u8 *)gEntities;
        asm("" ::"r"(base3720));
        mask = 8;
        new_var = base3720;
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
    register u32 *outp asm("r9") = out;
    register u32 maskBits asm("r6") = mask;
    register u32 found asm("sl");
    register u8 ulimit asm("r8");
    u32 scratch;
    register s32 slimit asm("ip");
    register s32 sf asm("r1");
    register s32 i asm("r5");
    register u32 loopValue asm("r0");
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
    register u16 *ptr asm("r1");
    register u32 x asm("r3");
    register u32 y asm("r1");

    sub_080113E8();
    dst = gEntities;
    src = &gIwram_35E0;
    x = (u16)src->_field_8;
    offset = 0x692;
    asm("" : "+r"(offset));
    ptr = (u16 *)((u8 *)dst + offset);
    *ptr = x;
    y = (u16)src->_field_A;
    offset2 = 0x694;
    asm("" : "+r"(offset2));
    dst = (struct Entity *)((u8 *)dst + offset2);
    *(u16 *)dst = y;
    return sub_0800DA70();
}
