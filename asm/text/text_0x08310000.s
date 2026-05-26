@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08310000, 0x08310eb4)  (0xeb4 bytes)
@
@ Pre-anchor head of the original [0x08310000, 0x08320000) blob, sliced
@ to make room for src/data/level_layout_dispatch_3112a8.c at
@ 0x083112a8..0x083112c8 and src/data/level_layout_310eb4.c at
@ 0x08310eb4..0x083112a8.
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_08310000
        .type   text_08310000, %object
text_08310000:
        .incbin "frog_us_baserom.gba", 0x00310000, 0x00000eb4
        .size   text_08310000, . - text_08310000
