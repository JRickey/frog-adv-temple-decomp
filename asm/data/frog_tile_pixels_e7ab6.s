@ Sibling 4bpp OBJ tile block at 0x080e7ab6..0x080f0000 (0x854a bytes).
@
@ Surfaced as a 1-ref pool anchor by the iter-24 scout pass; structurally a
@ sibling of sFrogTilePixels_E3AB6 (the adjacent block at +0x4000 earlier
@ in ROM). Both blocks share the same head pattern (a run of zero bytes
@ for 4bpp transparent-pixel tiles) and both feed the same OBJ-tile VRAM
@ char block via DMA3.
@
@ Single consumer in code region: a screen-setup function entered at
@ 0x0801d880. The relevant DMA stage at 0x0801d954 is:
@
@   SAD = sFrogTilePixels_E7AB6   -> DAD = 0x06008020 (OBJ tile VRAM,
@                                     char block 2, +0x20 offset)
@   CNT = 0x80000340  (DMA_ENABLE | 0x340 halfwords = 0x680 bytes,
@                      = 52 4bpp 8x8 tiles)
@
@ The DMA only consumes the first 0x680 bytes; the remaining ~33 KiB of
@ tile bytes are accessed via offset arithmetic in routines still in
@ asm (the same shape as sFrogTilePixels_E3AB6, where the largest DMA
@ uploads 0x2000 B of an 0x4000 B asset). The block ends just shy of
@ 0x080f0000 with ~0xc68 bytes of zero padding before the next 64 KiB
@ bucket boundary; the full asset spans the entire former blob.
@
@ Hand-written .s rather than a C file because 0x080e7ab6 is 2-byte
@ aligned but not 4-byte aligned, which trips the agbcc default
@ .rodata section alignment of 4. Emitting through `.balign 2` keeps
@ the linker from padding the upstream .rodata bucket up to a 4-byte
@ boundary. See docs/codegen-notes.md "Non-u32-aligned .rodata data
@ anchors".
@
@ TODO: rename once the consuming routine at 0x0801d880 lands in C.
@ Plausibly a second character / pose tile bank (paired with the
@ E3AB6 frog tile bank by relative ROM position and matching DMA
@ pattern).

        .section .rodata, "a", %progbits
        .balign  2

        .global  sFrogTilePixels_E7AB6
        .type    sFrogTilePixels_E7AB6, %object
        .size    sFrogTilePixels_E7AB6, 0x854a
sFrogTilePixels_E7AB6:
        .incbin "data/sprite/frog_tile_pixels_e7ab6.bin"
