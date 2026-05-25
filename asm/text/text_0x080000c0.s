@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080000c0, 0x08010000)  (0xff40 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_080000c0
        .type   text_080000c0, %object
text_080000c0:
        .incbin "frog_us_baserom.gba", 0x000000c0, 0x0000ff40
        .size   text_080000c0, . - text_080000c0
