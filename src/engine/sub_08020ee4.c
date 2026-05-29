#include "types.h"

/* Increments the offset-3 counter byte in the sound-channel struct at
 * 0x03003570 and forwards the caller's byte argument plus the new counter
 * value into sub_0802DC1C. Bails out without calling once the counter has
 * saturated at 245. Sibling sub_08020F08 is the matching decrement. */

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern void sub_0802DC1C(u8 value, u8 counter);

void sub_08020EE4(u8 value)
{
    StructAt3003570 *p = &gStructAt3003570;

    if (p->d > 244) {
        return;
    }
    p->d++;
    sub_0802DC1C(value, p->d);
}
