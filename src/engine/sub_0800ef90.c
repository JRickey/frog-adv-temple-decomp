#include "gba/intr.h"
#include "gba/io.h"
#include "types.h"

extern void sub_0800E85C(u8 arg);
extern void sub_0800EB1C(void);
extern void sub_0801129C(void);
extern void sub_08010958(u8 arg0, u8 arg1);
extern void sub_0800F24C(u8 arg);
extern void sub_0800EBDC(u8 arg);
extern void sub_08016A40(void);

/* Tears down the HBlank-driven display effect: drops BG2 from REG_DISPCNT
 * and disables the HBlank IRQ at both the enable (REG_IE) and trigger
 * (REG_DISPSTAT) ends. */
void sub_0800EF90(void)
{
    REG_DISPCNT &= ~DISPCNT_BG2_ON;
    REG_IE &= ~IRQ_HBLANK;
    REG_DISPSTAT &= ~DISPSTAT_HBLANK_IRQ;
}

void sub_0800EFC8(void)
{
    sub_0800E85C(2);
    sub_0800EB1C();
    sub_0801129C();
    sub_08010958(5, 3);
    sub_0800F24C(2);
    sub_0800EBDC(2);
    sub_08016A40();
}

void sub_0800EFF4(void)
{
    sub_0800E85C(2);
    sub_0800EB1C();
    sub_0800F24C(2);
    sub_0800EBDC(2);
    sub_08016A40();
}
