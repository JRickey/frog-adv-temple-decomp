#include "gba/io.h"
#include "iwram.h"
#include "types.h"

extern int __modsi3(int num, int den);

/* VCOUNT-seeded "pick a value in [0, range)" helper: scrambles the current
 * scanline with an LCG-style multiply-add, then folds it modulo `range`. */
u8 sub_0801185C(u8 range)
{
    return (u8)__modsi3((u8)REG_VCOUNT * 107 + 7, range);
}

typedef struct AnimDesc {
    u8 state;
    u8 _pad01[3];
    u32 field_04;
    u32 field_08;
    u8 maxFrames;
    u8 _pad0d;
    s16 field_0e;
    u8 _pad10[4];
    u32 field_14;
} AnimDesc;

extern const AnimDesc sAnimDesc_6e08;
extern const AnimDesc sAnimDesc_6e28;

extern void sub_0801223C(u32, u32, u32, u32, s32);
extern void sub_08012180(void);

u32 sub_08011884(void)
{
    u32 result;

    result = 0;
    sub_0801223C(sAnimDesc_6e08.field_04, sAnimDesc_6e08.field_14, sAnimDesc_6e28.field_04, sAnimDesc_6e28.field_04,
                 sAnimDesc_6e28.field_0e);
    sub_08012180();

    if (gIwram_6150._field_04 != 0)
        goto done;
    if (gIwram_5360._field_04 != 0)
        goto done;
    if (gIwram_5360._field_0e != 0)
        goto done;

    result = 1;
done:
    return result;
}

extern void sub_0800E85C(u8 arg);
extern void sub_08011518(void);
extern void sub_0800EB1C(void);
extern void sub_0800F24C(u8 arg);
extern void sub_0800EBDC(u8 arg);
extern void sub_08016A40(void);
extern void sub_080116B8(u32 arg);
extern void sub_08017000(void);
extern void sub_080135B8(s32 a, s32 b, s32 c, s32 d);

struct IwramAt60A0_sub1190C {
    u8 _pad00[12];
    s32 field_c;
    s32 field_10;
    u8 _pad14[24];
    s32 field_2c;
    s32 field_30;
};

struct IwramAt6480_sub1190C {
    u8 _pad00[46];
    s16 field_2e;
    u8 _pad30[6];
    s16 field_36;
};

struct IwramAt6540_sub1190C {
    u8 _pad00[9];
    u8 field_9;
    u8 _pad0a[34];
    s16 field_2c;
    u8 _pad2e[6];
    s16 field_34;
};

extern struct IwramAt60A0_sub1190C gIwram_60A0;
extern struct IwramAt6480_sub1190C gIwram_6480;
extern struct IwramAt6540_sub1190C gIwram_6540;

void sub_080118D8(void)
{
    sub_0800E85C(2);
    sub_08011518();
    sub_0800EB1C();
    sub_0800F24C(2);
    sub_0800EBDC(2);
    sub_08016A40();
}

void sub_080118FC(void)
{
    sub_080116B8(4);
    sub_08017000();
}

u32 sub_0801190C(void)
{
    register u32 result asm("r8");
    s32 x;
    s32 y;

    result = 0;
    sub_080135B8(-24, 2, -72, 2);
    x = gIwram_60A0.field_c + gIwram_6540.field_2c;
    gIwram_60A0.field_c = x;
    y = gIwram_60A0.field_10 + gIwram_6480.field_2e;
    gIwram_60A0.field_10 = y;
    gIwram_60A0.field_2c = x;
    gIwram_60A0.field_30 = y;

    if (gIwram_6480.field_36 == -72)
        gIwram_6540.field_9 = 3;

    if (gIwram_6540.field_34 == -24)
        result = 1;

    return result;
}

void sub_08011978(void)
{
    sub_08017000();
}
