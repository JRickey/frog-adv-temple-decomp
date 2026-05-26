@ Tail of the blob that previously ran [0x080e3ab4, 0x080f0000) before
@ the sFrogTilePixels_E3AB6 extraction.
@
@ Begins at 0x080e7ab6, the next pool-load anchor after the extracted
@ tile block. That anchor is itself a 1-ref 4bpp tile block consumed by
@ a single DMA at 0x0801d954 (src -> 0x06008020, cnt 0x340 hwords =
@ 0x680 bytes), and is structurally a sibling of sFrogTilePixels_E3AB6.
@ Left in asm pending a future extraction pass.
@
@ Range:  [0x080e7ab6, 0x080f0000)  (0x854a bytes)
@
@ Lowered to .balign 1 because the start address is halfword-aligned
@ but not word-aligned. See docs/codegen-notes.md "Non-u32-aligned
@ .rodata data anchors".
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_080e7ab6
        .type   text_080e7ab6, %object
text_080e7ab6:
        .incbin "frog_us_baserom.gba", 0x000e7ab6, 0x0000854a
        .size   text_080e7ab6, . - text_080e7ab6
