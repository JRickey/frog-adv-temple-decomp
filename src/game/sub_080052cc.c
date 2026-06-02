extern void ModeControl_Init(unsigned int a, unsigned int b, unsigned int c, unsigned int d, unsigned int e,
                             unsigned int f);
extern void sub_0800CE98(unsigned int a, unsigned int b);
extern void sub_08009CBC(void);

void sub_080052CC(void)
{
    unsigned char *control;

    control = (unsigned char *)0x03006110;
    ModeControl_Init((unsigned int)control, 0x50, 16, 0x082F9CE0, 1, 5);
    sub_0800CE98(16, 0);
    sub_08009CBC();
    control[0x33] = 0;
}
