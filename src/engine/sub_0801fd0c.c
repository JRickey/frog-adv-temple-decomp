#include "game.h"
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
extern void sub_080185C0(u32 a, u32 b, u32 c, u32 d);

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

extern u16 sub_080004C4(void);
extern void sub_08020C78(u32 sound);
extern void sub_08019014(u32 a);
extern void sub_08019958(u32 x);
extern void sub_08019834(void *self, u16 u1, u16 u2, u8 u3, u8 count);
extern void sub_08018648(u32 a, u16 b, u16 c, u8 d);
extern void sub_08018EF0(void);
extern void sub_08019228(void);
extern const u32 sOamDmaCfg_08100[4];
extern const u16 sWinPoseHeader[4];

/* The OAM shadow buffer at IWRAM 0x030054A0 (sibling routines memset it to a
 * hidden-sprite sentinel). sub_0801FE68 stamps the same 8-byte record from
 * sWinPoseHeader into its first seven slots; expressing the copy as an
 * 8-byte record assignment (rather than two scalar stores) is what makes
 * agbcc keep the source pointer / dest base in the baserom's register pair. */
struct OamPair {
    u32 a;
    u32 b;
};
extern struct OamPair gOamShadow_54A0[];

void sub_0801FE68(void)
{
    u32 attr;
    u16 state;
    u8 i;

    attr = (attr & 0xffffff00) | 0x08;
    attr = (attr & 0xffff00ff) | 0x0300;
    attr = (attr & 0x00ffffff) | 0x03000000;
    attr = (attr & 0xff00ffff) | 0x000e0000;

    gIwram_5398 = sub_080004C4();
    state = gIwram_5398;

    switch (state) {
    case 1:
        sub_08020C78(2);
        if (gIwram_3480._unk14 == 0)
            goto tail;
        gIwram_3480._unk14--;
        /* state == 1 here; the baserom reuses the just-read selector register
         * rather than materialising a fresh literal (case 2 below uses 1). */
        gIwram_34D0._field_10 = state;
        gIwram_34D0._field_08 = state;
        sub_08019014(1);
        goto tail;

    case 2:
        sub_08020C78(2);
        if (gIwram_3480._unk14 == 4)
            goto tail;
        gIwram_3480._unk14++;
        gIwram_34D0._field_10 = 1;
        gIwram_34D0._field_08 = 1;
        sub_08019014(0);
        goto tail;

    case 16:
    case 64:
        sub_08020C78(1);
        sub_08019958(gIwram_3480._unk14);

        switch (gIwram_3480._unk14) {
        case 0:
            attr = (attr & 0xffff00ff) | 0x0300;
            break;
        case 1:
            attr = (attr & 0xffff00ff) | 0x0600;
            break;
        case 2:
            attr = (attr & 0xffff00ff) | 0x0900;
            break;
        case 3:
            attr = (attr & 0xffff00ff) | 0x0c00;
            break;
        case 4:
            attr = (attr & 0xffff00ff) | 0x0f00;
            break;
        }

        if (gIwram_3480._unk14 != 3)
            sub_08019834(&attr, 0, 1, 2, 10);
        else
            sub_08019834(&attr, 2, 3, 2, 10);

        for (i = 0; i <= 6; i++) {
            struct OamPair rec = *(const struct OamPair *)sWinPoseHeader;
            gOamShadow_54A0[i] = rec;
        }

        REG_DISPCNT &= ~DISPCNT_OBJ_ON;
        gIwram_34A0._field_08 = 1;
        sub_08018648(1, 23, 6, 2);

        gGameStuff.mode = GAME_MODE_ROUTER;
        gIwram_3480._data[0] = 8;
        gIwram_3480._data[5] = 0;
        gIwram_3480._data[2] = 0;
        gIwram_3480._data[1] = 0;
        gIwram_5398 = 0;
        gIwram_3480._data[7] = 0;
        break;
    }

tail:
    if (gIwram_5398 == 32) {
        sub_08020C78(0);
        REG_DISPCNT &= ~DISPCNT_OBJ_ON;
        gIwram_3480._data[2]++;
    } else if (gIwram_5398 != 0 && gIwram_5398 != 16 && gIwram_5398 != 64) {
        sub_080200B4();
        sub_08019228();
    } else {
        sub_080185C0(sOamDmaCfg_08100[0], sOamDmaCfg_08100[1], sOamDmaCfg_08100[2], sOamDmaCfg_08100[3]);
        sub_08018EF0();
    }

    gIwram_5398 = 0;
}
