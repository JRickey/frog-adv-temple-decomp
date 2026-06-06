@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d53c, 0x0802d548)  (0xc bytes)
@
@ Post-peel chunk after sub_0802D538.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d53c
        .type   text_0802d53c, %object
text_0802d53c:
        .incbin "frog_us_baserom.gba", 0x0002d53c, 0x0000000c
        .size   text_0802d53c, . - text_0802d53c
