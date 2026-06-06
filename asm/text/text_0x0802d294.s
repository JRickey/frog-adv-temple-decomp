@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d294, 0x0802d548)  (0x2b4 bytes)
@
@ Post-peel chunk after sub_0802D170.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d294
        .type   text_0802d294, %object
text_0802d294:
        .incbin "frog_us_baserom.gba", 0x0002d294, 0x000002b4
        .size   text_0802d294, . - text_0802d294
