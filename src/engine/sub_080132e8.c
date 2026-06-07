#include "macros.h"
#include "types.h"

/* --- ScaleAnim_BlitSceneLayers: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "gfx.h"
#include "macros.h"
#include "types.h"
#include "iwram.h"

void ScaleAnim_BlitSceneLayers(void)
{
    register struct TilemapTableEntry *sceneA asm("r6");
    register struct TilemapTableEntry *sceneB asm("r5");
    register u8 *status asm("r8");
    register u8 indexA asm("sl");
    register u8 indexB asm("r9");
    register struct TilemapTableEntry *desc asm("r4");
    u8 mode; /* UNPINNED on purpose: pinning -> r7 const-fold/peel */
    u8 cleared;
    u8 mask2;

    if ((gIwram_6110.byteFlags8 & 0xf0) == (gIwram_6110.gateByte & 0xf0))
        return;

    mode = 4;
    sceneA = (struct TilemapTableEntry *)0x0830702c;
    indexA = 2;
    sceneB = (struct TilemapTableEntry *)0x083070ec;
    indexB = 3;
    status = (u8 *)0x030036e4;

    do {
        if ((gIwram_6110.gateByte >> mode) == 1)
            goto next;
        if (((gIwram_6110.byteFlags8 >> mode) & 1) == 0)
            goto next;

        switch (mode) {
        case 4:
            sub_08012BC4(sceneA->unk08, sceneA->unk00, sceneA->unk02, sceneA->unk04, sceneA->unk06, sceneA->tiles,
                         indexA);
            desc = &sceneA[5];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06,
                         ((const struct TilemapTableEntry *)0x0830702c)[5].tiles, indexA);
            sub_08012BC4(sceneB->unk08, sceneB->unk00, sceneB->unk02, sceneB->unk04, sceneB->unk06, sceneB->tiles,
                         indexB);
            desc = &sceneB[5];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06,
                         ((const struct TilemapTableEntry *)0x083070ec)[5].tiles, indexB);
            cleared = (u8)(*status & 0xfe);
            cleared = (u8)(cleared & 0xdf);
            *status = cleared;
            break;
        case 5:
            desc = &sceneA[1];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneA[1].tiles, indexA);
            desc = &sceneA[4];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneA[4].tiles, indexA);
            desc = &sceneB[1];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneB[1].tiles, indexB);
            desc = &sceneB[4];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneB[4].tiles, indexB);
            cleared = (u8)(*status & 0xfd);
            mask2 = 0xef;
            goto store;
        case 6:
            desc = &sceneA[7];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneA[7].tiles, indexA);
            desc = &sceneA[2];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneA[2].tiles, indexA);
            desc = &sceneB[7];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneB[7].tiles, indexB);
            desc = &sceneB[2];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneB[2].tiles, indexB);
            cleared = (u8)(*status & 0xfb);
            mask2 = 0x7f;
            goto store;
        case 7:
            desc = &sceneA[6];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneA[6].tiles, indexA);
            desc = &sceneA[3];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneA[3].tiles, indexA);
            desc = &sceneB[6];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneB[6].tiles, indexB);
            desc = &sceneB[3];
            sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, sceneB[3].tiles, indexB);
            cleared = (u8)(*status & 0xf7);
            mask2 = 0xbf;
        store:
            cleared = (u8)(cleared & mask2);
            *status = cleared;
            break;
        }

        gIwram_6110.gateByte |= (u8)(1 << mode);
    next:
        mode = (u8)(mode + 1);
    } while (mode <= 7);
}
#else
NAKED void ScaleAnim_BlitSceneLayers(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x132e8, 0x2d0\n");
}
#endif /* NON_MATCHING */
