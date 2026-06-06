@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d54c, 0x0802d554)  (0x8 bytes)
@
@ Post-peel chunk after sub_0802D548.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d54c
        .type   text_0802d54c, %object
text_0802d54c:
        .incbin "frog_us_baserom.gba", 0x0002d54c, 0x00000008
        .size   text_0802d54c, . - text_0802d54c
