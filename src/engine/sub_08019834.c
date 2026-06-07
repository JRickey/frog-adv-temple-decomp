#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"

extern const u32 sOamDmaCfg_08100[4];

extern void Tilemap_SwapPalette(void *self, u16 a, u16 b, u8 c);
extern void Sprite_CycleDmaFrame(u32 a, u32 b, u32 c, u32 d);

void Sprite_AnimateFlip(void *self, u16 u1, u16 u2, u8 u3, u8 count)
{
    if (count == 0)
        return;

    do {
        if (count & 1)
            Tilemap_SwapPalette(self, u1, u2, u3);
        else
            Tilemap_SwapPalette(self, u2, u1, u3);
        WaitFrames(5);
        Sprite_CycleDmaFrame(sOamDmaCfg_08100[0], sOamDmaCfg_08100[1], sOamDmaCfg_08100[2], sOamDmaCfg_08100[3]);
        count = (u8)(count - 1);
    } while (count != 0);
}

void Sprite_AnimateFlipWithShadow(u32 *self, u16 u1, u16 u2, u8 u3, u8 count)
{
    u32 attr;

    attr = (*self & 0xffffff00) | 0x0f;
    attr = (attr & 0xff00ffff) | 0x20000;

    if (count == 0)
        return;

    do {
        if (count & 1) {
            Tilemap_SwapPalette(self, u1, u2, u3);
            Tilemap_SwapPalette(&attr, 6, 7, u3);
        } else {
            Tilemap_SwapPalette(self, u2, u1, u3);
            Tilemap_SwapPalette(&attr, 7, 6, u3);
        }
        WaitFrames(5);
        Sprite_CycleDmaFrame(sOamDmaCfg_08100[0], sOamDmaCfg_08100[1], sOamDmaCfg_08100[2], sOamDmaCfg_08100[3]);
        count = (u8)(count - 1);
    } while (count != 0);
}

void SetCurrentLevel(u32 x)
{
    gIwram_34B0._data = x;
}
