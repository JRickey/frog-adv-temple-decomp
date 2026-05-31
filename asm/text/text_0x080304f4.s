@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080304f4, 0x080315d8)  (0x10e4 bytes)
@
@ Post-peel chunk after sub_0803045C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080304f4
        .type   text_080304f4, %object
text_080304f4:
        .incbin "frog_us_baserom.gba", 0x000304f4, 0x000010e4
        .size   text_080304f4, . - text_080304f4
