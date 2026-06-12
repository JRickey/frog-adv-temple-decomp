@ Auto-emitted by peel at 0x08025d84.
@ Shrunk for sub_08025D84 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025dac, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025dac
        .type   text_08025dac, %object
text_08025dac:
        .incbin "frog_us_baserom.gba", 0x0025dac, 0x004544
        .size   text_08025dac, . - text_08025dac
