/* Linker script for Frogger's Adventures: Temple of the Frog (USA).
 *
 * Phase 0 (current): one big asm/rom.o(.text) entry that INCBINs the whole
 * baserom. This gives us a matching-build baseline before any disassembly
 * has happened.
 *
 * Phase 1 (next): as functions are peeled off the front of rom.s into
 * asm/disasm_0xADDR.s slices, add their `.o(.text)` entries here in
 * baserom address order. The agent loop (pick_target.py / progress.py)
 * relies on this address-ordered placement to detect layout drift.
 *
 * Phase 2 (later): once C decomp begins, src/...o(.text) entries
 * interleave with the remaining asm slices.
 */

MEMORY {
    ewram : ORIGIN = 0x02000000 LENGTH = 256K
    iwram : ORIGIN = 0x03000000 LENGTH = 32K
    rom   : ORIGIN = 0x08000000 LENGTH = 32M
}

SECTIONS {
    ewram (NOLOAD) : ALIGN(4) {
        /* Add ewram globals here as the disassembly identifies them. */
    } >ewram

    iwram (NOLOAD) : ALIGN(4) {
        /* Add iwram globals here. */
    } >iwram

    .text : ALIGN(4) {
        asm/disasm_0x08000000.o(.text);  /* 0x08000000 - 0x08000004, entry branch */
        asm/header.o(.text);             /* 0x08000004 - 0x080000BF, header */
        asm/text/text_0x080000c0.o(.text);  /* 0x080000c0 - 0x08010000, raw bytes */
        asm/text/text_0x08010000.o(.text);  /* 0x08010000 - 0x08020000, raw bytes */
        asm/text/text_0x08020000.o(.text);  /* 0x08020000 - 0x08030000, raw bytes */
        asm/text/text_0x08030000.o(.text);  /* 0x08030000 - 0x08040000, raw bytes */
        asm/text/text_0x08040000.o(.text);  /* 0x08040000 - 0x08050000, raw bytes */
        asm/text/text_0x08050000.o(.text);  /* 0x08050000 - 0x08060000, raw bytes */
        asm/text/text_0x08060000.o(.text);  /* 0x08060000 - 0x08070000, raw bytes */
        asm/text/text_0x08070000.o(.text);  /* 0x08070000 - 0x08080000, raw bytes */
        asm/text/text_0x08080000.o(.text);  /* 0x08080000 - 0x08090000, raw bytes */
        asm/text/text_0x08090000.o(.text);  /* 0x08090000 - 0x080a0000, raw bytes */
        asm/text/text_0x080a0000.o(.text);  /* 0x080a0000 - 0x080b0000, raw bytes */
        asm/text/text_0x080b0000.o(.text);  /* 0x080b0000 - 0x080c0000, raw bytes */
        asm/text/text_0x080c0000.o(.text);  /* 0x080c0000 - 0x080d0000, raw bytes */
        asm/text/text_0x080d0000.o(.text);  /* 0x080d0000 - 0x080e0000, raw bytes */
        asm/text/text_0x080e0000.o(.text);  /* 0x080e0000 - 0x080f0000, raw bytes */
        asm/text/text_0x080f0000.o(.text);  /* 0x080f0000 - 0x08100000, raw bytes */
        asm/text/text_0x08100000.o(.text);  /* 0x08100000 - 0x08110000, raw bytes */
        asm/text/text_0x08110000.o(.text);  /* 0x08110000 - 0x08120000, raw bytes */
        asm/text/text_0x08120000.o(.text);  /* 0x08120000 - 0x08130000, raw bytes */
        asm/text/text_0x08130000.o(.text);  /* 0x08130000 - 0x08140000, raw bytes */
        asm/text/text_0x08140000.o(.text);  /* 0x08140000 - 0x08150000, raw bytes */
        asm/text/text_0x08150000.o(.text);  /* 0x08150000 - 0x08160000, raw bytes */
        asm/text/text_0x08160000.o(.text);  /* 0x08160000 - 0x08170000, raw bytes */
        asm/text/text_0x08170000.o(.text);  /* 0x08170000 - 0x08180000, raw bytes */
        asm/text/text_0x08180000.o(.text);  /* 0x08180000 - 0x08190000, raw bytes */
        asm/text/text_0x08190000.o(.text);  /* 0x08190000 - 0x081a0000, raw bytes */
        asm/text/text_0x081a0000.o(.text);  /* 0x081a0000 - 0x081b0000, raw bytes */
        asm/text/text_0x081b0000.o(.text);  /* 0x081b0000 - 0x081c0000, raw bytes */
        asm/text/text_0x081c0000.o(.text);  /* 0x081c0000 - 0x081d0000, raw bytes */
        asm/text/text_0x081d0000.o(.text);  /* 0x081d0000 - 0x081e0000, raw bytes */
        asm/text/text_0x081e0000.o(.text);  /* 0x081e0000 - 0x081f0000, raw bytes */
        asm/text/text_0x081f0000.o(.text);  /* 0x081f0000 - 0x08200000, raw bytes */
        asm/text/text_0x08200000.o(.text);  /* 0x08200000 - 0x08210000, raw bytes */
        asm/text/text_0x08210000.o(.text);  /* 0x08210000 - 0x08220000, raw bytes */
        asm/text/text_0x08220000.o(.text);  /* 0x08220000 - 0x08230000, raw bytes */
        asm/text/text_0x08230000.o(.text);  /* 0x08230000 - 0x08240000, raw bytes */
        asm/text/text_0x08240000.o(.text);  /* 0x08240000 - 0x08250000, raw bytes */
        asm/text/text_0x08250000.o(.text);  /* 0x08250000 - 0x08260000, raw bytes */
        asm/text/text_0x08260000.o(.text);  /* 0x08260000 - 0x08270000, raw bytes */
        asm/text/text_0x08270000.o(.text);  /* 0x08270000 - 0x08280000, raw bytes */
        asm/text/text_0x08280000.o(.text);  /* 0x08280000 - 0x08290000, raw bytes */
        asm/text/text_0x08290000.o(.text);  /* 0x08290000 - 0x082a0000, raw bytes */
        asm/text/text_0x082a0000.o(.text);  /* 0x082a0000 - 0x082b0000, raw bytes */
        asm/rom.o(.text);                /* 0x080000C0 onward, still unparsed */
        /* Disassembled function clusters land here, in baserom address
         * order, as they get peeled off rom.s. */
    } >rom

    .rodata : ALIGN(4) {
        /* Read-only data tables — empty until extraction begins. */
    } >rom

    .data : ALIGN(2) {
        /* Initialized RAM data — empty until extraction begins. */
    } >rom

    /* Discard anything the agbcc libs would pull in by default; with no
     * C source yet there are no references, but be explicit so a stray
     * .ARM.attributes section can't sneak into the binary. */
    /DISCARD/ : {
        *(.ARM.attributes)
        *(.comment)
        *(.note*)
    }
}
