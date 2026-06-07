#include "gba/dma.h"
#include "iwram.h"
#include "save.h"
#include "types.h"

extern void TileBlit(u32 *attr, const void *src, u8 mode);
extern void Tilemap_SwapPalette(u32 *attr, u16 a, u16 b, u8 c);
extern void DrawTextGlyphs(const u8 *str, int len, int x, int y, int a, int b, int c);
extern void DrawByteDecimal(u8 value, u8 x, u8 y, u16 a, u16 b, u8 c);
extern void DrawNumber(u16 value, u8 x, u8 y, u16 a, u16 b, u8 c, u32 forceZeros);
extern u8 CountHighestBit(u32 bits);

/* Twin of SaveSlot_DrawAllSlots (same body, different call site): renders the four save
 * slots. For each populated slot draws its name, two counters and a completion
 * percentage; for each empty slot blits a placeholder sprite. The slot whose
 * index equals gIwram_3480.cursorIndex is highlighted. An OAM-style attribute word
 * is built on the stack and its address handed to the sprite helpers. */
void FileSelect_DrawSlots(void)
{
    u32 attr;
    u8 slotMask;
    vu16 fill; /* volatile: forces &fill to be re-materialised for the DMA src
                  store instead of being CSE'd with the fill=0 store */
    u32 *attrp;
    u8 i;
    int emptyRow; /* function-scoped so the empty-slot row byte is computed
                     before &attr is pinned (keeps the add r4 after it) */

    attr = (attr & 0xffffff00) | 0x02;
    attr = (attr & 0xffff00ff) | 0x0300;
    attr = (attr & 0x00ffffff) | 0x04000000;
    attr = (attr & 0xff00ffff) | 0x001a0000;

    slotMask = gSaveData.header.slotMask;

    fill = 0;
    REG_DMA3.src = (const void *)&fill;
    REG_DMA3.dst = (void *)0x0600f000;
    REG_DMA3.cnt = 0x81000400;
    (void)REG_DMA3.cnt;

    i = 0;
    attrp = &attr;

    for (; i <= 3; i++) {
        if ((slotMask >> i) & 1) {
            u32 mask = 0xffffff00; /* load the mask constant before attr */
            u32 byte;
            u8 y;

            attr = (attr & mask) | 0x03;
            byte = (u8)(i * 4 + 3) << 8;
            attr = (attr & 0xffff00ff) | byte;
            y = i * 4 + 4; /* shares the i*4 subexpression with the attr byte */
            TileBlit(attrp, (const void *)0x081D8398, 2);

            DrawTextGlyphs(gSaveData.slots[i].name, 3, 3, y, 0x140, 5, 2);
            DrawTextGlyphs((const u8 *)0x081BE800, 3, 12, y, 0x140, 5, 2);
            DrawByteDecimal(gSaveData.slots[i]._field5, 12, y, 0x140, 5, 2);

            if (gSaveData.slots[i]._field6 > 99) {
                DrawNumber(gSaveData.slots[i]._field6, 18, y, 0x140, 5, 2, 0);
            } else if (gSaveData.slots[i]._field6 > 9) {
                DrawNumber(gSaveData.slots[i]._field6, 19, y, 0x140, 5, 2, 0);
            } else {
                DrawNumber(gSaveData.slots[i]._field6, 20, y, 0x140, 5, 2, 0);
            }

            {
                u8 pct;
                /* signed and pinned to r1: the truncated count becomes the
                   multiply's second operand (100 in r0 = accumulator), and the
                   signed type makes the >>4 an arithmetic shift */
                register int count asm("r1");

                count = (u8)CountHighestBit(gSaveData.slots[i]._field0);
                pct = (u8)((count * 100) >> 4);

                if (pct != 100) {
                    DrawByteDecimal(pct, 23, y, 0x140, 5, 2);
                } else {
                    DrawNumber(100, 22, y, 0x140, 5, 2, 0);
                }
            }

            if (gIwram_3480.cursorIndex == i) {
                Tilemap_SwapPalette(attrp, 5, 4, 2);
                Tilemap_SwapPalette(attrp, 7, 6, 2);
            }
        } else {
            const u32 *table = (const u32 *)0x08308ef4;
            u8 *ap = (u8 *)&attr;

            *(u8 *)attrp = 3;
            emptyRow = i * 4 + 4;
            /* keep &attr in its own register (r4) across the call, distinct
               from attrp's spill slot */
            asm("" : "+r"(ap));
            ap[1] = emptyRow;
            /* load the table base before dereferencing gIwram_34B0._data as the
               index */
            asm("" : "+r"(table));
            TileBlit((u32 *)ap, (const void *)table[gIwram_34B0._data], 2);

            if (gIwram_3480.cursorIndex == i) {
                Tilemap_SwapPalette((u32 *)ap, 5, 4, 2);
            }
        }
    }
}
