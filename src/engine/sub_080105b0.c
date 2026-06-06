#include "types.h"

/* --- Blit_CopyEntry: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "types.h"

struct BlitEntry {
    u16 dstX;
    u16 dstY;
    u16 cols;
    u16 rows;
    u8 flags;
    u8 _pad09[7];
    const u16 *const *srcTable;
    u8 _pad14[4];
};

struct BlitState {
    u8 _pad00[12];
    const u16 *src;
    u8 _pad10[4];
    u16 *dst;
};

struct SceneScroll {
    u8 _pad00[26];
    u16 stride;
};

#define gBlitState   (*(struct BlitState *)0x03006500)
#define gSceneScroll (*(struct SceneScroll *)0x030060A0)

void Blit_CopyEntry(struct BlitEntry *entries, u8 index, u8 srcIndex)
{
    u32 i;
    u32 j;
    u32 row;
    u32 col;

    i = index;
    j = srcIndex;

    if ((entries[i].flags >> 4) & 1) {
        gBlitState.dst = (u16 *)0x02010000;
    } else {
        gBlitState.dst = (u16 *)0x02000000;
    }

    gBlitState.dst += gSceneScroll.stride * entries[i].dstY + entries[i].dstX;
    gBlitState.src = entries[i].srcTable[j];

    row = 0;
    if (row < entries[i].rows) {
        do {
            col = 0;
            if (col < entries[i].cols) {
                do {
                    *gBlitState.dst++ = *gBlitState.src++;
                    col = (u8)(col + 1);
                } while (col < entries[i].cols);
            }

            gBlitState.dst += gSceneScroll.stride - entries[i].cols;
            row = (u8)(row + 1);
        } while (row < entries[i].rows);
    }
}
#endif /* NON_MATCHING */
