@ Paired BG screen-install assets at 0x081b23ca..0x081b4bca (0x2800 bytes).
@
@ Two ROM anchors surfaced by refcount_pool_loads.py and confirmed as a
@ matched char-tile + tilemap pair by the case-3 body of the screen
@ dispatcher at 0x080152c0:
@
@   0x081b23ca - 0x081b43ca   (0x2000 B / 8 KiB)   4bpp char-tile data
@   0x081b43ca - 0x081b4bca   (0x0800 B / 2 KiB)   BG tilemap (screenblock)
@
@ Consumer pattern (case 3 of dispatcher at 0x080152c0, body at 0x0801536c):
@
@   1. SAD = sScreenTilemap_1B43CA    -> DAD = 0x0600F000 (BG screenblock 30)
@      CNT = 0x80000400   (DMA_ENABLE | 0x400 halfwords = 2048 B; full block)
@   2. SAD = sScreenCharTiles_1B23CA  -> DAD = 0x0600C000 (VRAM char block)
@      CNT = 0x80001000   (DMA_ENABLE | 0x1000 halfwords = 8192 B; full block)
@   3. REG_BLDCNT  = 0x1744   (BG2/BG3 source, BG2/OBJ target, alpha)
@   4. REG_BLDALPHA = 0x0c04
@   5. [0x0300658a] = 0      (clear state byte)
@
@ Sibling pattern to:
@   - screen_1a3b6a (case 2 of the same dispatcher at 0x080152ec):
@     same 8 KiB + 2 KiB shape, same DMA template.
@   - screen_c578, screen_d8398, screen_d8b98, screen_188edc:
@     other variants discovered in iter-18/23/24/27.
@
@ The trailing 0x16e0 bytes between the tilemap end (0x081b4bca) and the
@ next refcount-anchored block (0x081b62aa) carry structured 4bpp tile +
@ small-palette-shaped data not referenced by any pool load in the scanned
@ code region. Hypothesis: extra tiles or supplementary palette consumed
@ by a not-yet-decompiled helper. Kept as a sibling INCBIN
@ `sScreenExtraData_1B4BCA` so the cluster ships as one .o.
@
@ Hand-written .s rather than a C file because 0x081b23ca / 0x081b43ca /
@ 0x081b4bca are all 2-byte aligned but not 4-byte aligned, which trips
@ the agbcc default .rodata section alignment of 4. See
@ docs/codegen-notes.md "Non-u32-aligned .rodata data anchors".
@
@ TODO: rename once the consuming dispatcher at 0x080152c0 lands in C.
@ Likely a fixed-screen install (title / pause / world-select etc.)
@ given the full-screenblock + full-char-block sizing.

        .section .rodata, "a", %progbits
        .balign  2

        .global  sScreenCharTiles_1B23CA
        .type    sScreenCharTiles_1B23CA, %object
        .size    sScreenCharTiles_1B23CA, 0x2000
sScreenCharTiles_1B23CA:
        .incbin "data/sprite/screen_1b23ca/char_tiles.bin"

        .global  sScreenTilemap_1B43CA
        .type    sScreenTilemap_1B43CA, %object
        .size    sScreenTilemap_1B43CA, 0x800
sScreenTilemap_1B43CA:
        .incbin "data/sprite/screen_1b23ca/tilemap.bin"

        .global  sScreenExtraData_1B4BCA
        .type    sScreenExtraData_1B4BCA, %object
        .size    sScreenExtraData_1B4BCA, 0x16e0
sScreenExtraData_1B4BCA:
        .incbin "data/sprite/screen_1b23ca/post_tilemap_pad.bin"
