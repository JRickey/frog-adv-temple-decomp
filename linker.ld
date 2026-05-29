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
        /* Dot-pinned IWRAM symbols. Each `. = OFFSET; gIwram_XXXX = .;`
         * declares a real C global whose address is fixed at link time.
         * This pattern (mirrored from testyourmine/cvaos's gUnk_03002CB0
         * setup) defeats agbcc 2.x's CSE-fold of adjacent compile-time
         * constant addresses — the compiler sees opaque undefined symbols
         * and emits one `ldr =gIwram_XXXX` per unique base. See
         * docs/codegen-notes.md "Adjacent IWRAM bases".
         *
         * Offsets MUST stay in ascending order (ld extends `.` forward,
         * never backward). The (NOLOAD) attribute keeps these byte-neutral
         * — no storage is committed; the symbols only carry addresses. */
        . = 0x00003480; gIwram_3480 = .;
        . = 0x000034A0; gIwram_34A0 = .;
        . = 0x000034B0; gIwram_34B0 = .;
        . = 0x000034B4; gIwram_34B4 = .;
        . = 0x000034C0; gIwram_34C0 = .;
        . = 0x00003550; gIwram_3550 = .;
        . = 0x000035E0; gIwram_35E0 = .;
        . = 0x00003710; gIwram_3710 = .;
        . = 0x00003720; gIwram_3720 = .;
        . = 0x00005328; gIwram_5328 = .;
        . = 0x00005330; gIwram_5330 = .;
        . = 0x00005358; gIwram_5358 = .;
        . = 0x00005398; gIwram_5398 = .;
        . = 0x00006110; gIwram_6110 = .;
    } >iwram

    .text : ALIGN(4) {
        asm/disasm_0x08000000.o(.text);  /* 0x08000000 - 0x08000004, entry branch */
        asm/header.o(.text);             /* 0x08000004 - 0x080000BF, header */
        asm/disasm_0x080000c0.o(.text);  /* 0x080000c0 - 0x080000fc, _start */
        asm/disasm_0x080000fc.o(.text);  /* 0x080000fc - 0x08000114, IntrEnable */
        asm/disasm_0x08000114.o(.text);  /* 0x08000114 - 0x0800012c, IntrDisable */
        asm/disasm_0x0800012c.o(.text);  /* 0x0800012c - 0x08000240, IntrMain */
        asm/disasm_0x08000240.o(.text);  /* 0x08000240 - 0x080002a4, sub_08000240 */
        src/system/agb_main.o(.text);    /* 0x080002a4 - 0x08000430, AgbMain (NAKED) */
        src/system/init1.o(.text);       /* 0x08000430 - 0x080005d8, sub_08000430 (Init1) + sub_080004C4 */
        asm/text/text_0x080005d8.o(.text);  /* 0x080005d8 - 0x08000678, raw bytes */
        asm/disasm_0x08000678.o(.text);  /* 0x08000678 - 0x0800072c, sub_08000678 (auto-peeled) */
        src/system/init.o(.text);        /* 0x0800072c - 0x08000820, sub_0800072C + sub_08000764 + sub_08000790 */
        src/game/sub_08000820.o(.text);  /* 0x08000820 - 0x0800088c, sub_08000820 + sub_08000884/sub_08000888 stubs */
        asm/text/text_0x0800088c.o(.text);  /* 0x0800088c - 0x080008dc, raw bytes */
        src/system/vblank.o(.text);      /* 0x080008dc - 0x0800090c, sub_080008DC + sub_08000900 */
        asm/text/text_0x0800090c.o(.text);  /* 0x0800090c - 0x08000918, raw bytes */
        src/system/sub_08000918.o(.text);  /* 0x08000918 - 0x08000b6c, sub_08000918 (NAKED + NON_MATCHING; mode-X cluster mov-pc-rN dispatcher) */
        src/system/sub_08000b6c.o(.text);  /* 0x08000b6c - 0x08000c98, sub_08000B6C (NAKED + NON_MATCHING; high-register pins on sl/r8/r9) */
        src/system/sub_08000c98.o(.text);  /* 0x08000c98 - 0x08000cb0, sub_08000C98 */
        asm/text/text_0x08000cb0.o(.text);  /* 0x08000cb0 - 0x08000cec, raw bytes */
        src/system/sub_08000cec.o(.text);  /* 0x08000cec - 0x08000d2c, sub_08000CEC */
        src/system/sub_08000d2c.o(.text);  /* 0x08000d2c - 0x08000d50, sub_08000D2C */
        src/system/sub_08000d50.o(.text);  /* 0x08000d50 - 0x08000d5c, sub_08000D50 */
        asm/text/text_0x08000d5c.o(.text);  /* 0x08000d5c - 0x08000e0c, raw bytes */
        src/system/sub_08000e0c.o(.text);  /* 0x08000e0c - 0x08000eb8, sub_08000E0C */
        src/system/sub_08000eb8.o(.text);  /* 0x08000eb8 - 0x08001128, sub_08000EB8 (NAKED + NON_MATCHING; mode-9 dispatch — `mov pc, rN` jump table, sibling of sub_08002844) */
        src/system/sub_08001128.o(.text);  /* 0x08001128 - 0x080011a4, sub_08001128 / sub_08001140 / sub_08001174 / sub_08001198 cluster */
        src/game/sub_080011a4.o(.text);    /* 0x080011a4 - 0x08001214, sub_080011A4 */
        src/game/sub_08001214.o(.text);  /* 0x08001214 - 0x08001478, sub_08001214 (NAKED + NON_MATCHING; mode-10 dispatch — `mov pc, rN` jump table, sibling of sub_08001508) */
        src/game/set_game_mode_03.o(.text);  /* 0x08001478 - 0x08001484, SetGameMode_03 */
        asm/text/text_0x08001484.o(.text);  /* 0x08001484 - 0x08001508, raw bytes */
        src/system/sub_08001508.o(.text);  /* 0x08001508 - 0x08001794, sub_08001508 (NAKED + NON_MATCHING; mode-11 dispatch — `mov pc, rN` jump table, sibling of sub_08000EB8) */
        asm/text/text_0x08001794.o(.text);  /* 0x08001794 - 0x080018f8, raw bytes */
        src/game/sub_080018f8.o(.text);  /* 0x080018f8 - 0x080019b4, sub_080018F8 */
        src/game/sub_080019b4.o(.text);  /* 0x080019b4 - 0x08001d18, sub_080019B4 + sub_08001CEC (NAKED + NON_MATCHING; mode-12 dispatch — `mov pc, rN` jump table, sibling of sub_08001508) */
        src/game/sub_08001d18.o(.text);  /* 0x08001d18 - 0x08001d54, sub_08001D18 */
        src/game/sub_08001d54.o(.text);  /* 0x08001d54 - 0x08001d94, sub_08001D54 */
        src/game/sub_08001d94.o(.text);  /* 0x08001d94 - 0x08001e18, sub_08001D94 */
        src/game/sub_08001e18.o(.text);  /* 0x08001e18 - 0x08001e24, sub_08001E18 */
        src/game/sub_08001e24.o(.text);
        asm/disasm_0x08001e24.o(.text);  /* 0x08001e24 - 0x08002184, sub_08001E24 (auto-peeled) */
        src/game/sub_08002184.o(.text);
        src/game/game_mode.o(.text);     /* 0x08002444 - 0x08002450, SetGameMode_06 */
        asm/text/text_0x08002450.o(.text);  /* 0x08002450 - 0x08002524, raw bytes */
        src/game/sub_08002524.o(.text);  /* 0x08002524 - 0x08002760, sub_08002524 (mode-14 handler) */
        src/game/set_game_mode_07.o(.text);  /* 0x08002760 - 0x0800276c, SetGameMode_07 */
        asm/text/text_0x0800276c.o(.text);  /* 0x0800276c - 0x08002844, raw bytes */
        src/game/mode_15.o(.text);       /* 0x08002844 - 0x08002a5c, sub_08002844 (mode-15 handler) */
        src/game/set_game_mode_08.o(.text);  /* 0x08002a5c - 0x08002a68, SetGameMode_08 */
        asm/text/text_0x08002a68.o(.text);  /* 0x08002a68 - 0x08002ae8, raw bytes */
        src/game/sub_08002ae8.o(.text);  /* 0x08002ae8 - 0x08002b58, sub_08002AE8 */
        src/game/sub_08002b58.o(.text);  /* 0x08002b58 - 0x08002e04, sub_08002B58 */
        src/game/set_game_mode_09.o(.text);  /* 0x08002e04 - 0x08002e10, SetGameMode_09 */
        asm/text/text_0x08002e10.o(.text);  /* 0x08002e10 - 0x08002ee8, raw bytes */
        src/game/sub_08002ee8.o(.text);
        asm/disasm_0x08002ee8.o(.text);  /* 0x08002ee8 - 0x080031d4, sub_08002EE8 (auto-peeled) */
        src/game/sub_080031d4.o(.text);
        asm/disasm_0x080031d4.o(.text);  /* 0x080031d4 - 0x08003254, sub_080031D4 (auto-peeled) */
        src/game/sub_08003254.o(.text);
        src/game/sub_0800336c.o(.text);
        asm/disasm_0x0800336c.o(.text);  /* 0x0800336c - 0x08003584, sub_0800336C (auto-peeled) */
        asm/text/text_0x08003584.o(.text);  /* 0x08003584 - 0x08003668, raw bytes */
        src/game/sub_08003668.o(.text);
        asm/disasm_0x08003668.o(.text);  /* 0x08003668 - 0x08003864, sub_08003668 (auto-peeled) */
        src/game/sub_08003864.o(.text);
        asm/disasm_0x08003864.o(.text);  /* 0x08003864 - 0x08003b40, sub_08003864 (auto-peeled) */
        asm/text/text_0x08003b40.o(.text);  /* 0x08003b40 - 0x08003ca8, raw bytes */
        src/game/sub_08003ca8.o(.text);
        asm/disasm_0x08003ca8.o(.text);  /* 0x08003ca8 - 0x08004074, sub_08003CA8 (auto-peeled) */
        src/game/set_game_mode_12.o(.text);  /* 0x08004074 - 0x08004080, SetGameMode_12 */
        asm/text/text_0x08004080.o(.text);  /* 0x08004080 - 0x0800411c, raw bytes */
        src/game/sub_0800411c.o(.text);
        asm/disasm_0x0800411c.o(.text);  /* 0x0800411c - 0x0800441c, sub_0800411C (auto-peeled) */
        asm/text/text_0x0800441c.o(.text);  /* 0x0800441c - 0x08004508, raw bytes */
        src/game/sub_08004508.o(.text);  /* 0x08004508 - 0x08004588, sub_08004508 */
        asm/text/text_0x08004588.o(.text);  /* 0x08004588 - 0x080045ec, raw bytes */
        src/game/sub_080045ec.o(.text);
        asm/disasm_0x080045ec.o(.text);  /* 0x080045ec - 0x08004938, sub_080045EC (auto-peeled) */
        src/game/sub_08004938.o(.text);
        asm/disasm_0x08004938.o(.text);  /* 0x08004938 - 0x08004c04, sub_08004938 (auto-peeled) */
        asm/text/text_0x08004c04.o(.text);  /* 0x08004c04 - 0x08004fac, raw bytes */
        src/game/sub_08004fac.o(.text);
        asm/disasm_0x08004fac.o(.text);  /* 0x08004fac - 0x080052c0, sub_08004FAC (auto-peeled) */
        src/game/set_game_mode_15.o(.text);  /* 0x080052c0 - 0x080052cc, SetGameMode_15 */
        asm/text/text_0x080052cc.o(.text);  /* 0x080052cc - 0x080054a8, raw bytes */
        src/game/sub_080054a8.o(.text);
        asm/disasm_0x080054a8.o(.text);  /* 0x080054a8 - 0x0800586c, sub_080054A8 (auto-peeled) */
        asm/text/text_0x0800586c.o(.text);  /* 0x0800586c - 0x080059c4, raw bytes */
        src/game/sub_080059c4.o(.text);
        asm/disasm_0x080059c4.o(.text);  /* 0x080059c4 - 0x08005d10, sub_080059C4 (auto-peeled) */
        asm/text/text_0x08005d10.o(.text);  /* 0x08005d10 - 0x08005ed8, raw bytes */
        src/game/sub_08005ed8.o(.text);
        asm/disasm_0x08005f50.o(.text);  /* 0x08005f50 - 0x08005fc8, sub_08005F50 (peeled) */
        src/game/sub_08005fc8.o(.text);
        asm/disasm_0x08005fc8.o(.text);  /* 0x08005fc8 - 0x0800658c, sub_08005FC8 (auto-peeled) */
        src/game/sub_0800658c.o(.text);
        asm/disasm_0x0800658c.o(.text);  /* 0x0800658c - 0x08006600, sub_0800658C (manual split) */
        src/game/sub_08006600.o(.text);  /* 0x08006600 - 0x080066c4, sub_08006600 */
        src/game/sub_080066c4.o(.text);  /* 0x080066c4 - 0x0800679c, sub_080066C4 */
        src/game/sub_0800679c.o(.text);  /* 0x0800679c - 0x08006830, sub_0800679C */
        asm/text/text_0x08006830.o(.text);  /* 0x08006830 - 0x08006948, raw bytes */
        src/game/sub_08006948.o(.text);  /* 0x08006948 - 0x080069bc, sub_08006948 + sub_08006958 + sub_0800696C */
        asm/text/text_0x080069bc.o(.text);  /* 0x080069bc - 0x08006a74, raw bytes */
        src/game/sub_08006a74.o(.text);  /* 0x08006a74 - 0x08006aac, sub_08006A74 */
        asm/text/text_0x08006aac.o(.text);  /* 0x08006aac - 0x08006adc, raw bytes */
        src/game/sub_08006adc.o(.text);  /* 0x08006adc - 0x08006afc, sub_08006ADC */
        asm/text/text_0x08006afc.o(.text);  /* 0x08006afc - 0x08006b88, raw bytes */
        src/game/sub_08006b88.o(.text);  /* 0x08006b88 - 0x08006fec, sub_08006B88 + sub_08006B94 + sub_08006BA4 + sub_08006BB4 + sub_08006D24 + sub_08006E8C */
        asm/text/text_0x080070a0.o(.text);  /* 0x080070a0 - 0x08007138, raw bytes */
        src/game/sub_08007138.o(.text);
        asm/disasm_0x08007138.o(.text);  /* 0x08007138 - 0x08007228, sub_08007138 (auto-peeled) */
        src/game/sub_08007228.o(.text);  /* 0x08007228 - 0x0800736c, sub_08007228 + sub_080072E0 */
        asm/disasm_0x0800736c.o(.text);  /* 0x0800736c - 0x08007660, sub_0800736C (auto-peeled) */
        src/game/sub_08007660.o(.text);
        asm/disasm_0x08007660.o(.text);  /* 0x08007660 - 0x080076a4, sub_08007660 (auto-peeled) */
        src/game/sub_080076a4.o(.text);
        asm/disasm_0x080076a4.o(.text);  /* 0x080076a4 - 0x080077ac, sub_080076A4 (auto-peeled) */
        src/game/sub_080077ac.o(.text);
        asm/disasm_0x080077ac.o(.text);  /* 0x080077ac - 0x08007874, sub_080077AC (auto-peeled) */
        src/game/sub_08007874.o(.text);
        src/game/sub_0800793c.o(.text);
        asm/disasm_0x0800793c.o(.text);  /* 0x0800793c - 0x08007dd0, sub_0800793C (auto-peeled) */
        src/game/sub_08007dd0.o(.text);
        asm/text/text_0x08007f88.o(.text);  /* 0x08007f88 - 0x08008174, raw bytes */
        src/game/sub_08008174.o(.text);
        asm/disasm_0x08008174.o(.text);  /* 0x08008174 - 0x08008570, sub_08008174 (auto-peeled) */
        src/game/sub_08008570.o(.text);
        asm/disasm_0x08008570.o(.text);  /* 0x08008570 - 0x080087b4, sub_08008570 (auto-peeled) */
        src/game/sub_080087b4.o(.text);
        asm/text/text_0x0800885c.o(.text);  /* 0x0800885c - 0x08008a5c, raw bytes */
        src/game/sub_08008a5c.o(.text);
        asm/disasm_0x08008a5c.o(.text);  /* 0x08008a5c - 0x08008e84, sub_08008A5C (auto-peeled) */
        src/game/sub_08008e84.o(.text);
        asm/disasm_0x08008e84.o(.text);  /* 0x08008e84 - 0x08008f98, sub_08008E84 (auto-peeled) */
        src/game/sub_08008f98.o(.text);
        asm/text/text_0x0800908c.o(.text);  /* 0x0800908c - 0x080090b0, raw bytes */
        src/game/sub_080090b0.o(.text);  /* 0x080090b0 - 0x080090fc, sub_080090B0 */
        asm/text/text_0x080090fc.o(.text);  /* 0x080090fc - 0x08009188, raw bytes */
        src/engine/sub_08009188.o(.text);
        asm/disasm_0x08009188.o(.text);  /* 0x08009188 - 0x080094f8, sub_08009188 (auto-peeled) */
        src/engine/sub_080094f8.o(.text);
        asm/disasm_0x080094f8.o(.text);  /* 0x080094f8 - 0x080097fc, sub_080094F8 (auto-peeled) */
        asm/text/text_0x080097fc.o(.text);  /* 0x080097fc - 0x08009884, raw bytes */
        src/engine/sub_08009884.o(.text);  /* 0x08009884 - 0x08009984, sub_08009884 */
        src/game/sub_08009984.o(.text);  /* 0x08009984 - 0x08009ba0, sub_08009984 + sub_08009A58 */
        src/game/sub_08009ba0.o(.text);  /* 0x08009ba0 - 0x08009cbc, sub_08009BA0 + sub_08009C14 */
        asm/disasm_0x08009cbc.o(.text);  /* 0x08009cbc - 0x08009d9c, sub_08009CBC (auto-peeled) */
        src/game/sub_08009d9c.o(.text);  /* 0x08009d9c - 0x08009eec, sub_08009D9C (NAKED+NON_MATCHING) */
        asm/disasm_0x08009eec.o(.text);  /* 0x08009eec - 0x0800a05c, sub_08009EEC (auto-peeled) */
        src/engine/sub_0800a05c.o(.text);  /* 0x0800a05c - 0x0800a104, sub_0800A05C (NAKED+NON_MATCHING) */
        src/engine/sub_0800a104.o(.text);  /* 0x0800a104 - 0x0800a158, sub_0800A104 */
        asm/text/text_0x0800a158.o(.text);  /* 0x0800a158 - 0x0800a1c8, raw bytes */
        src/engine/sub_0800a1c8.o(.text);
        src/engine/sub_0800a1c8.o(.text);  /* 0x0800a1c8 - 0x0800a26c, sub_0800A1C8, sub_0800A214, sub_0800A258 */
        asm/text/text_0x0800a26c.o(.text);  /* 0x0800a26c - 0x0800a2d8, raw bytes */
        src/game/dispatch_helpers.o(.text);  /* 0x0800a2d8 - 0x0800a3d0, sub_0800A2D8, sub_0800A328, sub_0800A3A4 */
        asm/text/text_0x0800a3d0.o(.text);  /* 0x0800a3d0 - 0x0800a4d0, raw bytes */
        src/engine/sub_0800a4d0.o(.text);  /* 0x0800a4d0 - 0x0800a520, sub_0800A4D0 */
        src/game/sub_0800a520.o(.text);  /* 0x0800a520 - 0x0800a580, sub_0800A520 + sub_0800A540 */
        asm/disasm_0x0800a540.o(.text);  /* 0x0800a580 - 0x0800a710, sub_0800A580 (auto-peeled) */
        src/engine/sub_0800a710.o(.text);  /* 0x0800a710 - 0x0800a7a8, sub_0800A710 */
        asm/disasm_0x0800a7a8.o(.text);  /* 0x0800a7a8 - 0x0800a83c, sub_0800A7A8 (auto-peeled) */
        asm/text/text_0x0800a83c.o(.text);  /* 0x0800a83c - 0x0800a9d4, raw bytes */
        src/engine/sub_0800a9d4.o(.text);
        asm/disasm_0x0800a9d4.o(.text);  /* 0x0800a9d4 - 0x0800aa70, sub_0800A9D4 (peeled) */
        src/engine/sub_0800aa70.o(.text);
        asm/disasm_0x0800aa70.o(.text);  /* 0x0800aa70 - 0x0800ab84, sub_0800AA70 (auto-peeled) */
        src/engine/sub_0800ab84.o(.text);
        asm/disasm_0x0800ab84.o(.text);  /* 0x0800ab84 - 0x0800af50, sub_0800AB84 (auto-peeled) */
        src/engine/sub_0800af50.o(.text);
        asm/disasm_0x0800af50.o(.text);  /* 0x0800af50 - 0x0800b07c, sub_0800AF50 (auto-peeled) */
        asm/text/text_0x0800b07c.o(.text);  /* 0x0800b07c - 0x0800b7b0, raw bytes */
        src/engine/sub_0800b7b0.o(.text);
        asm/disasm_0x0800b7b0.o(.text);  /* 0x0800b7b0 - 0x0800b8a8, sub_0800B7B0 (auto-peeled) */
        src/engine/sub_0800b8a8.o(.text);  /* 0x0800b8a8 - 0x0800b918, sub_0800B8A8 */
        src/engine/sub_0800b918.o(.text);
        asm/disasm_0x0800b918.o(.text);  /* 0x0800b918 - 0x0800be18, sub_0800B918 (auto-peeled) */
        src/engine/sub_0800be18.o(.text);
        asm/text/text_0x0800bebc.o(.text);  /* 0x0800bebc - 0x0800c358, raw bytes */
        src/engine/sub_0800c358.o(.text);
        asm/disasm_0x0800c358.o(.text);  /* 0x0800c358 - 0x0800c444, sub_0800C358 (auto-peeled) */
        asm/text/text_0x0800c444.o(.text);  /* 0x0800c444 - 0x0800c4a0, raw bytes */
        src/engine/sub_0800c4a0.o(.text);
        asm/disasm_0x0800c4a0.o(.text);  /* 0x0800c4a0 - 0x0800c4e8, sub_0800C4A0 (auto-peeled) */
        asm/text/text_0x0800c4e8.o(.text);  /* 0x0800c4e8 - 0x0800cb80, raw bytes */
        src/engine/sub_0800cb80.o(.text);
        asm/disasm_0x0800cb80.o(.text);  /* 0x0800cb80 - 0x0800cd88, sub_0800CB80 (auto-peeled) */
        src/engine/sub_0800cd88.o(.text);
        src/engine/sub_0800cdcc.o(.text);
        src/engine/sub_0800ce10.o(.text);
        src/engine/sub_0800ce54.o(.text);
        src/engine/sub_0800ce98.o(.text);
        asm/text/text_0x0800ced0.o(.text);  /* 0x0800ced0 - 0x0800d028, raw bytes */
        src/engine/sub_0800d028.o(.text);
        asm/text/text_0x0800d070.o(.text);  /* 0x0800d070 - 0x0800dc50, raw bytes */
        src/engine/sub_0800dc50.o(.text);
        asm/disasm_0x0800dc50.o(.text);  /* 0x0800dc50 - 0x0800dd80, sub_0800DC50 (auto-peeled) */
        src/engine/sub_0800dd80.o(.text);  /* 0x0800dd80 - 0x0800de0c, sub_0800DD80 */
        asm/text/text_0x0800de0c.o(.text);  /* 0x0800de0c - 0x0800de80, raw bytes */
        src/engine/sub_0800de80.o(.text);  /* 0x0800de80 - 0x0800df7c, sub_0800DE80 */
        src/engine/sub_0800df7c.o(.text);  /* 0x0800df7c - 0x0800df9c, sub_0800DF7C */
        asm/text/text_0x0800df9c.o(.text);  /* 0x0800df9c - 0x0800dffc, raw bytes */
        src/engine/sub_0800dffc.o(.text);
        asm/disasm_0x0800dffc.o(.text);  /* 0x0800dffc - 0x0800e048, sub_0800DFFC (auto-peeled) */
        src/engine/sub_0800e048.o(.text);
        src/engine/sub_0800e060.o(.text);  /* 0x0800e060 - 0x0800e174, sub_0800E060 */
        asm/text/text_0x0800e174.o(.text);  /* 0x0800e174 - 0x0800e600, raw bytes */
        src/engine/sub_0800e600.o(.text);  /* 0x0800e600 - 0x0800e6a8, sub_0800E600 */
        src/engine/sub_0800e6a8.o(.text);
        asm/disasm_0x0800e6a8.o(.text);  /* 0x0800e6a8 - 0x0800e85c, sub_0800E6A8 (auto-peeled) */
        src/engine/sub_0800e85c.o(.text);
        asm/disasm_0x0800e85c.o(.text);  /* 0x0800e85c - 0x0800eb1c, sub_0800E85C (auto-peeled) */
        asm/text/text_0x0800eb1c.o(.text);  /* 0x0800eb1c - 0x0800ee34, raw bytes */
        src/engine/sub_0800ee34.o(.text);  /* 0x0800ee34 - 0x0800ee94, sub_0800EE34 */
        src/engine/sub_0800ee94.o(.text);  /* 0x0800ee94 - 0x0800eee8, sub_0800EE94 */
        asm/disasm_0x0800eee8.o(.text);  /* 0x0800eee8 - 0x0800ef58, sub_0800EEE8 (auto-peeled) */
        asm/text/text_0x0800ef58.o(.text);  /* 0x0800ef58 - 0x0800ef90, raw bytes */
        src/engine/sub_0800ef90.o(.text);
        asm/disasm_0x0800ef90.o(.text);  /* 0x0800ef90 - 0x0800eff4, sub_0800EF90 (auto-peeled) */
        asm/text/text_0x0800eff4.o(.text);  /* 0x0800eff4 - 0x0800f24c, raw bytes */
        src/engine/sub_0800f24c.o(.text);
        asm/disasm_0x0800f24c.o(.text);  /* 0x0800f24c - 0x0800f2f8, sub_0800F24C (auto-peeled) */
        asm/text/text_0x0800f2f8.o(.text);  /* 0x0800f2f8 - 0x0800f398, raw bytes */
        src/engine/sub_0800f398.o(.text);
        asm/disasm_0x0800f398.o(.text);  /* 0x0800f398 - 0x0800f814, sub_0800F398 (auto-peeled) */
        src/engine/sub_0800f814.o(.text);
        asm/disasm_0x0800f814.o(.text);  /* 0x0800f814 - 0x0800fcc8, sub_0800F814 (auto-peeled) */
        src/engine/sub_0800fcc8.o(.text);
        src/engine/sub_0800fd50.o(.text);  /* 0x0800fd50 - 0x0800fe10, sub_0800FD50 (extended-pool range; 7 trailing words land in .o pool) */
        asm/text/text_0x0800fe10.o(.text);  /* 0x0800fe10 - 0x0800fe88, raw bytes */
        src/engine/sub_0800fe88.o(.text);
        asm/disasm_0x0800fe88.o(.text);  /* 0x0800fe88 - 0x080100e4, sub_0800FE88 (auto-peeled) */
        asm/text/text_0x080100e4.o(.text);  /* 0x080100e4 - 0x08010694, raw bytes */
        src/engine/sub_08010694.o(.text);
        src/engine/sub_080106b8.o(.text);
        asm/text/text_0x08010740.o(.text);  /* 0x08010740 - 0x080112c0, raw bytes */
        src/engine/sub_080112c0.o(.text);
        asm/disasm_0x080112c0.o(.text);  /* 0x080112c0 - 0x080113e8, sub_080112C0 (auto-peeled) */
        asm/text/text_0x080113e8.o(.text);  /* 0x080113e8 - 0x08012664, raw bytes */
        src/engine/sub_08012664.o(.text);
        asm/disasm_0x08012664.o(.text);  /* 0x08012664 - 0x0801288c, sub_08012664 (auto-peeled) */
        src/engine/sub_0801288c.o(.text);
        asm/disasm_0x0801288c.o(.text);  /* 0x0801288c - 0x0801297c, sub_0801288C (auto-peeled) */
        src/engine/sub_0801297c.o(.text);
        asm/disasm_0x0801297c.o(.text);  /* 0x0801297c - 0x08012a6c, sub_0801297C (auto-peeled) */
        asm/text/text_0x08012a6c.o(.text);  /* 0x08012a6c - 0x08012b38, raw bytes */
        src/engine/sub_08012b38.o(.text);
        asm/disasm_0x08012b38.o(.text);  /* 0x08012b38 - 0x08012b78, sub_08012B38 (auto-peeled) */
        asm/text/text_0x08012b78.o(.text);  /* 0x08012b78 - 0x08012bc4, raw bytes */
        src/engine/sub_08012bc4.o(.text);
        asm/disasm_0x08012bc4.o(.text);  /* 0x08012bc4 - 0x08012cac, sub_08012BC4 (auto-peeled) */
        asm/text/text_0x08012cac.o(.text);  /* 0x08012cac - 0x08013908, raw bytes */
        src/engine/sub_08013908.o(.text);
        asm/disasm_0x08013908.o(.text);  /* 0x08013908 - 0x08013920, sub_08013908 (auto-peeled) */
        asm/text/text_0x08013920.o(.text);  /* 0x08013920 - 0x08013fa0, raw bytes */
        src/engine/sub_08013fa0.o(.text);
        asm/text/text_0x08013fd0.o(.text);  /* 0x08013fd0 - 0x08016404, raw bytes */
        src/engine/sub_08016404.o(.text);
        asm/disasm_0x08016404.o(.text);  /* 0x08016404 - 0x08016650, sub_08016404 (auto-peeled) */
        asm/text/text_0x08016650.o(.text);  /* 0x08016650 - 0x08016a40, raw bytes */
        asm/disasm_0x08016a40.o(.text);  /* 0x08016a40 - 0x08017000, sub_08016A40 (auto-peeled) */
        asm/text/text_0x08017000.o(.text);  /* 0x08017000 - 0x08017364, raw bytes */
        src/engine/sub_08017364.o(.text);
        asm/disasm_0x08017364.o(.text);  /* 0x08017364 - 0x080177a0, sub_08017364 (auto-peeled) */
        asm/text/text_0x080177a0.o(.text);  /* 0x080177a0 - 0x0801793c, raw bytes */
        src/engine/sub_0801793c.o(.text);
        asm/disasm_0x0801793c.o(.text);  /* 0x0801793c - 0x080179b8, sub_0801793C (auto-peeled) */
        src/engine/sub_080179b8.o(.text);
        asm/disasm_0x080179b8.o(.text);  /* 0x080179b8 - 0x08017a88, sub_080179B8 (auto-peeled) */
        asm/text/text_0x08017a88.o(.text);  /* 0x08017a88 - 0x08019500, raw bytes */
        src/engine/sub_08019500.o(.text);
        asm/disasm_0x08019500.o(.text);  /* 0x08019500 - 0x08019540, sub_08019500 (auto-peeled) */
        src/engine/sub_08019540.o(.text);
        asm/disasm_0x08019540.o(.text);  /* 0x08019540 - 0x08019560, sub_08019540 (auto-peeled) */
        asm/disasm_0x08019560.o(.text);  /* 0x08019560 - 0x08019580, sub_08019560 (auto-peeled) */
        asm/text/text_0x08019580.o(.text);  /* 0x08019580 - 0x0801a268, raw bytes */
        src/engine/sub_0801a268.o(.text);
        asm/disasm_0x0801a268.o(.text);  /* 0x0801a268 - 0x0801a614, sub_0801A268 (auto-peeled) */
        asm/text/text_0x0801a614.o(.text);  /* 0x0801a614 - 0x0801a894, raw bytes */
        asm/disasm_0x0801a894.o(.text);  /* 0x0801a894 - 0x0801a980, sub_0801A894 (auto-peeled) */
        asm/disasm_0x0801a980.o(.text);  /* 0x0801a980 - 0x0801aa60, sub_0801A980 (auto-peeled) */
        asm/text/text_0x0801aa60.o(.text);  /* 0x0801aa60 - 0x0801b514, raw bytes */
        src/engine/sub_0801b514.o(.text);
        asm/disasm_0x0801b514.o(.text);  /* 0x0801b514 - 0x0801b694, sub_0801B514 (auto-peeled) */
        asm/text/text_0x0801b694.o(.text);  /* 0x0801b694 - 0x0801bb54, raw bytes */
        src/engine/sub_0801bb54.o(.text);
        asm/disasm_0x0801bb54.o(.text);  /* 0x0801bb54 - 0x0801be7c, sub_0801BB54 (auto-peeled) */
        asm/disasm_0x0801be7c.o(.text);  /* 0x0801be7c - 0x0801c078, sub_0801BE7C (auto-peeled) */
        asm/text/text_0x0801c078.o(.text);  /* 0x0801c078 - 0x0801c464, raw bytes */
        src/engine/sub_0801c464.o(.text);
        asm/disasm_0x0801c464.o(.text);  /* 0x0801c464 - 0x0801c6e4, sub_0801C464 (auto-peeled) */
        asm/text/text_0x0801c6e4.o(.text);  /* 0x0801c6e4 - 0x0801cf18, raw bytes */
        src/engine/sub_0801cf18.o(.text);
        asm/disasm_0x0801cf18.o(.text);  /* 0x0801cf18 - 0x0801cfa0, sub_0801CF18 (auto-peeled) */
        asm/text/text_0x0801cfa0.o(.text);  /* 0x0801cfa0 - 0x0801d048, raw bytes */
        src/engine/sub_0801d048.o(.text);
        src/engine/sub_0801d094.o(.text);
        asm/text/text_0x0801d0bc.o(.text);  /* 0x0801d0bc - 0x0801d150, raw bytes */
        asm/disasm_0x0801d150.o(.text);  /* 0x0801d150 - 0x0801d268, sub_0801D150 (auto-peeled) */
        asm/disasm_0x0801d268.o(.text);  /* 0x0801d268 - 0x0801d33c, sub_0801D268 (auto-peeled) */
        asm/disasm_0x0801d33c.o(.text);  /* 0x0801d33c - 0x0801d438, sub_0801D33C (auto-peeled) */
        asm/text/text_0x0801d438.o(.text);  /* 0x0801d438 - 0x0801d4cc, raw bytes */
        asm/disasm_0x0801d4cc.o(.text);  /* 0x0801d4cc - 0x0801d570, sub_0801D4CC (auto-peeled) */
        asm/text/text_0x0801d570.o(.text);  /* 0x0801d570 - 0x0801da1c, raw bytes */
        src/engine/sub_0801da1c.o(.text);
        asm/disasm_0x0801da1c.o(.text);  /* 0x0801da1c - 0x0801dbb4, sub_0801DA1C (auto-peeled) */
        asm/text/text_0x0801dbb4.o(.text);  /* 0x0801dbb4 - 0x0801e118, raw bytes */
        src/engine/sub_0801e118.o(.text);
        asm/disasm_0x0801e1ac.o(.text);  /* 0x0801e1ac - 0x0801e1fc, sub_0801E1AC (auto-peeled) */
        asm/text/text_0x0801e1fc.o(.text);  /* 0x0801e1fc - 0x0801e270, raw bytes */
        asm/disasm_0x0801e270.o(.text);  /* 0x0801e270 - 0x0801e28c, sub_0801E270 (auto-peeled) */
        asm/disasm_0x0801e28c.o(.text);  /* 0x0801e28c - 0x0801ea08, sub_0801E28C (auto-peeled) */
        asm/text/text_0x0801ea08.o(.text);  /* 0x0801ea08 - 0x08020000, raw bytes */
        asm/text/text_0x08020000.o(.text);  /* 0x08020000 - 0x080201a8, raw bytes */
        src/engine/sub_080201a8.o(.text);
        asm/disasm_0x080201a8.o(.text);  /* 0x080201a8 - 0x080201c8, sub_080201A8 (auto-peeled) */
        asm/disasm_0x080201c8.o(.text);  /* 0x080201c8 - 0x080201e8, sub_080201C8 (auto-peeled) */
        asm/disasm_0x080201e8.o(.text);  /* 0x080201e8 - 0x08020270, sub_080201E8 (auto-peeled) */
        asm/text/text_0x08020270.o(.text);  /* 0x08020270 - 0x080202a8, raw bytes */
        asm/disasm_0x080202a8.o(.text);  /* 0x080202a8 - 0x080202f8, sub_080202A8 (auto-peeled) */
        asm/text/text_0x080202f8.o(.text);  /* 0x080202f8 - 0x080204a4, raw bytes */
        asm/disasm_0x080204a4.o(.text);  /* 0x080204a4 - 0x080205d8, sub_080204A4 (auto-peeled) */
        asm/text/text_0x080205d8.o(.text);  /* 0x080205d8 - 0x0802090c, raw bytes */
        src/game/sub_0802090c.o(.text);  /* 0x0802090c - 0x08020b30, sub_0802090C (NAKED+NON_MATCHING) */
        src/game/sub_08020b30.o(.text);  /* 0x08020b30 - 0x08020b50, sub_08020B30 */
        asm/text/text_0x08020b50.o(.text);  /* 0x08020b50 - 0x08020b60, raw bytes */
        src/system/sub_08020b60.o(.text);  /* 0x08020b60 - 0x08020b78, sub_08020B60 */
        asm/text/text_0x08020b78.o(.text);  /* 0x08020b78 - 0x08020b88, raw bytes */
        asm/disasm_0x08020b88.o(.text);  /* 0x08020b88 - 0x08020bac, sub_08020B88 (auto-peeled) */
        asm/disasm_0x08020bac.o(.text);  /* 0x08020bac - 0x08020bc0, sub_08020BAC (auto-peeled) */
        src/engine/sub_08020bc0.o(.text);
        asm/disasm_0x08020bc0.o(.text);  /* 0x08020bc0 - 0x08020bf0, sub_08020BC0 (auto-peeled) */
        asm/text/text_0x08020bf0.o(.text);  /* 0x08020bf0 - 0x08020c78, raw bytes */
        src/engine/sub_08020c78.o(.text);
        asm/disasm_0x08020c78.o(.text);  /* 0x08020c78 - 0x08020ca4, sub_08020C78 (auto-peeled) */
        asm/text/text_0x08020ca4.o(.text);  /* 0x08020ca4 - 0x08020dc4, raw bytes */
        src/engine/sub_08020dc4.o(.text);
        asm/text/text_0x08020e14.o(.text);  /* 0x08020e14 - 0x08020e7c, raw bytes */
        src/engine/sub_08020e7c.o(.text);  /* 0x08020e7c - 0x08020e98, sub_08020E7C */
        src/system/sub_08020e98.o(.text);  /* 0x08020e98 - 0x08020ed8, sub_08020E98 */
        asm/disasm_0x08020ed8.o(.text);  /* 0x08020ed8 - 0x08020ee4, sub_08020ED8 (peeled) */
        asm/disasm_0x08020ee4.o(.text);  /* 0x08020ee4 - 0x08020f08, sub_08020EE4 (peeled) */
        asm/disasm_0x08020f08.o(.text);  /* 0x08020f08 - 0x08020f3c, sub_08020F08 (peeled) */
        asm/text/text_0x08020f3c.o(.text);  /* 0x08020f3c - 0x080210a0, raw bytes */
        asm/disasm_0x080210a0.o(.text);  /* 0x080210a0 - 0x08021140, sub_080210A0 (auto-peeled) */
        asm/text/text_0x08021140.o(.text);  /* 0x08021140 - 0x0802ab64, raw bytes */
        src/game/sub_0802ab64.o(.text);
        asm/text/text_0x0802abb0.o(.text);  /* 0x0802abb0 - 0x0802d554, raw bytes */
        asm/disasm_0x0802d554.o(.text);  /* 0x0802d554 - 0x0802d558, sub_0802D554 (auto-peeled) */
        asm/disasm_0x0802d558.o(.text);  /* 0x0802d558 - 0x0802d890, sub_0802D558 (auto-peeled) */
        asm/text/text_0x0802d890.o(.text);  /* 0x0802d890 - 0x0802d8f8, raw bytes */
        asm/disasm_0x0802d8f8.o(.text);  /* 0x0802d8f8 - 0x0802d9ec, sub_0802D8F8 (auto-peeled) */
        asm/disasm_0x0802d9ec.o(.text);  /* 0x0802d9ec - 0x0802dcbc, sub_0802D9EC (auto-peeled) */
        asm/text/text_0x0802dcbc.o(.text);  /* 0x0802dcbc - 0x0802e100, raw bytes */
        src/system/sub_0802e100.o(.text);  /* 0x0802e100 - 0x0802e13c, sub_0802E100 */
        src/system/sub_0802e13c.o(.text);  /* 0x0802e13c - 0x0802e1c8, sub_0802E13C */
        asm/text/text_0x0802e1c8.o(.text);  /* 0x0802e1c8 - 0x0802e3f8, raw bytes */
        src/system/sound_lock.o(.text);  /* 0x0802e3f8 - 0x0802e43c, sub_0802E3F8 + sub_0802E418 */
        asm/text/text_0x0802e43c.o(.text);  /* 0x0802e43c - 0x0802e5d8, raw bytes */
        src/system/sound_pitch.o(.text);  /* 0x0802e5d8 - 0x0802e684, sub_0802E5D8 */
        src/system/sound_volume.o(.text);  /* 0x0802e684 - 0x0802e724, sub_0802E684 */
        src/system/sub_0802e724.o(.text);  /* 0x0802e724 - 0x0802e7c4, sub_0802E724 */
        src/system/sub_0802e7c4.o(.text);  /* 0x0802e7c4 - 0x0802e934, sub_0802E7C4 + sub_0802E874 */
        src/system/sound_envelope_dual.o(.text);  /* 0x0802e934 - 0x0802ea2c, sub_0802E934 (NAKED+NON_MATCHING) */
        asm/text/text_0x0802ea2c.o(.text);  /* 0x0802ea2c - 0x0802ea80, raw bytes */
        src/system/sound_envelope.o(.text);  /* 0x0802ea80 - 0x0802eb34, sub_0802EA80 */
        asm/text/text_0x0802eb34.o(.text);  /* 0x0802eb34 - 0x0802ec7c, raw bytes */
        src/system/sound_channel.o(.text);  /* 0x0802ec7c - 0x0802eef8, sub_0802EC7C + sub_0802ED5C + sub_0802EDF0 (sub_0802EC7C and sub_0802EDF0 NAKED+NON_MATCHING) */
        asm/text/text_0x0802eef8.o(.text);  /* 0x0802eef8 - 0x0802f054, raw bytes */
        src/system/sound_envelope_slide.o(.text);  /* 0x0802f054 - 0x0802f2fc, sub_0802F054 (NAKED+NON_MATCHING) */
        src/system/sound_pan.o(.text);  /* 0x0802f2fc - 0x0802f398, sub_0802F2FC (NAKED+NON_MATCHING) */
        asm/text/text_0x0802f398.o(.text);  /* 0x0802f398 - 0x0802f4b0, raw bytes */
        src/system/sound_mixer.o(.text);  /* 0x0802f4b0 - 0x0802f870, sub_0802F4B0 (NAKED+NON_MATCHING) */
        asm/text/text_0x0802f870.o(.text);  /* 0x0802f870 - 0x0802f9f0, raw bytes */
        src/system/sub_0802f9f0.o(.text);  /* 0x0802f9f0 - 0x0802fa60, sub_0802F9F0 */
        asm/text/text_0x0802fa60.o(.text);  /* 0x0802fa60 - 0x08030000, raw bytes */
        asm/text/text_0x08030000.o(.text);  /* 0x08030000 - 0x080301c4, raw bytes */
        src/system/sound_period.o(.text);  /* 0x080301c4 - 0x08030264, sub_080301C4 (NAKED+NON_MATCHING — libgcc-BL class) */
        asm/text/text_0x08030264.o(.text);  /* 0x08030264 - 0x080315d8, raw bytes */
        src/system/sound_opcode_dispatch.o(.text);  /* 0x080315d8 - 0x08031638, sub_080315D8 */
        asm/text/text_0x08031638.o(.text);  /* 0x08031638 - 0x08032094, raw bytes */
        asm/disasm_0x08032094.o(.text);  /* 0x08032094 - 0x08032148, sub_08032094 (auto-peeled) */
        asm/text/text_0x08032148.o(.text);  /* 0x08032148 - 0x080325b0, raw bytes */
        src/system/sound_mixer_tail.o(.text);  /* 0x080325b0 - 0x08032894, sub_080325B0 (NAKED+NON_MATCHING) */
        src/system/sub_08032894.o(.text);  /* 0x08032894 - 0x08032904, sub_08032894 */
        asm/disasm_0x08032904.o(.text);  /* 0x08032904 - 0x0803299c, sub_08032904 (auto-peeled) */
        asm/disasm_0x0803299c.o(.text);  /* 0x0803299c - 0x08032aa0, sub_0803299C (auto-peeled) */
        asm/text/text_0x08032aa0.o(.text);  /* 0x08032aa0 - 0x08032b18, raw bytes */
        asm/disasm_0x08032b18.o(.text);  /* 0x08032b18 - 0x08032bc8, sub_08032B18 (auto-peeled) */
        asm/text/text_0x08032bc8.o(.text);  /* 0x08032bc8 - 0x08033910, raw bytes */
        src/game/sub_08033910.o(.text);  /* 0x08033910 - 0x08033948, sub_08033910 */
        asm/text/text_0x08033948.o(.text);  /* 0x08033948 - 0x08033ca4, raw bytes */
        asm/disasm_0x08033ca4.o(.text);  /* 0x08033ca4 - 0x08033cd8, __ashldi3 (libgcc; auto-peeled) */
        asm/disasm_0x08033cd8.o(.text);  /* 0x08033cd8 - 0x08033d14, _call_via_rX libgcc helper table (auto-peeled) */
        asm/disasm_0x08033d14.o(.text);  /* 0x08033d14 - 0x08033da8, __divsi3 (libgcc; auto-peeled) */
        asm/text/text_0x08033da8.o(.text);  /* 0x08033da8 - 0x08033ee4, raw bytes */
        asm/disasm_0x08033ee4.o(.text);  /* 0x08033ee4 - 0x08033f5c, __udivsi3 (libgcc; auto-peeled) */
        asm/disasm_0x08033f5c.o(.text);  /* 0x08033f5c - 0x0803401c, __umodsi3 (libgcc; auto-peeled) */
        asm/text/text_0x0803401c.o(.text);  /* 0x0803401c - 0x08035d7c, raw bytes */
        asm/disasm_0x08035d7c.o(.text);  /* 0x08035d7c - 0x08035d84, sub_08035D7C (auto-peeled) */
        asm/text/text_0x08035d84.o(.text);  /* 0x08035d84 - 0x08035d8c, one Thumb-to-ARM veneer */
        asm/disasm_0x08035d8c.o(.text);  /* 0x08035d8c - 0x08035d94, sub_08035D8C (Thumb-to-ARM veneer, sound-IRQ disable) */
        asm/disasm_0x08035d94.o(.text);  /* 0x08035d94 - 0x08035d9c, sub_08035D94 (Thumb-to-ARM veneer, sound-IRQ enable) */
        src/data/irq_handler_table.o(.rodata);  /* 0x08035d9c - 0x08035dd0, sIrqHandlerTable */
        asm/text/text_0x08035dd0.o(.text);  /* 0x08035dd0 - 0x08040000, raw bytes */
        asm/text/text_0x08040000.o(.text);  /* 0x08040000 - 0x08050000, raw bytes */
        asm/text/text_0x08050000.o(.text);  /* 0x08050000 - 0x08060000, raw bytes */
        asm/text/text_0x08060000.o(.text);  /* 0x08060000 - 0x08070000, raw bytes */
        asm/text/text_0x08070000.o(.text);  /* 0x08070000 - 0x08080000, raw bytes */
        asm/text/text_0x08080000.o(.text);  /* 0x08080000 - 0x08090000, raw bytes */
        asm/text/text_0x08090000.o(.text);  /* 0x08090000 - 0x080a0000, raw bytes */
        asm/text/text_0x080a0000.o(.text);  /* 0x080a0000 - 0x080b0000, raw bytes */
        asm/text/text_0x080b0000.o(.text);  /* 0x080b0000 - 0x080c0000, raw bytes */
        asm/text/text_0x080c0000.o(.text);  /* 0x080c0000 - 0x080c0ab0, raw bytes (shrunk for entity-dispatch cluster) */
        src/data/entity_dispatch.o(.rodata);  /* 0x080c0ab0 - 0x080c1254, entity dispatch + sine table (13 named tables) */
        asm/text/text_0x080c1254.o(.text);  /* 0x080c1254 - 0x080d0000, raw bytes (tail after entity-dispatch cluster) */
        asm/text/text_0x080d0000.o(.text);  /* 0x080d0000 - 0x080e0000, raw bytes */
        asm/text/text_0x080e0000.o(.text);  /* 0x080e0000 - 0x080e3190, raw bytes (shrunk for character-sprite-frames cluster) */
        src/data/character_sprite_frames.o(.rodata);  /* 0x080e3190 - 0x080e34c0, sCharacterSpriteFrames (51 records x 16 B) */
        asm/text/text_0x080e34c0.o(.text);  /* 0x080e34c0 - 0x080e3550, raw bytes (intra-cluster zero padding) */
        src/data/ui_status_bar.o(.rodata);  /* 0x080e3550 - 0x080e3754, sUiAssetSlots + sFrogStatusBarFrames */
        asm/text/text_0x080e3754.o(.text);  /* 0x080e3754 - 0x080e3774, raw bytes (intra-cluster gap head) */
        src/data/frog_sprite_palettes.o(.rodata);  /* 0x080e3774 - 0x080e3814, sFrogSpritePalettes_E3774 (5 x 16 colors) */
        asm/text/text_0x080e3814.o(.text);  /* 0x080e3814 - 0x080e3a30, raw bytes (sprite-frame region pointed at by sSpriteFrameDescriptors[0..4]) */
        src/data/ui_status_bar_tiles.o(.rodata);  /* 0x080e3a30 - 0x080e3ab4, sFrogStatusBarTileData */
        asm/text/text_0x080e3ab4.o(.text);  /* 0x080e3ab4 - 0x080e3ab6, halfword pad (.balign 1) */
        asm/data/frog_tile_pixels_e3ab6.o(.rodata);  /* 0x080e3ab6 - 0x080e7ab6, sFrogTilePixels_E3AB6 (0x4000 B 4bpp OBJ tile data) */
        asm/data/frog_tile_pixels_e7ab6.o(.rodata);  /* 0x080e7ab6 - 0x080f0000, sFrogTilePixels_E7AB6 (0x854a B 4bpp OBJ tile data, sibling of E3AB6) */
        asm/text/text_0x080f0000.o(.text);  /* 0x080f0000 - 0x080f72c4, raw bytes (shrunk for screen_0800f014 cluster) */
        src/data/screen_0800f014.o(.rodata);  /* 0x080f72c4 - 0x081004c4, sScreenPalette_F72C4 + Bg0 tilemap + Bg0 char tiles + Bg1 tilemap (37312 B) */
        asm/text/text_0x081004c4.o(.text);  /* 0x081004c4 - 0x08100cc4, intra-cluster gap (0x800 B zero pad) */
        src/data/screen_08100cc4.o(.rodata);  /* 0x08100cc4 - 0x08104cc4, sScreenCharTilesBg1_100CC4 (16384 B) */
        asm/text/text_0x08104cc4.o(.text);  /* 0x08104cc4 - 0x08110000, raw bytes (tail after screen_0800f014 cluster) */
        asm/text/text_0x08110000.o(.text);  /* 0x08110000 - 0x08120000, raw bytes */
        asm/text/text_0x08120000.o(.text);  /* 0x08120000 - 0x08130000, raw bytes */
        asm/text/text_0x08130000.o(.text);  /* 0x08130000 - 0x08140000, raw bytes */
        asm/text/text_0x08140000.o(.text);  /* 0x08140000 - 0x08150000, raw bytes */
        asm/text/text_0x08150000.o(.text);  /* 0x08150000 - 0x08160000, raw bytes */
        asm/text/text_0x08160000.o(.text);  /* 0x08160000 - 0x08170000, raw bytes */
        asm/text/text_0x08170000.o(.text);  /* 0x08170000 - 0x08173000, raw bytes (shrunk for icon-anim cluster) */
        src/data/icon_anim_frames.o(.rodata);  /* 0x08173000 - 0x08173ab8, sIconTilesHeader_173000 + sIconPalette_173038 + sIconUnrefAnimData_173058 + sIconAnimFrames */
        asm/text/text_0x08173ab8.o(.text);  /* 0x08173ab8 - 0x08180000, raw bytes (tail after icon-anim cluster) */
        asm/text/text_0x08180000.o(.text);  /* 0x08180000 - 0x08188edc, raw bytes (shrunk for screen_188edc cluster) */
        src/data/screen_188edc.o(.rodata);  /* 0x08188edc - 0x081896dc, sScreenTilemap_188EDC (0x800 B BG tilemap, screenblock 28) */
        asm/text/text_0x081896dc.o(.text);  /* 0x081896dc - 0x08190000, raw bytes (tail after screen_188edc cluster) */
        asm/text/text_0x08190000.o(.text);  /* 0x08190000 - 0x0819c312, raw bytes (shrunk for bg_tilemap_19c312 cluster) */
        asm/data/bg_tilemap_19c312.o(.rodata);  /* 0x0819c312 - 0x0819dcaa, sBgTilemapVariantA_19C312 + sBgTilemapVariantB_19CFDE */
        asm/text/text_0x0819dcaa.o(.text);  /* 0x0819dcaa - 0x081a0000, raw bytes (tail after bg_tilemap_19c312 cluster) */
        asm/text/text_0x081a0000.o(.text);  /* 0x081a0000 - 0x081a3b6a, raw bytes (shrunk for screen_1a3b6a cluster) */
        asm/data/screen_1a3b6a.o(.rodata);  /* 0x081a3b6a - 0x081a636a, sScreenCharTiles_1A3B6A (8 KiB) + sScreenTilemap_1A5B6A (2 KiB) */
        asm/text/text_0x081a636a.o(.text);  /* 0x081a636a - 0x081b0000, raw bytes (tail after screen_1a3b6a cluster) */
        asm/text/text_0x081b0000.o(.text);  /* 0x081b0000 - 0x081b23ca, raw bytes (shrunk for screen_1b23ca + scenery_1b62aa clusters) */
        asm/data/screen_1b23ca.o(.rodata);  /* 0x081b23ca - 0x081b62aa, sScreenCharTiles_1B23CA (8 KiB) + sScreenTilemap_1B43CA (2 KiB) + sScreenExtraData_1B4BCA (0x16e0 B) */
        asm/data/scenery_1b62aa.o(.rodata);  /* 0x081b62aa - 0x081bd8cc, 4 mode-dispatch pairs (8 x 0xec4) + 2 B tail pad */
        src/data/eeprom_signature.o(.rodata);  /* 0x081bd8cc - 0x081bd90c, sEepromSignatureBlock */
        asm/text/text_0x081bd90c.o(.text);  /* 0x081bd90c - 0x081bd910, 4 B pad */
        src/data/win_pose_oam.o(.rodata);  /* 0x081bd910 - 0x081bda44, win-pose OAM + tile-stream */
        src/data/level_name_strings.o(.rodata);  /* 0x081bda44 - 0x081bdf70, sLevelNameStrings */
        src/data/ui_text_tables.o(.rodata);  /* 0x081bdf70 - 0x081be0b4, window border + level-cleared + win/lose + glyphs + world letters */
        src/data/credits_text.o(.rodata);  /* 0x081be0b4 - 0x081be810, credits text + ON/OFF labels + misc */
        src/data/world_tile_map.o(.rodata);  /* 0x081be810 - 0x081bee64, sWorldTileTypeMap */
        src/data/credits_tilemap.o(.rodata);  /* 0x081bee64 - 0x081c2684, sCreditsTilemapEng + sSaveDialogStrings */
        asm/text/text_0x081c2684.o(.text);  /* 0x081c2684 - 0x081d0000, raw bytes (tail) */
        asm/text/text_0x081d0000.o(.text);  /* 0x081d0000 - 0x081d8398, raw bytes (shrunk for screen_d8398 + screen_d8b98 clusters) */
        src/data/screen_d8398.o(.rodata);   /* 0x081d8398 - 0x081d8b98, sScreenTilemapD8398 (screenblock-30 source tilemap) */
        src/data/screen_d8b98.o(.rodata);   /* 0x081d8b98 - 0x081e4c18, screen tilemap + palette + char tiles + tilemap (spans across former 0x081e0000 blob) */
        asm/text/text_0x081e4c18.o(.text);  /* 0x081e4c18 - 0x081e6418, raw bytes (shrunk for screen_tilemaps_e6418 + tilemap_e6c18 + screen_tilemaps_e7418 + screen_tilemaps_e9418 + obj_assets_ecc18 clusters) */
        src/data/screen_tilemaps_e6418.o(.rodata);  /* 0x081e6418 - 0x081e6c18, sScreenTilemap_E6418 (sVramTilePtrTable slot [32], screenblock-29 source tilemap, 2 KiB) */
        src/data/tilemap_e6c18.o(.rodata);  /* 0x081e6c18 - 0x081e7418, sBgTilemap_E6C18 (screenblock-29 source tilemap, 2 KiB) */
        src/data/screen_tilemaps_e7418.o(.rodata);  /* 0x081e7418 - 0x081e9418, sScreenTilemap_E7418 + E7C18 + E8418 + E8C18 (sVramTilePtrTable slots [33..36], 4 x 2 KiB screenblock-29 tilemap variants) */
        src/data/screen_tilemaps_e9418.o(.rodata);  /* 0x081e9418 - 0x081ecc18, sScreenTilemap_E9418 + E9C18 + EA418 + EAC18 + EB418 + EBC18 + EC418 (7 x 2 KiB screenblock-29 tilemap variants) */
        src/data/obj_assets_ecc18.o(.rodata);  /* 0x081ecc18 - 0x081ece58, sObjPalette_ECC18 + sObjCharTiles_ECC38 + sObjPalette_ECE38 (576 B) */
        asm/text/text_0x081ece58.o(.text);  /* 0x081ece58 - 0x081f0000, raw bytes (tail after obj_assets_ecc18 cluster) */
        asm/text/text_0x081f0000.o(.text);  /* 0x081f0000 - 0x081fbd58, raw bytes (shrunk for screen_bd58 cluster) */
        src/data/screen_bd58.o(.rodata);    /* 0x081fbd58 - 0x08204758, sScreenPaletteBD58 + sScreenTilemapBF58 + sScreenCharTilesC758 (screen-install cluster, spans across former 0x08200000 boundary) */
        asm/text/text_0x08204758.o(.text);  /* 0x08204758 - 0x0820c578, raw bytes (gap between screen_bd58 and screen_c578 clusters) */
        src/data/screen_c578.o(.rodata);    /* 0x0820c578 - 0x0820d778, sScreenAuxTilesC578 + sScreenPaletteCD78 + sScreenTilemapCF78 (screenblock-28 source tilemap) */
        asm/text/text_0x0820d778.o(.text);  /* 0x0820d778 - 0x08210000, raw bytes (tail after screen_c578 cluster) */
        asm/text/text_0x08210000.o(.text);  /* 0x08210000 - 0x08215778, raw bytes (shrunk for sprite_tiles_215778 cluster) */
        src/data/sprite_tiles_215778.o(.rodata);  /* 0x08215778 - 0x08219378, sSpriteTiles_215778 + 216378 + 216F78 + 217B78 + 218778 (5 x 3 KiB sprite tile pool, sVramTilePtrTable [42..46]) */
        asm/text/text_0x08219378.o(.text);  /* 0x08219378 - 0x08219cc8, gap bytes between sprite_tiles_215778 and sprite_tiles_219cc8 clusters */
        src/data/sprite_tiles_219cc8.o(.rodata);  /* 0x08219cc8 - 0x0821ecc8, sSpriteTiles_219CC8 + 21B0C8 + 21C4C8 + 21D8C8 (4 x 5 KiB sprite tile pool, sVramTilePtrTable [47..50]) */
        asm/text/text_0x0821ecc8.o(.text);  /* 0x0821ecc8 - 0x08220000, raw bytes (tail after sprite_tiles_219cc8 cluster) */
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
        asm/text/text_0x082f0000.o(.text);  /* 0x082f0000 - 0x082f8ad8, raw bytes */
        src/data/sprite_asset_table.o(.rodata);  /* 0x082f8ad8 - 0x082f8de0, sSpriteAssetTable */
        src/data/sound_pitch_luts.o(.rodata);  /* 0x082f8de0 - 0x082f8e8c, sUnknownSoundLut_82F8DE0 + _82F8E2A */
        src/data/eeprom_id.o(.rodata);  /* 0x082f8e8c - 0x082f8e98, gEepromIdString */
        src/data/sound_dma_records.o(.rodata);  /* 0x082f8e98 - 0x082f8ec4, sSoundDmaBufCfg + sSoundDmaMaster */
        asm/text/text_0x082f8ec4.o(.text);  /* 0x082f8ec4 - 0x082f9920, raw bytes */
        src/data/unk_dispatch_2f9920.o(.rodata);  /* 0x082f9920 - 0x082f9994, sUnkDispatchData_82F9920 + sUnkPtrPair_82F998C */
        asm/text/text_0x082f9994.o(.text);  /* 0x082f9994 - 0x082f99e8, raw bytes (7-record stride-12 block, back-pointer target of sModeConfigTables_2F99E8[0]) */
        src/data/mode_config_2f99e8.o(.rodata);  /* 0x082f99e8 - 0x082f9d08, sModeConfigTables_2F99E8 + sModeLookupTable_2F9CF4 (per-mode config cluster backing the sub_08000918 14-case dispatcher) */
        asm/text/text_0x082f9d08.o(.text);  /* 0x082f9d08 - 0x08300000, raw bytes */
        asm/text/text_0x08300000.o(.text);  /* 0x08300000 - 0x08306444, raw bytes */
        src/data/sprite_dispatch.o(.rodata);  /* 0x08306444 - 0x08306814, sSpriteAssetIndexTable + sSpriteGridLayout + sSpriteGridSubtable */
        src/data/sprite_anim_block.o(.rodata);  /* 0x08306814 - 0x08308100, anim / OAM-DMA descriptor cluster (9 named symbols) */
        src/data/sprite_dma_records.o(.rodata);  /* 0x08308100 - 0x08310000, OAM-DMA cfg + sprite frame ptrs + VRAM tile ptrs + DMA load records + dispatch tables + Scene 2 DMA cluster */
        src/data/level_layout_310000.o(.rodata);  /* 0x08310000 - 0x08310eb4, sprite-anim dispatch cluster: 4 sSpriteAssetTable-anchored dispatchers + 2 interior ptr arrays + 5 backing-store data blobs + 10 standalone sub-tables (22 named symbols) */
        src/data/level_layout_310eb4.o(.rodata);  /* 0x08310eb4 - 0x083112a8, sLevelLayoutData_310EB4 + sLevelLayoutPtrs_311074 + sLevelLayoutData_3110AC + sLevelLayoutPtrs_31118C + sLevelLayoutData_3111A8 */
        src/data/level_layout_dispatch_3112a8.o(.rodata);  /* 0x083112a8 - 0x083112c8, sLevelLayoutDispatch_3112A8 */
        src/data/level_layout_3112c8.o(.rodata);  /* 0x083112c8 - 0x08312c20, sLevelLayoutData_3112C8 + 27 more tables (6.5 KB cluster) */
        src/data/level_layout_312c20.o(.rodata);  /* 0x08312c20 - 0x08312d60, sLevelLayout_312C20 + sLevelLayoutPtrs_312C98 + sLevelLayout_312CAC + sLevelLayoutPtrs_312D4C */
        src/data/level_layout_ptrs_312d60.o(.rodata);  /* 0x08312d60 - 0x08312e94, sLevelLayoutPtrs_312D60 + _312D80 + _312DA8 + _312DD4 + _312E6C + sLevelLayoutSentinel_312E84 */
        src/data/level_layout_312e94.o(.rodata);  /* 0x08312e94 - 0x08314a68, sLevelLayoutData_312E94 + sLevelLayoutPtrs_31332C + sLevelLayoutData_313360 + sLevelLayoutPtrs_313F78 + sLevelLayoutData_314068 */
        src/data/level_layout_ptrs_314a68.o(.rodata);  /* 0x08314a68 - 0x08314b30, sLevelLayoutPtrs_314A68 (46 ptrs + 4 sentinels) */
        src/data/level_layout_314b30.o(.rodata);  /* 0x08314b30 - 0x08315a48, sLevelLayoutManifest_314B30 + sLevelLayoutData_314B78 + sLevelLayoutPtrs_315268 + sLevelLayoutData_315280 */
        src/data/level_layout_dispatch_315a48.o(.rodata);  /* 0x08315a48 - 0x08315bb0, sLevelLayoutDispatch_315A48 */
        src/data/level_layout_315bb0.o(.rodata);  /* 0x08315bb0 - 0x08316dc8, sLevelLayoutData_315BB0 + sLevelLayoutPtrs_316660 + sLevelLayoutData_316718 */
        src/data/level_layout_dispatch_316dc8.o(.rodata);  /* 0x08316dc8 - 0x08316e5c, sLevelLayoutDispatch_316DC8 */
        src/data/level_layout_316e5c.o(.rodata);  /* 0x08316e5c - 0x08316f24, sLevelLayout_316E5C + sLevelLayout_316EB4 + sLevelLayout_316EC4 */
        src/data/level_layout.o(.rodata);  /* 0x08316f24 - 0x08318020, sLevelLayout_316F24..._317FFC + sLevelLayoutData + sLevelLayoutPtrs + 23 continuation tables */
        src/data/level_layout_318020.o(.rodata);  /* 0x08318020 - 0x083181bc, sLevelLayoutSentinels_318020 + sLevelLayoutManifest_31802C + sLevelLayout_31805C + 4 parallel-array tables (_31807C/_3180AC/_3180DC/_31810C) + sLevelLayout_31813C */
        src/data/level_layout_dispatch_3181bc.o(.rodata);  /* 0x083181bc - 0x083184dc, sLevelLayoutDispatch_3181BC (back-ref to _31813C) + sLevelLayoutSectionTable_3181C4 (7 section ptrs) + sLevelLayoutOffsets_3181E0 (191 monotonic offsets) */
        asm/text/text_0x083184dc.o(.text);  /* 0x083184dc - 0x08320000, raw bytes */
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
        asm/text/text_0x083d0000.o(.text);  /* 0x083d0000 - 0x083dda1c, raw bytes */
        src/data/sound_tables.o(.rodata);  /* 0x083dda1c - 0x083dda4c, sChannelFreqRegTable + sChannelRegTable + sWaveVolLut */
        src/data/sound_instruments.o(.rodata);  /* 0x083dda4c - 0x083ddadc, sDefaultSquareWaveInstr + sDefaultSquareWavePcm */
        src/data/sound_pitch.o(.rodata);  /* 0x083ddadc - 0x083ddcdc, sNoteRatioTable + sInversePitchTable */
        src/data/sound_opcode_handlers.o(.rodata);  /* 0x083ddcdc - 0x083dddb4, sSoundOpcodeHandlers */
        asm/text/text_0x083dddb4.o(.text);  /* 0x083dddb4 - 0x083e0000, raw bytes (all 0xff padding) */
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
