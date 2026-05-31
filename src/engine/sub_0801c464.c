#include "macros.h"
#include "types.h"

#define BG_SCREENBLOCK_31 ((u32)0x0600f800)

void sub_0801C464(void)
{
    register u32 tileBase1 asm("r8") = (u32)0xb1 << 8;
    register u32 tileBase2 asm("r9") = 0x0000a109;
    register u32 ipBase asm("ip");
    register u32 vramBase asm("r6");
    register u32 row2 asm("r0");
    register u32 row asm("r3");
    u8 col;
    u32 rowOff;
    u32 vramRow;
    u32 tileRow;
    u32 nextRow;

    row = 0;
    ipBase = (u32)0x80 << 3;
    rowOff = ipBase + 2;
    vramBase = BG_SCREENBLOCK_31;
    do {
        register u32 row64 asm("r1");
        register u32 vramRow1 asm("r5");
        register u32 tileRow1 asm("r4");

        col = 0;
        asm("" : "=r"(row64) : "0"((u32)row * 64));
        row2 = (u32)row * 2;
        vramRow1 = row64 + rowOff;
        tileRow1 = tileBase1 + (row2 + (u32)row);
        do {
            *(vu16 *)((u32)col * 2 + vramRow1 + vramBase) = (u16)(tileRow1 + col);
            col++;
        } while (col <= 2);
        {
            register u32 nextRow asm("r0") = row + 1;

            row = (u8)nextRow;
        }
    } while (row <= 2);

    row = 0;
    asm volatile("" : "+r"(ipBase));
    rowOff = ipBase + 0x28;
    vramBase = BG_SCREENBLOCK_31;
    do {
        register u32 row64 asm("r1");

        col = 0;
        asm("" : "=r"(row64) : "0"((u32)row * 64));
        row2 = (u32)row * 2;
        nextRow = row + 1;
        vramRow = row64 + rowOff;
        row = tileBase2 + (row2 + row);
        do {
            *(vu16 *)((u32)col * 2 + vramRow + vramBase) = (u16)(row + col);
            col++;
        } while (col <= 2);
        {
            register u32 nextRowTrunc asm("r0") = nextRow << 24;

            row = nextRowTrunc >> 24;
        }
    } while (row <= 2);
}
