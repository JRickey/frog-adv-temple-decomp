#include "macros.h"
#include "types.h"
#include "iwram.h"

/* Four-cell panel redraw. selector6Flags tracks which of the four corner
   cells are currently drawn; each frame the cells whose selector5Flags bit
   differs are re-blitted from the parallel ROM tables at 0x08307E18 (cell
   geometry) and 0x08307E28 (per-cell source tile tables). */
struct PanelCellGeom {
    u16 dstX;
    u16 dstY;
    u16 width;
    u16 rows;
    u8 flags;
    u8 _pad[15];
};

struct PanelCellSrc {
    const u16 **srcTable;
    u8 _pad[20];
};

extern void sub_08012BC4(u32 flags, u32 dstX, u32 dstY, u32 width, u32 rows, const u16 **srcTable, u32 cellBit);
extern void sub_08020C78(u32 sound);
extern void sub_080152B0(void);
extern void sub_0801549C(void);

void sub_0801585C(void)
{
    u8 i;

    if ((gIwram_6110.selector5Flags & 0xF) != (gIwram_6110.selector6Flags & 0xF)) {
        const struct PanelCellGeom *geom = (const struct PanelCellGeom *)0x08307E18;
        const struct PanelCellSrc *src = (const struct PanelCellSrc *)0x08307E28;

        for (i = 0; i <= 3; i++) {
            u32 wantBit = (gIwram_6110.selector5Flags >> i) & 1;
            u32 haveBit = (gIwram_6110.selector6Flags >> i) & 1;

            if (wantBit == haveBit) {
                continue;
            }

            sub_08012BC4(geom[i].flags, geom[i].dstX, geom[i].dstY, geom[i].width, geom[i].rows, src[i].srcTable,
                         (gIwram_6110.selector5Flags >> i) & 1);

            if ((gIwram_6110.selector5Flags >> i) & 1) {
                gIwram_6110.selector6Flags |= 1 << i;
                sub_08020C78(0x19);
                *(u8 *)0x03003610 = i + 1;
            } else {
                *(u8 *)0x03003610 = 0;
                gIwram_6110.selector6Flags &= ~(1 << i);
            }
            sub_080152B0();
        }
    }

    sub_0801549C();
}
