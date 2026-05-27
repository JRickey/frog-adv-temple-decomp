@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802fa60, 0x08030000)  (0x5a0 bytes)
@
@ Post-peel chunk after sub_0802F9F0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802fa60
        .type   text_0802fa60, %object
text_0802fa60:
        .incbin "frog_us_baserom.gba", 0x0002fa60, 0x000005a0
        .size   text_0802fa60, . - text_0802fa60
