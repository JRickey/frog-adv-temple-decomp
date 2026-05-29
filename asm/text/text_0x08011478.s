@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08011478, 0x0801185c)  (0x3e4 bytes)
@
@ Post-peel chunk after sub_080113E8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08011478
        .type   text_08011478, %object
text_08011478:
        .incbin "frog_us_baserom.gba", 0x00011478, 0x000003e4
        .size   text_08011478, . - text_08011478
