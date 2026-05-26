@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08315bb0, 0x08316dc8)  (0x1218 bytes)
@
@ Mid-section of the original [0x08310000, 0x08320000) blob, sliced
@ between src/data/level_layout_dispatch_315a48.c (preceding) and
@ src/data/level_layout_dispatch_316dc8.c (following).
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_08315bb0
        .type   text_08315bb0, %object
text_08315bb0:
        .incbin "frog_us_baserom.gba", 0x00315bb0, 0x00001218
        .size   text_08315bb0, . - text_08315bb0
