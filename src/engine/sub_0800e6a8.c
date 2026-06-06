#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 AnimCtrl_RunPhase(void);
extern void WaitVblank(void);
extern void UpdateBgTilemapFrames(void);
extern u8 Scene08_MapScreenTick(void);
extern void SoundSystem_FadeOut(void);

u8 Scene_FadeUpdate(void)
{
    u8 result;

    result = AnimCtrl_RunPhase();
    WaitVblank();
    UpdateBgTilemapFrames();

    if (*(u8 *)0x03005328 == 0 || result == 0) {
        gGameStuff._unk18 &= 0xFE;
        gIwram_34A0.dispatchIdx = 0;
        SoundSystem_FadeOut();
    }

    if (*(u8 *)0x03005328 == 0) {
        switch (gGameStuff.pendingMode) {
        case 1:
        case 2:
            break;
        case 3:
        case 6:
        case 9:
        case 15:
            *(vu16 *)0x04000050 = 0x1748;
            *(vu16 *)0x04000052 = 0x0A06;
            break;
        case 16:
            break;
        }
    }

    return result;
}

void text_0800e76c(void)
{
    switch (gGameStuff.pendingMode) {
    case 1:
    case 2:
        break;
    case 3:
        *(vu16 *)0x04000050 = 0;
        break;
    case 4:
    case 5:
        break;
    case 6:
        *(vu16 *)0x04000050 = 0;
        break;
    case 7:
    case 8:
        break;
    case 9:
        *(vu16 *)0x04000050 = 0;
        break;
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
        break;
    case 15:
        *(vu16 *)0x04000050 = 0;
        break;
    case 16:
        break;
    }
}

void SetModeBlendRegs(void)
{
    switch (gGameStuff.pendingMode) {
    case 1:
    case 2:
        break;
    case 3:
        *(vu16 *)0x04000050 = 0x1748;
        *(vu16 *)0x04000052 = 0x0A06;
        break;
    case 4:
    case 5:
        break;
    case 6:
        *(vu16 *)0x04000050 = 0x1748;
        *(vu16 *)0x04000052 = 0x0A06;
        break;
    case 7:
    case 8:
        break;
    case 9:
        *(vu16 *)0x04000050 = 0x1748;
        *(vu16 *)0x04000052 = 0x0A06;
        break;
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
        break;
    case 15:
        *(vu16 *)0x04000050 = 0x1748;
        *(vu16 *)0x04000052 = 0x0A06;
        break;
    case 16:
        break;
    }
}

void text_0800e850(void)
{
    Scene08_MapScreenTick();
}
