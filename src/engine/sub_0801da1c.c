#include "game.h"
#include "gba/dma.h"
#include "types.h"

extern void Credits_LoadGfx(void);
extern int Credits_FillPage(u8 row, u8 col);
extern void WaitFrames(u8 arg);
extern int Screen_BeginFlash(int arg);
extern int Screen_TickFlash(void);
extern void SoundMixer_Stop(void);
extern void Credits_FadeTransition(void);

#define BG_PAL_1E2 (*(vu16 *)0x050001E2)
#define BG3VOFS    (*(vu16 *)0x0400001E)

void BgScroll_TileWipeTransition(void)
{
    u32 cols[12];
    u16 zero;
    u16 savedPal;
    u8 byteZero;
    u32 a;
    register u32 d asm("r9");
    register u32 e asm("sl");
    u8 b;
    u8 i;
    u32 c;

    {
        register vu16 *palReg asm("r1") = (vu16 *)0x050001E2;
        savedPal = *palReg;
        *palReg = 0x3DF;
    }

    a = 0;
    b = 0;
    c = 0;
    d = 1;
    e = 6;
    Credits_LoadGfx();

    i = 0;
loop1:
    if (i > 11) {
        goto loop1_done;
    }
    {
        u8 row = i;
        u8 col = i;

        if (Credits_FillPage(row, col)) {
            {
                u32 hi = 0x02000000;
                u32 *slot = &cols[i];
                *slot = (i << 11) + hi;
            }
            i = (u8)(i + 1);
            goto loop1;
        }
    }
    cols[i] = (i << 11) + 0x02000000;
loop1_done:

    REG_DMA3.src = (void *)cols[0];
    REG_DMA3.dst = (void *)0x0600F800;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;
    Screen_BeginFlash(0xBF);

    while (Screen_TickFlash()) {
        WaitFrames(2);
    }

    for (;;) {
        WaitFrames(2);
        c = (u8)(c + 1);
        BG3VOFS = (u16)c;

        if ((c & 7) == 0) {
            if (a < i) {
                REG_DMA3.src = (void *)(cols[a + 1] + (b << 6));
                REG_DMA3.dst = (void *)((b << 6) + 0x0600F800);
                REG_DMA3.cnt = DMA_ENABLE | 0x20;
                (void)REG_DMA3.cnt;
            } else if (e != 0) {
                zero = 0;
                REG_DMA3.src = &zero;
                REG_DMA3.dst = (void *)((b << 6) + 0x0600F800);
                REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x20;
                (void)REG_DMA3.cnt;
                e = (u8)(e - 1);
            } else {
                d = 0;
            }
            b = (u8)(b + 1);
        }

        if (b > 31) {
            if (a < i) {
                a = (u8)(a + 1);
            } else {
                d = 0;
            }
            BG3VOFS = 0;
            b = 0;
            c = 0;
        }

        if (d == 0) {
            break;
        }
    }

    {
        vu16 *vofs = (vu16 *)0x0400001E;
        byteZero = 0;
        *vofs = (u16)d;
    }
    SoundMixer_Stop();
    Credits_FadeTransition();
    BG_PAL_1E2 = savedPal;
    gGameStuff.mode = GAME_MODE_ROUTER;
    *(u8 *)0x03003480 = byteZero;
}
