@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d534, 0x0802d548)  (0x14 bytes)
@
@ Post-peel chunk after sub_0802D524.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d534
        .type   text_0802d534, %object
text_0802d534:
        .incbin "frog_us_baserom.gba", 0x0002d534, 0x00000014
        .size   text_0802d534, . - text_0802d534
