@ Parallel BG tilemap pair at 0x0819c312..0x0819dcaa (2 x 0xccc B).
@
@ Hand-written .s rather than a C file because the anchor 0x0819c312
@ is 2-byte aligned but not 4-byte aligned, which trips the agbcc
@ default .rodata section alignment of 4. Emitting the data through
@ a .s file with explicit `.balign 2` keeps the linker from padding
@ the upstream .text bucket up to a 4-byte boundary. See
@ docs/codegen-notes.md "u16-but-not-u32 aligned .rodata anchors".
@
@ The two blobs are siblings: same length (0xccc = 3276 B / 1638 u16
@ entries), identical first 1008 bytes (504 entries -- shared frame /
@ border / common region), divergent last 2268 bytes (1134 entries --
@ the variant content). They are loaded via the same DMA-then-render
@ pattern to the same VRAM destination, switched by a single
@ gGameStuff flag byte.
@
@   DMA stage: REG_DMA3 SRC = anchor, DST = 0x02000000 (EWRAM scratch),
@              CNT = 0x80008000 (enable + 0x8000-halfword count =
@              over-read past blob end, EWRAM-bound). Read-back of
@              DMACNT acts as the wait.
@   Render stage: BL 0x080100e4 with (r0=0, r1=0x02000000, r2=0x0600e000).
@              0x080100e4 reads the EWRAM scratch buffer and writes
@              processed tiles to BG screen-base 28 (0x0600e000).
@
@ Three consumer call-sites in the still-asm code region:
@
@   0x08015220 -- screen-init function. Reads byte at gGameStuff+0x33
@                 (an unnamed "screen variant" selector). If == 1 ->
@                 DMA+render variant A (0x0819c312); else -> variant
@                 B (0x0819cfde). Surrounding calls (0xe85c, 0xeb1c,
@                 0xf24c, 0xebdc, 0xee34) are the BG-mode setup
@                 helpers for BG 3.
@   0x08015a50 -- unconditional DMA+render of variant A. Standalone
@                 thumb function (push lr / pop r0 / bx r0).
@   0x08015a80 -- unconditional DMA+render of variant B. Standalone
@                 thumb function. The 0x812-byte gap between the two
@                 standalone fns and the matching gap between the two
@                 if/else arms in 0x08015220 is what flagged this pair
@                 as a structural cluster.
@
@ Content shape: u16 entries with the GBA BG-tilemap layout
@ (low 10 bits = tile id, bits 10-11 = h/vflip, bits 12-15 = palette).
@ Observed tile ids cluster around 0x021..0x023 (palette 2), 0x041..
@ 0x043, 0x061..0x063, 0x080+ etc. -- 3-tile motifs tiled across the
@ map. Variant A leans on palette 7 mid-region; variant B leans on
@ palette 1. Same geometry, different visual asset bank.
@
@ Purpose hypothesis: two visual variants of a single screen (e.g.,
@ world-A vs world-B map / level-select), selected by a game-state
@ flag. Confirmation requires decompiling 0x08015220 and 0x080100e4
@ (the renderer) -- TODO once those land in C.
@
@ Not 32x32 (1024 entries) or 32x20 (640) -- 1638 entries does not
@ match standard tilemap geometries, so the 0x080100e4 renderer is
@ doing custom layout (probably stamping rectangles into screenblock
@ 28 from a non-screenblock-shaped source, like the screen_d8398
@ blitter at 0x000196ec).

        .section .rodata, "a", %progbits
        .balign  2

        .global  sBgTilemapVariantA_19C312
        .type    sBgTilemapVariantA_19C312, %object
        .size    sBgTilemapVariantA_19C312, 0xccc
sBgTilemapVariantA_19C312:
        .incbin "data/sprite/bg_tilemap_19c312/variant_a.bin"

        .global  sBgTilemapVariantB_19CFDE
        .type    sBgTilemapVariantB_19CFDE, %object
        .size    sBgTilemapVariantB_19CFDE, 0xccc
sBgTilemapVariantB_19CFDE:
        .incbin "data/sprite/bg_tilemap_19c312/variant_b.bin"
