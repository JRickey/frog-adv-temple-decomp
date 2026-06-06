@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d504, 0x0802d548)  (0x44 bytes)
@
@ Post-peel chunk after sub_0802D4F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d504
        .type   text_0802d504, %object
text_0802d504:
        .incbin "frog_us_baserom.gba", 0x0002d504, 0x00000044
        .size   text_0802d504, . - text_0802d504
