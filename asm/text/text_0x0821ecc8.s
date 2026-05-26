@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Tail bucket after src/data/sprite_tiles_219cc8.c.
@ Range:  [0x0821ecc8, 0x08220000)  (0x1338 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_0821ecc8
        .type   text_0821ecc8, %object
text_0821ecc8:
        .incbin "frog_us_baserom.gba", 0x0021ecc8, 0x00001338
        .size   text_0821ecc8, . - text_0821ecc8
