#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"
#include "save.h"
#include "types.h"

/* 16-byte screen-install argument block passed by value to sub_08018898.
 * Same shape as sub_0801FD0C's installer (the sibling screen-setup routine). */
struct ScreenInstallArgs {
    u32 _unk00;
    const void *tilemap1;
    const void *tilemap2;
    u32 _unk0C;
};

extern void sub_0801844C(void);
extern void sub_08018648(s32 a, s32 b, s32 c, s32 d);
extern void sub_080185C0(s32 a, s32 b, s32 c, s32 d);
extern void sub_08018898(s32 flag, s32 a, s32 b, struct ScreenInstallArgs args, s32 last);
extern void sub_08018C0C(s32 mode);
extern u8 sub_0801C900(s32 a, s32 b, const void *c, s32 d, s32 e, s32 f);
extern void sub_0801F684(void);
extern s32 sub_0801F8BC(u8 idx);
extern u16 sub_080004C4(void);
extern void sub_08020C78(u32 sound);

extern u16 gIwram_5398;
extern const u32 sOamDmaCfg_08100[4];

/* ROM tables anchored inside the sprite-frame-pointer block, indexed by the
 * scene id in gIwram_34B0._data (see linker.ld). sScreenTilemapTable[id] is
 * the tilemap2 source for the screen install; sSceneRecordTable[id] points at
 * a record whose [1]/[2] entries are handed to sub_0801C900. Linker-assigned
 * so each base load is a relocation that agbcc materialises before the index. */
extern const void *const sScreenTilemapTable_308EF4[];
extern const void *const *const sSceneRecordTable_308110[];

void sub_0801F418(void)
{
    struct ScreenInstallArgs args;

    args._unk00 = 0;
    args.tilemap1 = (const void *)0x081d8b98;
    args.tilemap2 = sScreenTilemapTable_308EF4[gIwram_34B0._data];
    args._unk0C = 0;

    gIwram_3480._unk14 = 0;

    if (gIwram_34A0._field_08 == 0) {
        sub_0801844C();

        REG_DMA3.src = (const void *)0x081dab98;
        REG_DMA3.dst = (void *)0x05000000;
        REG_DMA3.cnt = DMA_ENABLE | 0x100;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = (const void *)0x081dad98;
        REG_DMA3.dst = (void *)0x06000000;
        REG_DMA3.cnt = DMA_ENABLE | 0x4000;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = (const void *)0x081e4418;
        REG_DMA3.dst = (void *)0x0600e000;
        REG_DMA3.cnt = DMA_ENABLE | 0x400;
        (void)REG_DMA3.cnt;
    } else {
        s32 flag;

        sub_08018C0C(14);

        flag = (gIwram_34A0._field_08 == 0);
        sub_08018898(flag, 29, 6, args, 2);

        REG_DISPCNT |= DISPCNT_BG3_ON;
    }

    REG_DISPCNT |= DISPCNT_BG1_ON;

    REG_DMA3.src = (const void *)0x081d8b98;
    REG_DMA3.dst = (void *)0x0600e800;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;

    sub_0801F684();

    if (gIwram_34A0._field_08 != 0) {
        const void *const *rec = sSceneRecordTable_308110[gIwram_34B0._data];
        sub_0801C900(0, 6, rec[1], 28, 0, 1);
    }

    gIwram_3480._data[2]++;
}

void sub_0801F560(void)
{
    gIwram_5398 = sub_080004C4();

    switch (gIwram_5398) {
    case 16:
    case 64: {
        const void *const *rec;
        u8 poseIdx;
        u8 finalIdx;

        sub_08020C78(1);

        rec = sSceneRecordTable_308110[gIwram_34B0._data];
        if ((*(u8 *)&gSaveData >> (poseIdx = gIwram_3480._unk14)) & 1) {
            if (sub_0801C900(0, 6, rec[2], 28, 0, 0) == 0)
                break;
            finalIdx = gIwram_3480._unk14;
        } else {
            finalIdx = poseIdx;
        }

        if (sub_0801F8BC(finalIdx) == 0)
            sub_0801F684();
        break;
    }
    case 1:
        sub_08020C78(2);
        if (gIwram_3480._unk14 == 0) {
            gIwram_3480._unk14 = 3;
            break;
        }
        gIwram_3480._unk14--;
        break;
    case 2: {
        /* pin the constant to r1 and the reload to r2 so the 0x3480 base lands
         * in r0 (case 1 uses r1) -- the two differing strb encodings stop the
         * cross-jumper from merging the per-case pose stores. The volatile
         * reload forces the inc store to commit before the &3 mask (baserom
         * does two read-modify-writes on the pose byte). */
        register u8 three asm("r1");
        register u8 reloaded asm("r2");

        sub_08020C78(2);
        gIwram_3480._unk14++;
        three = 3;
        reloaded = *(volatile u8 *)&gIwram_3480._unk14;
        gIwram_3480._unk14 = three & reloaded;
        break;
    }
    }

    if (gIwram_5398 == 32) {
        gIwram_5398 = 0;
        sub_08020C78(0);
        gIwram_34A0._field_08 = 0;
        sub_08018648(0, 30, 6, 2);
        gIwram_3480._data[2]++;
    } else if (gIwram_5398 != 0 && gIwram_5398 != 16 && gIwram_5398 != 64) {
        gIwram_5398 = 0;
        sub_0801F684();
    } else {
        sub_080185C0(sOamDmaCfg_08100[0], sOamDmaCfg_08100[1], sOamDmaCfg_08100[2], sOamDmaCfg_08100[3]);
    }
}
