@ Auto-updated after peel of sub_0802782C.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080278dc, 0x0802a2f0)  (0x2a14 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080278dc
        .type   text_080278dc, %object
text_080278dc:
        .incbin "frog_us_baserom.gba", 0x000278dc, 0x00002a14
        .size   text_080278dc, . - text_080278dc
