@ Auto-emitted by peel at 0x08025d84.
@ Shrunk for sub_08025DAC peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025dd0, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025dd0
        .type   text_08025dd0, %object
text_08025dd0:
        .incbin "frog_us_baserom.gba", 0x0025dd0, 0x004520
        .size   text_08025dd0, . - text_08025dd0
