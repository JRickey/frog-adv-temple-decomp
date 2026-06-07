#include "game.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "types.h"

extern void LoadRoomBg3Graphics(void);

/* Scene/mode bring-up sibling of Scene_LoadBg.
 *
 * Resets the 0x03005370 control struct (offsets 0/4/8/12/16), sets the
 * 0x03005328 control byte to 1, calls LoadRoomBg3Graphics(), then fires a run of
 * DMA3 transfers:
 *   - halfword-fill OBJ-VRAM 0x0600F800 with 0 (0x400 halfwords)
 *   - copy ROM 0x080E3754 -> palette 0x050001A0 (0x30 halfwords)
 *   - copy ROM 0x080E3AB6 -> BG-VRAM 0x06008000 (0x2000 halfwords)
 *   - if gGameStuff.sceneType == 12: copy ROM 0x080E37B4 -> palette
 *     0x05000140 (0x30 halfwords) -- the +0x60 src and the cnt word are
 *     reused from the second DMA.
 * Finally programs REG_BG3CNT (0x0400000E) = 0x1F08 and raises BG3 in
 * REG_DISPCNT.
 *
 * Matching notes (agbcc 2.x):
 *   - The fill seed value 0 is pinned to r4 (callee-saved) so it survives
 *     the BL and stores into the stack slot afterwards, forcing the
 *     push {r4, lr} prologue.
 *   - romBase (0x080E3754) is pinned to r2 and cnt30 (0x80000030) to r3 so
 *     the conditional palette copy reuses them rather than reloading fresh
 *     literals.
 *   - The conditional src (romBase + 0x60) is built in a fresh r0-pinned
 *     local so agbcc emits `adds r0, r2, #0; adds r0, #0x60` (copy then add)
 *     instead of mutating romBase's register in place.
 */

void FrogOam_Init(void)
{
    u16 seedVal;
    u32 romBase;
    u32 cnt30;
    vu16 seed;
    u8 *ctrl5370;
    vu32 *dma;

    ctrl5370 = (u8 *)0x03005370;
    seedVal = 0;
    ctrl5370[0] = 1;
    ctrl5370[4] = 3;
    ctrl5370[8] = 1;
    ctrl5370[12] = 9;
    ctrl5370[16] = 9;

    *(u8 *)0x03005328 = 1;

    LoadRoomBg3Graphics();

    seed = seedVal;
    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)&seed;
    dma[1] = 0x0600F800;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma[2];

    romBase = 0x080E3754;
    dma[0] = romBase;
    dma[1] = 0x050001A0;
    cnt30 = DMA_ENABLE | 0x30;
    dma[2] = cnt30;
    (void)dma[2];

    dma[0] = 0x080E3AB6;
    dma[1] = 0x06008000;
    dma[2] = DMA_ENABLE | 0x2000;
    (void)dma[2];

    if (gGameStuff.sceneType == 12) {
        register u32 src2 asm("r0");
        src2 = romBase;
        src2 += 0x60;
        dma[0] = src2;
        dma[1] = 0x05000140;
        dma[2] = cnt30;
        (void)dma[2];
    }

    *(vu16 *)0x0400000E = 0x1F08;
    REG_DISPCNT |= DISPCNT_BG3_ON;
}
