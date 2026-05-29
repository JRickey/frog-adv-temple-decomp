#include "macros.h"
#include "types.h"

void sub_08016A40(void);

struct StructA74 {
    u8 _field_00;
    u8 _pad01;
    u16 _field_02;
    u8 _field_04;
    u8 _field_05;
    u8 _pad06[6];
    u8 _field_0C;
    u8 _field_0D;
    u8 _pad0E[2];
    u16 _field_10;
    u16 _field_12;
    u32 _field_14;
};

/* Initializes the struct at *p from four args plus one stacked byte arg,
 * zeroing the +12/+13 byte fields and the +16/+18 halfwords and +20 word,
 * then calls sub_08016A40() between writing +4 and +5.
 */
void sub_08006A74(struct StructA74 *p, u8 a, u16 b, u8 c, u8 e)
{
    p->_field_00 = a;
    p->_field_02 = b;
    p->_field_04 = c;
    sub_08016A40();
    p->_field_05 = (u8)e;
    p->_field_0D = 0;
    p->_field_0C = 0;
    p->_field_14 = 0;
    p->_field_10 = 0;
    p->_field_12 = 0;
}

void sub_08006AAC(u8 *p, u8 v)
{
    *p = v;
    sub_08016A40();
}
