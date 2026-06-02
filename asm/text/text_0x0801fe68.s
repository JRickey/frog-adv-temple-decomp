@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801fe68, 0x08020000)  (0x198 bytes)
@
@ Post-peel chunk after sub_0801FD0C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801fe68
        .type   text_0801fe68, %object
text_0801fe68:
        .incbin "frog_us_baserom.gba", 0x0001fe68, 0x00000198
        .size   text_0801fe68, . - text_0801fe68
