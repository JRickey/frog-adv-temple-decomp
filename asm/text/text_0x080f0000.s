@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080f0000, 0x080f72c4)  (shrunk for screen_0800f014 cluster)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_080f0000
        .type   text_080f0000, %object
text_080f0000:
        .incbin "frog_us_baserom.gba", 0x000f0000, 0x000072c4
        .size   text_080f0000, . - text_080f0000
