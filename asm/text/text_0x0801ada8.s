@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801ada8, 0x0801b374)  (0x5cc bytes)
@
@ Post-peel chunk after sub_0801AD10.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801ada8
        .type   text_0801ada8, %object
text_0801ada8:
        .incbin "frog_us_baserom.gba", 0x0001ada8, 0x000005cc
        .size   text_0801ada8, . - text_0801ada8
