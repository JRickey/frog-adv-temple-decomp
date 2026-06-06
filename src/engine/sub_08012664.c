#include "iwram.h"
#include "types.h"

extern int sub_0801185C(u8 range);

/* Spawn-tile picker for entity slot 30. Reads the cached player tile coords
 * (gIwram_35E0._field_8 / _field_A, low byte only), builds two exclusion bands
 * [coord-3 .. coord+1] (columns) and [coord-3 .. coord-1] (rows), collects the
 * tiles in 0..7 / 0..4 that fall outside each band, then random-picks one of
 * each via sub_0801185C (a VCOUNT LCG returning [0,count)) and writes the
 * chosen spawn X/Y into gEntities[30], clamped to [1,8] / [2,6]. */
void sub_08012664(void)
{
    u8 *coords;
    u8 colExcl[5];
    u8 rowExcl[3];
    u8 colCand[8];
    u8 rowCand[4];
    u32 t8;
    u32 t10;
    u32 k;
    u32 colBase;
    u32 rowBase;
    u8 i;
    u8 j;
    u8 colCount;
    u8 rowCount;
    u8 hit;
    u8 *base;
    u32 offsetCol;
    u32 offsetRow;
    s16 *colDst;
    s16 *rowDst;
    s16 value;
    int picked;
    int r;

    coords = (u8 *)&gIwram_35E0;
    t8 = coords[8] << 24;
    t10 = coords[10] << 24;
    /* colBase/rowBase = (u8)(coord - 3) via the <<24 / +(-3<<24) / >>24 idiom.
     * The in-expression `k = t8 + k` (rather than two reads of a plain `k`)
     * keeps the 0xFD000000 constant pinned in a callee-saved register, which
     * agbcc then reuses for the colExcl base pointer in the fill/collect loops
     * below; the plain form drifts the register coloring. */
    k = 0xFD000000;
    colBase = (k = t8 + k) >> 24;
    rowBase = (t10 + 0xFD000000) >> 24;

    for (i = 0; i <= 4; i++)
        colExcl[i] = i + colBase;
    for (i = 0; i <= 2; i++)
        rowExcl[i] = i + rowBase;

    hit = 0;
    colCount = 0;
    for (i = 0; i <= 7; i++) {
        for (j = 0; j <= 4; j++) {
            if (i == colExcl[j])
                hit = 1;
        }
        if (hit == 0)
            colCand[colCount++] = i;
        hit = 0;
    }

    rowCount = 0;
    for (i = 0; i <= 4; i++) {
        for (j = 0; j <= 2; j++) {
            if (i == rowExcl[j])
                hit = 1;
        }
        if (hit == 0)
            rowCand[rowCount++] = i;
        hit = 0;
    }

    /* The entity base is the raw integer address, not the gEntities symbol:
     * using the symbol lets agbcc hoist the base load into a callee-saved reg
     * (widening the prologue) and breaks the match. */
    r = sub_0801185C(colCount);
    base = (u8 *)0x03003720;
    picked = colCand[r] + 1;
    offsetCol = 0x692; /* gEntities[30].x */
    colDst = (s16 *)(base + offsetCol);
    *colDst = picked;

    /* The Y pick indexes colCand (not rowCand) with a draw from the row count:
     * a genuine baserom quirk (the `add r0, r8` reuses the colCand base). */
    picked = colCand[sub_0801185C(rowCount)] + 2;
    offsetRow = 0x694; /* gEntities[30].y */
    rowDst = (s16 *)(base + offsetRow);
    *rowDst = picked;

    value = *colDst;
    if (value <= 0)
        *colDst = 1;
    value = *colDst;
    if (value > 8)
        *colDst = 8;

    value = *rowDst;
    if (value <= 1)
        *rowDst = 2;
    value = *rowDst;
    if (value > 6)
        *rowDst = 6;
}

extern void sub_080100E4(u32, void *, void *);

/* Tilemap descriptor at ROM 0x08306e64. Same block sub_0801288C blits, viewed
 * at the low offsets this routine uses (its srcIndex is fixed at 0). */
struct TileBlit_12798 {
    u8 _pad00[4];
    u8 width; /* +0x04 */
    u8 _pad05;
    u8 rows; /* +0x06 */
    u8 _pad07;
    u8 flags; /* +0x08 */
    u8 _pad09[7];
    const u16 *const *src; /* +0x10 */
};

#define sTileBlit_12798 (*(const struct TileBlit_12798 *)0x08306e64)

struct BlitState_12798 {
    u8 _pad00[26];
    u16 stride; /* +0x1A */
};

/* Specialized blit of descriptor row 0 to the EWRAM mirror selected by the
 * descriptor flags, then DMA-flushed to VRAM via sub_080100E4. Destination tile
 * is gEntities[30].(x,y)*3; the entity-slot reads are signed halfwords. */
void sub_08012798(void)
{
    const struct TileBlit_12798 *desc;
    u32 entityBase;
    register u32 r2Work asm("r2");
    s32 xCoord;
    s32 yCoord;
    u32 yWork;
    register u32 x asm("r8");
    register u32 ipWork asm("ip");
    register u32 flags asm("r3");
    register u32 width asm("r4");
    register u32 rows asm("r9");
    register const u16 *const *srcBase asm("r6");
    register const u16 *r1Work asm("r1");
    u32 bank;
    void *flushSrc;
    void *flushDst;
    u32 row;
    u32 nextRow;
    u8 col;
    register u32 r0Work asm("r0");
    register u16 *state asm("r5");
    register u16 stride asm("r1");
    register u32 hold4 asm("r4");
    register u32 hold5 asm("r5");
    register u32 hold6 asm("r6");

    desc = &sTileBlit_12798;
    entityBase = 0x03003720;
    xCoord = *(s16 *)(entityBase + 0x692);
    /* Register-coloring scaffold (this function only matches with it): the
     * hold4/hold5/hold6/r0Work dead reads keep r4/r5/r6/r0 occupied across both
     * signed-halfword loads so the ldrsh zero index is forced into the
     * callee-saved r7, widening the prologue to {r4-r7,lr} as the baserom does.
     * The redundant `if (r0Work)` around the second load anchors r0 there too. */
    r2Work = xCoord * 3 + hold4 - hold4 + hold5 - hold5 + hold6 - hold6;
    r2Work <<= 16;
    r0Work = 0x694;
    entityBase -= -r0Work;
    if (r0Work)
        yCoord = *(s16 *)entityBase;
    else
        yCoord = *(s16 *)entityBase;
    yWork = (u16)(yCoord * 3 + r0Work - r0Work + hold4 - hold4 + hold5 - hold5 + hold6 - hold6);
    ipWork = yWork;
    x = r2Work >> 16;
    width = desc->width;
    yWork = desc->rows;
    rows = yWork;
    srcBase = desc->src;
    flags = desc->flags;
    flags >>= 4;

    {
        u32 flagBit;

        r1Work = (const u16 *)1;
        flagBit = flags;
        flagBit &= (u32)r1Work;
        r2Work = 0x80 << 18;
        if (flagBit)
            r2Work = 0x02010000;
    }

    state = (u16 *)0x030060A0;
    stride = state[13];
    r2Work += (stride * ipWork + x) << 1;
    r1Work = srcBase[0];
    row = 0;
    bank = flags;
    if (row < rows) {
        ipWork = (u32)state;

        do {
            col = 0;
            nextRow = row + 1;
            if (col < width) {
                do {
                    *(u16 *)r2Work = *r1Work++;
                    r2Work += 2;
                    col++;
                } while (col < width);
            }
            {
                register u32 stride2 asm("r3");
                u32 strideAdvance;

                stride2 = ipWork;
                stride2 = ((struct BlitState_12798 *)stride2)->stride;
                strideAdvance = stride2 - width;
                strideAdvance <<= 1;
                r2Work += strideAdvance;
            }
            row = (u8)nextRow;
        } while (row < rows);
    }

    {
        r1Work = (const u16 *)1;
        if (bank & (u32)r1Work) {
            flushSrc = (void *)0x02010000;
            flushDst = (void *)0x0600E800;
        } else {
            flushSrc = (void *)(0x80 << 18);
            flushDst = (void *)0x0600E000;
        }
    }
    {
        register u32 one asm("r0");

        one = 1;
        bank &= one;
    }
    sub_080100E4(bank, flushSrc, flushDst);
    {
        u8 *sentinel = (u8 *)0x030064C0;

        sentinel[10] = 0;
    }
    *(u8 *)0x03003610 = 1;
}
