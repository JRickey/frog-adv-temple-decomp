#include "macros.h"
#include "sound.h"
#include "types.h"

/* --- Scroll_TickBlitDir: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

/* One per-axis blit record in the array passed in as `records`. Only the
 * per-axis step and the direction tag are read here. */
typedef struct ScrollRecord {
    u8 _pad00[4];
    u16 step; /* +0x04 */
    u8 _pad06[2];
    u8 kind; /* +0x08, low nibble selects the scroll direction (1..4) */
    u8 _pad09[15];
} ScrollRecord;

/* Scroll-blit bookkeeping block at IWRAM 0x03006540. */
typedef struct ScrollBlitState {
    u8 startBuf; /* +0x00 */
    u8 _pad01[1];
    u8 active; /* +0x02, per-direction enable bitmask */
    u8 _pad03[1];
    u32 lastTick; /* +0x04 */
    u8 mirror;    /* +0x08, selects the off-screen blit buffer pair */
    u8 _pad09[2];
    u8 delay;    /* +0x0B */
    u32 srcRead; /* +0x0C */
    u32 srcBase; /* +0x10 */
    u32 dstRead; /* +0x14 */
    u32 dstBase; /* +0x18 */
    u8 _pad1C[16];
    s16 colsLeft; /* +0x2C */
    s16 rowsLeft; /* +0x2E */
    u16 height;   /* +0x30 */
    u16 width;    /* +0x32 */
} ScrollBlitState;

/* romTable[sceneType-1] (20-byte stride). +0 points at the scroll record
 * array (also passed in as `records`), +12 is the per-direction step lut:
 * u8 pairs [n*2] = start index, [n*2+1] = limit. */
typedef struct ScrollModeEntry {
    void *records; /* +0x00 */
    u8 _pad04[8];
    const u8 *dirLut; /* +0x0C */
    u8 _pad10[4];
} ScrollModeEntry;

extern void Scroll_PrepareBlitWork(void *records, u8 n, u32 arg2);
extern void Scroll_FlushTilemapWindow(u32 mirror, void *src, void *dst);

extern u16 gIwram_60A0[];
extern ScrollModeEntry gFrameCellTable_08307EAC[];

void Scroll_TickBlitDir(void *records, u8 n)
{
    register void *recordsReg asm("r9") = records;
    u32 dir = n;
    register ScrollBlitState *scroll asm("r6") = (ScrollBlitState *)0x03006540;
    register u8 *dirStep asm("sl");
    register u32 n2 asm("r8");
    register ScrollModeEntry *romTable asm("r4") = gFrameCellTable_08307EAC;
    const u8 *dirLut;
    ScrollRecord *rec;
    u32 pm1;
    int kind;
    u8 i;

    if (((scroll->active >> dir) & 1) == 0)
        return;

    pm1 = gGameStuff.sceneType - 1;
    {
        /* Form (romTable + 12) as a held field-column base before adding the
         * scaled index, matching the baserom's `adds r1,#12; adds r0,r0,r1`. */
        const u8 *const *col = (const u8 *const *)((char *)romTable + 12);
        dirLut = *(const u8 *const *)((char *)col + pm1 * 20);
    }
    {
        u32 n2tmp = dir << 1;
        const u8 *lutEnt = (const u8 *)(n2tmp + (u32)dirLut);
        u8 *step = (u8 *)0x030063f0;
        u8 *stepEnt = step + dir;
        rec = &((ScrollRecord *)recordsReg)[*lutEnt + *stepEnt];
        kind = rec->kind & 0xf;
        n2 = n2tmp;
        dirStep = step;
    }

    switch (kind) {
    case 1:
        if (gGameStuff._unk00 - scroll->lastTick >= scroll->delay) {
            scroll->dstRead = scroll->dstBase;
            scroll->dstBase += gIwram_60A0[13] << 1;
            scroll->srcRead = scroll->srcBase;
            scroll->srcBase += rec->step << 1;
            if (scroll->rowsLeft != 0) {
                for (i = 0; i < scroll->height; i++) {
                    *(u16 *)scroll->dstRead = *(u16 *)scroll->srcRead;
                    scroll->srcRead += 2;
                    scroll->dstRead += 2;
                }
                scroll->rowsLeft--;
                scroll->lastTick = gGameStuff._unk00;
            }
        }
        if (scroll->rowsLeft != 0)
            goto refresh;
        break;
    case 2:
        if (gGameStuff._unk00 - scroll->lastTick >= scroll->delay) {
            scroll->dstRead = scroll->dstBase;
            scroll->dstBase -= gIwram_60A0[13] << 1;
            scroll->srcRead = scroll->srcBase;
            scroll->srcBase -= rec->step << 1;
            if (scroll->rowsLeft != 0) {
                for (i = 0; i < scroll->height; i++) {
                    *(u16 *)scroll->dstRead = *(u16 *)scroll->srcRead;
                    scroll->srcRead += 2;
                    scroll->dstRead += 2;
                }
                scroll->rowsLeft--;
                scroll->lastTick = gGameStuff._unk00;
            }
        }
        if (scroll->rowsLeft != 0)
            goto refresh;
        break;
    case 3:
        if (gGameStuff._unk00 - scroll->lastTick >= scroll->delay) {
            scroll->dstRead = scroll->dstBase;
            scroll->dstBase += 2;
            scroll->srcRead = scroll->srcBase;
            scroll->srcBase += 2;
            if (scroll->colsLeft != 0) {
                ScrollBlitState *s = scroll;
                u32 src = s->srcRead;
                u32 dst = s->dstRead;
                for (i = 0; i < s->width; i++) {
                    *(u16 *)dst = *(u16 *)src;
                    dst += ((u16 *)gIwram_60A0)[13] << 1;
                    src += s->height << 1;
                }
                s->srcRead = src;
                s->dstRead = dst;
                scroll->colsLeft--;
                scroll->lastTick = gGameStuff._unk00;
            }
        }
        if (scroll->colsLeft != 0)
            goto refresh;
        break;
    case 4:
        if (gGameStuff._unk00 - scroll->lastTick >= scroll->delay) {
            scroll->dstRead = scroll->dstBase;
            scroll->dstBase -= 2;
            scroll->srcRead = scroll->srcBase;
            scroll->srcBase -= 2;
            if (scroll->colsLeft != 0) {
                ScrollBlitState *s = scroll;
                u32 src = s->srcRead;
                u32 dst = s->dstRead;
                for (i = 0; i < s->width; i++) {
                    *(u16 *)dst = *(u16 *)src;
                    dst += ((u16 *)gIwram_60A0)[13] << 1;
                    src += s->height << 1;
                }
                s->srcRead = src;
                s->dstRead = dst;
                scroll->colsLeft--;
                scroll->lastTick = gGameStuff._unk00;
            }
        }
        if (scroll->colsLeft != 0)
            goto refresh;
        break;
    default:
        goto refresh;
    }

    {
        const u8 *const *col2 = (const u8 *const *)((char *)romTable + 12);
        const u8 *lut2 = *(const u8 *const *)((char *)col2 + (gGameStuff.sceneType - 1) * 20);
        if (dirStep[dir] < lut2[n2 + 1] - 1) {
            dirStep[dir]++;
            Scroll_PrepareBlitWork(recordsReg, dir, 0);
            goto refresh;
        }
    }
    dirStep[dir] = 0;
    scroll->active = 0;

refresh:
    if (gGameStuff.sceneType != 11)
        SoundEntry_Play(11);

    if (scroll->active == 0) {
        if (gGameStuff.sceneType != 11) {
            SoundEntry_Stop(11);
            Sound_Play(0x82);
        }
        scroll->startBuf = 0;
        gIwram_35E0._field_10 &= 0xfffe;
        gIwram_35E0._field_12 = 0;
    }

    if (scroll->mirror != 0) {
        scroll->srcRead = 0x02010000;
        scroll->dstRead = 0x0600e800;
    } else {
        scroll->srcRead = 0x02000000;
        scroll->dstRead = 0x0600e000;
    }

    Scroll_FlushTilemapWindow(scroll->mirror, (void *)scroll->srcRead, (void *)scroll->dstRead);
}
#else
NAKED void Scroll_TickBlitDir(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x10f64, 0x324\n");
}
#endif /* NON_MATCHING */
