@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x082c0000, 0x082d0000)  (0x10000 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_082c0000
        .type   text_082c0000, %object
text_082c0000:
        .incbin "frog_us_baserom.gba", 0x002c0000, 0x00010000
        .size   text_082c0000, . - text_082c0000
