#include "gba/io.h"
#include "types.h"

extern void sub_0801B374(u8 arg);
extern void Sound_DrainIfActive(void);
extern void Sound_PlayIfEnabled(u8 arg);

void Scene_SetupWindows(u8 arg)
{
    register u32 zero asm("r4");
    u16 *scroll;
    u8 *state;

    *(vu16 *)0x04000040 = 0xF0;
    *(vu16 *)0x04000044 = 0x70A0;
    *(vu16 *)0x04000042 = 0xF0;
    *(vu16 *)0x04000046 = 0x30;
    *(vu16 *)0x04000048 = 0x0808;
    *(vu16 *)0x0400004A = 0x3F3F;
    *(vu16 *)0x0400004A ^= 8;
    *(vu16 *)0x0400000E = 0x1F08;

    scroll = (u16 *)0x03003550;
    zero = 0;
    scroll[6] = 0;
    scroll[7] = 0;

    sub_0801B374(arg);

    state = (u8 *)0x03003540;
    state[1] = zero;
    state[12] = zero;

    Sound_DrainIfActive();
    Sound_PlayIfEnabled(16);
}
