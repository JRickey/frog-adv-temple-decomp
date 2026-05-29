#include "gba/io.h"
#include "types.h"

extern int __modsi3(int num, int den);

u32 sub_080113E8(void)
{
    u8 deck[28];
    u32 i;
    u8 deckSize;
    u32 result;
    u8 r1;
    u32 r2;
    u8 idx;

    result = 0;
    deckSize = 25;
    i = 0;
    r1 = 0;
    r2 = 128 << 5;

    do {
        if (i == 12) {
            result |= r2;
        } else {
            u8 r0 = r1;

            r1 = (r0 + 1) & 0xFF;
            deck[r0] = i;
        }
        i = (u8)(i + 1);
    } while (i <= 24);

    deckSize = (deckSize - 1) & 0xFF;
    i = 0;

    do {
        u8 r0 = (u8)REG_VCOUNT;
        u8 *ptr;

        idx = __modsi3(r0 * 107 + 7, deckSize) & 0xFF;
        /* ptr anchors sp+idx before deckSize-- so agbcc emits the address
         * computation first, matching the baserom's instruction order. */
        ptr = deck + idx;
        deckSize = (deckSize - 1) & 0xFF;
        result |= (u32)(1 << *ptr);
        i++;

        if (idx < deckSize) {
            do {
                deck[idx] = deck[idx + 1];
                idx++;
            } while (idx < deckSize);
        }

        i = (u8)i;
    } while (i <= 3);

    return result;
}
