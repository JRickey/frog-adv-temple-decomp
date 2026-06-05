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

/* ROM dispatch table at 0x08308028 (inside the sprite_anim_block blob).
 * Indexed by a 3-step cycle counter (gGameStuff._step24) in sub_0801793C —
 * entries 0..8 are Thumb function pointers to the set-game-mode handlers
 * (sub_08000918, sub_08000EB8, ...). Linker-assigned so agbcc loads the
 * table base into r1 before the index shift, matching baserom pool order. */
gHandlerTable_08308028 = 0x08308028;
gScriptPtrTable_08307fec = 0x08307FEC;
gFrameCellTable_08307EAC = 0x08307EAC;
gScriptPtrTable_08308164 = 0x08308164;
gScriptPtrTable_083081A0 = 0x083081A0;
sLevelLayoutPtrs_308698 = 0x08308698;
sRoomDmaTable_080C1254 = 0x080C1254;

/* State-handler dispatch table, currently inside the sSpriteAnimBlock_07104
 * INCBIN blob. Surfaced as a linker-assigned absolute symbol so a C
 * function-pointer array operand becomes a relocation rather than a
 * compile-time constant — this is what makes agbcc load the table base
 * before the (absolute) index base, matching baserom's pool/register order
 * in sub_08019540. See docs/codegen-notes.md "Adjacent IWRAM bases" (the
 * same defeat-the-fold principle, applied to a ROM data table). Promote to
 * a real extracted array when the dispatcher cluster is named. */
gStateHandlers_0830804C = 0x0830804C;


/* Sprite animation descriptor instances within the sSpriteAnimBlock_06838 blob.
 * Both at offset 0x5d0 / 0x5f0 into the block (addresses 0x08306e08 / 0x08306e28).
 * Linker-assigned so agbcc emits two separate pool loads instead of folding
 * the adjacent compile-time constants into a single base+offset computation.
 * Promote to real typed C symbols once the consumer cluster is fully named. */
sAnimDesc_6e08 = 0x08306e08;
sAnimDesc_6e28 = 0x08306e28;

/* Blit parameter table used by sub_08011478: 24-byte records with
 * dstX/dstY/width/rows/flags + srcTable pointer. Two separate linker-assigned
 * symbols (base and base+16) so agbcc emits distinct pool entries — prevents
 * CSE-fold of the adjacent ROM addresses into a single base+offset load. */
gBlitParamTable_08306b74 = 0x08306b74;
gBlitInitTable_08306AD4 = 0x08306AD4;
gBlitSrcTable_08306b84 = 0x08306b84;
gTileBlitTable_08306840 = 0x08306840;
gDmaDescTable_08306888 = 0x08306888;

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
        . = 0x00000000; gIwram_0000 = .;
        . = 0x00003432; gIwram_3432 = .;
        . = 0x00003434; gIwram_3434 = .;
        . = 0x00003470; gIwram_3470 = .;
        . = 0x00003474; gIwram_3474 = .;
        . = 0x00003478; gIwram_3478 = .;
        . = 0x00003480; gIwram_3480 = .;
        . = 0x000034A0; gIwram_34A0 = .;
        . = 0x000034B0; gIwram_34B0 = .;
        . = 0x000034B4; gIwram_34B4 = .;
        . = 0x000034B8; gIwram_34B8 = .;
        . = 0x000034C0; gIwram_34C0 = .;
        . = 0x000034D0; gIwram_34D0 = .;
        . = 0x00003500; gSaveData = .;
        . = 0x00003550; gIwram_3550 = .;
        . = 0x00003570; gIwram_3570 = .;
        . = 0x00003574; gIwram_3574 = .;
        . = 0x000035E0; gIwram_35E0 = .;
        . = 0x00003608; gIwram_3608 = .;
        . = 0x00003610; gIwram_3610 = .;
        . = 0x00003710; gIwram_3710 = .;
        . = 0x00003720; gEntities_03003720 = .; gEntities = .;
        . = 0x00005320; gIwram_5320 = .;
        . = 0x00005328; gIwram_5328 = .;
        . = 0x00005330; gIwram_5330 = .;
        . = 0x00005358; gIwram_5358 = .;
        . = 0x00005360; gIwram_5360 = .;
        . = 0x00005398; gIwram_5398 = .;
        . = 0x000053A0; gIwram_53A0 = .;
        . = 0x0000549F; gIwram_549F = .;
        . = 0x000060A0; gIwram_60A0 = .;
        . = 0x00006110; gIwram_6110 = .;
        . = 0x00006150; gIwram_6150 = .;
        . = 0x00006160; gEntityIndex_03006160 = .;
        . = 0x00006400; gIwram_6400 = .;
        . = 0x00006410; gIwram_6410 = .;
        . = 0x00006420; gUnk03006420 = .;
        . = 0x00006480; gIwram_6480 = .;
        . = 0x000064C0; gIwram_64C0 = .;
        . = 0x00006500; gIwram_6500 = .;
        . = 0x00006540; gIwram_6540 = .;
        . = 0x00006580; gIwram_6580 = .;
    } >iwram

    /* ROM dispatch table at 0x08308058 (a sub-region of the
     * sSpriteAnimBlock_07104 blob, not yet broken out as its own data
     * symbol). Declared as a linker-assigned symbol so agbcc treats it as
     * an opaque address — keeps its pool load ahead of the gIwram_3480
     * index read, matching the baserom. Shared by sub_08019540 /
     * sub_08019560. See docs/codegen-notes.md "Adjacent IWRAM bases". */
    gHandlerTable_08308058 = 0x08308058;

    /* ROM dispatch table at 0x0830806c (also inside the sprite_anim_block
     * blob, just past gHandlerTable_08308058). Linker-assigned so its pool
     * load precedes the gIwram_3480 index read, matching the baserom register/
     * pool order in sub_08019500's dispatchIdx==0 branch — same idiom as
     * gHandlerTable_08308058 above. */
    gHandlerTable_0830806C = 0x0830806C;

    /* ROM dispatch table at 0x08308ac8 (same sprite_dma_records blob).
     * Linker-assigned so its pool load precedes the gIwram_34A0 index read,
     * matching the baserom register/pool order in sub_080201A8 — the same
     * idiom as gHandlerTable_08308058 above. */
    gDispatchTable_08308AC8 = 0x08308AC8;

    /* ROM source pointer tables used by sub_0801D33C. Linker-assigned so
     * agbcc keeps the table-A base as an opaque relocation in r2, matching
     * the baserom's DMA3 setup sequence. */
    gFrogTileSrcA_083087C8 = 0x083087C8;
    gFrogPaletteSrcB_083087E8 = 0x083087E8;

    /* ROM dispatch table at 0x08308ad4 (also inside the sprite_dma_records
     * blob; not yet broken out). Linker-assigned for the same reason as
     * gHandlerTable_08308058 — keeps its pool load ahead of the gIwram_3480
     * index read. Indexed by gIwram_3480._data[2] in sub_080201C8. */
    gHandlerTable_08308AD4 = 0x08308AD4;

    /* ROM dispatch table at 0x08308ae0 (also inside the sprite_dma_records
     * blob; not yet broken out). Linker-assigned for the same reason as
     * gHandlerTable_08308AD4 — keeps its pool load ahead of the gIwram_3480
     * index read. Indexed by gIwram_3480._data[2] in sub_080201E8. */
    gHandlerTable_08308AE0 = 0x08308AE0;

    /* ROM dispatch table at 0x08308aec (also inside the sprite_dma_records
     * blob; not yet broken out). Linker-assigned for the same reason as
     * gHandlerTable_08308AD4 — keeps its pool load ahead of the gIwram_3480
     * index read. Indexed by gIwram_3480._data[2] in sub_080202A8. */
    gHandlerTable_08308AEC = 0x08308AEC;

    .text : ALIGN(4) {
        asm/disasm_0x08000000.o(.text);  /* 0x08000000 - 0x08000004, entry branch */
        asm/header.o(.text);             /* 0x08000004 - 0x080000BF, header */
        asm/disasm_0x080000c0.o(.text);  /* 0x080000c0 - 0x080000fc, _start */
        asm/disasm_0x080000fc.o(.text);  /* 0x080000fc - 0x08000114, IntrEnable */
        asm/disasm_0x08000114.o(.text);  /* 0x08000114 - 0x0800012c, IntrDisable */
        asm/disasm_0x0800012c.o(.text);  /* 0x0800012c - 0x08000240, IntrMain */
        src/system/sub_08000240.o(.text);  /* 0x08000240 - 0x080002a4, sub_08000240 (NAKED + NON_MATCHING; ARM-mode, CPSR manip) */
        src/system/agb_main.o(.text);    /* 0x080002a4 - 0x08000430, AgbMain */
        src/system/init1.o(.text);       /* 0x08000430 - 0x0800072c, sub_08000430 (Init1) + sub_080004C4 + sub_080005D8 + sub_08000678 */
        src/system/init.o(.text);        /* 0x0800072c - 0x08000820, sub_0800072C + sub_08000764 + sub_08000790 */
        src/game/sub_08000820.o(.text);  /* 0x08000820 - 0x0800088c, sub_08000820 + sub_08000884/sub_08000888 stubs */
        src/game/sub_0800088c.o(.text);  /* 0x0800088c - 0x080008dc, sub_0800088C */
        src/system/vblank.o(.text);      /* 0x080008dc - 0x0800090c, sub_080008DC + sub_08000900 */
        asm/text/text_0x0800090c.o(.text);  /* 0x0800090c - 0x08000918, raw bytes */
        src/system/sub_08000918.o(.text);  /* 0x08000918 - 0x08000b6c, sub_08000918 (NAKED + NON_MATCHING; mode-X cluster mov-pc-rN dispatcher) */
        src/system/sub_08000b6c.o(.text);  /* 0x08000b6c - 0x08000c98, sub_08000B6C (NAKED + NON_MATCHING; high-register pins on sl/r8/r9) */
        src/system/sub_08000c98.o(.text);  /* 0x08000c98 - 0x08000cec, sub_08000C98 + sub_08000CB0 */
        src/system/sub_08000cec.o(.text);  /* 0x08000cec - 0x08000d2c, sub_08000CEC */
        src/system/sub_08000d2c.o(.text);  /* 0x08000d2c - 0x08000d50, sub_08000D2C */
        src/system/sub_08000d50.o(.text);  /* 0x08000d50 - 0x08000e0c, sub_08000D50 + sub_08000D5C */
        src/system/sub_08000e0c.o(.text);  /* 0x08000e0c - 0x08000eb8, sub_08000E0C */
        src/system/sub_08000eb8.o(.text);  /* 0x08000eb8 - 0x08001128, sub_08000EB8 (NAKED + NON_MATCHING; mode-9 dispatch — `mov pc, rN` jump table, sibling of sub_08002844) */
        src/system/sub_08001128.o(.text);  /* 0x08001128 - 0x080011a4, sub_08001128 / sub_08001140 / sub_08001174 / sub_08001198 cluster */
        src/game/sub_080011a4.o(.text);    /* 0x080011a4 - 0x08001214, sub_080011A4 */
        src/game/sub_08001214.o(.text);  /* 0x08001214 - 0x08001478, sub_08001214 (mode-10 handler) */
        src/game/set_game_mode_03.o(.text);  /* 0x08001478 - 0x08001484, SetGameMode_03 */
        src/game/sub_08001484.o(.text);  /* 0x08001484 - 0x080014b8, sub_08001484 */
        src/game/sub_080014b8.o(.text);  /* 0x080014b8 - 0x08001508, sub_080014B8, sub_080014E4, sub_080014F0 */
        src/system/sub_08001508.o(.text);  /* 0x08001508 - 0x080017a8, sub_08001508 (mode-11 handler) + sub_08001794 */
        src/game/sub_080017a8.o(.text);  /* 0x080017a8 - 0x080018f8, sub_080017A8 + sub_080017DC + sub_08001850 + sub_0800189C + sub_080018A8 */
        src/game/sub_080018f8.o(.text);  /* 0x080018f8 - 0x080019b4, sub_080018F8 */
        src/game/sub_080019b4.o(.text);  /* 0x080019b4 - 0x08001d18, sub_080019B4 (mode-12 handler) + sub_08001CEC */
        src/game/sub_08001d18.o(.text);  /* 0x08001d18 - 0x08001d54, sub_08001D18 */
        src/game/sub_08001d54.o(.text);  /* 0x08001d54 - 0x08001d94, sub_08001D54 */
        src/game/sub_08001d94.o(.text);  /* 0x08001d94 - 0x08001e18, sub_08001D94 */
        src/game/sub_08001e18.o(.text);  /* 0x08001e18 - 0x08001e24, sub_08001E18 */
        src/game/sub_08001e24.o(.text);
        asm/disasm_0x08001e24.o(.text);  /* 0x08001e24 - 0x08002184, sub_08001E24 (auto-peeled) */
        src/game/sub_08002184.o(.text);  /* 0x08002184 - 0x08002444, sub_08002184 (mode-13 handler) */
        src/game/game_mode.o(.text);     /* 0x08002444 - 0x08002450, SetGameMode_06 */
        src/game/sub_08002450.o(.text);
        asm/text/text_0x08002518.o(.text);  /* 0x08002518 - 0x08002524, raw bytes */
        src/game/sub_08002524.o(.text);  /* 0x08002524 - 0x08002760, sub_08002524 (mode-14 handler) */
        src/game/set_game_mode_07.o(.text);  /* 0x08002760 - 0x0800276c, SetGameMode_07 */
        src/game/sub_0800276c.o(.text);  /* 0x0800276c - 0x08002844, sub_0800276C + sub_080027A0 + sub_080027F0 + sub_08002808 + sub_08002814 */
        src/game/mode_15.o(.text);       /* 0x08002844 - 0x08002a5c, sub_08002844 (mode-15 handler) */
        src/game/set_game_mode_08.o(.text);  /* 0x08002a5c - 0x08002a68, SetGameMode_08 */
        src/game/sub_08002a68.o(.text);  /* 0x08002a68 - 0x08002adc, sub_08002A68 + sub_08002A9C + sub_08002AC4 */
        asm/text/text_0x08002adc.o(.text);  /* 0x08002adc - 0x08002ae8, raw bytes */
        src/game/sub_08002ae8.o(.text);  /* 0x08002ae8 - 0x08002b58, sub_08002AE8 */
        src/game/sub_08002b58.o(.text);  /* 0x08002b58 - 0x08002e04, sub_08002B58 */
        src/game/set_game_mode_09.o(.text);  /* 0x08002e04 - 0x08002e10, SetGameMode_09 */
        src/game/sub_08002e10.o(.text);  /* 0x08002e10 - 0x08002ee8, sub_08002E10, sub_08002E44, sub_08002E94, sub_08002EAC, sub_08002EB8 */
        src/game/sub_08002ee8.o(.text);
        asm/disasm_0x08002ee8.o(.text);  /* 0x08002ee8 - 0x080031d4, sub_08002EE8 (auto-peeled) */
        src/game/sub_080031d4.o(.text);  /* 0x080031d4 - 0x08003254, sub_080031D4 */
        src/game/sub_08003254.o(.text);
        src/game/sub_0800336c.o(.text);  /* 0x0800336c - 0x08003668, sub_0800336C + sub_08003584 + sub_0800359C + sub_080035D0 + sub_080035F8 + sub_08003604 */
        src/game/sub_08003668.o(.text);  /* 0x08003668 - 0x08003864, sub_08003668 */
        src/game/sub_08003864.o(.text);
        asm/disasm_0x08003864.o(.text);  /* 0x08003864 - 0x08003b40, sub_08003864 (auto-peeled) */
        src/game/sub_08003b40.o(.text);
        src/game/sub_08003b8c.o(.text);  /* 0x08003b8c - 0x08003bfc, sub_08003B8C */
        src/game/sub_08003bfc.o(.text);  /* 0x08003bfc - 0x08003c38, sub_08003BFC */
        src/game/sub_08003c38.o(.text);  /* 0x08003c38 - 0x08003c9c, sub_08003C38 */
        asm/text/text_0x08003c9c.o(.text);  /* 0x08003c9c - 0x08003ca8, raw bytes */
        src/game/sub_08003ca8.o(.text);
        asm/disasm_0x08003ca8.o(.text);  /* 0x08003ca8 - 0x08004074, sub_08003CA8 (auto-peeled) */
        src/game/set_game_mode_12.o(.text);  /* 0x08004074 - 0x08004080, SetGameMode_12 */
        src/game/sub_08004080.o(.text);
        src/game/sub_080040c4.o(.text);
        src/game/sub_0800411c.o(.text);
        asm/disasm_0x0800411c.o(.text);  /* 0x0800411c - 0x0800441c, sub_0800411C (auto-peeled) */
        src/game/sub_0800441c.o(.text);
        src/game/sub_08004470.o(.text);
        src/game/sub_08004508.o(.text);  /* 0x08004508 - 0x080045e0, sub_08004508 + sub_08004588 */
        asm/text/text_0x080045e0.o(.text);  /* 0x080045e0 - 0x080045ec, raw bytes */
        src/game/sub_080045ec.o(.text);
        asm/disasm_0x080045ec.o(.text);  /* 0x080045ec - 0x08004938, sub_080045EC (auto-peeled) */
        src/game/sub_08004938.o(.text);
        src/game/sub_08004c04.o(.text);  /* 0x08004c04 - 0x08004fac, sub_08004C04 + sub_08004C30 + sub_08004C64 + sub_08004CA4 + sub_08004D04 + sub_08004D10 */
        src/game/sub_08004fac.o(.text);
        asm/disasm_0x08004fac.o(.text);  /* 0x08004fac - 0x080052c0, sub_08004FAC (auto-peeled) */
        src/game/set_game_mode_15.o(.text);  /* 0x080052c0 - 0x080052cc, SetGameMode_15 */
        src/game/sub_080052cc.o(.text);
        src/game/sub_08005308.o(.text);
        src/game/sub_0800534c.o(.text);
        src/game/sub_080054a8.o(.text);
        asm/disasm_0x080054a8.o(.text);  /* 0x080054a8 - 0x0800586c, sub_080054A8 (auto-peeled) */
        src/game/sub_0800586c.o(.text);
        src/game/sub_080059b0.o(.text);
        src/game/sub_080059c4.o(.text);
        asm/disasm_0x080059c4.o(.text);  /* 0x080059c4 - 0x08005d10, sub_080059C4 (auto-peeled) */
        src/game/sub_08005d10.o(.text);
        asm/disasm_0x08005d10.o(.text);  /* 0x08005d10 - 0x08005ed8, sub_08005D10 (auto-peeled) */
        src/game/sub_08005ed8.o(.text);
        src/game/sub_08005fc8.o(.text);
        asm/disasm_0x08005fc8.o(.text);  /* 0x08005fc8 - 0x080063ec, sub_08005FC8 (auto-peeled) */
        src/game/sub_080063ec.o(.text);
        asm/disasm_0x080063ec.o(.text);  /* 0x080063ec - 0x0800658c, sub_080063EC (auto-peeled) */
        src/game/mode_control.o(.text);  /* 0x0800658c - 0x08006600, ModeControl_Init */
        src/game/sub_08006600.o(.text);  /* 0x08006600 - 0x080066c4, sub_08006600 */
        src/game/sub_080066c4.o(.text);  /* 0x080066c4 - 0x0800679c, sub_080066C4 */
        src/game/sub_0800679c.o(.text);  /* 0x0800679c - 0x0800690c, sub_0800679C + sub_08006830 */
        src/game/sub_0800690c.o(.text);  /* 0x0800690c - 0x08006948, sub_0800690C + sub_0800693C */
        src/game/sub_08006948.o(.text);  /* 0x08006948 - 0x08006a0c, sub_08006948 + sub_08006958 + sub_0800696C + sub_080069BC */
        src/game/sub_08006a0c.o(.text);  /* 0x08006a0c - 0x08006a74, sub_08006A0C */
        src/game/sub_08006a74.o(.text);  /* 0x08006a74 - 0x08006adc, sub_08006A74 + sub_08006AAC + sub_08006AB8 */
        src/game/sub_08006adc.o(.text);  /* 0x08006adc - 0x08006b64, sub_08006ADC + sub_08006AFC + sub_08006B20 + sub_08006B40 */
        src/game/sub_08006b64.o(.text);  /* 0x08006b64 - 0x08006b88, sub_08006B64 */
        src/game/sub_08006b88.o(.text);  /* 0x08006b88 - 0x08006fec, sub_08006B88 + sub_08006B94 + sub_08006BA4 + sub_08006BB4 + sub_08006D24 + sub_08006E8C */
        asm/disasm_0x080070a0.o(.text);  /* 0x080070a0 - 0x08007138, sub_080070A0 (auto-peeled) */
        src/game/sub_08007138.o(.text);
        src/game/sub_08007228.o(.text);  /* 0x08007228 - 0x0800736c, sub_08007228 + sub_080072E0 */
        asm/disasm_0x0800736c.o(.text);  /* 0x0800736c - 0x08007660, sub_0800736C (auto-peeled) */
        src/game/sub_08007660.o(.text);  /* 0x08007660 - 0x080076a4, sub_08007660 */
        src/game/sub_080076a4.o(.text);
        src/game/sub_080077ac.o(.text);  /* 0x080077ac - 0x08007874, sub_080077AC */
        src/game/sub_08007874.o(.text);
        src/game/sub_0800793c.o(.text);
        asm/disasm_0x0800793c.o(.text);  /* 0x0800793c - 0x08007dd0, sub_0800793C (auto-peeled) */
        src/game/sub_08007dd0.o(.text);
        src/game/sub_08008174.o(.text);
        asm/disasm_0x08008174.o(.text);  /* 0x08008174 - 0x08008570, sub_08008174 (auto-peeled) */
        src/game/sub_08008570.o(.text);
        src/game/sub_080087b4.o(.text);
        asm/disasm_0x080089a4.o(.text);  /* 0x080089a4 - 0x08008a5c, sub_080089A4 (auto-peeled) */
        src/game/sub_08008a5c.o(.text);
        asm/disasm_0x08008a5c.o(.text);  /* 0x08008a5c - 0x08008e84, sub_08008A5C (auto-peeled) */
        src/game/sub_08008e84.o(.text);  /* 0x08008e84 - 0x08008f98, sub_08008E84 */
        src/game/sub_08008f98.o(.text);
        src/game/sub_080090b0.o(.text);  /* 0x080090b0 - 0x08009188, sub_080090B0, sub_080090FC, sub_08009140 */
        src/engine/sub_08009188.o(.text);
        asm/disasm_0x08009188.o(.text);  /* 0x08009188 - 0x080094f8, sub_08009188 (auto-peeled) */
        src/engine/sub_080094f8.o(.text);
        asm/disasm_0x080094f8.o(.text);  /* 0x080094f8 - 0x080097fc, sub_080094F8 (auto-peeled) */
        src/engine/sub_080097fc.o(.text);
        src/engine/sub_08009884.o(.text);  /* 0x08009884 - 0x08009984, sub_08009884 */
        src/game/sub_08009984.o(.text);  /* 0x08009984 - 0x08009ba0, sub_08009984 + sub_08009A58 */
        src/game/sub_08009ba0.o(.text);  /* 0x08009ba0 - 0x08009d9c, sub_08009BA0 + sub_08009C14 + sub_08009CBC */
        src/game/sub_08009d9c.o(.text);  /* 0x08009d9c - 0x0800a05c, sub_08009D9C (NAKED+NON_MATCHING) + sub_08009EEC */
        src/engine/sub_0800a05c.o(.text);  /* 0x0800a05c - 0x0800a104, sub_0800A05C (NAKED+NON_MATCHING) */
        src/engine/sub_0800a104.o(.text);  /* 0x0800a104 - 0x0800a1c8, sub_0800A104 + sub_0800A158 */
        src/engine/sub_0800a1c8.o(.text);  /* 0x0800a1c8 - 0x0800a2d8, sub_0800A1C8, sub_0800A214, sub_0800A258, sub_0800A26C */
        src/game/dispatch_helpers.o(.text);  /* 0x0800a2d8 - 0x0800a458, sub_0800A2D8, sub_0800A328, sub_0800A3A4, sub_0800A3D0 */
        src/engine/sub_0800a4d0.o(.text);  /* 0x0800a4d0 - 0x0800a520, sub_0800A4D0 */
        src/game/sub_0800a520.o(.text);  /* 0x0800a520 - 0x0800a710, sub_0800A520 + sub_0800A540 + sub_0800A580 */
        src/engine/sub_0800a710.o(.text);  /* 0x0800a710 - 0x0800a83c, sub_0800A710, sub_0800A7A8 */
        src/engine/sub_0800a83c.o(.text);  /* 0x0800a83c - 0x0800a910, sub_0800A83C */
        src/engine/sub_0800a9d4.o(.text);  /* 0x0800a9d4 - 0x0800aa70, sub_0800A9D4 */
        src/engine/sub_0800aa70.o(.text);  /* 0x0800aa70 - 0x0800ab84, sub_0800AA70 */
        src/engine/sub_0800ab84.o(.text);  /* 0x0800ab84 - 0x0800af50, sub_0800AB84/sub_0800AC44/sub_0800ACE8/sub_0800AE3C */
        src/engine/sub_0800af50.o(.text);  /* 0x0800af50 - 0x0800b178, sub_0800AF50/sub_0800B07C */
        asm/disasm_0x0800b178.o(.text);  /* 0x0800b178 - 0x0800b7b0, sub_0800B178 (auto-peeled) */
        src/engine/sub_0800b7b0.o(.text);
        src/engine/sub_0800b8a8.o(.text);  /* 0x0800b8a8 - 0x0800b918, sub_0800B8A8 */
        src/engine/sub_0800b918.o(.text);
        asm/disasm_0x0800b918.o(.text);  /* 0x0800b918 - 0x0800be18, sub_0800B918 (auto-peeled) */
        src/engine/sub_0800be18.o(.text);  /* 0x0800be18 - 0x0800bf24, sub_0800BE18 / sub_0800BEBC */
        src/engine/sub_0800bf24.o(.text);
        asm/disasm_0x0800bf24.o(.text);  /* 0x0800bf24 - 0x0800c2a8, sub_0800BF24 (auto-peeled) */
        src/engine/sub_0800c2a8.o(.text);  /* 0x0800c2a8 - 0x0800c358, sub_0800C2A8, sub_0800C2D0 */
        src/engine/sub_0800c358.o(.text);  /* 0x0800c358 - 0x0800c444, sub_0800C358, sub_0800C3E4 */
        src/engine/sub_0800c444.o(.text);  /* 0x0800c444 - 0x0800c4a0, sub_0800C444 */
        src/engine/sub_0800c4a0.o(.text);  /* 0x0800c4a0 - 0x0800c4e8, sub_0800C4A0 / sub_0800C4E0 / sub_0800C4E4 */
        src/engine/sub_0800c4e8.o(.text);
        asm/disasm_0x0800c4e8.o(.text);  /* 0x0800c4e8 - 0x0800c978, sub_0800C4E8 (auto-peeled) */
        src/engine/sub_0800c978.o(.text);
        src/engine/sub_0800cb80.o(.text);  /* 0x0800cb80 - 0x0800cd88, sub_0800CB80/sub_0800CBE8 and sibling grid writers */
        src/engine/sub_0800cd88.o(.text);
        src/engine/sub_0800cdcc.o(.text);
        src/engine/sub_0800ce10.o(.text);
        src/engine/sub_0800ce54.o(.text);
        src/engine/sub_0800ce98.o(.text);
        asm/disasm_0x0800ced0.o(.text);  /* 0x0800ced0 - 0x0800cfdc, sub_0800CED0 (auto-peeled) */
        src/engine/sub_0800cfdc.o(.text);
        src/engine/sub_0800d028.o(.text);
        src/engine/sub_0800d0f8.o(.text);
        src/engine/sub_0800d1f8.o(.text);  /* 0x0800d1f8 - 0x0800d270, sub_0800D1F8 */
        src/engine/sub_0800d270.o(.text);
        src/engine/sub_0800d2c0.o(.text);
        asm/disasm_0x0800d2c0.o(.text);  /* 0x0800d2c0 - 0x0800d450, sub_0800D2C0 (auto-peeled) */
        src/engine/sub_0800d450.o(.text);
        asm/disasm_0x0800d450.o(.text);  /* 0x0800d450 - 0x0800d808, sub_0800D450 (auto-peeled) */
        src/engine/sub_0800d808.o(.text);  /* 0x0800d808 - 0x0800d8a0, sub_0800D808 */
        src/engine/sub_0800d8a0.o(.text);  /* 0x0800d8a0 - 0x0800d9fc, sub_0800D8A0, sub_0800D924, sub_0800D9C8 */
        src/engine/sub_0800d9fc.o(.text);
        asm/disasm_0x0800dab8.o(.text);  /* 0x0800db04 - 0x0800dc3c, sub_0800DB04 cluster (auto-peeled) */
        asm/text/text_0x0800dc3c.o(.text);  /* 0x0800dc3c - 0x0800dc50, raw bytes */
        src/engine/sub_0800dc50.o(.text);
        asm/disasm_0x0800dc50.o(.text);  /* 0x0800dc50 - 0x0800dd80, sub_0800DC50 (auto-peeled) */
        src/engine/sub_0800dd80.o(.text);  /* 0x0800dd80 - 0x0800de0c, sub_0800DD80 */
        src/engine/sub_0800de80.o(.text);  /* 0x0800de80 - 0x0800df7c, sub_0800DE80 */
        src/engine/sub_0800df7c.o(.text);  /* 0x0800df7c - 0x0800dffc, sub_0800DF7C, sub_0800DF9C, sub_0800DFAC */
        src/engine/sub_0800dffc.o(.text);  /* 0x0800dffc - 0x0800e048, sub_0800DFFC, sub_0800E014, sub_0800E030 */
        src/engine/sub_0800e048.o(.text);
        src/engine/sub_0800e060.o(.text);  /* 0x0800e060 - 0x0800e174, sub_0800E060 */
        asm/disasm_0x0800e174.o(.text);  /* 0x0800e174 - 0x0800e4bc, sub_0800E174 (auto-peeled) */
        src/engine/sub_0800e4bc.o(.text);
        asm/disasm_0x0800e4bc.o(.text);  /* 0x0800e4bc - 0x0800e600, sub_0800E4BC (peeled) */
        src/engine/sub_0800e600.o(.text);  /* 0x0800e600 - 0x0800e6a8, sub_0800E600 */
        src/engine/sub_0800e6a8.o(.text);  /* 0x0800e6a8 - 0x0800e85c, sub_0800E6A8 + text_0800e76c + sub_0800E7D4 */
        src/engine/sub_0800e85c.o(.text);
        asm/disasm_0x0800e85c.o(.text);  /* 0x0800e85c - 0x0800eb1c, sub_0800E85C (auto-peeled) */
        src/engine/sub_0800eb1c.o(.text);  /* 0x0800eb1c - 0x0800ebdc, sub_0800EB1C */
        src/engine/sub_0800ebdc.o(.text);
        asm/disasm_0x0800ebdc.o(.text);  /* 0x0800ebdc - 0x0800ee34, sub_0800EBDC (auto-peeled) */
        src/engine/sub_0800ee34.o(.text);  /* 0x0800ee34 - 0x0800ee94, sub_0800EE34 */
        src/engine/sub_0800ee94.o(.text);  /* 0x0800ee94 - 0x0800ef58, sub_0800EE94 + sub_0800EEE8 */
        src/engine/sub_0800ef58.o(.text);  /* 0x0800ef58 - 0x0800ef90, sub_0800EF58 */
        src/engine/sub_0800ef90.o(.text);  /* 0x0800ef90 - 0x0800f014, sub_0800EF90 + sub_0800EFC8 + sub_0800EFF4 */
        src/engine/sub_0800f014.o(.text);  /* 0x0800f014 - 0x0800f24c, sub_0800F014 + sub_0800F114 + sub_0800F22C */
        src/engine/sub_0800f24c.o(.text);
        src/engine/sub_0800f2f8.o(.text);
        src/engine/sub_0800f398.o(.text);
        asm/disasm_0x0800f398.o(.text);  /* 0x0800f398 - 0x0800f814, sub_0800F398 (auto-peeled) */
        src/engine/sub_0800f814.o(.text);
        asm/disasm_0x0800f814.o(.text);  /* 0x0800f814 - 0x0800fcc8, sub_0800F814 (auto-peeled) */
        src/engine/sub_0800fcc8.o(.text);
        src/engine/sub_0800fd50.o(.text);  /* 0x0800fd50 - 0x0800fe10, sub_0800FD50 (extended-pool range; 7 trailing words land in .o pool) */
        src/engine/sub_0800fe88.o(.text);
        asm/disasm_0x0800fe88.o(.text);  /* 0x0800fe88 - 0x080100e4, sub_0800FE88 (auto-peeled) */
        src/engine/sub_080100e4.o(.text);
        asm/disasm_0x080100e4.o(.text);  /* 0x080100e4 - 0x0801025c, sub_080100E4 (auto-peeled) */
        src/engine/sub_0801025c.o(.text);
        asm/disasm_0x0801025c.o(.text);  /* 0x0801025c - 0x080105b0, sub_0801025C (auto-peeled) */
        src/engine/sub_080105b0.o(.text);
        asm/disasm_0x080105b0.o(.text);  /* 0x080105b0 - 0x08010694, sub_080105B0 (auto-peeled) */
        src/engine/sub_08010694.o(.text);
        src/engine/sub_080106b8.o(.text);  /* 0x080106b8 - 0x08010958, sub_080106B8 + sub_080106EC + sub_08010710 + sub_08010740 + sub_08010778 + sub_080107D0 + sub_08010870 + sub_0801089C + sub_080108F8 */
        src/engine/sub_08010958.o(.text);
        asm/disasm_0x08010958.o(.text);  /* 0x08010958 - 0x08010a44, sub_08010958 (auto-peeled) */
        src/engine/sub_08010a44.o(.text);
        asm/disasm_0x08010a44.o(.text);  /* 0x08010a44 - 0x08010dd8, sub_08010A44 (auto-peeled) */
        src/engine/sub_08010dd8.o(.text);
        asm/disasm_0x08010dd8.o(.text);  /* 0x08010dd8 - 0x08010f64, sub_08010DD8 (auto-peeled) */
        src/engine/sub_08010f64.o(.text);
        asm/disasm_0x08010f64.o(.text);  /* 0x08010f64 - 0x08011288, sub_08010F64 (auto-peeled) */
        asm/text/text_0x08011288.o(.text);  /* 0x08011288 - 0x0801129c, raw bytes */
        src/engine/sub_0801129c.o(.text);  /* 0x0801129c - 0x080112c0, sub_0801129C */
        src/engine/sub_080112c0.o(.text);  /* 0x080112c0 - 0x080113e8, sub_080112C0 */
        src/engine/sub_080113e8.o(.text);  /* 0x080113e8 - 0x08011574, sub_080113E8 + sub_08011478 + sub_08011518 */
        src/engine/sub_08011574.o(.text);  /* 0x08011574 - 0x080116b8, sub_08011574 + sub_080115F8 */
        asm/disasm_0x080116b8.o(.text);  /* 0x080116b8 - 0x0801185c, sub_080116B8 (peeled) */
        src/engine/sub_0801185c.o(.text);  /* 0x0801185c - 0x08011984, sub_0801185C + sub_08011884 + sub_080118D8 + sub_080118FC + sub_0801190C + sub_08011978 */
        asm/disasm_0x08011984.o(.text);  /* 0x08011984 - 0x08011aa4, sub_08011984 (auto-peeled) */
        src/engine/sub_08011aa4.o(.text);
        asm/disasm_0x08011aa4.o(.text);  /* 0x08011aa4 - 0x08011e40, sub_08011AA4 (auto-peeled) */
        src/engine/sub_08011e40.o(.text);
        asm/disasm_0x08011e40.o(.text);  /* 0x08011e40 - 0x08012098, sub_08011E40 (auto-peeled) */
        src/engine/sub_08012098.o(.text);  /* 0x08012098 - 0x0801223c, sub_08012098 + sub_08012100 + sub_08012180 */
        src/engine/sub_0801223c.o(.text);  /* 0x0801223c - 0x080122e4, sub_0801223C */
        asm/disasm_0x080122e4.o(.text);  /* 0x080122e4 - 0x0801254c, sub_080122E4 (auto-peeled) */
        src/engine/sub_0801254c.o(.text);
        src/engine/sub_0801255c.o(.text);
        asm/text/text_0x080125b0.o(.text);  /* 0x080125b0 - 0x080125ec, raw bytes */
        src/engine/sub_080125ec.o(.text);
        src/engine/sub_08012604.o(.text);
        src/engine/sub_08012664.o(.text);
        asm/disasm_0x08012664.o(.text);  /* 0x08012798 - 0x0801288c, sub_08012798 (auto-peeled) */
        src/engine/sub_0801288c.o(.text);
        asm/disasm_0x0801288c.o(.text);  /* 0x0801288c - 0x0801297c, sub_0801288C (auto-peeled) */
        src/engine/sub_0801297c.o(.text);
        asm/disasm_0x0801297c.o(.text);  /* 0x0801297c - 0x08012a6c, sub_0801297C (auto-peeled) */
        src/engine/sub_08012a6c.o(.text);
        asm/disasm_0x08012a6c.o(.text);  /* 0x08012a6c - 0x08012b38, sub_08012A6C (force-peeled) */
        src/engine/sub_08012b38.o(.text);  /* 0x08012b38 - 0x08012bb4, sub_08012B38 + sub_08012B5C + sub_08012B78 */
        asm/text/text_0x08012bb4.o(.text);  /* 0x08012bb4 - 0x08012bc4, raw bytes */
        src/engine/sub_08012bc4.o(.text);  /* 0x08012bc4 - 0x08012cac, sub_08012BC4 */
        src/engine/sub_08012cac.o(.text);
        src/engine/sub_08012d40.o(.text);
        src/engine/sub_08012d88.o(.text);
        src/engine/sub_08012e64.o(.text);
        src/engine/sub_08012f00.o(.text);  /* 0x08012f00 - 0x08012fa0, sub_08012F00 */
        src/engine/sub_08012fa0.o(.text);  /* 0x08012fa0 - 0x08013040, sub_08012FA0 */

        src/engine/sub_08013040.o(.text);  /* 0x08013040 - 0x0801310c, sub_08013040 */
        src/engine/sub_0801310c.o(.text);
        asm/disasm_0x0801310c.o(.text);  /* 0x0801310c - 0x080132e8, sub_0801310C (auto-peeled) */
        src/engine/sub_080132e8.o(.text);
        asm/disasm_0x080132e8.o(.text);  /* 0x080132e8 - 0x080135b8, sub_080132E8 (auto-peeled) */
        src/engine/sub_080135b8.o(.text);
        asm/disasm_0x080135b8.o(.text);  /* 0x080135b8 - 0x08013694, sub_080135B8 (auto-peeled) */
        src/engine/sub_08013694.o(.text);
        src/engine/sub_0801377c.o(.text);  /* 0x0801377c - 0x08013880, sub_0801377C + sub_08013828 */
        src/engine/sub_08013880.o(.text);
        src/engine/sub_08013898.o(.text);  /* 0x08013898 - 0x08013908, sub_08013898 */
        src/engine/sub_08013908.o(.text);  /* 0x08013908 - 0x08013980, sub_08013908, sub_08013920 */
        src/engine/sub_08013980.o(.text);
        src/engine/sub_080139bc.o(.text);  /* 0x080139bc - 0x080139f8, sub_080139BC */
        src/engine/sub_080139f8.o(.text);
        src/engine/sub_08013aac.o(.text);
        src/engine/sub_08013d1c.o(.text);
        src/engine/sub_08013e94.o(.text);  /* 0x08013e94 - 0x08013f68, sub_08013E94 + sub_08013F2C + sub_08013F5C */
        src/engine/sub_08013f68.o(.text);
        src/engine/sub_08013f94.o(.text);
        src/engine/sub_08013fa0.o(.text);
        src/engine/sub_08014020.o(.text);
        src/engine/sub_08014064.o(.text);
        src/engine/sub_08014078.o(.text);
        src/engine/sub_08014140.o(.text);
        asm/disasm_0x08014140.o(.text);  /* 0x08014140 - 0x080142d4, sub_08014140 (auto-peeled) */
        src/engine/sub_080142d4.o(.text);
        asm/text/text_0x0801436c.o(.text);  /* 0x0801436c - 0x080152b0, raw bytes (shrunk for sub_080152B0 peel) */
        asm/disasm_0x080152b0.o(.text);  /* 0x080152b0 - 0x0801549c, sub_080152B0 (auto-peeled) */
        asm/disasm_0x0801549c.o(.text);  /* 0x0801549c - 0x080155f0, sub_0801549C (auto-peeled) */
        src/engine/sub_080155f0.o(.text);
        asm/disasm_0x080155f0.o(.text);  /* 0x080155f0 - 0x0801585c, sub_080155F0 (auto-peeled) */
        src/engine/sub_0801585c.o(.text);  /* 0x0801585c - 0x08015930, sub_0801585C */
        src/engine/sub_08015930.o(.text);  /* 0x08015930 - 0x08015a00, sub_08015930 + sub_080159B0 */
        src/engine/sub_08015a00.o(.text);
        asm/disasm_0x08015b6c.o(.text);  /* 0x08015b6c - 0x08015c24, sub_08015B6C (auto-peeled) */
        src/engine/sub_08015c24.o(.text);  /* 0x08015c24 - 0x08015cbc, sub_08015C24 */
        asm/disasm_0x08015c24.o(.text);  /* 0x08015c24 - 0x08015cbc, sub_08015C24 (auto-peeled) */
        src/engine/sub_08015cbc.o(.text);
        src/engine/sub_08015d30.o(.text);
        src/engine/sub_08015d54.o(.text);
        asm/text/text_0x08015d84.o(.text);  /* 0x08015d84 - 0x08015ea4, raw bytes */
        src/engine/sub_08015ea8.o(.text);
        asm/text/text_0x08015ec4.o(.text);  /* 0x08015ec4 - 0x0801621c, raw bytes */
        src/engine/sub_0801621c.o(.text);
        asm/text/text_0x0801629c.o(.text);  /* 0x0801629c - 0x08016360, raw bytes */
        src/engine/sub_08016360.o(.text);  /* 0x08016360 - 0x08016404, sub_08016360 */
        src/engine/sub_08016404.o(.text);
        asm/disasm_0x08016404.o(.text);  /* 0x08016404 - 0x08016650, sub_08016404 (auto-peeled) */
        src/engine/sub_08016650.o(.text);
        asm/disasm_0x08016650.o(.text);  /* 0x08016650 - 0x08016824, sub_08016650 (auto-peeled) */
        src/engine/sub_08016824.o(.text);
        src/engine/sub_080169bc.o(.text);
        src/engine/sub_08016a40.o(.text);
        asm/disasm_0x08016a40.o(.text);  /* 0x08016a40 - 0x08017000, sub_08016A40 (auto-peeled) */
        src/engine/sub_08017000.o(.text);
        asm/disasm_0x08017000.o(.text);  /* 0x08017000 - 0x080172f4, sub_08017000 (auto-peeled) */
        src/engine/sub_080172f4.o(.text);  /* 0x080172f4 - 0x08017364, sub_080172F4 */
        src/engine/sub_08017364.o(.text);
        asm/disasm_0x08017364.o(.text);  /* 0x08017364 - 0x080177a0, sub_08017364 (auto-peeled) */
        src/engine/sub_080177a0.o(.text);
        src/engine/sub_0801793c.o(.text);  /* 0x0801793c - 0x080179b8, sub_0801793C */
        src/engine/sub_080179b8.o(.text);
        src/engine/sub_08017a88.o(.text);  /* 0x08017a88 - 0x08017aa8, sub_08017A88 */
        src/engine/sub_08017aa8.o(.text);  /* 0x08017aa8 - 0x08017abc, sub_08017AA8 */
        src/engine/sub_08017abc.o(.text);
        asm/disasm_0x08017abc.o(.text);  /* 0x08017abc - 0x08017bfc, sub_08017ABC (auto-peeled) */
        src/engine/sub_08017bfc.o(.text);
        asm/disasm_0x08017f00.o(.text);  /* 0x08017f00 - 0x080181d0, sub_08017F00 (auto-peeled) */
        src/engine/sub_080181d0.o(.text);
        asm/disasm_0x080181d0.o(.text);  /* 0x080181d0 - 0x080182cc, sub_080181D0 (auto-peeled) */
        src/engine/sub_080182cc.o(.text);
        asm/disasm_0x080182cc.o(.text);  /* 0x080182cc - 0x080184dc, sub_080182CC (auto-peeled) */
        src/engine/sub_080184dc.o(.text);  /* 0x080184dc - 0x080185c0, sub_080184DC */
        src/engine/sub_080185c0.o(.text);
        asm/disasm_0x080185c0.o(.text);  /* 0x080185c0 - 0x0801932c, sub_080185C0 (auto-peeled) */
        src/engine/sub_0801932c.o(.text);  /* 0x0801932c - 0x080193d8, sub_0801932C */
        asm/disasm_0x080193d8.o(.text);  /* 0x080193d8 - 0x08019500, sub_080193D8 + sub_08019420 (auto-peeled) */
        src/engine/sub_08019500.o(.text);  /* 0x08019500 - 0x08019540, sub_08019500 */
        src/engine/sub_08019540.o(.text);  /* 0x08019540 - 0x08019560, sub_08019540 */
        src/engine/sub_08019560.o(.text);  /* 0x08019560 - 0x08019834, sub_08019560 + sub_08019580 + sub_080195C4 + sub_0801964C + sub_08019668 + sub_08019678 + sub_080196A0 + sub_080196C8 + sub_080196E8 + sub_080196EC + sub_0801977C */
        src/engine/sub_08019834.o(.text);  /* 0x08019834 - 0x08019964, sub_08019834 + sub_080198A8 + sub_08019958 */
        src/engine/sub_08019964.o(.text);  /* 0x08019964 - 0x08019984, sub_08019964 */
        src/engine/sub_080199e4.o(.text);
        asm/text/text_0x08019a14.o(.text);  /* 0x08019a14 - 0x08019aec, raw bytes */
        src/engine/sub_08019aec.o(.text);
        asm/disasm_0x08019aec.o(.text);  /* 0x08019aec - 0x08019db4, sub_08019AEC (auto-peeled) */
        src/engine/sub_08019db4.o(.text);  /* 0x08019db4 - 0x08019e6c, sub_08019DB4 + sub_08019E28 */
        src/engine/sub_08019e6c.o(.text);  /* 0x08019e6c - 0x0801a268, sub_08019E6C + sub_08019EF0 + sub_08019F70 + sub_08019FD8 + sub_0801A0A4 + sub_0801A1C4 */
        src/engine/sub_0801a268.o(.text);
        asm/disasm_0x0801a268.o(.text);  /* 0x0801a268 - 0x0801a614, sub_0801A268 (auto-peeled) */
        src/engine/sub_0801a614.o(.text);
        src/engine/sub_0801a6d4.o(.text);
        src/engine/sub_0801a774.o(.text);
        src/engine/sub_0801a894.o(.text);
        src/engine/sub_0801a980.o(.text);  /* sub_0801A980 + sub_0801AA60 */
        asm/disasm_0x0801ab44.o(.text);  /* 0x0801ab44 - 0x0801ac84, sub_0801AB44 (auto-peeled) */
        src/engine/sub_0801ac84.o(.text);
        asm/disasm_0x0801ada8.o(.text);  /* 0x0801ada8 - 0x0801b0ac, sub_0801ADA8 (auto-peeled) */
        src/engine/sub_0801b0ac.o(.text);
        src/engine/sub_0801b154.o(.text);
        src/engine/sub_0801b514.o(.text);  /* 0x0801b514 - 0x0801b71c, sub_0801B514 + sub_0801B620 + sub_0801B694 */
        asm/text/text_0x0801b71c.o(.text);  /* 0x0801b71c - 0x0801b954, raw bytes (shrunk for sub_0801B954 peel) */
        src/engine/sub_0801b954.o(.text);
        src/engine/sub_0801b9e4.o(.text);
        src/engine/sub_0801bac8.o(.text);
        src/engine/sub_0801badc.o(.text);
        src/engine/sub_0801bb1c.o(.text);
        src/engine/sub_0801bb54.o(.text);
        asm/disasm_0x0801bb54.o(.text);  /* 0x0801bb54 - 0x0801be7c, sub_0801BB54 (auto-peeled) */
        src/engine/sub_0801be7c.o(.text);
        asm/disasm_0x0801be7c.o(.text);  /* 0x0801be7c - 0x0801c078, sub_0801BE7C (auto-peeled) */
        src/engine/sub_0801c078.o(.text);
        src/engine/sub_0801c2b4.o(.text);
        src/engine/sub_0801c464.o(.text);
        asm/disasm_0x0801c6fc.o(.text);  /* 0x0801c6fc - 0x0801cd0c, sub_0801C6FC (auto-peeled) */
        src/engine/sub_0801cd0c.o(.text);
        asm/disasm_0x0801cd0c.o(.text);  /* 0x0801cd0c - 0x0801cec0, sub_0801CD0C (auto-peeled) */
        src/engine/sub_0801cec0.o(.text);
        src/engine/sub_0801cf18.o(.text);  /* 0x0801cf18 - 0x0801cfa0, sub_0801CF18 */
        src/engine/sub_0801cfa0.o(.text);  /* 0x0801cfa0 - 0x0801d048, sub_0801CFA0 */
        src/engine/sub_0801d048.o(.text);
        src/engine/sub_0801d094.o(.text);
        src/engine/sub_0801d150.o(.text);
        src/engine/sub_0801d268.o(.text);  /* 0x0801d268 - 0x0801d33c, sub_0801D268 */
        src/engine/sub_0801d33c.o(.text);
        src/engine/sub_0801d4cc.o(.text);  /* 0x0801d4cc - 0x0801d570, sub_0801D4CC */
        src/engine/sub_0801d570.o(.text);
        asm/disasm_0x0801d570.o(.text);  /* 0x0801d570 - 0x0801d880, sub_0801D570 (auto-peeled) */
        src/engine/sub_0801d880.o(.text);
        asm/disasm_0x0801d880.o(.text);  /* 0x0801d880 - 0x0801da1c, sub_0801D880 (peeled) */
        src/engine/sub_0801da1c.o(.text);
        src/engine/sub_0801dbb4.o(.text);
        asm/disasm_0x0801dbb4.o(.text);  /* 0x0801dbb4 - 0x0801dea0, sub_0801DBB4 (auto-peeled) */
        src/engine/sub_0801dea0.o(.text);
        asm/disasm_0x0801dea0.o(.text);  /* 0x0801dea0 - 0x0801e078, sub_0801DEA0 (auto-peeled) */
        src/engine/sub_0801e078.o(.text);  /* 0x0801e078 - 0x0801e118, sub_0801E078 */
        src/engine/sub_0801e118.o(.text);  /* 0x0801e118 - 0x0801e270, sub_0801E118 + sub_0801E1AC + sub_0801E1FC */
        src/engine/sub_0801e270.o(.text);  /* 0x0801e270 - 0x0801e28c, sub_0801E270 */
        src/engine/sub_0801e28c.o(.text);
        asm/disasm_0x0801e28c.o(.text);  /* 0x0801e28c - 0x0801ea08, sub_0801E28C (auto-peeled) */
        src/engine/sub_0801ea08.o(.text);
        asm/disasm_0x0801ea08.o(.text);  /* 0x0801ea08 - 0x0801f1e0, sub_0801EA08 (auto-peeled) */
        src/engine/sub_0801f1e0.o(.text);
        asm/disasm_0x0801f1e0.o(.text);  /* 0x0801f1e0 - 0x0801f418, sub_0801F1E0 (auto-peeled) */
        src/engine/sub_0801f418.o(.text);
        asm/disasm_0x0801f418.o(.text);  /* 0x0801f418 - 0x0801f684, sub_0801F418 (auto-peeled) */
        src/engine/sub_0801f684.o(.text);
        asm/disasm_0x0801f684.o(.text);  /* 0x0801f684 - 0x0801f8bc, sub_0801F684 (auto-peeled) */
        src/engine/sub_0801f8bc.o(.text);
        asm/disasm_0x0801f970.o(.text);  /* 0x0801f970 - 0x0801fd0c, sub_0801F970 (auto-peeled) */
        src/engine/sub_0801fd0c.o(.text);  /* 0x0801fd0c - 0x0801fe68, sub_0801FD0C */
        asm/disasm_0x0801fe68.o(.text);  /* 0x0801fe68 - 0x080200b4, sub_0801FE68 (auto-peeled) */
        src/engine/sub_080200b4.o(.text);
        asm/disasm_0x080200b4.o(.text);  /* 0x080200b4 - 0x080201a8, sub_080200B4 (peeled) */

        src/engine/sub_080201a8.o(.text);  /* 0x080201a8 - 0x080201c8, sub_080201A8 */
        src/engine/sub_080201c8.o(.text);
        src/engine/sub_080201e8.o(.text);  /* 0x080201e8 - 0x080202a8, sub_080201E8 + sub_08020208 + sub_0802023C + sub_08020270 */
        src/engine/sub_080202a8.o(.text);  /* 0x080202a8 - 0x080202f8, sub_080202A8 + sub_080202C8 */
        src/engine/sub_080204a4.o(.text);
        src/engine/sub_080205d8.o(.text);
        asm/disasm_0x080205d8.o(.text);  /* 0x080205d8 - 0x0802090c, sub_080205D8 (auto-peeled) */
        src/game/sub_0802090c.o(.text);  /* 0x0802090c - 0x08020b30, sub_0802090C */
        src/game/sub_08020b30.o(.text);  /* 0x08020b30 - 0x08020b60, sub_08020B30 + sub_08020B50 */
        src/system/sub_08020b60.o(.text);  /* 0x08020b60 - 0x08020b88, sub_08020B60 + sub_08020B78 */
        src/engine/sub_08020b88.o(.text);  /* 0x08020b88 - 0x08020bac, sub_08020B88 */
        src/engine/sub_08020bac.o(.text);  /* 0x08020bac - 0x08020bc0, sub_08020BAC */
        src/engine/sub_08020bc0.o(.text);  /* 0x08020bc0 - 0x08020c78, sub_08020BC0 + sub_08020BE4 + sub_08020BF0 + sub_08020C14 + sub_08020C3C + sub_08020C58 */
        src/engine/sub_08020c78.o(.text);  /* 0x08020c78 - 0x08020dc4, sub_08020C78 + sub_08020CA4 + sub_08020CDC + sub_08020D2C + sub_08020DA0 */
        src/engine/sub_08020dc4.o(.text);  /* 0x08020dc4 - 0x08020e7c, sub_08020DC4 + sub_08020E14 */
        src/engine/sub_08020e7c.o(.text);  /* 0x08020e7c - 0x08020e98, sub_08020E7C */
        src/system/sub_08020e98.o(.text);  /* 0x08020e98 - 0x08020ee4, sub_08020E98 + sub_08020ED8 */
        src/engine/sub_08020ee4.o(.text);  /* 0x08020ee4 - 0x08020f08, sub_08020EE4 */
        src/engine/sub_08020f08.o(.text);  /* 0x08020f08 - 0x08020f3c, sub_08020F08 */
        src/engine/sub_08020f3c.o(.text);
        asm/disasm_0x08020fe4.o(.text);  /* 0x08020fe4 - 0x080210a0, sub_08020FE4 (auto-peeled) */
        src/engine/sub_080210a0.o(.text);
        asm/disasm_0x080210a0.o(.text);  /* 0x080210a0 - 0x08021140, sub_080210A0 (auto-peeled) */
        src/engine/sub_08021140.o(.text);
        asm/disasm_0x08021140.o(.text);  /* 0x08021140 - 0x08021510, sub_08021140 (auto-peeled) */
        src/engine/sub_08021510.o(.text);
        src/engine/sub_080217d4.o(.text);  /* 0x080217d4 - 0x08021838, sub_080217D4 */
        src/engine/sub_08021838.o(.text);
        src/engine/sub_080219bc.o(.text);
        asm/disasm_0x080219bc.o(.text);  /* 0x080219bc - 0x08021cfc, sub_080219BC (auto-peeled) */
        src/engine/sub_08021cfc.o(.text);
        src/engine/sub_08021e34.o(.text);  /* 0x08021e34 - 0x08021ec0, sub_08021E34 */
        src/engine/sub_08021ec0.o(.text);  /* 0x08021ec0 - 0x08021eec, sub_08021EC0 */
        src/engine/sub_08021eec.o(.text);  /* 0x08021eec - 0x08021f64, sub_08021EEC, sub_08021F1C */
        src/engine/sub_08021f64.o(.text);  /* 0x08021f64 - 0x0802205c, sub_08021F64 */
        src/engine/sub_0802205c.o(.text);  /* 0x0802205c - 0x080220c4, sub_0802205C */
        src/engine/sub_080220c4.o(.text);  /* 0x080220c4 - 0x08022160, sub_080220C4 */
        src/engine/sub_08022160.o(.text);  /* 0x08022160 - 0x080221fc, sub_08022160 */
        src/engine/sub_080221fc.o(.text);  /* 0x080221fc - 0x080222bc, sub_080221FC */
        src/engine/sub_080222bc.o(.text);  /* 0x080222bc - 0x08022360, sub_080222BC */
        src/engine/sub_08022360.o(.text);  /* 0x08022360 - 0x08022434, sub_08022360 */
        src/engine/sub_08022434.o(.text);
        asm/disasm_0x08022434.o(.text);  /* 0x08022434 - 0x08022730, sub_08022434 (auto-peeled) */
        src/engine/sub_08022730.o(.text);  /* 0x08022730 - 0x08022758, sub_08022730 */
        src/engine/sub_08022758.o(.text);  /* 0x08022758 - 0x0802277c, sub_08022758 */
        src/engine/sub_0802277c.o(.text);  /* 0x0802277c - 0x080228ac, sub_0802277C + sub_080227B4 + sub_080227DC + sub_08022800 + sub_08022838 + sub_08022884 */
        src/engine/sub_080228ac.o(.text);  /* 0x080228ac - 0x080228d0, sub_080228AC */
        src/engine/sub_080228d0.o(.text);  /* 0x080228d0 - 0x080228fc, sub_080228D0 */
        src/engine/sub_080228fc.o(.text);  /* 0x080228fc - 0x08022b4c, sub_080228FC + sub_08022920 + sub_08022958 + sub_08022980 + sub_080229A4 + sub_080229CC + sub_080229F0 + sub_08022A28 + sub_08022A9C + sub_08022AC8 + sub_08022AEC */
        src/engine/sub_08022b4c.o(.text);
        src/engine/sub_08022bb0.o(.text);  /* ... + sub_08022DDC */
        src/engine/sub_08022ea8.o(.text);  /* 0x08022ea8 - 0x08022f4c, sub_08022EA8 */
        src/engine/sub_08022f4c.o(.text);
        src/engine/sub_08022fec.o(.text);
        asm/disasm_0x08022fec.o(.text);  /* 0x08022fec - 0x080231f4, sub_08022FEC (auto-peeled) */
        src/engine/sub_080231f4.o(.text);
        src/engine/sub_0802321c.o(.text);
        src/engine/sub_08023244.o(.text);
        src/engine/sub_080232cc.o(.text);  /* 0x080232cc - 0x08023334, sub_080232CC */
        src/engine/sub_08023334.o(.text);  /* 0x08023334 - 0x08023360, sub_08023334 */
        src/engine/sub_08023360.o(.text);
        src/engine/sub_08023384.o(.text);
        src/engine/sub_080233b0.o(.text);
        src/engine/sub_080233d4.o(.text);
        src/engine/sub_0802349c.o(.text);
        src/engine/sub_080234e8.o(.text);
        src/engine/sub_08023538.o(.text);
        src/engine/sub_08023594.o(.text);  /* 0x08023594 - 0x080235c8, sub_08023594 */
        src/engine/sub_080235c8.o(.text);  /* 0x080235c8 - 0x0802367c, sub_080235C8 */
        asm/text/text_0x0802367c.o(.text);  /* 0x0802367c - 0x0802a2f0, raw bytes */
        src/engine/sub_0802a2f0.o(.text);
        src/engine/sub_0802a394.o(.text);
        src/engine/sub_0802a42c.o(.text);
        src/engine/sub_0802a4a4.o(.text);
        src/engine/sub_0802a538.o(.text);
        asm/disasm_0x0802a538.o(.text);  /* 0x0802a538 - 0x0802a63c, sub_0802A538 (auto-peeled) */
        asm/text/text_0x0802a63c.o(.text);  /* 0x0802a63c - 0x0802a8fc, raw bytes */
        src/engine/sub_0802a8fc.o(.text);
        asm/disasm_0x0802a8fc.o(.text);  /* 0x0802a8fc - 0x0802a9fc, sub_0802A8FC (auto-peeled) */
        src/engine/sub_0802a9fc.o(.text);
        asm/disasm_0x0802a9fc.o(.text);  /* 0x0802a9fc - 0x0802aae8, sub_0802A9FC (auto-peeled) */
        src/engine/sub_0802aae8.o(.text);
        src/game/sub_0802ab64.o(.text);  /* 0x0802ab64 - 0x0802af10, sub_0802AB64 + sub_0802ABB0 + sub_0802ABDC + sub_0802AC60 + sub_0802ACB4 */
        asm/text/text_0x0802af10.o(.text);  /* 0x0802af10 - 0x0802b9d4, raw bytes */
        src/game/sub_0802b9d4.o(.text);
        src/game/sub_0802ba64.o(.text);
        asm/disasm_0x0802ba64.o(.text);  /* 0x0802ba64 - 0x0802bb5c, sub_0802BA64 (auto-peeled) */
        src/game/sub_0802bb5c.o(.text);  /* 0x0802bb5c - 0x0802bc24, sub_0802BB5C + sub_0802BBC0 + sub_0802BBFC */
        src/game/sub_0802bc24.o(.text);
        src/game/sub_0802bdbc.o(.text);
        asm/disasm_0x0802bdbc.o(.text);  /* 0x0802bdbc - 0x0802bf58, sub_0802BDBC (peeled) */
        src/game/sub_0802bf58.o(.text);
        asm/disasm_0x0802c000.o(.text);  /* 0x0802c000 - 0x0802c200, sub_0802C000 (auto-peeled) */
        src/game/sub_0802c200.o(.text);
        asm/disasm_0x0802c200.o(.text);  /* 0x0802c200 - 0x0802c3e4, sub_0802C200 (auto-peeled) */
        src/game/sub_0802c3e4.o(.text);
        asm/disasm_0x0802c3e4.o(.text);  /* 0x0802c3e4 - 0x0802c75c, sub_0802C3E4 (auto-peeled) */
        src/game/sub_0802c75c.o(.text);
        src/game/sub_0802c7ec.o(.text);
        asm/disasm_0x0802c910.o(.text);  /* 0x0802c910 - 0x0802ca54, sub_0802C910 (auto-peeled) */
        asm/text/text_0x0802ca54.o(.text);  /* 0x0802ca54 - 0x0802ca64, raw bytes */
        src/game/sub_0802ca64.o(.text);
        asm/text/text_0x0802cafc.o(.text);  /* 0x0802cafc - 0x0802d554, raw bytes */
        src/game/sub_0802d554.o(.text);  /* 0x0802d554 - 0x0802d558, sub_0802D554 */
        src/game/sub_0802d558.o(.text);
        asm/disasm_0x0802d558.o(.text);  /* 0x0802d558 - 0x0802d890, sub_0802D558 (auto-peeled) */
        src/game/sub_0802d890.o(.text);
        src/game/sub_0802d8f8.o(.text);
        asm/disasm_0x0802d8f8.o(.text);  /* 0x0802d8f8 - 0x0802d9ec, sub_0802D8F8 (auto-peeled) */
        src/game/sub_0802d9ec.o(.text);
        asm/disasm_0x0802d9ec.o(.text);  /* 0x0802d9ec - 0x0802dcbc, sub_0802D9EC (auto-peeled) */
        src/game/sub_0802dcbc.o(.text);
        asm/disasm_0x0802dcbc.o(.text);  /* 0x0802dcbc - 0x0802de24, sub_0802DCBC (auto-peeled) */
        src/game/sub_0802de24.o(.text);
        src/game/sub_0802de9c.o(.text);
        asm/disasm_0x0802de9c.o(.text);  /* 0x0802de9c - 0x0802dfbc, sub_0802DE9C (auto-peeled) */
        src/game/sub_0802dfbc.o(.text);  /* 0x0802dfbc - 0x0802e00c, sub_0802DFBC */
        src/game/sub_0802e00c.o(.text);
        asm/disasm_0x0802e00c.o(.text);  /* 0x0802e00c - 0x0802e100, sub_0802E00C (auto-peeled) */
        src/system/sub_0802e100.o(.text);  /* 0x0802e100 - 0x0802e13c, sub_0802E100 */
        src/system/sub_0802e13c.o(.text);  /* 0x0802e13c - 0x0802e220, sub_0802E13C + sub_0802E1C8 */
        src/system/sub_0802e220.o(.text);  /* 0x0802e220 - 0x0802e27c, sub_0802E220 */
        src/system/sub_0802e27c.o(.text);  /* 0x0802e27c - 0x0802e380 */
        src/system/sub_0802e380.o(.text);  /* 0x0802e380 - 0x0802e3f8 */
        src/system/sound_lock.o(.text);  /* 0x0802e3f8 - 0x0802e528, sub_0802E3F8 + sub_0802E418 + sub_0802E43C + sub_0802E470 + sub_0802E4B4 + sub_0802E4E8 */
        asm/text/text_0x0802e528.o(.text);  /* 0x0802e528 - 0x0802e5d8, raw bytes */
        src/system/sound_pitch.o(.text);  /* 0x0802e5d8 - 0x0802e684, sub_0802E5D8 (NAKED+NON_MATCHING) */
        src/system/sound_volume.o(.text);  /* 0x0802e684 - 0x0802e724, sub_0802E684 */
        src/system/sub_0802e724.o(.text);  /* 0x0802e724 - 0x0802e7c4, sub_0802E724 */
        src/system/sub_0802e7c4.o(.text);  /* 0x0802e7c4 - 0x0802e934, sub_0802E7C4 + sub_0802E874 */
        src/system/sound_envelope_dual.o(.text);  /* 0x0802e934 - 0x0802ea80, sub_0802E934 (NAKED+NON_MATCHING) + sub_0802EA2C */
        src/system/sound_envelope.o(.text);  /* 0x0802ea80 - 0x0802ebf8, sub_0802EA80 + sub_0802EB34 (NAKED+NON_MATCHING) */
        asm/disasm_0x0802ebf8.o(.text);  /* 0x0802ebf8 - 0x0802ec7c, sub_0802EBF8 (auto-peeled) */
        src/system/sound_channel_envelope_a.o(.text);  /* 0x0802ec7c - 0x0802ed5c, sub_0802EC7C (NAKED+NON_MATCHING) */
        src/system/sound_channel.o(.text);  /* 0x0802ed5c - 0x0802edf0, sub_0802ED5C */
        src/system/sound_channel_stream.o(.text);  /* 0x0802edf0 - 0x0802f054, sub_0802EDF0 (NAKED+NON_MATCHING) + sub_0802EEF8 + sub_0802EF7C */
        src/system/sound_envelope_slide.o(.text);  /* 0x0802f054 - 0x0802f2fc, sub_0802F054 (NAKED+NON_MATCHING) */
        src/system/sound_pan.o(.text);  /* 0x0802f2fc - 0x0802f4b0, sub_0802F2FC (NAKED+NON_MATCHING) + sub_0802F398 */
        src/system/sound_mixer.o(.text);  /* 0x0802f4b0 - 0x0802f8f0, sub_0802F4B0 + sub_0802F870 + sub_0802F884 + sub_0802F890 */
        asm/text/text_0x0802f8f0.o(.text);  /* 0x0802f8f0 - 0x0802f9f0, raw bytes */
        src/system/sub_0802f9f0.o(.text);  /* 0x0802f9f0 - 0x0802fab8, sub_0802F9F0 + sub_0802FA60 */
        asm/text/text_0x0802fab8.o(.text);  /* 0x0802fab8 - 0x08030000, raw bytes */
        asm/text/text_0x08030000.o(.text);  /* 0x08030000 - 0x080301c4, raw bytes */
        src/system/sound_period.o(.text);  /* 0x080301c4 - 0x080304f4, sub_080301C4 (NAKED+NON_MATCHING — libgcc-BL class) + sub_08030264 + sub_08030290 + sub_0803030C + sub_0803038C + sub_0803045C */
        asm/text/text_0x080304f4.o(.text);  /* 0x080304f4 - 0x080315d8, raw bytes */
        src/system/sound_opcode_dispatch.o(.text);  /* 0x080315d8 - 0x08031638, sub_080315D8 */
        asm/text/text_0x08031638.o(.text);  /* 0x08031638 - 0x080316dc, raw bytes */
        src/system/sub_080316dc.o(.text);
        asm/text/text_0x080316fc.o(.text);  /* 0x080316fc - 0x08031720, raw bytes */
        src/system/sub_08031720.o(.text);
        src/system/sub_08031748.o(.text);
        asm/text/text_0x0803175c.o(.text);  /* 0x0803175c - 0x08031798, raw bytes */
        src/system/sub_08031798.o(.text);
        asm/text/text_0x080317c0.o(.text);  /* 0x080317c0 - 0x0803189c, raw bytes */
        src/system/sub_0803189c.o(.text);
        asm/text/text_0x080318a8.o(.text);  /* 0x080318a8 - 0x08031dbc, raw bytes */
        src/system/sub_08031dbc.o(.text);
        asm/disasm_0x08031e24.o(.text);  /* 0x08031e24 - 0x08031fdc, sub_08031E24 (auto-peeled) */
        src/system/sub_08031fdc.o(.text);
        src/system/sub_08032094.o(.text);
        src/system/sub_08032148.o(.text);  /* 0x08032148 - 0x08032200, sub_08032148 */
        asm/text/text_0x08032200.o(.text);  /* 0x08032200 - 0x080325b0, raw bytes */
        src/system/sound_mixer_tail.o(.text);  /* 0x080325b0 - 0x08032894, sub_080325B0 (NAKED+NON_MATCHING) */
        src/system/sub_08032894.o(.text);  /* 0x08032894 - 0x08032904, sub_08032894 */
        src/system/sound_channel_state.o(.text);  /* 0x08032904 - 0x0803299c, sub_08032904 (NAKED+NON_MATCHING) */
        src/game/sub_0803299c.o(.text);  /* 0x0803299c - 0x08032b18, sub_0803299C + sub_080329F4 + sub_08032A20 + sub_08032A54 + sub_08032A98 + sub_08032AA0 */
        src/game/sub_08032b18.o(.text);  /* 0x08032b18 - 0x08032c18, SoundSlot_PickByPriority + sub_08032BA0 + sub_08032BC8 */
        asm/text/text_0x08032c18.o(.text);  /* 0x08032c18 - 0x08032e04, raw bytes */
        src/game/sub_08032e04.o(.text);
        asm/text/text_0x08032e1c.o(.text);  /* 0x08032e1c - 0x080338a8, raw bytes */
        src/game/sub_080338a8.o(.text);
        src/game/sub_08033910.o(.text);  /* 0x08033910 - 0x08033948, sub_08033910 */
        asm/text/text_0x08033948.o(.text);  /* 0x08033948 - 0x08033ca4, raw bytes */
        asm/disasm_0x08033ca4.o(.text);  /* 0x08033ca4 - 0x08033cd8, __ashldi3 (libgcc; auto-peeled) */
        asm/disasm_0x08033cd8.o(.text);  /* 0x08033cd8 - 0x08033d14, _call_via_rX libgcc helper table (auto-peeled) */
        asm/disasm_0x08033d14.o(.text);  /* 0x08033d14 - 0x08033da8, __divsi3 (libgcc; auto-peeled) */
        src/game/sub_08033da8.o(.text);
        asm/text/text_0x08033de0.o(.text);  /* 0x08033de0 - 0x08033e14, raw bytes */
        src/game/__modsi3.o(.text);
        asm/disasm_0x08033e14.o(.text);  /* 0x08033e14 - 0x08033ee4, __modsi3 (libgcc; auto-peeled) */
        asm/disasm_0x08033ee4.o(.text);  /* 0x08033ee4 - 0x08033f5c, __udivsi3 (libgcc; auto-peeled) */
        asm/disasm_0x08033f5c.o(.text);  /* 0x08033f5c - 0x0803401c, __umodsi3 (libgcc; auto-peeled) */
        src/game/sub_0803401c.o(.text);
        asm/disasm_0x0803401c.o(.text);  /* 0x0803401c - 0x080340d4, sub_0803401C (auto-peeled) */
        src/game/sub_080340d4.o(.text);
        asm/disasm_0x080340d4.o(.text);  /* 0x080340d4 - 0x08034150, sub_080340D4 (auto-peeled) */
        src/game/sub_08034150.o(.text);
        asm/disasm_0x08034150.o(.text);  /* 0x08034150 - 0x080342cc, sub_08034150 (auto-peeled) */
        src/game/sub_080342cc.o(.text);
        asm/text/text_0x080342f8.o(.text);  /* 0x080342f8 - 0x0803457c, raw bytes */
        src/game/sub_0803457c.o(.text);
        asm/disasm_0x0803457c.o(.text);  /* 0x0803457c - 0x08034660, sub_0803457C (auto-peeled) */
        asm/text/text_0x08034660.o(.text);  /* 0x08034660 - 0x08034760, raw bytes */
        src/game/sub_08034760.o(.text);
        asm/text/text_0x080347a8.o(.text);  /* 0x080347a8 - 0x08034898, raw bytes */
        src/game/sub_08034898.o(.text);
        asm/disasm_0x08034900.o(.text);  /* 0x08034900 - 0x08034924, sub_08034900 (auto-peeled) */
        src/game/sub_08034924.o(.text);
        asm/disasm_0x08034924.o(.text);  /* 0x08034924 - 0x0803493c, sub_08034924 (auto-peeled) */
        src/game/sub_0803493c.o(.text);
        asm/disasm_0x0803493c.o(.text);  /* 0x0803493c - 0x08034968, sub_0803493C (auto-peeled) */
        src/game/sub_08034968.o(.text);
        asm/disasm_0x08034968.o(.text);  /* 0x08034968 - 0x080349d8, sub_08034968 (auto-peeled) */
        asm/text/text_0x080349d8.o(.text);  /* 0x080349d8 - 0x0803578c, raw bytes */
        src/game/sub_0803578c.o(.text);
        asm/text/text_0x080357ec.o(.text);  /* 0x080357ec - 0x08035d7c, raw bytes */
        src/game/sub_08035d7c.o(.text);  /* 0x08035d7c - 0x08035d84, sub_08035D7C (Thumb-to-ARM interwork thunk -> IntrEnable) */
        asm/text/text_0x08035d84.o(.text);  /* 0x08035d84 - 0x08035d8c, one Thumb-to-ARM veneer */
        src/game/sub_08035d8c.o(.text);
        src/game/sub_08035d94.o(.text);  /* 0x08035d94 - 0x08035d9c, sub_08035D94 (NAKED interwork veneer) */
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
        sLevelLayoutPtrs_3117F0 = sLevelLayoutData_3116F0 + 0x100;
        sLevelLayoutPtrs_311910 = sLevelLayoutData_3116F0 + 0x220;
        sLevelLayoutPtrs_311A30 = sLevelLayoutData_3116F0 + 0x340;
        sLevelLayout_3120D8 = sLevelLayoutData_311F80 + 0x158;
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
        /* Emitted by -fno-expensive-optimizations for an otherwise .text-only match. */
        src/game/sub_08001214.o(.rodata)
        src/game/sub_080019b4.o(.rodata)
        src/game/sub_08002184.o(.rodata)
        src/game/sub_08002524.o(.rodata)
        src/game/mode_15.o(.rodata)
        src/game/sub_08004938.o(.rodata)
        src/game/sub_08002b58.o(.rodata)
        src/engine/sub_08012f00.o(.rodata)
        src/system/sub_08001508.o(.rodata)
        src/engine/sub_0801b9e4.o(.rodata)
        *(.ARM.attributes)
        *(.comment)
        *(.note*)
    }
}
