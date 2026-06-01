#include "game.h"
#include "iwram.h"
#include "types.h"

typedef void (*GameProc)(void);

extern u16 sub_08010694(u16 arg);
extern int sub_080106B8(void);
extern u16 sub_080106EC(u16 arg);
extern int sub_08010710(void);

int sub_0800A104(s8 *phase, GameProc callback)
{
    int p = (s8)*phase;

    if (p == 0) {
        sub_08010694(0xBF);
        goto advance;
    }
    if (p == 1) {
        if (sub_080106B8() != 0)
            goto zero_return;
        goto advance;
    }
    if (p == 2) {
        callback();
        sub_080106EC(0xBF);
    advance:
        *phase = *phase + 1;
    zero_return:
        return 0;
    }
    if (p == 3) {
        if (sub_08010710() == 0)
            return 1;
        {
            int ret;
            /* Keep phase 3's zero return distinct from the shared 0/1/2 return. */
            asm("" : "=r"(ret) : "0"(0));
            return ret;
        }
    }
    return p;
}
