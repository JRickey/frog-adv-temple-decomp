#include "iwram.h"
#include "types.h"

extern u32 sub_0802D9EC(u32 sound, u32 a, u32 b, u32 c);
extern void sub_0802DC1C(u32 handle, u32 pan);

#define gStructAt3003570 (*(u8 *)0x03003570)

void sub_0802090C(void)
{
    u8 *base;
    u32 state;
    u32 sound;

    if ((gIwram_35E0._field_10 & 0x800) != 0) {
        base = (u8 *)0x03003570;
        if ((*base & 0x10) == 0)
            return;

        sound = 90;
        goto playSound;
    } else if ((gIwram_35E0._field_10 & 0x2000) != 0) {
        base = (u8 *)0x03003570;
        if ((*base & 0x10) == 0)
            return;

        sound = 92;
    } else {
        state = gIwram_35E0._field_D - 7;
        if (state > 85)
            return;

        switch (state) {
        case 11:
        case 21:
        case 22:
        case 47:
        case 48:
        case 49:
        case 57:
        case 59:
        case 71:
        case 81:
        case 84:
            base = (u8 *)0x03003570;
            if ((*base & 0x10) == 0)
                return;

            sound = 91;
            goto playSound;
        case 0:
        case 1:
        case 6:
        case 10:
        case 16:
        case 17:
        case 18:
        case 20:
        case 25:
        case 26:
        case 27:
        case 29:
        case 30:
        case 31:
        case 33:
        case 40:
        case 41:
        case 42:
        case 43:
        case 50:
        case 51:
        case 52:
        case 53:
        case 65:
        case 68:
        case 73:
        case 75:
        case 76:
        case 78:
        case 82:
        case 85:
            base = (u8 *)0x03003570;
            if ((*base & 0x10) == 0)
                return;

            sound = 12;
        playSound:
            sound = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
            {
                register u8 pan asm("r4");
                register u32 mask asm("r1");
                mask = 0x7f;
                pan = base[2];
                mask &= pan;
                sub_0802DC1C(sound, mask);
            }
            return;
        case 2:
        case 3:
        case 8:
        case 23:
        case 63:
        case 64:
        case 74:
            base = (u8 *)0x03003570;
            if ((*base & 0x10) == 0)
                return;

            sound = sub_0802D9EC(93, 0xff, 0xff, 0xff);
            {
                register u8 pan asm("r4");
                register u32 mask asm("r1");
                mask = 0x7f;
                pan = base[2];
                mask &= pan;
                sub_0802DC1C(sound, mask);
            }
            return;
        default:
            return;
        }
    }

    goto playSound;
}
