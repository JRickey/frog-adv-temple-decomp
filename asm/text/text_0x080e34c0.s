@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080e34c0, 0x080e3550)  (0x90 bytes, intra-cluster gap zero padding)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_080e34c0
        .type   text_080e34c0, %object
text_080e34c0:
        .incbin "frog_us_baserom.gba", 0x000e34c0, 0x00000090
        .size   text_080e34c0, . - text_080e34c0
