@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08033de0, 0x08033e14)  (0x34 bytes)
@
@ Post-peel chunk after sub_08033DA8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08033de0
        .type   text_08033de0, %object
text_08033de0:
        .incbin "frog_us_baserom.gba", 0x00033de0, 0x00000034
        .size   text_08033de0, . - text_08033de0
