@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024390, 0x0802a2f0)  (0x5f60 bytes)
@
@ Post-peel chunk after sub_08024328.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08024390
        .type   text_08024390, %object
text_08024390:
        .incbin "frog_us_baserom.gba", 0x00024390, 0x00005f60
        .size   text_08024390, . - text_08024390
