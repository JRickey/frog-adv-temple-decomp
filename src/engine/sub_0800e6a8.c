#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 sub_0800E4BC(void) asm("text_0800e4bc");
extern void sub_080008DC(void);
extern void sub_0800E174(void);
extern void sub_08020B78(void);

u8 sub_0800E6A8(void)
{
    u8 result;

    result = sub_0800E4BC();
    sub_080008DC();
    sub_0800E174();

    if (*(u8 *)0x03005328 == 0 || result == 0) {
        gGameStuff._unk18 &= 0xFE;
        gIwram_34A0.dispatchIdx = 0;
        sub_08020B78();
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
