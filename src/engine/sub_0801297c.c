#include "macros.h"
#include "types.h"

/* --- BlitEntityTileFrame2: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "iwram.h"
#include "types.h"

/* Two 0x18-byte tile-blit descriptors at sBlitDesc_6e64; this function reads
 * the second record (offsets 0x18..0x2f). */
struct BlitDesc {
    u8 _pad00[28];
    u8 width; /* +0x1C */
    u8 _pad1D;
    u8 height; /* +0x1E */
    u8 _pad1F;
    u8 flags; /* +0x20: bit 4 selects the EWRAM staging bank */
    u8 _pad21[7];
    const u16 *const *srcRec; /* +0x28: srcRec[2] is the tile stream */
};

extern const struct BlitDesc sBlitDesc_6e64;
extern void Scroll_FlushTilemapWindow(u8 bank, u16 *src, u16 *dst);
extern struct BgScrollState gIwram_60A0[3];

void BlitEntityTileFrame2(void)
{
    u16 srcX;
    u16 srcY;
    u8 width;
    u8 height;
    const u16 *const *srcRec;
    u8 bank;
    u32 destBase;
    u16 *dst;
    const u16 *src;
    u8 x;
    u8 y;

    width = sBlitDesc_6e64.width;
    height = sBlitDesc_6e64.height;
    srcRec = sBlitDesc_6e64.srcRec;
    bank = sBlitDesc_6e64.flags >> 4;
    srcX = (u16)(gIwram_3720._field_692 * 3);
    srcY = (u16)(gIwram_3720._field_694 * 3);

    destBase = 0x02000000;
    if (bank & 1)
        destBase = 0x02010000;

    dst = (u16 *)(destBase + (srcY * gIwram_60A0[0].tileCols + srcX) * 2);
    src = srcRec[2];

    y = 0;
    while (y < height) {
        for (x = 0; x < width; x++) {
            *dst++ = *src++;
        }
        dst += gIwram_60A0[0].tileCols - width;
        y = (u8)(y + 1);
    }

    if (bank & 1)
        Scroll_FlushTilemapWindow(bank & 1, (u16 *)0x02010000, (u16 *)0x0600E800);
    else
        Scroll_FlushTilemapWindow(bank & 1, (u16 *)0x02000000, (u16 *)0x0600E000);

    gIwram_64C0._field_0A = 0;
}
#else
NAKED void BlitEntityTileFrame2(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x1297c, 0xf0\n");
}
#endif /* NON_MATCHING */
