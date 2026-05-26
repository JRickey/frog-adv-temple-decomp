@ Two-byte head of the blob that previously ran [0x080e3ab4, 0x080f0000).
@ The 4bpp tile pixel block sFrogTilePixels_E3AB6 (0x4000 B at
@ 0x080e3ab6..0x080e7ab6) has been extracted to
@ asm/data/frog_tile_pixels_e3ab6.s; the tail [0x080e7ab6, 0x080f0000)
@ is held in asm/text/text_0x080e7ab6.s.
@
@ Range:  [0x080e3ab4, 0x080e3ab6)  (2 bytes - halfword pad)
@
@ Lowered to .balign 1 because the next section
@ (sFrogTilePixels_E3AB6) is halfword-aligned but not word-aligned;
@ retaining .align 2 would pad this 2-byte head up to 4 bytes and
@ shift the next anchor off 0x080e3ab6. See docs/codegen-notes.md
@ "Non-u32-aligned .rodata data anchors".
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_080e3ab4
        .type   text_080e3ab4, %object
text_080e3ab4:
        .incbin "frog_us_baserom.gba", 0x000e3ab4, 0x00000002
        .size   text_080e3ab4, . - text_080e3ab4
