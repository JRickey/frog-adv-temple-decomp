@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08312d60, 0x08314a68)  (0x1d08 bytes)
@
@ Mid-section of the original [0x08310000, 0x08320000) blob, sliced
@ between src/data/level_layout_312c20.c (preceding) and
@ src/data/level_layout_ptrs_314a68.c (following).
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_08312d60
        .type   text_08312d60, %object
text_08312d60:
        .incbin "frog_us_baserom.gba", 0x00312d60, 0x00001d08
        .size   text_08312d60, . - text_08312d60
