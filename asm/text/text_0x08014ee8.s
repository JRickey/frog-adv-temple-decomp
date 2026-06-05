@ Auto-emitted, then hand-shrunk for sub_0802BDBC callee peels.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08014ee8, 0x08015194)  (0x2AC bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08014ee8
        .type   text_08014ee8, %object
text_08014ee8:
        .incbin "frog_us_baserom.gba", 0x00014ee8, 0x000002AC
        .size   text_08014ee8, . - text_08014ee8
