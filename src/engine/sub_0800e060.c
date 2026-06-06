#include "game.h"
#include "gba/dma.h"
#include "types.h"

extern void sub_08020B60(void);
extern void sub_08020C78(u32 a);

/* Scene/mode teardown dispatched on gGameStuff.pendingMode. Modes 3, 6, 9, 15
 * additionally clear REG_BLDCNT before the shared teardown body; all other
 * pendingMode values (and any out-of-range) skip straight to the body.
 *
 * Shared body:
 *   - DMA3 halfword-fill 0x400 halfwords at OBJ-VRAM 0x0600F800 from a
 *     stack-local halfword seed of 0xF039.
 *   - Reset five bytes in the 0x03005370 control struct (offsets 0/4/8/12/16).
 *   - Set the 0x03005328 control byte to 1.
 *   - DMA3 copy from ROM 0x080E3AB6 to BG-VRAM 0x06008000 (0x2000 halfwords).
 *   - If *(u32 *)0x030034B0 is nonzero, DMA3 copy a second tile blob
 *     pointed to by g_TileBlobTable[*(u32 *)0x030034B0 - 1] into the same
 *     BG-VRAM region (0xA00 halfwords).
 *   - Call sub_08020B60(), then sub_08020C78(3).
 *   - Set gGameStuff._unk18 |= 1 and gGameStuff._unk04 = 6.
 *
 * Matching notes (agbcc 2.x):
 *   - The 16-entry casesi jump table at e080 comes from `switch (pendingMode)`
 *     with explicit empty cases 1..16 (so agbcc keeps the dense
 *     `subs #1; cmp #15; bhi default` dispatch instead of folding the four
 *     active cases into an if-chain).
 *   - The empty `tileTable` barrier blocks agbcc from CSE-folding
 *     `&tileTable[idx-1]` into `(tileTable - 4) + idx*4`. Without the
 *     barrier the pool literal stores 0x08308FA8 (= 0x08308FAC - 4) and
 *     the `subs r0, #1` step disappears.
 *   - The trailing `g` plus `flag` block keeps the post-BL recovery
 *     sequence in baserom's `ldr r0, [pool]; movs r1, #1; ldrb r2,
 *     [r0, #24]; orrs r1, r2; strb r1, [r0, #24]` shape.
 */

void sub_0800E060(void)
{
    vu16 seed;
    u8 *ctrl5370;
    u32 idx;
    const u32 *tileTable;

    switch (gGameStuff.pendingMode) {
    case 3:
    case 6:
    case 9:
    case 15:
        *(vu16 *)0x04000050 = 0;
        break;
    case 1:
    case 2:
    case 4:
    case 5:
    case 7:
    case 8:
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
    case 16:
    default:
        break;
    }

    seed = 0xF039;
    REG_DMA3.src = (const void *)&seed;
    REG_DMA3.dst = (void *)0x0600F800;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)REG_DMA3.cnt;

    ctrl5370 = (u8 *)0x03005370;
    ctrl5370[0] = 1;
    ctrl5370[4] = 3;
    ctrl5370[8] = 1;
    ctrl5370[12] = 9;
    ctrl5370[16] = 9;

    *(u8 *)0x03005328 = 1;

    REG_DMA3.src = (const void *)0x080E3AB6;
    REG_DMA3.dst = (void *)0x06008000;
    REG_DMA3.cnt = DMA_ENABLE | 0x2000;
    (void)REG_DMA3.cnt;

    idx = *(u32 *)0x030034B0;
    if (idx != 0) {
        tileTable = (const u32 *)0x08308FAC;
        asm volatile("" : "+r"(tileTable));
        idx -= 1;
        REG_DMA3.src = (const void *)tileTable[idx];
        REG_DMA3.dst = (void *)0x06008000;
        REG_DMA3.cnt = DMA_ENABLE | 0xA00;
        (void)REG_DMA3.cnt;
    }

    sub_08020B60();
    sub_08020C78(3);

    {
        GameStuff *g;
        u8 flag;
        g = &gGameStuff;
        flag = 1;
        g->_unk18 |= flag;
        g->_unk04 = 6;
    }
}

/* --- sub_0800E174: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
typedef struct {
    u16 x;
    u16 y;
    u16 w;
    u16 h;
    const u16 *tile_data;
} FrameDescriptor;

extern const FrameDescriptor *const sSpriteAnimFrameSet_06824[];

/* Per-slot tile blitter into OBJ-VRAM screenblock 31 (0x0600F800). The five
 * control bytes at 0x03005370 (stride 4, written by sub_0800E060) each select
 * a blit mode for the matching FrameDescriptor record; bit 0x80 marks a slot
 * already drawn. Records come from the 0x080C1xxx descriptor array selected by
 * gIwram_34B0._data. After the loop, an empty handshake byte at 0x03005328
 * triggers a full VRAM clear + sub_08016A40().
 *
 * Mode 1: blit verbatim.
 * Mode 2: blit each tile masked with 0xEFFF (clear the palette-bank-high bit).
 * Mode 3: gated on (gGameStuff._unk04 & 7) == 0; blits verbatim, and when
 *         (gGameStuff._unk04 & 0xF) == 0 re-stores the masked tile.
 * Mode 9: fill the rect with the blank tile 0xF039, then reset the slot byte.
 *
 * Matching note: the row advance to the record's y origin is a `dst += 32`
 * count-up loop (not a `y << 5` shift), and the per-row x indent is re-added
 * inside the outer loop so the trailing skip is `32 - x - h`.
 */
void sub_0800E174(void)
{
    const FrameDescriptor *records;
    u8 idx;

    records = sSpriteAnimFrameSet_06824[gIwram_34B0._data];

    for (idx = 0; idx <= 4; idx++) {
        u8 ctrl = ((u8 *)0x03005370)[idx * 4];

        if (ctrl & 0x80) {
            continue;
        }

        switch (ctrl & 0xF) {
        case 1: {
            const u16 *src = records[idx].tile_data;
            u16 *dst = (u16 *)0x0600F800;
            u16 row;
            u16 n;

            for (n = 0; n < records[idx].y; n++) {
                dst += 32;
            }
            for (row = 0; row < records[idx].w; row++) {
                u16 col;
                dst += records[idx].x;
                for (col = 0; col < records[idx].h; col++) {
                    *dst++ = *src++;
                }
                dst += 32 - records[idx].x - records[idx].h;
            }
            ((u8 *)0x03005370)[idx * 4] |= 0x80;
            break;
        }
        case 2: {
            const u16 *src = records[idx].tile_data;
            u16 *dst = (u16 *)0x0600F800;
            u16 row;
            u16 n;

            for (n = 0; n < records[idx].y; n++) {
                dst += 32;
            }
            for (row = 0; row < records[idx].w; row++) {
                u16 col;
                dst += records[idx].x;
                for (col = 0; col < records[idx].h; col++) {
                    *dst++ = *src++ & 0xEFFF;
                }
                dst += 32 - records[idx].x - records[idx].h;
            }
            ((u8 *)0x03005370)[idx * 4] |= 0x80;
            break;
        }
        case 3: {
            const u16 *src;
            u16 *dst;
            u16 row;
            u16 n;

            if ((gGameStuff._unk04 & 7) != 0) {
                break;
            }

            src = records[idx].tile_data;
            dst = (u16 *)0x0600F800;
            for (n = 0; n < records[idx].y; n++) {
                dst += 32;
            }
            for (row = 0; row < records[idx].w; row++) {
                u16 col;
                u32 lowMode = gGameStuff._unk04 & 0xF;
                u16 mask = 0xEFFF;
                dst += records[idx].x;
                for (col = 0; col < records[idx].h; col++) {
                    u16 tile = *src++;
                    *dst = tile;
                    if (lowMode == 0) {
                        *dst = tile & mask;
                    }
                    dst++;
                }
                dst += 32 - records[idx].x - records[idx].h;
            }
            break;
        }
        case 9: {
            u16 *dst = (u16 *)0x0600F800;
            u16 row;
            u16 n;

            for (n = 0; n < records[idx].y; n++) {
                dst += 32;
            }
            for (row = 0; row < records[idx].w; row++) {
                u16 col;
                dst += records[idx].x;
                for (col = 0; col < records[idx].h; col++) {
                    *dst++ = 0xF039;
                }
                dst += 32 - records[idx].x - records[idx].h;
            }
            ((u8 *)0x03005370)[idx * 4] = 0;
            break;
        }
        default:
            break;
        }
    }

    if (*(u8 *)0x03005328 == 0) {
        vu16 seed;
        vu32 *dma;

        seed = 0;
        dma = (vu32 *)0x040000D4;
        dma[0] = (u32)&seed;
        dma[1] = 0x0600F800;
        dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
        (void)dma[2];

        sub_08016A40();
    }
}
#endif /* NON_MATCHING */
