#include "macros.h"
#include "game.h"
#include "types.h"
#include "iwram.h"

enum ScaleAnimSyncState {
    SCALEANIM_SYNC_IDLE = 0,
    SCALEANIM_SYNC_SELECTED = 1,
    SCALEANIM_SYNC_CLEARED = 2,
};

struct ScaleAnimState {
    u8 _pad00[0xd3];
    u8 selectorAccum;
    u8 _padD4[8];
    u8 state;
};

struct ScaleAnimDesc {
    u16 dstX;
    u16 dstY;
    u16 width;
    u16 rows;
    u8 flags;
    u8 _pad09[7];
    const u16 **srcTable;
    u32 _pad14;
};

/* Frame counter of the scale animation, stored inside the gEntities pool
 * region. Overlaying the symbol keeps the +0x1a5b offset as a separate pool
 * word (`ldr =gEntities; ldr =0x1a5b; adds`), which a folded `sym+0x1a5b`
 * constant would not give. */
struct ScaleAnimPool {
    u8 _pad00[0x1a5b];
    u8 frameCounter;
};

extern struct ScaleAnimState gIwram_3610;
#define gScaleAnimPool (*(struct ScaleAnimPool *)gEntities)
extern const struct ScaleAnimDesc sScaleAnimDescriptors[];
extern const struct ScaleAnimDesc sScaleAnimDescriptors2[];

void Tilemap_BlitTileRows(u32 flags, u32 dstX, u32 dstY, u32 width, u32 rows, const u16 **srcTable, u32 srcIndex);
void RemapInputBits(void);
void ScaleAnim_ClearActiveBits(void);
void ScaleAnim_BlitSceneLayers(void);
void ScaleAnim_TickFrames(void);

void ScaleAnim_SyncSelectors(void)
{
    struct ScaleAnimState *anim = &gIwram_3610;
    u8 i;
    u16 flags;
    u32 low5;
    u32 low6;
    /* The loop writes the state through a constant pointer: a pool word that
     * reload rematerialises per site, instead of keeping `anim + 0xdc` alive
     * (or spilled) across the loop. */
    u8 *state = (u8 *)0x030036EC;

    switch (anim->state) {
    case SCALEANIM_SYNC_IDLE:
        flags = gIwram_6110.selector5Flags;
        low5 = flags & 0xff;
        flags = gIwram_6110.selector6Flags;
        low6 = flags & 0xff;
        if (low5 == low6)
            break;

        anim->selectorAccum = 0;
        i = 0;
        do {
            u32 on = (gIwram_6110.selector5Flags >> i) & 1;
            u32 off = (gIwram_6110.selector6Flags >> i) & 1;
            u32 bit;
            const struct ScaleAnimDesc *d0;
            const struct ScaleAnimDesc *d1;

            if (on != off) {
                switch (on) {
                case 0:
                    bit = 1 << i;
                    anim->selectorAccum |= bit;
                    d0 = &sScaleAnimDescriptors[i];
                    Tilemap_BlitTileRows(d0->flags, d0->dstX, d0->dstY, d0->width, d0->rows,
                                         sScaleAnimDescriptors[i].srcTable, 0);
                    d1 = &sScaleAnimDescriptors2[i];
                    Tilemap_BlitTileRows(d1->flags, d1->dstX, d1->dstY, d1->width, d1->rows,
                                         sScaleAnimDescriptors2[i].srcTable, 0);
                    gIwram_6110.selector6Flags &= ~bit;
                    gScaleAnimPool.frameCounter = 0;
                    *state = SCALEANIM_SYNC_CLEARED;
                    break;
                case 1:
                    bit = 1 << i;
                    anim->selectorAccum |= bit;
                    d0 = &sScaleAnimDescriptors[i];
                    Tilemap_BlitTileRows(d0->flags, d0->dstX, d0->dstY, d0->width, d0->rows,
                                         sScaleAnimDescriptors[i].srcTable, 1);
                    d1 = &sScaleAnimDescriptors2[i];
                    Tilemap_BlitTileRows(d1->flags, d1->dstX, d1->dstY, d1->width, d1->rows,
                                         sScaleAnimDescriptors2[i].srcTable, 2);
                    gIwram_6110.selector6Flags |= bit;
                    gScaleAnimPool.frameCounter = 0;
                    *state = SCALEANIM_SYNC_SELECTED;
                    break;
                }
            }
            /* No-op self-store: it is deleted, but the reference keeps the
             * `anim->state` address pseudo (r4) live across the selector
             * compare above, so reload takes r6 (not r4) for the two flag
             * loads there. */
            anim->state = anim->state;
            i++;
        } while (i <= 7);
        break;
    case SCALEANIM_SYNC_SELECTED:
        RemapInputBits();
        ScaleAnim_BlitSceneLayers();
        anim->state = SCALEANIM_SYNC_IDLE;
        break;
    case SCALEANIM_SYNC_CLEARED:
        ScaleAnim_ClearActiveBits();
        ScaleAnim_BlitSceneLayers();
        anim->state = SCALEANIM_SYNC_IDLE;
        break;
    }

    ScaleAnim_TickFrames();
}
