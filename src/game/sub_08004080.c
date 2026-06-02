extern void ModeControl_Init(unsigned int a, unsigned int b, unsigned int c, unsigned int d, unsigned int e,
                             unsigned int f);
extern void sub_0800CE98(unsigned int a, unsigned int b);
extern void sub_08009CBC(void);

void sub_08004080(void)
{
    register unsigned char *control asm("r4");
    register unsigned int zero asm("r5");

    control = (unsigned char *)0x03006110;
    ModeControl_Init((unsigned int)control, 0x32, 13, 0x082F9CD0, 1, zero = 0);
    sub_0800CE98(13, 0);
    control[0x2a] = zero;
    {
        register unsigned int six asm("r0");
        register unsigned int wordZero asm("r1");

        six = 6;
        wordZero = 0;
        *(unsigned int *)(control + 4) = six;
        *(unsigned int *)(control + 8) = wordZero;
    }
    sub_08009CBC();
}
