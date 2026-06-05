#include "macros.h"
#include "types.h"

extern void sub_0800E85C(u8 arg);
extern void sub_0800EB1C(void);
extern void sub_08010958(u8 arg0, u8 arg1);
extern void sub_0800F24C(u8 arg);
extern void sub_0800EBDC(u8 arg);
extern void sub_08016A40(void);

void sub_08014078(void)
{
    sub_0800E85C(2);
    sub_0800EB1C();
    sub_08010958(5, 3);
    sub_0800F24C(2);
    sub_0800EBDC(2);
    sub_08016A40();
}

struct AnimState;

/* Struct is passed by value. The first 16 bytes arrive in r0-r3 and the
 * remaining words arrive on the caller stack. */
struct AnimParams {
    u16 field_00; /* [+0] */
    u16 field_02; /* [+2] */
    u16 field_04; /* [+4] */
    u16 field_06; /* [+6] */
    u8 field_08;  /* [+8] */
    u8 _pad09;
    u8 _pad0a;
    u8 _pad0b;
    u8 field_0c; /* [+12] */
    u8 _pad0d;
    u8 _pad0e;
    u8 _pad0f;
    u32 *table;             /* [+16] */
    u32 unused;             /* [+20] */
    struct AnimState *dest; /* [+24] */
    u32 scale;              /* [+28] */
};

/* Destination animation-state struct accessed via r3. Fields used:
 * +8 (u8 index), +9, +11, +16 (u32), +44..54 (u16 coords). */
struct AnimState {
    u8 _pad00[8];
    u8 idx;      /* +0x08: index into table */
    u8 field_09; /* +0x09 */
    u8 _pad0a;
    u8 field_0b; /* +0x0b */
    u32 _pad0c;
    u32 field_10; /* +0x10 */
    u8 _pad14[24];
    u16 field_2c; /* +0x2c */
    u16 field_2e; /* +0x2e */
    u16 field_30; /* +0x30 */
    u16 field_32; /* +0x32 */
    u16 field_34; /* +0x34 */
    u16 field_36; /* +0x36 */
};

void sub_080140A0(struct AnimParams params)
{
    u8 mode;
    struct AnimState *dest;
    u16 v5;
    u16 v4;
    u8 scale;
    u32 v1;

    dest = params.dest;
    scale = params.scale;
    mode = params.field_08;

    dest->field_09 = mode;
    v5 = params.field_04;
    dest->field_30 = v5;
    v4 = params.field_06;
    dest->field_32 = v4;
    dest->field_2c = v5;
    dest->field_2e = v4;

    v1 = params.table[dest->idx];
    dest->field_10 = v1;

    dest->field_0b = params.field_0c;

    switch (mode & 0xF) {
    case 2:
        dest->field_34 = params.field_00;
        dest->field_36 = v4 + ((volatile struct AnimParams *)&params)->field_02 - scale;
        dest->field_10 = v1 + (dest->field_32 - scale) * dest->field_30 * 2;
        break;
    case 1:
    case 3:
        dest->field_34 = params.field_00;
        dest->field_36 = params.field_02;
        break;
    case 4:
        dest->field_34 = v5 + ((volatile struct AnimParams *)&params)->field_00 - scale;
        dest->field_36 = params.field_02;
        dest->field_10 = v1 + (dest->field_30 - scale) * 2;
        break;
    }
}
