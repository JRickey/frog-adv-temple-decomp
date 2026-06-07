#include "gfx.h"
extern void ModeControl_Init(unsigned int a, unsigned int b, unsigned int c, unsigned int d, unsigned int e,
                             unsigned int f);
extern void EntityDispatch_RunFrame(void);

void Mode16_Init(void)
{
    unsigned char *control;

    control = (unsigned char *)0x03006110;
    ModeControl_Init((unsigned int)control, 0x50, 16, 0x082F9CE0, 1, 5);
    SpriteAsset_LoadSheet(16, 0);
    EntityDispatch_RunFrame();
    control[0x33] = 0;
}
