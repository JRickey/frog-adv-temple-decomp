#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

extern const u16 sWinPoseSpriteCoords[];

/* sub_08018898 takes three leading scalars, a 16-byte struct by value, and a
 * trailing scalar. The struct is materialised on the caller's stack and passed
 * as r3 + [sp+0..8]; the trailing scalar lands in [sp+12]. Same call shape as
 * sub_0801F418's installer (the sibling screen-setup routine). */
struct ScreenInstallArgs {
    u32 _unk00;
    const void *tilemap1;
    const void *tilemap2;
    u32 _unk0C;
};

extern void sub_08018C0C(s32 mode);
extern void sub_08018898(s32 flag, s32 a, s32 b, struct ScreenInstallArgs args, s32 last);
extern void sub_0801844C(void);
extern void sub_08018CA8(void);
extern void sub_080200B4(void);

extern u16 gIwram_5398;

void sub_0801FD0C(void)
{
    struct ScreenInstallArgs args;

    args._unk00 = 0;
    args.tilemap1 = (const void *)0x081e5c18;
    args.tilemap2 = (const void *)0x081e4c18;
    args._unk0C = 0;

    gIwram_3480._unk14 = gIwram_34B0._data;

    REG_DISPCNT &= ~DISPCNT_BG1_ON;

    gIwram_34D0._field_10 = 0;

    /* Read gIwram_3480._unk14 inline at every lookup: caching it in a local
     * lets agbcc CSE the index away, which diverges from the baserom's
     * reload-per-access. sWinPoseSpriteCoords packs (x, y) u16 pairs. */
    gIwram_34D0._field_04 = sWinPoseSpriteCoords[gIwram_3480._unk14 * 2] - 16;
    gIwram_34D0._field_05 = sWinPoseSpriteCoords[gIwram_3480._unk14 * 2 + 1] - 24;
    gIwram_34D0._field_00 = sWinPoseSpriteCoords[gIwram_3480._unk14 * 2] - 16;
    gIwram_34D0._field_02 = sWinPoseSpriteCoords[gIwram_3480._unk14 * 2 + 1] - 24;
    gIwram_34D0._field_1D = 3;

    if (gIwram_34A0._field_08 == 0) {
        s32 flag;

        sub_08018C0C(14);

        flag = (gIwram_34A0._field_08 == 0);
        sub_08018898(flag, 0x21, 6, args, 2);

        REG_DMA3.src = (void *)0x081e5c18;
        REG_DMA3.dst = (void *)0x0600e800;
        REG_DMA3.cnt = DMA_ENABLE | 0x400;
        (void)REG_DMA3.cnt;
    } else {
        sub_0801844C();

        /* Four-stage screen install via DMA3 (see src/data/screen_d8b98.c):
         * palette -> BG palette RAM, char tiles -> charblock 0, then two
         * tilemaps into screenblocks 28 and 29. */
        REG_DMA3.src = (void *)0x081dab98; /* sScreenPaletteDAB98 */
        REG_DMA3.dst = (void *)0x05000000;
        REG_DMA3.cnt = DMA_ENABLE | 0x100;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = (void *)0x081dad98; /* sScreenCharTilesDAD98 */
        REG_DMA3.dst = (void *)0x06000000;
        REG_DMA3.cnt = DMA_ENABLE | 0x4000;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = (void *)0x081e4418; /* sScreenTilemapE4418 */
        REG_DMA3.dst = (void *)0x0600e000;
        REG_DMA3.cnt = DMA_ENABLE | 0x400;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = (void *)0x081e5c18;
        REG_DMA3.dst = (void *)0x0600e800;
        REG_DMA3.cnt = DMA_ENABLE | 0x400;
        (void)REG_DMA3.cnt;
    }

    sub_08018CA8();
    sub_080200B4();

    gIwram_3480._data[2]++;
    gIwram_5398 = 0;
}
