#include "gfx.h"
#include "macros.h"
#include "types.h"

extern const FrameDescriptor sFrogStatusBarFrames[];

/* Blits the [24] status-bar frame (a 2x2 tile widget) into BG tilemap
 * screenblock 31 at VRAM 0x0600f800. The dst pointer is built in two
 * statements (base load, then add) so agbcc colours dst into r1 to match
 * the baserom's register allocation. */
void StatusBar_DrawTile24(void)
{
    const u16 *src;
    u16 *dst;
    u16 row;

    src = sFrogStatusBarFrames[24].tile_data;
    dst = (u16 *)0x0600f800;
    dst = dst + ((sFrogStatusBarFrames[24].y << 5) + sFrogStatusBarFrames[24].x);

    for (row = 0; row < sFrogStatusBarFrames[24].w; row++) {
        u16 col;
        for (col = 0; col < sFrogStatusBarFrames[24].h; col++) {
            *dst++ = *src++;
        }
        dst += 32 - sFrogStatusBarFrames[24].h;
    }
}
