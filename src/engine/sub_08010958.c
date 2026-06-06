#include "types.h"

/* --- sub_08010958: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "macros.h"
#include "types.h"

extern void sub_080105B0(void *list, u8 index, u8 flag);

typedef struct ModeList {
    void *list;
    u8 _pad04[16];
} ModeList;

#define gModeListA ((ModeList *)0x08307EB4)
#define gModePairs ((ModeList *)0x08307EB8)
#define gModeListB ((ModeList *)0x08307EBC)

void sub_08010958(u8 a, u8 b)
{
    u8 *base = (u8 *)0x03006110;
    register u8 *p2a asm("r9");
    register ModeList *pairs asm("sl");
    ModeList *listA;
    u8 *pair;
    u8 i;
    u8 j;
    u8 count;

    if (*(u16 *)(base + 0x26) != 0) {
        listA = gModeListA;
        for (i = 0; i < a; i++) {
            if ((*(u16 *)(base + 0x26) >> i) & 1) {
                u32 idx = gGameStuff.pendingMode - 1;
                sub_080105B0(listA[idx].list, i, 1);
            }
        }
    }

    if (*(base + 0x2a) == 0) {
        return;
    }

    p2a = base + 0x2a;
    pairs = gModePairs;
    for (i = 0; i < b; i++) {
        if ((*p2a >> i) & 1) {
            u32 idx = gGameStuff.pendingMode - 1;
            pair = (u8 *)pairs[idx].list + i * 2;
            j = pair[0];
            count = pair[1];
            while (count != 0) {
                u32 idx2 = gGameStuff.pendingMode - 1;
                sub_080105B0(gModeListB[idx2].list, j, 0);
                j++;
                count--;
            }
        }
    }
}
#endif /* NON_MATCHING */
