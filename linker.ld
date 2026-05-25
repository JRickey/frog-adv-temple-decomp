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
        asm/disasm_0x080000c0.o(.text);  /* 0x080000c0 - 0x080000fc, _start */
        asm/disasm_0x080000fc.o(.text);  /* 0x080000fc - 0x08000114, IntrEnable */
        asm/disasm_0x08000114.o(.text);  /* 0x08000114 - 0x0800012c, IntrDisable */
        asm/disasm_0x0800012c.o(.text);  /* 0x0800012c - 0x08000240, IntrMain */
        asm/disasm_0x08000240.o(.text);  /* 0x08000240 - 0x080002a4, sub_08000240 */
        asm/disasm_0x080002a4.o(.text);  /* 0x080002a4 - 0x08000430, AgbMain */
        asm/disasm_0x08000430.o(.text);  /* 0x08000430 - 0x080004c4, sub_08000430 */
        asm/text/text_0x080004c4.o(.text);  /* 0x080004c4 - 0x0800072c, raw bytes */
        asm/disasm_0x0800072c.o(.text);  /* 0x0800072c - 0x08000820, sub_0800072C (auto-peeled) */
        asm/disasm_0x08000820.o(.text);  /* 0x08000820 - 0x0800088c, sub_08000820 (auto-peeled) */
        asm/text/text_0x0800088c.o(.text);  /* 0x0800088c - 0x08001478, raw bytes */
        src/game/set_game_mode_03.o(.text);  /* 0x08001478 - 0x08001484, SetGameMode_03 */
        asm/text/text_0x08001484.o(.text);  /* 0x08001484 - 0x08002444, raw bytes */
        src/game/game_mode.o(.text);     /* 0x08002444 - 0x08002450, SetGameMode_06 */
        asm/text/text_0x08002450.o(.text);  /* 0x08002450 - 0x08002760, raw bytes */
        src/game/set_game_mode_07.o(.text);  /* 0x08002760 - 0x0800276c, SetGameMode_07 */
        asm/text/text_0x0800276c.o(.text);  /* 0x0800276c - 0x08002a5c, raw bytes */
        src/game/set_game_mode_08.o(.text);  /* 0x08002a5c - 0x08002a68, SetGameMode_08 */
        asm/text/text_0x08002a68.o(.text);  /* 0x08002a68 - 0x08002e04, raw bytes */
        src/game/set_game_mode_09.o(.text);  /* 0x08002e04 - 0x08002e10, SetGameMode_09 */
        asm/text/text_0x08002e10.o(.text);  /* 0x08002e10 - 0x08004074, raw bytes */
        src/game/set_game_mode_12.o(.text);  /* 0x08004074 - 0x08004080, SetGameMode_12 */
        asm/text/text_0x08004080.o(.text);  /* 0x08004080 - 0x080052c0, raw bytes */
        src/game/set_game_mode_15.o(.text);  /* 0x080052c0 - 0x080052cc, SetGameMode_15 */
        asm/text/text_0x080052cc.o(.text);  /* 0x080052cc - 0x08010000, raw bytes */
        asm/text/text_0x08010000.o(.text);  /* 0x08010000 - 0x08017364, raw bytes */
        asm/disasm_0x08017364.o(.text);  /* 0x08017364 - 0x080177a0, sub_08017364 (auto-peeled) */
        asm/text/text_0x080177a0.o(.text);  /* 0x080177a0 - 0x08020000, raw bytes */
        asm/text/text_0x08020000.o(.text);  /* 0x08020000 - 0x08020b30, raw bytes */
        asm/disasm_0x08020b30.o(.text);  /* 0x08020b30 - 0x08020b50, sub_08020B30 (auto-peeled) */
        asm/text/text_0x08020b50.o(.text);  /* 0x08020b50 - 0x08030000, raw bytes */
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
        asm/text/text_0x082b0000.o(.text);  /* 0x082b0000 - 0x082c0000, raw bytes */
        asm/text/text_0x082c0000.o(.text);  /* 0x082c0000 - 0x082d0000, raw bytes */
        asm/text/text_0x082d0000.o(.text);  /* 0x082d0000 - 0x082e0000, raw bytes */
        asm/text/text_0x082e0000.o(.text);  /* 0x082e0000 - 0x082f0000, raw bytes */
        asm/text/text_0x082f0000.o(.text);  /* 0x082f0000 - 0x08300000, raw bytes */
        asm/text/text_0x08300000.o(.text);  /* 0x08300000 - 0x08310000, raw bytes */
        asm/text/text_0x08310000.o(.text);  /* 0x08310000 - 0x08320000, raw bytes */
        asm/text/text_0x08320000.o(.text);  /* 0x08320000 - 0x08330000, raw bytes */
        asm/text/text_0x08330000.o(.text);  /* 0x08330000 - 0x08340000, raw bytes */
        asm/text/text_0x08340000.o(.text);  /* 0x08340000 - 0x08350000, raw bytes */
        asm/text/text_0x08350000.o(.text);  /* 0x08350000 - 0x08360000, raw bytes */
        asm/text/text_0x08360000.o(.text);  /* 0x08360000 - 0x08370000, raw bytes */
        asm/text/text_0x08370000.o(.text);  /* 0x08370000 - 0x08380000, raw bytes */
        asm/text/text_0x08380000.o(.text);  /* 0x08380000 - 0x08390000, raw bytes */
        asm/text/text_0x08390000.o(.text);  /* 0x08390000 - 0x083a0000, raw bytes */
        asm/text/text_0x083a0000.o(.text);  /* 0x083a0000 - 0x083b0000, raw bytes */
        asm/text/text_0x083b0000.o(.text);  /* 0x083b0000 - 0x083c0000, raw bytes */
        asm/text/text_0x083c0000.o(.text);  /* 0x083c0000 - 0x083d0000, raw bytes */
        asm/text/text_0x083d0000.o(.text);  /* 0x083d0000 - 0x083e0000, raw bytes */
        asm/text/text_0x083e0000.o(.text);  /* 0x083e0000 - 0x083f0000, raw bytes */
        asm/text/text_0x083f0000.o(.text);  /* 0x083f0000 - 0x08400000, raw bytes */
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
