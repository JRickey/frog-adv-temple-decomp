@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022980, 0x0802ab64)  (0x81e4 bytes)
@
@ Post-peel chunk after sub_08022958.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022980
        .type   text_08022980, %object
text_08022980:
        .incbin "frog_us_baserom.gba", 0x00022980, 0x000081e4
        .size   text_08022980, . - text_08022980
