#include "types.h"
#include "iwram.h"

extern u8 sub_0801185C(u8 range);
extern u8 gIwram_53A0[];
extern u8 gIwram_549F[];
extern u8 gIwram_3610[];

void sub_08013E94(u8 n)
{
    u8 i;

    i = 0;
    while (i < n) {
        u8 *arr = gIwram_53A0;
        u8 *limit = arr + 0xFF;
        u8 *writeIdx = arr + 0xFE;
        u8 rnd = sub_0801185C(*limit);
        u8 j = rnd;
        int dst;

        dst = *writeIdx + 0x64;
        arr[dst] = gIwram_3610[rnd];
        (*writeIdx)++;
        arr[rnd] = 2;

        if (rnd < *limit) {
            do {
                gIwram_3610[j] = gIwram_3610[j + 1];
                j++;
            } while (j < *gIwram_549F);
        }

        i++;
        (*limit)--;
    }
}

void sub_08013F2C(void)
{
    u8 i;

    for (i = 0; i <= 99; i++)
        gIwram_3610[i] = i;

    gIwram_53A0[0xFF] = 100;
    gIwram_53A0[0xFE] = 0;
}

void sub_08013F5C(void)
{
    gIwram_3610[0] = 0;
}
