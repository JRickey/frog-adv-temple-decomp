@ Paired BG screen-install assets at 0x081a3b6a..0x081a636a (0x2800 bytes).
@
@ Two ROM anchors surfaced as siblings by the iter-22 scout pass and
@ confirmed adjacent by the pool-load scan (both consumed in the same
@ DMA-staging routine at 0x080152ec):
@
@   0x081a3b6a - 0x081a5b6a   (0x2000 B / 8 KiB)   char-tile data
@   0x081a5b6a - 0x081a636a   (0x0800 B / 2 KiB)   BG tilemap (screenblock)
@
@ Consumer pattern (function starts at 0x080152ec, dispatcher case):
@
@   1. SAD = sScreenCharTiles_1A3B6A  -> DAD = 0x0600C000 (VRAM char block 3)
@      CNT = 0x80001000   (DMA_ENABLE | 0x1000 halfwords = 8192 B; full block)
@   2. SAD = sScreenTilemap_1A5B6A    -> DAD = 0x0600F000 (BG screenblock 30)
@      CNT = 0x80000400   (DMA_ENABLE | 0x400 halfwords = 2048 B; full block)
@
@ Each DMA stage matches its block size exactly: this pair is a complete
@ screen install, no overflow tiles or partial uploads. Both blocks have
@ a zero-padded head (typical 4bpp transparent and BG-tilemap zero-tile
@ leading runs).
@
@ The pair sits inside a larger dispatcher function (case-jump table at
@ 0x080152c0 entered via `mov pc, rN`); the matching case body for the
@ screen tilemap install is at 0x080152ec..0x08015320, with later cases
@ in the same function loading other screen assets (palettes / char
@ banks) via the same DMA template.
@
@ Hand-written .s rather than a C file because 0x081a3b6a is 2-byte
@ aligned but not 4-byte aligned, which trips the agbcc default
@ .rodata section alignment of 4. Emitting through `.balign 2` keeps
@ the linker from padding the upstream .text bucket up to a 4-byte
@ boundary. See docs/codegen-notes.md "Non-u32-aligned .rodata data
@ anchors".
@
@ TODO: rename once the consuming dispatcher at 0x080152ec lands in C.
@ Likely a fixed-screen install (title / pause / world-select) given
@ the full-screenblock + full-char-block sizing.

        .section .rodata, "a", %progbits
        .balign  2

        .global  sScreenCharTiles_1A3B6A
        .type    sScreenCharTiles_1A3B6A, %object
        .size    sScreenCharTiles_1A3B6A, 0x2000
sScreenCharTiles_1A3B6A:
        .incbin "data/sprite/screen_1a3b6a/char_tiles.bin"

        .global  sScreenTilemap_1A5B6A
        .type    sScreenTilemap_1A5B6A, %object
        .size    sScreenTilemap_1A5B6A, 0x800
sScreenTilemap_1A5B6A:
        .incbin "data/sprite/screen_1a3b6a/tilemap.bin"
