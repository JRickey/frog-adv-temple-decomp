extern void sub_0800E85C(unsigned int arg);
extern void sub_0800EB1C(void);
extern void sub_0800F24C(unsigned int arg);
extern void sub_0800EBDC(unsigned int arg);
extern void sub_08016A40(void);

void sub_08013F68(void)
{
    sub_0800E85C(2);
    *(unsigned char *)0x03003610 = 0;
    sub_0800EB1C();
    sub_0800F24C(2);
    sub_0800EBDC(2);
    sub_08016A40();
}
