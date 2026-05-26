@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x083112c8, 0x08315a48)  (0x4780 bytes)
@
@ Mid-section of the original [0x08310000, 0x08320000) blob, sliced
@ between src/data/level_layout_dispatch_3112a8.c (preceding) and
@ src/data/level_layout_dispatch_315a48.c (following).
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_083112c8
        .type   text_083112c8, %object
text_083112c8:
        .incbin "frog_us_baserom.gba", 0x003112c8, 0x00004780
        .size   text_083112c8, . - text_083112c8
