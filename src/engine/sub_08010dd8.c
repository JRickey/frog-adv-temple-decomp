#include "macros.h"
#include "types.h"

/* --- Scroll_PrepareBlitWork: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

extern const u32 *gFrameCellTable_08307EAC[];

struct DrawRecord {
    u16 x;      /* +0x00 */
    u16 _unk02; /* +0x02 */
    u16 w;      /* +0x04 */
    u16 h;      /* +0x06 */
    u8 flags;   /* +0x08 */
    u8 _pad09[3];
    u8 _unk0C; /* +0x0C */
    u8 _pad0D[3];
    u32 *src; /* +0x10 */
};

struct BlitWork {
    u8 tile; /* +0x00 */
    u8 _pad01;
    u8 _unk02; /* +0x02 */
    u8 _pad03[5];
    u8 bank; /* +0x08 */
    u8 _pad09[2];
    u8 _unk0B; /* +0x0B */
    u8 _pad0C[12];
    u32 srcOffset; /* +0x18 */
    u8 _pad1C[16];
    u16 _unk2C; /* +0x2C */
    u16 _unk2E; /* +0x2E */
    u16 _unk30; /* +0x30 */
    u16 _unk32; /* +0x32 */
};

struct SceneStride {
    u8 _pad00[26];
    u16 stride; /* +0x1A */
};

void Scroll_PrepareBlitWork(struct DrawRecord *records, u32 idxArg, u32 commit)
{
    register u32 i asm("r4") = (u8)idxArg;
    register u8 *control asm("r2") = (u8 *)&gIwram_6110;
    register u8 *ctrlSaved asm("ip");
    u8 *stream;
    register u8 *streamBytes asm("r2"); /* temp: reuses control's freed r2 */
    register u8 *sbHome asm("r6");      /* callee-saved home for the late use */
    struct DrawRecord *rec;
    struct BlitWork *blit;
    struct BlitWork *bw; /* working copy (target r2) */
    u32 bitA;
    u32 ewram;

    bitA = control[0x2a] >> i & 1;
    ctrlSaved = control;
    if (bitA == 0 || bitA == (ctrlSaved[0x2b] >> i & 1)) {
        if (commit != 0) {
            return;
        }
    }

    {
        u8 *table = (u8 *)gFrameCellTable_08307EAC;
        u32 sceneIdx = gGameStuff.sceneType - 1;
        asm("" : "+r"(table)); /* keep +12 a runtime add, not folded to table-8 */
        table += 12;
        stream = *(u8 **)(table + sceneIdx * 20);
    }
    streamBytes = (u8 *)0x030063F0;
    rec = (struct DrawRecord *)((u8 *)records + (stream[i * 2] + streamBytes[i]) * 24);
    sbHome = streamBytes;

    if ((rec->flags >> 4 & 1) != 0) {
        ((struct BlitWork *)0x03006540)->bank = 1;
        ewram = 0x02010000;
    } else {
        ((struct BlitWork *)0x03006540)->bank = 0;
        ewram = 0x02000000;
    }
    blit = (struct BlitWork *)0x03006540;
    blit->srcOffset = ewram;

    gIwram_35E0._field_10 = 1;

    bw = blit;
    bw->tile = sbHome[i] + 1;
    if (commit != 0) {
        bw->_unk02 += 1 << i;
    }

    bw->_unk0B = rec->_unk0C;
    bw->_unk30 = rec->w;
    bw->_unk32 = rec->h;
    bw->_unk2C = rec->w;
    bw->_unk2E = rec->h;

    switch (rec->flags & 15) {
    case 2:
        bw->srcOffset += 2 * (rec->x + ((struct SceneStride *)0x030060A0)->stride * (rec->_unk02 + rec->h - 1));
        *(u32 *)((u8 *)bw + 16) = *rec->src + 2 * ((rec->h - 1) * rec->w);
        break;
    case 1:
    case 3:
        bw->srcOffset += 2 * (rec->x + ((struct SceneStride *)0x030060A0)->stride * rec->_unk02);
        *(u32 *)((u8 *)bw + 16) = *rec->src;
        break;
    case 4:
        blit->srcOffset += 2 * (rec->x + ((struct SceneStride *)0x030060A0)->stride * rec->_unk02);
        blit->srcOffset += rec->w * 2 - 2;
        *(u32 *)((u8 *)blit + 16) = *rec->src;
        *(u32 *)((u8 *)blit + 16) += rec->w * 2 - 2;
        break;
    }

    if (commit != 0) {
        ctrlSaved[0x2b] = ctrlSaved[0x2a];
    }
}
#else
NAKED void Scroll_PrepareBlitWork(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x10dd8, 0x18c\n");
}
#endif /* NON_MATCHING */
