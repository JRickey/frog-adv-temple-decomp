@ 4bpp OBJ tile pixel data at 0x080e3ab6..0x080e7ab6 (0x4000 bytes).
@
@ Surfaced as 3-ref pool anchor by tools/agent/refcount_pool_loads.py.
@ All three consumer call-sites stage a DMA from 0x080e3ab6 to OBJ tile
@ VRAM (0x06000000 region) via REG_DMA3:
@
@   0x0800e0f2  src -> 0x06008000, cnt 0x80000200 (0x200 hwords = 0x400 B)
@   0x0800eb5c  src -> 0x06008000, cnt 0x80000200 (0x200 hwords = 0x400 B)
@   0x0800f19c  src -> 0x0600c000, cnt 0x80001000 (0x1000 hwords = 0x2000 B)
@
@ Sizing: the largest observed DMA is 0x2000 bytes (site 3), and the next
@ pool-load anchor in this region is 0x080e7ab6 at exactly +0x4000 bytes
@ later. Both 0x080e3ab6 and 0x080e7ab6 begin with a run of zero bytes
@ (typical 4bpp transparent-pixel padding) and the prior table
@ (sFrogStatusBarTileData at 0x080e3a30..0x080e3ab4) ends cleanly at the
@ boundary. The full asset is therefore 0x4000 bytes (512 4bpp 8x8 tiles,
@ enough for an OBJ character block); the smaller DMA sites at sites 1
@ and 2 only upload the first 0x400 bytes (32 tiles), while site 3
@ uploads half the asset (0x2000 / 256 tiles) to a different OBJ char
@ block. The remaining 0x2000 bytes are likely consumed via offset
@ arithmetic at routines still in asm.
@
@ Hand-written .s rather than a C file because 0x080e3ab6 is 2-byte
@ aligned but not 4-byte aligned, which trips the agbcc default
@ .rodata section alignment of 4. Emitting through `.balign 2` keeps
@ the linker from padding the upstream .text bucket up to a 4-byte
@ boundary. See docs/codegen-notes.md "Non-u32-aligned .rodata data
@ anchors".
@
@ TODO: rename once the consuming routines around [0x0800e0e0,
@   0x0800f1a0] land in C. The 4bpp tile data is plausibly a sprite
@   sheet for a single character; the 0x4000-byte block contains
@   enough tile capacity for full multi-pose animation.

        .section .rodata, "a", %progbits
        .balign  2

        .global  sFrogTilePixels_E3AB6
        .type    sFrogTilePixels_E3AB6, %object
        .size    sFrogTilePixels_E3AB6, 0x4000
sFrogTilePixels_E3AB6:
        .incbin "data/sprite/frog_tile_pixels_e3ab6.bin"
