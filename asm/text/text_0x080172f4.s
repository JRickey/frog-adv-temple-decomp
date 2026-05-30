@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080172f4, 0x08017364)  (0x70 bytes)
@
@ Post-peel chunk after sub_08017000.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080172f4
        .type   text_080172f4, %object
text_080172f4:
        .incbin "frog_us_baserom.gba", 0x000172f4, 0x00000070
        .size   text_080172f4, . - text_080172f4
