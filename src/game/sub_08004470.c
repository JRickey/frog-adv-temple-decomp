extern void ModeControl_Init(unsigned int a, unsigned int b, unsigned int c, unsigned int d, unsigned int e,
                             unsigned int f);
extern void sub_0800CE98(unsigned int a, unsigned int b);
extern void sub_08009CBC(void);

void sub_08004470(void)
{
    ModeControl_Init(0x03006110, 0x80, 14, 0x082F9B6C, 1, 3);
    sub_0800CE98(14, 0);
    sub_08009CBC();
}
