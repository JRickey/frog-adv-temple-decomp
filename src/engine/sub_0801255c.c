extern void sub_0800E85C(unsigned int arg);
extern void sub_0800EE34(unsigned int arg);
extern void sub_0800EE94(unsigned int arg);
extern void sub_0800EB1C(void);
extern void sub_08012100(void);
extern void sub_0800F24C(unsigned int arg);
extern void sub_0800EBDC(unsigned int arg);
extern void sub_08016A40(void);

void sub_0801255C(void)
{
    sub_0800E85C(3);
    sub_0800EE34(2);
    sub_0800EB1C();
    sub_08012100();
    sub_0800F24C(3);
    sub_0800EBDC(3);
    sub_08016A40();
}

void sub_08012588(void)
{
    sub_0800EE94(2);
    *(volatile unsigned short *)0x04000050 = 0x1744;
    *(volatile unsigned short *)0x04000052 = 0x020e;
}
