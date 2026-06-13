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
 * Indexed by a 3-step cycle counter (gGameStuff._step24) in GameMode_Attract —
 * entries 0..8 are Thumb function pointers to the set-game-mode handlers
 * (Scene08_Main, Scene09_Run, ...). Linker-assigned so agbcc loads the
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
 * in GameMode_Menu26. See docs/codegen-notes.md "Adjacent IWRAM bases" (the
 * same defeat-the-fold principle, applied to a ROM data table). Promote to
 * a real extracted array when the dispatcher cluster is named. */
gStateHandlers_0830804C = 0x0830804C;

/* Per-scene tilemap-source pointer table (anchor inside sSpriteFramePtrs_08110).
 * Linker-assigned absolute symbol so the array base becomes a relocation: this
 * makes agbcc load the table base before the (absolute) gIwram_34B0 index base,
 * matching the baserom pool/register order in FileSelect_Init. */
sScreenTilemapTable_308EF4 = 0x08308EF4;

/* Per-scene record-pointer table at the head of sSpriteFramePtrs_08110. Each
 * entry points at a small array of ROM pointers whose [1]/[2] slots feed
 * Scene_DrawWindow. Linker-assigned for the same defeat-the-fold reason as the
 * tilemap table above (FileSelect_Init / FileSelect_Update). */
sSceneRecordTable_308110 = 0x08308110;
sSpawnTable_0830791C = 0x0830791C;
sSpawnTable_083079DC = 0x083079DC;
sSpawnRecords_08307CB0 = 0x08307CB0;

/* Per-frame palette/tile sources for the animated-icon DMA in Icon_LoadFrameByMode.
 * Declared as linker-assigned ROM symbols (not absolute casts) so agbcc
 * treats each as an independent relocation: this defeats the CSE fold that
 * would otherwise derive each frame's palette from its tiles (palette =
 * tiles - 32) and cross-merge the per-case tile DMAs. See docs/codegen-notes
 * "Adjacent IWRAM bases — defeat CSE-fold via linker-assigned symbols". The
 * five frames live in sIconAnimFrames (src/data/icon_anim_frames.c). */
sIconFramePal0 = 0x081736F8;
sIconFrameTiles0 = 0x08173718;
sIconFramePal1 = 0x081737B8;
sIconFrameTiles1 = 0x081737D8;
sIconFramePal2 = 0x08173878;
sIconFrameTiles2 = 0x08173898;
sIconFramePal3 = 0x08173938;
sIconFrameTiles3 = 0x08173958;
sIconFramePal4 = 0x081739F8;
sIconFrameTiles4 = 0x08173A18;
/* Sprite animation descriptor instances within the sSpriteAnimBlock_06838 blob.
 * Both at offset 0x5d0 / 0x5f0 into the block (addresses 0x08306e08 / 0x08306e28).
 * Linker-assigned so agbcc emits two separate pool loads instead of folding
 * the adjacent compile-time constants into a single base+offset computation.
 * Promote to real typed C symbols once the consumer cluster is fully named. */
sAnimDesc_6e08 = 0x08306e08;
sAnimDesc_6e28 = 0x08306e28;

/* Blit parameter table used by Blit_ApplyFlaggedRecords: 24-byte records with
 * dstX/dstY/width/rows/flags + srcTable pointer. Two separate linker-assigned
 * symbols (base and base+16) so agbcc emits distinct pool entries — prevents
 * CSE-fold of the adjacent ROM addresses into a single base+offset load. */
gBlitParamTable_08306b74 = 0x08306b74;
gBlitInitTable_08306AD4 = 0x08306AD4;
gBlitRecord_08306abc = 0x08306abc;
gBlitSrcTable_08306b84 = 0x08306b84;
gTileBlitTable_08306840 = 0x08306840;
gDmaDescTable_08306888 = 0x08306888;
gDmaJob_08307D98 = 0x08307D98;
gDmaJobTable_08307DA8 = 0x08307DA8;
gPaletteSrcTable_08307E78 = 0x08307E78;

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
        . = 0x00003440; *libgcc.a:fp-bit.o(.bss);
        . = 0x00003450; *libgcc.a:dp-bit.o(.bss);
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
        . = 0x000036D8; gIwram_36d8 = .;
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
        . = 0x000054A0; gOamShadow_54A0 = .;
        . = 0x000060A0; gIwram_60A0 = .;
        . = 0x00006110; gIwram_6110 = .;
        /* Aliases gIwram_6110.limit (offset 0x30). A distinct symbol so the
         * Entity_UpdateVisibility loop bound materialises 0x03006140 as its own
         * pool constant instead of folding onto the live gIwram_6110 base
         * (base+0x30) — matches the baserom back-edge. */
        . = 0x00006140; gIwram_6140 = .;
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
     * index read, matching the baserom. Shared by GameMode_Menu26 /
     * GameMode_Menu25. See docs/codegen-notes.md "Adjacent IWRAM bases". */
    gHandlerTable_08308058 = 0x08308058;

    /* ROM dispatch table at 0x0830806c (also inside the sprite_anim_block
     * blob, just past gHandlerTable_08308058). Linker-assigned so its pool
     * load precedes the gIwram_3480 index read, matching the baserom register/
     * pool order in GameMode_Router's dispatchIdx==0 branch — same idiom as
     * gHandlerTable_08308058 above. */
    gHandlerTable_0830806C = 0x0830806C;

    /* ROM dispatch table at 0x08308ac8 (same sprite_dma_records blob).
     * Linker-assigned so its pool load precedes the gIwram_34A0 index read,
     * matching the baserom register/pool order in GameMode_Options — the same
     * idiom as gHandlerTable_08308058 above. */
    gDispatchTable_08308AC8 = 0x08308AC8;

    /* ROM source pointer tables used by Credits_LoadFrogGfx. Linker-assigned so
     * agbcc keeps the table-A base as an opaque relocation in r2, matching
     * the baserom's DMA3 setup sequence. */
    gFrogTileSrcA_083087C8 = 0x083087C8;
    gFrogPaletteSrcB_083087E8 = 0x083087E8;

    /* ROM dispatch table at 0x08308ad4 (also inside the sprite_dma_records
     * blob; not yet broken out). Linker-assigned for the same reason as
     * gHandlerTable_08308058 — keeps its pool load ahead of the gIwram_3480
     * index read. Indexed by gIwram_3480._data[2] in GameMode_Menu07. */
    gHandlerTable_08308AD4 = 0x08308AD4;

    /* ROM dispatch table at 0x08308ae0 (also inside the sprite_dma_records
     * blob; not yet broken out). Linker-assigned for the same reason as
     * gHandlerTable_08308AD4 — keeps its pool load ahead of the gIwram_3480
     * index read. Indexed by gIwram_3480._data[2] in GameMode_Menu27. */
    gHandlerTable_08308AE0 = 0x08308AE0;

    /* ROM dispatch table at 0x08308aec (also inside the sprite_dma_records
     * blob; not yet broken out). Linker-assigned for the same reason as
     * gHandlerTable_08308AD4 — keeps its pool load ahead of the gIwram_3480
     * index read. Indexed by gIwram_3480._data[2] in GameMode_FileSelect. */
    gHandlerTable_08308AEC = 0x08308AEC;

    .text : ALIGN(4) {
        src/system/entry_branch.o(.text);
        asm/disasm_0x08000000.o(.text);  /* 0x08000000 - 0x08000004, entry branch */
        asm/header.o(.text);             /* 0x08000004 - 0x080000BF, header */
        src/system/boot.o(.text);
        src/system/_start.o(.text);
        asm/disasm_0x080000c0.o(.text);  /* 0x080000c0 - 0x080000fc, _start */
        src/system/intr_enable.o(.text);
        asm/disasm_0x080000fc.o(.text);  /* 0x080000fc - 0x08000114, IntrEnable */
        asm/system/intr_disable.o(.text);  /* 0x08000114 - 0x0800012c, shipped ARM runtime */
        asm/system/intr_main.o(.text);     /* 0x0800012c - 0x08000240, shipped ARM IRQ dispatcher */
        asm/system/sub_08000240.o(.text);  /* 0x08000240 - 0x080002a4, shipped ARM runtime */
        src/system/agb_main.o(.text);    /* 0x080002a4 - 0x08000430, AgbMain */
        src/system/init1.o(.text);       /* 0x08000430 - 0x0800072c, Init1 (Init1) + Input_Poll + PollInputAndAttract + PollKeys_DPad */
        src/system/init.o(.text);        /* 0x0800072c - 0x08000820, ClearVramAndWorkram + RandRange + VBlankIntr */
        src/game/sub_08000820.o(.text);  /* 0x08000820 - 0x0800088c, IrqHandler_Install + sub_08000884/sub_08000888 stubs */
        src/game/sub_0800088c.o(.text);  /* 0x0800088c - 0x080008dc, IntrHBlank */
        src/system/vblank.o(.text);      /* 0x080008dc - 0x0800090c, WaitVblank + GetFrameTick */
        asm/disasm_0x0800090c.o(.text);  /* 0x0800090c - 0x08000918, sub_0800090C (auto-peeled) */
        src/system/sub_08000918.o(.text);  /* 0x08000918 - 0x08000b6c, Scene08_Main (matched pure C; mode-X cluster mov-pc-rN dispatcher) */
        src/system/sub_08000b6c.o(.text);  /* 0x08000b6c - 0x08000c98, Scene08_UpdatePlayerEntity */
        src/system/sub_08000c98.o(.text);  /* 0x08000c98 - 0x08000cec, Scene08_StartIntro + Scene08_InitModeControl */
        src/system/sub_08000cec.o(.text);  /* 0x08000cec - 0x08000d2c, Scene08_PlayFrameTick */
        src/system/sub_08000d2c.o(.text);  /* 0x08000d2c - 0x08000d50, Mode8_StateStep */
        src/system/sub_08000d50.o(.text);  /* 0x08000d50 - 0x08000e0c, Mode8_Teardown + Mode8_Setup */
        src/system/sub_08000e0c.o(.text);  /* 0x08000e0c - 0x08000eb8, Scene09_UpdatePlayerTile */
        src/system/sub_08000eb8.o(.text);  /* 0x08000eb8 - 0x08001128, Scene09_Run (NAKED + NON_MATCHING; mode-9 dispatch — `mov pc, rN` jump table, sibling of Scene15_Main) */
        src/system/sub_08001128.o(.text);  /* 0x08001128 - 0x080011a4, EntityProbe_SetMode2 / EntityProbe_ResetAndDispatch / EntityProbe_FinishOrSetup / ModeControl_Cleanup cluster */
        src/game/sub_080011a4.o(.text);    /* 0x080011a4 - 0x08001214, Entity_UpdateHudState */
        src/game/sub_08001214.o(.text);  /* 0x08001214 - 0x08001478, Scene10_Main (mode-10 handler) */
        src/game/set_game_mode_03.o(.text);  /* 0x08001478 - 0x08001484, SetGameMode_03 */
        src/game/sub_08001484.o(.text);  /* 0x08001484 - 0x080014b8, Scene_Init_04 */
        src/game/sub_080014b8.o(.text);  /* 0x080014b8 - 0x08001508, Scene10_FrameUpdate, Scene10_Exit, Scene10_EntityTick */
        src/system/sub_08001508.o(.text);  /* 0x08001508 - 0x080017a8, Scene11_AttractModeMain (mode-11 handler) + Scene11_ArmModeTransition */
        src/game/sub_080017a8.o(.text);  /* 0x080017a8 - 0x080018f8, Scene05_Init + Scene05_Tick + Scene05_StateTransition + Scene05_Exit + Scene05_EntityDispatch */
        src/game/sub_080018f8.o(.text);  /* 0x080018f8 - 0x080019b4, Scene12_UpdateTileInteraction */
        src/game/sub_080019b4.o(.text);  /* 0x080019b4 - 0x08001d18, Scene12_Main (mode-12 handler) + Scene12_InitPlayState */
        src/game/sub_08001d18.o(.text);  /* 0x08001d18 - 0x08001d54, Scene06_Init */
        src/game/sub_08001d54.o(.text);  /* 0x08001d54 - 0x08001d94, Scene06_Tick */
        src/game/sub_08001d94.o(.text);  /* 0x08001d94 - 0x08001e18, Scene_UpdateAnimState */
        src/game/sub_08001e18.o(.text);  /* 0x08001e18 - 0x08001e24, Scene06_Exit */
        src/game/sub_08001e24.o(.text);
        asm/disasm_0x08001e24.o(.text);  /* 0x08001e24 - 0x08002184, Entity_CollisionProbe (auto-peeled) */
        src/game/sub_08002184.o(.text);  /* 0x08002184 - 0x08002444, Scene13_Update (mode-13 handler) */
        src/game/game_mode.o(.text);     /* 0x08002444 - 0x08002450, SetGameMode_06 */
        src/game/sub_08002450.o(.text);
        src/game/sub_08002524.o(.text);  /* 0x08002524 - 0x08002760, SceneLoop_14 (mode-14 handler) */
        src/game/set_game_mode_07.o(.text);  /* 0x08002760 - 0x0800276c, SetGameMode_07 */
        src/game/sub_0800276c.o(.text);  /* 0x0800276c - 0x08002844, Scene08_Init + Scene08_Tick + Scene08_StateGuard + Scene08_Exit + Scene08_EntityDispatch */
        src/game/mode_15.o(.text);       /* 0x08002844 - 0x08002a5c, Scene15_Main (mode-15 handler) */
        src/game/set_game_mode_08.o(.text);  /* 0x08002a5c - 0x08002a68, SetGameMode_08 */
        src/game/sub_08002a68.o(.text);  /* 0x08002a68 - 0x08002ae8, Mode9_Init + Mode9_Update + Mode9_AdvanceState + sub_08002ADC */
        src/game/sub_08002ae8.o(.text);  /* 0x08002ae8 - 0x08002b58, Scene_EnterLevel */
        src/game/sub_08002b58.o(.text);  /* 0x08002b58 - 0x08002e04, SceneLoop_16 */
        src/game/set_game_mode_09.o(.text);  /* 0x08002e04 - 0x08002e10, SetGameMode_09 */
        src/game/sub_08002e10.o(.text);  /* 0x08002e10 - 0x08002ee8, GameMode10_Init, GameMode10_Tick, GameMode10_StateCallback, GameMode10_Cleanup, GameMode10_TileCheckTick */
        src/game/sub_08002ee8.o(.text);
        asm/disasm_0x08002ee8.o(.text);  /* 0x08002ee8 - 0x080031d4, Scroll_UpdateCameraAlt (auto-peeled) */
        src/game/sub_080031d4.o(.text);  /* 0x080031d4 - 0x08003254, Player_UpdateHorizontalInput */
        src/game/sub_08003254.o(.text);
        src/game/sub_0800336c.o(.text);  /* 0x0800336c - 0x08003668, SceneLoop_17 + Scene17_LoadPart + Scene17_ModeControlInit + Scene17_PauseCheck + Scene17_Exit + Scene17_TileCheck */
        src/game/sub_08003668.o(.text);  /* 0x08003668 - 0x08003864, Scene_UpdateCollisionAndTile */
        src/game/sub_08003864.o(.text);
        asm/disasm_0x08003864.o(.text);  /* 0x08003864 - 0x08003b40, GameMode_Scene18 (auto-peeled) */
        src/game/sub_08003b40.o(.text);
        src/game/sub_08003b8c.o(.text);  /* 0x08003b8c - 0x08003bfc, Mode12_Init */
        src/game/sub_08003bfc.o(.text);  /* 0x08003bfc - 0x08003c38, Scene_InitHitboxes */
        src/game/sub_08003c38.o(.text);  /* 0x08003c38 - 0x08003ca8, Mode12_SetupAndUpdate + sub_08003C9C */
        src/game/sub_08003ca8.o(.text);
        asm/disasm_0x08003ca8.o(.text);  /* 0x08003ca8 - 0x08004074, GameMode_Scene19 (auto-peeled) */
        src/game/set_game_mode_12.o(.text);  /* 0x08004074 - 0x08004080, SetGameMode_12 */
        src/game/sub_08004080.o(.text);
        src/game/sub_080040c4.o(.text);
        src/game/sub_0800411c.o(.text);
        src/game/sub_0800441c.o(.text);
        src/game/sub_08004470.o(.text);
        src/game/sub_08004508.o(.text);  /* 0x08004508 - 0x080045ec, Scene20_UpdateParts + TileCacheProbe_Init + sub_080045E0 */
        src/game/sub_080045ec.o(.text);
        src/game/sub_08004938.o(.text);
        src/game/sub_08004c04.o(.text);  /* 0x08004c04 - 0x08004fac, Mode14_Setup + Mode15_Setup + Mode17_RunFrame + Mode_InitEntityState + Mode_EndScene + SpawnCycle_Update */
        src/game/sub_08004fac.o(.text);
        src/game/set_game_mode_15.o(.text);  /* 0x080052c0 - 0x080052cc, SetGameMode_15 */
        src/game/sub_080052cc.o(.text);
        src/game/sub_08005308.o(.text);
        src/game/sub_0800534c.o(.text);
        src/game/sub_080054a8.o(.text);
        asm/disasm_0x080054a8.o(.text);  /* 0x080054a8 - 0x0800586c, GameMode_Scene23 (auto-peeled) */
        src/game/sub_0800586c.o(.text);
        src/game/sub_080059b0.o(.text);
        src/game/sub_080059c4.o(.text);
        asm/disasm_0x080059c4.o(.text);  /* 0x080059c4 - 0x08005d10, Entity_Update (auto-peeled) */
        src/game/sub_08005d10.o(.text);
        src/game/sub_08005ed8.o(.text);
        src/game/sub_08005fc8.o(.text);
        asm/disasm_0x08005fc8.o(.text);  /* 0x08005fc8 - 0x080063ec, Game_CommitRender (auto-peeled) */
        src/game/sub_080063ec.o(.text);
        src/game/mode_control.o(.text);  /* 0x0800658c - 0x08006600, ModeControl_Init */
        src/game/sub_08006600.o(.text);  /* 0x08006600 - 0x080066c4, CtrlFlags_SetBit */
        src/game/sub_080066c4.o(.text);  /* 0x080066c4 - 0x0800679c, ModeControl_ClearBit */
        src/game/sub_0800679c.o(.text);  /* 0x0800679c - 0x0800690c, ModeControl_GetFlag + CtrlFlags_ReadBitRange */
        src/game/sub_0800690c.o(.text);  /* 0x0800690c - 0x08006948, Entity_InitMotionFields + Entity_OrFlags */
        src/game/sub_08006948.o(.text);  /* 0x08006948 - 0x08006a0c, EntityRec_ClearKeyFlags + EntityRec_TestKeyFlags + ModeControl_SetBit + EventFlags_ClearBit */
        src/game/sub_08006a0c.o(.text);  /* 0x08006a0c - 0x08006a74, Input_DetectHold */
        src/game/sub_08006a74.o(.text);  /* 0x08006a74 - 0x08006adc, PlayerState_Init + PlayerState_SetByte + PlayerState_IncrByteMax10 */
        src/game/sub_08006adc.o(.text);  /* 0x08006adc - 0x08006b64, Timer_DecrByte + Timer_IncrS16Max99 + Timer_IncrS16Wrap + Timer_IncrByteMax12 */
        src/game/sub_08006b64.o(.text);  /* 0x08006b64 - 0x08006b88, Timer_IncrementCheckNeg */
        src/game/sub_08006b88.o(.text);  /* 0x08006b88 - 0x08006fec, PlayerFlags_Set + IwramFlags_Clear + IsFlagMaskSet + EntityScript_BuildSlotData + Entity_TickCells + Entity_ApplyGridMovement */
        asm/disasm_0x080070a0.o(.text);  /* 0x080070a0 - 0x08007138, Entity_ApplyScrollStep (auto-peeled) */
        src/game/sub_08007138.o(.text);
        src/game/sub_08007228.o(.text);  /* 0x08007228 - 0x0800736c, LoadPartEntry + EntityScript_Advance */
        asm/disasm_0x0800736c.o(.text);  /* 0x0800736c - 0x08007660, CollisionTable_CheckAndTriggerScript (auto-peeled) */
        src/game/sub_08007660.o(.text);  /* 0x08007660 - 0x080076a4, Entity_RunScript */
        src/game/sub_080076a4.o(.text);
        src/game/sub_080077ac.o(.text);  /* 0x080077ac - 0x08007874, Entity_SpawnFromConfig */
        src/game/sub_08007874.o(.text);
        src/game/sub_0800793c.o(.text);
        asm/disasm_0x0800793c.o(.text);  /* 0x0800793c - 0x08007dd0, Player_ProbeSpawnDir (auto-peeled) */
        src/game/sub_08007dd0.o(.text);
        src/game/sub_08008174.o(.text);
        asm/disasm_0x08008174.o(.text);  /* 0x08008174 - 0x08008570, Player_UpdatePhysics (auto-peeled) */
        src/game/sub_08008570.o(.text);
        src/game/sub_080087b4.o(.text);
        asm/disasm_0x080089a4.o(.text);  /* 0x080089a4 - 0x08008a5c, Entity_GetDirHitbox (auto-peeled) */
        src/game/sub_08008a5c.o(.text);
        asm/disasm_0x08008a5c.o(.text);  /* 0x08008a5c - 0x08008e84, sub_08008A5C (auto-peeled) */
        src/game/sub_08008e84.o(.text);  /* 0x08008e84 - 0x08008f98, Entity_ProbeDir */
        src/game/sub_08008f98.o(.text);
        src/game/sub_080090b0.o(.text);  /* 0x080090b0 - 0x08009188, Player_UpdateTileCache, Player_InitEntity, Player_NormalizeStatusAndUpdate */
        src/engine/sub_08009188.o(.text);
        asm/disasm_0x08009188.o(.text);  /* 0x08009188 - 0x080094f8, Entity_Advance (auto-peeled) */
        src/engine/sub_080094f8.o(.text);  /* 0x080094f8 - 0x080097fc, Entity_CheckAllCollisions */
        src/engine/sub_080097fc.o(.text);
        src/engine/sub_08009884.o(.text);  /* 0x08009884 - 0x08009984, Player_HandleTileCollision */
        src/game/sub_08009984.o(.text);  /* 0x08009984 - 0x08009ba0, Player_CheckTileEvents + Entity_UpdateVisibility */
        src/game/sub_08009ba0.o(.text);  /* 0x08009ba0 - 0x08009d9c, Player_CheckSpecialTileMatch + Scene_EntityTick + EntityDispatch_RunFrame */
        src/game/sub_08009d9c.o(.text);  /* 0x08009d9c - 0x0800a05c, Scene_InitScan (NAKED+NON_MATCHING) + Entity_UpdateFrame */
        src/engine/sub_0800a05c.o(.text);  /* 0x0800a05c - 0x0800a104, EntityPool_Reset */
        src/engine/sub_0800a104.o(.text);  /* 0x0800a104 - 0x0800a1c8, RunFadeTransition + Entity_RectOverlap */
        src/engine/sub_0800a1c8.o(.text);  /* 0x0800a1c8 - 0x0800a2d8, EntityParam_Reset, Scene_SelectEntityLimit, EntityParam_Apply, Entity_DispatchBC */
        src/game/dispatch_helpers.o(.text);  /* 0x0800a2d8 - 0x0800a458, Game_RunEntityFrame, Game_ForceRender, CmpPair_Compare, Scroll_CheckTileStep */
        src/engine/sub_0800a4d0.o(.text);  /* 0x0800a4d0 - 0x0800a520, Entity_UpdateSlot1Status */
        src/game/sub_0800a520.o(.text);  /* 0x0800a520 - 0x0800a710, Game_UpdateSubsystems + Entity_InitShadow + MotionDesc_Set */
        src/engine/sub_0800a710.o(.text);  /* 0x0800a710 - 0x0800a83c, sub_0800A710, EntityHitbox_FindPoint */
        src/engine/sub_0800a83c.o(.text);  /* 0x0800a83c - 0x0800a910, EntityHitbox_RegisterGridPoints */
        src/engine/sub_0800a9d4.o(.text);  /* 0x0800a9d4 - 0x0800aa70, TileCacheProbe_HandleTile20 */
        src/engine/sub_0800aa70.o(.text);  /* 0x0800aa70 - 0x0800ab84, Gate_HandleGateTile */
        src/engine/sub_0800ab84.o(.text);  /* 0x0800ab84 - 0x0800af50, FrogPad_CheckTile/TileCollect_OnStep/TileArrival_UpdateModeFlags/Gate_OnTileStep */
        src/engine/sub_0800af50.o(.text);  /* 0x0800af50 - 0x0800b178, Entity_InitHitboxSlots/Gate_PollResult */
        asm/disasm_0x0800b178.o(.text);  /* 0x0800b178 - 0x0800b7b0, Entity_BlitAndCheckTiles (auto-peeled) */
        src/engine/sub_0800b7b0.o(.text);
        src/engine/sub_0800b8a8.o(.text);  /* 0x0800b8a8 - 0x0800b918, Entity_ActivateHitSlot */
        src/engine/sub_0800b918.o(.text);
        asm/disasm_0x0800b918.o(.text);  /* 0x0800b918 - 0x0800be18, Entity_UpdateHitboxWithTile (auto-peeled) */
        src/engine/sub_0800be18.o(.text);  /* 0x0800be18 - 0x0800bf24, Entity_SetupHitboxSlots / EntityHitbox_RegisterHit */
        src/engine/sub_0800bf24.o(.text);
        asm/disasm_0x0800bf24.o(.text);  /* 0x0800bf24 - 0x0800c2a8, Entity_ScanHitboxAndBlit (auto-peeled) */
        src/engine/sub_0800c2a8.o(.text);  /* 0x0800c2a8 - 0x0800c358, sub_0800C2A8, sub_0800C2D0 */
        src/engine/sub_0800c358.o(.text);  /* 0x0800c358 - 0x0800c444, Frog_ProcessTileContact, UpdateSceneGate */
        src/engine/sub_0800c444.o(.text);  /* 0x0800c444 - 0x0800c4a0, Scene_OnPlayerStepTile20 */
        src/engine/sub_0800c4a0.o(.text);  /* 0x0800c4a0 - 0x0800c4e8, Stage_BuildActiveSlotMask / EntityProc_Nop / EntityProcE_Nop */
        src/engine/sub_0800c4e8.o(.text);
        src/engine/sub_0800c978.o(.text);
        src/engine/sub_0800cb80.o(.text);  /* 0x0800cb80 - 0x0800cd88, SpriteGrid_SetCellFlags/BgMap_WriteTileAttr and sibling grid writers */
        src/engine/sub_0800cd88.o(.text);
        src/engine/sub_0800cdcc.o(.text);
        src/engine/sub_0800ce10.o(.text);
        src/engine/sub_0800ce54.o(.text);
        src/engine/sub_0800ce98.o(.text);
        src/engine/sub_0800ced0.o(.text);  /* 0x0800ced0 - 0x0800cfdc, Rect_PointInRect (NAKED+NON_MATCHING) */
        src/engine/sub_0800cfdc.o(.text);
        src/engine/sub_0800d028.o(.text);
        src/engine/sub_0800d0f8.o(.text);
        src/engine/sub_0800d1f8.o(.text);  /* 0x0800d1f8 - 0x0800d270, GateRoom_TickFrogUpdate */
        src/engine/sub_0800d270.o(.text);
        src/engine/sub_0800d2c0.o(.text);
        src/engine/sub_0800d450.o(.text);
        asm/disasm_0x0800d450.o(.text);  /* 0x0800d450 - 0x0800d808, PadGrid_FillGrid (auto-peeled) */
        src/engine/sub_0800d808.o(.text);  /* 0x0800d808 - 0x0800d8a0, PadGrid_RemoveRandom */
        src/engine/sub_0800d8a0.o(.text);  /* 0x0800d8a0 - 0x0800d9fc, SpawnControl_Dispatch, PadGrid_ScanMaskToCoord, PadGrid_RandomizeAndSyncEntityCoords */
        src/engine/sub_0800d9fc.o(.text);
        asm/disasm_0x0800dab8.o(.text);  /* 0x0800db04 - 0x0800dc3c, PadGrid_SlotToCoord cluster (auto-peeled) */
        src/engine/sub_0800dc3c.o(.text);
        asm/disasm_0x0800dc3c.o(.text);  /* 0x0800dc3c - 0x0800dc50, sub_0800DC3C (auto-peeled) */
        src/engine/sub_0800dc50.o(.text);
        src/engine/sub_0800dd80.o(.text);  /* 0x0800dd80 - 0x0800de0c, WorldMap_Init */
        src/engine/sub_0800de80.o(.text);  /* 0x0800de80 - 0x0800df7c, Game_FrameEnd */
        src/engine/sub_0800df7c.o(.text);  /* 0x0800df7c - 0x0800dffc, EntityProcE_Dispatch, EntityProcE_Init, EntityProcE_Run */
        src/engine/sub_0800dffc.o(.text);  /* 0x0800dffc - 0x0800e048, Fixed8Mul, Fixed16Mul, Fixed8Div */
        src/engine/sub_0800e048.o(.text);
        src/engine/sub_0800e060.o(.text);  /* 0x0800e060 - 0x0800e174, Scene_LoadBg */
        src/engine/sub_0800e174.o(.text);  /* 0x0800e174 - 0x0800e4bc, UpdateBgTilemapFrames (NAKED+NON_MATCHING) */
        src/engine/sub_0800e4bc.o(.text);  /* 0x0800e4bc - 0x0800e600, AnimCtrl_RunPhase */
        src/engine/sub_0800e600.o(.text);  /* 0x0800e600 - 0x0800e6a8, Scene08_MapScreenInit */
        src/engine/sub_0800e6a8.o(.text);  /* 0x0800e6a8 - 0x0800e85c, Scene_FadeUpdate + text_0800e76c + SetModeBlendRegs */
        src/engine/sub_0800e85c.o(.text);
        src/engine/sub_0800eb1c.o(.text);  /* 0x0800eb1c - 0x0800ebdc, FrogOam_Init */
        src/engine/sub_0800ebdc.o(.text);
        src/engine/sub_0800ee34.o(.text);  /* 0x0800ee34 - 0x0800ee94, BgLayer_Disable */
        src/engine/sub_0800ee94.o(.text);  /* 0x0800ee94 - 0x0800ef58, BgLayer_Enable + Bg_SetLayersByMode */
        src/engine/sub_0800ef58.o(.text);  /* 0x0800ef58 - 0x0800ef90, SceneReset */
        src/engine/sub_0800ef90.o(.text);  /* 0x0800ef90 - 0x0800f014, Scene_DisableBg2 + SceneInit_WithHud + SceneInit */
        src/engine/sub_0800f014.o(.text);  /* 0x0800f014 - 0x0800f24c, InitScreenBgGraphics + InitCharacterBgGraphics + InitAllBgTilemapLayers */
        src/engine/sub_0800f24c.o(.text);
        src/engine/sub_0800f2f8.o(.text);
        src/engine/sub_0800f398.o(.text);
        asm/disasm_0x0800f398.o(.text);  /* 0x0800f398 - 0x0800f814, ScrollUpdate_Pass1 (auto-peeled) */
        src/engine/sub_0800f814.o(.text);
        asm/disasm_0x0800f814.o(.text);  /* 0x0800f814 - 0x0800fcc8, ScrollUpdate_Pass0 (auto-peeled) */
        src/engine/sub_0800fcc8.o(.text);
        src/engine/sub_0800fd50.o(.text);  /* 0x0800fd50 - 0x0800fe10, Scene08_MapScreenTick (extended-pool range; 7 trailing words land in .o pool) */
        src/engine/sub_0800fe88.o(.text);
        src/engine/sub_080100e4.o(.text);
        src/engine/sub_0801025c.o(.text);
        asm/disasm_0x0801025c.o(.text);  /* 0x0801025c - 0x080105b0, ScaleAnim_BlitFrameToVram (auto-peeled) */
        src/engine/sub_080105b0.o(.text);
        src/engine/sub_08010694.o(.text);
        src/engine/sub_080106b8.o(.text);  /* 0x080106b8 - 0x08010958, Blend_StepFade + Screen_BeginFlash + Screen_TickFlash + Render_UpdateBlendRegs + Pal_RotateEntries + Render_DmaLoadTileset + WrapBufPtr + Anim_AdvanceFrameStep + Anim_TickFrame */
        src/engine/sub_08010958.o(.text);
        src/engine/sub_08010a44.o(.text);
        asm/disasm_0x08010a44.o(.text);  /* 0x08010a44 - 0x08010dd8, Scroll_TickChannels (auto-peeled) */
        src/engine/sub_08010dd8.o(.text);
        src/engine/sub_08010f64.o(.text);
        asm/text/text_0x08011288.o(.text);  /* 0x08011288 - 0x0801129c, raw bytes */
        src/engine/sub_0801129c.o(.text);  /* 0x0801129c - 0x080112c0, Scroll_ResetDirStep */
        src/engine/sub_080112c0.o(.text);  /* 0x080112c0 - 0x080113e8, BlitFrameCell */
        src/engine/sub_080113e8.o(.text);  /* 0x080113e8 - 0x08011574, GenRandomTileMask + Blit_ApplyFlaggedRecords + Selector_InitState */
        src/engine/sub_08011574.o(.text);  /* 0x08011574 - 0x080116b8, Selector_StepBlitAnim + Selector_RunAnimSequence */
        src/engine/sub_080116b8.o(.text);  /* 0x080116b8 - 0x0801185c, Selector_BlitStateMachine */
        src/engine/sub_0801185c.o(.text);  /* 0x0801185c - 0x08011984, GetVcountRandom + Anim_CheckScreenIdle + Selector_InitScene + Selector_Update + Selector_StepScroll + Selector_VblankTick */
        src/engine/sub_08011984.o(.text);  /* 0x08011984 - 0x08011aa4, Selector_BlitTiles (NAKED+NON_MATCHING) */
        src/engine/sub_08011aa4.o(.text);
        asm/disasm_0x08011aa4.o(.text);  /* 0x08011aa4 - 0x08011e40, Selector_UpdateBlit (auto-peeled) */
        src/engine/sub_08011e40.o(.text);
        src/engine/sub_08012098.o(.text);  /* 0x08012098 - 0x0801223c, Selector_StepColorFade + Selector_ResetState + UpdateScrollFromAnimChannels */
        src/engine/sub_0801223c.o(.text);  /* 0x0801223c - 0x080124d0, InitScrollAnimSequence + RunScrollTransitionSequence */
        src/engine/sub_080124d0.o(.text);  /* 0x080124d0 - 0x08012504, AnimChannels_Reset */
        asm/disasm_0x080122e4.o(.text);  /* 0x08012504 - 0x0801254c, sub_08012504 (auto-peeled) */
        src/engine/sub_0801254c.o(.text);
        src/engine/sub_0801255c.o(.text);
        asm/disasm_0x080125b0.o(.text);  /* 0x080125b0 - 0x08012604, sub_080125B0 (auto-peeled) */
        src/engine/sub_08012604.o(.text);
        src/engine/sub_08012664.o(.text);
        src/engine/sub_0801288c.o(.text);
        src/engine/sub_0801297c.o(.text);
        src/engine/sub_08012a6c.o(.text);
        src/engine/sub_08012b38.o(.text);  /* 0x08012b38 - 0x08012bc4, LoadScreenTilemap_188EDC + ScrollState_Reset + Scene_Init2Layer + sub_08012BB4 */
        src/engine/sub_08012bc4.o(.text);  /* 0x08012bc4 - 0x08012cac, Tilemap_BlitTileRows */
        src/engine/sub_08012cac.o(.text);
        src/engine/sub_08012d40.o(.text);
        src/engine/sub_08012d88.o(.text);
        src/engine/sub_08012e64.o(.text);
        src/engine/sub_08012f00.o(.text);  /* 0x08012f00 - 0x08012fa0, RemapInputBits */
        src/engine/sub_08012fa0.o(.text);  /* 0x08012fa0 - 0x08013040, ScaleAnim_ClearActiveBits */

        src/engine/sub_08013040.o(.text);  /* 0x08013040 - 0x0801310c, ScaleAnim_TickFrames */
        src/engine/sub_0801310c.o(.text);
        src/engine/sub_080132e8.o(.text);
        src/engine/sub_080135b8.o(.text);
        src/engine/sub_08013694.o(.text);
        src/engine/sub_0801377c.o(.text);  /* 0x0801377c - 0x08013880, BgLayer_Init + ScaleAnim_Reset */
        src/engine/sub_08013880.o(.text);
        src/engine/sub_08013898.o(.text);  /* 0x08013898 - 0x08013908, ScaleAnim_UpdateFrame */
        src/engine/sub_08013908.o(.text);  /* 0x08013908 - 0x08013980, AnimTile_ResetAndClearBg, Array_ThrottledRotate */
        src/engine/sub_08013980.o(.text);
        src/engine/sub_080139bc.o(.text);  /* 0x080139bc - 0x080139f8, ScaleAnim_BlitDescIdx1 */
        src/engine/sub_080139f8.o(.text);
        src/engine/sub_08013aac.o(.text);
        src/engine/sub_08013d1c.o(.text);
        src/engine/sub_08013e94.o(.text);  /* 0x08013e94 - 0x08013f68, Deck_DealRandom + Deck_Init + Deck_ResetFirst */
        src/engine/sub_08013f68.o(.text);
        src/engine/sub_08013f94.o(.text);
        src/engine/sub_08013fa0.o(.text);
        src/engine/sub_08014020.o(.text);
        src/engine/sub_08014064.o(.text);
        src/engine/sub_08014078.o(.text);
        src/engine/sub_08014140.o(.text);
        src/engine/sub_080142d4.o(.text);
        asm/disasm_0x0801436c.o(.text);  /* 0x0801436c - 0x08014ea8, Gate_RunAnimSequence (auto-peeled) */
        src/engine/sub_08014ea8.o(.text);  /* 0x08014ea8 - 0x08014ee8, Display_ResetLayers */
        asm/disasm_0x08014ee8.o(.text);  /* 0x08014ee8 - 0x08015044, EnemySpawn_ProcessWaveA (auto-peeled) */
        src/engine/sub_08015044.o(.text);
        asm/disasm_0x08015044.o(.text);  /* 0x08015044 - 0x08015194, EnemySpawn_ProcessWaveB (auto-peeled) */
        src/engine/sub_08015194.o(.text);
        src/engine/sub_080152b0.o(.text);
        src/engine/sub_0801549c.o(.text);
        src/engine/sub_080155f0.o(.text);
        src/engine/sub_0801585c.o(.text);  /* 0x0801585c - 0x08015930, Scenery_UpdateSelectorCells */
        src/engine/sub_08015930.o(.text);  /* 0x08015930 - 0x08015a00, Tilemap_DispatchPendingBlits + Scenery_InitScrollState */
        src/engine/sub_08015a00.o(.text);
        src/engine/sub_08015b6c.o(.text);
        src/engine/sub_08015c24.o(.text);  /* 0x08015c24 - 0x08015cbc, BlitTilesRect */
        src/engine/sub_08015cbc.o(.text);
        src/engine/sub_08015d30.o(.text);
        src/engine/sub_08015d54.o(.text);
        asm/disasm_0x08015d84.o(.text);  /* 0x08015d84 - 0x08015ea4, sub_08015D84 (auto-peeled) */
        src/engine/sub_08015ea8.o(.text);
        src/engine/sub_08015ec4.o(.text);  /* 0x08015ec4 - 0x08016074, sub_08015EC4 + sub_08015F9C (NON_MATCHING/NAKED) */
        asm/disasm_0x08016074.o(.text);  /* 0x08016074 - 0x0801621c, sub_08016074 + sub_0801616C */
        src/engine/sub_0801621c.o(.text);
        src/engine/sub_0801629c.o(.text);  /* 0x0801629c - 0x08016360, sub_0801629C + sub_080162FC (NON_MATCHING/NAKED) */
        src/engine/sub_08016360.o(.text);  /* 0x08016360 - 0x08016404, EntitySlots_Init */
        src/engine/sub_08016404.o(.text);
        src/engine/sub_08016650.o(.text);  /* 0x08016650 - 0x08016824, Icon_LoadFrameByMode */
        src/engine/sub_08016824.o(.text);
        src/engine/sub_080169bc.o(.text);
        src/engine/sub_08016a40.o(.text);
        asm/disasm_0x08016a40.o(.text);  /* 0x08016a40 - 0x08017000, StatusBar_Update (auto-peeled) */
        src/engine/sub_08017000.o(.text);
        src/engine/sub_080172f4.o(.text);  /* 0x080172f4 - 0x08017364, SaveDetect */
        src/engine/sub_08017364.o(.text);
        src/engine/sub_080177a0.o(.text);
        src/engine/sub_0801793c.o(.text);  /* 0x0801793c - 0x080179b8, GameMode_Attract */
        src/engine/sub_080179b8.o(.text);
        src/engine/sub_08017a88.o(.text);  /* 0x08017a88 - 0x08017aa8, Attract_StepFinish */
        src/engine/sub_08017aa8.o(.text);  /* 0x08017aa8 - 0x08017abc, Attract_Cleanup */
        src/engine/sub_08017abc.o(.text);  /* 0x08017abc - 0x08017b68, UiScreen_Init */
        asm/disasm_0x08017b68.o(.text);  /* 0x08017b68 - 0x08017bfc, sub_08017B68 (auto-peeled) */
        src/engine/sub_08017bfc.o(.text);  /* ... - 0x08018188, + sub_08017FC4 */
        asm/disasm_0x08018188.o(.text);  /* 0x08018188 - 0x080181d0, sub_08018188 (auto-peeled) */
        src/engine/sub_080181d0.o(.text);
        src/engine/sub_080182cc.o(.text);  /* 0x080182cc - 0x080184dc, CreditsMenu_HandleInputA, CreditsScreen_Init, CreditsMenu_HandleInputB, Bg_InitMode0 */
        src/engine/sub_080184dc.o(.text);  /* 0x080184dc - 0x080185c0, Tilemap_SwapPalette */
        src/engine/sub_080185c0.o(.text);
        src/engine/sub_0801932c.o(.text);  /* 0x0801932c - 0x080193d8, TitleLogo_Display */
        src/engine/sub_08019420.o(.text);
        asm/disasm_0x080193d8.o(.text);  /* 0x080193d8 - 0x08019500, Menu25_InitKeyTable + Menu25_PollInput (auto-peeled) */
        src/engine/sub_08019500.o(.text);  /* 0x08019500 - 0x08019540, GameMode_Router */
        src/engine/sub_08019540.o(.text);  /* 0x08019540 - 0x08019560, GameMode_Menu26 */
        src/engine/sub_08019560.o(.text);  /* 0x08019560 - 0x08019834, GameMode_Menu25 + Menu25_WaitFadeIn + Menu25_ReloadStatusBarBg + Menu25_ResetAfterFade + Menu25_AdvanceSubstate + Menu25_AdvanceAndReturn + Menu25_ReturnToRouter + Menu25_Enter + Menu25_Nop + TileBlit + BgTilemap_BlitRectClipped */
        src/engine/sub_08019834.o(.text);  /* 0x08019834 - 0x08019964, Sprite_AnimateFlip + Sprite_AnimateFlipWithShadow + SetCurrentLevel */
        src/engine/sub_08019964.o(.text);  /* 0x08019964 - 0x08019984, TitleScene_InitRng */
        src/engine/sub_080199e4.o(.text);
        asm/text/text_0x08019a14.o(.text);  /* 0x08019a14 - 0x08019aec, raw bytes */
        src/engine/sub_08019aec.o(.text);
        src/engine/sub_08019db4.o(.text);  /* 0x08019db4 - 0x08019e6c, Display_RestoreState + Display_EnableBg */
        src/engine/sub_08019e6c.o(.text);  /* 0x08019e6c - 0x0801a268, BgBuffer_ApplyPending + LoadRoomBg3Graphics + BgPlane_FillTilemap + RoomSelect_InitDisplay + WinPose_Init + MapCursor_Step */
        src/engine/sub_0801a268.o(.text);
        asm/disasm_0x0801a268.o(.text);  /* 0x0801a268 - 0x0801a614, GameMode_WorldMap (auto-peeled) */
        src/engine/sub_0801a614.o(.text);
        src/engine/sub_0801a6d4.o(.text);
        src/engine/sub_0801a774.o(.text);
        src/engine/sub_0801a894.o(.text);
        src/engine/sub_0801a980.o(.text);  /* IrisClose + Credits_DmaLoadTiles + LevelSelect_Enter */
        src/engine/sub_0801ac84.o(.text);
        src/engine/sub_0801ada8.o(.text);  /* 0x0801ada8 - 0x0801b0ac, Credits_RunScript (NAKED+NON_MATCHING) */
        src/engine/sub_0801b0ac.o(.text);
        src/engine/sub_0801b154.o(.text);
        src/engine/sub_0801b514.o(.text);  /* 0x0801b514 - 0x0801b71c, RunWorldSelectTransition + sub_0801B620 + sub_0801B694 */
        asm/text/text_0x0801b71c.o(.text);  /* 0x0801b71c - 0x0801b954, raw bytes (shrunk for Scene_SetupWindows peel) */
        src/engine/sub_0801b954.o(.text);
        src/engine/sub_0801b9e4.o(.text);
        src/engine/sub_0801bac8.o(.text);
        src/engine/sub_0801badc.o(.text);
        src/engine/sub_0801bb1c.o(.text);
        src/engine/sub_0801bb54.o(.text);
        src/engine/sub_0801be7c.o(.text);
        asm/disasm_0x0801be7c.o(.text);  /* 0x0801be7c - 0x0801c078, DrawTextGlyphs (auto-peeled) */
        src/engine/sub_0801c078.o(.text);
        src/engine/sub_0801c2b4.o(.text);
        src/engine/sub_0801c464.o(.text);
        asm/disasm_0x0801c6fc.o(.text);  /* 0x0801c6fc - 0x0801cd0c, sub_0801C6FC (auto-peeled) */
        src/engine/sub_0801cd0c.o(.text);
        src/engine/sub_0801cec0.o(.text);
        src/engine/sub_0801cf18.o(.text);  /* 0x0801cf18 - 0x0801cfa0, DrawByteDecimal */
        src/engine/sub_0801cfa0.o(.text);  /* 0x0801cfa0 - 0x0801d048, Bg_WriteTilePair */
        src/engine/sub_0801d048.o(.text);
        src/engine/sub_0801d094.o(.text);
        src/engine/sub_0801d150.o(.text);
        src/engine/sub_0801d268.o(.text);  /* 0x0801d268 - 0x0801d33c, Credits_LoadBgGfx */
        src/engine/sub_0801d33c.o(.text);
        src/engine/sub_0801d4cc.o(.text);  /* 0x0801d4cc - 0x0801d570, Credits_InitScrollPage1 */
        src/engine/sub_0801d570.o(.text);
        src/engine/sub_0801d880.o(.text);
        src/engine/sub_0801da1c.o(.text);
        src/engine/sub_0801dbb4.o(.text);
        src/engine/sub_0801dea0.o(.text);
        src/engine/sub_0801e078.o(.text);  /* 0x0801e078 - 0x0801e118, Credits_FadeTransition */
        src/engine/sub_0801e118.o(.text);  /* 0x0801e118 - 0x0801e270, Screen_FadeSequence + Credits_Tick + Credits_FillPage */
        src/engine/sub_0801e270.o(.text);  /* 0x0801e270 - 0x0801e28c, WaitFrames */
        src/engine/sub_0801e28c.o(.text);
        asm/disasm_0x0801e28c.o(.text);  /* 0x0801e28c - 0x0801ea08, Level_Load (auto-peeled) */
        src/engine/sub_0801ea08.o(.text);
        asm/disasm_0x0801ea08.o(.text);  /* 0x0801ea08 - 0x0801f1e0, sub_0801EA08 (auto-peeled) */
        src/engine/sub_0801f1e0.o(.text);
        src/engine/sub_0801f418.o(.text);
        src/engine/sub_0801f684.o(.text);
        src/engine/sub_0801f8bc.o(.text);
        asm/disasm_0x0801f970.o(.text);  /* 0x0801f970 - 0x0801fd0c, SaveSlot_UpdateScreen (auto-peeled) */
        src/engine/sub_0801fd0c.o(.text);  /* 0x0801fd0c - 0x080200b4, WinPoseScreen_Init + WinPoseScreen_Update */
        src/engine/sub_080200b4.o(.text);  /* 0x080200b4 - 0x080201a8, WinPoseScreen_DrawBg */

        src/engine/sub_080201a8.o(.text);  /* 0x080201a8 - 0x080201c8, GameMode_Options */
        src/engine/sub_080201c8.o(.text);
        src/engine/sub_080201e8.o(.text);  /* 0x080201e8 - 0x080202a8, GameMode_Menu27 + Dispatcher_ResetModeA + Dispatcher_ResetModeB + Dispatcher_ResetModeC */
        src/engine/sub_080202a8.o(.text);  /* 0x080202a8 - 0x080202f8, GameMode_FileSelect + SaveMenu_ResetDispatcher */
        src/engine/sub_080204a4.o(.text);
        src/engine/sub_080205d8.o(.text);  /* 0x080205d8 - 0x0802090c, Entity_DispatchSound */
        src/game/sub_0802090c.o(.text);  /* 0x0802090c - 0x08020b30, Entity_PlayStateSound */
        src/game/sub_08020b30.o(.text);  /* 0x08020b30 - 0x08020b60, SoundMixer_Init + SoundMixer_Stop */
        src/system/sub_08020b60.o(.text);  /* 0x08020b60 - 0x08020b88, SoundSystem_StopAll + SoundSystem_FadeOut */
        src/engine/sub_08020b88.o(.text);  /* 0x08020b88 - 0x08020bac, Sound_PlayIfEnabled */
        src/engine/sub_08020bac.o(.text);  /* 0x08020bac - 0x08020bc0, Sound_DrainIfActive */
        src/engine/sub_08020bc0.o(.text);  /* 0x08020bc0 - 0x08020c78, Sound_ServiceQueue + SoundSlot_SetVolumeByte + Sound_ClearActiveFlag + SoundSlot_EnableAndLoad + Music_Stop + Music_Resume */
        src/engine/sub_08020c78.o(.text);  /* 0x08020c78 - 0x08020dc4, Sound_Play + Sound_PlayWithPan + Sound_PlayNearEntity + Entity_PlaySoundOnScreenEnter + Sound_ReplaySlotEntry */
        src/engine/sub_08020dc4.o(.text);  /* 0x08020dc4 - 0x08020e7c, SoundEntry_Play + Entity_CheckProximityAndPlaySound */
        src/engine/sub_08020e7c.o(.text);  /* 0x08020e7c - 0x08020e98, SoundEntry_Stop */
        src/system/sub_08020e98.o(.text);  /* 0x08020e98 - 0x08020ee4, SoundChannel_BroadcastValue + SoundChannelTable_SetCounter */
        src/engine/sub_08020ee4.o(.text);  /* 0x08020ee4 - 0x08020f08, Sound_IncrementChannelDepth */
        src/engine/sub_08020f08.o(.text);  /* 0x08020f08 - 0x08020f3c, Sound_DecrementChannelDepth */
        src/engine/sub_08020f3c.o(.text);
        src/engine/sub_080210a0.o(.text);
        asm/disasm_0x080210a0.o(.text);  /* 0x080210a0 - 0x08021140, Entity_InitSlotFromRecord (auto-peeled) */
        src/engine/sub_08021140.o(.text);
        asm/disasm_0x08021140.o(.text);  /* 0x08021140 - 0x08021510, LevelLayout_WalkRecords (auto-peeled) */
        src/engine/sub_08021510.o(.text);
        src/engine/sub_080217d4.o(.text);  /* 0x080217d4 - 0x08021838, Entity_WaypointDirectionCompare */
        src/engine/sub_08021838.o(.text);
        src/engine/sub_080219bc.o(.text);  /* 0x080219bc - 0x08021ac8, Entity_FollowPath */
        asm/disasm_0x08021ac8.o(.text);  /* 0x08021ac8 - 0x08021cfc, sub_08021AC8 (auto-peeled) */
        src/engine/sub_08021cfc.o(.text);
        src/engine/sub_08021e34.o(.text);  /* 0x08021e34 - 0x08021ec0, Entity_IsInTileRange */
        src/engine/sub_08021ec0.o(.text);  /* 0x08021ec0 - 0x08021eec, TileEntry_CalcDirection */
        src/engine/sub_08021eec.o(.text);  /* 0x08021eec - 0x08021f64, Entity_InitFromLayout, DirToMotion */
        src/engine/sub_08021f64.o(.text);  /* 0x08021f64 - 0x0802205c, LevelLayout_LoadSlots3113C8 */
        src/engine/sub_0802205c.o(.text);  /* 0x0802205c - 0x080220c4, LevelLayout_LoadSlots311074 */
        src/engine/sub_080220c4.o(.text);  /* 0x080220c4 - 0x08022160, SpawnDispatchedEntities */
        src/engine/sub_08022160.o(.text);  /* 0x08022160 - 0x080221fc, SpawnEntitiesIfScrolled */
        src/engine/sub_080221fc.o(.text);  /* 0x080221fc - 0x080222bc, SpawnVarHeightEntities */
        src/engine/sub_080222bc.o(.text);  /* 0x080222bc - 0x08022360, SpawnRowGroupEntities */
        src/engine/sub_08022360.o(.text);  /* 0x08022360 - 0x08022434, InitSpecialEntitySlots */
        src/engine/sub_08022434.o(.text);
        src/engine/sub_08022730.o(.text);  /* 0x08022730 - 0x08022758, SpawnEntitySlot2 */
        src/engine/sub_08022758.o(.text);  /* 0x08022758 - 0x0802277c, SpawnZone_Slot02 */
        src/engine/sub_0802277c.o(.text);  /* 0x0802277c - 0x080228ac, UpdateZone_Slots36to3D + StreamInit_Slot2F + SpawnZone_Slot2F + UpdateZone_Slots19to26 + StreamInit_Slots3Eto44 + StreamInit_Slot05 */
        src/engine/sub_080228ac.o(.text);  /* 0x080228ac - 0x080228d0, SpawnZone_Slot05 */
        src/engine/sub_080228d0.o(.text);  /* 0x080228d0 - 0x080228fc, SpawnEntitySlot47 */
        src/engine/sub_080228fc.o(.text);  /* 0x080228fc - 0x08022b4c, SpawnZone_Slot47 + UpdateZone_Slots4Cto53 + StreamInit_Slot02 + Pickup_LoadSlotGroup_2 + StreamInit_Slot06 + Pickup_LoadSlotGroup_6 + UpdateZone_Slots3Eto44 + SpawnNearbyEntities + StreamInit_Slot59 + SpawnZone_Slot59 + LevelLayout_StreamInit */
        src/engine/sub_08022b4c.o(.text);
        src/engine/sub_08022bb0.o(.text);  /* ... + EntityGroup_UpdateMovers */
        src/engine/sub_08022ea8.o(.text);  /* 0x08022ea8 - 0x08022f4c, LevelLayout_SpawnGroup311C80 */
        src/engine/sub_08022f4c.o(.text);
        src/engine/sub_08022fec.o(.text);
        src/engine/sub_080231f4.o(.text);
        src/engine/sub_0802321c.o(.text);
        src/engine/sub_08023244.o(.text);
        src/engine/sub_080232cc.o(.text);  /* 0x080232cc - 0x08023334, LevelLayout_InitGroup311C80 */
        src/engine/sub_08023334.o(.text);  /* 0x08023334 - 0x08023360, StreamInit_Slot43 */
        src/engine/sub_08023360.o(.text);
        src/engine/sub_08023384.o(.text);
        src/engine/sub_080233b0.o(.text);
        src/engine/sub_080233d4.o(.text);
        src/engine/sub_0802349c.o(.text);
        src/engine/sub_080234e8.o(.text);
        src/engine/sub_08023538.o(.text);
        src/engine/sub_08023594.o(.text);  /* 0x08023594 - 0x080235c8, LevelLayout_Update */
        src/engine/sub_080235c8.o(.text);  /* 0x080235c8 - 0x080236f4, LevelEntityBatch_SpawnAndClassify + LevelEntity_AnimAndSpawn */
        src/engine/sub_080236f4.o(.text);
        src/engine/sub_08023ab4.o(.text);  /* 0x08023ab4 - 0x08023bc0, LevelEntities_SpawnGroup10 */
        src/engine/sub_08023bc0.o(.text);
        asm/disasm_0x08023bc0.o(.text);  /* 0x08023bc0 - 0x08023f68, sub_08023BC0 (auto-peeled) */
        src/engine/sub_08023f68.o(.text);
        src/engine/sub_08023fac.o(.text);  /* 0x08023fac - 0x08023ff8, LevelLayout_312D60_UpdateEntities */
        src/engine/sub_08023ff8.o(.text);
        src/engine/sub_08024024.o(.text);
        src/engine/sub_08024048.o(.text);
        src/engine/sub_08024070.o(.text);
        src/engine/sub_08024094.o(.text);
        src/engine/sub_080240e0.o(.text);
        src/engine/sub_08024138.o(.text);
        src/engine/sub_08024180.o(.text);
        src/engine/sub_080241cc.o(.text);  /* 0x080241cc - 0x08024234, LevelLayout_InitEntities59 */
        src/engine/sub_08024234.o(.text);
        src/engine/sub_08024260.o(.text);
        src/engine/sub_080242ac.o(.text);
        src/engine/sub_080242d8.o(.text);
        src/engine/sub_08024304.o(.text);  /* 0x08024304 - 0x080243d4, InitEntitySlot65 + InitEntitySlots0A_13 */
        src/engine/sub_080243d4.o(.text);
        src/engine/sub_08024444.o(.text);
        asm/disasm_0x08024470.o(.text);  /* 0x08024470 - 0x08024494, sub_08024470 (auto-peeled) */
        asm/text/text_0x08024494.o(.text);  /* 0x08024494 - 0x080244f8, raw bytes */
        asm/disasm_0x080244f8.o(.text);  /* 0x080244f8 - 0x08024534, sub_080244F8 (auto-peeled) */
        asm/disasm_0x08024534.o(.text);  /* 0x08024534 - 0x080247ac, sub_08024534 (peeled) */
        asm/disasm_0x080247ac.o(.text);  /* 0x080247ac - 0x080247d4, sub_080247AC (peeled) */
        asm/disasm_0x080247d4.o(.text);  /* 0x080247d4 - 0x080247f8, sub_080247D4 (peeled) */
        asm/disasm_0x080247f8.o(.text);  /* 0x080247f8 - 0x08024820, sub_080247F8 (peeled) */
        asm/disasm_0x08024820.o(.text);  /* 0x08024820 - 0x08024844, sub_08024820 (peeled) */
        asm/disasm_0x08024844.o(.text);  /* 0x08024844 - 0x0802486c, sub_08024844 (peeled) */
        asm/text/text_0x0802486c.o(.text);  /* 0x0802486c - 0x08024890, raw bytes */
        asm/disasm_0x08024890.o(.text);  /* 0x08024890 - 0x080248e4, sub_08024890 (peeled) */
        asm/disasm_0x080248e4.o(.text);  /* 0x080248e4 - 0x0802491c, sub_080248E4 (peeled) */
        asm/disasm_0x0802491c.o(.text);  /* 0x0802491c - 0x08024970, sub_0802491C (peeled) */
        asm/disasm_0x08024970.o(.text);  /* 0x08024970 - 0x080249a8, sub_08024970 (peeled) */
        asm/disasm_0x080249a8.o(.text);  /* 0x080249a8 - 0x080249e8, sub_080249A8 (peeled) */
        asm/disasm_0x080249e8.o(.text);  /* 0x080249e8 - 0x08024a20, sub_080249E8 (peeled) */
        asm/disasm_0x08024a20.o(.text);  /* 0x08024a20 - 0x08024a48, sub_08024A20 (peeled) */
        asm/disasm_0x08024a48.o(.text);  /* 0x08024a48 - 0x08024a6c, sub_08024A48 (peeled) */
        asm/disasm_0x08024a6c.o(.text);  /* 0x08024a6c - 0x08024a98, sub_08024A6C (peeled) */
        asm/disasm_0x08024a98.o(.text);  /* 0x08024a98 - 0x08024ac4, sub_08024A98 (peeled) */
        asm/disasm_0x08024ac4.o(.text);  /* 0x08024ac4 - 0x08024ae8, sub_08024AC4 (peeled) */
        asm/disasm_0x08024ae8.o(.text);  /* 0x08024ae8 - 0x08024b3c, sub_08024AE8 (peeled) */
        asm/disasm_0x08024b3c.o(.text);  /* 0x08024b3c - 0x08024b68, sub_08024B3C (auto-peeled) */
        asm/disasm_0x08024b68.o(.text);  /* 0x08024b68 - 0x08024cd0, sub_08024B68 */
        asm/disasm_0x08024cd0.o(.text);  /* 0x08024cd0 - 0x08024dbc, sub_08024CD0 (peeled) */
        asm/text/text_0x08024dbc.o(.text);  /* 0x08024dbc - 0x08024fd0, raw bytes (shrunk for sub_08024FD0 peel) */
        asm/disasm_0x08024fd0.o(.text);  /* 0x08024fd0 - 0x0802508c, sub_08024FD0 (peeled) */
        asm/disasm_0x0802508c.o(.text);  /* 0x0802508c - 0x08025180, sub_0802508C (peeled) */
        asm/disasm_0x08025180.o(.text);  /* 0x08025180 - 0x080251a8, sub_08025180 (peeled) */
        asm/disasm_0x080251a8.o(.text);  /* 0x080251a8 - 0x080251cc, sub_080251A8 (peeled) */
        asm/disasm_0x080251cc.o(.text);  /* 0x080251cc - 0x080251f4, sub_080251CC (peeled) */
        asm/disasm_0x080251f4.o(.text);  /* 0x080251f4 - 0x08025218, sub_080251F4 (peeled) */
        asm/disasm_0x08025218.o(.text);  /* 0x08025218 - 0x08025240, sub_08025218 (peeled) */
        asm/disasm_0x08025240.o(.text);  /* 0x08025240 - 0x08025264, sub_08025240 (peeled) */
        asm/disasm_0x08025264.o(.text);  /* 0x08025264 - 0x080252b0, sub_08025264 (peeled) */
        asm/disasm_0x080252b0.o(.text);  /* 0x080252b0 - 0x080252e8, sub_080252B0 (peeled) */
        asm/disasm_0x080252e8.o(.text);  /* 0x080252e8 - 0x0802532c, sub_080252E8 (peeled) */
        asm/disasm_0x0802532c.o(.text);  /* 0x0802532c - 0x08025364, sub_0802532C (peeled) */
        asm/disasm_0x08025364.o(.text);  /* 0x08025364 - 0x08025390, sub_08025364 (peeled) */
        asm/disasm_0x08025390.o(.text);  /* 0x08025390 - 0x080253f0, sub_08025390 (peeled) */
        asm/disasm_0x080253f0.o(.text);  /* 0x080253f0 - 0x0802543c, sub_080253F0 (peeled) */
        asm/disasm_0x0802543c.o(.text);  /* 0x0802543c - 0x08025484, sub_0802543C (peeled) */
        asm/disasm_0x08025484.o(.text);  /* 0x08025484 - 0x080254dc, sub_08025484 (peeled) */
        asm/disasm_0x080254dc.o(.text);  /* 0x080254dc - 0x08025508, sub_080254DC (peeled) */
        asm/disasm_0x08025508.o(.text);  /* 0x08025508 - 0x08025578, sub_08025508 (peeled) */
        asm/disasm_0x08025578.o(.text);  /* 0x08025578 - 0x080255bc, sub_08025578 (peeled) */
        asm/disasm_0x080255bc.o(.text);  /* 0x080255bc - 0x080255f4, sub_080255BC (peeled) */
        asm/disasm_0x080255f4.o(.text);  /* 0x080255f4 - 0x08025620, sub_080255F4 (peeled) */
        asm/disasm_0x08025620.o(.text);  /* 0x08025620 - 0x08025644, sub_08025620 (peeled) */
        asm/disasm_0x08025644.o(.text);  /* 0x08025644 - 0x080256c8, sub_08025644 (peeled) */
        asm/disasm_0x080256c8.o(.text);  /* 0x080256c8 - 0x0802572c, sub_080256C8 (peeled) */
        asm/disasm_0x0802572c.o(.text);  /* 0x0802572c - 0x08025904, sub_0802572C (peeled) */
        asm/text/text_0x08025904.o(.text);  /* 0x08025904 - 0x080259c4, raw bytes (sub_08025904) */
        asm/disasm_0x080259c4.o(.text);  /* 0x080259c4 - 0x08025cec, sub_080259C4 (peeled) */
        asm/disasm_0x08025cec.o(.text);  /* 0x08025cec - 0x08025d14, sub_08025CEC (peeled) */
        asm/disasm_0x08025d14.o(.text);  /* 0x08025d14 - 0x08025d38, sub_08025D14 (peeled) */
        asm/disasm_0x08025d38.o(.text);  /* 0x08025d38 - 0x08025d60, sub_08025D38 (peeled) */
        asm/disasm_0x08025d60.o(.text);  /* 0x08025d60 - 0x08025d84, sub_08025D60 (peeled) */
        asm/disasm_0x08025d84.o(.text);  /* 0x08025d84 - 0x08025dac, sub_08025D84 (peeled) */
        asm/disasm_0x08025dac.o(.text);  /* 0x08025dac - 0x08025dd0, sub_08025DAC (peeled) */
        asm/disasm_0x08025dd0.o(.text);  /* 0x08025dd0 - 0x08025dfc, sub_08025DD0 (peeled) */
        asm/disasm_0x08025dfc.o(.text);  /* 0x08025dfc - 0x08025e60, sub_08025DFC (peeled) */
        asm/disasm_0x08025e60.o(.text);  /* 0x08025e60 - 0x08025eb4, sub_08025E60 (peeled) */
        asm/disasm_0x08025eb4.o(.text);  /* 0x08025eb4 - 0x08025eec, sub_08025EB4 (peeled) */
        asm/disasm_0x08025eec.o(.text);  /* 0x08025eec - 0x08025f38, sub_08025EEC (peeled) */
        asm/disasm_0x08025f38.o(.text);  /* 0x08025f38 - 0x08025f70, sub_08025F38 (peeled) */
        asm/disasm_0x08025f70.o(.text);  /* 0x08025f70 - 0x08025fbc, sub_08025F70 (peeled) */
        asm/disasm_0x08025fbc.o(.text);  /* 0x08025fbc - 0x08025ff4, sub_08025FBC (peeled) */
        asm/disasm_0x08025ff4.o(.text);  /* 0x08025ff4 - 0x08026020, sub_08025FF4 (peeled) */
        asm/disasm_0x08026020.o(.text);  /* 0x08026020 - 0x08026090, sub_08026020 (peeled) */
        asm/disasm_0x08026090.o(.text);  /* 0x08026090 - 0x080260d4, sub_08026090 (peeled) */
        asm/disasm_0x080260d4.o(.text);  /* 0x080260d4 - 0x0802610c, sub_080260D4 (peeled) */
        asm/disasm_0x0802610c.o(.text);  /* 0x0802610c - 0x0802618c, sub_0802610C (peeled) */
        asm/disasm_0x0802618c.o(.text);  /* 0x0802618c - 0x080261f8, sub_0802618C (peeled) */
        asm/disasm_0x080261f8.o(.text);  /* 0x080261f8 - 0x08026240, sub_080261F8 (peeled) */
        asm/disasm_0x08026240.o(.text);  /* 0x08026240 - 0x0802626c, sub_08026240 (peeled) */
        asm/disasm_0x0802626c.o(.text);  /* 0x0802626c - 0x08026290, sub_0802626C (peeled) */
        asm/disasm_0x08026290.o(.text);  /* 0x08026290 - 0x080262f4, sub_08026290 (peeled) */
        asm/disasm_0x080262f4.o(.text);  /* 0x080262f4 - 0x08026330, sub_080262F4 (peeled) */
        asm/disasm_0x08026330.o(.text);  /* 0x08026330 - 0x08026454, sub_08026330 (peeled) */
        asm/disasm_0x08026454.o(.text);  /* 0x08026454 - 0x080264b8, sub_08026454 (peeled) */
        asm/disasm_0x080264b8.o(.text);  /* 0x080264b8 - 0x0802651c, sub_080264B8 (peeled) */
        asm/disasm_0x0802651c.o(.text);  /* 0x0802651c - 0x080265d4, sub_0802651C (peeled) */
        asm/disasm_0x080265d4.o(.text);  /* 0x080265d4 - 0x080268c8, sub_080265D4 (peeled) */
        asm/disasm_0x080268c8.o(.text);  /* 0x080268c8 - 0x0802690c, sub_080268C8 (peeled) */
        asm/disasm_0x0802690c.o(.text);  /* 0x0802690c - 0x08026944, sub_0802690C (peeled) */
        asm/disasm_0x08026944.o(.text);  /* 0x08026944 - 0x080269ac, sub_08026944 (peeled) */
        asm/disasm_0x080269ac.o(.text);  /* 0x080269ac - 0x080269e4, sub_080269AC (peeled) */
        asm/disasm_0x080269e4.o(.text);  /* 0x080269e4 - 0x08026a0c, sub_080269E4 (peeled) */
        asm/disasm_0x08026a0c.o(.text);  /* 0x08026a0c - 0x08026a30, sub_08026A0C (peeled) */
        asm/disasm_0x08026a30.o(.text);  /* 0x08026a30 - 0x08026a58, sub_08026A30 (peeled) */
        asm/disasm_0x08026a58.o(.text);  /* 0x08026a58 - 0x08026a98, sub_08026A58 (peeled) */
        asm/disasm_0x08026a98.o(.text);  /* 0x08026a98 - 0x08026ad0, sub_08026A98 (peeled) */
        asm/disasm_0x08026ad0.o(.text);  /* 0x08026ad0 - 0x08026b14, sub_08026AD0 (peeled) */
        asm/disasm_0x08026b14.o(.text);  /* 0x08026b14 - 0x08026b84, sub_08026B14 (peeled) */
        asm/disasm_0x08026b84.o(.text);  /* 0x08026b84 - 0x08026bd8, sub_08026B84 (peeled) */
        asm/disasm_0x08026bd8.o(.text);  /* 0x08026bd8 - 0x08026c10, sub_08026BD8 (peeled) */
        asm/disasm_0x08026c10.o(.text);  /* 0x08026c10 - 0x08026c68, sub_08026C10 (peeled) */
        asm/disasm_0x08026c68.o(.text);  /* 0x08026c68 - 0x08026cc0, sub_08026C68 (peeled) */
        asm/disasm_0x08026cc0.o(.text);  /* 0x08026cc0 - 0x08026ce8, sub_08026CC0 (peeled) */
        asm/disasm_0x08026ce8.o(.text);  /* 0x08026ce8 - 0x08026d0c, sub_08026CE8 (peeled) */
        asm/disasm_0x08026d0c.o(.text);  /* 0x08026d0c - 0x08026d34, sub_08026D0C (peeled) */
        asm/disasm_0x08026d34.o(.text);  /* 0x08026d34 - 0x08026d58, sub_08026D34 (peeled) */
        asm/disasm_0x08026d58.o(.text);  /* 0x08026d58 - 0x08026dcc, sub_08026D58 (peeled) */
        asm/disasm_0x08026dcc.o(.text);  /* 0x08026dcc - 0x08026e40, sub_08026DCC (peeled) */
        asm/disasm_0x08026e40.o(.text);  /* 0x08026e40 - 0x08026e6c, sub_08026E40 (peeled) */
        asm/disasm_0x08026e6c.o(.text);  /* 0x08026e6c - 0x08026e90, sub_08026E6C (peeled) */
        asm/disasm_0x08026e90.o(.text);  /* 0x08026e90 - 0x08026edc, sub_08026E90 (peeled) */
        asm/disasm_0x08026edc.o(.text);  /* 0x08026edc - 0x08026f14, sub_08026EDC (peeled) */
        asm/disasm_0x08026f14.o(.text);  /* 0x08026f14 - 0x08026f8c, sub_08026F14 (peeled) */
        asm/disasm_0x08026f8c.o(.text);  /* 0x08026f8c - 0x08027000, sub_08026F8C (peeled) */
        asm/disasm_0x08027000.o(.text);  /* 0x08027000 - 0x080270c0, sub_08027000 (peeled) */
        asm/disasm_0x080270c0.o(.text);  /* 0x080270c0 - 0x08027138, sub_080270C0 (peeled) */
        asm/disasm_0x08027138.o(.text);  /* 0x08027138 - 0x08027310, sub_08027138 (peeled) */
        asm/disasm_0x08027310.o(.text);  /* 0x08027310 - 0x08027338, sub_08027310 (peeled) */
        asm/disasm_0x08027338.o(.text);  /* 0x08027338 - 0x0802735c, sub_08027338 (peeled) */
        asm/disasm_0x0802735c.o(.text);  /* 0x0802735c - 0x08027384, sub_0802735C (peeled) */
        asm/disasm_0x08027384.o(.text);  /* 0x08027384 - 0x080273a8, sub_08027384 (peeled) */
        asm/disasm_0x080273a8.o(.text);  /* 0x080273a8 - 0x080273d0, sub_080273A8 (peeled) */
        asm/disasm_0x080273d0.o(.text);  /* 0x080273d0 - 0x080273f4, sub_080273D0 (peeled) */
        asm/disasm_0x080273f4.o(.text);  /* 0x080273f4 - 0x08027458, sub_080273F4 (peeled) */
        asm/disasm_0x08027458.o(.text);  /* 0x08027458 - 0x08027490, sub_08027458 (peeled) */
        asm/disasm_0x08027490.o(.text);  /* 0x08027490 - 0x080274bc, sub_08027490 (peeled) */
        asm/disasm_0x080274bc.o(.text);  /* 0x080274bc - 0x08027510, sub_080274BC (peeled) */
        asm/disasm_0x08027510.o(.text);  /* 0x08027510 - 0x08027558, sub_08027510 (peeled) */
        asm/text/text_0x08027558.o(.text);  /* 0x08027558 - 0x08027584, raw bytes */
        asm/disasm_0x08027584.o(.text);  /* 0x08027584 - 0x080275b0, sub_08027584 (peeled) */
        asm/disasm_0x080275b0.o(.text);  /* 0x080275b0 - 0x080275fc, sub_080275B0 (peeled) */
        asm/disasm_0x080275fc.o(.text);  /* 0x080275fc - 0x08027634, sub_080275FC (peeled) */
        asm/disasm_0x08027634.o(.text);  /* 0x08027634 - 0x08027680, sub_08027634 (peeled) */
        asm/disasm_0x08027680.o(.text);  /* 0x08027680 - 0x080276b8, sub_08027680 (peeled) */
        asm/disasm_0x080276b8.o(.text);  /* 0x080276b8 - 0x080276f4, sub_080276B8 (peeled) */
        asm/text/text_0x080276f4.o(.text);  /* 0x080276f4 - 0x080276fc, raw bytes (literal pool) */
        asm/disasm_0x080276fc.o(.text);  /* 0x080276fc - 0x08027744, sub_080276FC (peeled) */
        asm/disasm_0x08027744.o(.text);  /* 0x08027744 - 0x08027770, sub_08027744 (peeled) */
        asm/disasm_0x08027770.o(.text);  /* 0x08027770 - 0x08027794, sub_08027770 (peeled) */
        asm/disasm_0x08027794.o(.text);  /* 0x08027794 - 0x080277f4, sub_08027794 (peeled) */
        asm/disasm_0x080277f4.o(.text);  /* 0x080277f4 - 0x0802782c, sub_080277F4 (peeled) */
        asm/disasm_0x0802782c.o(.text);  /* 0x0802782c - 0x080278dc, sub_0802782C (peeled) */
        asm/disasm_0x080278dc.o(.text);  /* 0x080278dc - 0x08027ac4, sub_080278DC (peeled) */
        asm/disasm_0x08027ac4.o(.text);  /* 0x08027ac4 - 0x08027c84, sub_08027AC4 (peeled) */
        asm/disasm_0x08027c84.o(.text);  /* 0x08027c84 - 0x08027d18, wave_effect (peeled) */
        asm/disasm_0x08027d18.o(.text);  /* 0x08027d18 - 0x08027d40, sub_08027D18 (peeled) */
        asm/disasm_0x08027d40.o(.text);  /* 0x08027d40 - 0x08027d64, sub_08027D40 (auto-peeled) */
        asm/disasm_0x08027d64.o(.text);  /* 0x08027d64 - 0x08027d8c, sub_08027D64 (peeled) */
        asm/disasm_0x08027d8c.o(.text);  /* 0x08027d8c - 0x08027db0, sub_08027D8C (peeled) */
        asm/disasm_0x08027db0.o(.text);  /* 0x08027db0 - 0x08027dd8, sub_08027DB0 (peeled) */
        asm/disasm_0x08027dd8.o(.text);  /* 0x08027dd8 - 0x08027dfc, sub_08027DD8 (peeled) */
        asm/disasm_0x08027dfc.o(.text);  /* 0x08027dfc - 0x08027e3c, sub_08027DFC (peeled) */
        asm/disasm_0x08027e3c.o(.text);  /* 0x08027e3c - 0x08027e64, sub_08027E3C (peeled) */
        asm/disasm_0x08027e64.o(.text);  /* 0x08027e64 - 0x08027eb0, sub_08027E64 (peeled) */
        asm/disasm_0x08027eb0.o(.text);  /* 0x08027eb0 - 0x08027ee8, sub_08027EB0 (peeled) */
        asm/text/text_0x08027ee8.o(.text);  /* 0x08027ee8 - 0x08027f40, raw bytes (shrunk for sub_08027F40 peel) */
        asm/disasm_0x08027f40.o(.text);  /* 0x08027f40 - 0x08027f78, sub_08027F40 (peeled) */
        asm/disasm_0x08027f78.o(.text);  /* 0x08027f78 - 0x08027fd0, sub_08027F78 (peeled) */
        asm/disasm_0x08027fd0.o(.text);  /* 0x08027fd0 - 0x08028008, sub_08027FD0 (peeled) */
        asm/disasm_0x08028008.o(.text);  /* 0x08028008 - 0x08028084, sub_08028008 (peeled) */
        asm/disasm_0x08028084.o(.text);  /* 0x08028084 - 0x080280c8, sub_08028084 (peeled) */
        asm/disasm_0x080280c8.o(.text);  /* 0x080280c8 - 0x08028118, sub_080280C8 (peeled) */
        asm/disasm_0x08028118.o(.text);  /* 0x08028118 - 0x08028188, sub_08028118 (peeled) */
        asm/disasm_0x08028188.o(.text);  /* 0x08028188 - 0x080281b4, sub_08028188 (peeled) */
        asm/disasm_0x080281b4.o(.text);  /* 0x080281b4 - 0x080281d8, sub_080281B4 (peeled) */
        asm/disasm_0x080281d8.o(.text);  /* 0x080281d8 - 0x08028238, sub_080281D8 (peeled) */
        asm/disasm_0x08028238.o(.text);  /* 0x08028238 - 0x08028270, sub_08028238 (peeled) */
        asm/disasm_0x08028270.o(.text);  /* 0x08028270 - 0x08028520, sub_08028270 (peeled) */
        asm/disasm_0x08028520.o(.text);  /* 0x08028520 - 0x0802857c, sub_08028520 (peeled) */
        asm/disasm_0x0802857c.o(.text);  /* 0x0802857c - 0x08028600, sub_0802857C (peeled) */
        asm/disasm_0x08028600.o(.text);  /* 0x08028600 - 0x08028684, sub_08028600 (peeled) */
        asm/disasm_0x08028684.o(.text);  /* 0x08028684 - 0x08028720, sub_08028684 (peeled) */
        asm/disasm_0x08028720.o(.text);  /* 0x08028720 - 0x0802877c, sub_08028720 (peeled) */
        asm/disasm_0x0802877c.o(.text);  /* 0x0802877c - 0x08028858, sub_0802877C (peeled) */
        asm/disasm_0x08028858.o(.text);  /* 0x08028858 - 0x08028a98, sub_08028858 (peeled) */
        asm/disasm_0x08028a98.o(.text);  /* 0x08028a98 - 0x08028b94, sub_08028A98 (peeled) */
        asm/disasm_0x08028b94.o(.text);  /* 0x08028b94 - 0x080292e0, sub_08028B94 (peeled) */
        asm/disasm_0x080292e0.o(.text);  /* 0x080292e0 - 0x08029448, sub_080292E0 (peeled) */
        asm/disasm_0x08029448.o(.text);  /* 0x08029448 - 0x080295ac, sub_08029448 (peeled) */
        asm/disasm_0x080295ac.o(.text);  /* 0x080295ac - 0x080295d4, sub_080295AC (peeled) */
        asm/disasm_0x080295d4.o(.text);  /* 0x080295d4 - 0x080295f8, sub_080295D4 (peeled) */
        asm/disasm_0x080295f8.o(.text);  /* 0x080295f8 - 0x08029620, sub_080295F8 (peeled) */
        asm/disasm_0x08029620.o(.text);  /* 0x08029620 - 0x08029644, sub_08029620 (peeled) */
        asm/disasm_0x08029644.o(.text);  /* 0x08029644 - 0x0802966c, sub_08029644 (peeled) */
        asm/disasm_0x0802966c.o(.text);  /* 0x0802966c - 0x08029690, sub_0802966C (peeled) */
        asm/disasm_0x08029690.o(.text);  /* 0x08029690 - 0x080296b8, sub_08029690 (peeled) */
        asm/disasm_0x080296b8.o(.text);  /* 0x080296b8 - 0x08029710, sub_080296B8 (peeled) */
        asm/disasm_0x08029710.o(.text);  /* 0x08029710 - 0x08029748, sub_08029710 (peeled) */
        asm/disasm_0x08029748.o(.text);  /* 0x08029748 - 0x08029780, sub_08029748 (peeled) */
        asm/disasm_0x08029780.o(.text);  /* 0x08029780 - 0x080297ac, sub_08029780 (peeled) */
        asm/disasm_0x080297ac.o(.text);  /* 0x080297ac - 0x080297f0, sub_080297AC (peeled) */
        asm/disasm_0x080297f0.o(.text);  /* 0x080297f0 - 0x08029828, sub_080297F0 (peeled) */
        asm/disasm_0x08029828.o(.text);  /* 0x08029828 - 0x0802986c, sub_08029828 (peeled) */
        asm/disasm_0x0802986c.o(.text);  /* 0x0802986c - 0x0802a284, sub_0802986C (peeled) */
        asm/disasm_0x0802a284.o(.text);  /* 0x0802a284 - 0x0802a298, sub_0802A284 (peeled) */
        asm/disasm_0x0802a298.o(.text);  /* 0x0802a298 - 0x0802a2d8, sub_0802A298 (peeled) */
        asm/disasm_0x0802a2d8.o(.text);  /* 0x0802a2d8 - 0x0802a2f0, sub_0802A2D8 (peeled) */
        src/engine/sub_0802a2f0.o(.text);
        src/engine/sub_0802a394.o(.text);
        src/engine/sub_0802a42c.o(.text);
        src/engine/sub_0802a4a4.o(.text);
        src/engine/sub_0802a538.o(.text);
        src/engine/sub_0802a63c.o(.text);
        src/engine/sub_0802a8fc.o(.text);
        src/engine/sub_0802a9fc.o(.text);
        src/engine/sub_0802aae8.o(.text);
        src/game/sub_0802ab64.o(.text);  /* 0x0802ab64 - 0x0802af10, EntitySlot17_Init + EntitySlot12_LoadLayout + RoomEntities_Update + RoomEntities_Init + RoomFrogEntity_Update */
        asm/disasm_0x0802af10.o(.text);  /* 0x0802af10 - 0x0802af4c, sub_0802AF10 (auto-peeled) */
        asm/disasm_0x0802af4c.o(.text);  /* 0x0802af4c - 0x0802af84, sub_0802AF4C */
        asm/disasm_0x0802af84.o(.text);  /* 0x0802af84 - 0x0802afc0, sub_0802AF84 (auto-peeled) */
        asm/text/text_0x0802afc0.o(.text);  /* 0x0802afc0 - 0x0802aff8, raw bytes */
        asm/disasm_0x0802aff8.o(.text);  /* 0x0802aff8 - 0x0802b008, sub_0802AFF8 (auto-peeled) */
        asm/disasm_0x0802b008.o(.text);  /* 0x0802b008 - 0x0802b2ec, sub_0802B008 (auto-peeled) */
        asm/disasm_0x0802b2ec.o(.text);  /* 0x0802b2ec - 0x0802b3b0, sub_0802B2EC (auto-peeled) */
        asm/text/text_0x0802b3b0.o(.text);  /* 0x0802b3b0 - 0x0802b9d4, raw bytes */
        src/game/sub_0802b9d4.o(.text);
        src/game/sub_0802ba64.o(.text);
        asm/disasm_0x0802baf8.o(.text);  /* 0x0802baf8 - 0x0802bb5c, PadGrid_SpawnTypeA (auto-peeled) */
        src/game/sub_0802bb5c.o(.text);  /* 0x0802bb5c - 0x0802bc24, Walker_SpawnAtTile + Pos2D_ClampToBounds + Walker_LoadLayout */
        src/game/sub_0802bc24.o(.text);
        src/game/sub_0802bdbc.o(.text);
        src/game/sub_0802bf58.o(.text);
        src/game/sub_0802c200.o(.text);
        src/game/sub_0802c3e4.o(.text);
        asm/disasm_0x0802c3e4.o(.text);  /* 0x0802c3e4 - 0x0802c75c, EntityPool_SpawnEntry (auto-peeled) */
        src/game/sub_0802c75c.o(.text);
        src/game/sub_0802c7ec.o(.text);
        src/game/sub_0802c910.o(.text);  /* 0x0802c910 - 0x0802ca54, Entity22_Update (NAKED+NON_MATCHING) */
        src/game/sub_0802ca54.o(.text);
        asm/disasm_0x0802ca54.o(.text);  /* 0x0802ca54 - 0x0802ca64, sub_0802CA54 (auto-peeled) */
        src/game/sub_0802ca64.o(.text);
        src/game/sub_0802cafc.o(.text);
        src/game/sub_0802cdd0.o(.text);
        src/game/sub_0802ce60.o(.text);
        src/game/sub_0802d170.o(.text);
        asm/disasm_0x0802d170.o(.text);  /* 0x0802d170 - 0x0802d294, sub_0802D170 (auto-peeled) */
        src/game/sub_0802d294.o(.text);
        asm/disasm_0x0802d294.o(.text);  /* 0x0802d294 - 0x0802d3c0, sub_0802D294 (auto-peeled) */
        src/game/sub_0802d3c0.o(.text);
        asm/disasm_0x0802d3c0.o(.text);  /* 0x0802d3c0 - 0x0802d448, sub_0802D3C0 (auto-peeled) */
        src/game/sub_0802d448.o(.text);
        asm/disasm_0x0802d448.o(.text);  /* 0x0802d448 - 0x0802d4ac, sub_0802D448 (auto-peeled) */
        src/game/sub_0802d4ac.o(.text);
        asm/disasm_0x0802d4ac.o(.text);  /* 0x0802d4ac - 0x0802d4f8, sub_0802D4AC (auto-peeled) */
        src/game/sub_0802d4f8.o(.text);  /* 0x0802d4f8 - 0x0802d504, sub_0802D4F8 */
        src/game/sub_0802d504.o(.text);
        asm/disasm_0x0802d504.o(.text);  /* 0x0802d504 - 0x0802d514, sub_0802D504 (game trampoline) */
        asm/libagbsyscall.o(.text);  /* 0x0802d514 - 0x0802d5ec, public SDK BIOS SWI wrappers (libagbsyscall) */
        lib/gax/disasm_0x0802d5ec.o(.text);  /* 0x0802d5ec - 0x0802d770, SoundSystem_Transfer (auto-peeled) */
        src/game/sub_0802d770.o(.text);
        lib/gax/disasm_0x0802d770.o(.text);  /* 0x0802d770 - 0x0802d800, sub_0802D770 (auto-peeled) */
        src/game/sub_0802d800.o(.text);
        lib/gax/disasm_0x0802d800.o(.text);  /* 0x0802d800 - 0x0802d890, sub_0802D800 (auto-peeled) */
        lib/gax/sub_0802d890.o(.text);
        lib/gax/sub_0802d8f8.o(.text);
        lib/gax/disasm_0x0802d8f8.o(.text);  /* 0x0802d8f8 - 0x0802d9ec, Sound_Reset (auto-peeled) */
        lib/gax/sub_0802d9ec.o(.text);
        lib/gax/disasm_0x0802d9ec.o(.text);  /* 0x0802dc1c - 0x0802dcbc, SoundHandle_SetPan (auto-peeled) */
        lib/gax/sub_0802dcbc.o(.text);
        lib/gax/sub_0802de24.o(.text);
        lib/gax/sub_0802de9c.o(.text);  /* 0x0802de9c - 0x0802dfbc, Sound_OpenStream */
        lib/gax/sub_0802dfbc.o(.text);  /* 0x0802dfbc - 0x0802e00c, SoundSlot_SetPitchScale */
        lib/gax/sub_0802e00c.o(.text);  /* 0x0802e00c - 0x0802e100, SoundStream_UpdateCursor + Sound_SetActiveCount */
        lib/gax/sub_0802e100.o(.text);  /* 0x0802e100 - 0x0802e13c, SoundHandle_Retire */
        lib/gax/sub_0802e13c.o(.text);  /* 0x0802e13c - 0x0802e220, Sound_DrainActiveSlots + SoundHandle_GetPeriod */
        lib/gax/sub_0802e220.o(.text);  /* 0x0802e220 - 0x0802e27c, Sound_GetChannelVolume */
        lib/gax/sub_0802e27c.o(.text);  /* 0x0802e27c - 0x0802e380 */
        lib/gax/sub_0802e380.o(.text);  /* 0x0802e380 - 0x0802e3f8 */
        lib/gax/sound_lock.o(.text);  /* 0x0802e3f8 - 0x0802e544, Sound_Unlock + Sound_Lock + SoundLock_SlotOpen + SoundLock_SlotClose + SoundLock_SetPan + SoundLock_SetEnable + SoundLock_CalcPeriod */
        lib/gax/disasm_0x0802e544.o(.text);  /* 0x0802e544 - 0x0802e5d8, sub_0802E544 */
        lib/gax/sound_pitch.o(.text);  /* 0x0802e5d8 - 0x0802e684, Sound_EmitPsgPitch (NAKED+NON_MATCHING) */
        lib/gax/sound_volume.o(.text);  /* 0x0802e684 - 0x0802e724, SoundVolume_Emit */
        lib/gax/sub_0802e724.o(.text);  /* 0x0802e724 - 0x0802e7c4, SoundChannel_Reset */
        lib/gax/sub_0802e7c4.o(.text);  /* 0x0802e7c4 - 0x0802e934, sub_0802E7C4 + Sound_AdjustPan */
        lib/gax/sound_envelope_dual.o(.text);  /* 0x0802e934 - 0x0802ea80, Sound_TickDualEnvelopes (NAKED+NON_MATCHING) + SoundEnvelope_SetOscillator */
        lib/gax/sound_envelope.o(.text);  /* 0x0802ea80 - 0x0802ec7c, SoundEnvelope_TickA0 + SoundEnvelope_SetRamp (NAKED+NON_MATCHING) + SoundEnvelope_InitClamp (NAKED+NON_MATCHING) */
        lib/gax/sound_channel_envelope_a.o(.text);  /* 0x0802ec7c - 0x0802ed5c, Sound_UpdateChannelEnvelopesA (NAKED+NON_MATCHING) */
        lib/gax/sound_channel.o(.text);  /* 0x0802ed5c - 0x0802edf0, Sound_TickSlotEnvelopeB */
        lib/gax/sound_channel_stream.o(.text);  /* 0x0802edf0 - 0x0802f054, Sound_TickStreamHead (NAKED+NON_MATCHING) + SoundChannel_SetEnvelopeC + Sound_ApplyEnvelopeC */
        lib/gax/sound_envelope_slide.o(.text);  /* 0x0802f054 - 0x0802f2fc, Sound_TickEnvelopeC (NAKED+NON_MATCHING) */
        lib/gax/sound_pan.o(.text);  /* 0x0802f2fc - 0x0802f4b0, SoundPan_Tick (NAKED+NON_MATCHING) + SoundPan_UpdateMixEntry */
        lib/gax/sound_mixer.o(.text);  /* 0x0802f4b0 - 0x0802f99c, SoundMixer_VBlankUpdate + Sound_WritePsgDuty + Sound_WriteNoiseFreq + Sound_WritePsgVolume + Sound_MarkChannelFullDirty + Sound_LoadWaveRam */
        lib/gax/disasm_0x0802f99c.o(.text);  /* 0x0802f99c - 0x0802f9f0, sub_0802F99C (auto-peeled) */
        lib/gax/sub_0802f9f0.o(.text);  /* 0x0802f9f0 - 0x0802fab8, Sound_RetireChannel + Sound_UpdateStreamPeriod */
        lib/gax/disasm_0x0802fab8.o(.text);  /* 0x0802fab8 - 0x08030158, sub_0802FAB8 (auto-peeled) */
        src/system/sub_08030158.o(.text);
        lib/gax/disasm_0x08030158.o(.text);  /* 0x08030158 - 0x080301c4, sub_08030158 (auto-peeled) */
        lib/gax/sound_period.o(.text);  /* 0x080301c4 - 0x08030644, Sound_CalcNotePeriod (NAKED+NON_MATCHING — libgcc-BL class) + SoundPeriod_Reset + Sound_StartDma + SoundOp_RetireChannel + SoundOp_SetPeriod + SoundOp_GateOff + SoundOp_Wait */
        lib/gax/sub_08030644.o(.text);  /* 0x08030644 - 0x0803079c, sub_08030644 */
        lib/gax/sub_0803079c.o(.text);
        asm/disasm_0x0803079c.o(.text);  /* 0x0803080c - 0x080308b0, SoundOp_SetAcc1 (auto-peeled) */
        lib/gax/sub_080308b0.o(.text);  /* 0x080308b0 - 0x080309a0, Sound_LoadStreamSlot */
        lib/gax/sub_080309a0.o(.text);
        lib/gax/SoundOpcode_SetStreamLoop.o(.text);  /* 0x08030a44 - 0x08030b34, SoundOpcode_SetStreamLoop */
        asm/disasm_0x08030b34.o(.text);  /* 0x08030b34 - 0x08030c4c, sub_08030B34 */
        asm/text/text_0x08030c4c_before.o(.text);  /* 0x08030c4c - 0x08030d8c, raw bytes before sub_08030D8C */
        asm/disasm_0x08030d8c.o(.text);  /* 0x08030d8c - 0x08030e50, sub_08030D8C (auto-peeled) */
        asm/disasm_0x08030e50.o(.text);  /* 0x08030e50 - 0x08031390, sub_08030E50 (auto-peeled) */
        asm/disasm_0x08031390.o(.text);  /* 0x08031390 - 0x80313fc, sub_08031390 (auto-peeled) */
        asm/disasm_0x080313fc.o(.text);  /* 0x080313fc - 0x080314ac, sub_080313FC (auto-peeled) */
        asm/disasm_0x080314ac.o(.text);  /* 0x080314ac - 0x08031540, sub_080314AC (auto-peeled) */
        asm/disasm_0x08031540.o(.text);  /* 0x08031540 - 0x080315d8, sub_08031540 (auto-peeled) */
        lib/gax/sound_opcode_dispatch.o(.text);  /* 0x080315d8 - 0x08031638, Sound_OpcodeDispatch */
        lib/gax/SoundOpcode_SetStreamPan.o(.text);
        lib/gax/disasm_0x08031688.o(.text);  /* 0x08031688 - 0x080316dc, sub_08031688 (auto-peeled) */
        lib/gax/SoundOp_SetEnvelopeOscillator.o(.text);
        lib/gax/disasm_0x080316fc.o(.text);  /* 0x080316fc - 0x08031720, sub_080316FC (auto-peeled) */
        lib/gax/SoundOp_SetEnvelopeRamp.o(.text);
        lib/gax/SoundOp_Jump.o(.text);
        lib/gax/text_0x0803175c.o(.text);  /* 0x0803175c - 0x08031798, raw bytes */
        lib/gax/SoundOp_Call.o(.text);  /* 0x08031798 - 0x080317e0, SoundOp_Call + SoundOp_Return + SoundOp_SetEnvelopeC */
        lib/gax/disasm_0x080317e0.o(.text);  /* 0x080317e0 - 0x08031824, sub_080317E0 (auto-peeled) */
        src/system/sub_08031824.o(.text);
        lib/gax/disasm_0x08031824.o(.text);  /* 0x08031824 - 0x08031868, sub_08031824 (auto-peeled) */
        src/system/sub_08031868.o(.text);
        lib/gax/disasm_0x08031868.o(.text);  /* 0x08031868 - 0x0803189c, sub_08031868 (auto-peeled) */
        lib/gax/SoundOp_Skip2.o(.text);
        lib/gax/disasm_0x080318a8.o(.text);  /* 0x080318a8 - 0x080318f0, sub_080318A8 (auto-peeled) */
        src/system/sub_080318f0.o(.text);
        lib/gax/disasm_0x080318f0.o(.text);  /* 0x080318f0 - 0x08031910, sub_080318F0 (auto-peeled) */
        src/system/sub_08031910.o(.text);
        lib/gax/disasm_0x08031910.o(.text);  /* 0x08031910 - 0x0803194c, sub_08031910 (auto-peeled) */
        src/system/sub_0803194c.o(.text);
        lib/gax/disasm_0x0803194c.o(.text);  /* 0x0803194c - 0x08031998, sub_0803194C (auto-peeled) */
        src/system/sub_08031998.o(.text);
        lib/gax/disasm_0x08031998.o(.text);  /* 0x08031998 - 0x080319c0, sub_08031998 (auto-peeled) */
        src/system/sub_080319c0.o(.text);
        lib/gax/disasm_0x080319c0.o(.text);  /* 0x080319c0 - 0x080319fc, sub_080319C0 (auto-peeled) */
        src/system/sub_080319fc.o(.text);
        lib/gax/disasm_0x080319fc.o(.text);  /* 0x080319fc - 0x08031a48, sub_080319FC (auto-peeled) */
        src/system/sub_08031a48.o(.text);
        lib/gax/disasm_0x08031a48.o(.text);  /* 0x08031a48 - 0x08031ab4, sub_08031A48 (auto-peeled) */
        src/system/sub_08031ab4.o(.text);
        lib/gax/disasm_0x08031ab4.o(.text);  /* 0x08031ab4 - 0x08031b84, sub_08031AB4 (auto-peeled) */
        src/system/sub_08031b84.o(.text);
        lib/gax/disasm_0x08031b84.o(.text);  /* 0x08031b84 - 0x08031bb8, sub_08031B84 (auto-peeled) */
        src/system/sub_08031bb8.o(.text);
        lib/gax/disasm_0x08031bb8.o(.text);  /* 0x08031bb8 - 0x08031c04, sub_08031BB8 (auto-peeled) */
        src/system/sub_08031c04.o(.text);
        lib/gax/disasm_0x08031c04.o(.text);  /* 0x08031c04 - 0x08031c64, sub_08031C04 (auto-peeled) */
        src/system/sub_08031c64.o(.text);
        lib/gax/disasm_0x08031c64.o(.text);  /* 0x08031c64 - 0x08031c84, sub_08031C64 (auto-peeled) */
        src/system/sub_08031c84.o(.text);
        lib/gax/disasm_0x08031c84.o(.text);  /* 0x08031c84 - 0x08031d2c, sub_08031C84 (auto-peeled) */
        src/system/sub_08031d2c.o(.text);
        lib/gax/disasm_0x08031d2c.o(.text);  /* 0x08031d2c - 0x08031dbc, sub_08031D2C (auto-peeled) */
        lib/gax/sub_08031dbc.o(.text);
        lib/gax/disasm_0x08031e24.o(.text);  /* 0x08031e24 - 0x08031fdc, SoundSlot_Load (auto-peeled) */
        lib/gax/sub_08031fdc.o(.text);
        lib/gax/sub_08032094.o(.text);
        lib/gax/SoundSystem_IsActive.o(.text);  /* 0x08032148 - 0x08032200, SoundSystem_IsActive */
        asm/disasm_0x08032200.o(.text);  /* 0x08032200 - 0x080322e8, sub_08032200 (peeled) */
        asm/disasm_0x080322e8.o(.text);  /* 0x080322e8 - 0x080323cc, sub_080322E8 (peeled) */
        lib/gax/disasm_0x080323cc.o(.text);  /* 0x080323cc - 0x080325b0, sub_080323CC (peeled) */
        lib/gax/sound_mixer_tail.o(.text);  /* 0x080325b0 - 0x08032894, Sound_ProcessRequests (NAKED+NON_MATCHING) */
        lib/gax/sub_08032894.o(.text);  /* 0x08032894 - 0x08032904, SoundSlot_InitParams */
        lib/gax/sound_channel_state.o(.text);  /* 0x08032904 - 0x0803299c, GAX SoundChannel_SetState (Shin'en lib — incbin) */
        lib/gax/sub_0803299c.o(.text);  /* 0x0803299c - 0x08032b18, sub_0803299C + sub_080329F4 + sub_08032A20 + sub_08032A54 + sub_08032A98 + SoundSystem_InitRequestSlot */
        lib/gax/sub_08032b18.o(.text);  /* 0x08032b18 - 0x08032c18, SoundSlot_PickByPriority + SoundChannel_CheckPriority + SoundVoice_Init */
        lib/gax/text_0x08032c18.o(.text);  /* 0x08032c18 - 0x08032e04, raw bytes */
        lib/gax/sub_08032e04.o(.text);
        lib/gax/text_0x08032e1c.o(.text);  /* 0x08032e1c - 0x080338a8, raw bytes */
        src/game/sub_080338a8.o(.text);
        src/game/sub_08033910.o(.text);  /* 0x08033910 - 0x08033948, Timer_SetIrqHandler */
        asm/disasm_0x08033948.o(.text);    /* 0x08033948 - 0x080339ac, sub_08033948 */
        asm/disasm_0x080339ac.o(.text);    /* 0x080339ac - 0x080339f0, sub_080339AC */
        asm/disasm_0x080339f0.o(.text);    /* 0x080339f0 - 0x08033a70, sub_080339F0 */
        asm/text/text_0x08033a70.o(.text); /* 0x08033a70 - 0x08033ca4, raw bytes */
        *libgcc.a:_ashldi3.o(.text);      /* 0x08033ca4 - 0x08033cd8, __ashldi3 */
        *libgcc.a:_call_via_rX.o(.text);  /* 0x08033cd8 - 0x08033d14, _call_via_rX helper table */
        *libgcc.a:_divsi3.o(.text);       /* 0x08033d14 - 0x08033da8, __divsi3 */
        *libgcc.a:_dvmd_tls.o(.text);     /* 0x08033da8 - 0x08033dac, __div0 */
        *libgcc.a:_fixunssfsi.o(.text);   /* 0x08033dac - 0x08033de0, __fixunssfsi */
        *libgcc.a:_lshrdi3.o(.text);      /* 0x08033de0 - 0x08033e14, __lshrdi3 */
        *libgcc.a:_modsi3.o(.text);       /* 0x08033e14 - 0x08033ee4, __modsi3 */
        *libgcc.a:_udivsi3.o(.text);      /* 0x08033ee4 - 0x08033f5c, __udivsi3 */
        *libgcc.a:_umodsi3.o(.text);      /* 0x08033f5c - 0x0803401c, __umodsi3 */
        *libgcc.a:fp-bit.o(.text);        /* 0x0803401c - 0x08034968, single-precision soft-float */
        *libgcc.a:_muldi3.o(.text);       /* 0x08034968 - 0x080349d8, __muldi3 */
        *libgcc.a:dp-bit.o(.text);        /* 0x080349d8 - 0x08035774, double-precision soft-float */
        *libgcc.a:_negdi2.o(.text);       /* 0x08035774 - 0x0803578c, __negdi2 */
        sub_08033DA8 = __div0;
        sub_08033DAC = __fixunssfsi;
        sub_0803401C = __pack_f;
        sub_080340D4 = __unpack_f;
        sub_08034150 = __pack_f + 0x134;
        sub_080342CC = __addsf3;
        sub_080342F8 = __subsf3;
        sub_0803432C = __mulsf3;
        sub_0803457C = __fpcmp_parts_f;
        sub_08034760 = __gesf2;
        sub_08034898 = __fixsfsi;
        sub_08034900 = __negsf2;
        sub_08034924 = __make_fp;
        sub_0803493C = __extendsfdf2;
        sub_080349D8 = __pack_d;
        sub_08034B20 = __unpack_d;
        sub_08034BF8 = __pack_d + 0x220;
        sub_08035708 = __make_dp;
        src/game/sub_0803578c.o(.text);
        asm/disasm_0x080357ec.o(.text);  /* 0x080357ec - 0x08035d7c, qsort (libc, peeled) */
        src/game/sub_08035d7c.o(.text);  /* 0x08035d7c - 0x08035d84, IntrEnable_Thunk (Thumb-to-ARM interwork thunk -> IntrEnable) */
        asm/disasm_0x08035d84.o(.text);  /* 0x08035d84 - 0x08035d8c, sub_08000240_Thunk (Thumb-to-ARM interwork veneer -> sub_08000240, peeled) */
        src/game/sub_08035d8c.o(.text);
        src/game/sub_08035d94.o(.text);  /* 0x08035d94 - 0x08035d9c, SoundIrqEnable (NAKED interwork veneer) */
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
        src/data/mode_config_2f99e8.o(.rodata);  /* 0x082f99e8 - 0x082f9d08, sModeConfigTables_2F99E8 + sModeLookupTable_2F9CF4 (per-mode config cluster backing the Scene08_Main 14-case dispatcher) */
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
        sLevelLayout_312138 = sLevelLayoutData_311F80 + 0x1b8;
        sLevelLayout_312148 = sLevelLayoutData_311F80 + 0x1c8;
        sLevelLayout_3121F0 = sLevelLayoutData_311F80 + 0x270;
        sLevelLayout_3120D8 = sLevelLayoutData_311F80 + 0x158;
        sLevelLayout_312148 = sLevelLayoutData_311F80 + 0x1c8;
        sLevelLayout_3121F0 = sLevelLayoutData_311F80 + 0x270;
        sLevelLayout_312210 = sLevelLayoutData_311F80 + 0x290;
        sLevelLayout_312228 = sLevelLayoutData_311F80 + 0x2a8;
        sLevelLayout_312248 = sLevelLayoutData_311F80 + 0x2c8;
        sLevelLayout_312270 = sLevelLayoutData_311F80 + 0x2f0;
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
