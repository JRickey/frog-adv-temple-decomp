@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080228ac, 0x0802ab64)  (0x82b8 bytes)
@
@ Post-peel chunk after sub_08022884.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080228ac
        .type   text_080228ac, %object
text_080228ac:
        .incbin "frog_us_baserom.gba", 0x000228ac, 0x000082b8
        .size   text_080228ac, . - text_080228ac
