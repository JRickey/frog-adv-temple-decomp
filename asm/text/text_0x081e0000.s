@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x081e0000, 0x081f0000)  (0x10000 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_081e0000
        .type   text_081e0000, %object
text_081e0000:
        .incbin "frog_us_baserom.gba", 0x001e0000, 0x00010000
        .size   text_081e0000, . - text_081e0000
