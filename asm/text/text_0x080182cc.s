@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080182cc, 0x0801932c)  (0x1060 bytes)
@
@ Post-peel chunk after sub_080181D0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080182cc
        .type   text_080182cc, %object
text_080182cc:
        .incbin "frog_us_baserom.gba", 0x000182cc, 0x00001060
        .size   text_080182cc, . - text_080182cc
