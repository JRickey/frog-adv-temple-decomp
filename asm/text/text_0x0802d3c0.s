@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d3c0, 0x0802d548)  (0x188 bytes)
@
@ Post-peel chunk after sub_0802D294.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d3c0
        .type   text_0802d3c0, %object
text_0802d3c0:
        .incbin "frog_us_baserom.gba", 0x0002d3c0, 0x00000188
        .size   text_0802d3c0, . - text_0802d3c0
