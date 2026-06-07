#include "gfx.h"
extern void ModeControl_Init(unsigned int a, unsigned int b, unsigned int c, unsigned int d, unsigned int e,
                             unsigned int f);
extern void EntityDispatch_RunFrame(void);

void Mode13_Init(void)
{
    unsigned char *control;
    unsigned int zero;

    control = (unsigned char *)0x03006110;
    ModeControl_Init((unsigned int)control, 0x32, 13, 0x082F9CD0, 1, zero = 0);
    SpriteAsset_LoadSheet(13, 0);
    control[0x2a] = zero;
    {
        unsigned int six;
        register unsigned int wordZero asm("r1");

        six = 6;
        wordZero = 0;
        *(unsigned int *)(control + 4) = six;
        *(unsigned int *)(control + 8) = wordZero;
    }
    EntityDispatch_RunFrame();
}
