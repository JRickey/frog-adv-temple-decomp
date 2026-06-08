#include "macros.h"
#include "types.h"

/* --- Selector_BlitTiles: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "iwram.h"

extern struct BgScrollState gIwram_60A0[3];

extern struct ScrollBlitLayer gIwram_6480;
extern struct ScrollBlitLayer gIwram_6540;

struct Unk11984Elem {
    u16 field_0;
    u16 field_2;
    u16 field_4;
    u16 field_6;
    u8 _pad08[4];
    u8 field_c;
    u8 _pad0d[3];
    u32 field_10;
    u8 _pad14[8];
};

extern void ScaleAnim_BlitFrameToVram(u8 rows, u8 cols, u16 dstX, u16 dstY, u32 bank, u32 src, u32 vram);

void Selector_BlitTiles(struct Unk11984Elem *elems, u8 idx)
{
    u32 idx8;
    u32 ofs;
    u16 *src;
    u16 *dst;
    u32 x;
    u32 y;
    u32 width;
    u32 height;

    gIwram_6540.active = 1;
    gIwram_6540.animFrame = 0;
    gIwram_6540._field_30 = elems[idx].field_4;
    gIwram_6540._field_32 = elems[idx].field_6;
    gIwram_6540._field_2c = elems[idx].field_4;
    gIwram_6540._field_2e = elems[idx].field_6;
    gIwram_6540.frameCtr = elems[idx].field_c;
    gIwram_6540.srcPtr = elems[idx].field_10;

    gIwram_6480.active = 1;
    gIwram_6480.phase = 1;
    gIwram_6480._field_36 = elems[idx + 1].field_2;
    gIwram_6480._field_34 = elems[idx + 1].field_0;
    src = (u16 *)elems[idx + 1].field_10;
    gIwram_6480.srcPtr = (u32)src;
    gIwram_6480.pendingDma = 2;
    gIwram_6480.dstPtr = 0x02020000;
    gIwram_6480.frameCtr = elems[idx + 1].field_c;
    gIwram_6480._field_30 = elems[idx + 1].field_4;
    gIwram_6480._field_32 = elems[1].field_6;
    gIwram_6480._field_2c = elems[idx + 1].field_4;
    gIwram_6480._field_2e = elems[idx + 1].field_6;

    /* lever #1: the `ofs` temp (multiply-first) lengthens the 60A0/dst base pseudo
     * to len 36, dropping its allocno priority below idx's -> idx wins ip, elems->r9 */
    ofs = gIwram_60A0[0].tileCols * elems[idx + 1].field_2 + elems[idx + 1].field_0;
    dst = (u16 *)0x02020000 + ofs;
    gIwram_6480.field_18 = (u32)dst;

    idx8 = idx << 3;
    height = gIwram_6540._field_32;
    width = gIwram_6540._field_30;
    y = 0;
    while (y < height) {
        x = 0;
        while (x < width) {
            *dst++ = *src++;
            x = (u16)(x + 1);
        }
        dst += gIwram_60A0[0].tileCols - width;
        y = (u16)(y + 1);
    }

    ScaleAnim_BlitFrameToVram((u8)gIwram_6540._field_32, (u8)gIwram_6540._field_30, gIwram_6480._field_34,
                              gIwram_6480._field_36, 2,
                              ((struct Unk11984Elem *)((u8 *)elems + ((idx8 - idx) << 2)))->field_10, 0x0600F000);
}
#else
NAKED void Selector_BlitTiles(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x11984, 0x120\n");
}
#endif /* NON_MATCHING */
