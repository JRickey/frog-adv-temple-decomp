#include "macros.h"
#include "types.h"

#define BG_SCREENBLOCK_31              ((volatile struct BgScreenblock *)0x0600f800)
#define BG_SCREENBLOCK_ROW_OFFSET(row) OFFSET_OF(struct BgScreenblock, entry[row][0])
#define BG_SCREENBLOCK_COL_OFFSET(col) OFFSET_OF(struct BgScreenblock, entry[0][col])

struct BgScreenblock {
    vu16 entry[32][32];
};

void sub_0801C464(void)
{
    u32 tileBase1 = (u32)0xb1 << 8;
    u32 tileBase2 = 0x0000a109;
    register u32 ipBase asm("ip");
    register volatile struct BgScreenblock *screenblock asm("r6");
    register u32 row2 asm("r0");
    u32 row;
    u8 col;
    u32 rowOff;
    u32 vramRow;
    u32 nextRow;

    row = 0;
    ipBase = BG_SCREENBLOCK_ROW_OFFSET(16);
    rowOff = ipBase + BG_SCREENBLOCK_COL_OFFSET(1);
    screenblock = BG_SCREENBLOCK_31;
    do {
        u32 row64;
        u32 vramRow1;
        u32 tileRow1;

        col = 0;
        row64 = (u32)row * 64;
        row2 = (u32)row * 2;
        vramRow1 = row64 + rowOff;
        tileRow1 = tileBase1 + (row2 + (u32)row);
        do {
            *(vu16 *)((u32)col * 2 + vramRow1 + (u32)screenblock) = (u16)(tileRow1 + col);
            col++;
        } while (col <= 2);
        row = (u8)(row + 1);
    } while (row <= 2);

    row = 0;
    asm volatile("" : "+r"(ipBase));
    rowOff = ipBase + BG_SCREENBLOCK_COL_OFFSET(20);
    screenblock = BG_SCREENBLOCK_31;
    do {
        u32 row64;

        col = 0;
        row64 = (u32)row * 64;
        row2 = (u32)row * 2;
        nextRow = row + 1;
        vramRow = row64 + rowOff;
        row = tileBase2 + (row2 + row);
        do {
            *(vu16 *)((u32)col * 2 + vramRow + (u32)screenblock) = (u16)(row + col);
            col++;
        } while (col <= 2);
        row = (u8)nextRow;
    } while (row <= 2);
}
