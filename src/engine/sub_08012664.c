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
